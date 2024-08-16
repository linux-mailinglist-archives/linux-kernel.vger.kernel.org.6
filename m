Return-Path: <linux-kernel+bounces-290362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA599552B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 23:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C0EA1C2429C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 21:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A811C579A;
	Fri, 16 Aug 2024 21:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3WYXjPSq"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0081C578C
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723845077; cv=none; b=ufinGCCpOD5p9DpTmkfsqzrK6fw+PZb80xNS5ggkGbVkmIf9cvgjoiqeIqcu/rPZt3SqLXdUg/qXOPi2B3Q8iLpbrkL4Iwd/Kp4J40kIa7O8d8wgqrsi0GZ/LbLmROxLQWdYUZN91OM1iym5Da41uUYvGxK0uLPLX+nmi/4jtXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723845077; c=relaxed/simple;
	bh=KBd6sqjPUrDj4KtyJBS+inkODx/JwJeDXwPuU1WiGQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MZKJS85y15+dtDR0x/V/L+JVPGAt9GdjN3zEtIGfnksTsg8eh6nlWmnAvCvJnktdCaLWYLZ0qcRFYQ1/2JuyxIeRAqHLvzcQ68CU0bFcAl024HjRhH8aENqs0P6oaXPCVFP2x+XjSEKLySOFvcKiYz2Jcjfk3m3Uc/3yin8KNks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3WYXjPSq; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a83869373b6so222881266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 14:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723845074; x=1724449874; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tSoLT3jQSFrMPTRX3f3E09PU/Z1+sySUyTnEKJFhXh4=;
        b=3WYXjPSqrTs0rJGXiNrUlbZtxuWzjST8XzePU4ScRElh40fv0VxybEsk0hW8DrYeeV
         eKhQDkHQklmoIg+yeOQEkZAP+jkofxOdMIGdO1o8mx87RsR5CTIYPveB1Xced3ZdetNw
         JN7RI3hWwcwwUkB1FFIjikSCbvGwaGbI+zqy7SmeHrGrPgzatOaZ7KMiix66RTkDCgjf
         O+u3OnMsRQwki1giy3gwoqH7r0L9EZHZUC5De0yw/nWTPmcB85hDSTQtttEM2eTJbrvS
         ETRBfNeWjwZfMawt64z2MTP/1lfn3vDTpz582fsKtHPvdd9mfOwDZIp5wOzROgjQg1sx
         bGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723845074; x=1724449874;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tSoLT3jQSFrMPTRX3f3E09PU/Z1+sySUyTnEKJFhXh4=;
        b=JsKebHMa0HUpZrB+hGI3l85pPBfQU23NN3Gu6nUfi/KFm0FTZruV4w6L9rpfExcIJF
         pfwADBlbn6sgVuQJXo5dpCsN4RROzKCAY8XBDS4/z8tWeaUEt5Qr3TFfpBNvW3eCJuWy
         f54TCJEzwnJ8qwpBbHz/GCSsr/8XVVlppFkkV5LcbsPz+auw6OlpcV2teauH+0+YbHVH
         oPyVSjOxZjq4tpNdYyAvtcL38ionPmxlFCa1ipLrn5C2lOo3ENyU0+2DPu8prwtpjB/X
         Ov+oZeLezAS4/7v0Qrz55jYJ/woEGCIGorXFCXqSKh9kXN9vw6Sv3qpTM4m/wo4yXTEU
         H2kg==
X-Forwarded-Encrypted: i=1; AJvYcCWKgDRPctvvi8/E90AZY+m9UWnmkbWQzEXKJA57X7YRJ6QXnzdiMHLpctIQrCc407rdqGWCeXZWDe7IAh2Fzt3wvoBX1XhpUhijkZZn
X-Gm-Message-State: AOJu0YzJTyxaz+7edGBelXe0V/D1K5hTdB1fuAEoQMH8l1+Tx94N7q7c
	HSF7tCvp1Rf4QROXydlBsojLB7xD6fUiDPSwPXdBmY/Y5Ll3FVI9fQF+rxcOzgrnNGl+9aakT96
	KyFjMLvbQ50slW+hUCk7+LXOigZ58v2RvSUBn
