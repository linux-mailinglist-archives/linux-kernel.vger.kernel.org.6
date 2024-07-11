Return-Path: <linux-kernel+bounces-249741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F3D92EF3B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E041C22688
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 18:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE17716EB42;
	Thu, 11 Jul 2024 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kq43newY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95121161939
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 18:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720724193; cv=none; b=M9Jm2w0flVF5iglaoFz26+RCvrm7B2Og5NlA3p+BM6P8rW8khVQgM8eoq4upG3MxDbK8Ss5+JRC/4EUI/ymElaMh57uM+QJKCt+oZzYv6vZwvVo3wLv6022V5jywZKO4e0Nyc+TLns8KyPx3dyfbipWJIbLcytVkAe7w1nFrVfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720724193; c=relaxed/simple;
	bh=BvzN/zrI1Lg3aYVeeaVXdZJS1wjmXQPsNWjPosdonw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZLuXswJ73EtVIsCuCwYEfBiCCnW5SyBIpVylEvBUYZPPNYq2BYAWoQy3fvWIt0AzgMMzKxYgiIOYGwow3a+MaxMKJ/eAruacmibB4z3QWUNdV/r293QvAwotu8VRSnXW5sHynzP545NIWabueGKhLZtvyaSMWvgXHdLj+Qrd2oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kq43newY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720724190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8h7F4MlqrWHgk+nNfd6Cl6q2WvAakceBMWnBSEiYFJk=;
	b=Kq43newYim+rVJllD63lNnyOtiCVWKtwEIRoQLNaHKXlh9iZvnIdESGH3+xF/yz2xhDkQM
	4v+l7Hm1ok79R9Yq1BrbPLPf+ak+YeVuJibwrWKltWodSqajt12uP5p5Kh38GlpBhuSeCa
	bK5VR/R6lunrw1beCVJZl7+xZ3/YHFI=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-ZutyVaroOuylDFnrbhsJ0Q-1; Thu, 11 Jul 2024 14:56:24 -0400
X-MC-Unique: ZutyVaroOuylDFnrbhsJ0Q-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2c974ec599cso901317a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 11:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720724183; x=1721328983;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8h7F4MlqrWHgk+nNfd6Cl6q2WvAakceBMWnBSEiYFJk=;
        b=xFwSXDMg/grT2bmBjpUZEZmw49/7mzTX4Z4ccP23PLGQ/t1bEnU+iqcLatpA7DB/Me
         rmP1QcVhqnCkImeoi8Ko7iaTeTY5y7Pb9RZfH2hN8Anog5yBy7JCJ9lKdB4FgQM8k5At
         nyJsrrFCK9hjwzEIR7Eys9/ZzyXFIVDTf+VkvnjNJOkGCMRmd+b/mQZzHx7U481Dcvs9
         LJNXFwwSpUwqYL9CylndDE2jaDMYxzDaFznmT8wJO1KXJczskHptKZdxmXYKmn/Cc08A
         edJSWHGWUUcbzV20EPj5A4X57H7w9HzyxwZeVgYSUof+kp1wNcSI3nodgZhz2PvRSCEC
         P2TQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0olijEe7oEILyM0Y4gxCWO2IQWQ6zu1FF1CtG9AyJPj2qqIOCSGXRCZ/eyD7meVD2JMEeOqTA4ylCX8G/2hVUdSb0NyUwNOVbqZwB
X-Gm-Message-State: AOJu0YwDdZAWHXigfctrLu/ZDlSPIP+yBSLfs4ERMAULAvn81uF1EVKQ
	Imq6Dz5joHO6MomDs5G/uyPnV48wR8mh3WJN3Gb2YJ3noq59AJVirnrQ7Ax22B+OmRQyiOG+Tkw
	inv3ep7EDei8fYkSJAD3wy+WZ6aSWZ9zCN+pwrZ/r9Pht/8W/zpa2ZqpNJ6Il/A==
X-Received: by 2002:a17:90a:e648:b0:2c8:f3b5:7dd1 with SMTP id 98e67ed59e1d1-2cac6e3ede4mr664291a91.16.1720724183521;
        Thu, 11 Jul 2024 11:56:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCeGooxyB497nu/OI0/YZImP0In9UtmI/QnPSNNDvRuaucq4SMLS65EYW8tw2xfvfuPAj8dQ==
X-Received: by 2002:a17:90a:e648:b0:2c8:f3b5:7dd1 with SMTP id 98e67ed59e1d1-2cac6e3ede4mr664261a91.16.1720724183031;
        Thu, 11 Jul 2024 11:56:23 -0700 (PDT)
Received: from [10.35.209.243] ([208.115.86.77])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c99a950c37sm14149003a91.13.2024.07.11.11.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jul 2024 11:56:22 -0700 (PDT)
Message-ID: <443146f4-9db8-4a19-91f1-b6822fad8ce8@redhat.com>
Date: Thu, 11 Jul 2024 20:56:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v22 1/4] mm: add MAP_DROPPABLE for designating always
 lazily freeable mappings
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, patches@lists.linux.dev, tglx@linutronix.de,
 linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
 Carlos O'Donell <carlos@redhat.com>, Florian Weimer <fweimer@redhat.com>,
 Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
 Christian Brauner <brauner@kernel.org>,
 David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
References: <bf51a483-8725-4222-937f-3d6c66876d34@redhat.com>
 <CAHk-=wh=vzhiDSNaLJdmjkhLqevB8+rhE49pqh0uBwhsV=1ccQ@mail.gmail.com>
 <ZpAR0CgLc28gEkV3@zx2c4.com> <ZpATx21F_01SBRnO@zx2c4.com>
 <98798483-dfcd-451e-94bb-57d830bf68d8@redhat.com>
 <54b6de32-f127-4928-9f4a-acb8653e5c81@redhat.com>
 <ZpAcWvij59AzUD9u@zx2c4.com> <ZpAc118_U7p3u2gZ@zx2c4.com>
 <ZpAfigBHfHdVeyNO@zx2c4.com>
 <8586b19c-2e14-4164-888f-8c3b86f3f963@redhat.com>
 <ZpAqbh3TnB9hIRRh@zx2c4.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <ZpAqbh3TnB9hIRRh@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.07.24 20:54, Jason A. Donenfeld wrote:
> On Thu, Jul 11, 2024 at 08:24:07PM +0200, David Hildenbrand wrote:
>>> And PG_large_rmappable seems to only be used for hugetlb branches.
>>
>> It should be set for THP/large folios.
> 
> And it's tested too, apparently.
> 
> Okay, well, how disappointing is this below? Because I'm running out of
> tricks for flag reuse.
> 
> diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> index b9e914e1face..c1ea49a7f198 100644
> --- a/include/linux/page-flags.h
> +++ b/include/linux/page-flags.h
> @@ -110,6 +110,7 @@ enum pageflags {
>   	PG_workingset,
>   	PG_error,
>   	PG_owner_priv_1,	/* Owner use. If pagecache, fs may use*/
> +	PG_owner_priv_2,

Oh no, no new page flags please :)

Maybe just follow what Linux suggested: pass vma to pte_dirty() and 
always return false for these special VMAs.

-- 
Cheers,

David / dhildenb


