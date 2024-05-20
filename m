Return-Path: <linux-kernel+bounces-183825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9888C9EA5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 16:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3545D2846D5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 14:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA8613699F;
	Mon, 20 May 2024 14:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="CfCpOSMW"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C86854780
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716214637; cv=none; b=bEp31Ri6HWCBZY809NmUPiKG94HEvzzUcfT45dUCSInAOcRXf1DCBm4hZk7uTNfnOGpzK+Qd7gf6S5Ezr0KhI+wCTobjyEYnWbaN98T0JU7u7WhtgLOWoSKFG9eFlbSvW6Xj+DfpTkzc33nFUXu9iKj3BjH6/1WeIHosI9Mv0RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716214637; c=relaxed/simple;
	bh=TE1sg4WblssAzwhk8Fvh6z0iKKAZNh2qhRC/gVt7ePA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TfE7KmZkrENRdU6wqnd3jTxfegwepi13mg1H5FKCM/PB2omuzTSjJCy9NdzMvjp7QWrcNhHXT1urIs2iKPbhNrd7xZXWzaA6sBSpW219GrwIogiN8aLDpAOZDvQCkHqCCrZ/25BRKSzHzLiDHzDB1N8v5eW7c3U7mU81QCT6Qg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CfCpOSMW; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6ee089eedb7so12088019b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 07:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716214635; x=1716819435; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1nXWQb2sKPFqVRDv3f0da66A+zIbGZeLQHEJBZKGaXc=;
        b=CfCpOSMWM4ANKBKhuJu67eEsD5KCork9AR078H1aun2GoNqx1cZv11VrQ8uAec2asA
         oMFaxK+ZONIbqBckItp4tmC/JffJxLPFqc3n8xfGBDgA2zZIdYo3wVIFtNyCuslIQyGu
         RH1HIOyUdkctoy4tFKHvnt6tcUmbWfFVSwwerxIQMISbahh/e9h0fnU4IQItJbfg8jJR
         ECGL9CwB7evsCooM0VDSLVXaNWROmVOitGkjSkYGAnBSUZ65+Q4BVhNXBMa7rbwAuZ2B
         jPuVTBxvFlkyjwfBNFwmqs4cf3ma4ZD2RgiCUx0ig5wyWCEjMkPG3qFZ8fTbTckxO/pE
         UfVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716214635; x=1716819435;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nXWQb2sKPFqVRDv3f0da66A+zIbGZeLQHEJBZKGaXc=;
        b=IevAbI9R2m6srCWljrWxK1+XRf5oqaTmgNxJBzDDbdh63TZBYlb9MmAt+XQF5kUYXy
         2vqdMpkaNmlYDqJPKbvyFUQKV8vHxXs+qcXSRG3ht8ZPDgblbQWsvxo6VdmqC/pUMCiK
         MUT+vfJ82j6aysXhxr1c69CD4WVCYbj3sVRbKOy3UJfQfiVp7R3lGuDXhMHUnByIuwcJ
         rlgI78seBAySgE9806gbhjsSHi5EBCQts2nHiTBS+rjpwzoYtZ/uoeWI0VNxA8rLbQ3V
         vhSxfFN3c8f91L8gLBtWRQBXB1uwmnBBFWlMEGcScgzEEHIo/IMUKsqj49NaxRck/wkA
         xQRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVK48jvBqoslW5CrxMo5Foc56GjM3pHSjYM9l6m3qERXRlC0//zYZxVPBhSvgHXl1Fb1hL0oKm+JldOwMbmrtWizum2qOsDp87kDBkl
X-Gm-Message-State: AOJu0YzrrfYf8qwTZKi/mqPx0NWMhLaPwG0RppPBm1I0/2Hs30myFjX2
	3UehJFdUgRtXkcuaE9f5Trh2RC+1r86bdIWcM0/lDB65PJ4GASXSH4i4kxGuicvjWKSrw/C/zUZ
	yzQ==
