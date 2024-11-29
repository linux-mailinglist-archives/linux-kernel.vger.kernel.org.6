Return-Path: <linux-kernel+bounces-425582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8ED9DE705
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 14:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4722E1646C5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 13:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0864919D8BE;
	Fri, 29 Nov 2024 13:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fyBz51hG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AA7156991
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732885913; cv=none; b=DPRjTXiMdi2vxJ/ATSVZAFMrLRYkZblrjrE/9rHEmmOJAe18hw+tCgHNEuCOruIbwOZZk1DTRKAeCffgfzK7UMGgd0+Fdrpk0PonT4Km7IwSiKAHXLz6pwUf+GO4ABA5MN4wLw/SybNjf3jF/CBkMt/pXL55ouiwHLPuiN3az2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732885913; c=relaxed/simple;
	bh=YnJzF9KYRCS2bZhD8BFhUI1QeJMyl7hozeHKO1WcYL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxHvtF/DX+LdICXZaj4bPvSrpoAcSJfePHVudeK3wUYkSnMzQSAGpagbVMDIm/TXmmCs2Lnl58RHTbgrb3yLMvaFDl7y/2v26kVMwXJEQ5V4VB+3fAKwt6glBG/2gs7h6NBRBt5HQXHmJ2uVBr9E/MJNWh9+x9AjE1lO+dGBgEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fyBz51hG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732885910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7/lsbs4eMAFpBMNNwe7aa+EDadcLAy15/Z7Xw2L/Pw8=;
	b=fyBz51hGtYajIvHgArW4YiM4xTfQdS4E+qX8nuz6/hOoRBwWzvEwaBnt3ZU29AACQi49rE
	QsmKam6bvTTsg/xipRX4c0ajzbmWrKUAUqh8J+GORwqioUiKJvblpX9GLfB7dZXf+qaPQX
	f63uhfvpKuPEVgRlQxyCy9BeWm0VwQM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-ZCnyL0L9PtWrvjEb3vIXuw-1; Fri, 29 Nov 2024 08:11:49 -0500
X-MC-Unique: ZCnyL0L9PtWrvjEb3vIXuw-1
X-Mimecast-MFC-AGG-ID: ZCnyL0L9PtWrvjEb3vIXuw
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4349fd2965fso16882425e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 05:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732885907; x=1733490707;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7/lsbs4eMAFpBMNNwe7aa+EDadcLAy15/Z7Xw2L/Pw8=;
        b=rsXrPUasB4uFbu5mRMYBTu/iBqlWqfsg2U8VySMw6dRGDuB9f0WKVsZdg74FdV3kJz
         SMUZe4iByJD4tpQblDceE5HRzu4CS+VlJI+DrmOcWXRveFedh13rftsIXX9wX1/XMEQ8
         yQrRSL4YtekZxbC5edHYD85jEBW9HCvdXMd6cAufOFts4pLu+pQECQG0It9ngvJvANdI
         ENt1lJbJw8A8ndQuVv+WbE4PBLh+gO11hMN0DT8x5yAHI34NTUJYXzc3sTkg0+5L8N9B
         VgV+IbWU2hsO7q0hkUXUlIouzoYdI9qlOi4DjjG4iw9qpecLkHnVlTT2AmJ8ryr8fHJn
         V7Xw==
X-Forwarded-Encrypted: i=1; AJvYcCWktDr/UVW6JYgiCmhM7/NBveE7sY/5hilPdZ0vNESfYCNIIiHQjA/KJp5qcbWF0nW2CQszaU/mgJPEVng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/dJfiAgX7//eAPc13l042fOOPilVrtAYyZU6xfODTC7SyvRkW
	oHaXh5oQdL8+eFF85G1cMwDKL03Gn149Y00n4wGuLnJzaGXY0pxxo87ViIIZ1kV0L+bLVAaHaRI
	DI7SoyElW5wwOa59/FRAcetLk0zdBqtVXt7GXdz9NGzJ8NWsTRFVfMbT/FSU3AQ==
