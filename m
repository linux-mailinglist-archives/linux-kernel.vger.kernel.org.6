Return-Path: <linux-kernel+bounces-280483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843C694CB3C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 09:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3582128530C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 07:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B582174ED0;
	Fri,  9 Aug 2024 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LURrz+SA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336171B964
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 07:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188281; cv=none; b=MoFtP5D97o6nF8xTxg+M67ShiGnDBOWWhv/+mFNFhYdAaQfVaEzPR0rT7nBaFRamL9t06nAhynK0ahtKo/Dx4KKI+r6bO9cNH6ACqVRSCqonmyTnYNQrfF3c5J7XPdiGIp2nTAPsv/71vXeabZVd0kDlftNdRQRR4DIDRw8h5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188281; c=relaxed/simple;
	bh=ewX9/GsQstth5A9N7fhLWAUVPHAZJV3R/2Jqztqo6f8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=lbevXy/LJMcuHkNVV9ywjx8glfbKbefIbttOTNwA43MTZnHE9GOEuPxuEhck6nHxsrkAIYZfLbG1CY6ocezXgb9eIqJWxloNdi7UlaCx8D55NBPgCgNcbLNaRxuCSenckyFAp1L7qNdsW2RDbDPZg+HcBPg2yH10vtmbl18El1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LURrz+SA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723188279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=j/+G9Q4Qg8gYAjoxNTSdgau9K5llB7hyj6r+le5aqV0=;
	b=LURrz+SA4G4nOLtxH+9W4zwaChqHrHdVLwI3+/F/QAsMjOnid+HpBtGNH7GsNilRPWBmy6
	0Zwz81oc1ThxVSt35e4pRtQn+tdjVMiQiGwUfAfLyDk3tLAp4IhKGoKLeW3OalCwgAetsz
	8KP3HulHwITsQoIufMm6QDuFO6WMzfY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-255-cFoy7VmZNsy2sOZsWeHb-Q-1; Fri, 09 Aug 2024 03:24:37 -0400
X-MC-Unique: cFoy7VmZNsy2sOZsWeHb-Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36865706f5eso916754f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 00:24:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723188276; x=1723793076;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j/+G9Q4Qg8gYAjoxNTSdgau9K5llB7hyj6r+le5aqV0=;
        b=d8aNj9iBgYcX5WbegurJCibhzV3CWlAfnG4T0o7xFNmItOdf++LekHR8fSQu47eLFj
         oa40jxiZ39j2FvibuZLJmgPRo6UKBbJ7cTU7tx6VzvnY2ZuGSIha7B8ZkNDVZecVeBen
         94jC9rUzXtasbr8aLG80tuMVn36ffVOpJHzIerbam0Xg9i9mmw6bdxHjf6ceZHOdmeLT
         2zRLX4guKIo2JuEtGODFZTdDRhBrOKEl0DEg1gBvzk3Rchg9oCdvxSRembBPaAHqi5X0
         R9aMYONnPjwMwTPZi86he398HGusDehlp4aSZs4u72cxNvgYQJzNSmHSzYsYDGvLG5+c
         0a4g==
X-Forwarded-Encrypted: i=1; AJvYcCUPo06nFH1ZFxaxKFm1LdEMH4ykh6Z78LVIWE0w0QgldQzcHo0MIV3Zo2/ZRc8F1mmF1q4DymwiWXSFvGyi0I0F1UKru39nyZ7YKloe
X-Gm-Message-State: AOJu0Yxo0lbE6Es7+IROHrRAbrYhE0mWzYaa5jIx86KWAsTE6W0zpdLd
	npJnXvUTomRkX4WveqpZEts3Ypis8R1TtJfVenYBBr2xOVF2DzCaqKNBbOXjhUpJdfVYQwnyquo
	XzxXRYcBm5bT9LfVpuIBYazUgiKMTx6tuRsUc4PxJfWa5+FM6//D1Xv5D18GGlA==
X-Received: by 2002:adf:f412:0:b0:368:5d2:9e58 with SMTP id ffacd0b85a97d-36d5afac168mr545195f8f.0.1723188276512;
        Fri, 09 Aug 2024 00:24:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5K/cWHBZlnD10GL0QjC33JAUPKIJCOBt9+rLXzJa7A8QX3uFSITBUB3VFCBvPu2ABanpUZw==
X-Received: by 2002:adf:f412:0:b0:368:5d2:9e58 with SMTP id ffacd0b85a97d-36d5afac168mr545172f8f.0.1723188275979;
        Fri, 09 Aug 2024 00:24:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c71c:4e00:b097:7075:f6ba:300a? (p200300cbc71c4e00b0977075f6ba300a.dip0.t-ipconnect.de. [2003:cb:c71c:4e00:b097:7075:f6ba:300a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d272290c2sm4408217f8f.92.2024.08.09.00.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 00:24:35 -0700 (PDT)
Message-ID: <017b4c44-efca-4160-abd6-ed84c36fa06b@redhat.com>
Date: Fri, 9 Aug 2024 09:24:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] mm: add system wide stats items category
To: Pasha Tatashin <pasha.tatashin@soleen.com>, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-cxl@vger.kernel.org,
 cerasuolodomenico@gmail.com, hannes@cmpxchg.org, j.granados@samsung.com,
 lizhijian@fujitsu.com, muchun.song@linux.dev, nphamcs@gmail.com,
 rientjes@google.com, rppt@kernel.org, souravpanda@google.com,
 vbabka@suse.cz, willy@infradead.org, dan.j.williams@intel.com,
 yi.zhang@redhat.com, alison.schofield@intel.com, yosryahmed@google.com
References: <20240808213437.682006-1-pasha.tatashin@soleen.com>
 <20240808213437.682006-3-pasha.tatashin@soleen.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240808213437.682006-3-pasha.tatashin@soleen.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.08.24 23:34, Pasha Tatashin wrote:
> /proc/vmstat contains events and stats, events can only grow, but stats
> can grow and shrink.
> 
> vmstat has the following:
> -------------------------
> NR_VM_ZONE_STAT_ITEMS:	per-zone stats
> NR_VM_NUMA_EVENT_ITEMS:	per-numa events
> NR_VM_NODE_STAT_ITEMS:	per-numa stats
> NR_VM_WRITEBACK_STAT_ITEMS:	system-wide background-writeback and
> 				dirty-throttling tresholds.
> NR_VM_EVENT_ITEMS:	system-wide events
> -------------------------
> 
> Rename NR_VM_WRITEBACK_STAT_ITEMS to NR_VM_STAT_ITEMS, to track the
> system-wide stats, we are going to add per-page metadata stats to this
> category in the next patch.
> 
> Also delete unused writeback_stat_name() function.
> 
> Suggested-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


