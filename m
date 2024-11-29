Return-Path: <linux-kernel+bounces-425161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB8A9DBE4E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 02:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18921282422
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 01:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1119B12B93;
	Fri, 29 Nov 2024 01:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MIGP/4co"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B16A28EC
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 01:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732842390; cv=none; b=rJACZgAYSTzSqKbgFXYtYm3GzR7Ou6v2Qng7eB/VV2kafejOMVqc2FhTiYNatViLV+laadvkNXpvdzZCV57YQiPwdUFCb7hMnyheb3A1hYOi2I4ztBVcHDUfO7wl2YnLG3SqEBkpR+oy0ZGZD90iqP1UTeUvpgn3eGsEj0Arz+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732842390; c=relaxed/simple;
	bh=vmkfQ05U4KcJBRb+AMfeXtPUZ0nlO5Ekuhw77upgapA=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HkSlnp/B0nfVheMFYI8dkBqY0GXtcuBlnM3USNkvH9Fd8k1JYN2IEEgLQIJkHMEtMy/jcj7vX9DUo5PYcwS2s5GVYG6vpUvopVtUBRFvfQBIISTfiejnaL38wHiGM5diBZtjvIwXD4m6UDVYWVbm3TCFgT/p71OEgI4wTBjyk1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MIGP/4co; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732842387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p0bNS2q7BKlOVjXw/GPjh/MQWSKivvITbVWoFGWlwxA=;
	b=MIGP/4coV6c8WmFmaOpBWsD+RSYAVrprUn7nxntdy+k5tMI5wQThW+nikTl9j1dKEBPpIJ
	XrdJhJHTv/OIIyccM+65ReLCHQ8GVGiINlpERtgRg+aFhiPFxO7kyEmVxlWuxWJXAU5HuX
	cA6/gR0jKaM1z+4J7kgCsiKHxaR1NXQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-Xr1tsWO7O3a60a1rKYcnkQ-1; Thu, 28 Nov 2024 20:06:25 -0500
X-MC-Unique: Xr1tsWO7O3a60a1rKYcnkQ-1
X-Mimecast-MFC-AGG-ID: Xr1tsWO7O3a60a1rKYcnkQ
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4668d3833a4so26957821cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 17:06:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732842385; x=1733447185;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0bNS2q7BKlOVjXw/GPjh/MQWSKivvITbVWoFGWlwxA=;
        b=pq+ZTLRqfl0AK7pbGuhooc1Xy394Awg52UDHxE3xJSg7ixnltM07Bv52IM9eyVplxP
         s+HXb4+64t/E1CMBgx4jbDC23/PmKU9/4Bzmb4U1mulzEA+DxDvgVIX1sw+VS7UhMXqI
         F53XDRzbaJFGeqifKNr9zr69ptdYatDWQHZDuyyNDu+f5DsUdoww9OXg5R1UBaEjWScp
         s4nZZYyTP51XWnl3/XUDSV5k3p8NNm5vMPrG87vIAjl0OzeC4S26RW2yBWSf31pmIUIw
         FenGDwlY2j+/PicjZHoPki5y/wz/XtAYweubfdz28TOCr3U/9XaNnoFjKscN5AAiinhk
         YLfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOmVNQS2SrQ1+n/6RzTpfLtK2W0z3SqQpK+lTJjHqa4Rmc/R9D5yD/WxO/SV06Wt+0YvTekmaRFU9o/Nc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZhw6WfCoHWL/bwiKGUmKzXk1fEz9eBLT5nmaShR77/Gr7P8Ec
	pKpzeYilYBDmVI51ujhjbzb5oBQc0aJFYxO40Wew6nlSxv3CyOTBvZDy8VybtYhWOJe6kymWdmw
	NBu+lqsg7HMH1J29WUvqd9P0xxBtV7GIgQYAcCcgrS+EO1Ak4c1t1YbWeOrU9Lw==
X-Gm-Gg: ASbGncuRWDNx4Umd+dNHgMWykNgvlSZfdt7fKIw0xKyZ/mV2Xd7SZ+ySKWV/owsOHEY
	g8xbz70q19/oce09V+KQMy1zZdLwxlgSr6hrHX94bT8wldB8qWZpIhea27PsbnCXA1wKom/N5Xb
	QQbrMfMHF2xCl1az4+C4cfpvd49WOyOYma/vo8e3C4DZnLWMkkne4DEcFBRmMD+TSJj/EI60FW4
	D/J8aRUltSPVkXQ06LUKAl6c+wCyvxTJPtcEEafeJ/NPYHm7Q==
X-Received: by 2002:ac8:5a11:0:b0:461:13a4:e901 with SMTP id d75a77b69052e-466b35f08d6mr127202491cf.30.1732842385103;
        Thu, 28 Nov 2024 17:06:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEuETeXrPJRNHeso0X3u/OswGloHSFFFL8Budr2sz9MwwlE3+fRrB48+VyUt4pzdnzYIOx5Vg==
X-Received: by 2002:ac8:5a11:0:b0:461:13a4:e901 with SMTP id d75a77b69052e-466b35f08d6mr127202131cf.30.1732842384771;
        Thu, 28 Nov 2024 17:06:24 -0800 (PST)
Received: from [172.20.1.227] ([70.25.108.75])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-466c4054d0bsm11643281cf.3.2024.11.28.17.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Nov 2024 17:06:23 -0800 (PST)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <15662315-0332-4c0e-95c9-928329a094a7@redhat.com>
Date: Thu, 28 Nov 2024 20:06:21 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/nmi: Use trylock in __register_nmi_handler() when
 in_nmi()
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>
References: <20241127233455.76904-1-longman@redhat.com>
 <20241128092800.GB35539@noisy.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <20241128092800.GB35539@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 11/28/24 4:28 AM, Peter Zijlstra wrote:
> On Wed, Nov 27, 2024 at 06:34:55PM -0500, Waiman Long wrote:
>> The __register_nmi_handler() function can be called in NMI context from
>> nmi_shootdown_cpus() leading to a lockdep splat like the following.
> This seems fundamentally insane. Why are we okay with this?

According to the functional comment of nmi_shootdown_cpus(),

  * nmi_shootdown_cpus() can only be invoked once. After the first
  * invocation all other CPUs are stuck in crash_nmi_callback() and
  * cannot respond to a second NMI.

That is why it has to insert the crash_nmi_callback() call with 
register_nmi_handler() here in the NMI context. Changing this will 
require a fundamental redesign of the way this shutdown process need to 
be handled and I am not knowledgeable enough to do that. I will 
certainly appreciate idea to handle it in a more graceful way.

Cheers,
Longman


