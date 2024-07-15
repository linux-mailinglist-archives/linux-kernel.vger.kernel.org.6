Return-Path: <linux-kernel+bounces-252775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E80931813
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 18:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3DFCB21D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 16:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DE217758;
	Mon, 15 Jul 2024 16:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GqyaCWkA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CE2E556
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 16:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721059620; cv=none; b=WegCK99h5Lsyoh5hwbH3331lQ4jImgXfwHbPYwCDAlcKTGIIDVf8cuDpN5Pcndt/FLXxWLYtcx7NMaQDUwot+SmDexjwGmTg/lh48x7DcHWOKvLkj0mDg+RjpYUR2CaM7AaAAn/w/eQs/XnC68KX9s5nOpHlNOOVsNDpwzsG6X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721059620; c=relaxed/simple;
	bh=tIHK6dnfCyfce+euPyIB2CpRn5YuCncPitx4IOKXycw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MHPv65v0uWQjjIdMXWvzK6wH96cBg7zG0lpgKv4nAa4bbkTqv8zvYwwWa21bmrZEtVIabU4TChxb/baa1mwweMXV2htR6ITAQa2pZarRltCyHofGZPKz6JksDm+HyNc+S/ZsoOGuIjzVinl4LiyIgZxoa+mwrN8/8xzmapGnjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GqyaCWkA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721059617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zm6ujIbOEx2ahSbq3oVxgq1NM0ojAISTIQFPM/ZZy+4=;
	b=GqyaCWkASzPauEuNBiRCEs45P7NfM/b7PK6UBvFMX0Bbry+gmqSbCBo6O4OZQAVQBtgAbl
	L/HyHnlnqFt+/ZzVxPz2JgjWzutMS/9sI03QHIBw9yjAke7HR3EFQHPNkLACfBU8XNVcrE
	cbpkUwwNzBb4vPSFyXgUHi4jVE8VCAM=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-GP0u5JxgMgCjqSDQ8iDjUQ-1; Mon, 15 Jul 2024 12:06:56 -0400
X-MC-Unique: GP0u5JxgMgCjqSDQ8iDjUQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52e98693f43so4149576e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 09:06:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721059615; x=1721664415;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zm6ujIbOEx2ahSbq3oVxgq1NM0ojAISTIQFPM/ZZy+4=;
        b=PqZhG1Tvw6WjO683wOcdWJ5zkEeUFzNZt3+kvPtMB89HWc71OX/lufcFqve0n5DAxR
         pmIW+d5SYNeNLVHxHtkJwFpsvtl1Wty4ZDuVofuMwPn06WdYpwesXxCuyoWH5ZfboI3r
         ZYypoF735+jYBJubNbHv/vV6MfhdCHh6xpELNl43D+OhL+5rbAUShKO8a3M2p0wi1PRn
         em4x4YCNRRJ3LvtMpmvauyBCKZ5wzFbudTeq72WCMckvuACNInVPisDCJ0dNeiNxYpXi
         moRDQBvKAU91BPzooDWSRqRKdPna1C9qZx/9nsq2QDdKPdkzxeteKxpb+8gb0JhYWCOF
         0DHw==
X-Forwarded-Encrypted: i=1; AJvYcCVCPEikjQ9lPRczp7I1AG6qX5EADghf+oBkvM8KU+YHEQSXxEfzzHfavE760pfDskiDGwo56FTSVX7qY0+/mX1rlr+BgE1YdtnPJ39C
X-Gm-Message-State: AOJu0YyvKuTEnq9qcou4DsFu0RQLy19qPk2NXubtGjtVuHIqNy1W83Xq
	XjnCBdjvzGiSamh7eHI3dDTsuJIJMyig0WffGFoQD56+fNj87Q8N+uRO4VnA0TUrX6rwqZZtjSO
	HL5ombRZ1RGAlfYewRl+i6+jHAJw6rjcmk5lOsIt4HN38Vhfal9d/hYvOPXiJxg==
X-Received: by 2002:a05:6512:3d05:b0:52c:dc4a:fb14 with SMTP id 2adb3069b0e04-52eb998e77emr13957386e87.14.1721059614867;
        Mon, 15 Jul 2024 09:06:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIK9AT/n4qKqwBZydk+u7mgmcsReV129oM7FJoE//40vMarWE0IgLjLxGYk6YCbc+6Ev01CQ==
X-Received: by 2002:a05:6512:3d05:b0:52c:dc4a:fb14 with SMTP id 2adb3069b0e04-52eb998e77emr13957357e87.14.1721059614399;
        Mon, 15 Jul 2024 09:06:54 -0700 (PDT)
Received: from [10.0.229.2] (ip-037-024-227-121.um08.pools.vodafone-ip.de. [37.24.227.121])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427ae750519sm29307195e9.1.2024.07.15.09.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 09:06:54 -0700 (PDT)
Message-ID: <16aa56bd-b71f-417a-9a82-a2d0876571f2@redhat.com>
Date: Mon, 15 Jul 2024 18:06:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] WARNING in unmap_page_range (3)
To: syzbot <syzbot+e145145f0c83d4deb8fa@syzkaller.appspotmail.com>,
 Liam.Howlett@oracle.com, akpm@linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, lstoakes@gmail.com,
 syzkaller-bugs@googlegroups.com, vbabka@suse.cz
References: <0000000000007b55ab061d494ced@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <0000000000007b55ab061d494ced@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.07.24 15:35, syzbot wrote:
> This bug is marked as fixed by commit:
> mm/memory: Fix missing pte marker for !page on pte zaps
> 
> But I can't find it in the tested trees[1] for more than 90 days.
> Is it a correct commit? Please update it by replying:
> 
> #syz fix: exact-commit-title

Should be long fixed

#syz fix: f8572367eaff6739e3bc238ba93b86cd7881c0ff

-- 
Cheers,

David / dhildenb


