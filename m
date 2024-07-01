Return-Path: <linux-kernel+bounces-236400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D3591E1C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 16:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA301F2268B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16A88153BE2;
	Mon,  1 Jul 2024 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCt6KPfE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA9A3D72
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719842491; cv=none; b=fmUDk0htoUY9X8BG6zeYuEAWj8m5wrjtU+M7FrDjVf8Lm+QbPyOVwf6RrcGAF8cJ4fCQcUqLOgUb2OGEY5xAoyUYk65MILMv1SSsUJmAT8Xe4i8jSLjXAhrLSfu/aAlbsB5MpNwrCo9/ZtABJhSBFTKy8nwQJCfXlJsA+5iKUIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719842491; c=relaxed/simple;
	bh=OCCNiYkig3OpItCurKgzHYtMokBXxh1cSb7XVgOm6D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKWB0k6GLIg6EjNTC62QZGl2gW3+YgpXt1uJDGHfXICfbrSpONKbJ3hFc3NLm+TQuYXEDJ9g4QX2mIKBuT72KybPccqEV4rOiCe/Zbt/NrQP58wB9yowoS0UuBY6BTY0YCM87QqNoZ+qpNw/psM0BwjL/Kyf0FFsEUd349D6ik8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCt6KPfE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57C9C116B1;
	Mon,  1 Jul 2024 14:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719842490;
	bh=OCCNiYkig3OpItCurKgzHYtMokBXxh1cSb7XVgOm6D4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=DCt6KPfEC4wrzpjthvJpI1iicVsXHkoMkr40lfVEGqSnM4UbdnDA8HVNf++TfS1yW
	 Sp7Nfyo/g3c8GG9JDQYzpt/EDy9Px4A2gTJUJ8FhsC1YSKBsgtVTQ61sKKZqA3/PWd
	 tH3i4ugNwGSXuEa93UFGCeW2Wa7k3YkJvNK7Wfbojr/3xQEX+jlYIUs7pFuwZLsK9F
	 TTkn3lykqO3mJ2c/ll6a3WTsXSPS8TXyCCRgZnTrIyu3HbVnWr9x1M1ffX+Qv6iYIS
	 PdbOfmkqG087Fd6gvoYQ1Y9Bkl3n7JJRU2cYIFHRsW4YJZ3jubJeKzHp1dnjgtxRxP
	 P1/7kVb1yc0xA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 88A74CE0AD3; Mon,  1 Jul 2024 07:01:30 -0700 (PDT)
Date: Mon, 1 Jul 2024 07:01:30 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Marco Elver <elver@google.com>
Cc: Thorsten Blum <thorsten.blum@toblux.com>, dvyukov@google.com,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	David.Laight@aculab.com
Subject: Re: [PATCH v3] kcsan: Use min() to fix Coccinelle warning
Message-ID: <b96317e1-2aa6-4e04-bd9e-6fb2ce49c417@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240630200135.224108-1-thorsten.blum@toblux.com>
 <CANpmjNMXOn_N=9CY2iGLC=r=FAP4J2EFJbwDsAEuhKydwh6wtg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMXOn_N=9CY2iGLC=r=FAP4J2EFJbwDsAEuhKydwh6wtg@mail.gmail.com>

On Mon, Jul 01, 2024 at 10:07:29AM +0200, Marco Elver wrote:
> On Sun, 30 Jun 2024 at 22:03, Thorsten Blum <thorsten.blum@toblux.com> wrote:
> >
> > Fixes the following Coccinelle/coccicheck warning reported by
> > minmax.cocci:
> >
> >   WARNING opportunity for min()
> >
> > Use size_t instead of int for the result of min().
> >
> > Compile-tested with CONFIG_KCSAN=y.
> >
> > Reviewed-by: Marco Elver <elver@google.com>
> > Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> > ---
> > Changes in v2:
> > - Add const and remove redundant parentheses as suggested by Marco Elver
> > - Link to v1: https://lore.kernel.org/linux-kernel/20240623220606.134718-2-thorsten.blum@toblux.com/
> >
> > Changes in v3:
> > - Remove const again after feedback from David Laight
> 
> I think I was clear that the removal of const was not needed in this
> case, and my preference was to keep const.
> 
> While general and _constructive_ comments are helpful and appreciated,
> this level of nit-picking and bikeshedding about 'const' is a complete
> and utter waste of time. I'm sorry, but I'm rather allergic to this
> level of time-wasting.
> 
> As KCSAN maintainer, I'm just going to say I prefer v2.
> 
> > - Link to v2: https://lore.kernel.org/linux-kernel/20240624175727.88012-2-thorsten.blum@toblux.com/
> 
> [+Cc Paul]
> 
> Paul, if possible kindly pick v2 of this patch into the KCSAN tree:
> https://lore.kernel.org/linux-kernel/20240624175727.88012-2-thorsten.blum@toblux.com/

I have queued v2 of this patch, which is as shown below.  Please let me
know if anything needs adjustment.  If things go well, this should make
the upcoming merge window.

							Thanx, Paul

------------------------------------------------------------------------

commit 613b072fe9b3aa11410937498c98b7ac6d7c9d5a
Author: Thorsten Blum <thorsten.blum@toblux.com>
Date:   Mon Jun 24 19:57:28 2024 +0200

    kcsan: Use min() to fix Coccinelle warning
    
    Fixes the following Coccinelle/coccicheck warning reported by
    minmax.cocci:
    
            WARNING opportunity for min()
    
    Use const size_t instead of int for the result of min().
    
    Compile-tested with CONFIG_KCSAN=y.
    
    Reviewed-by: Marco Elver <elver@google.com>
    Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/kcsan/debugfs.c b/kernel/kcsan/debugfs.c
index 1d1d1b0e4248..53b21ae30e00 100644
--- a/kernel/kcsan/debugfs.c
+++ b/kernel/kcsan/debugfs.c
@@ -225,7 +225,7 @@ debugfs_write(struct file *file, const char __user *buf, size_t count, loff_t *o
 {
 	char kbuf[KSYM_NAME_LEN];
 	char *arg;
-	int read_len = count < (sizeof(kbuf) - 1) ? count : (sizeof(kbuf) - 1);
+	const size_t read_len = min(count, sizeof(kbuf) - 1);
 
 	if (copy_from_user(kbuf, buf, read_len))
 		return -EFAULT;

