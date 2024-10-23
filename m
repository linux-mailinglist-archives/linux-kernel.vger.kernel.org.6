Return-Path: <linux-kernel+bounces-377875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DB1B9AC7E6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 12:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D3C289C93
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 10:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2FD1AAE32;
	Wed, 23 Oct 2024 10:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP/BYOVT"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343231A7AF6;
	Wed, 23 Oct 2024 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729679202; cv=none; b=SQB5Dsv5JO7QvEZpsjSfzgXDMgxg1i0PIbSmm1+HYmXYENsN8g80uL9jM3jMv8+paQP41FLGVmJtP4gpyncLIlL26HvXoWu8VaeK/aRWsBNs7eWizNNMre/1Kigv1A5s3zSgR3PUdI4KzP1M0iH+EB52bX/2BfYz63sQpsDq+ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729679202; c=relaxed/simple;
	bh=QBuEo5eIVgcTnsQ0f9dFMCLkDRYCkv+Zgcpy1jNnZRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N4vYVlvS5son16pf3J3ruW+18CQJRMTumNX1HNGdXWExN0BbpsxR2+WeExtLqdTNEOEUA1/E7b2MtkCRVq3h7joNDSdbQwODIG6xzUJqbETOulkOC0AnYQsEeVthIBbc44lDgLGdHsjN8+TaRjj7Ki/1fmz2hICInHB/UGpu5e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YP/BYOVT; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-539f0f9ee49so7214587e87.1;
        Wed, 23 Oct 2024 03:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729679199; x=1730283999; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PI3pexgot2AS5y2K3N1eH+jxvyIvFandoOsjehy81XI=;
        b=YP/BYOVTlY54m2KnxXec6xsqIcBh5+ZlGxcqhLPZtTnF6/YKPdncVP7BFCqLUZ2Dxd
         hcnqvb3D9a99z+DRretevDb5xZYfP8XSQ6M7J13/f4pUomOJ222lrkr27bygSEJq75nN
         4G1O+sFORsemRo6PuJKo9CW4mTB/13diQ9pJOwGT2H6ZW5zr8x8WUTQA3XjK8gBIQAVJ
         zV35cAGku5V84tIMC6NaZZAgX3+5qm2bSwreDnnabvobIX6zCzMLVyMxgY21p4WYIXGT
         dGM7r0qN0XF06pXfjypsGoLmukqzfLql9rStAzPRp7Z5e55wbgOV+a/YE8xcv8GQgn0t
         hH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729679199; x=1730283999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PI3pexgot2AS5y2K3N1eH+jxvyIvFandoOsjehy81XI=;
        b=vn+fe4xRtT/uwPxdsmMXoPrOLR8xdSMCYNBh3tzMmY0iq/sRzyosoC+Bl5+zuHmY7I
         xyjtfV/an/eDyTouEm3KUn7BdDZ31cQyyaRL6O92BylfGO+YycblmL3j06GMrGCE9t76
         FjABRsYEzIcwrI4qIJ5LBAWtir77BC9xBds7Zf4a/VK4+eOLBYZtiM8JgmxmLbOERLik
         2FBw3gE7aSmEy7wz0iziFqaIJAA9p2xHVLon3nYBF/4Huvk/BHMtPDYZufLLEXm4hXjJ
         AcyEkUUOYzCsJ3r6Ck6VK6leR5nH5GebwlYQcbyOUxJjwnHav71EzOrgKkFIgT7u2lYh
         hywQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhgxVMQ87oByRJkGCqHZ+YiXpKmfWmavsHqRkHT7zZ9KZMhubTJtsGcYtVM6cgkGI9aQjuu/AWCEmEL+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnBNQRQFOJx/vBLMMX09NQI6AuRx0kQ6RYEpPdz057U0AyOCbp
	h9+irM4gFZumrXSD3MOQnZUmcp0yCNl6MIumEjEN2SAjeN1omTqxYY6Dfw==
X-Google-Smtp-Source: AGHT+IG8wFEAFtFm9Gw7OOgeiTmHEDudfTFzqnZcJjfeFZRkNo8oYisrFFGzVFLM2c52Mz0atBovww==
X-Received: by 2002:a05:6512:3a95:b0:539:edf4:68b4 with SMTP id 2adb3069b0e04-53b1a37f186mr866757e87.57.1729679199291;
        Wed, 23 Oct 2024 03:26:39 -0700 (PDT)
Received: from [192.168.1.146] (87-94-132-183.rev.dnainternet.fi. [87.94.132.183])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a22422167sm1020400e87.129.2024.10.23.03.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 03:26:38 -0700 (PDT)
Message-ID: <74db5f3b-c329-474e-9a9d-de67d7cb888c@gmail.com>
Date: Wed, 23 Oct 2024 13:26:37 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] rust: page: Extend support to vmalloc_to_page
To: Danilo Krummrich <dakr@kernel.org>
Cc: rust-for-linux@vger.kernel.org, aliceryhl@google.com, dakr@redhat.com,
 linux-kernel@vger.kernel.org, airlied@redhat.com,
 miguel.ojeda.sandonis@gmail.com, boqun.feng@gmail.com
References: <20241022224832.1505432-1-abdiel.janulgue@gmail.com>
 <20241022224832.1505432-4-abdiel.janulgue@gmail.com>
 <Zxi287W_MJcMB4YO@pollux>
Content-Language: en-US
From: Abdiel Janulgue <abdiel.janulgue@gmail.com>
In-Reply-To: <Zxi287W_MJcMB4YO@pollux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/10/2024 11:42, Danilo Krummrich wrote:
>> +    ) -> Result<&'a Self, AllocError>
> 
> Please don't use `AllocError`. We're not allocating anything here.
> 
> Anyway, do we need this as a separate function at all?
Thanks. Would it make sense to squash this function into 
`Page::page_slice_to_page` instead?

/Abdiel

