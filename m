Return-Path: <linux-kernel+bounces-428514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A13E9E0F82
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 01:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 307901625EF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 00:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FA123CE;
	Tue,  3 Dec 2024 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CRSqb8Fz"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A83370
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 00:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733184691; cv=none; b=nuASGkU8BH0Kh67WaQAcUaFgX8atmMGTOvZGLm7vmgFnxMfRRFS2musraUdkDcaGU63TwU7klf8A9eoBNT830pJ9Mz8Bompo8GxpSahgI/omxozRiyBn1HKTFH7+5u1ZNx6JcrXWGKblYQ9BQ3rObytlcWv9UwokBaagYSmNimM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733184691; c=relaxed/simple;
	bh=sXKboPJVhvZm9MRFI/36V/Dw28GUy47CEwhIWBjLPbY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l+WKKkqh6gyHo9kNfFMvrfVxBhEZwPhGwMMcG8qwb61rjKXjHLrUAF53mZiZtH9hrOWqapH/Po2cTWrAMlkvLQrh9rh7+OtugGlcoXpc+kKvJrof+6q76M3RAUN1/hQEqLaV0eNHLpj2PD8ubV++oPnCLFoRulW6PoO6cei8Tec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CRSqb8Fz; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ee948b77c9so3155477a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 16:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733184686; x=1733789486; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HyRCW53Khz052+aBjVdJTpIV/tic2eaOScb3I7IW9MA=;
        b=CRSqb8FzrmuAWOdscMP3vIQJMM4Rj7LdFaopny6c7dxfliIUhoUbLZE9UcgF9uOcvn
         Z7RiReBQgMrQIZ8HrXRWt4joLEAtFjeJ+YA+XXHQPb7oRg98ftrNHJVsNUixqBRlmqhb
         mExBYQg3VKIanfuuankQ2nPKclXuaLWrOc8tlVSVzePKazABlw8VgTIkE3JNpeNifN0+
         nQLDrQIpkedwMiEpRNxqCtqVzwHLBtY3UQfZaGzV2Q0P11hfAaLW1hazBkueCCEn4QjA
         Z34l05U0ztwUqkPgC2rHA3RiNAV5U/FIFegWyyUP56f8Ug0NzOInH1AOo5s6TBA3Ps+g
         dyLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733184686; x=1733789486;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HyRCW53Khz052+aBjVdJTpIV/tic2eaOScb3I7IW9MA=;
        b=fZdpoLZXDS6dwEgX/sv5uFl3KATJahUSU6NCE7+5Pbx6I5mPN5UVMO/s9k1qgcnf9G
         qaf6UdOG3rx+NDR0y8Cl1GFRN0OSxpeg+4Zc5lXHT85ccnSjj66/1eZdi0GiRpEY9/xG
         PfNGTz2BK7nMvW1f7Sa7niAemrRto9ffgS7lC99qMlUzkaeQPvO0qk5LyQS7iUXua8O5
         +Hs8osFSwU8pYkQeJ2m9UBHz7LBdI9c+BMr/ahkckhxbFqeu/8ZG4b4xxYguGIybfDpJ
         PEsgUFOToURUcbmOmeIrMCjCgtLuTucBu35YjnX6bhX1eYE6rD9nrxd7mxynOVOTBEgm
         pHNA==
X-Gm-Message-State: AOJu0YzoIwsU6Bf3FYXtKSJzJM3HwFxkLU3D0Sv5jScB1s9q575gb8yf
	LJGVG/9pHEHAqi9R5x+5qRNc6iivB8SbtNd7s+4YjzL3kmCgO7l2t+eZMHkRUIaqnBVpfuttQz0
	+kg==
X-Google-Smtp-Source: AGHT+IE0tU8DEKdjyyKwq8TT/+CTYk5YYD3SCO3wVYP2c5+AmdEw/3xZ/gG660l3MPLAuKDqsSbFdwWOb9Q=
X-Received: from pjbsz16.prod.google.com ([2002:a17:90b:2d50:b0:2e2:44f2:9175])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:380c:b0:2ee:ab29:1482
 with SMTP id 98e67ed59e1d1-2ef011ff673mr894137a91.16.1733184686643; Mon, 02
 Dec 2024 16:11:26 -0800 (PST)
