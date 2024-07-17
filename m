Return-Path: <linux-kernel+bounces-255651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDD2934336
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 22:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B71C1C21332
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 20:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8501849E7;
	Wed, 17 Jul 2024 20:29:05 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A5C1EA71
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 20:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721248145; cv=none; b=f4bnh6Tf+gyFagpcsjpJ4eq431qDnymk26BqqT6/I6Okn3nhuX2zxZsajwpC9JizI2qZ4aTZ8nyT/55VM0MMMN7HseKtDknUBPlh6YgB9/1GNg0XoW+gK6vn+weyQPOKIo7sMuMIXb0tX9TW2/p3ZiqoFHm+lb+PofBiu3aERoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721248145; c=relaxed/simple;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CffsoQmDkexSKFlYKvPi7Yri/Kd8QOP/CpaDIi/mqVuoOOHxHHAioa0nEGhU+JhTHkFenBmxHscnvXl2eD++TGDfkXVaJ4dt1+fenjo3SJpwj2s87am6N9lsxrUJEGS4yZ44vs8TH35BLOS129JF3xolR1WqA5PoUkad/y/rZBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-426744ca29bso103785e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 13:29:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721248142; x=1721852942;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=fiooPy/F6eWEEFktziWAdAeKZ8wvfFfLQ+UzE3+JW1nzhsvly9sZi1dvjaitbHaZLV
         mcAyXK1vXBoBklV5/INFBt8pZFAUgWGDC+oiQO3ceuWdY1ef2iWtVhnGed4hos69vYlN
         SQx8+Wy2RmcqrNxNP665JjfqoF7MMnLorg5mWtYmbDD3b6wqpIKxcAeH8KS+wKB4NKFv
         UPb2DlGHsNlZkj7Uxy4Os10ZWehRmP7v/T2laYjgIoyiog5ezofxXLxN82+7ocop/ig2
         xpHJC3YQJBaOrfPMizNGlPDNvEEVpumcP4iDbTlPhgm87leYoekMDApICpRnvZkhmK80
         gv/A==
X-Forwarded-Encrypted: i=1; AJvYcCXYBIIcIS/+DHDqn6V9pXTWbJ6MfMYP6WFjTt1hgbH6Mmdqtxjn3v0mPN8UmwUNp48w+g2tAmugrpf+kb7Cax1mw+YqRcvHs8j7G7F0
X-Gm-Message-State: AOJu0YxhDSnXNJ/BmTwzxaQUI6V+tZaGiwehRit4Mdfyu8TX1MuO/LZN
	x4bOj4lL8Sr6wMYfTdMoEAO+SF5++BqaOFSg1wyJsm72Y09RwSZk
X-Google-Smtp-Source: AGHT+IEgpTsF4KTygZw6dmo2qCMX729MyYcSTCY0zjO1oFNbzgvBxVxJSlaCNJD0BJNzGgyZyAfh7A==
X-Received: by 2002:a5d:64e8:0:b0:362:1322:affc with SMTP id ffacd0b85a97d-368316fbf8dmr1204272f8f.5.1721248142165;
        Wed, 17 Jul 2024 13:29:02 -0700 (PDT)
Received: from [10.100.102.74] (85.65.198.251.dynamic.barak-online.net. [85.65.198.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680daccb6fsm12361199f8f.65.2024.07.17.13.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 13:29:01 -0700 (PDT)
Message-ID: <cb419a98-e2b6-4836-92c6-928f00e4578f@grimberg.me>
Date: Wed, 17 Jul 2024 23:29:00 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvmet-rdma: add unbound_wq support for nvmet-rdma
To: Ping Gan <jacky_gam_2001@163.com>, hare@suse.de, hch@lst.de,
 kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: ping.gan@dell.com
References: <20240717091451.111158-1-jacky_gam_2001@163.com>
 <20240717091451.111158-3-jacky_gam_2001@163.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240717091451.111158-3-jacky_gam_2001@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

