Return-Path: <linux-kernel+bounces-303359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA5B960B28
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1CC91C22EBD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D771BC08A;
	Tue, 27 Aug 2024 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XPBm6UMb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DBA1B3F33
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763300; cv=none; b=HwrLafdvYljz2Mo0IZ7AamGKHsi/7pss8kEXcn05CPXs0tEJY4A0776bMRxRQ1h1uCTwfhJ3yi+JPJXw+w7nB4A2Q8rs2jPJa9tXhW1sH79wAHks+J83BtNLpB6xh2rlhOi+xQSsGVPnG0hcA1uxMF4NSHeIZa4ncaT9JJEJSgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763300; c=relaxed/simple;
	bh=6Vea7Snn1Uz5kG+HRqv1WOYzVme5HarUsJsA6T/n0/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+roRMIoce4AyWJtHBBLgj7ric9a5EusBt8T1GiKSh2CdBek6ssagcW5dA0GSUyTMeSdKoGX+8Q3PUmEA8MW+mnnRpzCoJctY4TkqhplQwr7PzMwsNrXm8/kokhE+wN3RpcsYXrsZRgIC1/k4ETg4yHQhKsimiC/7zuVi8oAiqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XPBm6UMb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724763297;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YvhPKPj5fM87oEo5FNslIVul+ObBq1WAlqgHhDt1NF8=;
	b=XPBm6UMbo5h6zMMASYZ95KgSSBvNLJ6/eZpFduexPokMESyuGkgJ10K5Jd+zNuiAN6oSAD
	wHBRlbCqwHHZU2LS1910Relu6wZ3ie39kucN00GdvaNKRl03JLI4TNxUDvpoMxEHDQA5PN
	HI3i1aujviSwSfiCr1IoJUuOmCuWAN8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-wedJUOTKPjWuZ6XSAMTgBA-1; Tue, 27 Aug 2024 08:54:56 -0400
X-MC-Unique: wedJUOTKPjWuZ6XSAMTgBA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4280a434147so48206415e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 05:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724763295; x=1725368095;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YvhPKPj5fM87oEo5FNslIVul+ObBq1WAlqgHhDt1NF8=;
        b=p6XHBJIPxyCaH2xQ0+eAYXAo9+h1xtwOgBzeJOeYGxNhZB8DX7qAmgE+J5pIQHPJFi
         c6cCLjqegmiSNw33MByBpfZDs9XnreYai78jbNkGI+kzSqLwbuk2Ik0QH1YXQi/5VXL0
         CmJl3l3dwdU7AlhcLiOtIaxuCu8EfLKgIfCzRjheALfeCeVgqqgENRmpJY5UnwVuq84y
         m5STFr52irmV2RxmgrO/fFPi1iJRGOtdj4XpWz3jKh3TPMz0L0jm8Wftg9Y2hO5uTZn0
         jnZopsjR+4oZxDiWUCsmbHMhUiXoOoczV5YYwNHIOiIIYBWK8jMHjtP/V/tV0nNoPlzR
         rA+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWens5JFDZ43hfuQjyHkHYiUIgmTfuiv1d8SbcQLgogZCLBWWZPTPyElV2Gz4rbRtYAT1KKdBxQNdVD47Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxXBGNhTDteg5oi4d5+fAthMNE+R13owTHaYBw8g10W3sDZ1ib
	Srp9c6qNZ7de8hwlj0fc7BiqzFycH7JWgR+0iNXlMwHT5s7TZK5hc0JSffxlI0+zIP3qp/3H1V0
	BKJ4VLd13kJ4o4cuO3j6uT2jXDy2RSCXiGtI52cLY4Sy7xMdkqZZ46mRYtxolPA==
X-Received: by 2002:a05:600c:1906:b0:426:5416:67e0 with SMTP id 5b1f17b1804b1-42acca0228fmr90411265e9.31.1724763295104;
        Tue, 27 Aug 2024 05:54:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcKzocLFfj1Zx6zpPCdu24ks+pENOx15zFAnOfiJhwTIujoyYSZJ76haH2DnJIoNowgxjnEg==
X-Received: by 2002:a05:600c:1906:b0:426:5416:67e0 with SMTP id 5b1f17b1804b1-42acca0228fmr90411045e9.31.1724763294667;
        Tue, 27 Aug 2024 05:54:54 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b67:7410::f71? ([2a0d:3344:1b67:7410::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37307c0c9c7sm13213393f8f.0.2024.08.27.05.54.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 05:54:54 -0700 (PDT)
Message-ID: <36f312eb-150e-4497-84f0-6bfbaab16d9b@redhat.com>
Date: Tue, 27 Aug 2024 14:54:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: microchip: Use standard regmap locking
To: Mark Brown <broonie@kernel.org>, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240822-net-dsa-microchip-regmap-locking-v1-1-d557073b883c@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240822-net-dsa-microchip-regmap-locking-v1-1-d557073b883c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/22/24 21:53, Mark Brown wrote:
> For unclear reasons the ksz drivers use custom regmap locking which is
> simply a wrapper around a standard mutex. 

According to the commit introducing such lock, 
013572a236ef53cbd1e315e0acf2ee632cc816d4
the ksz driver family one regmap per register width (8/16/32), accessing 
the same set of registers.

The locking implemented with the code removed here allows serializing 
operations using different register widths.

Thanks,

Paolo


