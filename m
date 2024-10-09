Return-Path: <linux-kernel+bounces-357272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E55996ECB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2FA28443A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 14:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E858D1A262D;
	Wed,  9 Oct 2024 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AI8q1xHy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6D819DF64
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485596; cv=none; b=UYOekN7WhN9ka0RudjXWzFHPyUP800eVe83H5Q9esVDlZiLdX8OtzryJ5wKOvhGWcGYYNk4dlk1IHCTTNRkw3hkCuG7yGisMCQBJeeFRF5bAe/MndzRup2Asw6o5wSkfcAfAKp9/1wkUBtBu26KdexrrhlqumzQspsHz7Qe9K1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485596; c=relaxed/simple;
	bh=UBFEi1ZanyCIFF8STF3JBKUeL6Ye2vx3cesN3MY37M8=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KCygPL2/t+zCndRclHY0N6cJcg8hmcM3GN8k6nZC0Am9K/ehsh0fmJ4hYMH9orGwhgWngHQAOWAV7bcf9zTRH443QVo6ib+pf4CykNUMWA1YsbA3it16OLfo3IMGpLcPiX26g8cfJJXJoI4LdOvn5A+Tbz0nQeSQwseNFJuNNoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AI8q1xHy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728485593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MsdC7C06B7k23BEVtNiQKiVWI2syGR/GUAuS5PTFvrw=;
	b=AI8q1xHyn7AB9n2di4unB64erGJ5RuDpCpQtdj63we7ChSwTwKlCf0G1wFyTu/Mc08ISff
	jQ3DOjDNx4sLumamn2RmuHkQViUH5Bw2XtvV7pm1SigGOTsgOye2i2/a8z/oH4KEPMlhzK
	tC1YSJzgYgQqFjZfcNsuMs0jFDnM5Nc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-GWhlVOHvNJaE9Y58Zbs7WA-1; Wed, 09 Oct 2024 10:53:11 -0400
X-MC-Unique: GWhlVOHvNJaE9Y58Zbs7WA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7ae3f3529faso1622055485a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 07:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728485591; x=1729090391;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MsdC7C06B7k23BEVtNiQKiVWI2syGR/GUAuS5PTFvrw=;
        b=BRPMe33Iec5SjpwU8IlDHuoZGz5bvHqmVn0W3dXZP6BKPuVxEpdnzC7ddpdgTTpvwn
         XdL/eD6+SUFfRkLPvF9phWbvTVX/Nne+/dgoGiSYfQpXgAe6WdeIiFXCNYotOfK5AZ1w
         x5XYTQFM0aoH7lP/RH1dgExO2ZSXFG/xW/yt+qYuVGBN49UTjtWJkSBSUiu2jlhA4Jj+
         H33/YNWKkpFk22oz3UqSVeThSJZyStFWa/pKWJTBanL2gzFT/KkxJIwKMLzWEBKNsgRU
         3Kv9Lz/nB78nVHTiVxRD/zTybT87cDS8RUjR0Sp2/djL/WaDAn2pByWe0lYVKrDb4uEa
         25LA==
X-Forwarded-Encrypted: i=1; AJvYcCUHP5rPjKfdLRxMpDM/ByR0ivS4X66H3Xc8nt9or4cEOvJ04TaqOk8itao1SPiNfJyXFdp7n3IhceYX+sw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIrg0gbQc8KJ4vKmUnKeKFhP4P/sSczelf1DlKZoArssvfni+9
	M8q3SCOYS+SuGRGRefIscA47U5ROt7RhU82DdLRtzz97PXX1qeL1fchaO6FS3npvkICf8xA4L0e
	e5zi4oMdNa8s2t9tPAvEMCHXCj4LYixd2rewf6+lCjnYYLiSWz86zz6gHCDzNbg==
X-Received: by 2002:a05:620a:49e:b0:7b1:e0f:bf80 with SMTP id af79cd13be357-7b10e0fc34emr256702885a.42.1728485590926;
        Wed, 09 Oct 2024 07:53:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXAlBvIZWz9PJb1pjw8gqt7q7KhU5Ab+Omw9uNCFTuXhTPuyOntGqUouutFwxlsNlJRpXcpA==
X-Received: by 2002:a05:620a:49e:b0:7b1:e0f:bf80 with SMTP id af79cd13be357-7b10e0fc34emr256699585a.42.1728485590513;
        Wed, 09 Oct 2024 07:53:10 -0700 (PDT)
Received: from ?IPV6:2601:188:ca00:a00:f844:fad5:7984:7bd7? ([2601:188:ca00:a00:f844:fad5:7984:7bd7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7afcd34d20fsm138713985a.114.2024.10.09.07.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 07:53:09 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <1ccd6411-5002-4574-bb8e-3e64bba6a757@redhat.com>
Date: Wed, 9 Oct 2024 10:53:08 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Enhance union-find with KUnit tests and
 optimization improvements
To: Kuan-Wei Chiu <visitorckw@gmail.com>,
 Christoph Hellwig <hch@infradead.org>
Cc: xavier_qy@163.com, lizefan.x@bytedance.com, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com, akpm@linux-foundation.org,
 jserv@ccns.ncku.edu.tw, linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
References: <20241007152833.2282199-1-visitorckw@gmail.com>
 <ZwZIXxQLyJUL_nOW@infradead.org>
 <ZwaPdSOMWQzuoPWU@visitorckw-System-Product-Name>
Content-Language: en-US
In-Reply-To: <ZwaPdSOMWQzuoPWU@visitorckw-System-Product-Name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/9/24 10:13 AM, Kuan-Wei Chiu wrote:
> On Wed, Oct 09, 2024 at 02:09:51AM -0700, Christoph Hellwig wrote:
>> On Mon, Oct 07, 2024 at 11:28:27PM +0800, Kuan-Wei Chiu wrote:
>>> This patch series adds KUnit tests for the union-find implementation
>>> and optimizes the path compression in the uf_find() function to achieve
>>> a lower tree height and improved efficiency. Additionally, it modifies
>>> uf_union() to return a boolean value indicating whether a merge
>>> occurred, enhancing the process of calculating the number of groups in
>>> the cgroup cpuset.
>> Given that this fairly special union find code is obly used in the
>> cpuset code, please move the code there rather adding more exports.
>> Even as-is it is bloating every kernel build even without cgroups
>> for no good reason.
>>
> I noticed that it was Michal who originally suggested putting the
> union-find code to lib/ in an earlier email thread [1]. Before I send a v3
> patch moving it to cpuset, I'd like to hear Michal, Tejun, and Waiman’s
> thoughts on this change.
>
> [1]: https://lore.kernel.org/lkml/wu4m2m5igc752s5vrmtsnd7ekaq6opeqdtrzegs7oxlwgypdcx@qhcnow5txxiv/
>
> Regards,
> Kuan-Wei

The current union_find code is pretty small. Putting it there in lib 
allows it to be used by other kernel subsystems when needed. I believe 
it should stay in lib. If a slight increase in kernel size is a concern, 
we can update the Makefile to make its build depend on CONFIG_CPUSETS 
which can be taken out when it is being used by another kernel subsystem.

Cheers,
Longman


