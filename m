Return-Path: <linux-kernel+bounces-448396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4752B9F3F94
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30E2B1881A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AB617758;
	Tue, 17 Dec 2024 00:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2OD3+Ryx"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7956818035
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734396965; cv=none; b=c3BqXB+PQEOyp51LZtJ21uRm4CNwkePqxG0N88MTYwWrJLNyZ00VeEhcZaWgrcB/SEOoYFN8ulYPppNbkQbjO118Ag7SditKTdkJJT7MQqEyRoZCoAm3ZGA7Q69OWqlUDHeaCRVHdxOiIwjbCyJVswm+1cQFLAGsh+gSBxj1tCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734396965; c=relaxed/simple;
	bh=uf4E4ZJTgQPF6jOGDxzd65RkUmi2Y1Z7sZ1ArTxgFO4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JE0MDFLbhkyc713yqE0vK9vvkqjo/LtBRXFbpUpDWvTtTmqZHnJljAAvqSkDEbq355itH8JshmvGqPAEe0vKOQjiZABOt+uuuedJSnFeLu1fLbcw77Z9OPeoVk1oxOd8qiS2/yvBmS1z7Mqf4+20BbCgNjjheFazcgbeEBgJI0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2OD3+Ryx; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7f712829f05so3013837a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734396963; x=1735001763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MnzdvO4O+aRVWsv7vtyrTZtE2PXoqXcmtZNp/Ta2/To=;
        b=2OD3+RyxxnwVTzwiJ/bGElECOXeQiABfyBBjQEtWccpWE6ynUDLs2kq06yxXb1wki/
         nPzo5vpGr7gYFRxp/tBnj/NoRPmMLUdEZvrHW6XuBQ3Bwdb2ioXns03Bwk4+z9CQndHj
         GN7plgJO4qSC16Bu+63Ul8WJccoZmXSoh3whN8jSQY2Jy36x4RdacD+twUYYJ91PwTol
         4hzKDUJkgtX2KBZOAT+a5S4MkWoO7kQQeblL7/8P8j186wMxUD6yvFTUv4VRAvcw/9af
         mS7hQ6ttrEtiNsngPltU23jsVkoatI3STYoAbWXDSllORoOfEkMZqbVEmOzwP91P4oqZ
         hkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734396963; x=1735001763;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MnzdvO4O+aRVWsv7vtyrTZtE2PXoqXcmtZNp/Ta2/To=;
        b=LePuXU0o1DYYjqAzAD2TD9YBM//aFSLAzpU2sfCVd4oNKBvaenQ0oDrkN7BVsxy69+
         Suuv1RcCrEu+b9OftwRpRSGvviKo0Yxzg2/rRGC61eAz5VkFed0nF6eNfhFl2OGBBQ7z
         9QPAMgcOYAWH32PZl+Jff3ByQbOcv8yHM96EQQRXujy3bgfga9pqBTTYcPD6mpXGUEXw
         USHPbdYbbvjOAWY/25Jd7kmBCZ8wXYPh4hlaISS9+TIAEt/cB3EJycd+JC/+r915FQv5
         sUQA8aS2XFLmPeqYyTp4Tt0jC1NZe1x1rLwk/pOUvi/c5Jw9EdfqOVFb3I5AyAQKv7p7
         pHAw==
X-Forwarded-Encrypted: i=1; AJvYcCVG7hw4KXmZcrRJ6PeO5Q+T0zcq10vzKfUNx1LA6+EUUdjd3DVfjI9dsTvUA0GbhQPM0iZGY11s1qi+JyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeXAQVtyDRvhnInxL8EB7CvJBTwEdG6x2r8d1bTRvtnyhpQc2i
	jVEAomPR7r5g62ZWR8g3Mk/meSSmYWiZwphkwh56K7hsJXktuEKBGqeO6yKzOr6bELOrpUYfNpH
	WaA==
X-Google-Smtp-Source: AGHT+IF1QXijwOQWD0T5NlzCUm0zVt9mghGeJcTe6qz+ZScLi9GJ8O/Ko3Tg/egVccM/wve9R64rv6p3J8U=
X-Received: from pjk8.prod.google.com ([2002:a17:90b:5588:b0:2ea:448a:8cd1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3502:b0:2ef:1134:e350
 with SMTP id 98e67ed59e1d1-2f2901b8178mr22389838a91.35.1734396962824; Mon, 16
 Dec 2024 16:56:02 -0800 (PST)
Date: Mon, 16 Dec 2024 16:56:01 -0800
In-Reply-To: <20241206221257.7167-3-huibo.wang@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241206221257.7167-1-huibo.wang@amd.com> <20241206221257.7167-3-huibo.wang@amd.com>
Message-ID: <Z2DMIWqSP3h0cV-F@google.com>
Subject: Re: [PATCH 2/2] KVM: SVM: Provide helpers to set the error code
From: Sean Christopherson <seanjc@google.com>
To: Melody Wang <huibo.wang@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Dhaval Giani <dhaval.giani@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024, Melody Wang wrote:
> @@ -3577,8 +3576,7 @@ static int setup_vmgexit_scratch(struct vcpu_svm *s=
vm, bool sync, u64 len)
>  	return 0;
> =20
>  e_scratch:
> -	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, GHCB_HV_RESP_MALFORMED_INPUT)=
;
> -	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, GHCB_ERR_INVALID_SCRATCH_AREA=
);
> +	svm_vmgexit_bad_input(svm, GHCB_ERR_INVALID_SCRATCH_AREA);
> =20
>  	return 1;
>  }
> @@ -3671,7 +3669,11 @@ static void snp_complete_psc(struct vcpu_svm *svm,=
 u64 psc_ret)
