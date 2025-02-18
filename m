Return-Path: <linux-kernel+bounces-519291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C360EA39B18
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 12:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EA0D7A1FD2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 11:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFA323C8BC;
	Tue, 18 Feb 2025 11:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="PJFkzvwc"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93875238D25
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739878620; cv=none; b=T69/LPLAE2EUYYxD3mvVI2C9l051rirYk7DI46nN/zaBXEX9aFaMD56LZ3TjahKQSBn0LcMEAYI2YQaL8wLbC8i7anXAJFgkqgv3e8DKV6FsH0lBX3SAAmiQAQQo0wSQiOoQgUorHdsR8o4O37rbHiINBwUP8KhWJ3eMOluKMCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739878620; c=relaxed/simple;
	bh=zbCiU9Ae4FzHrM4w/GC4ChZbQpszLPXwmWbje8AgkMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AQIK8Bm7dK+NVgpK0EPB4hps/DjBOfbM1kt/qjWuApq2arz7GGCAVrivjvEy3w/99XZkZdknNclRQTkbgNWC7EQzDljspwhx+biiUjZ/cWR+RX72VO/kdlEbNDKP548BlwUdXKHF4cPXXQ1NjJegZ47C2vjvuCzVLDm30ITFRaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=PJFkzvwc; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A3B7340E020E;
	Tue, 18 Feb 2025 11:36:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id krXcJ8Zp-lUt; Tue, 18 Feb 2025 11:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1739878610; bh=7LVGqdCM1nGr83QwOVulbhapn9Q1bwYRVVa/tyMpSMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJFkzvwcSbbzUJpMNXgeITMRMXGJxXLsdaTnPwqqQ/WxEh7uEYEPKM0d2jwAezlxo
	 zbECcXfLRqypx0Ozm/4mDlN9GRRUIalXqs217d1/9pbpOeeRlfNkZCvNilQCA2LVfq
	 48vJDuwSwYercp2b3h/TsHSr6wDquGHFgkLm+MQbnhPy0etz9tK6bEbEsDHOeOQliO
	 AKQZbAuKEJmoDxKWagqPB5E7l92Fujrvah4lq4yOTr31fr6oZA75hLFUXRMqdNWnP5
	 38QmbMPb+uYpBXVAtQgEvMRGHYZfvIx1OYmvqqZiJb8DZPAv2ie/dZFHxVWswjo+RA
	 HqMADEhSG5Pi9H4DoXD9zsJsXzedGAI8wgBwXuXibvcuddILpkEi1686QJVE4WgFPj
	 loUV3DlQ7ssjtdUzWXr0lZsl3/J2ELDf48I3aaGDmcNTd4Yra8wyCmIvlgsIcEhiBq
	 qQwmN8o9PT0d51wh1Si/Tuqx6086SfM1HieYGw+7lcSZ/AR/i3IQIerO6xay1Z9CW8
	 zLkcQQ5P+CSl7IYL6c965iZDnMvL2JYevFF+SetutrhGIwe4XpFj86YQuQuPlPFHxL
	 pvAxMuRBGZctxZi9Cackym0e00QxqgN5MOZmMGxWjczvjAgYlTxULhkVHTnPPg4Z9B
	 8C1Cu5utXIHlL0rG+tuAQGn4=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8CC6D40E0192;
	Tue, 18 Feb 2025 11:36:44 +0000 (UTC)
Date: Tue, 18 Feb 2025 12:36:34 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, dave.hansen@linux.intel.com
Subject: Re: [PATCH 1/6] x86/microcode: Introduce staging option to reduce
 late-loading latency
Message-ID: <20250218113634.GGZ7RwwkrrXADX0eRo@fat_crate.local>
References: <20241001161042.465584-1-chang.seok.bae@intel.com>
 <20241211014213.3671-1-chang.seok.bae@intel.com>
 <20241211014213.3671-2-chang.seok.bae@intel.com>
 <20250217133348.GJZ7M6vFdZtXDd0lF0@fat_crate.local>
 <b88227ad-f5ed-4228-be08-29a4110a2478@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b88227ad-f5ed-4228-be08-29a4110a2478@intel.com>

On Mon, Feb 17, 2025 at 11:51:28PM -0800, Chang S. Bae wrote:
> On 2/17/2025 5:33 AM, Borislav Petkov wrote:
> > 
> > Why are you even touching this function instead of doing the staging in the
> > beginning of load_late_stop_cpus()?
> 
> I thought staging is logically distinguishable.

What does that even mean?

> While load_late_stop_cpus() currently performs loading when CPUs are
> _stopped_,

Not entirely - it does preparatory work and then stops the CPUs. Staging could
be part of that prep work.

> staging occurs on a non-critical path and remains interruptible.

So if you really wanna do that and be really "free", then you should do it
outside of load_late_locked() because that runs with the hotplug lock taken.

But then the only thing that matters is, when *exactly* you should stage. If
->request_microcode_fw() fails, staging would be unnecessary work.

So instead of trying to too hard, just stick the staging at the beginning of
load_late_stop_cpus() and be done with it.

Also, if you want to send a patch, don't send it from a mail client which will
mangle it so that it is inapplicable and no one can play with it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

