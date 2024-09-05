Return-Path: <linux-kernel+bounces-317567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A894D96E030
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 18:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65DF028B859
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5434A1A01DD;
	Thu,  5 Sep 2024 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ZACdSF07"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A60917BCA
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725555000; cv=none; b=QR7MDCOEGxadVOOnpwj0h0GLVQkEmtCY1SZeQxFacm/3XwlVa+xVKEWF7KvIo+dUqVNOn1EBLe4UQaNRzJsn7D2tzW/RpzEvvU0DJXpMJimYcp4g6QKkwb/3nb3osRsI5R61zAKB9tV/MATdujqPOaxPYMs406bbE+FVw+RLGxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725555000; c=relaxed/simple;
	bh=6ppMJTCUMDHEIy2+XrldZ7rp1llWL3mtq6EatVCi7i0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oDego82wtko1z08sTj3KHjGgVIZvO4P/91Xo6Gl8qFZ6zfMO0lkRSCbB9L0l60Ac55MO2PLr6waaYA77SHEWyb20N0rrbumUDeKfqRLcCzK4PYO/2xgMN+sUSUNg0njzEJ4qIISz2uFIKKvjSN1/DMHEC4CEaDYicOr0dXf9OWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ZACdSF07; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-82a73a81074so41155639f.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725554997; x=1726159797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gzYI42De5EJ7Y+DuQYyo+Knog6etwcYVpNZv0Merlic=;
        b=ZACdSF07KpFc8wDzzIEB2ciTOZTTsK0Dvb1n/fh6pbCI5iPL78SYHsC3bwdbj0+ynn
         IB/7Rppj3lKJS03oGbcJRlzAZvhQ7i4PgG3vXpINZYtB8+lGv8wHdd9lJ/Roz8D8iwJi
         fIPMGorRHM7hjRSB9rw6DTLVG6LjQU4eDuh8JPo/CbgkyiQmEcmMscxJ5uCQZnzJiQIq
         KTEpuDOqF4EXCsFf3tc9vewcIzg6LESvOalZoprVYSflDIcxxfwpHiPSYYpc13sQrkSV
         anpNyuhc7FiQAai1Idb8R2DtolqBsAqUZ6y1VBy97wf3RabBrnAuY6t0lM9g7Ynklkev
         PYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725554997; x=1726159797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzYI42De5EJ7Y+DuQYyo+Knog6etwcYVpNZv0Merlic=;
        b=LRi42/KJwSJ8LRLeXqPEOY8cek2LUxR1si5rE1RImvLNKsLNQasVvDf5/Qgyyg5qAY
         AHhxnHEcwfuMiO//9YdjVVFnihrEKDHU2PaNgfWYtb5e3QQQT7Zub2UIjTKutfdj6RM1
         n/acRW1wFHZwAtCLRp28XGT+bZsRlfP3sQbRMb4torxmVSbkn3h6rhfYql4rzj4wgzla
         FLe/wNMcF4DYMd1CMv68fT6hDmUXC7flFtLDdDzsF0wa2/tuajuxvC/nFZZsjs0xtXhp
         ph5u/Z7ttoZJJov26bOwhw1jQziTTpaolv3rtrZyRoSt4xQ50aJ7a403y9f56zwXKS5v
         xZrw==
X-Forwarded-Encrypted: i=1; AJvYcCUmVu8aMWm4oHhdyyL52STpBz0CMCUhuclpArTfSPcPyaUtPunlHH+M9Hw4RiJHg/Rz4U35tlUGNoiOBmE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynqec46Ngl3Fgq2lFzWrzIy3+QRGWtdmAm9GJKE6v3M1GShijR
	BqbOj8ww8NB1s9tZAs56Uj+JG6tvYbJYdZCwrsXffCUh5i7wf8SUO1RPwiIyUMY=
X-Google-Smtp-Source: AGHT+IGTnYovPt2hYcnHubtDxpOg5gYI1JO9bdw1XAH4HP10BdiydNOPRjVz5S6Ysw5b9Yj2djDYQw==
X-Received: by 2002:a05:6602:6307:b0:82a:4419:6156 with SMTP id ca18e2360f4ac-82a44196334mr1747748239f.14.1725554997543;
        Thu, 05 Sep 2024 09:49:57 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ced2de78aesm3713121173.65.2024.09.05.09.49.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 09:49:56 -0700 (PDT)
Message-ID: <b748a4aa-504b-4e58-9988-170e462401eb@kernel.dk>
Date: Thu, 5 Sep 2024 10:49:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Move the BFQ io scheduler to Odd Fixes state
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-block@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Bart Van Assche <bvanassche@acm.org>, Yu Kuai <yukuai3@huawei.com>,
 Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
 Paolo Valente <paolo.valente@unimore.it>
References: <20240905164344.186880-1-ulf.hansson@linaro.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240905164344.186880-1-ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/5/24 10:43 AM, Ulf Hansson wrote:
> To not give up entirely on maintenance of BFQ, add myself and Linus Walleij
> as maintainers for BFQ. Although, as both of us has limited bandwidth for
> this, let's reflect that by changing the state to Odd Fixes. If there are
> anybody else that would be interested to help with maintenance of BFQ,
> please let us know.

We don't add maintainers that haven't actually worked on the code. As it
so happens, we already have a good candidate for this, who knows the
block layer code and does many fixes there, Yu Kuai. And they recently
sent in real fixes too. So that's likely the way the needle will swing.

-- 
Jens Axboe



