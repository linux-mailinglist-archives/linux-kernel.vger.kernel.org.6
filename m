Return-Path: <linux-kernel+bounces-291689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D12956598
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7055A28315F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BBF15B119;
	Mon, 19 Aug 2024 08:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RRHxx95X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B8B15820F
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724056137; cv=none; b=AYDPQkxacHEghHbBVh8yhu7zEVxpC1ZG59I5TgtWE8de3b/xlKymApzHJSQi4/JPyamTqLhumN+rp46tLmLBCGBl8Wx21mpD2iA0fQLC3b85a0hjgFmoiDPEFIrzosOyqtD6nqEjt4vObuZqv6y6rLXPDfGI5n9H1ILscd/ynws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724056137; c=relaxed/simple;
	bh=4HQK+0zTtMgFxA6gwLoLkDHT5cQzPNNmCi1qimC/SK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lMWgbVbAbpPz+b2EWjOamv4iLdxh3rFCOrxW5PLcKln8QK/erQVoco4XfW/YIT/T+SJ32E0dF/vhjVU6Jsl6ZRNNs/9xO1TrMq8DfemiEO9Fwiu1LVlHXzTpKYFVQN1nM/ZPknCK5gScrWe1R4bVINUxF0otrLiVlveim5+vX1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RRHxx95X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724056134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BXTC4iCYopsco8GyWo/NHJEKhgLVBRfR2EbC4DYmVsA=;
	b=RRHxx95XeQWPxvLBDE/wGQt5WMrzOf44ozv3dLzjdWZmicp+AfMPNVZ0pMEQTDHBMV2RdF
	cYDw5HKa7iRmtTlENsjPLktaarHRIfFTx4p4gKZumbLkNy96SrRYOT0HjgZRPZDa3/rHGE
	puoUwbTyRA5YxnSPoFwuj6WcA+0T8pc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-A34vnd3mO6STInogSyJHsA-1; Mon, 19 Aug 2024 04:28:53 -0400
X-MC-Unique: A34vnd3mO6STInogSyJHsA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a7ab644746eso274002966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724056132; x=1724660932;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BXTC4iCYopsco8GyWo/NHJEKhgLVBRfR2EbC4DYmVsA=;
        b=P+/pxeRnb/JORFgggqawuAywmK4ppZP3Egem45w/MtAGqn/5IiKjwwO0XFksUDB+3h
         44jQhFwLZHWrd/ryqlUSDUbmHMW7mZol2FEjTarqIt7drmoqwZ19zoNgYM8K5CMDcQNe
         fICbRYIyr5AjVoI/qUmCmP8wIY19wy6Chn5aCCw4uPecYZNsjpxIRLT2PK5AlhIHKGyZ
         X2QzCFaQJmKVM1XQ6JCVOLFNjz66dgsVJHguSm4n5gSHeQsim7ftPwSyOsiVtqE5jZdL
         RDZ3wLdjdskR3eU4V0e1Lyq9JD5uGxeQD1xiw0dyANC3r0+iML2VTiaZ8isvca9V6ba0
         Uq2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmonkziakX8GrKlBb3lsNSr0os0aorkFYnVCoprYnHb2hJQV1NlIISWOvK+ZIgTJoWaiJ7gr8pBExEBWSqL/Ioz38sEyg2gsAdf+nf
X-Gm-Message-State: AOJu0Yz6JgckBwkLyXv4PhnWsJwD3NA2GhedFtrBkoV8HCFnnTXQzC6b
	dwVPFbl/JROfeblvdviWRtvh5rkyzLl+ZupbxBuhsevbt7TuGEYfdjWzK1Ix7zVgVpnW4P9dcjE
	FN35jRhqD76sC1LnhkGJOmk8Rypy2Ovb33rgMSDntxUcuO54xxuyrxd7cBFnG+Q==
X-Received: by 2002:a17:907:1c22:b0:a80:f6f2:e070 with SMTP id a640c23a62f3a-a83928a3333mr804132766b.3.1724056131898;
        Mon, 19 Aug 2024 01:28:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBb5MNEDm6zQQ0yCzIXMA3G3NpcYfgaUrZrUd3Z5P16R+B1treJozyDARF63//zt5EBb4qWA==
X-Received: by 2002:a17:907:1c22:b0:a80:f6f2:e070 with SMTP id a640c23a62f3a-a83928a3333mr804130766b.3.1724056131434;
        Mon, 19 Aug 2024 01:28:51 -0700 (PDT)
Received: from [100.81.188.195] (ipb218f908.dynamic.kabel-deutschland.de. [178.24.249.8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383946517sm600570566b.169.2024.08.19.01.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 01:28:50 -0700 (PDT)
Message-ID: <c817bf05-a9fa-4fb9-b8c6-a1de5a44e59a@redhat.com>
Date: Mon, 19 Aug 2024 10:28:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] mm: collect the number of anon mTHP
To: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
 linux-mm@kvack.org, Usama Arif <usamaarif642@gmail.com>
Cc: baolin.wang@linux.alibaba.com, chrisl@kernel.org, hanchuanhua@oppo.com,
 ioworker0@gmail.com, kaleshsingh@google.com, kasong@tencent.com,
 linux-kernel@vger.kernel.org, ryan.roberts@arm.com, v-songbaohua@oppo.com,
 ziy@nvidia.com, yuanshuai@oppo.com
References: <20240811224940.39876-1-21cnbao@gmail.com>
 <CAGsJ_4yMu=aaQZEXtcwCdMgrxUuqQ-9P1AiqyyVLfehD_-my9A@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CAGsJ_4yMu=aaQZEXtcwCdMgrxUuqQ-9P1AiqyyVLfehD_-my9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.08.24 09:58, Barry Song wrote:
> Hi Andrew, David, Usama,
> 
> I'm attempting to rebase this series on top of Usama's
> [PATCH v3 0/6] mm: split underutilized THPs[1]
> 
> However, I feel it is impossible and we might be tackling things
> in the wrong order.

Is just the ordering suboptimal (which can/will get resolved one way or 
the other), or is there something fundamental that will make this series 
here "impossible"?

-- 
Cheers,

David / dhildenb


