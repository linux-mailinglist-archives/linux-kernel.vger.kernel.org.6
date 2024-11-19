Return-Path: <linux-kernel+bounces-414157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4589D23C9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 11:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464451F22F9D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC61A1C461A;
	Tue, 19 Nov 2024 10:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSAnGICn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD8313AD03
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732013264; cv=none; b=IdUmTePQzeh5IOV5QaPHfMgKFH/4xvMQstopDO2nMBGa4VNp7kF1a5uFdIrhO3DtDEnShLsCNGS5EA9EcPTFVBH78nvdui4roe234stE/ahezurvbys0Uo/QTqyXwL4lqef5PoFFeSmUQS2H5R7+ecvv4foevYPE0g6Lt6aUUzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732013264; c=relaxed/simple;
	bh=6VCRFnCX3pfgj4fK4Xruwd8ELWuUcPyHUTVhmyFVH0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQZzvhbm6aQOQt4rxdTGwL03jgdLboNaj2beTcpiPIXQpjmDqrlaOLkC+0QsWi/tc84lOKBMjegomyx5BKqNsVdMxXH8zqERUx9rkF1GffejkoYZSBgpu940JfdP9bdXlSIfZpCdvkeDVT+ZTbRnkQeNK2OQOttGz5VwjTBMajQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSAnGICn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732013261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lbq4GTD2ZW1VFhzZ9Ih2F0hJrIDKiy6HQqH3WOgrSvw=;
	b=DSAnGICnYZ/LSDkTvNvW+0nc13xCmE67aGex7OjLGLZAQ1/4jbaZFEBL12NbizOsVM1GcU
	+/5afBsrn7XzvTX07HTkGhicHrYSFz27gBSNyed00wbi6PAbNbvKSPn/cr214/vK7vS9z2
	xr8Ikw0JjbycVwEELuPAh8+jAFMsca4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-sAa97vf7MNqbLKc1Ii_juw-1; Tue, 19 Nov 2024 05:47:40 -0500
X-MC-Unique: sAa97vf7MNqbLKc1Ii_juw-1
X-Mimecast-MFC-AGG-ID: sAa97vf7MNqbLKc1Ii_juw
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43164f21063so33356005e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 02:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732013259; x=1732618059;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lbq4GTD2ZW1VFhzZ9Ih2F0hJrIDKiy6HQqH3WOgrSvw=;
        b=DQ3pOX8QEUd3eb59+950AKjHoUjJ50DYDKDXdjPr3X3YVk7Tb87k405HxrUsJffFb+
         kceE3gZJ/GZMO7E3RzTGIy8XV+S2q8gjmAFWtSXZkjzNQAAoiiDPqFouHOWmdxNvk8S4
         Q7LEMVLB9OQgJbEs6gunylUcZ/jw0dk6M0Qrw882FldrarAjtLBImWdRX3Y4WdphQiBP
         FXg/PN8jkSi5YqR5MX/cM/EPY8/rXdQ2EwKjd9MnsDIao9IMs96I3MPMpV0BaOygQ5NJ
         TAJ83oDh+zJbLfaeE7a+GGrY0SHCYPdFxyCmczvqpB1VTJ0boOGIrid6Z8qp2+6N5G3P
         0akg==
X-Forwarded-Encrypted: i=1; AJvYcCUF16w389F0YY2zhVKsWBdqr7Uf5vnVDVOCQKVBkEU5xYasVzYF5s2KHHswV3MhQXEkphuWwVDLYXGgICc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+4VZ2U1XWR6T67UKsqhkWXd0oU+4HjuxfKEGMks/1TK7TgwHX
	rczJU0ECU21Hp7Fy6TFrgSYOJrSoDBSqg99lF5oriFkIXEIlbl1LulzApNojKnMYalELMYB+JZ6
	ao5aTSHMBB6421ver78vT3zgrQzPcUPMrLxM5DkeGpZARgEyGDtsGLVnQO8yX3g==
X-Received: by 2002:a05:600c:1c09:b0:431:5f1c:8352 with SMTP id 5b1f17b1804b1-432df71d609mr136397795e9.5.1732013259172;
        Tue, 19 Nov 2024 02:47:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXQU8bYBZyo+JtkpZZANf/ov31RNF5jrSGWsBbL2ftQ1DTgrFXVNSX9siT2RRWrGpE1HT9Bg==
X-Received: by 2002:a05:600c:1c09:b0:431:5f1c:8352 with SMTP id 5b1f17b1804b1-432df71d609mr136397625e9.5.1732013258844;
        Tue, 19 Nov 2024 02:47:38 -0800 (PST)
Received: from [192.168.1.14] (host-79-55-200-170.retail.telecomitalia.it. [79.55.200.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38247d065c3sm5791778f8f.87.2024.11.19.02.47.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 02:47:38 -0800 (PST)
Message-ID: <1bc6fbd9-aa04-4bed-b435-262edd8f2d37@redhat.com>
Date: Tue, 19 Nov 2024 11:47:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/4] net: ipv6: seg6_iptunnel: mitigate
 2-realloc issue
To: Justin Iurman <justin.iurman@uliege.be>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, linux-kernel@vger.kernel.org,
 David Lebrun <dlebrun@google.com>
References: <20241118131502.10077-1-justin.iurman@uliege.be>
 <20241118131502.10077-4-justin.iurman@uliege.be>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241118131502.10077-4-justin.iurman@uliege.be>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/24 14:15, Justin Iurman wrote:
[...]
>  /* encapsulate an IPv6 packet within an outer IPv6 header with reduced SRH */
>  static int seg6_do_srh_encap_red(struct sk_buff *skb,
> -				 struct ipv6_sr_hdr *osrh, int proto)
> +				 struct ipv6_sr_hdr *osrh, int proto,
> +				 struct dst_entry *dst)
>  {
>  	__u8 first_seg = osrh->first_segment;
> -	struct dst_entry *dst = skb_dst(skb);
> -	struct net *net = dev_net(dst->dev);
> +	struct net *net = dev_net(skb_dst(skb)->dev);
>  	struct ipv6hdr *hdr, *inner_hdr;
>  	int hdrlen = ipv6_optlen(osrh);
>  	int red_tlv_offset, tlv_offset;


Minor nit: please respect the reverse x-mas tree order above.
Also the code would probably be more readable with:

	struct dst_entry *old_dst = skb_dst(skb);

and using 'old_dst' instead of 'skb_dst(skb)'

Cheers,

Paolo


