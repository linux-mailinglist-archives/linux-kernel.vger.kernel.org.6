Return-Path: <linux-kernel+bounces-526234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B971A3FBD8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 17:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45A398656C7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C130E20FAAC;
	Fri, 21 Feb 2025 16:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Y2GBrl1Y"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860491EBA14
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156001; cv=none; b=EEwo6L1EEQn6HD/XiDT3z1AsIrPM7ECqVd7uAxDUFZsztxFiOSLgCJk+AR+1Xz7MB6NEClfTeGR5Jo2aTWh5Yd/XaU2s+fVB+gVDPaRBEUWhfPehWD63fJYrsYtYPyXyhxKgRbfFqd+g7dLEyhL+aYzrCbz8dMWFwuBkLBkH19s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156001; c=relaxed/simple;
	bh=VE5mMyStHsDU17NQ22dtIc4GazCDgcLebbjhX7Gm4lQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcgjAgUhgZFMehFPyf0eWyVHN+Z30vibG+amPpUbka0v1/UWpOQ899U4w1mO3FJKy6SRMlw/0p0PiTpMq41lsCjL7esn+q7Yw6Dad655cnJJ5bL5bz7yjMp69+fmveMVN6rISAzjm91uC9uxds8XCuH+KbhvI8CR2/f6Lga6eyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Y2GBrl1Y; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-855a1f50a66so60500939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:39:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1740155997; x=1740760797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tpIVheEuZLG2iAHIpc9LKyrAoq5nqc9ptuNxDevkzBg=;
        b=Y2GBrl1YCah/odD6SEeL6NNdNgHuuHA5oMu1xzQeXx7mdo5U5Jy0ZGKMKllFlLjzS1
         dqzFJVDKfUEoORsrEAgTho30PKqum+rUlmoLUAofgt9SGG9ewqIo2aqYWW1LSa5KxR0r
         Xcd03+Rrzfpg0sg/xMMztPEdaXMAdp4aUgs/XCNs7Dyaw/+p/kb+565lvc2Ul+Kgbh2R
         7OKA5zIPvAKZIfuzeBOpJzqWGLmSP4XKCAIbPGSKHzBpUmOalOvp8um4HtXNSFtflxa8
         lhKfqRPejPPkqO7qtky4gTM2RT3Znm3I6O39ea2PlAFqgL2yXx2thhwRTpdij9d1CduM
         MJIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740155997; x=1740760797;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tpIVheEuZLG2iAHIpc9LKyrAoq5nqc9ptuNxDevkzBg=;
        b=u4mFvwodM1h0hlIw3DVKoARw/mdREUDLi0NMGUKp6b0xlLznNcfNFwHKqM1iMWxYpE
         Yt4gxHHmp+cp3vjxMl01bGuVV6qhWt57OJTDu2b7/NXwG/FjwODTaG86URxCbQ9z53FY
         930A2sTmv4ljy8rxkSgulEyjnP7Foiev9WcJeKjjFzTzf+9wmzL1OB21kJc9QwTY4Wx8
         iK4cL6uzjbYDBMX3P2sTpu2yx6TPN7etQpXPo9CdrKCYafJPZt2+nawHnX7yHSUnHdiz
         Cp+HrsQVnBzMooweZnPo5fEKXPUqGF+VLfGkCNX402QRGVMvI9ltw7iWhoiLiypvPN1L
         NGzA==
X-Forwarded-Encrypted: i=1; AJvYcCXcg1V2BAZOde/2kMKFEhApAXLE+GOs9Xtl4bt1fZ6eUvRDEROxvejRzEifYjZOROI8iTBnKOohKEkhT/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh3qc4Kya83ogiI80WERmPD6RSKulCNp/2dzX1/LwMiQY6WUhL
	j+IV3yjMlXri0ZR6+ZXJYnxTGRZJT64JGi8YsO8bgI4TCHOu5jBo9tfSvGc5ksg=
X-Gm-Gg: ASbGnctgYEkIXA0eaouQ2CbZWOi7zqXCrQdggnMFHjuo9hQRnCehXYtuhbxbw0jBZ0s
	FSyN8SSwVZPxmRmxkg5haOO7Z18OZEyf/dzs7ebSt0et8weZil5gp2Fx4kT7aPdsp/WXlJ/yVww
	QXZnWLosE9OPzr01Z4Z9mP3QFAd8WVcTvTxw7AvV1JtjgXO9iY/dh0EuVDA1c3b3gwR98j7jLuo
	yQRHPsmsib9lx2Sk/ryiW/svSWEA1O5lUfGOGeji5aOf1iMMZfTiw/JJISNcDAEOoXBCUTvYc1Z
	982veq2CBeu3stQvxbG0MAU=
X-Google-Smtp-Source: AGHT+IEQDPSURcGXmuozZVdFy3UCuIUjqREgH/Da4GyTWHQurE3pBhVbAP+8ISGsn67fSxl7Tt603A==
X-Received: by 2002:a05:6e02:156e:b0:3d1:968a:6d46 with SMTP id e9e14a558f8ab-3d2cae6b841mr37216195ab.6.1740155997651;
        Fri, 21 Feb 2025 08:39:57 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d18f9c5bc9sm39596575ab.28.2025.02.21.08.39.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 08:39:56 -0800 (PST)
Message-ID: <0c1faa58-b658-4a64-9d42-eaf603fdc69d@kernel.dk>
Date: Fri, 21 Feb 2025 09:39:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] io_uring: add missing IORING_MAP_OFF_ZCRX_REGION in
 io_uring_mmap
To: Pavel Begunkov <asml.silence@gmail.com>, lizetao <lizetao1@huawei.com>,
 Bui Quang Minh <minhquangbui99@gmail.com>
Cc: David Wei <dw@davidwei.uk>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
References: <20250221085933.26034-1-minhquangbui99@gmail.com>
 <590cff7ccda34b028706b9288f8928d3@huawei.com>
 <79189960-b645-4b51-a3d7-609708dc3ee2@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <79189960-b645-4b51-a3d7-609708dc3ee2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/25 5:20 AM, Pavel Begunkov wrote:
> On 2/21/25 09:10, lizetao wrote:
>> Hi,
>>
>>> -----Original Message-----
>>> From: Bui Quang Minh <minhquangbui99@gmail.com>
>>> Sent: Friday, February 21, 2025 5:00 PM
>>> To: io-uring@vger.kernel.org
>>> Cc: Jens Axboe <axboe@kernel.dk>; Pavel Begunkov
>>> <asml.silence@gmail.com>; David Wei <dw@davidwei.uk>; linux-
>>> kernel@vger.kernel.org; Bui Quang Minh <minhquangbui99@gmail.com>
>>> Subject: [PATCH] io_uring: add missing IORING_MAP_OFF_ZCRX_REGION in
>>> io_uring_mmap
>>>
>>> Allow user to mmap the kernel allocated zerocopy-rx refill queue.
>>>
>>
>> Maybe fixed-tag should be added here.
> 
> No need, it's not strictly a fix, and whlist it's not yet sent to
> linus, the tags only cause confusion when hashes change, e.g. on rebase.

I do like using fixes still, if only to provide a link to the original
commit without needing to dig for it. And yeah there's the occasional
rebase where I forget to update the sha, but those get discovered pretty
quick.

-- 
Jens Axboe


