Return-Path: <linux-kernel+bounces-171897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1338BEA1A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B361F22AFB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905E68F72;
	Tue,  7 May 2024 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="pagzj0ZW"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A767013D63B
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 17:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101787; cv=none; b=IVI2sg734iFDMQyNuOpSwd874/09npxkEO0DusOMRwHRbczUmbz95rEjy9sdV+rzq1dHNKyjp6+EvtjqBOtirz/oWJHX7KVSFXe5mSduZcI84jMfe+DuqkH0ASA9+nNiH8roiN7TKNISGWEWrFdjHX2sGbkF1mOxLbmUl8syboI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101787; c=relaxed/simple;
	bh=cxBnI0V+A77Y2HA8nkpU/SoRJL2gunBwBElfZQaz99I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ubSjvejtE+nulRsd4K+d6+8uiPgZir7XNPNLWc/VjiPgnpfpHM8DgFgY96Tn1Gj4LeLVewfp0YH5+zh2pnsQMIGMPeRGaPkcm2lGLOWYYM5Nz5uanu41lZXjaJyI+6+THhtZ9h3o6WOnd80d6jPZbf07Bmcpb+KZ78e4vAWkz8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pagzj0ZW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so7814243276.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 10:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715101784; x=1715706584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3SG1rzAoM8uY88FvswpqM+Szlp+5zBUjcIa4szFSpCo=;
        b=pagzj0ZWIQI35Q1jNM+r1mYS3nNi5E6xMZ2DyE8W/8dVInUTw0hb94Jdha/RBuy0XS
         ALFB6JY512bJhu3niKs3cV+zt3vFwLJAZ2AndtdQnZRjfM48/rZQT09a1mh9hnOGDgkv
         XSDeiCtVDoo3xESa3ZdclrkD4qvqJ9XSC3m3og0Wzw8I0eFXw7zqc1DELgxo91hKu+WA
         WpqZoJlb5bWW1GnrxneiP5uvrG8HrtNDeE0c7wTUF/wssCGrne/ddLjhimLdjdiEHdmw
         wfe4NyMpbPpAD8IUsfan7Ip6H56hskNiMHvbDhOh7Fe4ExiEPc7tB32atqE6DJs+AhK+
         wy6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715101784; x=1715706584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3SG1rzAoM8uY88FvswpqM+Szlp+5zBUjcIa4szFSpCo=;
        b=N4XyyIleoeiO5yH6bEGnVcBHQo/fz5SLVrQH6B3t9SwZmhfQRAD0mCEgi43BQn6lZB
         y82LUiqMmLXjP4SM9ySaW0Pc/SRvJMSpuYWmB9f6Brpi9spEdskC1M9nazcIepcI3njJ
         UEXwK1RTD8HbGO6XAYlNyKPI/i/hT1NY+ZXgqyoKR6JMO+3B9WP32WPFna6NQiYb8rhI
         HdUg2MEaDVSi0P7sNgdX3I1q9ufSH+cok64oXNUz/hTTPj6ZaOzT4z4Eunu+lPPk8qnN
         dTpHj6OCDSey54RVMrRsojdklhoZ4bNVhHGqTUqrQlukZgA2vieNcukSnDbFYJPo6ZyD
         TmzA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+QVVO3lHLhO8HWBCgLvsnrAFus+75E68XVp1lzAQpmWTDMMq8Fx/NkNYYCQn/HwSqwpFe8J1yvRSpf6YqUlxOCR8oj6dg2vGUMrr
X-Gm-Message-State: AOJu0YznnkbdckKe0+yTaVCXS6zvHXICNcbe6rkHttgyUY9WQHAs8ZSl
	DvBdp52loKuw2S67kZcg2jbHtY8zNHKzgI4Bqt2neHbkopheskAFgy4ZgOlh2T95ubloghtra7C
	GzA==
X-Google-Smtp-Source: AGHT+IHae491wrusprky728M5llnp1S0vUofuj0e6wCJ8itraYOwy9j7fA4JfRi45Q/XtiuCFnR0clXdXnY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:dc82:0:b0:deb:8bc4:e27f with SMTP id
 3f1490d57ef6-debb9db1ffdmr56200276.6.1715101784626; Tue, 07 May 2024 10:09:44
 -0700 (PDT)
