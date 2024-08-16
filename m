Return-Path: <linux-kernel+bounces-289484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 264F49546A8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BC131C21C48
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9A018FDAA;
	Fri, 16 Aug 2024 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yf5H/gCi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9027618FC91
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723803607; cv=none; b=a3lqcY9mH3pa34qp4L8EipmgJhgKsu5lrDymy39YN0uExqO1DqOFRkkm2i2I+PgvpeSnWZ0v3E9KYQNp36VduAZ8KatnQqC85IVXI+xEH7MviRyNkwXs3brNkVuBfcYhPfKjxCObK+hE9XJlSraRh9iBkNtvnv/fs2GvYv+Rexo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723803607; c=relaxed/simple;
	bh=Q7Tx68mXJbhoSFVjsZb3On3tQ69pdQCCGIl59/q6hgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I03pZJavyObyovY5OVdGzUNX7XV3FKSuoDLJOSeSyjFKq9mxWEZywrbz0JjS3b8PG9mjnQjbfYwZaaeUeTDaxsECAHw39dKw4afPEXRm0bfTN3PgWk8sMm9NERc5/UkQYm4WcGfZS8kq5saXanPe6oOcf7h1QXiMr1PbWzBgX5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yf5H/gCi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723803604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GiGH3zeAxa2Jx6Io/k4YdQGBv52I1k5flFPAhWOIYhs=;
	b=Yf5H/gCi0cHqxgDv+YCBcFSmNHUAOWo/Jz+moMp93EYoqdfFURkau91VmdkH6AqpGINfqz
	DZEZNedWHlwVLqbzmqKnThJ+C4GRSyn04VoaWiiN5bWo9oqs0TsUqW39Q/Ge5Bfx6aO1ol
	8WML8SSgsISvJBZpuOnFPisB/PRrSK4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-s9G_opAAOq-dsnuoqD_Dew-1; Fri, 16 Aug 2024 06:20:03 -0400
X-MC-Unique: s9G_opAAOq-dsnuoqD_Dew-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42816aacabcso13565055e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 03:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723803602; x=1724408402;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GiGH3zeAxa2Jx6Io/k4YdQGBv52I1k5flFPAhWOIYhs=;
        b=rzLtjS6wfKWoeSo6LOQArjAoCpKXZrh60L2r+eRAUt/Zy+55d+gEHvebS0NYt9rTKJ
         xQdq0VSQVctKUpSfgmBMJ7cveQ/LeShNN5ee2zjzjbvZYGIvuCk4WLKVimMOVnB84CNt
         3WGN/V3A6xnwYb2ZD4MX+Q33Q33kaj0mkjzdQ01EtdYW7h1OQ9YYdyjQ69tmE6WlJB69
         1nqw2BIhYNi1ukli/njW6/PHEBfw+xcm+FAc7KFtHe1/x7pJetAkMycec3txkN1g9PPr
         1d1ymLQW7yuSLMlNFzM8+/p4Z1MNZ9JrVonH66lDhBUnjrTUolapOqppmoVMvtOZPDYg
         S9NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh0b+osgSl8VBHyvXpFQu8QShSD5JCClClosjv1BlVFUshY43R2+MncNJbgHrDmBMA2kV2WpHqroA3gZgVBeNGXyV0HhnSQz+Zo1xJ
X-Gm-Message-State: AOJu0Yy1lAFy+vtctMCW48XHrAgi7trblCI1sRKUvdtMFLKKrQI0m0ER
	8T5t0t0Sf7cS4XYwjxi2FyZQT9CHMS+Xiu4QEJAVaip3SRxjOr8ATGlTQvrxVSEQGp3HoKxmqXi
	hZqgoC7FMxFZiJLBw3jm1tNOg99nNAEY8tIVIImBZjfUBPtEywiGWO6/2pup8yw==
X-Received: by 2002:a05:600c:444b:b0:426:61f6:2e38 with SMTP id 5b1f17b1804b1-429ed7db64fmr13983975e9.35.1723803602257;
        Fri, 16 Aug 2024 03:20:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHtu3CY8gsMdmmPJm0qqf1bsZ6Z2KxSJIE505dCeM93i1U3KXLkozWnth9CpOQSrQHaeGOE9A==
X-Received: by 2002:a05:600c:444b:b0:426:61f6:2e38 with SMTP id 5b1f17b1804b1-429ed7db64fmr13983785e9.35.1723803601759;
        Fri, 16 Aug 2024 03:20:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c721:b900:4f34:b2b7:739d:a650? (p200300cbc721b9004f34b2b7739da650.dip0.t-ipconnect.de. [2003:cb:c721:b900:4f34:b2b7:739d:a650])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded71ef0sm72577445e9.36.2024.08.16.03.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 03:20:01 -0700 (PDT)
Message-ID: <883bf552-f339-474f-805b-4355ef49e526@redhat.com>
Date: Fri, 16 Aug 2024 12:19:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: add lazyfree folio to lru tail
To: gaoxu <gaoxu2@honor.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Shaohua Li <shli@fb.com>,
 yipengxiang <yipengxiang@honor.com>, fengbaopeng <fengbaopeng@honor.com>,
 Kalesh Singh <kaleshsingh@google.com>
References: <f29f64e29c08427b95e3df30a5770056@honor.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <f29f64e29c08427b95e3df30a5770056@honor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.08.24 09:48, gaoxu wrote:
> Replace lruvec_add_folio with lruvec_add_folio_tail in the lru_lazyfree_fn:
> 1. The lazy-free folio is added to the LRU_INACTIVE_FILE list. If it's
>     moved to the LRU tail, it allows for faster release lazy-free folio and
>     reduces the impact on file refault.
> 2. When mglru is enabled, the lazy-free folio is reclaimabled and should be
>     added using lru_gen_add_folio(lruvec, folio, true) instead of
>     lru_gen_add_folio(lruvec, folio, false) for adding to gen.
> 
> With the change in place, workingset_refault_file is reduced by 33% in the
> continuous startup testing of the applications in the Android system.
> 

The patch subject does not match what you do in the patch -- at all.

"mm/swap: use lruvec_add_folio_tail() in lru_lazyfree()" ?


-- 
Cheers,

David / dhildenb


