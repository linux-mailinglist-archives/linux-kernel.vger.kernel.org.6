Return-Path: <linux-kernel+bounces-522667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82178A3CD12
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 00:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 620F57A74FF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 23:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5FE22CBF3;
	Wed, 19 Feb 2025 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZsLGu7YK"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8BC2144C8
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740006599; cv=none; b=QmjPh+TgD9N7IgYevmWbExLTY/B8aKHWbjP0uNs9ylqZLT0G85ocxbmQ3SQniL3mHtr9FtV+xex3QE1lb2yj3CMvMDunkIXU32PXi1Kj4EayyrsztvV2y0lCcTAADFMOOHd02JvwSAKqYaSSV5nZSk6lhnaLOASN24tMEbYrHqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740006599; c=relaxed/simple;
	bh=AQQz81U+/uQt8t1jtDfXn5ubKPfVZPZuQq0XA2aTtFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iNjaUHumn9AZiR3wFS6pQAu4trbUG1hL5KpFiaH9bb2ZXqZkL3BCbTVOH6qM56/7oBZRzz2LipC7ZhydH3aKIZXbuaThDP4rFieF6N4dFwPuEuUVb/AmNKJikhaPpuK1kU4jFcDBGf2dhXj2Vuhw6Pocbu6dSxB1VUiDsVcLHkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZsLGu7YK; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3d19702f977so27465ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 15:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740006596; x=1740611396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQQz81U+/uQt8t1jtDfXn5ubKPfVZPZuQq0XA2aTtFw=;
        b=ZsLGu7YK9eF+Pcq7F4H+mjL16tNspFf2QQp0mJVOCiuIvzX0p0K87DF0KFMybbw45Z
         p/cNOgPaqdODwjm9rxrIOjnaEv2Xfyvnt7873RWrzW/lXFAXQ5+b+RUz4Wmnw0uLjdJW
         GXhdSpzSoC75nwf5WlU2tUCqOMUWkpjqLaz/cP3VT5Cj9P3erA9vmzFm2qwBN/xqchFP
         OCjChEUeguKUUJ1HgI++wnnJyyQ/oMY/Vm/Y/8+vnUTp7ItCuhAFdksOMD0fi3sZfKx5
         c2g5GaHcB+1p/JyDEL1JaH1W2QuluinBl4s05GTOpiO9lIHUzW6gg6GTBL6pyvYRYxj3
         KSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740006596; x=1740611396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQQz81U+/uQt8t1jtDfXn5ubKPfVZPZuQq0XA2aTtFw=;
        b=g+v6H2Vnvfd+WwwcCGmycr6gPv/Y07uXli7odm3kiOkmNVTeDHr8YZOIS9iPrPjHD+
         sg/Txnprp7no0BfahKfonwH1zO5LAj63mefe8TB4HbJkNTbe7IZSV2Il8LxuccK5FLyz
         7f8tc9nbK28M6K2bhOtVBaoN8ln9b0Fp7xtML5ZZWHqyyHlpi64XqZs+EVIEMiJsVGA8
         V3X98YgdM8ZlTdy+Kl7rYcUvRsoRngvy1MD0op1gFWyKjUJl+G9rSwr3bi2ffbTI5NEC
         lkkfGLVZGSVyrVFOicZLku1DPw8Dnt/SMHudPJLmNIkOCTMg6vwa1YWO/F6BsJ1twQW+
         u/bg==
X-Forwarded-Encrypted: i=1; AJvYcCWlF5qLtrmrF1TP6iC6fBOqIpwLHw1BFOmI8KWgqu8w8yeLOK98HMSWeup2DiHXVF563n5jQ8X4j3j4goY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3kbaP3hwhD821ig+GYEIkbR4rckRyqWbcboVkgZoSJX8I7eB/
	l5YwMD20Iwcc/aLJObMN2VIwh4aMzyfgyaso11toS4z3IVT6UDfzc2IHFZQbas/ZsDiLYtUNkkf
	MgxOV2r4T+hA+QPNrsVEw58vVXum95ISrZnJe
X-Gm-Gg: ASbGncs4xPhDB7gAyCFNaCA9XIKEQ0/K9JoR3cBbn61QUV9+UnuN8ZxMLNwwMg7Qd1o
	cZXkym1ifjCmz4ZTkwczlLgaLAow1MdcVO9vbu557vIUNxGzQqXSjdj3xpRsAKA+0eThSorqw
X-Google-Smtp-Source: AGHT+IEjLr482aJlHAAFBNSdvbSRICH9yurzAps08NVDvhZKsMsHZ4nAAaz9Lt8jjyW1wzcJ2bGnYSo/O/9OKcNCh0w=
X-Received: by 2002:a05:6e02:144d:b0:3d0:4e5d:4782 with SMTP id
 e9e14a558f8ab-3d2c09e9cbemr1292775ab.10.1740006595834; Wed, 19 Feb 2025
 15:09:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219220826.2453186-1-yosry.ahmed@linux.dev> <20250219220826.2453186-6-yosry.ahmed@linux.dev>
In-Reply-To: <20250219220826.2453186-6-yosry.ahmed@linux.dev>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 19 Feb 2025 15:09:43 -0800
X-Gm-Features: AWEUYZmIhUTZVLHPN2I1OKFIOPwRKrPuUJoTdwG1QAkz1q6QNSK1OOrLwbQj-NE
Message-ID: <CALMp9eSUGYfyogSruFY_o7EXdKUB52EC3iOU4r+vyrnG3cW-4g@mail.gmail.com>
Subject: Re: [PATCH 5/6] KVM: nVMX: Always use IBPB to properly virtualize IBRS
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2025 at 2:11=E2=80=AFPM Yosry Ahmed <yosry.ahmed@linux.dev>=
 wrote:
>
> On synthesized nested VM-exits in VMX, an IBPB is performed if IBRS is
> advertised to the guest to properly provide separate prediction domains
> for L1 and L2. However, this is currently conditional on
> X86_FEATURE_USE_IBPB, which depends on the host spectre_v2_user
> mitigation.
>
> In short, if spectre_v2_user=3Dno, IBRS is not virtualized correctly and
> L1 becomes suspectible to attacks from L2. Fix this by performing the

Nit: susceptible.

> IBPB regardless of X86_FEATURE_USE_IBPB.
>
> Fixes: 2e7eab81425a ("KVM: VMX: Execute IBPB on emulated VM-exit when gue=
st has IBRS")
> Signed-off-by: Yosry Ahmed <yosry.ahmed@linux.dev>

Argh! No doubt, I was burned once again by assuming that a function
name (indirect_branch_prediction_barrier) was actually descriptive.

Reviewed-by: Jim Mattson <jmattson@google.com>

