Return-Path: <linux-kernel+bounces-575371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9131A701C3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64EBE19A6C05
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6BE27701A;
	Tue, 25 Mar 2025 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hQa4vGIY"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CEF259CA3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907179; cv=none; b=AcB6XN6frDugm01kLdzEhAluJBua3E53s7hlgffdoiZXDAsd0uj27Q1gYGBfAqtAjfxjdAbeJDHS0xcePidFr5+xQpZ5J3/3Xbx8dt78stZhhYHsqL9ktn0QS/6i3yfTms0wOI/XaseWJe6vwfwCirBg/HOoyKf9Vk/LHqVzsac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907179; c=relaxed/simple;
	bh=hbjFWc/M1u0JtUeGDfraCyEfZ1LuYrMt6ic+SN3g7Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kH6blFE1TmDzpTnyzdLVFZUGQDnYGhnB+lLeQGBUacCDrHFnyEt4QwGUm6XWEGOpSrTye4q+fdZCZn5eTDShUpqxNGp/ym+9zwLMneAfGaD3ZzaiZsGLfxZFaA2tQIgUooWNndrC/1EN0W7yM52k1L7DVPC7iKDTtD2qtbwblPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hQa4vGIY; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c56321b22cso605353085a.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 05:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1742907176; x=1743511976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=hQa4vGIYgLdyUaF3FHuYkxrOS+WFv1QM16ozK09RJAz1+05+r0sfUiNL3e9fjSrFvz
         2G+k8sE4DvYi3RU6y3x3tdz+SmkdWI+GLx2hROIPqXPhv5cU3atH0X0r6AvFQurFUp+c
         3IBUtLDlWoaV0lM2aRtIWn29NrvBP0PyvLStiGhg9o9q4munhaRJzxFQAKueX2NiUnCe
         k2LiMC3b7KuU0+etcLWLEUUgXQj5W0ORk+QJwH/9jauNsAVZxvvdLRSIzM4xqiqdlhZq
         69SnhY1QPSlPGW2J/mDQ/+vv1nf7gBnbhaJS21fQ/4alZaxfdazR7aBjCpB07Zyqnh9u
         UNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742907176; x=1743511976;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+f5haOvY7V5aJLRvqMe+OKgyMJap2D1kg9AHRnXBFo=;
        b=NAQSCgFTf8mopJ25cExOxYidvi5ECxvK18xhgnn98fZBKcNNjwjN29JJY/0n/12xQ5
         MzI2or2mq/hHXCoKthwjMMa4gtD2Xj4SThu4MdjYVqgW3MowWb/VsG29ATcDRwJlNQBT
         z2cgfdVuTZ/HwOwxt0ccm9EHFWSKTEVwDtwT37CXjiJLwDO9DjAfUf3WaQm9on4j/cUZ
         cMwRFCGyfZiajR/1LIXeQpziakwnxmgyMUiPlFasJgi0ZL65YSRAnB8wM/VIp3ose9ST
         0WDJmh7DJw3WHJeXqwpDOgaE3GmFkD6M57ALyopmvlG9Q3VHl8Qy7QG0hfIn/IResJM7
         bADA==
X-Forwarded-Encrypted: i=1; AJvYcCUtzfGsvXOpkausnZfew/lxBFlXliV/u4gelIeSizM7ZLbzumUWmTMqhLzxCh+gaS2RLmLzjmDRJK774kw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXAXHAAEzlwtmMWm+kO7GUrRKQMVL3ktygEIV7y5kOmWLykqut
	iPoE+TFB2D8NiUBeFeWf8oNfa2xJviNp/+Z4G2mDp9eaPx3nr19/ecnepbWBOmg=
X-Gm-Gg: ASbGncus5hzWPAqCvJVd9tRXzZrCAl9Uq8quU0/yBdyUB1yzn0BGCnMSHF/5Mc70BND
	ujRlAsIrRPiT6qRzzbOvvexZHGWjk+m+r9asBHtposQ4JBgr3P3jVNQj7sGtY1CIipHUfBSu0hR
	cl0TPoQr8rxTic7Nlthpn/9hft7RGk5JqyIzROHGUoQ7BYJK79fKLueKV2sbnzH40ZxfswU+XBD
	WAr2nPLNjgUeT8fNsXRu2b1p1xmYyvmhKVdAZr8sjly6pYaZUDX8Gb8N2Vb7oIer9aCCvT/4MAX
	Jn8NYjlj1UQo+nghWdelabYKXGY++BMpSd83jvrgFg==
X-Google-Smtp-Source: AGHT+IGuzAh1m+3Da8HMyPjo4cS8BnNgDmCwUc/FwsVtlsCsRku7PH5rlGDzAZSOlfFgYFdymsUcNQ==
X-Received: by 2002:a05:620a:4554:b0:7c3:b7c2:acf6 with SMTP id af79cd13be357-7c5b05296cfmr3274590385a.15.1742907176053;
        Tue, 25 Mar 2025 05:52:56 -0700 (PDT)
Received: from [172.22.32.183] ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5d7eb96fesm144992485a.90.2025.03.25.05.52.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 05:52:55 -0700 (PDT)
Message-ID: <846fb871-c171-4f31-9097-5396aa9376e7@kernel.dk>
Date: Tue, 25 Mar 2025 06:52:54 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] nvme/ioctl: move fixed buffer lookup to
 nvme_uring_cmd_io()
To: Caleb Sander Mateos <csander@purestorage.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Pavel Begunkov <asml.silence@gmail.com>
Cc: Xinyu Zhang <xizhang@purestorage.com>, linux-nvme@lists.infradead.org,
 io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250324200540.910962-1-csander@purestorage.com>
 <20250324200540.910962-4-csander@purestorage.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250324200540.910962-4-csander@purestorage.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

