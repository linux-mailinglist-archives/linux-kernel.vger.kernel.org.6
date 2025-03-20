Return-Path: <linux-kernel+bounces-570361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B00A6AF5C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 21:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7E818984F1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B4B22A4ED;
	Thu, 20 Mar 2025 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o2GWLK/0"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84FF22A1EF
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742503678; cv=none; b=FlOhm74pBmFLzGSYH4g0/4oROKgD9fCQWtU/pW8avnOX6esZ2flA1C9CA4A/r0rmD0cKAIGx1dbZ9ec9xrt2SuNnQggkYXfPGn0DJY3Nm5Kg0oMaWQqFNWjD0PWn2rHkxUcrIHWx4MsG1LEi60yro0835DjhW+UQ0RnaO1wWR7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742503678; c=relaxed/simple;
	bh=akoUxBA1ighux8JnAPCyxwHFsZb1eSOKkYyJaXVZOXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MV58fwHrZ/zFbBLKbdq6Mf2GICuC2JB4aoCfUj8Il/DjKk4YMl9v4dG0xT+FLt6Pr7+lvJ7cNjSZ20QfqiJtmc+3DoOs76L7jOBlADP8vvXyv3ZfgFO8cZSeZ60In+typnEMhYDvj3eUuyFhFsMULCNutlsBE+mtVqdFDfFn14I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=o2GWLK/0; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2a88c7fabdeso791428fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742503674; x=1743108474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FoUUte5ljdke831I8NU54sFFz01ai2RoggYX+/lHrQo=;
        b=o2GWLK/0sLKSttky6n4Lb0jVfgW93gv7yebzrhiM46GyPTd971+MJaaBFJJNeo2Jd0
         EOfnfsWoRl1A0u82xZZyqhasrPKwbI6xa6K9qvDkOjrbbcKdEP96z2jV3+DA4oA2xFty
         MkbOohVAPkUFs7ydzuiAl11pwsW+q+4NvEQ9fDyKhkIAOqru7gr8AyYRMiuuNaBv4Dlc
         Vd8h2wiKo5Gfnn3BnOcxNu5UVNbN03vJkWKj5vcLYwe5PV7ayamcGpz75bq8te5cuN7R
         ZLcZU2w/E9pVBaDPwQAuRmezGmpUcuqyyZ1lNEtytLIlT33j/LZ0umgXNQQPONASRwz7
         Ycgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742503674; x=1743108474;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FoUUte5ljdke831I8NU54sFFz01ai2RoggYX+/lHrQo=;
        b=l21qrsoUkhx6mVQ3Krb3KOjctB6A7/+sux8g2jdbI4slgsY8aJnYm0cPCw9U8fC9Cp
         3i4nyMrgATzwB2X81QQfZUQh42dYg2AFEuWFUI3dlVkdb94H7nIjMZ3+p8SvJ8uW+0R7
         5b4YeakOUsekJaz65zKnutRqiXb3nplYWwg7q5vjPRU2vhGoTb0ooslvj1xiRklUPslv
         Mhk5hMuDyjgCTJX3BcG54u3tj2sK1TMPSrhouGRgmEkX+nQFUNQqBComZyM3lN7WRcPE
         0/iAMLor9sw1W7bjsNHSoyFjpTvQbrS11VANz8yVZBPIV6/ppUwkYDM1jRd8LkUUnx6V
         TRsA==
X-Forwarded-Encrypted: i=1; AJvYcCWdWRUDetQYObla0+Dbxsibqkh8oPsZ6UjBSJg7zwFYc1wrZJRzO920+rqEp+FkUSDCAJ8RAd2IwUVzETg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyGNAw9A5LdslXwqe43l6mBSO0lZY4UOXoGHsmzHTX8fvsbCMg
	U4rbZ6gsj9VWzLX4vrg9hg/uH9d0rx3LfglShmmnlijUhgi97mRVpw76KPC4Rug=
X-Gm-Gg: ASbGnctkPpgJjvRLaMoDjbCbbqGSVXWIdj8DvQU4ttiGfFFf8/gHysw0ogRPhbNFhT3
	k6QaRhUwWIa9XBHgX7ooDSTwVwpyIka9ACN/VaAB+Hy2zj9yhrOgSSihnWODaK+X4wy0txO8GaX
	huiMwoGAuQqTEVpkJIudw8I5JHeJBODLR9n4DbC6ueQqIf+WyjNF3ooGWSwJ70wDjVuRzsX94oR
	qEy2meEEy7wZEnjbFac6Fx9qKqaW7JFKhwKk298wf/J+Sv3cwepxhwPN+P3wXoEYMmOAg7edTl9
	gHbu1dpXUoTIQam+cJmSzmWBRaxjUZQw2mr2xy2jALovyVo23h6AM0kY89GSH1bDeUjW+NqBlL9
	kaslhjw==
X-Google-Smtp-Source: AGHT+IEThj26dBTP4Z2xXCcKfq3Tre3BUTf1MdLUxFhzND7kG9B2/mI5ooNOAggoJaMyQPPsgC+yqQ==
X-Received: by 2002:a05:6870:f70f:b0:2c1:4d78:57b8 with SMTP id 586e51a60fabf-2c78043942fmr646118fac.28.1742503673607;
        Thu, 20 Mar 2025 13:47:53 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f05ec85sm132955fac.32.2025.03.20.13.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 13:47:53 -0700 (PDT)
Message-ID: <1b544061-4b5c-4a69-98c3-265f9d1e32ec@baylibre.com>
Date: Thu, 20 Mar 2025 15:47:52 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] Documentation: iio: ad4000: Add new supported
 parts
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1742394806.git.marcelo.schmitt@analog.com>
 <4ad6c3d6dbfac9d5e9321a23a647cf333d7f96b6.1742394806.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <4ad6c3d6dbfac9d5e9321a23a647cf333d7f96b6.1742394806.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 9:57 AM, Marcelo Schmitt wrote:
> Commit <c3948d090080> ("iio: adc: ad4000: Add support for PulSAR devices"),
> extended the ad4000 driver supports many single-channel PulSAR devices.
> 
> Update IIO ad4000 documentation with the extra list of supported devices.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Reviewed-by: David Lechner <dlechner@baylibre.com>


