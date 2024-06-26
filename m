Return-Path: <linux-kernel+bounces-230930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 168DB9183E5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49ED41C21BA3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8860D186285;
	Wed, 26 Jun 2024 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kgr5PE76"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50178155A26
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719411767; cv=none; b=In/9Q+NclcPWkvOv08kqmljq7EMCHM0pYoJ7u6EgdG/+yVCbiEFraUR3/6316ov7l9ItqGZXz+87TXf91QcySQYVnH9JeCUkmhSlbBx1YMPAndG5DnJLtze/jsBlLPkAQOoIkjZFTGZB2aHJsrHHz/BxkqkTShbqSRUwSHw+YXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719411767; c=relaxed/simple;
	bh=Md2bQa4i77L1a2ZeCzjEInnWWb4LCcOfrCX9kdzNkqI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bTI1FDrT10EkbbTVO+fiOuv0/MFplzrc1DV5+JJ48cvbmDzvOz66GxuO6kdv9KbAljYZfdCyXPmWgHyFcx10TLux93j/yHXmEfGKZNMGK2EfZwFk/aYNpOXSIj9uUK/6K8W0ZcZWk9ZPakrl1Ysf0Y1W29NFHeoSUAAdvneftkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kgr5PE76; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6435ed81ca2so97762127b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719411765; x=1720016565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qp7ZaRBbzBSgQ/146Ma/gHnUZhhaH0ckKss1Vo4y77o=;
        b=kgr5PE76LRYb/NeoipjOG1L+h8s7UsbX61fEfm5X9j00ciHcpVu8sAO8TfO+4xvdcY
         mPD7czPudRTZHQ/+eXhI7cVdIzc1mR9kXoPE49ga8G7KNO4+bXNzbdDl5fU2cQa2ZD3m
         9SjVhZOvDfqhNvSW6AwZhN/JA7cMAg6ddVfsypTffGSVaJV+VYI+u3WVYf+gZnWze9ks
         Te1LKgrGOWWSlAmKHm5dXGmx4pE8l+UiyQwhp+6ztYdg3gsiVjaE4QQldd1MFl2I9qw1
         ARa6qLx7LY01RE+vaVplKg3LkSOsalxfHkEWwCWxPSgJoOAwE8uM9mb0Npt9jCPVgcGc
         ksLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719411765; x=1720016565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qp7ZaRBbzBSgQ/146Ma/gHnUZhhaH0ckKss1Vo4y77o=;
        b=WP7eUAUKLcV/H5Ckp6RV5IAOrNPnLehbGlinR2MLf4fr8r6Fs9lIc/Jc6OB7QE9PBo
         yhOE41AdrkxiI9h6oQqSPD9qA0+2gbMOSr9VeZJ1nZH/O0Jte+g5OFeiyLRVOu8zxasF
         ovucDm3x3fbHJHjheg9V1XPJ1123Vmi3XawkVbaHPPqeBe7SbYyFSmr9bsYjNTJMRUXz
         IBBPJRSwzM/Z5+93XM9HP92PX/5L1FzHFdyprc0acNRMu0RQMDEoEXzUIst4NmTmoQkg
         Xz70r0uSnnvYT/a1YBRqFbjR6EHg1OTr47xjPU5OSm0nHkiyBiA4QOULnnMbx2WS7FRP
         ZXJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN4zupet2yDR/hziUGMa8+Dw1W53ltsAB7RfRNzjM/KTYmFwaD8+qDMcdl0x5o0eyKXuSUI5MtoCDd8MrEerUwYCs6r9OL5Xvg6K++
X-Gm-Message-State: AOJu0YwiH2A/tPBPOnfk3v1963ug4/tD5WxKrMQtOSOzhlu87nu9VYBx
	Ikn+HLADbz2uVv0pQslMcwPwD9nw7qIXra1zx4PonWwz252WHqm0Bg+mvbKqXav9xLSqd9yT6Pt
	21g==
X-Google-Smtp-Source: AGHT+IGqcs/EmSI3qabDNZ1kSDkVdc1rK39WP8naNRXVdbTy2XE4VAXP7npVp68Qm95FUBEb4i3B54q0OQc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:6d0a:b0:62c:fa1a:21d2 with SMTP id
 00721157ae682-643aaa7d245mr5660817b3.1.1719411765419; Wed, 26 Jun 2024
 07:22:45 -0700 (PDT)
Date: Wed, 26 Jun 2024 07:22:43 -0700
In-Reply-To: <20240621134041.3170480-5-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240621134041.3170480-1-michael.roth@amd.com> <20240621134041.3170480-5-michael.roth@amd.com>
Message-ID: <ZnwkMyy1kgu0dFdv@google.com>
Subject: Re: [PATCH v1 4/5] KVM: Introduce KVM_EXIT_COCO exit type
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, pbonzini@redhat.com, 
	jroedel@suse.de, thomas.lendacky@amd.com, pgonda@google.com, 
	ashish.kalra@amd.com, bp@alien8.de, pankaj.gupta@amd.com, 
	liam.merwick@oracle.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 21, 2024, Michael Roth wrote:
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index ecfa25b505e7..2eea9828d9aa 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -7122,6 +7122,97 @@ Please note that the kernel is allowed to use the kvm_run structure as the
>  primary storage for certain register types. Therefore, the kernel may use the
>  values in kvm_run even if the corresponding bit in kvm_dirty_regs is not set.
>  
> +::
> +
> +		/* KVM_EXIT_COCO */
> +		struct kvm_exit_coco {
> +		#define KVM_EXIT_COCO_REQ_CERTS			0
> +		#define KVM_EXIT_COCO_MAX			1
> +			__u8 nr;
> +			__u8 pad0[7];
> +			union {
> +				struct {
> +					__u64 gfn;
> +					__u32 npages;
> +		#define KVM_EXIT_COCO_REQ_CERTS_ERR_INVALID_LEN		1
> +		#define KVM_EXIT_COCO_REQ_CERTS_ERR_GENERIC		(1 << 31)

Unless I'm mistaken, these error codes are defined by the GHCB, which means the
values matter, i.e. aren't arbitrary KVM-defined values.

I forget exactly what we discussed in PUCK, but for the error codes, I think KVM
should either define it's own values that are completely disconnected from any
"harware" spec, or KVM should very explicitly #define all hardware values and have
the semantics of "ret" be vendor specific.  A hybrid approach doesn't really work,
e.g. KVM_EXIT_COCO_REQ_CERTS_ERR_GENERIC isn't used anywhere and and looks quite odd.

My vote is for vendor specific error codes, because unlike having a common user
exit reason+struct, I don't think arch-neutral error codes will minimize KVM's ABI,
I think it'll do the exact opposite.  The only thing we need to require is that
'0' == success.

E.g. I think we can end up with something like:

  static int snp_complete_req_certs(struct kvm_vcpu *vcpu)
  {
	struct vcpu_svm *svm = to_svm(vcpu);
	struct vmcb_control_area *control = &svm->vmcb->control;

	if (vcpu->run->coco.req_certs.ret)
		if (vcpu->run->coco.req_certs.ret == SNP_GUEST_VMM_ERR_INVALID_LEN)
			vcpu->arch.regs[VCPU_REGS_RBX] = vcpu->run->coco.req_certs.npages;

		ghcb_set_sw_exit_info_2(svm->sev_es.ghcb,
					SNP_GUEST_ERR(vcpu->run->coco.req_certs.ret, 0));
		return 1;
	}

	return snp_handle_guest_req(svm, control->exit_info_1, control->exit_info_2);
  }

> +					__u32 ret;
> +				} req_certs;
> +			};

