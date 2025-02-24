Return-Path: <linux-kernel+bounces-529741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7223EA42A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB9E33A9DC3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F72A264A60;
	Mon, 24 Feb 2025 17:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="NxTRE61I"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFED2627E1
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740419725; cv=none; b=MEOzWWUFQAVQY38f5NfXUq8aBTbCl8qYhsi3mbZHo9b5rt/dn4hl9UsxQspwX1taHt4rlh6Yt4NhWfYqvSYgMBpCn8MACA3GiX8pCVM3gwr9yoGxbLrArdI8zxlc1KvTYo66lVm2E0QW5OoQVwRoTzoA6YZy09G6WR6JKAMe830=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740419725; c=relaxed/simple;
	bh=aHxQ3RpgVyxdHjQE/CzgpBbZ7e4Z7E1ZeJ/blA+sYqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XIeWswKyxV6h8R+S9uUYIc9/qpJdfaYtneVXKbNcK1EqE27192uJTCHFJwAkx8vuL0OsEgjJPscKjSvyHch7nmBtM2kyFTwTVIieGPm1CrqeLjC9SXbCGkwRbDWeePnXCqZyMBQ1X00AIVN6KCAupK9mRely30ASAlu3WH+H5V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=NxTRE61I; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-855d73856f3so320391939f.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740419723; x=1741024523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1uzyU82hmIsAi67Xq5Y6egExuZwd4OLfYvCWCU2BXJo=;
        b=NxTRE61IhUNX6gP1C1ngxoWh2wdxVxiFkXPK2o1WzukRLlKkFsfHtcIi/QrgIA3e6D
         Wmv+OeugepqtOKS3A0s3JPaaQqxPKhhQ+/LCa2uCVkKkbF9g9Xgajw93HmjHWDSWLwG5
         RAW3kJtRpihIY8M31KwQLAlu7NFyCxT2TYUhMB7CPIhaB7YBJZtJJpnsQIX1S0b5Q5Lk
         +qUdlTHq1o1pqJUeD9ebuNX7IGGXAnbu6Otn2/b6ZMuREUp57R6gBe+Se/uYQkCh0E96
         aVZ7UryJV95+tLvCIii9v667aEJDTKbHP8uucSK09Izs2mgtaPSKu3MfkMsOLVdhrSzb
         JpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740419723; x=1741024523;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1uzyU82hmIsAi67Xq5Y6egExuZwd4OLfYvCWCU2BXJo=;
        b=DfbxXXj3HEjOoQvrXOJ6uJx9NLzP/PLTkgpYro2wX+7R0/ESRKrT8AQyIK5UG0wOqj
         L26lv5PCnpM1ZEMSyPtzcLncLVvAf4e7pXf0ZRQtifprttTcLggMatC3apB4TwXyOfas
         76TTLdg5obckfMznWENkU9Aw2M1ElJi9rNaqtBubTLoczQZj658cbaXSv9XruFHu2u2j
         TZupTJ70fRHjJfoBlp9i3FjEzKA+DxGEQNTOAnwtlahobB+7B/ymSIRcL1GVJvLfdoBB
         oo61e28Zcf6aHm6fxfki7bUGt8vb3uIPLI4tutKYUCXVMtcB6AWCWyNgDcny5RZgiqWY
         I8jg==
X-Forwarded-Encrypted: i=1; AJvYcCUr/22KJGa8RNQ0keMqzxxkEIddoMyEG0+GguAsLl2Tg5xT9jkywllm7GznZJS3jGeENmNFvTVWO4NYZ4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzegvufN0ka/L5pQHfZ6L9Xweon+oT2bhPQxV1bWLHbVy7b/Y8H
	oU7xQPFp7GGrze1LdS8/PON/WaQUYpI3Ko1amka+EFDhcZ/RdOBKS3p441yhmCY=
X-Gm-Gg: ASbGnctuGGy/LovIreLnXjh1wTaaNAYL31uoqIJ/CnOCOCLcp9tpRDX7sibjPSj4+UM
	+bxmUX9kQNuyw82KK+w5vKtVmBjpbKk7FeuQRqcA+gkbhTVBvkPd5WvLi1yI1wdL5N8NjnzYGhZ
	UO+8Fl5B1Ox0PVapwarJvN66i56VHt6+gNG+7VUmFklRxR9JS3GXLoD64F6/Zca3G5U2rBjSIin
	TuHqkNJp8oShaLhJuZnEp7FYgqDX5eucvHO1FUriK+9PdijQ0REIDruoIwCfA7vUj7naGpwZxVc
	huR0VTeLZmDfe8xAKIm7SSc=
X-Google-Smtp-Source: AGHT+IFMKNwb9DdbQv5NBCGYRpuI/1FV/FwOCa9S1u6cQx71eQK5s0ZB75Sc3VNIaRoNkDF5hdJkRw==
X-Received: by 2002:a05:6602:1485:b0:855:ac69:32bb with SMTP id ca18e2360f4ac-8562014a58emr31561739f.1.1740419723435;
        Mon, 24 Feb 2025 09:55:23 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-855a00df541sm327191239f.5.2025.02.24.09.55.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 09:55:22 -0800 (PST)
Message-ID: <fedd8628-327a-473b-9443-4504fab48c2c@kernel.dk>
Date: Mon, 24 Feb 2025 10:55:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring/waitid: remove #ifdef CONFIG_COMPAT
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250224172337.2009871-1-csander@purestorage.com>
 <ebad3c9b-9305-4efd-97b7-bbdf07060fea@kernel.dk>
 <CADUfDZrXAn=+4B9boaKe3aMBq19TXn8JDQm4kL0ctOxwB6YF9g@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZrXAn=+4B9boaKe3aMBq19TXn8JDQm4kL0ctOxwB6YF9g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/24/25 10:53 AM, Caleb Sander Mateos wrote:
> On Mon, Feb 24, 2025 at 9:44 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> On 2/24/25 10:23 AM, Caleb Sander Mateos wrote:
>>> io_is_compat() is already defined to return false if CONFIG_COMPAT is
>>> disabled. So remove the additional #ifdef CONFIG_COMPAT guards. Let the
>>> compiler optimize out the dead code when CONFIG_COMPAT is disabled.
>>
>> Would you mind if I fold this into Pavel's patch? I can keep it
>> standalone too, just let me know.
> 
> Fine by me, though I thought Pavel was suggesting keeping it separate:
> https://lore.kernel.org/io-uring/da109d01-7aab-4205-bbb1-f5f1387f1847@gmail.com/T/#u

I'm reading it as he has other stuff that will go on top. I don't see
any reason to double stage this part, might as well remove the
CONFIG dependency at the same time, if it's doable.

Pavel?

-- 
Jens Axboe


