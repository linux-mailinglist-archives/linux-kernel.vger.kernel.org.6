Return-Path: <linux-kernel+bounces-318951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3455A96F587
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E66B52842B5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902F31CF284;
	Fri,  6 Sep 2024 13:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kE5nEvGG"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431401CEE93
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629743; cv=none; b=ZGJ1mJeLXIyYgpZ9QhMPSHZzwcFnhAqJd+YjOwUTvpP8pLj/86mKk0HDVkToqG0+nqo3jVIJo3M2WV5535ka8swju2AYuemSmORI413an9l9jGKkIEBHE2UsNXc7waw+DJCRlxrflN+mkdfl6bgmeGFmdDc4PWnkjwVwb7r4cmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629743; c=relaxed/simple;
	bh=xlVjZvx8Kfz0vPmEL09K8qasOTDW+ZAK2Ezg1WHU90I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZiBGFAiWuEPSSRAjPvupHSOXf9phueYb+SIID7uNezMlIRWaSyPg4hDTQCN4pz0nnWyOMuSwGz7F8HUAB1IKKvL1RLiiy5OfR9J7lKiFYmha39khNG6QV/VUIP2oJEduRPBgWsskXvtKaYzxj5WdqtF7G72kCOM9XNEyWFubpqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kE5nEvGG; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-717911ef035so1458375b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2024 06:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1725629740; x=1726234540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HUkg54a17RgPhq+ZUhqMBAq3OcYYCQUYES715FhpxwQ=;
        b=kE5nEvGGbGtrn7ovqiuDUHxX/CvPnE6iyDsJOl8QXp9aTMwt1zltODJEXP5U84MAuH
         6dOdyLWwd5xwgxkYdWJkbJ2fxUWn8QPhQc5dyGBkY9CMFxaOii0oaTzqH1h8YNkrSHwa
         Q5GEAJ+LTXwK1baM90oKjEPU4MasUXPhFCGzXpcI3WybWic2a+cKBVwMbfEW0DNVqrFb
         FgTQAs8Cdn5dFhUTkJpImt4UzmDe+9zM9iMPZ6koIE5fq82UhvJ6UZPhzwZfEbq7wTjd
         2FObKMVUbffcTDtrnm3PYKHjnJGcMBNwG+9SCWLf/B1RhqB052sXupv6WHJwsCJnvE8l
         HwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725629740; x=1726234540;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUkg54a17RgPhq+ZUhqMBAq3OcYYCQUYES715FhpxwQ=;
        b=UIuz6SGAKeQU7TgL6FLCBuJcUJzalXt1SUvFqfMxKofBY64I0yLKj//henrlz9+2Ji
         tff7eVxLllXAxJlFMbgLj0sM0d+F6BoXnusQBFEzereLVYowAbGBZkWNzICIVjwLXseI
         trMF7g0XrDtm7QjwU5bek7HbXD/I1g3HBKB8Rkd8PyC5COmq+GrNng0SJ/HQG61vsEIi
         g923xYcDbE84KTYpCzYu96a5iIKBy7DIaYExSJonYEEwwPkO0bnRDSxm/6ana6+qN8bu
         5qrAtyX1VWaa31ehKmyMYSe1Hnfef8p388VtWJoenQI54VUbtg91YEulcoAw5QRWczDP
         Vczg==
X-Forwarded-Encrypted: i=1; AJvYcCVVcFOKKXtWeqpL+o/pKW113ZGVEkeLckvZfX6n0wWMYnzxkmZYAlcG+xm+2LD6oqNiwEN7TFgUrZsc+zI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAUNFkj250ZNnKSzMeXX7V2p4p9ooZMNeSooyim8rQRWNn/w1t
	GBPwn1uFvPjQ12L/PRaSW51FsqaaSUY+BAh2Ydi8xs5zBud+658aIZ1on+AINA4=
X-Google-Smtp-Source: AGHT+IGFvHYovNLVwygh7r0q+MBWbY2jxWYMiDHjPm5qLRaRrY6yw0WVs8cGTasw3+nU4Ajqq8jg3A==
X-Received: by 2002:a05:6a20:cf8d:b0:1ce:e6ff:df29 with SMTP id adf61e73a8af0-1cf1d0ad680mr2309474637.14.1725629740505;
        Fri, 06 Sep 2024 06:35:40 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778531d77sm4826275b3a.54.2024.09.06.06.35.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 06:35:39 -0700 (PDT)
Message-ID: <cf7e9e40-dcd3-4bcd-8bf5-fc1d594afae6@kernel.dk>
Date: Fri, 6 Sep 2024 07:35:38 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] block: move non sync requests complete flow to softirq
To: ZhangHui <zhanghui31@xiaomi.com>, bvanassche@acm.org,
 ming.lei@redhat.com, dlemoal@kernel.org
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240906095414.386388-1-zhanghui31@xiaomi.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240906095414.386388-1-zhanghui31@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/6/24 3:54 AM, ZhangHui wrote:
> From: zhanghui <zhanghui31@xiaomi.com>
> 
> Currently, for a controller that supports multiple queues, like UFS4.0,
> the mq_ops->complete is executed in the interrupt top-half. Therefore, 
> the file system's end io is executed during the request completion process,
> such as f2fs_write_end_io on smartphone.
> 
> However, we found that the execution time of the file system end io
> is strongly related to the size of the bio and the processing speed
> of the CPU. Because the file system's end io will traverse every page
> in bio, this is a very time-consuming operation.
> 
> We measured that the 80M bio write operation on the little CPU will
> cause the execution time of the top-half to be greater than 100ms,
> which will undoubtedly affect interrupt response latency.
> 
> Let's fix this issue by moving non sync requests completion to softirq
> context, and keeping sync requests completion in the IRQ top-half context.

Didn't we already conclude that the fix for this would be on the f2fs
side?

-- 
Jens Axboe



