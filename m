Return-Path: <linux-kernel+bounces-314938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8894796BB31
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45AE2282624
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 11:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401D31D221C;
	Wed,  4 Sep 2024 11:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PD0PxEf2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07591D220C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 11:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725450429; cv=none; b=q9FFOy7EdtDJumwmEfTv8cTttuxuAQMbGQoTSe6wqNxfBLcH/17Vihv5R2swSxCQPlK2EIvPXfy/AKMc8dU9Csfx91ncOfR6c6oaJdw9awfUtd/CBF1VcdodR8ozOhln+bxE1SkdAmPNzCRsnltA0WyEA6PZWNjRAHQKFRXnD48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725450429; c=relaxed/simple;
	bh=A8vSwQ2K8dohTK7JtRLsx/MJ9E2P3DAHBXR4jevJPtQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=twcMNBypWdLshxR9RSdi8wuEwbBxFmHPzXcY38G2RKhhefLfyyZxwfAgE0B21GDoHpCOZZiT0Yb0CVxelCphrVNNPTemzjEhD1SnlTaMPYkh9UjzsxuXjuh58A4U3i3dUZKbG26UyP38XEg6AM2dPT1/80xytI6h0U/bxDqsh/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PD0PxEf2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725450426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IFz1z4bpL1jITAk7xtQcrjv0O1jnUDE07Q/HxRcErkE=;
	b=PD0PxEf2nP3BQSTtCZaugE5ngKP6W8VroIlRxeSGZSHPFr/zU+k/K3zWafQ5YIBWh3uHvn
	m0KsJXazrbwpEmvacqSrfTiLjsOeBw1hTJ3QwRoSUshiB5QnK58kQ6egdvZKGeTfXwVXSV
	vTmdtfkh9d00iYDfnMHJ7qWvmAe7mKE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-IBmjNiIGNHyHul_apCSneQ-1; Wed, 04 Sep 2024 07:47:05 -0400
X-MC-Unique: IBmjNiIGNHyHul_apCSneQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374c44e58a9so374536f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 04:47:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725450424; x=1726055224;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFz1z4bpL1jITAk7xtQcrjv0O1jnUDE07Q/HxRcErkE=;
        b=qeIQVHPTQ5+qQ+YoqdAzBQLdx/M7gRnapm2Q/2qwypEP4BveFiDBK0nzfBHj3p3p1N
         HjF1wpb9gFrZ1IIDjahQyMuF7y7ndlNjB6OsjAUFaxjOO7yHnxSOUm6j68IDAeHhJsKT
         2H3jfI3pAvBBd2l4chaeXQzGBJkyNnduN9mYfyh/qBH5ktaGXWZowyoKz4e/0pSON5rK
         RGNckxhshvvtd0brzQ572q7/dtDJcJhqQCbmXWSChmjdx+VQ6SmmSDXjljjVxO51Rs3m
         woQx74MCCMatWymghQ+DAFXHxOoqz/zE0On8W0/zm6mURat6zDv/gVqYdFwyQ8YLOUVi
         sUxA==
X-Forwarded-Encrypted: i=1; AJvYcCXOY6EmlrlhBgU0h6o5hVlcQtaExx3afLFkQIV/WtyR98lZkldh2CrP4KcoJJjBnmwYmzY60VeOwkg0o34=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTFb+0bJsODAZkY6hfyGKIz36E03lj4G7gxuBp98B6IkkKmDrk
	6f0FB2qnSLFZ8tkHQRRUj2o1PBKYWLg+/vRVAsd039iJPg/Oc1o3LXPveg1+bFKLoa80+eGDNTI
	pJuUVMEpcD+4juETpu0MPSc7WMtU7thKfgFKX1fbPHVlZF4puOWlUs77SfNggVg==
X-Received: by 2002:adf:efcb:0:b0:375:b52:7d75 with SMTP id ffacd0b85a97d-37771328f40mr1656476f8f.53.1725450424182;
        Wed, 04 Sep 2024 04:47:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV3LKzD8KE8Ajx3WJiPY2JLMBff5S4Q79awiFOvrR3sFd+JYnyYh7083dFbiCJv1lLd6H+BQ==
X-Received: by 2002:adf:efcb:0:b0:375:b52:7d75 with SMTP id ffacd0b85a97d-37771328f40mr1656454f8f.53.1725450423659;
        Wed, 04 Sep 2024 04:47:03 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee9ba8esm16721895f8f.50.2024.09.04.04.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 04:47:03 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org, Kevin Tian
 <kevin.tian@intel.com>, Yiwei Zhang <zzyiwei@google.com>, Lai Jiangshan
 <jiangshanlai@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Josh
 Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 5/5] KVM: VMX: Always honor guest PAT on CPUs that
 support self-snoop
In-Reply-To: <87frqgu2t0.fsf@redhat.com>
References: <20240309010929.1403984-1-seanjc@google.com>
 <20240309010929.1403984-6-seanjc@google.com> <877cbyuzdn.fsf@redhat.com>
 <vuwlkftomgsnzsywjyxw6rcnycg3bve3o53svvxg3vd6xpok7o@k4ktmx5tqtmz>
 <871q26unq8.fsf@redhat.com> <ZtUYZE6t3COCwvg0@yzhao56-desk.sh.intel.com>
 <87jzfutmfc.fsf@redhat.com> <Ztcrs2U8RrI3PCzM@google.com>
 <87frqgu2t0.fsf@redhat.com>
Date: Wed, 04 Sep 2024 13:47:02 +0200
Message-ID: <87a5gntzd5.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Sean Christopherson <seanjc@google.com> writes:
>
>> On Mon, Sep 02, 2024, Vitaly Kuznetsov wrote:
>>> FWIW, I use QEMU-9.0 from the same C10S (qemu-kvm-9.0.0-7.el10.x86_64)
>>> but I don't think it matters in this case. My CPU is "Intel(R) Xeon(R)
>>> Silver 4410Y".
>>
>> Has this been reproduced on any other hardware besides SPR?  I.e. did we stumble
>> on another hardware issue?
>
> Very possible, as according to Yan Zhao this doesn't reproduce on at
> least "Coffee Lake-S". Let me try to grab some random hardware around
> and I'll be back with my observations.

We have some interesting results :-)

In addition to Sapphire Rapids, the issue also reproduces on a Cascade
lake CPU (Intel(R) Xeon(R) Silver 4214 CPU) but does NOT reproduce on
Skylake (Intel(R) Xeon(R) Gold 5118 CPU). I don't have a lot of desktop
CPUs around, so can't say much.

AMD also doesn't seem to be affected, at leats AMD EPYC 7413 works fine.

-- 
Vitaly


