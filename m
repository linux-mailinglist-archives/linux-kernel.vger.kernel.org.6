Return-Path: <linux-kernel+bounces-565045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D6BA65FCE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B14188B39C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 20:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813291FECB6;
	Mon, 17 Mar 2025 20:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uzLcOO2P"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372DA1FAC5E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 20:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245006; cv=none; b=WxF7j76JZGGpHLN/Ki2JMRlj/z+tw3ls05It0vzCuHLg/BW1libcyYqeksxc91IxZPo3XzmBttbdQEuYDpUwWWHNvbq8dYIy1mn7WxVuF6azEyRToiUn0l7fikPJnMJYOvRF/IpsALbJjaSWFhRYoyi20vn4/4121hF3VALrK7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245006; c=relaxed/simple;
	bh=81zBDcNSTguoXj9MOJ1/PFN5nLQAASCySc3Mh2z+s74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KczFxolW2bz1XdeSFO9VYFBI8u28Am/WktzLHkt3R8QovSVQ33bgvgkfK94OWhDSyENeHbohon29X5BHMVU+LnSdhFA1hsvrcoznS3Lae0AdjUfoU6LlefPx3BsB4tH9zzQcq92y+3r72vmTwa3JxgmJRyV4d6SoTa60esgmn7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uzLcOO2P; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab7430e27b2so935870366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742245003; x=1742849803; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BstLVAtzfOCDqp+GhsAWxESvpLO5VswkpR8jzgDHtmM=;
        b=uzLcOO2PWzFpBucLzqkKFaFSshXo8t3b4oo4pRs+AagfY9cs9t7sgthLLbR+9yCyst
         zeG4ffRWifH9sAcg0fPE4pzBTWU/we0J1ss/AztOGCbBec+ERAXX3X2dJcLL/rum3e+h
         EpeuT3eRc5d4bbZGjlTYN/WaYZI/zRn2XTECG4tR7RV7Uvar/dllWtgqRVjT8lJlG3pc
         iERRfUZnlWyA4dAmxC86q+qG10/PJ2K2uFCP/jpzhrPoccDTY9JxUey2FnSDZ2suM04C
         tRHBNW3YeYY3znzBr8LGhHwIKwlv3yqCdbDktaBD6fq1cJ0L/1y+tTzBxkW6cJYySobK
         Qnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742245003; x=1742849803;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BstLVAtzfOCDqp+GhsAWxESvpLO5VswkpR8jzgDHtmM=;
        b=qXNxX9VhRVPepz89mDRbA8L0kXZaSPXjEJK1Rp5heIyX2hB94WNJuq8fFfGDpu5STG
         sOWgCBFV4cctBfZ3AeLBm4VUCcxqM6a6RNzPtZlI2RTjZovKdmPa7plsuMJECR4lXUJC
         INm6lrPd3kEX+glaAuooHCzHSqoZkLbRCnQ5TSku3BwHJBbCJeTl6trjwZ6/h21f4jDB
         yLJPBH257O1uihhjDC/zYRNc7jcLV1ok3MUwt4KhFCDInW8Dg60KshkOIMiOFBekQDmg
         2ou1hSEl/7SUs8zC3c2jUJpgAbdZIrgiJdYOSTBKdWqSBPRdFnTaESedKJikUpSnxYCg
         ngxw==
X-Forwarded-Encrypted: i=1; AJvYcCXor1U4XHDUi8J3zouAvKEH8ThH4ymMyU1I+IaspRWxWMPm0U/bPUx1NkZv4QeG6uUTAPbySozDw6YZI0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmoJpIYqptT0tsz2YFAn8vsWzGXd42VznnUUcVBK3D861bq+EH
	MuuaUzNyQYn7KhjgToY/QoPLpP0UpYLKOQt6HERXZ75XSn0vr06SrW0MDwLmTyQ=
X-Gm-Gg: ASbGncstamxgUvufC06GfRAHpsaHXMId6IKarbISTywTWQOsvXMgLmL35ZKg0eRATjo
	jUla581ZY5Jb1LFyAWS3q40LG7GWTtaVz9woO/2PxXqiHIWqRauELRLCrbo/SiOHYcCiG4LUsxf
	ftFkxk7WXZd2KLgjAJyESiOQfJEah+hofn+BUqgHyCHt7Jvr9sRWfpoSGLT+BkHfXxGVg9/MNwf
	SYGlVbrDPUKxyudWCzxC5dNy8qzq8Kw6EfZdsaVeOtLNxcPKypsipOtJYKu55eYSOuhLm7G9jPc
	c3l9kNRuEXLzm4vfqiJtrKx8O6N2lU4yJ76bkg2KV4RhApfJ/c8twE/Lq71q0ER25nIt4VOWnhi
	64h0z2r8WP0U2IC2YAN2Unr7FnZaM6D/41oXXHACohAfMZMlUfrWTas8bCC8oZ4WNEYEHC6E5Vy
	+/xSnpv00VHg91MKwZVQwz0ywrYYT4RsA=
X-Google-Smtp-Source: AGHT+IFKWe2DZ5nF9okyCT//0zSoiElFf1qyr0Z5z8k5hDUvEjT4K7BHpoBvcuOjJECmwN34SwR+WQ==
X-Received: by 2002:a17:907:9604:b0:aa6:b63a:4521 with SMTP id a640c23a62f3a-ac38d40101cmr109581166b.15.1742245003482;
        Mon, 17 Mar 2025 13:56:43 -0700 (PDT)
Received: from ?IPV6:2001:1c06:2302:5600:7555:cca3:bbc4:648b? (2001-1c06-2302-5600-7555-cca3-bbc4-648b.cable.dynamic.v6.ziggo.nl. [2001:1c06:2302:5600:7555:cca3:bbc4:648b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149cec1esm721968966b.114.2025.03.17.13.56.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 13:56:42 -0700 (PDT)
Message-ID: <4ac65d97-e494-4047-ab72-e1da09d057ca@linaro.org>
Date: Mon, 17 Mar 2025 20:56:40 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/8] RFT/RFC: Import IPU6 ov02e10 sensor driver and enable
 OF usage of it
To: Alan Stern <stern@rowland.harvard.edu>,
 Hans de Goede <hdegoede@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jingjing Xiong <jingjing.xiong@intel.com>, Hao Yao <hao.yao@intel.com>,
 Jim Lai <jim.lai@intel.com>, You-Sheng Yang <vicamo.yang@canonical.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20250317-b4-media-comitters-next-25-03-13-ov02e10-v1-0-bd924634b889@linaro.org>
 <89af0891-3bbe-4964-8d19-205cdab79497@redhat.com>
 <685ef286-0694-44c6-85c2-c6c5f51ce6a4@rowland.harvard.edu>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <685ef286-0694-44c6-85c2-c6c5f51ce6a4@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/03/2025 17:33, Alan Stern wrote:
> After installing all the patches except for 3/8 (and adjusting some of
> the later ones to account for its lack), I can confirm that the camera
> on my laptop still works.
> 
> Is there any particular aspect you want me to test or is basic
> functionality good enough?
> 
> Alan

No not really thank you, just a smoke test to make sure nothing broke.

---
bod

