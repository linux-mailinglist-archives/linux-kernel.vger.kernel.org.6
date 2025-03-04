Return-Path: <linux-kernel+bounces-543688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDE1A4D89A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 952F8188AB9A
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEAA1FF5F4;
	Tue,  4 Mar 2025 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Npxm/5gP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DFD1FCF7C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080447; cv=none; b=OnmCe55hH+sLqD9Lcs2ykhkgXGEjte1DXKPoqjEAq7P9JfUJZifF/1Ad9bk+gts3zif9Tmv1RBR4AQvxQyxoovES8ffAFisxNuh7QNRJkCo2KlLnucO8H9EfBYRL6jm6rm6evNxfVMvGOTej2OUwAOPrYRMb+sq8CPz5nDNRDp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080447; c=relaxed/simple;
	bh=hR2xEDa4mCY/CYJOZkbXo6ZznOBpkJxCdonNc9UV8Cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GTFL8BinnjhTbVe6rkJx43mbl9rKXFNYDINZdU4dtPb6vHQJTx6WgvUp+kH3ygdP7zGJdXnLxugIEf7jSVJ8HSUZWQlH8SKtcsgML6kYnB6zQAPMHP/ZP4Tnbv0ur4mQ6NLHVf/LbxQPB6EDsLpx9f2LKsCXDXPytzIZwRPIfyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Npxm/5gP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741080445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tIB8nd9thvkyIwVObHDYCvrndbLG7jBNPcs2JeFybcc=;
	b=Npxm/5gPUfMjPYx0kHor2jgziYIVml8/cA30F5qEmI6lcSekf6vktSS0WCRhh8vL6486BO
	WN0xh5lGd+qQRT0w6lt4xEbuZGHQJMiUj8HE5uWGLlit6UYeP1M6yepVsLzUG9zSQ5Z6HX
	0tS+ck4QgKxqHSoWmCJbnxEQZhiJ8eA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-XvWQB8RhOziSdHrmVAJzLw-1; Tue, 04 Mar 2025 04:27:23 -0500
X-MC-Unique: XvWQB8RhOziSdHrmVAJzLw-1
X-Mimecast-MFC-AGG-ID: XvWQB8RhOziSdHrmVAJzLw_1741080443
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4399c32efb4so27508855e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 01:27:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741080442; x=1741685242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tIB8nd9thvkyIwVObHDYCvrndbLG7jBNPcs2JeFybcc=;
        b=h3hPv9EIP++W7y3VDum9Tt6xWMGtpLL2ScxDfq+NvxVgOD7jChm6v1VaEAgBNOP6rj
         Frg9SgIccTxEbPlpUYWcZcM9jJUOXk/c/o5BNJiLpIsK3ilB2y0n7u35WHCVDLuTgr98
         mKsOmrY5KKrG1qTEx5fMs3wZGD23sg9S7uXmDLapqsCzdhyBjnnyGZ9TBt05DGk2gSJk
         aZS3acV563I9jgVrsBO5tehV+qCCBc05/9hOtSigEGdW5SzouAijG6B3D1+4WRzFZuah
         qm/sPJUxy/X+7Ha540aViOHeEZC4venxI2NjWd36bvSLY4r9Hs3bTUUIlhcMY5YNp1fj
         ekBw==
X-Gm-Message-State: AOJu0YwSDCwjKbVwsE+HuLl9wieOZfAQpGA/1F32yalLcjNJSz5pI1Me
	9avxkI+WZ9vzuAIoaGrANksLqb0tQXqZz5biVL/RR/lZ3b0wiRRrZ6CE6GoWYFpRDt48O/kF36V
	Bb0YYqQo3opUsgQq2Q0/dZkTEAdvWGeHKjYzWb1c4+uxlyK//NO4K3/TJOm1Rsg==
X-Gm-Gg: ASbGncs6Oh7f3l48BYoi7cTppzFz8S8V9BA0rqc5XcA4/eEgGw95au23cpW7iVuQyi2
	w66YZUrR7Bi+8fQoCWtVCsyv/d6mE1N5BARqqYY9aRizV3uz3KkcaasdnXujnx2AB33PRkdNKji
	jIy4XLN0079MFeGGLDCDDqVacoX/U6C6jJNdMenaUTTZdCONZuzcWwAMSFZqzYw/YFr0ztzaATr
	axbpiuKDstZ1YFAmnmdNi1OXVql0vWnOzNFY+n1OxASGe1HhgUg4IcDpanxKa2Nq3dYMaEL3BEY
	Xx/hYvHC2aWlmXEjAi5Aq3azlhLJ0fGUM7gsLRLTPHx8jw==
