Return-Path: <linux-kernel+bounces-244709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE7092A838
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B3E21F21C76
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8FBB148FE4;
	Mon,  8 Jul 2024 17:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="wrHC8FpA"
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C225C1487F6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 17:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720459911; cv=none; b=BEi3uYW8NFvLGimLUjlmN7wsTR/zbcpZ2Yv6u2L8o0yYdp/tznMxQuMzf9ot8tNe+0Vo3TYAliRnOKNepGRenb4RWqcrtPLtNOO7Q5q9c0AEJzDQ3bKMQUpaZojoBpWSeJQ/hZ9Wy0uneKZKVKRWek1qQUOXTidY5nGuTqM5VRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720459911; c=relaxed/simple;
	bh=lJ2932qDkC0LYg+crodmOu1OYYAGfPXir2mvX7XuYlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmbhFvRxmo/SFLv12iwAvr7vSd5LbW8+wKw7L87hdML2agVrYNQXCPQES0ws7Uj2/4HnPkDw/FCNT+XoU27V2J5OpCnL09ZWB7HFnqUT0GaRSKRoQzXxvmdQXQC6FK+P9R/4s03eykvYk/yBDODi2tmZBnfYm1rd7HRZdYw+50M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=wrHC8FpA; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4WHrlH2nGgz7CV;
	Mon,  8 Jul 2024 19:31:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1720459899;
	bh=mQnW5NCn1TmU2xbMOO/R79KgJurHxMXyQn21myAso+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wrHC8FpAa0Nrl6MDhZVLEh2IeCdDaKszP59Loyn9h+Zj4ecIdUMCDDZKe7nSZkOwP
	 uzWsImMOqfvVuCwR+BC6UzTKJmdW3P8jRIgpiH2ZG68a9aMTMVELy+D/AFwLi4zKW1
	 hotUiwgj3pzOluGti7Y3vY2hLM6TYdSwJLXo5s3g=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4WHrlG41Ygz3C2;
	Mon,  8 Jul 2024 19:31:38 +0200 (CEST)
Date: Mon, 8 Jul 2024 19:31:35 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tahera Fahimi <fahimitahera@gmail.com>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Jann Horn <jannh@google.com>, outreachy@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH 0/2] Landlock: Add abstract unix socket connect
 reastriction
Message-ID: <20240708.nujahgh6Zeec@digikod.net>
References: <cover.1720203255.git.fahimitahera@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1720203255.git.fahimitahera@gmail.com>
X-Infomaniak-Routing: alpha

Please send inline patches, and don't forget to set the patch series
version.  Because the difference with the previous series is only about
formatting, I'l only review the previous one.

On Fri, Jul 05, 2024 at 12:58:10PM -0600, Tahera Fahimi wrote:
> This patch series introduces the optional scoping of abstract unix
> sockets. This feature aims to scope the connection of an abstract socket
> from a sandbox process to other sockets outside of the sandbox domain.
> (see [1, 2])
> 
> The following changes are included in this series:
>   [PATCH 1/2]: Introduce the "scoped" field to the ruleset structure in
>                the user space interface, and add the restriction
>                mechanism to Landlock.
>   [PATCH 2/2]: Add three comprehensive tests for the new feature.
> 
> Tahera Fahimi (2):
>   Landlock: Add abstract unix socket connect restriction
>   Landlock: Abstract unix socket restriction tests
> 
>  include/uapi/linux/landlock.h                 |  29 +
>  security/landlock/limits.h                    |   3 +
>  security/landlock/ruleset.c                   |   7 +-
>  security/landlock/ruleset.h                   |  23 +-
>  security/landlock/syscalls.c                  |  12 +-
>  security/landlock/task.c                      |  62 ++
>  .../testing/selftests/landlock/ptrace_test.c  | 786 ++++++++++++++++++
>  7 files changed, 916 insertions(+), 6 deletions(-)
> 
> [1]: https://lore.kernel.org/all/20231023.ahphah4Wii4v@digikod.net/
> [2]: https://lore.kernel.org/all/20231102.MaeWaepav8nu@digikod.net/
> -- 
> 2.34.1
> 




