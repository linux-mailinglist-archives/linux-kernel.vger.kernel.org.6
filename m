Return-Path: <linux-kernel+bounces-241786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B06927FA1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 03:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97EE6283B97
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 01:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F9C17BAF;
	Fri,  5 Jul 2024 01:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkqqBvpx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A777514AA0
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 01:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720142248; cv=none; b=GcduHXCcWwO6G75Rh0mG4EbsVWZOOh6IbjNn4Cw2qCXCo5xrQXeaKilEtZ9cZ9XHzW8msfQu81gqN2dcKXi0//dEnSlUa7FA6U6UkejhIz7n08O9N0LaMJOzka/LibDPDXxJmqZIrXUpxTFqunTXxH6+Jr3De5yLwt9ip+lkVrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720142248; c=relaxed/simple;
	bh=7KFDUQ4i2KfzsoICKnOvEAIga6Wr9YS9PFL1rZgpsZ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IISRgDawSyTv21xrgrqK6YkrEhOudFJ351KvSy6zuVvYdVA1NIUtl2qpYsv15ml4KmBUgoi2HDltSRvf/5g66X6BH494enitXi6vSXMM/PzPwPE85Y0eaKyrOvREP0Thzi/2FXFFMrv7I1rfJRpzVwmnnwgQNKKubkb0lxE/vxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AkqqBvpx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720142245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zv/K7RimCAw7h/gUAYVzyoMilwvhFYo3U7YRoPRf6MI=;
	b=AkqqBvpx5JS3DjDJNK0aK/tguQA4E30XuP+YR07yAkkuY2SifeoktIEtgCv2CIqYhksFMu
	3FM3Db9x+Lv6wLP78Ub0gvtAfZIgSdqdktjtRt/zUjlQOI5RjACB+MMEZZcgkR1IYTTjAJ
	o4YSYgq+5K7rCnUaM3jx3g6H3KY5ZAU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-aRtJL5veNBW4A-rrGkQd_g-1; Thu, 04 Jul 2024 21:17:24 -0400
X-MC-Unique: aRtJL5veNBW4A-rrGkQd_g-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4460f0951e8so16804811cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 18:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720142243; x=1720747043;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zv/K7RimCAw7h/gUAYVzyoMilwvhFYo3U7YRoPRf6MI=;
        b=mYj6uEhnHqJc1Q7PzZFUzzZ5IMplCrtNeRZVyHJPUQJUDHE/7ezdZtGY6wGHZsajBl
         /A0AUTjEDUEow4tkvIbG4DJL38w9CcPF0R7YLSD9wKwd/NmdGU3/M38HQc66xpxuF0TN
         jLcaErRQqgLFJkw3idYujLezoINnb+0y455YflR1XNtqh02E8L4nI3i87lSwoJqTxMiN
         SD1liEjpadPpN8rVgzaAZmXw+NAIT+OvHjEIr3Pc2FuYMB/njk1itFeGvxEJ0d4n+49/
         +kGzW/RRfCShLV+bi+fbUKtCvQRoS8gVnyLyDdOlThPh0tcSnpYo4fa3cuG4iLGDW89H
         fXAw==
X-Forwarded-Encrypted: i=1; AJvYcCUjkjOcpYOFJsPLHYjcHA6hx1UAM641sIridrTI0UcdLN0HG7A3cw8N8tBFUp+RiZiXwdnz87RP0grsUSaYssoBuxhVKtvTJdrCrNs8
X-Gm-Message-State: AOJu0YxNpAxJEKPRpeCQ2snr0znwncoQKAbYbV28XElbJTw64X/8RhOZ
	rgXuME/jonQ4HIRqXm9qFMO3rD0W/pbickppZcyIeJSk3QXCb9CUnllEKiKsqkapBqWZa9Pv6PP
	XaXoKH25d8h5/0F8G7KIPANW+Ven7xca9adHk/b5QaNh9ZAhSwYDMQY2KFsSQcQ==
X-Received: by 2002:a05:622a:4d:b0:446:5cb4:aee5 with SMTP id d75a77b69052e-447cbf9bd8bmr39804511cf.57.1720142243592;
        Thu, 04 Jul 2024 18:17:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvciF+mekL9iBg4wcfjxsPvLLuu3SDUytKN7W+i5u1R6EpX/zdVmucz/6HcD89Vrn16hFjSA==
X-Received: by 2002:a05:622a:4d:b0:446:5cb4:aee5 with SMTP id d75a77b69052e-447cbf9bd8bmr39804311cf.57.1720142243287;
        Thu, 04 Jul 2024 18:17:23 -0700 (PDT)
Received: from starship ([2607:fea8:fc01:7b7f:6adb:55ff:feaa:b156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44651428177sm65231371cf.40.2024.07.04.18.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 18:17:23 -0700 (PDT)
Message-ID: <5d27e799daf7677a8d26c7769a5d24b6d3459aa2.camel@redhat.com>
Subject: Re: [PATCH v2 13/49] KVM: selftests: Fix a bad TEST_REQUIRE() in
 x86's KVM PV test
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Hou Wenlong
 <houwenlong.hwl@antgroup.com>, Kechen Lu <kechenl@nvidia.com>, Oliver Upton
 <oliver.upton@linux.dev>, Binbin Wu <binbin.wu@linux.intel.com>, Yang
 Weijiang <weijiang.yang@intel.com>, Robert Hoo <robert.hoo.linux@gmail.com>
Date: Thu, 04 Jul 2024 21:17:22 -0400
In-Reply-To: <20240517173926.965351-14-seanjc@google.com>
References: <20240517173926.965351-1-seanjc@google.com>
	 <20240517173926.965351-14-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Fri, 2024-05-17 at 10:38 -0700, Sean Christopherson wrote:
> Actually check for KVM support for disabling HLT-exiting instead of
> effectively checking that KVM_CAP_X86_DISABLE_EXITS is #defined to a
> non-zero value, and convert the TEST_REQUIRE() to a simple return so
> that only the sub-test is skipped if HLT-exiting is mandatory.
> 
> The goof has likely gone unnoticed because all x86 CPUs support disabling
> HLT-exiting, only systems with the opt-in mitigate_smt_rsb KVM module
> param disallow HLT-exiting.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/x86_64/kvm_pv_test.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c b/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
> index 78878b3a2725..2aee93108a54 100644
> --- a/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
> +++ b/tools/testing/selftests/kvm/x86_64/kvm_pv_test.c
> @@ -140,10 +140,11 @@ static void test_pv_unhalt(void)
>  	struct kvm_cpuid_entry2 *ent;
>  	u32 kvm_sig_old;
>  
> +	if (!(kvm_check_cap(KVM_CAP_X86_DISABLE_EXITS) & KVM_X86_DISABLE_EXITS_HLT))
> +		return;
> +
>  	pr_info("testing KVM_FEATURE_PV_UNHALT\n");
>  
> -	TEST_REQUIRE(KVM_CAP_X86_DISABLE_EXITS);
> -
>  	/* KVM_PV_UNHALT test */
>  	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
>  	vcpu_set_cpuid_feature(vcpu, X86_FEATURE_KVM_PV_UNHALT);

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky


