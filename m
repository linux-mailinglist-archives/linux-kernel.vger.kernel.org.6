Return-Path: <linux-kernel+bounces-311574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6291C968A9C
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CC2283635
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC18719F105;
	Mon,  2 Sep 2024 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PR0ECwNO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289771CB538
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725289527; cv=none; b=RD2wXkVzV/AeXmjP57wRXZxvmKG4UYVzmNBZtUerLiMBpizBJm39yInHwaoVRwLmw7eT7xsy/zsYoCFKbw1MDQ3JTJ3h9biUcH+PEiZ9hXngIyGvluzpej2ReBcHW6ky27uE39iZn5im00pW5HhwvN2UaaVYqL4rHgeo3OF3cv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725289527; c=relaxed/simple;
	bh=k0/DqNn6r0hvbqjOGsbxJs9bNKNoTLtYp0jpsW3kue0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Shir/bIlgjVWLXtDU/uAW24fbqGCQ15QEaIWI1WIOYtjz/VPdMVJfigSSh8Fydha/l8+ZwDlfq0vMsuir0O+RjBada0YktswDtHmLUrrTgWE8BKddyqJ6YGbvBeovOSMBsSBzwNAany+F9/JM2vwMMKIbtxixuT0ZfizLgC2lZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PR0ECwNO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725289524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ziH5RycTQIYEsjONg+GaJvTnZD1q/SgNIqzqcE498lo=;
	b=PR0ECwNOpesYja2qQn+UlwfxAjGONnF+RCuLIBPWtGSrOjF0z/0CfCF3LLQIZUzIjlfAzH
	lQCn+Zy1cp7oL0Xx/JFFMy/umbwi9C7kwk6piMww9p+g064awyNLrQYS53hLl6himwWsfB
	WmhMh8/HUyKMmKsfDaGseht7LqWToMA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-5KO2tlqhOqWBfSwwxzs4rQ-1; Mon, 02 Sep 2024 11:05:23 -0400
X-MC-Unique: 5KO2tlqhOqWBfSwwxzs4rQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2d8759255d4so3322062a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 08:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725289522; x=1725894322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziH5RycTQIYEsjONg+GaJvTnZD1q/SgNIqzqcE498lo=;
        b=Q/ptrw9tp1f0iO1TgTPS4y4pfq8Yd3QBeIVDkYbhoLj504hB19H3L+vFNacbjzH48D
         X0hzk4FdqkETyRw1rXabz74lKoR/lFBmuJniLOekTJ57xX1AqqzdAL+JVPbBMJpsw38g
         9q1EIUv+D9KKYdhp878ELqwOTv3ef4U+d+UC/spjJd+69Ujo2kO2FbePUrk7mU7Kdinh
         PSKJct61T2HpD2PIgCp527xkVpbkJpy08X3WVJsAEwJK6cUX1ZS1h057h7i4el2MpVrD
         lyRfv15jAa+YlipGDgUzFvbhdUd/qQU+F/xILolzTfEyWy6ipnQfNM4FRI+IVAsui2v3
         wxyg==
X-Forwarded-Encrypted: i=1; AJvYcCXfdjLEppYM8+lWgnv/OivWbrNaXLV5jAyUzS0VnXUS3nD4J0bCdMxh/kyFvB2nbu8pHpB5JqOmbM8FvWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm3VP/8dZfVOLsy58pwa4yCGq+Symyv4s0kOKcemADFUPAsO2f
	rv+Hi6gHWaqesb7ewgLyD4DmTpLGxY6cMSYGL5gx/MwR1hxdadwo3l4YxoJoYSuSPJN0G/q8z/N
	sAg4+yPpOCY9bl4wzixOFT/Lxaw3yXXrsTrK2IKsCA6l8MeNGOK6m5pcA6N0amuU/lJnzfUPVoM
	JRVU/UiWOzifCSY5aIMQoTr+Tc+GcwE9tfps6n
X-Received: by 2002:a17:90a:8d07:b0:2d8:27c1:1d4a with SMTP id 98e67ed59e1d1-2d88d6dbadbmr8803280a91.24.1725289522154;
        Mon, 02 Sep 2024 08:05:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0yHTmMgIu13OPCtaJjdH70dJqkGRaPQI7+UUIjnFKNKjMRWxvi7+frXfjTnChdUxzt4MQr6gq2Zp/Dq3TmBk=
X-Received: by 2002:a17:90a:8d07:b0:2d8:27c1:1d4a with SMTP id
 98e67ed59e1d1-2d88d6dbadbmr8803237a91.24.1725289521719; Mon, 02 Sep 2024
 08:05:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827203804.4989-1-Ashish.Kalra@amd.com>
In-Reply-To: <20240827203804.4989-1-Ashish.Kalra@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 2 Sep 2024 17:05:08 +0200
Message-ID: <CABgObfZMQ1qcQf-XLZaPGFzmbtoe3gGuMvXF-N0qo_5Z9jf+vg@mail.gmail.com>
Subject: Re: [PATCH] x86/sev: Fix host kdump support for SNP
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: seanjc@google.com, dave.hansen@linux.intel.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com, 
	peterz@infradead.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	thomas.lendacky@amd.com, michael.roth@amd.com, kexec@lists.infradead.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 10:40=E2=80=AFPM Ashish Kalra <Ashish.Kalra@amd.com=
> wrote:
> +void snp_decommision_all(void)

Should be spelled snp_decommission_all (with two "s").

> +static DEFINE_SPINLOCK(snp_decommision_lock);

Same here.

>  /*
>   * Only MSR_TSC_AUX is switched via the user return hook.  EFER is switc=
hed via
>   * the VMCB, and the SYSCALL/SYSENTER MSRs are handled by VMLOAD/VMSAVE.
> @@ -594,9 +597,97 @@ static inline void kvm_cpu_svm_disable(void)
>
>  static void svm_emergency_disable(void)
>  {
> +       static atomic_t waiting_for_cpus_synchronized;
> +       static bool synchronize_cpus_initiated;
> +       static bool snp_decommision_handled;

Same here, and below throughout the function (also SNP_DECOMMISSION).

Please create a new function sev_emergency_disable(), with a stub in
svm.h if CONFIG_KVM_AMD_

> @@ -749,6 +749,7 @@ void sev_snp_init_protected_guest_state(struct kvm_vc=
pu *vcpu);
>  int sev_gmem_prepare(struct kvm *kvm, kvm_pfn_t pfn, gfn_t gfn, int max_=
order);
>  void sev_gmem_invalidate(kvm_pfn_t start, kvm_pfn_t end);
>  int sev_private_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn);
> +void snp_decommision_all(void);
>  #else
>  static inline struct page *snp_safe_alloc_page_node(int node, gfp_t gfp)
>  {
> @@ -779,7 +780,7 @@ static inline int sev_private_max_mapping_level(struc=
t kvm *kvm, kvm_pfn_t pfn)
>  {
>         return 0;
>  }
> -
> +static void snp_decommision_all(void);

This should be inline (and after the change above it should be
sev_emergency_disable(), not snp_decommission_all(), that is exported
from sev.c).

Thanks,

Paolo


