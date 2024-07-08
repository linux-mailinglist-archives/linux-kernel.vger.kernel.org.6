Return-Path: <linux-kernel+bounces-244465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D32C92A494
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB324282865
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D0513C806;
	Mon,  8 Jul 2024 14:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Tche9g9/"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802CC13B2B9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 14:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720448750; cv=none; b=nEOACwTWw/rnyWA6Umbu4M9pJP3bo+NuadKwLluWdwxAS51lmsS5iMOFtdGNUKauxIgxvNvC69GE6fbZsEZf42rAc8am37HX+XgvfL9tofU204F0FwfQOLs48tN7ig8GUPcBb7w5IBek1CK3EEaJch2w64pp9hPf/mMXeEqQuTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720448750; c=relaxed/simple;
	bh=sVqP3HYILE8K4kseLkzHEkhKSuPq7y6d7aGwycP+SqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDTUDD0fMX+GjiG0QhLf2G7y8UlpU+qEwC0BsRI8p42sZvrWzyAgISFFXmD8IsQymerp2M4LjC+qfwZTLraR9UH9tGy1Z+6rkoL0X7l+pkloJCfCv3ZFSjvVeiyXS2V2Ejg11rqnYoYl43J6qnn/0r4IbwBysBvcvE0qGVbr4IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Tche9g9/; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3678fbf4a91so2076870f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 07:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720448745; x=1721053545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W/eF7oIcPCmgh2btkuGSELcXuAe2AdViMi7aYroQLWw=;
        b=Tche9g9/WVvR0FFk/CXfJuU/V9Wg9CJg+77U3ZPs8OV+/E8qjPQzL+ihN2gYyataOe
         gKZzPyFhLYQAl5wgRST8RHj+9M7dXyfBIUcXILaRKK78OEivUSH4KJzjbs+NaWtxRFMq
         53QbOg9cMnMPOWppotREzjSgYFeBDJPJ/TL2mYY5wbvwcBogYZW0QaBkL+NNKRViMjyq
         wYigJwySeBWBtX813DVeBeOo1Q4QxV9CdxKLnxUWHFCGbvPrPoZSHVzJzfoURtgna6/8
         sLzrzHQxcM0l/biX0QZGpw/acYbqBWnha08STsw61jWDG2kGQYfvj5lak9RWDTvZ+6qX
         IBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720448745; x=1721053545;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/eF7oIcPCmgh2btkuGSELcXuAe2AdViMi7aYroQLWw=;
        b=qk/If5MiZABSRvsTfjilo8WexpQfk4A6r0w2d6UTxV1TNmhqGV79XsjTAJYErtPHA8
         Vf98B8gGHWPxi7WZR5TORxpoIEpoMw2bPsdCUgHB9A/tHKp/Uwbcq0IM/vbcQJCuaiDy
         n7i8b1rRx9SXQsIWu/vxQLFfzcPqAhAm3cIngR2mwkTQb8bXxC93ZFa+DlGVbYoW4Ms9
         G9yTZN5I9maahFla6wD/xbkD3GPXTrXgCLguW3686Ix8S0wN5tyA4Ez0/J8Fw1Oar+TV
         UZdkHHRKHPamu/QA4moNcbodaQpqajPQsx+q2JbNDzuYj7av2AuJQkEljucpJQl5SGdo
         zupQ==
X-Forwarded-Encrypted: i=1; AJvYcCUATm/Fs5hE9weu58R52gdhC0NH3lcKmURoiv9nbQcVw0t1FludFZaaKETNoVv9/Boy/x//FlmNDTNNrM81wg0Dr4SK+2P3LPg1w8Q7
X-Gm-Message-State: AOJu0Yycbsi2YckCZD7NfgDzJqxgYp8GhNBoa/WLyqb9Ihy/5J2gB1ad
	ShgnblLyQfQpZD7K+Z9fV+RLhkvuLNd121wr2C96XT+xeV/LmXOsb4331Lm7Hc8=
X-Google-Smtp-Source: AGHT+IGdkjg5ScqQmofH+S1f2GzeJU8mlai3Mw3zLq/JArqhrfdX0A2oYma/TLFVS0tZC1Er+OwZ+Q==
X-Received: by 2002:a5d:6690:0:b0:367:89b0:f58a with SMTP id ffacd0b85a97d-3679dd73c4amr8167197f8f.58.1720448744888;
        Mon, 08 Jul 2024 07:25:44 -0700 (PDT)
Received: from ?IPV6:2a01:cb09:d029:b5a2:628c:ea6c:7082:b40d? (2a01cb09d029b5a2628cea6c7082b40d.ipv6.abo.wanadoo.fr. [2a01:cb09:d029:b5a2:628c:ea6c:7082:b40d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36789d5ec1csm16066152f8f.37.2024.07.08.07.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 07:25:44 -0700 (PDT)
Message-ID: <f8f33e5d-5595-4218-a754-eaab71e30510@baylibre.com>
Date: Mon, 8 Jul 2024 16:25:43 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ti: icssg-prueth: add missing deps
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, MD Danish Anwar <danishanwar@ti.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240708-net-deps-v1-1-835915199d88@baylibre.com>
 <1eec9f10-9eda-4f9b-b0f8-28f25a6153ca@lunn.ch>
Content-Language: en-US
From: Guillaume LA ROQUE <glaroque@baylibre.com>
In-Reply-To: <1eec9f10-9eda-4f9b-b0f8-28f25a6153ca@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 08/07/2024 à 15:53, Andrew Lunn a écrit :
> On Mon, Jul 08, 2024 at 03:38:20PM +0200, Guillaume La Roque wrote:
>> Add missing dependency on NET_SWITCHDEV.
>>
>> Fixes: 5905de14c2a5 ("net: ti: icssg-prueth: Add support for ICSSG switch firmware")
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>
>      Andrew

I will send a v2 , shaeone was wrong on Fixes line.


Guillaume


