Return-Path: <linux-kernel+bounces-280297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DF294C852
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 03:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC119287992
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 01:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA3B1798C;
	Fri,  9 Aug 2024 01:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g6t6WFF9"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDD9175AB
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 01:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723168627; cv=none; b=RFiQyIDp9Crg8phYKLv3kB22UkvaaeLahr1M7WGHaCXDJ5Z2WY82aRPtiFrRa7u6J9MMpGdrsMBEFTXPz66T4HO0gB87v1JXxE1vjpnkrn1WH5cqK85ijDY2Y2p+KraNJHcVAoBzg9hMOh/ZsdanABHw6CkJ/x9u9Eq5t7jUKqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723168627; c=relaxed/simple;
	bh=r231GslQSVbZ+GOnXC04E/yfa0+FwVvQveaHgqzV384=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2fBt7OCD0OFI4g+6LcBiPatZfgG5xmvAnJe2eGKH5vSF1rGk5TxBpOH55mwlHjjBzd6ysV3NJ0tlrBQwq6esPqPJSCs6f9I7fkEhEFWsoeEAKWoWsjmgJ9h7rMystQjgar3gGwSkKUEqcHmi4SGXAJC/YXuj/UlQaYWRwETco4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6t6WFF9; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d199fb3dfso1287944b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2024 18:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723168626; x=1723773426; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r231GslQSVbZ+GOnXC04E/yfa0+FwVvQveaHgqzV384=;
        b=g6t6WFF90el5HB9T+PvC74d5VQS7Qg9SJzev1IASs2UVNtDplfe44Wn0SPuZbbLxCR
         M3rqPrTDg+RncqiutUqBGxwpLggYJhYDa0t76iHPseGiofpRsa7J3z4M9Y2KBTMNqEb2
         cNJaOVd2pjUfaK4kbOg3HeugpnvSxD+lfxIQxqqNRmyaKLTO86V+FkaBQfipk5DLdgL8
         yoU6NmZ6t3pKCZMqppMc3EJRH+C62acEqAsLFDJAsgDL5GcSZWr/ETkcowhagQd/vJBI
         rbhC0NKcrS7aIGvJTDWGNhrJSlO8S7shn+eMqKQQMfp66Cv3ihstDEZiOFEpGc0IEfAu
         jb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723168626; x=1723773426;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r231GslQSVbZ+GOnXC04E/yfa0+FwVvQveaHgqzV384=;
        b=Yhk345XvQF3iGmozJfxKx43VOV57uKdfYPx1HumpOA6gT4VHNb8CvEdn7pFzvuRmdY
         DYohfUlMppm1rlHstFAoHBjQkjEzakeIFIEUDurs6S72fNfs9XqsH5Y49B0AUaxrSwVW
         TJnBlEbxINXIhITn2GgxkV1SGpk8BPROXVxe/NnL1OUu703q9GvoMkkyl6OTfOrAoOq9
         u8m5PQACUJUrz3C0dDHko0/IxEzN1loSo5UFgGmEDF2NkIH1EcC/a9wDHHUp1WGMEpH3
         jrv5ZAFJ7gu9tIK66kWpZTsBJxQbnpQK2eFX7YdorhiBoWacBYirEm6XphAdoAcypLYH
         J31A==
X-Forwarded-Encrypted: i=1; AJvYcCXoHWKHTOjJFFw0rvEgKgu9X1Z4FzCkMnEvdScICbrTh2rDNQaFiDHnfRxAJV1Kw/8xHHdH5I0wBYau9cX9Eh1Gc/JafJF4RnHA4ME8
X-Gm-Message-State: AOJu0YxsEXo1URlnDdkjEQpCS7fCd/8RdquT2isGG56bR/4CKKE85S18
	PLnDKIV6j8JkO4TrMxK8dTw7rmmIc4TwJWmFPMZiuXCDgHiLX2pj
X-Google-Smtp-Source: AGHT+IFsXnoVru2zXzPqBvGcz6Q5PIOnYe1p2YXWbuYQS+0tZKmnsCbkidib+PZeD1jaaOhJVoh2Pg==
X-Received: by 2002:a05:6a00:139f:b0:70b:cf1:8dc9 with SMTP id d2e1a72fcca58-710dcab6e5amr8210b3a.25.1723168625576;
        Thu, 08 Aug 2024 18:57:05 -0700 (PDT)
Received: from [192.168.255.10] ([43.132.141.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710cb2e563csm1775535b3a.147.2024.08.08.18.57.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Aug 2024 18:57:05 -0700 (PDT)
Message-ID: <839f2c4b-5312-447c-a3de-6c8fc098876e@gmail.com>
Date: Fri, 9 Aug 2024 09:57:01 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/22] mm/zsmalloc: convert create_page_chain() and its
 users to use zpdesc
To: Vishal Moola <vishal.moola@gmail.com>
Cc: alexs@kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, minchan@kernel.org, willy@infradead.org,
 senozhatsky@chromium.org, david@redhat.com, 42.hyeyoo@gmail.com,
 Yosry Ahmed <yosryahmed@google.com>, nphamcs@gmail.com
References: <20240729112534.3416707-1-alexs@kernel.org>
 <20240729112534.3416707-7-alexs@kernel.org>
 <66ad2ef0.170a0220.8fae7.6e38@mx.google.com>
 <a3cc7157-6ea0-4493-8baf-c988b9fa4dcb@gmail.com>
 <66b50d7f.170a0220.2171ed.8a4f@mx.google.com>
Content-Language: en-US
From: Alex Shi <seakeel@gmail.com>
In-Reply-To: <66b50d7f.170a0220.2171ed.8a4f@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/9/24 2:25 AM, Vishal Moola wrote:
>>> I'm not a fan of the names above. IMO, naming should follow some
>>> semblance of consistency regarding their purpose (or have comments
>>> that describe their purpose instead).
>>>
>>> At a glance zpdesc_set_zspage() and zpdesc_set_first() sound like they
>>> are doing similar things, but I don't think they serve similar purposes?
>> zpdesc_set_zspage() only used in one place, a helper maynot needed. Let me remove it.
>> Same thing for the alloc_zpdesc() and free_zpdesc(), they could be merge into using place.
> alloc_zpdesc() and free_zpdesc() are fine as is. The helper functions
> will be useful whenever memdescs can be allocated on their own, so its
> better to introduce it now.

Thanks for suggestion. will recover them in next version, maybe tomorrow if no more comments.

