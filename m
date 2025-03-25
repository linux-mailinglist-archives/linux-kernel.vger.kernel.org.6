Return-Path: <linux-kernel+bounces-575369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCF1A70158
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93C7176F77
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E76F264FBB;
	Tue, 25 Mar 2025 12:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CX5aDAh+"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D2C264F89
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907129; cv=none; b=qqchWK2BsHV5qzYF45XIlYOBBjb349BNpihIir6PMOkB2x5t07FXgJ3u8ElQLCcxjJc70pMdSAxUXGhycfwRq+Cclk967aMXraKnHSB425bLUkM9GexbZfNRNkALIcrctrw8oYCPKYVIOCthD2gXWit3uY2ZZUZUTIsXJh9MUuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907129; c=relaxed/simple;
	bh=tj03Iy2cOddp5Dpo6rnyDthdPVJfZRvM2w2yOeQBtyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4GUIgbL8af9vF7xLCWscNZqEGlr6z/2yWOYbb7GYWONXjHTrWs9slFgvamf98cZWjBQrpx0e2wdMifP8UaapLDMFN8qB+ePQ7TBohKj7HuM5SlZVxEPjT1OFJ8KGIj5V9r3TW4xUQIesKqN0b1LHutabHXTmla/r1NbdkYVGFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CX5aDAh+; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-47686580529so53191101cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742907127; x=1743511927; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oPJxOALUzRJxRqwO/dJ1oQ2Yu8yWnLQ9Qghb9Fdffx4=;
        b=CX5aDAh+B2RplNkVJaER0zHAmQ++nERhrzKiz8fSi4iwM4tbDKnj5Gj5wym3VClJKe
         WGNk9eC8v8wl56SR/ICHu/H+Vqn929dHqH6bHeBuYWocWOoW4qEX0dtVtGU86wtfJgVi
         xLpEzUF0x+Yh3CeO5dQ/U2HtPgP2/8wRVLZOZQT7o+1yS/X3E4saigIdwBZ8eMqN+/2Y
         Z9v9+A3c5y4X9BclrDEMya1DNFrbNNREWJfgiO8o4DOWqQtveztTgxa7/FbHkq/RmPgX
         FxlVTCCBByZptzq96ilWR2RVhryQJnvYbnz4n3e+0popfOVLxFZOOB5oG6bGQICU8fYO
         Sy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742907127; x=1743511927;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oPJxOALUzRJxRqwO/dJ1oQ2Yu8yWnLQ9Qghb9Fdffx4=;
        b=FhYoZYR3f+jSUqPXzZdBeKRA+AOiGfPmKE0Dfwwub+V8OOLwyH6UQqMEPcNY+uPIbt
         nnZOGSy5tFK9u7CXG1igkWQycANNvlJSIpEh/5WyuWaWp18UueE/xKtM5KrjSBzBXpgU
         K+3qsM/Pm/1BRVhwxJ1POAM7aStud2pUCyatbRkS10vYWnEvmBgniVfDOlr4DYITsqre
         KTQdE3n+QxDYjt8CJj3t29wHagTFJWQDwMqIh7h20B1opqFpZWY2zAhkwS1nVy2N1FdM
         K9Iixbz+PtDCPXyYM9MBo3tj3sPYFpV5WBvzYWXEkZo9XLaC7ihyMPAS/mmQYklft69f
         UkMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVobxUvG7YX+zg4ljIJQWyp9W3v3WUL4BXBSrwFMQfGdjRiBmCT1S9pUDZAqM//Ei6H3QeW9Uw5rtsncA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2llLYOlBLr0JjwSPoamwbQbVta3cs/Z9nwIQa2USc591gUUyo
	SxfXAN73SPvENflRjWj0fEyni8GfwDOKig/XBfHoOaJCE9t2WSPgasWuDZyzor1Pobl5NnOapvE
	6X9M=
X-Gm-Gg: ASbGnctPcTN23s0tXALwFBkOOnzt0sRAT64yZTHs8LPKxgYIvM3KS9evg6SS7czQxBk
	KT98GWhR+cQnXJf6gT7u4qkISjpon9r8qnJoWAuiYWfMHwRzol4yjQeM5jxuB9Oas9IhNWTn4ot
	Zv6Hz5GB+sqeYuNAT/LocXUE8WekON59Calda+Se3iLVoEnsvtHXMeIkoF/nFYBAOf6ABTTZqQI
	pMTqqPZJBuU+n5JH+V5fQBSXECwlfQWBhk6Hke3c6OBabm1MJ9ZG9VFkyiTHRn1uUYEgY3ylQAq
	FbcZV2HJFpXRuLROO413H6KOKmy1mJ7hbvm7KtW33A==
X-Google-Smtp-Source: AGHT+IGqEToBEJbz0GNzaBV9LfDIy0nCojMJeT0B2Xje5qrSOLPVomFIE6YsCWtEQNR3KpSKRJwAJw==
X-Received: by 2002:a05:622a:2513:b0:471:b8dd:6411 with SMTP id d75a77b69052e-4771de62864mr302505941cf.47.1742907127141;
        Tue, 25 Mar 2025 05:52:07 -0700 (PDT)
Received: from [172.22.32.183] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d18f6a3sm59449381cf.38.2025.03.25.05.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 05:52:06 -0700 (PDT)
Message-ID: <bb7eb5db-6675-4e24-b08d-b48378ebbc88@kernel.dk>
Date: Tue, 25 Mar 2025 06:52:05 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] nvme/ioctl: move blk_mq_free_request() out of
 nvme_map_user_request()
To: Caleb Sander Mateos <csander@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Pavel Begunkov <asml.silence@gmail.com>
Cc: Xinyu Zhang <xizhang@purestorage.com>, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324200540.910962-1-csander@purestorage.com>
 <20250324200540.910962-3-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250324200540.910962-3-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jens Axboe <axboe@kernel.dK>

-- 
Jens Axboe