X-Google-Smtp-Source: AGHT+IEmc4kaoUmyndexzsa7RrjVkpBN/O6EN0guPJoo2EGRzlWVfpPIGDGKEfKmK4pOF9srqCEqaC5Eq+aT59GDm8Y=
X-Received: by 2002:a17:907:e2c3:b0:a7a:b1a8:6a2e with SMTP id
 a640c23a62f3a-a839292ff2bmr297152766b.28.1723845073435; Fri, 16 Aug 2024
 14:51:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZkN25BPuLtTUmDKk@google.com> <20240515012552.801134-1-michael.roth@amd.com>
In-Reply-To: <20240515012552.801134-1-michael.roth@amd.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Fri, 16 Aug 2024 14:50:59 -0700
Message-ID: <CAAH4kHb03Una2kcvyC3W=1ZfANBWF_7a7zsSmWhr_r9g3rCDZw@mail.gmail.com>
Subject: Re: [PATCH] KVM: SEV: Replace KVM_EXIT_VMGEXIT with KVM_EXIT_SNP_REQ_CERTS
To: Michael Roth <michael.roth@amd.com>
Cc: seanjc@google.com, kvm@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, 
	jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com, ardb@kernel.org, 
	pbonzini@redhat.com, vkuznets@redhat.com, jmattson@google.com, 
	luto@kernel.org, dave.hansen@linux.intel.com, slp@redhat.com, 
	pgonda@google.com, peterz@infradead.org, srinivas.pandruvada@linux.intel.com, 
	rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com, bp@alien8.de, 
	vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com, tony.luck@intel.com, 
	sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com, 
	jarkko@kernel.org, ashish.kalra@amd.com, nikunj.dadhania@amd.com, 
	pankaj.gupta@amd.com, liam.merwick@oracle.com, papaluri@amd.com
Content-Type: text/plain; charset="UTF-8"

> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -4006,21 +4006,14 @@ static int snp_complete_ext_guest_req(struct kvm_vcpu *vcpu)
>         sev_ret_code fw_err = 0;
>         int vmm_ret;
>
> -       vmm_ret = vcpu->run->vmgexit.req_certs.ret;
> +       vmm_ret = vcpu->run->snp_req_certs.ret;
>         if (vmm_ret) {
>                 if (vmm_ret == SNP_GUEST_VMM_ERR_INVALID_LEN)
>                         vcpu->arch.regs[VCPU_REGS_RBX] =
> -                               vcpu->run->vmgexit.req_certs.data_npages;
> +                               vcpu->run->snp_req_certs.data_npages;
>                 goto out;
>         }

Finally getting around to this patch. Thanks for your patience.

Whether the exit to guest for certs is first or second when getting
the attestation report, the certificates need to be
consistent. Since we don't have any locks held before exiting, and no
checks happening on the result, there's a
chance that a well-intentioned host can still provide the wrong
certificate to the guest when VMs are running and requesting
attestations during a firmware hotload.

Thread 1:
DOWNLOAD_FIRMWARE_EX please
CURRENT_TCB > REPORTED_TCB
(notify service to get a new VCEK cert)
Interrupted

Thread 2:
VM extended guest request in.
Exit to user space
Call SNP_PLATFORM_STATUS to get REPORTED_TCB.
Get certs for REPORTED_TCB for the blob. It's at /x/y/z-REPORTED_TCB.crt.
Interrupted

Thread 1:
I got my VCEK cert delivered for CURRENT_TCB! I'll put it at
/x/y/z-CURRENT_TCB.crt
Great. SNP_COMMIT.
Now both REPORTED_TCB and COMMITTED_TCB to CURRENT_TCB, because that's
the spec. Different reported_tcb here. than in thread 1.
Interrupted

Thread 2:
Get the attestation report. It will be signed by the VCEK versioned to
the newer REPORTED_TCB.
Return to VM guest

