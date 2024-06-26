Return-Path: <linux-kernel+bounces-230956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E788918449
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 16:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01DE91F281A5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 14:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B549DC136;
	Wed, 26 Jun 2024 14:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r3EQgpPh"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79E7186E36
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412356; cv=none; b=Wfb5gqdgobyDcyirlQ9fxbnnSRH8l62LEsv2vtkfO9cl8G/MSmb8DoUUTgxIJab00Rf8osbl7P50fzJy6ykQlgLejjSTpi0Ykax9A9rmezkk2xkwnKteyt83xSnEQL0DPzOFhp9z5L3d+l7fFGCoT/Mww9aQA9SdK6B39Ka9ze0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412356; c=relaxed/simple;
	bh=ZNPzGDrViZtN+euOTYNGNCvhSBpNIjiT+sYwF77Gmis=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TmkSHCpMvo2XMvgoN+qIduKVXna4NyAUycvzwkP3sbAYF3xAEgHq/TRXy5HOyyFydatycKggNxxe8wy+2Y2X/PrErAKEBFw6MTTF6KNAhgXjvUv+z4BIPvLdgOQysO1Jul483LXM9axngqnrlxtYKjHp7GC4ggmcdCzXVlgipDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r3EQgpPh; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2c7c3401dfdso8589888a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 07:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719412354; x=1720017154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ymlm/4AWkUfS196/Og/rjOQ+iw7EfhnrK5+wBxuoc0=;
        b=r3EQgpPhbMAZDPicDQ3ZsPOiFCPTrsN2u/NcGmyFf7CpG/LVOz3H7ylimnT8bO0XBN
         iJItMVsoJwTJv62TDBC33A35xodVouHtKVmyZ+hBCF5PdQPcsp85YaoWDR8ih/7QRba2
         sLi9q9SfbZAaiJpzbrls3CUbghkRy9DALQVIgzsmhvPl6/PnBuRAPtVVfj67OCcmRm0q
         oXF4/DDIai+aIxWDDVi3ts03HyVYfYPsz8/rDZpkFMkenyYaexMGmgwElmiFX3nCO/61
         +UuuX7VOisxk8A7L6Rp9R1u7/We8sz77Jmb7u4nqJz0IhE2jqDXA/E1b0M5VPZRLuZlt
         fVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719412354; x=1720017154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ymlm/4AWkUfS196/Og/rjOQ+iw7EfhnrK5+wBxuoc0=;
        b=ebimQo/I5UsVQ/6mM5uVvGke2/coqb78p+kNpJAo/sXjhFV/WCZmEv8G1kQ2JrbGsS
         NTrWT4MFzz8pHLdmWQtiVaoBafLFUuYuo0JQaxGhIZBVtQArqtbQAQB2Ju+8ve+OTODY
         1jso+btFpOSLkJ3HupWZrXq3MgncW2w9DPiZZcEGTZjkjCsZVveDhor3oeSduPTUD6yf
         xN8t5tOlZZq4TlKGO9yVkO6FXeUtQHg/y5+DSq4Lwt+BMJnnNQJSRUcbmQf9JqF1Q2k+
         8/7+L2N2V/8cFSyORHXBGEVPgFfQt6zaE9kMC3lJ+hX8iBBPdAoQcpliUhp5l2mBGntN
         Qi4g==
X-Forwarded-Encrypted: i=1; AJvYcCWPfM4wtbDIENGCJEYkmddcbT6J95s0ziPlWlHzyTf5JhHtYG+gELqYjD9FeAPNQG5DWyLqP+sBaZmLicZ8WZfiQCsKIe5jUd8OMxtA
X-Gm-Message-State: AOJu0Yy/Pb0duD5/zK8pIUXCMCv8CMmtKpDe7yLkp0PAlO2cvehNZNv1
	1vfUWEwynwP1fyX62dWQz3CsQsdXljQnwLAgtt8sqwdJG0WwX/YjLuBhBUvLYiWnSxNqTksmG4w
	iEw==
