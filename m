Return-Path: <linux-kernel+bounces-561215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B539A60EE4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C8B17010F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343A21F2BA1;
	Fri, 14 Mar 2025 10:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ugRG7j+5"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80901581F1
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741948283; cv=none; b=ajM7kTaC21wS0CCfKTQZIy98vl4vANZkOkDulfMXAllI3Rt9vZ0Dc4xAFeCWreEkYAaZBUUkjkaeKSYVlLzgx+blccqCUtH5R9wAe0+4SHeB4JTy3YAfdisTC/kPP7NYDG1B0+BaDv/FIdOZOopR/Hq0G1ya+7UAn4i5rrguNPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741948283; c=relaxed/simple;
	bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GW3QRkoZDrEAFAEww0eEQZ+1nhgakPi0hUZ59yDUfHbx4dxmf9mDP1iz6wKbQSx8zRI0V4qMNYzBG/H0ycEtbP3qxe5ANwXfvJvhXSWkk3AhEbP1jIS3/e39tYophhnIX/LaHbMPui1U9Mv3LkfTTfhO3hSXGghkcWVeB58jg/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ugRG7j+5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cf06eabdaso18232005e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741948280; x=1742553080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=ugRG7j+5b96XhyIQq7zctZzyUeJ8Gr9xm+/kCamNifzo9osp0FhFt+gmjk1snVCDSa
         UEdqPBWqZJMpGdyxnRoMPSzMpMdh/8Mn9YHzrfnBcXkiTJqQA5RM8uTDE4gMpnIyGGXS
         kkFT8NMSrGt8+jQi3AjKu63KUWcnNjd4xs8ffFDyplArHYAEUJyknMhjJs5TzljWJ0eV
         iAbnfD0s6YvVGmYfiBPdJLB5BXu1tC5ab0EjTbAeMiFJrO2fIUbsMtxk4m+ybjohNM+H
         oQwlMM7KOyBBjlvddDSz6nUWbMJI2uZHLfSsmrx5BNnGJk7U7NKl/FDft7/U5v7hceHK
         ai3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741948280; x=1742553080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yyfk8X7hQAsUD9G+4fe4CzUE4boCyIRsCV8/4Z21Gnc=;
        b=Qr4B/bG2maeLweIAK1+F/9/t/ErJ1FEYkgTEg2qoLHmQTwvTXHQ72TWfqRfxr0UbuG
         Xtojn3DfswpEMj8BKS00s/yASV+8ZpRqKqb0W2P0/dN6i9UYgZEzsbfjPDtNeizhont3
         08aDBN2CDPrXUa2YiJfn88lTteAF23NhdPxMwFLHaYUFOY6FkkO3fXzLO+jRwKvMIdd7
         PC3p+iGCXLj/VLH74FzTLIRdxQwxkHu5Btzit0fRGhaAJilbzFe4TD6Sul8d8NoICW7Z
         P19kK6m436/7/qqhOyhNPWGNjic8RK3h+ws+8Cz8Cibyy9DRm6DA90iaKXEXIEitak77
         HzKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfD9XLI3q2wZBwTQx/2+yEf8a6Wz0IAueZ0tQm4reteIZLYXkvc8ZLY5edjehQ2ttxa9cBMmw1aB0Kc30=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUt0T1O/jeQvzOrOF3eAhTiAMIiUZLrfVNvpAbCgEb3vdttnQJ
	32plG7V5mxczuLAehGnmwvXcJosJ+GEQovxb1C6KOqyBd0SS7lj7AdrYicVIdnU=
X-Gm-Gg: ASbGncu+mrU1mpwspluUFASr69lApgyG3Fw+AZACRqdJLyz6ZN80PZSbo2o7keRONgW
	YqD3rhbuBBEd+7gGXatYEFKKLQjqUTa6FXX4wWRMqWpa5KzIM3WDiu/rDQPS1RaYyoTEAafimSG
	G6hp7PWmTTiS2Bdr3RACoTrMPYkUGvPobUiS7+D4uWFDB6F7HuWirlc0pcDcU0qaXSZ3etOfcar
	UKWQmTLutbE3FYlNV+BqB2aKvS3yB9qBIukAz1KfWMSrPbUDsD0gQ914p69zTNH86CWRDyO1XMb
	uIr4qOUTPSsvDkALx7OrEfgT2mgOPDAC/Cj30+Opsnidq+9chQpLdA==
X-Google-Smtp-Source: AGHT+IHLxgSnBZcseOLOPQyS2epU0s8c7uzffYTWTiPGztxQVaBwu3fBYij2zWFBMDtyUoWPqCYOHA==
X-Received: by 2002:a05:6000:1f82:b0:391:11b:c7e9 with SMTP id ffacd0b85a97d-3971ee43e56mr1935297f8f.28.1741948280252;
        Fri, 14 Mar 2025 03:31:20 -0700 (PDT)
Received: from [192.168.0.14] ([79.115.63.206])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb7eb9ccsm5169603f8f.96.2025.03.14.03.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Mar 2025 03:31:19 -0700 (PDT)
Message-ID: <73d9a5ab-0fd0-4a8a-80f0-b43c4bf45e4a@linaro.org>
Date: Fri, 14 Mar 2025 10:31:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] spi: sg2044-nor: fix signedness bug in
 sg2044_spifmc_write()
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Longbin Li <looong.bin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <4e16e1bf-e5fb-4771-bc92-c5cba9aac473@stanley.mountain>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <4e16e1bf-e5fb-4771-bc92-c5cba9aac473@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

