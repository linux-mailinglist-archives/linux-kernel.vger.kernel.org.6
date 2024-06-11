Return-Path: <linux-kernel+bounces-209149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B822902DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 03:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CE822835A8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52768F5A;
	Tue, 11 Jun 2024 01:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="okUFOnC5"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4146FC5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 01:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718068649; cv=none; b=pkcbLdRbXO8zhZXPcmmyUFFAF5IjvpPFWUVA8qOrnUowZUG77/b86gsEnWrDuDI/y6yEVYcGGala4Rtqm9V6WEu8DlKL5dBYHOWmmdbcRS/15+JjvqjxsftAHeGia+GO24wJfDBVxCz2Al5W70fMJ+7L4JpIj0QM0/C2Muic1H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718068649; c=relaxed/simple;
	bh=cDG4sBmtaLwX3BcWuqNAVreT/h9JlC27J2E+qHFs6b4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u/Jr+sLy2yi3rxe9AqD3ucv5Zq1ynSY1WRcB4+wYxjQVNS6/9DsnfGJYxp2wE0duURVP/dL6mWETA61noheY0i0XcymZvqHGwvNPnsssaCuo9xWdFn32CLeKujW3J8cxYWvEMJ5i4gajIhmWrRvV8g/0SRTgM+H8mUL8WyyAX/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=okUFOnC5; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2c2dfa5cfa5so2378613a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718068646; x=1718673446; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lD/LO/gxXCIGTZKmzDO3IySUcSGm5VYiE8jvdtRhgQQ=;
        b=okUFOnC5kQPxvERe3gp1C9v8dcFAFH/DpCyD5cqahTmZW9If8wno8KTBmLyKgjfO2a
         s412FXhgyXXreAcq9Ot1nF7g5LKP1HZXs+SpBf9IMioUrlJ8tOcARhgW+g/JJbYe8v/7
         b5hP1L44HQwt9S+C8v2ZESy+MLKA4NBCnH39WdgbMuRP2SO7h44eBQxr5ijzux2iFd/y
         jJ/JPlX4c/YNekGgqc87OQAx6z4T34RFQaIxbU242nSd6GJvqpivwL1lam7bWgeJRJTb
         LNRHGsqoviW6o6Fn0Oo8+hJzotLYIVo3xZg8slxLlY9TO2tthQnYZQOBqwpNO+E/gHKg
         Oteg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718068646; x=1718673446;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lD/LO/gxXCIGTZKmzDO3IySUcSGm5VYiE8jvdtRhgQQ=;
        b=OGpTG4sjV+fvi3OF1buI2zyDcp4bztCJUxMK8F/YAg5hYoM3Rtr4erX4L3i8ldQDs2
         hfRux69sVB6Nv0au3fWFbcgXggzw6VR8uGCNrq8329V5om5M6LjPqr+KZtWc6Irlr0Sv
         +53L2E/kjH+MolOlRj9KfSh2Kyc37RQv6IMgrVeoGNPaH5jAxmpgXNLHbboQJ2EvL0d8
         5NNBPDV/LiQAHYY8INztFW9levMgTXUrRR4FfUNZDyEKFa1uoi7YvGDTYJu5U0N9k62V
         ZDTZMJ+fg1LjfoJm6AnkWo+mC0mP3VKzWq7MoUiZj40vW2eRKrO9wypKnJtnIDP5K6KV
         bCGA==
X-Forwarded-Encrypted: i=1; AJvYcCXqpcawCdpq2k88qcJbROYgii/qWpScoWC9MgAWeJykuIwq1aAi8ZddLC19qOMcfpHzh8uXjTjr/nFdtD9Nte2FQCfe5j9J///SKZL1
X-Gm-Message-State: AOJu0YwYA7Oi5f/37RhWefh5f5qrej6YjdH8PKugxWrSJDU4og1RZlrS
	exDdWinqcTnDxgq05gwy8P3WiImBYDhkOLCTkULK9PR0bMnlcYg9CQtxZFn1xKoz3ZW1kRbiDvX
	MYg==
X-Google-Smtp-Source: AGHT+IHhAcgd3utbJYDRGxgrLzP9SGACR5u04abW5bR8SQQdYf0g+W+AAgne/wgHvaBuqh1i70Q6FxoEe/M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:807:b0:2c3:2e2:8391 with SMTP id
 98e67ed59e1d1-2c302e283cdmr13494a91.0.1718068646422; Mon, 10 Jun 2024
 18:17:26 -0700 (PDT)
Date: Mon, 10 Jun 2024 18:17:24 -0700
In-Reply-To: <20240509075423.156858-2-weijiang.yang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240509075423.156858-1-weijiang.yang@intel.com> <20240509075423.156858-2-weijiang.yang@intel.com>
Message-ID: <ZmelpPm5YfGifhIj@google.com>
Subject: Re: [RFC PATCH 2/2] KVM: x86: Enable guest SSP read/write interface
 with new uAPIs
From: Sean Christopherson <seanjc@google.com>
To: Yang Weijiang <weijiang.yang@intel.com>
Cc: pbonzini@redhat.com, mlevitsk@redhat.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, May 09, 2024, Yang Weijiang wrote:
> Enable guest shadow stack pointer(SSP) access interface with new uAPIs.
> CET guest SSP is HW register which has corresponding VMCS field to save
> /restore guest values when VM-{Exit,Entry} happens. KVM handles SSP as
> a synthetic MSR for userspace access.
> 
> Use a translation helper to set up mapping for SSP synthetic index and
> KVM-internal MSR index so that userspace doesn't need to take care of
> KVM's management for synthetic MSRs and avoid conflicts.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Yang Weijiang <weijiang.yang@intel.com>
> ---
>  arch/x86/include/uapi/asm/kvm.h |  3 +++
>  arch/x86/kvm/x86.c              |  7 +++++++
>  arch/x86/kvm/x86.h              | 10 ++++++++++
>  3 files changed, 20 insertions(+)
> 
> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index ca2a47a85fa1..81c8d9ea2e58 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -420,6 +420,9 @@ struct kvm_x86_reg_id {
>  	__u16 rsvd16;
>  };
>  
> +/* KVM synthetic MSR index staring from 0 */
> +#define MSR_KVM_GUEST_SSP	0

Do we want to have "SYNTHETIC" in the name?  E.g. to try and differentiate from
KVM's paravirtual MSRs?

Hmm, but the PV MSRs are synthetic too.  Maybe it's the MSR part that's bad, e.g.
the whole point of these shenanigans is to let KVM use its internal MSR framework
without exposing those details to userspace.

So rather than, KVM_X86_REG_SYNTHETIC_MSR, what if we go with KVM_X86_REG_SYNTHETIC?
And then this becomes something like KVM_SYNTHETIC_GUEST_SSP?

Aha!  And then to prepare for a future where we add synthetic registers that
aren't routed through the MSR framework (which seems unlikely, but its trivially
easy to handle, so why not):

static int kvm_translate_synthetic_reg(struct kvm_x86_reg_id *reg)
{
	switch (reg->index) {
	case MSR_KVM_GUEST_SSP:
		reg->type = KVM_X86_REG_MSR;
		reg->index = MSR_KVM_INTERNAL_GUEST_SSP;
		break;
	default:
		return -EINVAL;
	}
	return 0;
}

and then the caller would have slightly different ordering:

        if (id->type == KVM_X86_REG_SYNTHETIC_MSR) {
                r = kvm_translate_synthetic_msr(&id->index);
                if (r)
                        break;
        }

        r = -EINVAL;
        if (id->type != KVM_X86_REG_MSR)
                break;

