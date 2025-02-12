Return-Path: <linux-kernel+bounces-510387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76767A31C16
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 03:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B62161039
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 02:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A9A1D5143;
	Wed, 12 Feb 2025 02:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XMCQ5w2a"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE99378F4E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 02:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739327507; cv=none; b=IgsFwzuYJdEr8V7LYPhGEyLoDMhc4+T4k5jZS2eUA8jN6l3ImoBgXTLLpaNKDVYVk1RWAidZGRi2yBd+yRWxUifMfzxFz7naLdRGVOZYaP4gV18oL8iJEcxwnX9L+0NKNPAmgGS+3jYivhnz1fcQf1nm8HHN38LRAxA//bFPZG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739327507; c=relaxed/simple;
	bh=/xVLIbnBID19pVlqnJua6JU9LCMU9qjYDj0RqS1xVgc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mWm08/bCKx/ZzzLVOM63mNJDEPHW666nfQdI9r//gDLS3vPoeKmIUkzMPjo/q87hQWBolnBus6tBdSqCQ4oll0XSS+fSDyL7M/u+MeJSZ/tgOtH5TQV3GgI6z7t0/oiu5iu3B2fAM2R+hALilbV7j9bAhfp4PV6HNo/LVRU1l/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XMCQ5w2a; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2fa440e16ddso8300241a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 18:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739327504; x=1739932304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vPRb0IsRdvCLk95iJ9DvUJH0LJh/0xdqXsVtoHsQUsQ=;
        b=XMCQ5w2agmlYv1s0pdi7t182NBsKWVRQWC2FKVwRvkwm3y/AL3HSvSfBaosrMIIivI
         3rZSbBi93tSybljuoxp+P6VId+R47ZiRcmthPecAGnxXijT6ENxJRJt1KpspZE1skV5x
         rapOU6yl/LlVmyAXlH+y/DG+5f823a3U5WTDkONfvU35oZeWOU7Czuxl/36dYnMleOAA
         oe4QbvocdqVYS3quW7FEAE8ukVdj7ULI3J2AXq6jwAuuwj8HiuopMe4W4S1Mqaf5QsO9
         Chix6cRJfc6shn+KepOWopI0bpfY4+WnH3Ovt6ehIbbPgd5rw/FSOiQ0nzcy3XdhhEPb
         k2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739327504; x=1739932304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPRb0IsRdvCLk95iJ9DvUJH0LJh/0xdqXsVtoHsQUsQ=;
        b=HB0fIfogjQld0XuRm4a+ZcisPAJc3/wzFidpmkRSQN4jyBIa/1tduDuV7qr9htHVpv
         mG/WJanu1XGNNwRJiuVIkpzeqUUxxjORKLZJcbj3KkMcWeu4YwNFe17rl35W833+Mc5H
         ++ZFWVsECYdQVsGlGnLJXUL4TTdWN3xbfsMed3dsNXjClMoNydvWFGmtSaR4Xx5hwG/l
         lrNygGiXiUdifmSbGkVcIypF8+WlrXVWaw2yYlyaAiSYSip3IpRXqMQOfw369Bjp1CqN
         hCVTFpXhV95kLdig1QwvIqBuop2Omovj1AANr6YSVpgJ/ymj+vKnFTS5jXd9+aoZhffe
         2dhQ==
X-Gm-Message-State: AOJu0YwJQy5osrsHZgIqg81hnMD4NJyu6mx8JBmkSFDTSz9V4Z0gONFg
	SowpxVgcMqlVzgRPXRt2Z3fJP6nIZkzriFY+VRA/8TQQbUIGxQexOMK7dvzyxhrawOyQ2027aP7
	U9Q==
X-Google-Smtp-Source: AGHT+IGMX9u7M35FXglCi8he7YjOChUI+hVwPKDefN8wt50qF3YlUo1gLTN02dl5lpemjD008hcqqNreu6U=
X-Received: from pjbpw18.prod.google.com ([2002:a17:90b:2792:b0:2ee:4b69:50e1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:dfcd:b0:2ee:863e:9ffc
 with SMTP id 98e67ed59e1d1-2fbf5c237demr2067501a91.21.1739327504064; Tue, 11
 Feb 2025 18:31:44 -0800 (PST)
Date: Tue, 11 Feb 2025 18:31:42 -0800
In-Reply-To: <20250203223205.36121-10-prsampat@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203223205.36121-1-prsampat@amd.com> <20250203223205.36121-10-prsampat@amd.com>
Message-ID: <Z6wIDsbjt2ZaiX0I@google.com>
Subject: Re: [PATCH v6 9/9] KVM: selftests: Add a basic SEV-SNP smoke test
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org, 
	linux-crypto@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	pbonzini@redhat.com, thomas.lendacky@amd.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, shuah@kernel.org, 
	pgonda@google.com, ashish.kalra@amd.com, nikunj@amd.com, pankaj.gupta@amd.com, 
	michael.roth@amd.com, sraithal@amd.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 03, 2025, Pratik R. Sampat wrote:
> @@ -217,5 +244,20 @@ int main(int argc, char *argv[])
>  		}
>  	}
>  
> +	if (kvm_cpu_has(X86_FEATURE_SEV_SNP)) {
> +		uint64_t snp_policy = snp_default_policy();
> +
> +		test_snp(snp_policy);
> +		/* Test minimum firmware level */
> +		test_snp(snp_policy | SNP_FW_VER_MAJOR(SNP_MIN_API_MAJOR) |
> +			SNP_FW_VER_MINOR(SNP_MIN_API_MINOR));

Ah, this is where the firmware policy stuff is used.  Refresh me, can userspace
request _any_ major/minor as the min, and expect failure if the version isn't
supported?  If so, the test should iterate over the major/minor combinations that
are guaranteed to fail.  And if userspace can query the supported minor/major,
the test should iterate over all the happy versions too. 

Unless there's nothing interesting to test, I would move the major/minor stuff to
a separate patch.

> +
> +		test_snp_shutdown(snp_policy);
> +
> +		if (kvm_has_cap(KVM_CAP_XCRS) &&
> +		    (xgetbv(0) & kvm_cpu_supported_xcr0() & xf_mask) == xf_mask)
> +			test_sync_vmsa_snp(snp_policy);

This is all copy+paste from SEV-ES tests, minus SEV_POLICY_NO_DBG.  There's gotta
be a way to dedup this code.

Something like this?

static void needs_a_better_name(uint32_t type, uint64_t policy)
{
	const u64 xf_mask = XFEATURE_MASK_X87_AVX;

	test_sev(guest_sev_code, policy | SEV_POLICY_NO_DBG);
	test_sev(guest_sev_code, policy);

	if (type == KVM_X86_SEV_VM)
		return;

	test_sev_shutdown(policy);

	if (kvm_has_cap(KVM_CAP_XCRS) &&
	    (xgetbv(0) & kvm_cpu_supported_xcr0() & xf_mask) == xf_mask) {
		test_sync_vmsa(policy);
		test_sync_vmsa(policy | SEV_POLICY_NO_DBG);
	}
}

int main(int argc, char *argv[])
{
	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_SEV));

	needs_a_better_name(KVM_X86_SEV_VM, 0);

	if (kvm_cpu_has(X86_FEATURE_SEV_ES))
		needs_a_better_name(KVM_X86_SEV_ES_VM, 0);

	if (kvm_cpu_has(X86_FEATURE_SEV_SNP))
		needs_a_better_name(KVM_X86_SEV_SNP_VM, 0);

	return 0;
}