X-Received: by 2002:a05:600c:1caa:b0:439:9737:675b with SMTP id 5b1f17b1804b1-43bcb024424mr18880645e9.7.1741080442588;
        Tue, 04 Mar 2025 01:27:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHyV/4FYCRs2qRtB3CsnE/pIP6aLhyWpQNXeN1VCdVQaMJeKtE4eOW6Bg2rcM7ihCtC3K8xIQ==
X-Received: by 2002:a05:600c:1caa:b0:439:9737:675b with SMTP id 5b1f17b1804b1-43bcb024424mr18880425e9.7.1741080442221;
        Tue, 04 Mar 2025 01:27:22 -0800 (PST)
Received: from [192.168.88.253] (146-241-81-153.dyn.eolo.it. [146.241.81.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bc5a32e62sm50890535e9.25.2025.03.04.01.27.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 01:27:21 -0800 (PST)
Message-ID: <922ae0f3-f2e1-495d-85b0-2b0740bbff09@redhat.com>
Date: Tue, 4 Mar 2025 10:27:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/2] net: hsr: Add KUnit test for PRP
To: Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Lukasz Majewski <lukma@denx.de>, MD Danish Anwar <danishanwar@ti.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Jaakko Karrenpalo <jaakko.karrenpalo@fi.abb.com>
References: <20250227050923.10241-1-jkarrenpalo@gmail.com>
 <20250227050923.10241-2-jkarrenpalo@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250227050923.10241-2-jkarrenpalo@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/27/25 6:09 AM, Jaakko Karrenpalo wrote:
> Add unit tests for the PRP duplicate detection
> 
> Signed-off-by: Jaakko Karrenpalo <jkarrenpalo@gmail.com>
> ---
> Changes in v2:
> - Changed KUnit tests to compile as built-in only
> Changes in v3:
> - Changed the KUnit tests to compile as a module
> 
>  net/hsr/Kconfig                |  18 +++
>  net/hsr/Makefile               |   2 +
>  net/hsr/hsr_framereg.c         |   4 +
>  net/hsr/prp_dup_discard_test.c | 212 +++++++++++++++++++++++++++++++++
>  4 files changed, 236 insertions(+)
>  create mode 100644 net/hsr/prp_dup_discard_test.c
> 
> diff --git a/net/hsr/Kconfig b/net/hsr/Kconfig
> index 1b048c17b6c8..fcacdf4f0ffc 100644
> --- a/net/hsr/Kconfig
> +++ b/net/hsr/Kconfig
> @@ -38,3 +38,21 @@ config HSR
>  	  relying on this code in a safety critical system!
>  
>  	  If unsure, say N.
> +
> +if HSR
> +
> +config PRP_DUP_DISCARD_KUNIT_TEST
> +	tristate "PRP duplicate discard KUnit tests" if !KUNIT_ALL_TESTS
> +	depends on KUNIT
> +	default KUNIT_ALL_TESTS
> +	help
> +	  Covers the PRP duplicate discard algorithm.
> +	  Only useful for kernel devs running KUnit test harness and are not
> +	  for inclusion into a production build.
> +
> +	  For more information on KUnit and unit tests in general please refer
> +	  to the KUnit documentation in Documentation/dev-tools/kunit/.
> +
> +	  If unsure, say N.
> +
> +endif
> diff --git a/net/hsr/Makefile b/net/hsr/Makefile
> index 75df90d3b416..34e581db5c41 100644
> --- a/net/hsr/Makefile
> +++ b/net/hsr/Makefile
> @@ -8,3 +8,5 @@ obj-$(CONFIG_HSR)	+= hsr.o
>  hsr-y			:= hsr_main.o hsr_framereg.o hsr_device.o \
>  			   hsr_netlink.o hsr_slave.o hsr_forward.o
>  hsr-$(CONFIG_DEBUG_FS) += hsr_debugfs.o
> +
> +obj-$(CONFIG_PRP_DUP_DISCARD_KUNIT_TEST) += prp_dup_discard_test.o
> diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
> index 79e066422044..3192e1253715 100644
> --- a/net/hsr/hsr_framereg.c
> +++ b/net/hsr/hsr_framereg.c
> @@ -588,6 +588,10 @@ int prp_register_frame_out(struct hsr_port *port, struct hsr_frame_info *frame)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_PRP_DUP_DISCARD_KUNIT_TEST_MODULE

The more idiomatic way to express the above is:

#if IS_MODULE(CONFIG_PRP_DUP_DISCARD_KUNIT_TEST)

Otherwise LGTM,

Paolo


