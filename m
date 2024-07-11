Return-Path: <linux-kernel+bounces-248631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FC292DFF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2CA3B22627
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 06:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B4182D68;
	Thu, 11 Jul 2024 06:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kA6/Cg3D"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBECE7FBBD
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720678589; cv=none; b=WSmwX297SC21mrfZ180wmYV2SzXgiU9/HwTQtvxemsEAQlqs0UIfDTRBlbhUdFCd5LfC0hk0dKDEfhxdlH2VVqR8Tq+dhWLdEr47NHWufC/RRpjGyAfN8lIPiLdTy0ANYf30ohQtdfNRweuSvvsr+Z2NnF0Kk5qT6E+ttRkrnmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720678589; c=relaxed/simple;
	bh=6BBilbEeL52FTT35N7XB7Kzu/8daqmHMoqXrsMdiBZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvHsOSlGHld9UkJ+ACQltiuInSXh1drfmvCa4WGL0meVLHIQeqpJMBH/WJ731ezPs8qlhjvCaXmYP1yYOEB3J2aMPyG+rPur/AQLZ9ULWNS80Z+yACt92BHFObY4wRqZK90cV2a1w6xpN41+vJ+mmwFSkQ//mdWrl12thNBzIOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kA6/Cg3D; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52e994be1abso78505e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 23:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1720678583; x=1721283383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=elYfpEJsVdFAh6mq3g1TRr0FkqgmW3O38LkNSBzAYLo=;
        b=kA6/Cg3DNQJSX517pFSr11K8GA1A0jwgQTJ0xou+35IxRXxFB3OrgME/a4XDv4f2GQ
         ViyWvTMQzHaLHtUwWWvb3SFadQPwWJVLWE2giV+dWmNk3O+xvn32704z45VD7XKuGHek
         etTyn1QcRqzFXClwZKhqIbHnzPRI/htf1AI7j5ZjuR47XMyS9P6F1iHlfugOy6lMw+tf
         DUWHmG39qwZV7DTRBGI6XJEnsPOJPPd8OONTbbaeHiI8X9vMyhsDaVafV/V5dguElRLl
         3bPBXYbftqtJhfFxq/m3RO72Jta6CSnerWYK71+w+OAeFO/9dIlbt/BTbjJ8IQqKVKIT
         cptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720678583; x=1721283383;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=elYfpEJsVdFAh6mq3g1TRr0FkqgmW3O38LkNSBzAYLo=;
        b=Od7rZWup7qMuz+CxYzeUq3a6D3kc2MJkSuSdr39CFJsgVqmBGOyTspDTSemaJ406KV
         T88CAgGPGuzmdP5Dzp1lkIwM5UGi+oMB9phNa3yvxOaXJpCUoVC2N4Ko8AWkKq80jt3P
         YsX4zBkgTRo/CxNXgpCpxQ6C3YydYFInEdZdmueNsHQjV2UAp9bp04AVIL4k5FuMjdgz
         CmEY2jyt25WwvzuNvsgk0N7ss6XKU6sUCF5anzypQrFzRxXSdEnu8MYPGxDO4Pd9/kN7
         5Xxxt10nmzQB1ZGnw/5pMUe9HLl2WCTIxRwzgRmLUEY8jyaM7zA1NV6tiggVjsuuEV3x
         rffw==
X-Gm-Message-State: AOJu0YzG8G5meNEs6p6PgsYKL0Rc88SP+u3LTFL+TaCmvFv6XtX9Iasa
	JgUTzW+oGVP4EIEBEvfMNk/c5Y2Ul3Z1FVVGrNyt6SFY0VP+0zMwqAa2oyJSi8s=
X-Google-Smtp-Source: AGHT+IEYcKV1fB6RTyZpy4i6Dp8uhrL7s6pAADA4A93BZvxC1tbodpeGJvMhgglMxJAP3loJMukkvA==
X-Received: by 2002:a05:6512:3986:b0:52c:dd58:1a97 with SMTP id 2adb3069b0e04-52ec3fa3669mr1007081e87.5.1720678582700;
        Wed, 10 Jul 2024 23:16:22 -0700 (PDT)
Received: from [192.168.1.68] (87-52-80-167-dynamic.dk.customer.tdc.net. [87.52.80.167])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52eb8e49605sm879366e87.99.2024.07.10.23.16.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 23:16:21 -0700 (PDT)
Message-ID: <947e6d6b-f798-4f04-b6d7-d18ad550db66@kernel.dk>
Date: Thu, 11 Jul 2024 00:16:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: duplicate patch in the device-mapper tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Alasdair G Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240711121729.0d71308e@canb.auug.org.au>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240711121729.0d71308e@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/10/24 8:17 PM, Stephen Rothwell wrote:
> Hi all,
> 
> The following commit is also in the block tree as a different commit
> (but the same patch):
> 
>   e87621ac68fe ("dm: Refactor is_abnormal_io()")
> 
> This is commit
> 
>   ae7e965b36e3 ("dm: Refactor is_abnormal_io()")
> 
> in the block tree.

Looks like the dm tree is re-applying patches yesterday rather
than pulling in the dependency?

https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-6.11&id=e87621ac68fec9086d9f0af4fe96594dd8e07fbb

why?

-- 
Jens Axboe



