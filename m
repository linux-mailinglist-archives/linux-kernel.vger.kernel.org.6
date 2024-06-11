Return-Path: <linux-kernel+bounces-210471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C7F90440A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 20:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C756281833
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2BB770FB;
	Tue, 11 Jun 2024 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="No3kRxxr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C5774413
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 18:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718131894; cv=none; b=E2rj34TzvoC8i8vqa/qJbN1T69cMkXk+1jnTgAeqPrHDQY50jT1evSroi0ypkALJCsbmASPDaf7NX3LDYRWc4VTKHbRzeTnUbCTHF3V6E7AKPSrIo6ndp+/XzIOMpcHJwfAypyiump0DspMeEWWhUJ1Kqry6UW/9ie35JegRiKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718131894; c=relaxed/simple;
	bh=CRVb1cscuZGU+C1mehva/5GiW5SQN/xPGb0k2ueosro=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qmDUY2nrUJbvpzN+NmnZqQXmJXWqWbhexsirb2Wa0rfMS3MVOzdoK2YBowD1WbkE6A5YuhV1c1UjtJOjo+ZR7UozQcKsoWMGSjJzFRG/ONqcRdA2h0VJOU/lQwW5ykyTYUVuv2g45DBuiWFTC9QgIcJ+pDcLhqcCnr+Av21I/F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=No3kRxxr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B23C2BD10;
	Tue, 11 Jun 2024 18:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718131894;
	bh=CRVb1cscuZGU+C1mehva/5GiW5SQN/xPGb0k2ueosro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=No3kRxxrNI0tTN0hPHgb/qxTHnxbq6INdnv4nz+JcBDk8PonK+GgqFx0YJ9UCff+3
	 FQD4vr6bFA6VYKMCNo5JXutRLplrBc31hjbITTAB6nXhlbhvdObeQP13xEIkU55cdj
	 Nn6A5gISENMjTCb5fRXyIbii7stdAOiOpJhupUqY=
Date: Tue, 11 Jun 2024 11:51:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Aleksandr Nogikh <nogikh@google.com>
Cc: dvyukov@google.com, andreyknvl@gmail.com, arnd@arndb.de,
 elver@google.com, glider@google.com, syzkaller@googlegroups.com,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcov: don't lose track of remote references during
 softirqs
Message-Id: <20240611115133.fa80466e924ad34ed4ad73cb@linux-foundation.org>
In-Reply-To: <20240611133229.527822-1-nogikh@google.com>
References: <20240611133229.527822-1-nogikh@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 15:32:29 +0200 Aleksandr Nogikh <nogikh@google.com> wrote:

> In kcov_remote_start()/kcov_remote_stop(), we swap the previous KCOV
> metadata of the current task into a per-CPU variable. However, the
> kcov_mode_enabled(mode) check is not sufficient in the case of remote
> KCOV coverage: current->kcov_mode always remains KCOV_MODE_DISABLED
> for remote KCOV objects.
> 
> If the original task that has invoked the KCOV_REMOTE_ENABLE ioctl
> happens to get interrupted and kcov_remote_start() is called, it
> ultimately leads to kcov_remote_stop() NOT restoring the original
> KCOV reference. So when the task exits, all registered remote KCOV
> handles remain active forever.
> 
> Fix it by introducing a special kcov_mode that is assigned to the
> task that owns a KCOV remote object. It makes kcov_mode_enabled()
> return true and yet does not trigger coverage collection in
> __sanitizer_cov_trace_pc() and write_comp_data().

What are the userspace visible effects of this bug?  I *think* it's
just an efficiency thing, but how significant?  In other words, should
we backport this fix?



