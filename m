Return-Path: <linux-kernel+bounces-277222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8BA4949E28
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 05:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74013284C7D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 03:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7E515CD54;
	Wed,  7 Aug 2024 03:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Yaq9buyM"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C30335B5
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 03:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723000181; cv=none; b=pYlQxaSM4gN0wQUnYfk7B/2zC0gt45ypGVPgPRvsc612XVnwSyLcx+JhB1Hv7jUiWeHUVuLJf3s5s74toTzgro70XFHbs4IKrOz0Wo6BnsnMMOxQq6pJz0iE3hU7e00qeXijSapBIgD885z8H/srtV8X8qj9MUKlPwL55gGUeUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723000181; c=relaxed/simple;
	bh=/Y+5bPdFTrBkCAoWYWE6pK9I0pUVLEdzAMx9qk6by8w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AT32NAiVI5+DzJJafCYX5mumF9AsII3Q+2pTAcjL5q/M2MdvBXl67NmMHooNWkWSX8N9yS4kQsmCXtuB3PUTxD/iZj3HDNPuitBNeDEgTS+paeD3RxhQ3JbKH4DV1j5+0zTFkxOCR6I8J47BvDjfFdO6MY7+pPGEU+gEt8TgDIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Yaq9buyM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d2357df99so65711b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 20:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723000179; x=1723604979; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p+tXfgdSdy3/a8aVP1yms8C2yNn64Nb95H3YLP/iWv4=;
        b=Yaq9buyMiH1qPVH+oFueQLZ1kW9XCxK6FtHH/CvF+eVOm5gWAJjgJmRM/JWOfKqjWR
         oAlQcEWsIcOMzB42QPYBgm2H0Sl6h/AguOw4DrURh4U/uFejzAA953CjPbkKFsb0l2q6
         YhP18wVqYaZen+7rvWcNXkolo0PXgl9mFyYusjBQHSQKwWqrDhDxWX72NOXiQiVNbvRM
         aPoc7RQTXxd079zWwiX1qSG2JD7/iZk9QLG6AEk7l9CEwPDc8MhSYY3w7trDmlWq1C+S
         w20yvxEcWHa8Nawb8QTLXC33WbDsiqnGPGyAj3Nj7uqqRgVpdLYXoWmCHj+ABlNi9H1N
         rhzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723000179; x=1723604979;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+tXfgdSdy3/a8aVP1yms8C2yNn64Nb95H3YLP/iWv4=;
        b=svMOMUMzn1uCW/ZLemJ+t7k3Wk0rqV8CibjkSdzyLqKaf9IpIsmTePu305cztJQmWO
         a4J4Hc1OODx31/53IubXbVdYNY+gSr+r4EpIaVzBWwaQjXW7i/LuvovDnLX6gnY99nZB
         NENDB10cGX5i4j8ZnKHYvUn+HrQLUtAet0GbtkRlkSP3rPaKwhwF4bnzIARKpgczW+4o
         GCOUxmq/4ilRLBPWOElEJUrWgJFx2eOmu1NziiiCvy35rOtbi+Szebp0asTBEOU3UCY4
         nMwomOmwUoZiC1uNMtYuCFjmHG5Lv7aYhy0DVP6eJ3IxrqJ+jACKV72EQNgIiDfj62Q9
         F5jA==
X-Forwarded-Encrypted: i=1; AJvYcCXg0xqWUHkzUYidufT+5vOUxuiYqBO8DWrsSJrPg4a4Aiul6nFE9OtP+zJzPwEYTeBlk1yhRo73oZFcRxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPKL9ac6nRTlKz+Uuj/zClvlVh9ye2rjemwr1a4s0YHT9KJZjW
	EDP1ysuLOeHPjCNy0Mbi3R9wxCWPp6jC6G7DTPqWmZvHNQiDa7Ub93iQs0CKAaE=
X-Google-Smtp-Source: AGHT+IGNdJ4lsslw/4kIK+2+a9FPU0qfrhQMJO0FhiVALS6W4bUsiQ4MMZ6BHJsYbnxb8vUBuXEqhw==
X-Received: by 2002:a05:6a00:1152:b0:70b:705f:8c5d with SMTP id d2e1a72fcca58-7106d0992c6mr11779872b3a.4.1723000178606;
        Tue, 06 Aug 2024 20:09:38 -0700 (PDT)
Received: from [10.255.168.175] ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed15367sm7811965b3a.175.2024.08.06.20.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Aug 2024 20:09:37 -0700 (PDT)
Message-ID: <6a535435-724c-46b5-95b2-103b183753bf@bytedance.com>
Date: Wed, 7 Aug 2024 11:09:33 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/7] mm: introduce CONFIG_PT_RECLAIM
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>
Cc: hughd@google.com, willy@infradead.org, mgorman@suse.de,
 muchun.song@linux.dev, vbabka@kernel.org, akpm@linux-foundation.org,
 zokeefe@google.com, rientjes@google.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
 <7c726839e2610f1873d9fa2a7c60715796579d1a.1722861064.git.zhengqi.arch@bytedance.com>
 <20485870-2156-4b60-a8f7-bc3d9a2f98f9@redhat.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20485870-2156-4b60-a8f7-bc3d9a2f98f9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/8/6 22:25, David Hildenbrand wrote:
> On 05.08.24 14:55, Qi Zheng wrote:
>> This configuration variable will be used to build the code needed
>> to free empty user page table pages.
>>
>> This feature is not available on all architectures yet, so
>> ARCH_SUPPORTS_PT_RECLAIM is needed. We can remove it once all
>> architectures support this feature.
> 
> Please squash this into #4

OK, will do.

> 

