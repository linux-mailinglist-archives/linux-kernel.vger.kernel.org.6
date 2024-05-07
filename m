Return-Path: <linux-kernel+bounces-171235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181B28BE183
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD01286BCE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 12:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABA3156C7A;
	Tue,  7 May 2024 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dh/N1wEb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971C11509B0
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715083241; cv=none; b=NeqD3c9bFDfcqxZ9dwI2E0TG9a51N2R5590RxYISwmpJ4MWyMjABACcR/hhztO2bxvA3CoSr4n9tzqU6x4NyIa69ykjF2RX+YrD9BIPp84Qa7fzcMIaS3KN/QulETHekpcqBCNRb53ZHP+q9x/rewZ9VKs2seQKZ5OngE5mlQtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715083241; c=relaxed/simple;
	bh=k2TnqExskT/BOQA4uq+bwfP4G9/e8R5h0GdlaYWeVoo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqmtZjw30VAwisy/2lrDOuP5al+2fLapupQWi++gOX65Plv9ZYKFZLQaCEVhL5PxPxmdeKHYAbGzRX4nd38By6bZoWtjRpYIsHoHeZtQnBOjAxSxmLWjJfAK978vG8htzV68adc//4/jgVHC+PFnQozaZUWohsHS0KCifLzi1oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dh/N1wEb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715083238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QFEbDe5HkXiUIkOUJF/XHx+uJgG3n0llY8zaxmyNRcg=;
	b=dh/N1wEbjrG7DDvHDa9j2330LCvMJppYuxADsFvCDCV63NT7oampv2b39vcJ4IoXSWaLH1
	2XTo5PzH5UylHSzBJHxuuuggf6u+MzMLBYcM8hx9lTFdA7sg5wcprPUzps270BaC3xgisf
	enlQNRyJvNDcaTu1Zqtg1Vp1DhsRFUM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-hvj1iB_8NFiyEFc3C7TzTA-1; Tue, 07 May 2024 08:00:36 -0400
X-MC-Unique: hvj1iB_8NFiyEFc3C7TzTA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-34f1b148725so963490f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 05:00:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715083235; x=1715688035;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QFEbDe5HkXiUIkOUJF/XHx+uJgG3n0llY8zaxmyNRcg=;
        b=rs4hPstybaFvOJX2zaFYBoiL9I19AjTUL09+scbYJCL1WoJV8FNjL/fFKvoIVCWmad
         fvbSynJ3bE7mf43t3OirF5645bO0P/eRDkS2KsjrIkGZlk3hgbCNmzqHsOSrlTsJtErH
         +9dR1IZhD0Mr/UPj3lTAulo86dm41Vdk4OfMcRyf2Vd01LnWtM2sIyGfrKJzd4VO51ul
         ki+aZVfgBJz0mNkP8j++nk6OyYSl4YhFKwqJDfEV4P0OaXp7B13ss2nzNVlkuMFvx3bY
         RkTl4xH4jBPq9RZFDTQ8XgGtREpChVHcnpzYLlMFqW4VRaKVi9ZfAv04aBFfOULJ/Zc8
         HtXw==
X-Forwarded-Encrypted: i=1; AJvYcCUHIoynvGZFKZubiY2F3wLqkDi0VGr3Mvm+DYmUMKKqn4C225AJpkg0J0INloEEO4Ut2EPeYlKxwdLcEQIMBv0O37OotyTDGlVXP0rP
X-Gm-Message-State: AOJu0Yxbs1U9ktAwq7aqx07XFsBOg9BmHuQlfDgUXVNCQeaQuJhdgt/N
	XO5azAFVE9VSVvSg3SKLSqLTddUX3tPwxREJjtm+lKChGvPgwSSRR9QtdW5wYxoRay1Gm674r9t
	Bxh96Cjs2l7bEFULA7bVxOna0FK2P4h03Hk2m8/zGhjCu3C5wOt1yIo03uZcnHw==
X-Received: by 2002:a5d:590b:0:b0:34d:b0ff:526f with SMTP id v11-20020a5d590b000000b0034db0ff526fmr10203340wrd.0.1715083235170;
        Tue, 07 May 2024 05:00:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdel82zI84Z7OC1swjLW/BmFMRxkcv2sGkh4vbEK04TI6ebMfMbdNbjikylZrnhHzpnG7Ijg==
X-Received: by 2002:a5d:590b:0:b0:34d:b0ff:526f with SMTP id v11-20020a5d590b000000b0034db0ff526fmr10203315wrd.0.1715083234684;
        Tue, 07 May 2024 05:00:34 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id c4-20020a5d5284000000b0034b1a91be72sm12817930wrv.14.2024.05.07.05.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 05:00:34 -0700 (PDT)
Message-ID: <901d53f0-1cbf-436e-8ccb-875680dbc1d5@redhat.com>
Date: Tue, 7 May 2024 14:00:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] Address hugetlbfs mmap behavior
To: Prakash Sangappa <prakash.sangappa@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Cc: muchun.song@linux.dev, akpm@linux-foundation.org, willy@infradead.org
References: <1714699270-7360-1-git-send-email-prakash.sangappa@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <1714699270-7360-1-git-send-email-prakash.sangappa@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.05.24 03:21, Prakash Sangappa wrote:
> This patch proposes to fix hugetlbfs mmap behavior so that the
> file size does not get updated in the mmap call.
> 
> The current behavior is that hugetlbfs file size will get extended by a
> PROT_WRITE mmap(2) call if mmap size is greater then file size. This is
> not normal filesystem behavior.
> 
> There seem to have been very little discussion about this. There was a
> patch discussion[1] a while back, implying hugetlbfs file size needs
> extending because of the hugetlb page reservations. Looks like this was
> not merged.
> 
> It appears there is no correlation between file size and hugetlb page
> reservations. Take the case of PROT_READ mmap, where the file size is
> not extended even though hugetlb pages are reserved.
> 
> On the other hand ftruncate(2) to increase a file size does not reserve
> hugetlb pages. Also, mmap with MAP_NORESERVE flag extends the file size
> even though hugetlb pages are not reserved.
> 
> Hugetlb pages get reserved(if MAP_NORESERVE is not specified) when the
> hugeltbfs file is mmapped, and it only covers the file's offset,length
> range specified in the mmap call.
> 
> Issue:
> 
> Some applications would prefer to manage hugetlb page allocations explicity
> with use of fallocate(2). The hugetlbfs file would be PROT_WRITE mapped with
> MAP_NORESERVE flag, which is accessed only after allocating necessary pages
> using fallocate(2) and release the pages by truncating the file size. Any stray
> access beyond file size is expected to generate a signal. This does not
> work properly due to current behavior which extends file size in mmap call.

Would a simple workaround be to mmap(PROT_READ) and then 
mprotect(PROT_READ|PROT_WRITE)?

I know, not perfect, but certainly better than mount options?

-- 
Cheers,

David / dhildenb