X-Gm-Gg: ASbGnctYsjtVhq1dkc3CR23izmkJ12vJ1E3kj1TzDo5x94dzKn1sLpnotvzk3sTPX4O
	7L3Sm/cNhi67240TiXnTlvkpSCxYkh+OWcPZugvaGN7zPnxbt2gdA6+7J+uBkEfQxlP3FoENvW0
	8+ubFhn97cdEMcay4gry0pBwGRJRHj2pvqw0KDEqZnyTowulNajbG96LsjPrVI+Ri3cld2357YI
	8ENzBCa5i8JvJnNQE4/aDygurqyaozF8U/6iKkW2ufu0DSTEEWBQju8XmcBFI1/EPhKe22aJMKa
	AxEb0egvk0QCka/C2+Cq309KJcDo4QJDJyfyFlS/XTO8DLxcOlP/JEuoSk7uliautTxhVHGAyt/
	GBQ==
X-Received: by 2002:a05:6000:1f8b:b0:385:e176:43e8 with SMTP id ffacd0b85a97d-385e17644c1mr262936f8f.33.1732885907125;
        Fri, 29 Nov 2024 05:11:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOir4XnE0JlO93OYdRaExLw6gTrk+WtrxLfp0VTyXJDHkBmEzbXxU+gtV/8YndlL6HVGYuZg==
X-Received: by 2002:a05:6000:1f8b:b0:385:e176:43e8 with SMTP id ffacd0b85a97d-385e17644c1mr259702f8f.33.1732885885041;
        Fri, 29 Nov 2024 05:11:25 -0800 (PST)
Received: from ?IPV6:2003:cb:c71c:a700:bba7:849a:ecf1:5404? (p200300cbc71ca700bba7849aecf15404.dip0.t-ipconnect.de. [2003:cb:c71c:a700:bba7:849a:ecf1:5404])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa76a8e0sm84214255e9.15.2024.11.29.05.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Nov 2024 05:11:18 -0800 (PST)
Message-ID: <8376a446-1e8d-4359-ac69-626790ebcd97@redhat.com>
Date: Fri, 29 Nov 2024 14:11:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf: map pages in advance
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Matthew Wilcox <willy@infradead.org>
References: <20241128113714.492474-1-lorenzo.stoakes@oracle.com>
 <9f9fd840-6421-43b5-9a12-edfa96e067cc@redhat.com>
 <1af66528-0551-4735-87f3-d5feadadf33a@lucifer.local>
 <926b3829-784f-47b8-9903-ea7b9ad484ac@redhat.com>
 <31e8202d-f3db-4dcd-a988-2f531b14e40f@lucifer.local>
 <84fed269-3f82-47f7-89cb-671fcee5a23a@redhat.com>
 <03f654d5-424a-4d23-828e-323aff46fa61@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <03f654d5-424a-4d23-828e-323aff46fa61@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.11.24 13:48, Lorenzo Stoakes wrote:
> Will reply inline also but to be clear - we should differentiate between
> ongoing discussion about how best to tackle these things going forward
> vs. whether _this patch_ is OK :)
> 
> I don't think you're objecting to the patch as such, just disappointed
> about VM_PFNMAP and wanting to discuss this more generally?

Well, a bit of both :)

> 
> As I say below, we can't use VM_MIXEDMAP as it's broken for our case (we
> have to use page->mapping if there's a struct page), so I think _right now_
> this is the only sane solution.

I'm not so sure ...

I've also been wondering whether this particular user really wants to 
allocate and work on folios for the time being :/


Putting aside the remainder of what we discuss further below for now, 
I've just been wondering if we could somehow have two mappings with two 
separate ops. The one for the single R/W page, the other for the R/O 
pages ...

... but I'm not sure yet if that would completely help.

... still trying to grasp all the details here, and how to keep GUP working.

-- 
Cheers,

David / dhildenb


