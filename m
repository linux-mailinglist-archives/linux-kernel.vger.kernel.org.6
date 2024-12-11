Return-Path: <linux-kernel+bounces-441146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2251C9ECA4C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDEE8282723
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B32A1EC4FF;
	Wed, 11 Dec 2024 10:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EI8CYOc/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBB5236FB2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912866; cv=none; b=ewhJZY7LBfH5r0G2QElIxn9HtSU98WRNQIV+CIWF2EQCAryyykC9pWVrDaJd6FiceY5Rf9QhaeS69n80JQhIMoiHQ08DaYzhn9sz7B5b+4fkTHw/EaCdoLw/kx2WX+f57XrgjxjwoWEvK+Pk9Z1mN3e+qhUTP/lpI1dGdEZYHlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912866; c=relaxed/simple;
	bh=VGIdTReu9oFNmZG3uMqjmgoUPbh//9jbBVUeVh2+EeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LpQU2VQhbyggFNlpfGPfhxhvADW8tecHRCwpbkNON1P0Dc/JEt/DEn9wrzZTV9Gg7QtfZylGo1M/s+W8alkTFDfgpdAGLfFTnzmnT/DvBN53L/qwXtf/2N2UWOuyydeGOF+bNhuMBwYI0cubGPSUo8TP4Ui1Zt2u179l6UPjaTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EI8CYOc/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733912863;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JGcgCCHSs6Sn/ajp60yPWf1ZQUEwQNfJpAcgMkRFdpw=;
	b=EI8CYOc/tAF3ixaGH2YONT5qkWIB7Guhsh0eB2WKVOl3l2SM5oNpLiJzUH22LxgNI9ItlH
	jjDxTCDh52Ba6p7sHbaS2VdcSHzp2cuR5y+KUwrm8ONWTa77uNalSgUXch6raE8J0wDhSd
	9+6+XnvA+1Dxd9FMlZ+zndUeu6W1PPM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-ZpbA0PETOaKoS0ZIfM0wjw-1; Wed, 11 Dec 2024 05:27:42 -0500
X-MC-Unique: ZpbA0PETOaKoS0ZIfM0wjw-1
X-Mimecast-MFC-AGG-ID: ZpbA0PETOaKoS0ZIfM0wjw
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4675749a982so68774671cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:27:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733912862; x=1734517662;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JGcgCCHSs6Sn/ajp60yPWf1ZQUEwQNfJpAcgMkRFdpw=;
        b=OoHtHM4LAqaxbKuhC1+CiFvs44/9TxF156hE3vx2dGXPyzJMmAr23UaNNr/9h7frOZ
         D8MK6Yrnt434c/v8diFRCHYKzcjbTWaFyl/4pvjeH5xdj6qG8w0y0+CoajyDnylMF6MZ
         +7heQiEWoVEsVrS6xPSZuNSMlD6ZeNJb+3Mvc/pR6dHTI9HqrNstKbswWRpEmjPOccAP
         FlmmrukZeBvV8ruCcyGxnJ6+E6mLNT3OBECQH6MjUCAq6U0GwqX5RxJ7cjBTjYrapklr
         L/MKYIvKNjWcfm3gf8SnWxP12GYHLyDhfHnyYRWhlBZ9Y1O2KCQtHckdAr60+aHEdAos
         Dmyw==
X-Forwarded-Encrypted: i=1; AJvYcCXORv0LZuDPFED+KtGN6UDdVBvFC8XoNvC1nO2tFO9VIvp+hAz6Wb2vQpNQYraoXi8U4byzyIWn1zA1lVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbf6TDVHvRSBkY+orC4WRTtvn/VzmkRQrwzDAlZpQowafcyyiK
	L6u+0xvezb9alP6cbHDmtGUSdG3NQXPtrqq0IedRHJK0tI6GwT/xfFIfakl0gNt/orlt3BLCaUv
	/LsYAGLSdWLLyRtEWJz87vAw5QzILCaTyr12dk11CVGuZAGOKCSSS1iOkxSo0D92o/dPlUeCi
