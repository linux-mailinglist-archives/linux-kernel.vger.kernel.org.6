Return-Path: <linux-kernel+bounces-255901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8E8934667
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 04:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE914281060
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE6F273FD;
	Thu, 18 Jul 2024 02:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmVk3VPk"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A7B15C3;
	Thu, 18 Jul 2024 02:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721269660; cv=none; b=Dcvezj6Z4LFhsCILPX0CSfaF1FyHvcoby11yIa1DLPO+wjpK3Ul1QyK8XwRFMSkgcVpDj3Ahv/8Br9WOZdeXBuVH/qc5sILjW53qUK48nKOGIoPetisEha7C5XBSJm0msfuWONtqgUTgqk0te75yBACUWFI4zCe9OyV38RBsg6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721269660; c=relaxed/simple;
	bh=CV7LYfCxINP5w09KGhat3kkBY4Oo+VC8T93Z6UfqSUs=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hz8EdxeYEyVxRBemXBxAVym10tZilVqlBUZFv8ZucecoObV/paan1adwT5T9hRlVq1WFlte/W4cOXN18uyi56jHpVwnzwOgHfCDtyhbID0LeaLPIe8cFor5EgMTmJ+ExykpNI04L2ucQApT1sxzzweZeacaChpzkOCIzWSxWlSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YmVk3VPk; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2c9e37bdd6fso226097a91.3;
        Wed, 17 Jul 2024 19:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721269659; x=1721874459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GUAd6g54xeJRdV81nGL0g6LtQDcATLm06ClbA+KAow0=;
        b=YmVk3VPkhaShHuV6sYN0Wzq6WCzWirBMqsII8PJh6S36bLQjcXXbzRZJvCjEMbfOLU
         itLI66/eJnIV/oSxh4sIWBhduzBc0sHR3z1aMYAK93ylA2Cgm7UMsMCHLwBI/f75cNnf
         gyLN5KKHjNmHLKppQ/WqN7PGQOY0BTvgAzN8J7UgU9ViX8evC1Wxh8gP3Ynn+LjSiOk/
         IgAyMRXk0N7TD6FPwpem/CF33lRC854f7JLRvW7feyBYlV5Y2Ff+v1cOnavkscU3Bpgq
         GrUrxTUX8tQK0BSdyiJcDjeYeViU5UGX5sX7UxA1hXCDq0a8JZ78gszoViF78jGdB/ij
         MWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721269659; x=1721874459;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GUAd6g54xeJRdV81nGL0g6LtQDcATLm06ClbA+KAow0=;
        b=RZucKeurtWdjULt4i5uWs+Qle/b9bfqapjbpXed2s0pmNZZRjl1m6unKz6STbwFYla
         B2Cb7H3VjMu3LrfVGlmJfu5kT4BC4hePTGW8Bl0a7NsR0IOqtMXMOtIeNTdNxmPgGKJ6
         uLFUy0GEaPIMxVfAKt8YmA0pmS2iUD5raEpvW+6JmvwhgmPvyF5TXyWTCo9XjzLJQLk0
         XWgDbdsNe2R3P1VB26crnYcFsw1Cm5zl8BuVfCsSmxJTBy7+MyQeSZAyNnVSGTqCwasW
         +w//7awLTsvg2Qkp4XjFcj7eyHio3MsqF+ULwDCmu0zExv0U0V+j21V9h5Znu4tPcTrc
         gwmw==
X-Forwarded-Encrypted: i=1; AJvYcCXczA+r9wi3cj1wh/ReKsNWkeDzVzudGrRi7A6DL6vD7O3NzDq2quXtAJpRQsCeCCAMb3pwkcmEmvFBKR6ohWfeNbitpETevGiZGLp8NP6ebt8d+fw1Dubb3aZJ+OzyuqD+BcjZzK4=
X-Gm-Message-State: AOJu0YwG6LathwkXVrOmc1WxSQ5glJEOiRiS0fCkaKvs/0iaKBANdRRc
	OslIiJN/KW7q2GTppf11wJuOVCpXhv8lJgC8TuOqFQuQzG5xPTeVtAGZ2BNp
X-Google-Smtp-Source: AGHT+IE8SvX4CLDwAqE0jj8m+KCvYqhmkfATV+kF3+EHc9JlTZrnccUYA8tLj1CrFijiVCWM2kehCw==
X-Received: by 2002:a17:90a:fb8f:b0:2c8:1f30:4e04 with SMTP id 98e67ed59e1d1-2cb5293beb9mr3038183a91.36.1721269658624;
        Wed, 17 Jul 2024 19:27:38 -0700 (PDT)
Received: from [198.18.0.1] ([2401:d9c0:2902::c2eb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb601e42easm662877a91.40.2024.07.17.19.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 19:27:36 -0700 (PDT)
From: Cryolitia PukNgae <cryolitia@gmail.com>
X-Google-Original-From: Cryolitia PukNgae <Cryolitia@gmail.com>
Message-ID: <22807968-922a-460d-9dda-7e8f9b4791ad@gmail.com>
Date: Thu, 18 Jul 2024 10:27:28 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] hwmon: add GPD devices sensor driver
To: Krzysztof Kozlowski <krzk@kernel.org>, Jean Delvare <jdelvare@suse.com>,
 Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-doc@vger.kernel.org, Celeste Liu <CoelacanthusHex@gmail.com>,
 Yao Zi <ziyao@disroot.org>, =?UTF-8?Q?Marcin_Str=C4=85gowski?=
 <marcin@stragowski.com>
References: <20240717-gpd_fan-v3-0-8d7efb1263b7@gmail.com>
 <20240717-gpd_fan-v3-1-8d7efb1263b7@gmail.com>
 <14e3654e-27b1-41f7-a66f-03ec47e95593@kernel.org>
Content-Language: en-US
In-Reply-To: <14e3654e-27b1-41f7-a66f-03ec47e95593@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2024/7/17 15:11, Krzysztof Kozlowski wrote:
> This entire driver still does not look like using Linux coding style.

I carefully read the code style again and adjusted my code.

I apologize for my rookie recklessness and sincerely thank you for your 
patience.

v4 sent: 
https://lore.kernel.org/all/20240718-gpd_fan-v4-1-116e5431a9fe@gmail.com/