Date: Tue, 7 May 2024 10:09:43 -0700
In-Reply-To: <20240507114814.GBZjoU_u5kYBhLips3@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZjE7DkTBSbPlBN8k@google.com> <20240430193211.GEZjFHO0ayDXtgvbE7@fat_crate.local>
 <ZjFLpkgI3Zl4dsXs@google.com> <20240430223305.GFZjFxoSha7S5BYbIu@fat_crate.local>
 <20240504124822.GAZjYulrGPPX_4w4zK@fat_crate.local> <ZjiCJz4myN2DLnZ5@xsang-OptiPlex-9020>
 <Zjj3Lrv2NNHLEzzk@google.com> <20240506155759.GOZjj-B_Qrz4DCXwmb@fat_crate.local>
 <ZjnTW4XQwVHEiSaW@xsang-OptiPlex-9020> <20240507114814.GBZjoU_u5kYBhLips3@fat_crate.local>
Message-ID: <ZjpgV-_bjOQh1SL3@google.com>
Subject: Re: [tip:x86/alternatives] [x86/alternatives] ee8962082a: WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, x86@kernel.org, Ingo Molnar <mingo@kernel.org>, 
	Srikanth Aithal <sraithal@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Tue, May 07, 2024, Borislav Petkov wrote:
> From: Borislav Petkov <bp@alien8.de>
> To: Oliver Sang <oliver.sang@intel.com>
> Cc: Sean Christopherson <seanjc@google.com>, oe-lkp@lists.linux.dev,
> 	lkp@intel.com, linux-kernel@vger.kernel.org, x86@kernel.org,
> 	Ingo Molnar <mingo@kernel.org>, Srikanth Aithal <sraithal@amd.com>
> Bcc: bp@alien8.de
> Subject: Re: [tip:x86/alternatives] [x86/alternatives] ee8962082a:
>  WARNING:at_arch/x86/kernel/cpu/cpuid-deps.c:#do_clear_cpu_cap
> Reply-To: 
> In-Reply-To: <ZjnTW4XQwVHEiSaW@xsang-OptiPlex-9020>
> 
> On Tue, May 07, 2024 at 03:08:11PM +0800, Oliver Sang wrote:
> > I applied the debug pach ontop of lastest Linus master:
> > 
> > 1621a826233a7 debug patch from Boris for ee8962082a
> > dccb07f2914cd (HEAD, linus/master) Merge tag 'for-6.9-rc7-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux
> > 
> > attached dmesg and cpuinfo (a little diff, so I attached it again)
> 
> Thanks, now what are we seeing here:
> 
> [    0.763720][    T0] x86/cpu: init_ia32_feat_ctl: CPU0: FEAT_CTL: 0x5, tboot: 0

..

> FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX, bit 2 is set. So that conditional is
> not true either. And the pr_err_once() doesn't appear in dmesg.
> 
> BUT(!), look what the original dmesg said:
> 
> [    0.055225][    T0] x86/cpu: VMX (outside TXT) disabled by BIOS
> 
> So that FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX bit was not set back then. Why?
> 
> Oliver, have you done any BIOS config changes in the meantime?
> 
> This all looks really weird.
> 
> The other possibility would be if something changed between -rc3
> (the branch x86/alternatives is based on) and -rc7. Unlikely but by now
> everything's possible.
>
> What could also be the case is, the BSP's FEAT_CTL is 0x0 (unconfigured,
> whatever), we'd go in, set FEAT_CTL_LOCKED and that'll lock the bit in
> all FEAT_CTLs on all cores, then it'll set
> FEAT_CTL_VMX_ENABLED_OUTSIDE_SMX.o

I would say it's beyond unlikely that a kernel change is responsible.  In both
traces, FEAT_CTL.LOCKED is '1' before init_ia32_feat_ctl() runs, i.e. the MSR was
already locked by BIOS.  And that is by far the most common scenario, it's all
but unheard of for BIOS to leave FEAT_CTL unlocked.

For giggles, I hacked QEMU to simulate FEAT_CTL being (a) unlocked by BIOS and
(b) locked with VMX disabled.  For both (a) and (b), an -rc3 based kernel behaves
as expected, i.e. configures the MSR correctly for (a), and complains once on the
BSP about VMX being disabled for (b).  Neither case triggers the WARN_ON()
alternatives being applied.

Oliver, are you able to reproduce the WARN using the "original" kernel?  If not,
then I don't think it's more time looking at this from a kernel perspective, as
it's more or less guaranteed to be some sort of environmental issue.