X-Google-Smtp-Source: AGHT+IHoLpy1haJfmM+o0LmD5U1iZh86EBvuJ5rgP0o2pdMh09BBK9/6PtMelrlOW3VGdks0UySW+x/E2qQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90a:e7c4:b0:2c2:c6fa:c05d with SMTP id
 98e67ed59e1d1-2c86147a695mr30306a91.9.1719412353662; Wed, 26 Jun 2024
 07:32:33 -0700 (PDT)
Date: Wed, 26 Jun 2024 07:32:32 -0700
In-Reply-To: <20240621171519.3180965-1-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240621134041.3170480-2-michael.roth@amd.com> <20240621171519.3180965-1-michael.roth@amd.com>
Message-ID: <ZnwmgHYWQQ4DP176@google.com>
Subject: Re: [PATCH v1-revised 1/5] KVM: SEV: Provide support for
 SNP_GUEST_REQUEST NAE event
From: Sean Christopherson <seanjc@google.com>
To: Michael Roth <michael.roth@amd.com>
Cc: kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, x86@kernel.org, pbonzini@redhat.com, 
	jroedel@suse.de, thomas.lendacky@amd.com, pgonda@google.com, 
	ashish.kalra@amd.com, bp@alien8.de, pankaj.gupta@amd.com, 
	liam.merwick@oracle.com, Brijesh Singh <brijesh.singh@amd.com>, 
	Alexey Kardashevskiy <aik@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jun 21, 2024, Michael Roth wrote:
> diff --git a/include/uapi/linux/sev-guest.h b/include/uapi/linux/sev-guest.h
> index 154a87a1eca9..7bd78e258569 100644
> --- a/include/uapi/linux/sev-guest.h
> +++ b/include/uapi/linux/sev-guest.h
> @@ -89,8 +89,17 @@ struct snp_ext_report_req {
>  #define SNP_GUEST_FW_ERR_MASK		GENMASK_ULL(31, 0)
>  #define SNP_GUEST_VMM_ERR_SHIFT		32
>  #define SNP_GUEST_VMM_ERR(x)		(((u64)x) << SNP_GUEST_VMM_ERR_SHIFT)
> +#define SNP_GUEST_FW_ERR(x)		((x) & SNP_GUEST_FW_ERR_MASK)
> +#define SNP_GUEST_ERR(vmm_err, fw_err)	(SNP_GUEST_VMM_ERR(vmm_err) | \
> +					 SNP_GUEST_FW_ERR(fw_err))
>  
> +/*
> + * The GHCB spec only formally defines INVALID_LEN/BUSY VMM errors, but define
> + * a GENERIC error code such that it won't ever conflict with GHCB-defined
> + * errors if any get added in the future.
> + */
>  #define SNP_GUEST_VMM_ERR_INVALID_LEN	1
>  #define SNP_GUEST_VMM_ERR_BUSY		2
> +#define SNP_GUEST_VMM_ERR_GENERIC	BIT(31)

Related to my suggestion to not have KVM-defined error codes, if we go that route,
then I believe SNP_GUEST_VMM_ERR_GENERIC is unnecessary.

For snp_handle_guest_req(), if sev_issue_cmd() fails, KVM can/should do something
like:

	/* Forward non-firmware errors to userspace, e.g. if the PSP is dead. */
	if (ret && !fw_err)
		goto release_req;

	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, SNP_GUEST_ERR(0, fw_err));

And then in snp_complete_req_certs(), we could either let userspace shove in any
error code whatsoever, or restrict userspace to known, GHCB-defined error codes,
e.g.
	int err;

	err  = READ_ONCE(vcpu->run->coco.req_certs.ret);
	if (err)
		if (err != SNP_GUEST_VMM_ERR_INVALID_LEN &&
		    err != SNP_GUEST_VMM_ERR_BUSY)
			return -EINVAL;

		if (err == SNP_GUEST_VMM_ERR_INVALID_LEN)
			vcpu->arch.regs[VCPU_REGS_RBX] = vcpu->run->coco.req_certs.npages;

		ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, SNP_GUEST_ERR(err, 0));
		return 1;
	}


>  
>  #endif /* __UAPI_LINUX_SEV_GUEST_H_ */
> -- 
> 2.25.1
> 

