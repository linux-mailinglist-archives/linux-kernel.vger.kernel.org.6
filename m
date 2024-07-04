Return-Path: <linux-kernel+bounces-240482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE33926E32
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 05:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE9F11C21583
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 03:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ACF1BC2F;
	Thu,  4 Jul 2024 03:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ovkkWHOJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E3B171A7
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 03:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720065256; cv=none; b=lMIFiAgqW5qTq1xLFJzb4F7crFHzW8A8ae/FANC8SafEvN7IfeCN5kMURKl7RdSIhwZnuVoU8Ivi3kUgejmRG1vT6+XOrQaTXo1ZGk8vE3j1V7wUwu+UvXZYJwympuOwQstLAXHecWczlYT8ZmCxSMW0tyU+65iUGi1vqrF0F7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720065256; c=relaxed/simple;
	bh=sinPs2WortomVC/or3SQauASGpdHBJMjbsFLIxc/1eM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OPSrfksELAgwWKJmqXvzvQ1oD9r88A1q4fpL185Rv4JdjvRHhl7LMdlJ+7wbuuxYWyvhC79wUv7Dyp5jOGZ/CWNA35dHag2xjXS2FU1Ti2ICXfgi1kehD7yibf5FhWi6Lb3V3TTOE3jvVr/ifUCCVM+PaiBvhyUuINeZrOwy3Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ovkkWHOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED8CAC3277B;
	Thu,  4 Jul 2024 03:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1720065256;
	bh=sinPs2WortomVC/or3SQauASGpdHBJMjbsFLIxc/1eM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ovkkWHOJpJX1yOAVUdTsCT+yI2wssomX/+egM3dqhA7zE3M+2Gb9Z4YEyk58c/ILr
	 tXhRCMFlSsZLr9afkzkZ/7GgcMQiVUTN29LXRMhTyngKF7f6syhdOdhr4a2rWG6mhv
	 QbwRhp9PzXbXTA4jO76FUV+gHgOFagywdbnvaj4M=
Date: Wed, 3 Jul 2024 20:54:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, kent.overstreet@linux.dev,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 1/1] sched.h: always_inline alloc_tag_{save|restore} to
 fix modpost warnings
Message-Id: <20240703205415.de49467352601290c9fb27e8@linux-foundation.org>
In-Reply-To: <CAJuCfpEJkCN1XDDE+2B4ePoFKbvSCaUA8=RO1TTg23XV56mRZg@mail.gmail.com>
References: <20240703221520.4108464-1-surenb@google.com>
	<20240703155129.cbd023c14dee61e5727bb750@linux-foundation.org>
	<CAJuCfpFGRmQXxkaUjasyVGu74su_a-319o5zYe_eJD_KfbmNdg@mail.gmail.com>
	<CAJuCfpGA5Jy0NmO6oT0Y-KQSPvjj-=pDsM9AiT0vSUUGAM96OA@mail.gmail.com>
	<CAJuCfpEJkCN1XDDE+2B4ePoFKbvSCaUA8=RO1TTg23XV56mRZg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 20:46:11 -0700 Suren Baghdasaryan <surenb@google.com> wrote:

> Ok, I confirmed that the warning is happening due to the access to
> "current" from alloc_tag_save()/alloc_tag_restore() functions. I guess
> when these functions access "thread_info" variable:
> https://elixir.bootlin.com/linux/v6.10-rc6/source/arch/xtensa/include/asm/thread_info.h#L96,
> compiler flags that because the variable is on the stack of an __init
> function while alloc_tag_save()/alloc_tag_restore() when not inlined
> are from .text section.

Well, is the warning legitimate?  I don't see why an automatic variable
of an __init function should be considered to be .init storage - we can
assume it won't become an invalid reference while the .init function is
executing?


