Return-Path: <linux-kernel+bounces-196777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D16D78D61BF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 14:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F39A1F27A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 12:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24DD15886E;
	Fri, 31 May 2024 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="E3KaQRf2"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDA3158847
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717158616; cv=none; b=es79X9vZD14GsDULFtPXpL41idgvYShBrH05wFbjNGMcDDQcWq+5Fvc3yxPz1D5UkQHiSGCqHCY8TU3FdEO81juZWbdJyB+MgI1Kx8RoAE9lvZlBVjuV0bQfJwMcrI7vgJDs/XV9CRyyK3OHHz4T/ORmwk4B8hJ++WQjkNO4mMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717158616; c=relaxed/simple;
	bh=PVDSnpGmRt8ijqYH04SdOAIHTZQoWdauoklqv/bpCjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFezoIOzKDAifdzk+HyYIGZNFF+NtpREqvoX4GW3CGe9rPQHLdHnb29/aXv3W/bOcgyWn39Sb0JtZ76Pg/3reLI7EV4WaBziIbhoqla/1SuAJJSRkYmpoeHjRnfB8vHhp11YeaW4EyaWkZlnANWGA0D+6S+vEIo6+Vbe59sXUc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=E3KaQRf2; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6f8ea563a46so1150692a34.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 05:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1717158613; x=1717763413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pobb+qKmbEVkLRW5gpiFE+2DxXv9n/WgMfYUIElZ6qQ=;
        b=E3KaQRf2UlHTHr9r3E4Rws2pyv7MEsbWAVs+K9rj+dMpyqh1RnNeJpTwRwwZ1PiswN
         VfFF1mHhHWGbYd/a+fjcRY2JTh0lJkD7j3r0B9LoazpsjbIMv0HNMNFpPQikFpVCGtWi
         24qaPVV5j2CLd8f+C/Bd2HoFvMSaUU8m+NI/XOVMOhKtPa0xAp7HoZ6ecsfb3t4nTKC4
         VLiLSV3QJuXUurs+Fw8lxe83RZ5A1bz7modJIU3NqADPKE5DwmIRkfvapcoxB+FoGPDs
         chjS0VKJ9XaxMbRoavM90kXWg4xqgO3chgLl65T+sIHHNaPnmyf3mCnzYQgg5tJIsAqa
         eTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717158613; x=1717763413;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pobb+qKmbEVkLRW5gpiFE+2DxXv9n/WgMfYUIElZ6qQ=;
        b=kqYYQS4CpQ01LAEYRWGnE3tk8/dvUblG3jG0KymN0ogkb5JIOfmkKXLle8U33uf7pX
         50cs1Dt5o/jrXMVY7C7c4d9SQRAkT2jasENcn1EocsOP9SztmCP2Ixm2D4SSlTSG5bXA
         fOSAZQ5BwrE4K0loKrqCAYY1z6gaBjNWbP2qJGuCyXzMgMYilq+dk4CQS8oOADJTu0ga
         V4enfIn07PavvpKkDVzg/2Ut9ybCtapXNHTyq8PDGE99jgPgf0UZjutBf22QJZxITqDk
         WzOv2ivLYV+17SQvI4ScwhQu8OBSrmyeTxDsIi0Y96dmJ4pSAxQcAbc0J+RBsGyy3ST9
         OQwg==
X-Forwarded-Encrypted: i=1; AJvYcCXzrJXzDvCuvC3AtU+4NGvqLaHUwwWpNpO5xnq5DGuIgjmyeYExTiHF+E4en2TPRMRrsRwqvkN3smqJFrIx/0cZr126Vm5muP1HY8fl
X-Gm-Message-State: AOJu0YxmD4I4Zghf0mw50G8zZ3HVKJtDlvbl4Mf9HDic/LIdSQPinoJt
	W8+FndoD4qa3RXLixzX3tOXVC0nsO60cS+/81tRJ/IshuuB+0CCbXh1RApltlcI=
X-Google-Smtp-Source: AGHT+IGeo7tqAnMa9JIVWwH4HjMXc/fO4mXZB9xlsqbbsjuQhrqcsOkModTThzMO7MtphiKdpMdQXg==
X-Received: by 2002:a05:6358:33a2:b0:199:28f7:c247 with SMTP id e5c5f4694b2df-19b48c28251mr203744155d.9.1717158613508;
        Fri, 31 May 2024 05:30:13 -0700 (PDT)
Received: from [10.4.66.249] ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6c354b945a8sm1181633a12.23.2024.05.31.05.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 05:30:13 -0700 (PDT)
Message-ID: <7f7c3bbe-e250-420d-a7d5-89508d881f0b@bytedance.com>
Date: Fri, 31 May 2024 20:30:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [QUESTION] mm: Redundant const parameter?
Content-Language: en-US
To: Dev Jain <dev.jain@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Anshuman.Khandual@arm.com
References: <e5f01ffe-de51-4079-a87f-2886788422f9@arm.com>
 <e6b7858b-39cd-432d-9206-4ccbd153baa2@arm.com>
From: Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <e6b7858b-39cd-432d-9206-4ccbd153baa2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/5/31 19:31, Dev Jain wrote:
> I guess it would be better if I send this as a patch and wait for comments.

Ah, you're right. I think it should be:

	return folio_test_workingset(slab_folio(slab));

Right? Don't notice there isn't any build warning about this "const" discard.

Thanks.

> 
> On 5/31/24 16:42, Dev Jain wrote:
>> Hi Chengming,
>>
>> In mm/slub.c, you had defined slab_test_node_partial() to take a const parameter.
>>
>> Is there any point of taking in a const, when you are anyways typecasting it to
>>
>> a (struct folio *) from (const struct folio *) ? In fact, at the place where you call
>>
>> slab_test_node_partial(), the struct slab *slab is not const.
>>
>> Please comment.
>>
>>
>> Thanks
>>
>> DJ
>>
>>
>>
>>

