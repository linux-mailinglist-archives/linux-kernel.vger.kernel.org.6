Return-Path: <linux-kernel+bounces-212249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FE3905D47
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 22:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B09C1C21182
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 20:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B1684FDC;
	Wed, 12 Jun 2024 20:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ek/SQXK7"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD4F84A56
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 20:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718225874; cv=none; b=rgngbUKYUD6ute/ZxCwASsp49m7wuS/2NQhTfZZ18gYEqHyVVG3YOU6wMfC/zsvzyQcNQm5hyiN8cUoJBBJbvgD4RTXFWfYNRsu5BZns964zBblWKUPBCN7DvCw5T0UYax+ZxLMh4kpS6LUJfTk/EeSdP01v5XIyhH8fLYSKhos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718225874; c=relaxed/simple;
	bh=R6KRUoUZ9Sn5OH3wZeBm3taYSCMljLwNdxHxT8X/gLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UBaTzZsIGl6Ynecn2jKEgF+Qk2fJw2X3fdVauRvIBKj/Xuh624W6ni6bM0eQbZLpWj5RhQA2nDyRMRUANIH1n5/P3hpaLVwf5/vET/1w7ChZRA/bkQwPzR+BV+nGdekC8OznTqxqoRn9M9mUuto1nqd7hpGbQWOwYEOb7ZzAGdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ek/SQXK7; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35f1edc71e6so33138f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718225870; x=1718830670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uOsiW8OYUfyTW+up5+j2gle6/xMA5K2ljE518H1R1Kc=;
        b=ek/SQXK73skm3ujzXugQhHQVZh72MV/VTT2DGmOZRerYLi0wuek8fDoo4E9NmptUsu
         kWrMsTTY5jTKjAlL194x8qvCSnkxyfb8SKLMWSKgbyc+LOHVk9UCWaR/1qvvGvbedisF
         FJ3YfepOpvcMk5FKl4lTFVHwUnNxRKDzsShQ8oyU0lWWqVbkU3spf378nVi1hSSgRFmn
         TKfQjx4Dc0Vd7wydhm6s9TvsEWM0K1DZigEABLqcL+ZRNeGvNOeZoB2i9PmWU54N0cTC
         DdRYUEd2P+73Z37zTtEjww/PGvsWK3ukLVYg9rz2Ik4RwzF4OHJiJtsrQoDFZHEj1Ded
         L+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718225870; x=1718830670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uOsiW8OYUfyTW+up5+j2gle6/xMA5K2ljE518H1R1Kc=;
        b=q5Lan2cJqpEgBD3Udp8Di3sYNZln1MuSko000qKE5TowvUFoTDUeE1QYfCQ7pvgYRa
         ah1XaDBVOdtgP6aFY+Lv06F3gotNE6QQzAVOHZz6dX+Kgu+kzKM9KRhiXxSfrZrSHo5I
         3U/1oWeJZKhDS+rbJQnc4dWn7XLiFpjeGQTs7SFWmYhZHQMOjxKfQi4k1HmxIbzeX2+U
         BtKrHJfT9HKiSwanyXmMSFq3peBgnC+EtK2oG02lsWtjx00mJEM716Xx9yxwBkOdnkGU
         fxDBmpIjSYaq1Rzq/WFnxTn/R9wMPtqBYa7EdkrvfMZ3eXcOZYh2Xp2hSorohoQdpzbB
         lf0w==
X-Forwarded-Encrypted: i=1; AJvYcCVxDpGSHm7CYVvLI9/9u/qZGaP5XcL5Iue45+tNw8O0xgvdI4102iYhSz9dnMa4mEuixsLLMsv5+qUewMNpGxp411hqWwsV3eECKjte
X-Gm-Message-State: AOJu0YzcFKpZ7Pq/N+IkIlGKvaJBeBMy4xdE1xe3NIg3j6X4surk5iPC
	qa418iDuhLFKzG+cPOVYRr6P986jzJFJMHfVA601T62RQgxQi0bZwKaIRg==
X-Google-Smtp-Source: AGHT+IHaNx1hKLE9sUF1+YmsUUZ/Ldgz/P5eurnsRKHBXheW8FKCo81Fug4A133Nfa2IO1PoYcUwyA==
X-Received: by 2002:a5d:6c6f:0:b0:35f:306f:1580 with SMTP id ffacd0b85a97d-35fd4d89841mr2430226f8f.0.1718225848994;
        Wed, 12 Jun 2024 13:57:28 -0700 (PDT)
Received: from [192.168.0.104] (p57935a9b.dip0.t-ipconnect.de. [87.147.90.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ef83ac0c4sm687466866b.74.2024.06.12.13.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jun 2024 13:57:28 -0700 (PDT)
Message-ID: <390c1aeb-69ad-4a0e-86ab-992e3757cbd3@gmail.com>
Date: Wed, 12 Jun 2024 22:57:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: vt6656: Remove line from TODO
To: Teddy Engel <engel.teddy@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240612140735.2423-1-engel.teddy@gmail.com>
Content-Language: en-US
From: Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20240612140735.2423-1-engel.teddy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/12/24 16:07, Teddy Engel wrote:
> Remove checkpatch.pl line from TODO as no valid checkpatch
> recommendations still present.
> 
> Signed-off-by: Teddy Engel <engel.teddy@gmail.com>
> ---
>   drivers/staging/vt6656/TODO | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/staging/vt6656/TODO b/drivers/staging/vt6656/TODO
> index e154b2f3b247..876cdccb6948 100644
> --- a/drivers/staging/vt6656/TODO
> +++ b/drivers/staging/vt6656/TODO
> @@ -11,7 +11,6 @@ TODO:
>   - switch to use LIB80211
>   - switch to use MAC80211
>   - use kernel coding style
> -- checkpatch.pl fixes
>   - sparse fixes
>   - integrate with drivers/net/wireless
>   

Hi Teddy,

to me this is a second version of a previous patch. Please issue a new 
version. Your next Patch with this content is V3 as this was a V2

If you send in a second version of this patch please use a change 
history. Description from Dan under:
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Thanks for your support.

Bye Philipp