X-Gm-Gg: ASbGncvwO+MBGysLPaKmHFIAca34eYS3ExH3MRXDrYHbhg3U/v/T1qSuLKX4p/0nb7a
	1qR/yhVoYWktZrA03u+Z5KdYdlsNJmhzZtTPpel3DIIYdHBeLWNRwS2Xw/00wahaAKspVINFsD+
	mep/i6zwdPE78QPchePS4usYSuHYH+Sr9ZzrUtEDMud1u21+UK7YIbKAWJl5uokdpjhvFVEltFt
	F7ddYYOEUFVTwgRxWKEmqGhRO6IScjSrTBHWQVOvsJhy2R/+H733hK6CDLLII4uk+Tjj8yq0k5+
X-Received: by 2002:a05:622a:114e:b0:467:672a:abb8 with SMTP id d75a77b69052e-467892a25eamr46907231cf.5.1733912862060;
        Wed, 11 Dec 2024 02:27:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9ze0CKs4WN/iwYACMxNnqPYYxh+6XHCVxFTTE33oNxqOB9Ute8xCRGm7knRXpkw54/99tCg==
X-Received: by 2002:a05:622a:114e:b0:467:672a:abb8 with SMTP id d75a77b69052e-467892a25eamr46906961cf.5.1733912861756;
        Wed, 11 Dec 2024 02:27:41 -0800 (PST)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467296fe9bcsm71559991cf.51.2024.12.11.02.27.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 02:27:41 -0800 (PST)
Message-ID: <ba149c5b-e213-4047-b660-f44b1c8643b4@redhat.com>
Date: Wed, 11 Dec 2024 11:27:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: group all VMA-related files into the VMA
 section
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <41a14051-75ee-4de3-863c-d0532aa7e3aa@suse.cz>
 <1e4c3e31-ea9a-4af4-83f9-15a882732e69@redhat.com>
 <71beb3d1-21ac-4037-8363-6484c0c333b8@lucifer.local>
 <CAG48ez2s2mY83uce9mGUgc61_50nOp9VPJKLHMtyRYTTeKpo=A@mail.gmail.com>
 <81fc4cd1-55f4-4569-aef7-0b0da9684fdf@lucifer.local>
 <af887f35-0831-4c7d-9f1d-bc857b52975b@redhat.com>
 <67ae2a5f-0c86-446f-a122-f14decdb84d3@lucifer.local>
 <a3cacdde-8dab-4dcb-a720-9e00833ee9c1@redhat.com>
 <dfe6b339-a742-4adc-9a53-c653510428d8@lucifer.local>
 <50e194c2-914d-43eb-bff8-47c4a1119dce@redhat.com>
 <bd0ebc49-e5ce-4cb2-a7a1-14e864c5888e@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <bd0ebc49-e5ce-4cb2-a7a1-14e864c5888e@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>
> 
> OK so I think we're (probably?) now agreed, I will submit a patch shortly
> that:
> 
> a. puts everything in MEMORY MAPPING
> b. Drops mm/madvise.c, mm/msync.c from the list
> c. I commit to moving things out of the various files that truly belongs
>     elsewhere
 > > I mean there's stuff that's weirdly used for page table moving in 
mremap.c
> that should probably live in memory.c as well for instance.

Yes, and hopefully we can clearly frame what MEMORY MAPPING is supposed 
to contain. I tried to tackle it with "/proc/self/maps output", but 
that's probably not the complete story.

For example, maybe mbind() should, for example, at some point be 
separated out into into mbind.c (making use of mempolicy.c 
functionality?) and covered there as well? I really don't know, maybe 
it's not one of the mmap/munmap/mprotect/mremap/mseal/mlock gang after all.

-- 
Cheers,

David / dhildenb


