Return-Path: <linux-kernel+bounces-214489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A63908573
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FDFE1F28EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 07:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA481836DC;
	Fri, 14 Jun 2024 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSEPZcqW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7B142E80
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 07:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718351823; cv=none; b=uyFI3+ipcAlTwEs7zJpnlWFBv2XpSqfx5QK9he5JLqwy/OtoHQck4pWAxgTxChpMGjFa1u9o9f6ESKY5Lsgij1Bl5o4sLiK6bFUZWnfSgff780Caej5nFgWVoi9LXPPDGF86Y9LIvpCxyhRTRAKLRt+dVlapEJ30tubiFlwGeF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718351823; c=relaxed/simple;
	bh=2p5xAyIYEYL5kOaFCIoz5Dcl9fFAo2ojVSc3Wy3Jbxg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=d0T31mgXoEz7dOfBvqlEDEtSFKEGIuCU/56AD9NEiBeB6MCTKcSqIntPAjBd92HleDAzHTtlPnlU+YOlCX27zG5a/Lg1psIOUQClAYJUphN/Iieq5j61lfz0xGU8245gaHMVLT+RONQNULjbd8jociRq2OjZdXFi822NHtL+gkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSEPZcqW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718351821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Tj9aNzYqQGp3pqdN1f0c1J29XbTZmlSb5mECeoTCN30=;
	b=gSEPZcqW7GUji02BXM4IPT9pmczxXMkfbDqLBipNC3uxL98czA3xFimqCrK3F/0gRsxCtV
	AgYRHoFzilWYb/URlJ8mp+Z93K3lT18DKZCNbIO82rmcTBHqP+sVTSBaq2VolATOB0SE5T
	id9bSAlq033gLgw35eu2c2G/b7yhUEI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-7KXqQFB1MPW0AyYO2nrRYA-1; Fri, 14 Jun 2024 03:56:57 -0400
X-MC-Unique: 7KXqQFB1MPW0AyYO2nrRYA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-35f123fb9deso1260156f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 00:56:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718351816; x=1718956616;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tj9aNzYqQGp3pqdN1f0c1J29XbTZmlSb5mECeoTCN30=;
        b=XDYVv5pL6H8Qm8jbQYX4sCHXbUFvrKI/pq3pfKXhFJchnh1GlIVx8jkyceTTSprv7G
         unvDMFMNe6Pm8sx9Ke5WhhB5IWeyzALsrPngEd9etZdrbHO+c/tAJBMOJ6GrYp+fcjP6
         Y2M2UeTVSBtROAFDwMnBK5Ag40HtI8aWeTKszPI1Kazdmh4o0PQFC1W8Fr4/KvWomU8Q
         4lwwb6fPLFvCTJ1ejWPwgM9tPK41VGwhPPTB5C+g2Z+ovs+fQ6Iz000ndi6s3OQpGo+m
         ehpoNOzA8F9ykQVwizlDt6p6u3u6A45XRaHINkfqYeWcahNoHzLT0J9aJZfdNYNJg+wN
         Idyg==
X-Forwarded-Encrypted: i=1; AJvYcCXH/fWR5/RQgjOzaSEzwe1DgRkRk8HouXYoi2GwHVXp/l8fyWpYM4+bIl+aOIbZ1dHHGIHYeVXxiDY/wUHRTrmoN7JXdfiVw5a+8olu
X-Gm-Message-State: AOJu0YxVZrb9pu0OiloAf/gRrfD1XwHMZz1s7NDAcdQHj6sKN+uusLvq
	xrSXGA7cOvJsRLIxU7dAgkTDiBVc8Wmd1po1BzKLKPO1pImc0QoYNvSLUZS7jEpOXpua6vuLGK+
	t6B/Ke1tVs7De76Hzd2frYpdIruK5bqvAwELob5s4GICQUGCcvCfquyfUILG45Q==
X-Received: by 2002:adf:eed2:0:b0:360:853d:bda5 with SMTP id ffacd0b85a97d-360853dbdeamr389915f8f.10.1718351816334;
        Fri, 14 Jun 2024 00:56:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMxVwgf1CY8MLSdRv0n0iwzNfy8xWit+ZMsUlg+YmX69jv9yrvz3jGozIs/TjyUNtwsIl2yg==
X-Received: by 2002:adf:eed2:0:b0:360:853d:bda5 with SMTP id ffacd0b85a97d-360853dbdeamr389904f8f.10.1718351815886;
        Fri, 14 Jun 2024 00:56:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4f:2b00:69b5:3684:56c:6dd5? (p200300d82f4f2b0069b53684056c6dd5.dip0.t-ipconnect.de. [2003:d8:2f4f:2b00:69b5:3684:56c:6dd5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c9c1sm3599612f8f.44.2024.06.14.00.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 00:56:55 -0700 (PDT)
Message-ID: <63580668-bce9-4af6-a3c6-a444a78bedf4@redhat.com>
Date: Fri, 14 Jun 2024 09:56:54 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: 0001-mm-rmap-Correct-stats-calulation-in-__folio_remove_r
To: =?UTF-8?B?5Y+y5oCd6L+c?= <shisiyuan@lixiang.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <7369acecbf91db58e8c539678867170b5eef13e3.f5a34363.12c5.4c20.b839.0ef7c6407444@feishu.cn>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <7369acecbf91db58e8c539678867170b5eef13e3.f5a34363.12c5.4c20.b839.0ef7c6407444@feishu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14.06.24 09:52, 史思远 wrote:
> Dear mm maintainers,
> 

Thanks, but Hugh already sent a patch for this a couple of days ago.

-- 
Cheers,

David / dhildenb


