Return-Path: <linux-kernel+bounces-524708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B815A3E616
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 21:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 393787A9C28
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 20:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89A89262D39;
	Thu, 20 Feb 2025 20:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2Abcr6L"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3449E85C5E
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 20:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740084466; cv=none; b=hyLI4PovP//9rqmBan3l9jcrB/+LOX84bgzgkeJe6t2EAyxcd+1yuX/U2VK9c22e593vJG/wBfKIWv5Is07ljK/o1hqeVkqwgVekU/yBW9QYW5Dd/JAivod7vs8hqQ8uf7eAESzKhEW5C4LndnUkKyqVPjTaXnmWA5uGrapzRUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740084466; c=relaxed/simple;
	bh=VXm4u/meJsfJduq78WkrGxx3r494Xrd+CUZDjVX64Os=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=URGK/2HfTR7RYzIRNnLLKA2UB9v9gspRFkZvkBY5CqxpH0OuhtUICFO9ztGErTlgVfY9z6ygADl5UrOLmwnWJgSgc7OQriK7rTUR4n4/3k03+wP8AVeSAaHJCOiYSY8mw/0D78yTjXyOvpdxEQCjamO/pX5rAnlVVMlKFJqoVWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2Abcr6L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740084464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UWa/VI5uRsZXHuQw0tps/qrLYGstCupI7xowb98dNUo=;
	b=U2Abcr6L6GTt4cE4lWGZZMfp+vLZ99wJF6UsHWcz5L8fjZNMu6HtgapDS7sAyTxwFNYXUC
	Exmi4LYTIJhhVTUHnLYznK9tOvIbF+DPJoDj1xDG04RImUb2/1FtHYUKcJvcPwukmqZLDw
	lo2CO9RfQuBaUKrHPvHYTUcrIaovcZM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-uHfGbbnSONiqYdfvCt_4NQ-1; Thu, 20 Feb 2025 15:47:42 -0500
X-MC-Unique: uHfGbbnSONiqYdfvCt_4NQ-1
X-Mimecast-MFC-AGG-ID: uHfGbbnSONiqYdfvCt_4NQ_1740084461
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f628ff78eso710048f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 12:47:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740084461; x=1740689261;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UWa/VI5uRsZXHuQw0tps/qrLYGstCupI7xowb98dNUo=;
        b=GuBp+zfLHLga3Sgq5el1FH4y9uCcsmoe8RclPPYzaKBeSMztJHTnUVz1ND8DPq/JqE
         W+bgfznrhKQIzIa9AXWsk487+1L/OVxjl557Zn88s0tEz5bHJubdUsl0rodKydinrQwG
         Rhtwxol4j6mqn81D1IIMaRI8c3QTABMrSLUluv9PbbqVoM4DhC8lheO58PhQZQ+YOa9z
         ZBTyLJgJ+rddywNo9UP1fIrWpxPT1IUxyUV0rmRcgZQfW1MxiA5bI6TKDeyGQCj/WzkA
         pO5hzmD3Bp5MZqIs/lbe8Rq9R9IOYlxWd5+pTYR1gho+/H+UhORecp4+ptIc79EqPS4r
         03Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVnSGBLfX8BT5nRUN5edLJGq/MctwdYN7kAKH1DenABO39bNUayEjai42Rf4DFG5taQ/wtoTtHdiv/tBM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKvbt0mEI9uqFBiFd0wVJD639x7fAzV81wyZWn/K1mvanTyCEq
	m7LtT2oF/tKpz9J8z/poIOQl7TUeX6rn+zQnE5d3yxCDGtBnX1/lQYNSpAOljiTXXM6hOmyLCAX
	d/ZM4FonymrplQ/s3jqTSLyo0q3csxk5RVlHHlXG8nnPFbtgUya4bOUxx1ZkbSQ==
X-Gm-Gg: ASbGnctqE8X/tJSMl+/MguM+jRmll5CnsGbAFzZItBL4cXMkYtZopzvYWLGK7Tm1fuC
	kMBimfIMgUQWchpuGWYvfq74UgRTv44B5ZhQEGIi4DX1e+zFHCvTE1/Vrw/Qffdp/LrSSO8vmmn
	R9rmo8CSkZRelQR26gcVDHbEjwaEvGIU5ZeGl47Qrz0O7zfAI/Tvb1RDdAqEml7fAY4HdRrBRCN
	Xlu/D0gqxSpB/TSLLO6hdV/LYOgdStoC/U1g2yIzk/0NF7K6iqDifxYLP3JqWptSyNXyPdOXMmL
	hQVnAmHxvXNYhDyA/YMLvvC6TC+sEgNBpwo3FzNO5YaRKB/lprpI0QC9bSA9CJlVnjAvwcsYhVz
	9cn2c7INbku/sC7KNh6boMC2eOQcG+Q==
X-Received: by 2002:a5d:6c6f:0:b0:38d:df15:2770 with SMTP id ffacd0b85a97d-38f613fa36emr4305992f8f.0.1740084461439;
        Thu, 20 Feb 2025 12:47:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IED5+c6tEW/Vsfn4MBjvvsy6NZ5D+6mydxsFRFN0iSZBXlvCjjfCDLrkxUMrvOiiKXHvUtGiQ==
X-Received: by 2002:a5d:6c6f:0:b0:38d:df15:2770 with SMTP id ffacd0b85a97d-38f613fa36emr4305974f8f.0.1740084461094;
        Thu, 20 Feb 2025 12:47:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:2000:e44c:bc46:d8d3:be5? (p200300cbc7062000e44cbc46d8d30be5.dip0.t-ipconnect.de. [2003:cb:c706:2000:e44c:bc46:d8d3:be5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f259d5f4fsm21580909f8f.78.2025.02.20.12.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 12:47:39 -0800 (PST)
Message-ID: <dc78326f-38ac-4207-be59-2b753e0dc26b@redhat.com>
Date: Thu, 20 Feb 2025 21:47:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm: page_ext: add an iteration API for page
 extensions
From: David Hildenbrand <david@redhat.com>
To: Luiz Capitulino <luizcap@redhat.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, yuzhao@google.com, pasha.tatashin@soleen.com
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, muchun.song@linux.dev
References: <cover.1739931468.git.luizcap@redhat.com>
 <3f0e058aef3951b39cf6bb4259c247352d4fe736.1739931468.git.luizcap@redhat.com>
 <4cb93166-29fd-4aea-965b-5dfb62d4dc8c@redhat.com>
 <0a8bd481-0b97-416d-935e-84828016445d@redhat.com>
 <70971ae0-3933-4e55-983a-24c6b65ef913@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <70971ae0-3933-4e55-983a-24c6b65ef913@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> I personally don't like over-using inline functions, also I don't think this
>> code needs optimization since the current clients make the affected code paths
>> slow anyways (and this also applies to the likely/unlikely use in page_owner
>> and page_table_check, I'd drop all of them if you ask me). But again, I can
>> change if this would prevent you from giving your ACK :)
> 
> Well, 512^512 function calls for a 1 GiB page just to traverse the page
> ext? :)

Ehm, 512^2 :)


-- 
Cheers,

David / dhildenb


