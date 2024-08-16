Return-Path: <linux-kernel+bounces-290416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5DE95538F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 00:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C67EB23326
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 22:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638E314658C;
	Fri, 16 Aug 2024 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ofh8Ed8L"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5059E78C9C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723849156; cv=none; b=JDCdCFM0Je6WXTENhUv6dxZYAgcFcihgV8vrqjsqWgYVVGSsVP/2CszjJj1gYgUjpe+XhlnAIDziUt/GblTiOZBV5WRJiOVhqGWGzErVhQaS8fqfYJoNSfXWZKEgWExUrK/+porArbOOkWk7mwhIirHZ7AX54SLtzuNW2FSoL1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723849156; c=relaxed/simple;
	bh=MJs2a21yAaqbtR36kVTBt+DPGz0l0wyzYftG3vvf3t8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qd/DkJMkl0T/x9UUpwz5a6FvaZnbTkxI1Bq6H+JW0RJBybqy8ZAzIVWYvDRiuFcGTgxS9/KVM59LCmuQEwyqiOl8uOXZUJpMAA/aR2duxUadyObRF6Vni+IpkrX7JHr4M3MrR8wlNnjqYFOkC7QDuvo4D4q/Q6T9Sjcsnj0mkAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ofh8Ed8L; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ad9ffa0d77so46452747b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723849154; x=1724453954; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6OigZl0tBlIvn+LyfmlGZPjZ8Rd3zNNzd+iuerO/zdw=;
        b=ofh8Ed8LtJObjpPNPZwS5rUSfm4TaWr597j443IPNSW58ea/eOXePXdSRBxq5mR6gl
         0KcG9INyVAUYkabl1R9kktS4U4JAzbWVI8q7YtMXkidR/H8rwYtRQYWF5zfhmorSe/Dc
         TqGOSTEJ3TrnkPwGm+UcCO/2Gp7NXVNvwn1o53QaA40CL930ivBhbXeHY81Mm8mF6JlL
         hqTbtRAO4m9Ny9+z9YPNHLfsOQomZVbouO8XqL2N7bF0WUYpWK3eDZKYbH3HNgljRlwR
         IYaZPedxhQm9b1Er2ZUnC0VdPwMlNuvl5Cbc5eFaPhSP9hDV8jRmPVm4jOnFh681NvQm
         BLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723849154; x=1724453954;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6OigZl0tBlIvn+LyfmlGZPjZ8Rd3zNNzd+iuerO/zdw=;
        b=f0KiV6QsBQrQGJX5a5EXEVaZEshmX7RTH1Ze0zSp0rsoQ23e/sODWO0ZTN5hOAsE1E
         /j0jQOAWpub/xLgDSNzbbd8E6AYrxAEHDgMrP/LstD7WNmQrij7L+Z7/JzJgKXoUh6Nu
         P1I0BYywNTr75tL5+dr7hYItObi2cx2xso+g46v4eoNQE6CdwYsXW1B0pA180jP8FWD5
         tVMAxvPQ48BauyR8cfq2QNG2/x0c8prF6kqu2WbaoKpP6IBVLsnSbNrOJYxccE4EJHTE
         GGmPhl4VccTvOP56Y6POtp7EXfrthrBrQUpSSL+wxyewt2/2Ho8wkApNJK3+saA+OWtS
         dB7A==
X-Forwarded-Encrypted: i=1; AJvYcCUYoCoEOtaXb9uxhcmMrGeYbfnoi9kYNyZrZxVNgim1iqIhrZ6/tHjPHH21UdW+knqlPgrkyF7KEJQTxMg8NiOoI0FgN/BLmVo55WBg
X-Gm-Message-State: AOJu0Yx7RgdeS1anj0LO3og+YhP7qa1/vTOqY6yUVkfgfIw1byHxgCsr
	Gtlu8btm5wXsfSNCOny11F/rZrFRp/mCKUZvlq/V/k+NzH/pqlA8C8qTfG2dCCXicIchQ+Jpd4s
	Afg==
X-Google-Smtp-Source: AGHT+IEBjklcX/YjjkCqt7TUIQQPn/5VaTiXo1FTpq7Fi5uIK9LBoTkBv7DIWbdiZ7fQsq0WqKSltBd9lwc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:2a87:b0:673:b39a:92ce with SMTP id
 00721157ae682-6b1b7c6a599mr999877b3.3.1723849153801; Fri, 16 Aug 2024
 15:59:13 -0700 (PDT)
Date: Fri, 16 Aug 2024 15:59:12 -0700
In-Reply-To: <20240802015732.3192877-3-kim.phillips@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240802015732.3192877-1-kim.phillips@amd.com> <20240802015732.3192877-3-kim.phillips@amd.com>
Message-ID: <Zr_ZwLsqqOTlxGl2@google.com>
Subject: Re: [PATCH 2/2] KVM: SEV: Configure "ALLOWED_SEV_FEATURES" VMCB Field
From: Sean Christopherson <seanjc@google.com>
To: Kim Phillips <kim.phillips@amd.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Kishon Vijay Abraham I <kvijayab@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Aug 01, 2024, Kim Phillips wrote:
> From: Kishon Vijay Abraham I <kvijayab@amd.com>
> 
> AMD EPYC 5th generation processors have introduced a feature that allows
> the hypervisor to control the SEV_FEATURES that are set for or by a
> guest [1]. The ALLOWED_SEV_FEATURES feature can be used by the hypervisor
> to enforce that SEV-ES and SEV-SNP guests cannot enable features that the
> hypervisor does not want to be enabled.

How does the host communicate to the guest which features are allowed?  And based
on this blurb:

  Some SEV features can only be used if the Allowed SEV Features Mask is enabled,
  and the mask is configured to permit the corresponding feature. If the Allowed
  SEV Features Mask is not enabled, these features are not available (see SEV_FEATURES
  in Appendix B, Table B-4).

and the appendix, this only applies to PmcVirtualization and SecureAvic.  Adding
that info in the changelog would be *very* helpful.

And I see that SVM_SEV_FEAT_DEBUG_SWAP, a.k.a. DebugVirtualization, is a guest
controlled feature and doesn't honor ALLOWED_SEV_FEATURES.  Doesn't that mean
sev_vcpu_has_debug_swap() is broken, i.e. that KVM must assume the guest can
DebugVirtualization on and off at will?  Or am I missing something?

