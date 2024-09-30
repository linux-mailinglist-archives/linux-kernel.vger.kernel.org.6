Return-Path: <linux-kernel+bounces-344905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD22E98AF78
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 23:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55246B241D9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 21:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E05D187862;
	Mon, 30 Sep 2024 21:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iK4ctBoL"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756B21865EE
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 21:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727733413; cv=none; b=uxKWuf7XXZ2VCLTvrEv/mk0ErStaclaM+XmYBmwHPd1Qrk3MGXDU151qShXRK9GJEYOPnijjz1m69K4azGwDaUED3HrafEMfCjFePMWpMESSQf2j6zFjt+RP1GQag4C5XqGkzLHdoW9QmogtCd8pPC+uWGte/UyHGkRjMLuya5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727733413; c=relaxed/simple;
	bh=EI35CoEM1AcSciWaRt5Y7P85pwkoV/1G1OSkpZxfbPg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=YMYMQgxg3flmyzZ+ZGmnOTjTFiCxe1R2fEothVfz28wTkLUl4JSeu7YrYdbz6Qe74Mbu6qs7cmVYknSmNh8TDuKnzDkDtvr4psh8pJr582qHfr/WXXYbiGu1ToZCAGhz1+Z0lIj57MW7HHeyZ3yq/xwH4bnwrbdg/YOAbcTmFX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iK4ctBoL; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-204e310e050so57110745ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 14:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727733412; x=1728338212; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PntPBodbq4krAqAL/kXN8N5SHx+RiWW9dX81Z4mrKcI=;
        b=iK4ctBoLbfEykS27Sxro0hN4zq6Fsa8D/e4qyRX7VhXIyF1n7JXLwfPLtAr+02SsQF
         asndJZN8oS5fIEiuyL4lY15/Qe8MXx0TKmMJ018v9DK2ltmm900NLN7gCfBtwVdOmFrC
         ujE9k/eLQpDmP097pL4P31lLCQ/DksXqVjD7cNMQQ92Vwi8Zk66qHCaiv8fxl45/lxry
         pBreIysoDq4cgfoPZuW7cUeTTOA/i6sy6Zzgcw28bsgQjFA4kTdp8fnHG72jkG24coZv
         sTJnVOcZ0lUMvMqulPFuiFdzszNgB7RjudMC3dLV3w7Q1ISsB7R3+86/cFTIqjqwapMe
         nJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727733412; x=1728338212;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PntPBodbq4krAqAL/kXN8N5SHx+RiWW9dX81Z4mrKcI=;
        b=mFhUOcJneC1Q47jyQflBvxDbl5JiN1mRLGh6PYQK5RdDZhPz8iTxJFm6agKwmjVTLt
         0VSrFKcSz2i91TqACsPySEXaM0hqkeKUC9LdZLbOHZjcf1T7xcHBjBo+R5yzpydsok6Y
         ru9aaP9VLkISkCMSwb8Za7NPlE1iy6DLCdadisScsBVYd0rmf404kGro1ybfMbXtkMqd
         Zpn3SRuCdp1Wm3k+1BWWfrQKG2qsfxgn1as++1c4OcpLwNIvkmZsvIJ8KbiJ1ko2SJtU
         8O4MaBFMokF9y+wmZTg96VL60Sra02bOj75hLO+beiUNKVRMxOp+rmRLQQITfaNru5Vj
         wqaw==
X-Forwarded-Encrypted: i=1; AJvYcCWN2nK1+lOpKmc66sw7G/rTJ+QZ+zjz/YKM2TMSu4zperV6tl0BN2q5h2BrYDQQVUcLiYZdSOBB+Moqw0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNhy3zlfvTJc2+jddxjP2ZXMak2PjDrDVhr8FA4U4e0m+aXzJG
	S4vQSSsR+Y+TCqVR1fZSRKwYbtH0UsoSlJjV+KJwdIyflnZsqPykVYdgeJBpifJAKfVVIAj9tvd
	9lQ==
X-Google-Smtp-Source: AGHT+IFa/3NUudFCuE72HcCwi+hM+UVm+5oAl6XGWfqHgohNP2i/0xjhJQmHwp45qjEiLZEOk9HWi9na7w8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:f691:b0:20b:aed1:bf77 with SMTP id
 d9443c01a7336-20baed1c097mr62225ad.7.1727733411419; Mon, 30 Sep 2024 14:56:51
 -0700 (PDT)
Date: Mon, 30 Sep 2024 14:56:49 -0700
In-Reply-To: <20240911204158.2034295-4-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240911204158.2034295-1-seanjc@google.com> <20240911204158.2034295-4-seanjc@google.com>
Message-ID: <ZvseoZLzmaS4MEbc@google.com>
Subject: Re: [PATCH v2 03/13] KVM: selftests: Fudge around an apparent gcc bug
 in arm64's PMU test
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 11, 2024, Sean Christopherson wrote:
> Use u64_replace_bits() instead of u64p_replace_bits() to set PMCR.N in
> arm64's vPMU counter access test to fudge around what appears to be a gcc
> bug.  With the recent change to have vcpu_get_reg() return a value in lieu
> of an out-param, some versions of gcc completely ignore the operation
> performed by set_pmcr_n(), i.e. ignore the output param.

Filed a gcc bug: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=116912

I'll report back if anything interesting comes out of that bug.

