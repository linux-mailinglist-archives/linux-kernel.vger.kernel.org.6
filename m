Return-Path: <linux-kernel+bounces-555106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E2DA5A571
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB493AB22F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69191DF74F;
	Mon, 10 Mar 2025 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gD4So5IK"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6976D1D5CDB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 21:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640510; cv=none; b=E99iCDst2MSNgt3u2LY1B4zmHOuLKx/HT5VqNqDnZQaz8DDlGhp8MgOfHO9VSkyw5mHW8KrGAHI+kgWVuVavayLJ8OhcYdZu0UX4i4J4S2vbSs/+D3dOJg/BUy1du6kPub6t8mSCanmz4SAr+1EGzH+KOT7tpNgJAaFR3zczKM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640510; c=relaxed/simple;
	bh=uvl+tCTSBkpkA1JocRjArWmG37T36+NIL9cpQh3h/7o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B57/ig3ektUCQhNf63WaNye9xh3+H0yXxOqtMVfLJgXvR8LAp3kjyVJwEJmlUufAEBcCeHgKyQ9qDAvnZr9aMbMcFNmKNb+bCcyJ09HVFv73RgnQGXG/WRcD1YVs52zOjAkjMDxGKttxaCD7DWZJJiPoIthmQ1WD8S8+P7D8D4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gD4So5IK; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-72726025fa5so924278a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 14:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741640506; x=1742245306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mh6NBQiJXATQe2dlTg58r4IHLGmkgQvhFuYRHTx4JoI=;
        b=gD4So5IKpAvy5uKSGrhX3CF1MhN8VeXjcQST/2NIsihABLxIdspg/Dwd+gIw5xw1y0
         CJgrkqqYjLvpIlr5VrwOxkttdw5iAl2uEUJEARU4K6xUgi/CIp7DqlZfenA0HHPiAYYK
         utQXzq0EH3UmTzBi5KpZgzjr6V4FDyd7UP7SaKvoYhemwnLPiI61QSqMLJcSAnFAVI6u
         P1KvqD3SHTrxglYPOUpB2KcLmXB+gald9DA/8UZSKhrN03/QEzvZ2SmDmOtU3jCAYm58
         OMIme8YOUnhptFlyAO4qH3SErcyIYF63Jd2yRUnQadTdHu+pE5+AuDtclfVhkpR9MrUN
         PW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741640506; x=1742245306;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mh6NBQiJXATQe2dlTg58r4IHLGmkgQvhFuYRHTx4JoI=;
        b=JOnqNZQGCtoVbWeOLopCxW0TNO5vd/KQ97F5sA6hhulVaVHH3tZN32eFKgMPtnqpOz
         D2uoxM3Q0w41LVzl8KWqKIPiglRjlh9AUAPNHNm6hPv4LTSvEVcBygY6Huf/TeHGPbYC
         IV94rM6kJB7sQsPzyS5oV70evJjBESLHJ05eE/B5f6vC1QH1ENwpKx6Ehu+6u/qT9rE8
         grByNNEjzGFhkb4ir93Z6ZH+g2inuc1zghLig+5jFj30uuv9JJ4VPlIK1NaN2Ztnv8vF
         Md2iuXb5A31/UTVqqWUu/pN80ujz8oSO/f4umkRYwq3aU88XQ/utMxOmCDUTbbvsGWMB
         Jk1A==
X-Forwarded-Encrypted: i=1; AJvYcCV/Zue+M9BFLTvBXquz+5lE+ydaVbklFz9fhWvsPpTGfPLsvHcGcMR6Cz1BGyb798aDg3jnKB0/G1RZljk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRAYTSXCeBqNkSHOJqbC45fHu2fKLQaymq6Okh9UbKAG8szQj8
	3p9zWV3smWOxeahs6P8ZBs02V++J6aY1pp9weAcsHlmC2P0jjyp8UmOEMIXIzz8=
X-Gm-Gg: ASbGncu5y0yt6m8wG2IIc2dIdqi04GxOMwkBp/CgFq82I+kQsSvqjKJ843GJivT4M3e
	J1w7E0PxGx76AJvtKDSbFNDPzxUlWkgDJ+NcvEtqi1Trs3pFmDxZkgio392shIetjfurEwUbDIp
	ykWydCtP0uRm3BH9vTcnQW/Otp88zgqH51h8bIMxFsp8nXjT2H04dD1qWaHGCzy23Fc0jt3pJJQ
	cw1ZyWq4YaRgzwAAx8zSQPuDXNgS4xhWHyPB68+UlR9uKs3WaWqglwpfb5DnO+21p+0DkskBiea
	Jntor68UvQPi/fMFYvuUnIH6E0gQfdo3f1B9ANG7xtyZysTc7Ia+VcSDurXUiHBD9/VvJ0N9hXL
	SUAxpiTbgsYvZOFi6
X-Google-Smtp-Source: AGHT+IFws383NJzGNKMTduW7VFs/LhYVCds9An+PWkBfwPQGP9vDAELOMSUsERr+wmmRotC7x4j6MQ==
X-Received: by 2002:a05:6830:6a8d:b0:72a:11aa:6ebd with SMTP id 46e09a7af769-72a37c771c2mr8328040a34.23.1741640506456;
        Mon, 10 Mar 2025 14:01:46 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72a7c926001sm1298993a34.32.2025.03.10.14.01.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Mar 2025 14:01:46 -0700 (PDT)
Message-ID: <3fa4136e-b384-4c3b-a58d-773887b87552@baylibre.com>
Date: Mon, 10 Mar 2025 16:01:45 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] Add support for AD7191
To: Alisa-Dariana Roman <alisadariana@gmail.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>,
 "Rob Herring (Arm)" <robh@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ramona Gradinariu <ramona.bolboaca13@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
References: <20250228141327.262488-1-alisa.roman@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250228141327.262488-1-alisa.roman@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 8:05 AM, Alisa-Dariana Roman wrote:
> 

Probably too late...

Reviewed-by: David Lechner<dlechner@baylibre.com>


