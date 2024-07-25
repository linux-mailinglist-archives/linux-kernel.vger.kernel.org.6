Return-Path: <linux-kernel+bounces-261725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDD093BB58
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 05:57:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB679285BB1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 03:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F07818040;
	Thu, 25 Jul 2024 03:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="blDgM++D"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3276F1758F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 03:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721879867; cv=none; b=YlrgsWQ4j8JAsBetIR+UGYjgg8y9pOv37ziUjJGm9AQ01HODayhLyut7KLTcttGcsE72q5GD2n7MXQkphF/a8QIzKe7vZdfActy+7GNXaDIvaWZ7vyNu8Ag70WP+beP7tjU0C1yItURuAtgKBC6TIfyS8IujYN7jxFWn2qhGPj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721879867; c=relaxed/simple;
	bh=NN4e54WWOq6B2fwdOa9t2GLdQ9mu9xRGv5LRRRGoah4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Od1DN5/LX+roRTN+JalG6NplaqqE8PraNS4BuAs7rarWOJwtsH+xEwsdHbyXMI6W8vRLytNU8NQhO41MkSLkV8XQWkk2ydL5pN44ZOYqX11km3nb93kzrIfFiUDzLuBmXMsj1Y1xKpvjHsu8rEUb0ZYG8s9YTITCTVROyGI9WkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=blDgM++D; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d316f0060so1102419b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 20:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721879865; x=1722484665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G8QkMrBrbmuVD73p937iEQe4M0teqnwqaVU5BNy4CB4=;
        b=blDgM++DWbF3iuG5pp1ZlWAVKvuPBc804izPxQVg0o1OzCEovx3MLQxD40RnWnab/7
         SThV2I2uQ/Kw0YH8WvndhDFpNB6xm0TMkWixLLVP/VoBR8OChYVk4jW0xyqLMGZONq72
         4PsNweOdKDXUyfEl1/L3s8dpsgyBklZAD1YE9HJ2uK4BDAxG24Q0SK7gaDRF+bkU3TpT
         c4iH0vIj5g0QGQZ1oLuEQiekbL/ZfV+4VGkX2uwKicdu2znUdTQLaQ5RTg6QQnha+mrh
         6h3xaK6ieoWpTvYZ0Q0xBFdvVBgTT7afjxmYfPYF5aI39oE5FAKzUfll0p32k92dypKZ
         pbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721879865; x=1722484665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G8QkMrBrbmuVD73p937iEQe4M0teqnwqaVU5BNy4CB4=;
        b=iW5gknWG37cMQGs+whGuHBDlULTmRm1Fe4TOItRbnIU5P2xBtqqs3Mxo48+AC5ranq
         vIbqEoNC9mtsYFKOw8r624hCt2xZ43mf01KAoO2XQFH+Ppt3jEG5WMdgWabCBleUeHI4
         3cR/7j5i5Ho05ZiLutt1HV4z8mept6IxYbo1EXhGMWB5BLE4takK5l6WxYdHWzjaAu3/
         9GqLyYGjaCYGwtzALfFbTJkUlyWEFtiv3gyqETELVcdIkKRqjf18eU8XCoV0AEhtxpAd
         yj+g6U+AX+U3hhGb8/FKYx8CiLv30FH9FJHYW0mu7Pgb79ytdlfSs1H+3Y/3LirTFteN
         Ne4w==
X-Forwarded-Encrypted: i=1; AJvYcCWn7oT3MTVtxiQnhF0eUCJI4ko8g4SWjCZ4sApHe8KHEGRCN0nlP44Org6QTt9V0575htxMSWsBaAhIHvYmR+pT3sM+eYlrml9PnsWX
X-Gm-Message-State: AOJu0Yxhmt3nwuHVF4zIv69DEymY2bQnIILodF53rLtNSekI8eIQO0wa
	2b4zyIdxKoiTLanOSCv1rWIkqBj4XDykZlx/qIh0DlTOEh4ohiHOXUOtCMLDBb4=
X-Google-Smtp-Source: AGHT+IExYR5muVg5KSgTwYkDqCJa2fGHiFlPUlDB/gzhVVAc/V1pCp8RlcapVTwTVUWrwDTMBAVQug==
X-Received: by 2002:a05:6a21:9996:b0:1c0:bd6c:aabc with SMTP id adf61e73a8af0-1c473ea67f1mr3214168637.7.1721879865357;
        Wed, 24 Jul 2024 20:57:45 -0700 (PDT)
Received: from localhost ([122.172.84.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f816af39sm281439a12.21.2024.07.24.20.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 20:57:44 -0700 (PDT)
Date: Thu, 25 Jul 2024 09:27:42 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Shreeya Patel <shreeya.patel@collabora.com>
Cc: rafael@kernel.org, shuah@kernel.org, linux-pm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: Re: [PATCH v2] kselftest: cpufreq: Add RTC wakeup alarm
Message-ID: <20240725035742.uahab5uf2kmv476g@vireshk-i7>
References: <20240715192634.19272-1-shreeya.patel@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240715192634.19272-1-shreeya.patel@collabora.com>

On 16-07-24, 00:56, Shreeya Patel wrote:
> Add RTC wakeup alarm for devices to resume after specific time interval.
> This improvement in the test will help in enabling this test
> in the CI systems and will eliminate the need of manual intervention
> for resuming back the devices after suspend/hibernation.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> ---
> 
> Changes in v2
>   - Use rtcwake utility instead of sysfs for setting up
> a RTC wakeup alarm
> 
>  tools/testing/selftests/cpufreq/cpufreq.sh | 15 +++++++++++++++
>  tools/testing/selftests/cpufreq/main.sh    | 13 ++++++++++++-
>  2 files changed, 27 insertions(+), 1 deletion(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

