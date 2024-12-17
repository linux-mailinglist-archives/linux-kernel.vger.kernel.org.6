Return-Path: <linux-kernel+bounces-449572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9624C9F50F2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8206616DB24
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5FF1F8675;
	Tue, 17 Dec 2024 16:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nSkkUGQg"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D3A1D2B11
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734452102; cv=none; b=MW1SsJgFl2iJb/Ux8dKD2jTvIZJNBcAgiw/OIMzo1I+LfXV5vb65oaY72crPVsPrLWOpl1lgf3Pc0GbGfOOwTC2CtYiQ9JY/1hoslb6t1Y1NhvoTLp3KlsknFS8VeYB2T13ICsGypjd3RRWFeWFrDWtoewBH3mlKQEJIpRv6bdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734452102; c=relaxed/simple;
	bh=QPSYckfiLL1lnDodBtIUNq6qmRcvEFpiARDp6WB18es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5Wtqulf7KrdwWOgNMu+b9RhHI2vDgxdJF6UmjWgU+D5go3oTNxxfsVFosvF7pp9vo58Z/XW8Guo8uV9UiEUsEdEKQGtVYJYXmhtXfY0cuUJrpPtXiHP0wgP02egeoadCM6r3ckAEq2Mjm+GD8sIB4NwHil1vsHDFN2c5bA1ItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nSkkUGQg; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5f362c3950dso863117eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:14:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734452098; x=1735056898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g0qj2ZtXw4mGi7K38v9aznJPLj6SnTFWzYOgNwna2zA=;
        b=nSkkUGQgQv2E41niw4e6a3oayeJU4WXtNTTgq4j3NTQZRc3Hy0ozJ7fv69bKPSQIRO
         ce+4ATmjU8jMuTP2LXwbgT6VBKFtLKUZzNXKOTDEr/qOJ/tgzE80qqfTT4jLJJfVbb4+
         9L+z9cUSIIG8IZ83BkHrHOA2RZUqTF3+rW1cABaaTsw9WwZ9yl70+0SQjP3aBNt/VjYO
         +nKGWmQoxTJSDrxYkvA74cDiFPkHuB7UAnB7lP9Nz62S/gS+kF3WJumVh5vpdNI29fuN
         sfkZ6NlKBw9Eg3Ezb0xCAnm+SwWB9vz3oy0aG84ceaMCIrLpeEUdaP9jKyOgvM/s3hCO
         LP3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734452098; x=1735056898;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0qj2ZtXw4mGi7K38v9aznJPLj6SnTFWzYOgNwna2zA=;
        b=S/LAafLws/KrweFgDx3uPhyxKQvLEdAfffUkRkwNlPO20Vp34++A5hQ85gFepfVaky
         4BrLygli8/UgUm8ygjn3IsbUGWzFKq1Y0AWUNS22Aj+Eg0ZUYAPE4PK9QbbiyX13dQJc
         d4ZsuDod5CqDwLB0DZ5tqwo6V0Gq3MkY1O6qPCcmX/580qW6ouzYEVpRPru2gqbi7TXp
         FAzayY1i+iSnDmn6O/5Aub9AfwjP8iMhnhD8/Sa8ypBJ644TH0W1NMSa/RGkSqmNBhFZ
         T0OUCdKAJDfvFt37TKD7QYSdOSfR4HDf0xVTvkEorYr0OxMa8IJvIILspcYbPSGusveT
         N1iQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvw/aN7COgjOYd5MTqSgSJpM0D/imEHwV+h8UkkSTqGh9PXbPpWFgt1RQ6Yg2ZB5MQoaCpxHldcFQ4OiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn9BgKCtg7anjTBIEteklKpdPVsUxx4XP5EghLUZFtk8hQs/6y
	vmOOZ+78CnrxoN89wPhhEBUTg4QQmZaBR38+n6bgR+ObFiJ9zc5RQJr2y7Lzi04=
X-Gm-Gg: ASbGncveC9NIWkWgndmkhrmc+fTOs6pFqn5PbmsvMzYWL52nDDTMAwsvtuTZVIznzER
	dBFnPJtgMy/ZZoryzdhJbp53juJjjUC3ed3qAmkoP+HYy+nwTPIuyoz/ieefagpANMafShcfbfX
	B8ZnBnolCGgYfG5rDbLUYBK/x9aORYkVPdOx0ufYXcHkVsf8rYoiY5O+6qmbXgQrvTIIp2SweHC
	bVzRw92MCaMniU8IlMTGs61ys/hWSkD/ucazT6wene7Y4lP+YHugJ8Kfu7oQe3fpE5ztmwkU/j2
	Lqnt88gztfxkLehI2w==
X-Google-Smtp-Source: AGHT+IHi5YlEBrO2w3hulIZ7f3Hwzjg+RNVJ+wTBdSjvtZ6AqMLZVxIyBU2OF+hr5jFFwnec6Kgcvg==
X-Received: by 2002:a05:6870:7007:b0:29e:65ed:5c70 with SMTP id 586e51a60fabf-2a3ac99010amr10303582fac.30.1734452098401;
        Tue, 17 Dec 2024 08:14:58 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2a3d2913d16sm2845239fac.35.2024.12.17.08.14.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2024 08:14:58 -0800 (PST)
Message-ID: <962f14e6-9b6b-47a4-9751-fa017399e563@baylibre.com>
Date: Tue, 17 Dec 2024 10:14:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] iio: iio-mux: kzalloc instead of devm_kzalloc to
 ensure page alignment
To: Matteo Martelli <matteomartelli3@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Peter Rosin <peda@axentia.se>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241202-iio-kmalloc-align-v1-0-aa9568c03937@gmail.com>
 <20241202-iio-kmalloc-align-v1-2-aa9568c03937@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20241202-iio-kmalloc-align-v1-2-aa9568c03937@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/2/24 9:11 AM, Matteo Martelli wrote:
> During channel configuration, the iio-mux driver allocates a page with
> devm_kzalloc(PAGE_SIZE) to read channel ext_info. However, the resulting
> buffer points to an offset of the page due to the devres header sitting
> at the beginning of the allocated area. This leads to failure in the
> provider driver when sysfs_emit* helpers are used to format the ext_info
> attributes.
> 
> Switch to plain kzalloc version. The devres version is not strictly
> necessary as the buffer is only accessed during the channel
> configuration phase. Rely on __free cleanup to deallocate the buffer.
> Also, move the ext_info handling into a new function to have the page
> buffer definition and assignment in one statement as suggested by
> cleanup documentation.
> 
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