X-Google-Smtp-Source: AGHT+IHwMXt192TPGhL3U5rdQ2PwvxoxqMmzncGJqWtT/05Cf/3rlm06Qlo4R17hQxuN53Ihxriaw7U0VAk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:3a0f:b0:6ea:88cd:67e9 with SMTP id
 d2e1a72fcca58-6f4e0376006mr1467282b3a.4.1716214634726; Mon, 20 May 2024
 07:17:14 -0700 (PDT)
Date: Mon, 20 May 2024 07:17:13 -0700
In-Reply-To: <20240518150457.1033295-1-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <58492a1a-63bb-47d2-afef-164557d15261@redhat.com> <20240518150457.1033295-1-michael.roth@amd.com>
Message-ID: <ZktbBRLXeOp9X6aH@google.com>
Subject: Re: [PATCH] KVM: SEV: Fix guest memory leak when handling guest requests
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <mdroth@utexas.edu>
Cc: pbonzini@redhat.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ashish.kalra@amd.com, thomas.lendacky@amd.com, rick.p.edgecombe@intel.com
Content-Type: text/plain; charset="us-ascii"

This needs a

  From: Michael Roth <michael.roth@amd.com>

otherwise Author will be assigned to your @utexas.edu email.

On Sat, May 18, 2024, Michael Roth wrote:
> Before forwarding guest requests to firmware, KVM takes a reference on
> the 2 pages the guest uses for its request/response buffers. Make sure
> to release these when cleaning up after the request is completed.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---

..

> @@ -3970,14 +3980,11 @@ static int __snp_handle_guest_req(struct kvm *kvm, gpa_t req_gpa, gpa_t resp_gpa
>  		return ret;
>  
>  	ret = sev_issue_cmd(kvm, SEV_CMD_SNP_GUEST_REQUEST, &data, fw_err);
> -	if (ret)
> -		return ret;
>  
> -	ret = snp_cleanup_guest_buf(&data);
> -	if (ret)
> -		return ret;
> +	if (snp_cleanup_guest_buf(&data))
> +		return -EINVAL;

EINVAL feels wrong.  The input was completely valid.  Also, forwarding the error
to the guest doesn't seem like the right thing to do if KVM can't reclaim the
response PFN.  Shouldn't that be fatal to the VM?

> -	return 0;
> +	return ret;

I find the setup/cleanup split makes this code harder to read, not easier.  It
won't be pretty no matter waht due to the potential RMP failures, but IMO this
is easier to follow:

	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
	struct sev_data_snp_guest_request data = {0};
	kvm_pfn_t req_pfn, resp_pfn;
	int ret;

	if (!sev_snp_guest(kvm))
		return -EINVAL;

	if (!PAGE_ALIGNED(req_gpa) || !PAGE_ALIGNED(resp_gpa))
		return -EINVAL;

	req_pfn = gfn_to_pfn(kvm, gpa_to_gfn(req_gpa));
	if (is_error_noslot_pfn(req_pfn))
		return -EINVAL;

	ret = -EINVAL;

	resp_pfn = gfn_to_pfn(kvm, gpa_to_gfn(resp_gpa));
	if (is_error_noslot_pfn(resp_pfn))
		goto release_req;

	if (rmp_make_private(resp_pfn, 0, PG_LEVEL_4K, 0, true)) {
		kvm_release_pfn_clean(resp_pfn);
		goto release_req;
	}

	data.gctx_paddr = __psp_pa(sev->snp_context);
	data.req_paddr = __sme_set(req_pfn << PAGE_SHIFT);
	data.res_paddr = __sme_set(resp_pfn << PAGE_SHIFT);
	ret = sev_issue_cmd(kvm, SEV_CMD_SNP_GUEST_REQUEST, &data, fw_err);

	if (snp_page_reclaim(resp_pfn) ||
	    rmp_make_shared(resp_pfn, PG_LEVEL_4K))
		ret = ret ?: -EIO;
	else
		kvm_release_pfn_dirty(resp_pfn);
release_req:
	kvm_release_pfn_clean(req_pfn);
	return ret;