VM guest:
My report's signature doesn't verify with the VCEK cert I was given.
Yes, 1-88-COM-PLAIN?

How do we avoid this?
1. We can advise that the guest parses the certificate and the
attestation report to determine if their TCBs match expectations and
retry if they're different because of a bad luck data race.
2. We can add a new global lock that KVM holds from CCP similar to
sev_cmd_lock to sequentialize req_certs, attestation reports, and
SNP_COMMIT. KVM releases the lock before returning to the guest.
  SNP_COMMIT must now hold this lock before attempting to grab the sev_cmd_lock.

I think probably 2 is better.

>
> @@ -4060,12 +4045,9 @@ static int snp_begin_ext_guest_req(struct kvm_vcpu *vcpu)
>          * Grab the certificates from userspace so that can be bundled with
>          * attestation/guest requests.
>          */
> -       vcpu->run->exit_reason = KVM_EXIT_VMGEXIT;
> -       vcpu->run->vmgexit.type = KVM_USER_VMGEXIT_REQ_CERTS;
> -       vcpu->run->vmgexit.req_certs.data_gpa = data_gpa;
> -       vcpu->run->vmgexit.req_certs.data_npages = data_npages;
> -       vcpu->run->vmgexit.req_certs.flags = 0;
> -       vcpu->run->vmgexit.req_certs.status = KVM_USER_VMGEXIT_REQ_CERTS_STATUS_PENDING;
> +       vcpu->run->exit_reason = KVM_EXIT_SNP_REQ_CERTS;

This should be whatever exit reason #define you go with (40), not the
(1) you defined for kvm_snp_exit.

> +       vcpu->run->snp_req_certs.data_gpa = data_gpa;
> +       vcpu->run->snp_req_certs.data_npages = data_npages;
>         vcpu->arch.complete_userspace_io = snp_complete_ext_guest_req;
>
>         return 0; /* forward request to userspace */
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 106367d87189..8ebfc91dc967 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -135,22 +135,17 @@ struct kvm_xen_exit {
>         } u;
>  };
>
> -struct kvm_user_vmgexit {
> -#define KVM_USER_VMGEXIT_REQ_CERTS             1
> -       __u32 type; /* KVM_USER_VMGEXIT_* type */
> +struct kvm_exit_snp {
> +#define KVM_EXIT_SNP_REQ_CERTS         1
> +       __u32 type; /* KVM_EXIT_SNP_* type */

I think this whole struct should be removed since we're only doing the
one exit reason. This is unused.
You also double-#define the return value preprocessor directives.

>  };
> @@ -198,7 +193,7 @@ struct kvm_user_vmgexit {
>  #define KVM_EXIT_NOTIFY           37
>  #define KVM_EXIT_LOONGARCH_IOCSR  38
>  #define KVM_EXIT_MEMORY_FAULT     39
> -#define KVM_EXIT_VMGEXIT          40
> +#define KVM_EXIT_SNP_REQUEST_CERTS 40

Probably we should just make this KVM_EXT_SNP_REQ_CERTS so the rest of
the code works.
>
>  /* For KVM_EXIT_INTERNAL_ERROR */
>  /* Emulate instruction failed. */
> @@ -454,8 +449,16 @@ struct kvm_run {
>                         __u64 gpa;
>                         __u64 size;
>                 } memory_fault;
> -               /* KVM_EXIT_VMGEXIT */
> -               struct kvm_user_vmgexit vmgexit;
> +               /* KVM_EXIT_SNP_REQ_CERTS */
> +               struct {
> +                       __u64 data_gpa;
> +                       __u64 data_npages;
> +#define KVM_EXIT_SNP_REQ_CERTS_ERROR_INVALID_LEN   1
> +#define KVM_EXIT_SNP_REQ_CERTS_ERROR_BUSY          2
> +#define KVM_EXIT_SNP_REQ_CERTS_ERROR_GENERIC       (1 << 31)
> +                       __u32 ret;
> +               } snp_req_certs;
> +
>                 /* Fix the size of the union. */
>                 char padding[256];
>         };
> --
> 2.25.1
>
>


--
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

