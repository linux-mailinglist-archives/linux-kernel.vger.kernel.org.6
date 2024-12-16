Return-Path: <linux-kernel+bounces-447977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C79A9F3974
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 20:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07B08188A909
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 19:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666B82066F4;
	Mon, 16 Dec 2024 19:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MRQJH/MP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312792F5B
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 19:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734375877; cv=none; b=L70I8Q/mrvkaqDqr5HfiHYxzVJIJq/a4IueUisaiEqV6+jCti9XIcEkRQJGNvqMqOXpqCZH/yJxLbaLOPGTBD694wHpX25iRM+eCf1jQeIkO0oLmfHrMrD5FB4i4vik9vkx3VfC4brRl5I3CQbggEhDBFGvQCpRaEiVxnFGmwuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734375877; c=relaxed/simple;
	bh=fJUiNMpOQvRkIRDBSYKmwoXECAPXgC+TdlaIIpnXzQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpFr9dQeW7uPkU1jXcyPy/Mrx9M4VKlT8m0CAUZmfNUDqVAkkD4/vKsnAaPrPeO9Pw6YQ/BizJ5oHkIx9tjGqCXJ6Vi7kn7+oMBS+ELsJN3XGxiG0+T/sxujBIfD8ixDD0m0aTgr17ytBUWEbb/a7wtC6Q755cqDyCJk6pzIbvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MRQJH/MP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734375874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4TAyoTcpg5C07EBdJR8q26tZw81IL7bJn8uvwRbzII=;
	b=MRQJH/MPXSrcP+a51ikNXPgMfB2FTgF1EVmQffYpNm3ip0Etfs0jDQqCkSy5prWBJc8ktS
	xHNhgO0Kp9cqExF3LnB9k7d/kVzcD4NVA/GKW+u+p89CsDx2Hw/LrIjgA87gm8BrvOncks
	Q8nmGmJnea68S/3dQ2OfhRcH8yQpqVg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-tXchM9LWOzufR17xzDe5iw-1; Mon, 16 Dec 2024 14:04:31 -0500
X-MC-Unique: tXchM9LWOzufR17xzDe5iw-1
X-Mimecast-MFC-AGG-ID: tXchM9LWOzufR17xzDe5iw
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-46791423fc9so99345701cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 11:04:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734375871; x=1734980671;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P4TAyoTcpg5C07EBdJR8q26tZw81IL7bJn8uvwRbzII=;
        b=bCVVrukCZeY1KA4NYH1ka6fBTMwsljgvbQRHU9oChZd/uqZXDvtegbpr3bWRvDx0K7
         PKftOukCvLStWkDg9ke90q+TzAxLH+3OEVYOSZUmJ7U29ZlceGvYq+ZEr0m/YqUwP9lf
         /tzcdFl4mTiWkolaSuzd2znRXkllsuL3A8OZGfXwKguKExMBh5zaDNIhQyLBuljKll0C
         YZ6r/Gtn8tzYfSC/8ht6jW2x4AXn+qKHzn6/ELOUU/c6OWOFv92iWN6BVChIePbWFTw5
         DCAuxUKqmLDp/+f6vlyfpHYLrWXc7VFK3630N+Vd6nRQYEKaq+krS/XEF4oA+fiGEyDZ
         jSxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDPTEsANh+MR7A2yzt3SWXibXQjLJiRaetANqJM6R4B2Mxfm3Mj/FcdS8tLEAllOURqj3/Qp+YivlU6AA=@vger.kernel.org
X-Gm-Message-State: AOJu0YynIPzgNrEdei2dzSGna6A3M/VYETQK1jj5nXnR7SJ2V13XJY86
	q3pYn0EfLIs3BC4XdE6l+yfWCr+KWj2juIraqff1em4xQUwLdTbbXOiMnghSMlGxqX2TTX65ae9
	Afat1TeKrTlI2vNRa2GeM/x/dDjWwbsI3a5rRgnh8sYwJ7tkNr0zhPw+pa8ppHQ==
X-Gm-Gg: ASbGncsiGq932GhI3o7pMa7g2FAh6Zhguan8lDAjscuVlGLDTXi2+iZy268l3hv7fxj
	ElLUxkA51BFSKoCOtLwsidXtHapKT5Jg8Gcumw5/Pk36KGEhU35Q+C/YOmYyCSbfKgdDHcZvGBl
	BdCX0n/B5MYoHZgY48rf1OUs6DgRlNmAr6v2cVDr1KAhVePqVkBKPd3HISbCXFj3qwHm2QZCFn2
	0+LbFmrCTVcLLC1IaK0ZhmnYlr36GHm9FEyL+H00q+/JbiACVbt8A9N
X-Received: by 2002:a05:622a:90:b0:467:5457:c380 with SMTP id d75a77b69052e-467a582d0b3mr253847781cf.52.1734375870934;
        Mon, 16 Dec 2024 11:04:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGtMRSRuUhywNVqQ8BPcpuSFP0ZKJyUAs0jfELdRVUC1+zKG6YNTFyDt+VKU8Nvt1jruKDpqw==
X-Received: by 2002:a05:622a:90:b0:467:5457:c380 with SMTP id d75a77b69052e-467a582d0b3mr253847381cf.52.1734375870605;
        Mon, 16 Dec 2024 11:04:30 -0800 (PST)
Received: from [192.168.2.110] ([70.52.22.87])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467b2e93bb7sm30830981cf.70.2024.12.16.11.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 11:04:30 -0800 (PST)
Message-ID: <ca53b64e-3d89-49bf-a95b-9b37d9d1d9a6@redhat.com>
Date: Mon, 16 Dec 2024 14:04:19 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] mm: alloc_pages_bulk_noprof: drop page_list argument
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, mgorman@techsingularity.net, david@redhat.com,
 linux-kernel@vger.kernel.org
References: <20241216184504.19406-1-luizcap@redhat.com>
 <Z2B3yMiYLwoc6VJB@casper.infradead.org>
Content-Language: en-US, en-CA
From: Luiz Capitulino <luizcap@redhat.com>
In-Reply-To: <Z2B3yMiYLwoc6VJB@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-12-16 13:56, Matthew Wilcox wrote:
> On Mon, Dec 16, 2024 at 01:45:04PM -0500, Luiz Capitulino wrote:
>> The commit 387ba26fb1cb added __alloc_pages_bulk() along with the page_list
>> argument. The next commit 0f87d9d30f21 added the array-based argument. As
>> it turns out, the page_list argument has no users in the current tree (if it
>> ever had any). Dropping it allows for a slight simplification and eliminates
>> some unnecessary checks, now that page_array is required.
> 
> Maybe just fix up Mel's patch:
> 
> https://lore.kernel.org/linux-mm/20231025093254.xvomlctwhcuerzky@techsingularity.net/
> 

That was fast :)

Yes, I can do that.