Date: Mon, 2 Dec 2024 16:11:25 -0800
In-Reply-To: <20241202214032.350109-1-huibo.wang@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241202214032.350109-1-huibo.wang@amd.com>
Message-ID: <Z05MrWbtZQXOY2qk@google.com>
Subject: Re: [PATCH v2] KVM: SVM: Convert plain error code numbers to defines
From: Sean Christopherson <seanjc@google.com>
To: Melody Wang <huibo.wang@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Tom Lendacky <thomas.lendacky@amd.com>, KVM <kvm@vger.kernel.org>, 
	Pavan Kumar Paluri <papaluri@amd.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Dec 02, 2024, Melody Wang wrote:
> Convert VMGEXIT SW_EXITINFO1 codes from plain numbers to proper defines.
> 
> No functionality changed.
> 
> Signed-off-by: Melody Wang <huibo.wang@amd.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Reviewed-by: Pavan Kumar Paluri <papaluri@amd.com>
> ---
>  arch/x86/include/asm/sev-common.h |  8 ++++++++
>  arch/x86/kvm/svm/sev.c            | 12 ++++++------
>  arch/x86/kvm/svm/svm.c            |  2 +-
>  3 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/include/asm/sev-common.h b/arch/x86/include/asm/sev-common.h
> index 98726c2b04f8..01d4744e880a 100644
> --- a/arch/x86/include/asm/sev-common.h
> +++ b/arch/x86/include/asm/sev-common.h
> @@ -209,6 +209,14 @@ struct snp_psc_desc {
>  
>  #define GHCB_RESP_CODE(v)		((v) & GHCB_MSR_INFO_MASK)
>  
> +/*
> + * Error codes of the GHCB SW_EXITINFO1 related to GHCB input that can be
> + * communicated back to the guest
> + */
> +#define GHCB_HV_RESP_SUCCESS		0
> +#define GHCB_HV_RESP_ISSUE_EXCEPTION	1
> +#define GHCB_HV_RESP_MALFORMED_INPUT	2
> +
>  /*
>   * Error codes related to GHCB input that can be communicated back to the guest
>   * by setting the lower 32-bits of the GHCB SW_EXITINFO1 field to 2.
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 72674b8825c4..e7db7a5703b7 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -3433,7 +3433,7 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
>  		dump_ghcb(svm);
>  	}
>  
> -	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, 2);
> +	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, GHCB_HV_RESP_MALFORMED_INPUT);
>  	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, reason);

Hmm, IMO, open coding literals in multiple locations is a symptom of not providing
helpers.  From a certain (slightly warped) perspective, setting exit_info_1 vs.
exit_info_2 is just weird version of an open coded literal.

Rather than provide macros (or probably in addition to), what if we provide helpers
to set the error code and the payload?  That would also ensure KVM sets both '1'
and '2' fields.  E.g. in sev_handle_vmgexit()'s SVM_VMGEXIT_AP_JUMP_TABLE path,
setting '2' but not '1' is mildly confusing at first glance, because it takes some
staring to understand that's it's NOT a failure path.  Ditto for
sev_vcpu_deliver_sipi_vector().

And IMO, not having to parse input parameters to understand success vs. failure
usually makes code easier to read.

E.g. something like this?  Definitely feel free to suggest better names.

static inline void svm_vmgexit_set_return_code(struct vcpu_svm *svm,
					       u64 response, u64 data)
{
	ghcb_set_sw_exit_info_1(svm->sev_es.ghcb, response);
	ghcb_set_sw_exit_info_2(svm->sev_es.ghcb, data);
}

static inline void svm_vmgexit_inject_exception(struct vcpu_svm *svm, u8 vector)
{
	u64 data = SVM_EVTINJ_VALID | SVM_EVTINJ_TYPE_EXEPT | vector;

	svm_vmgexit_set_return_code(svm, GHCB_HV_RESP_ISSUE_EXCEPTION, data);
}

static inline void svm_vmgexit_bad_input(struct vcpu_svm *svm, u64 suberror)
{
	svm_vmgexit_set_return_code(svm, GHCB_HV_RESP_MALFORMED_INPUT, suberror);
}

static inline void svm_vmgexit_success(struct vcpu_svm *svm, u64 data)
{
	svm_vmgexit_set_return_code(svm, GHCB_HV_RESP_SUCCESS, data);
}