>  	svm->sev_es.psc_inflight =3D 0;
>  	svm->sev_es.psc_idx =3D 0;
>  	svm->sev_es.psc_2m =3D false;
> -	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, psc_ret);
> +	/*
> +	 * psc_ret contains 0 if all entries have been processed successfully

No, it doesn't.

  =E2=80=A2 SW_EXITINFO2 =3D=3D 0x00000000
    The page state change request was interrupted, retry the request.

> +	 * or a reason code identifying why the request has not completed.

Honestly, even if it were correct, this comment does far more harm than goo=
d.
The literal '0' below has nothing to do with the '0' referenced in the comm=
ent,
and so all the comment does is add more confusion.  Furthermore, this is th=
e
wrong place to document SW_EXITINFO2 return codes.  That's the responsibili=
ty of
the call sites and/or individual PSC-specific macros.

This code should instead document the weirdness with PSC's SW_EXITINFO1:

	/*
	 * Because the GHCB says so, PSC requests always get a "no action"
	 * response, with a PSC-specific return code in SW_EXITINFO2.
	 *
	svm_vmgexit_set_return_code(svm, GHCB_HV_RESP_NO_ACTION, psc_ret);

The readers of _this_ code don't care about the individual return codes, th=
ey
care about knowing the semantics of the return itself.

Alternatively, it might even make sense to add a svm_vmgexit_no_action() he=
lper
(along with svm_vmgexit_success()).  There are at least two VMGEXIT types t=
hat
roll their own error codes with NO_ACTION, and it might be better to have t=
he
initial zeroing in sev_handle_vmgexit() use NO_ACTION, e.g.

	/*
	 * Assume no action is required as the vast majority of VMGEXITs don't
	 * require the guest to take action upon success, and initializing the
	 * GHCB for the happy case avoids the need to do so for exits that are
	 * handled via SVM's common exit handlers.
	 */
	svm_vmgexit_no_action(svm, 0);

> +	 */
> +	svm_vmgexit_set_return_code(svm, 0, psc_ret);
>  }
> =20
>  static void __snp_complete_one_psc(struct vcpu_svm *svm)
> @@ -4067,8 +4069,12 @@ static int snp_handle_guest_req(struct vcpu_svm *s=
vm, gpa_t req_gpa, gpa_t resp_
>  		ret =3D -EIO;
>  		goto out_unlock;
>  	}
> -
> -	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, SNP_GUEST_ERR(0, fw_err));
> +	/*
> +	 * SNP_GUEST_ERR(0, fw_err): Upper 32-bits (63:32) will contain the
> +	 * return code from the hypervisor. Lower 32-bits (31:0) will contain
> +	 * the return code from the firmware call (0 =3D success)

Same thing here.  A comment documenting SNP_GUEST_ERR() belongs above the
definition of SNP_GUEST_ERR.  How the "guest error code" is constructed isn=
't
relevant/unique to this code, what's relevant is that *KVM* isn't requestin=
g an
action.

	/*
	 * No action is requested from KVM, even if the request failed due to a
	 * firmware error.
	 */
	svm_vmgexit_set_return_code(svm, GHCB_HV_RESP_NO_ACTION,
				    SNP_GUEST_ERR(0, fw_err));


> +	 */
> +	svm_vmgexit_set_return_code(svm, 0, SNP_GUEST_ERR(0, fw_err));
> =20
>  	ret =3D 1; /* resume guest */
> =20

...

> +static inline void svm_vmgexit_set_return_code(struct vcpu_svm *svm,
> +						u64 response, u64 data)
> +{
> +	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, response);
> +	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, data);
> +}
> +
> +static inline void svm_vmgexit_inject_exception(struct vcpu_svm *svm, u8=
 vector)
> +{
> +	u64 data =3D SVM_EVTINJ_VALID | SVM_EVTINJ_TYPE_EXEPT | vector;
> +
> +	svm_vmgexit_set_return_code(svm, GHCB_HV_RESP_ISSUE_EXCEPTION, data);
> +}
> +
> +static inline void svm_vmgexit_bad_input(struct vcpu_svm *svm, u64 suber=
ror)
> +{
> +	svm_vmgexit_set_return_code(svm, GHCB_HV_RESP_MALFORMED_INPUT, suberror=
);
> +}
> +
> +static inline void svm_vmgexit_success(struct vcpu_svm *svm, u64 data)

As mentioned in patch 1, please keep svm_vmgexit_success() even if
GHCB_HV_RESP_SUCCESS is renamed to GHCB_HV_RESP_NO_ACTION.

> +{
> +	svm_vmgexit_set_return_code(svm, GHCB_HV_RESP_SUCCESS, data);
> +}
> +
>  /* svm.c */
>  #define MSR_INVALID				0xffffffffU
> =20
> --=20
> 2.34.1
>=20

