Return-Path: <linux-kernel+bounces-569786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A2AA6A76F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 14:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F124802F8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 13:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F154A2222D9;
	Thu, 20 Mar 2025 13:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PR29wAG8"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58CFD221726
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742478112; cv=none; b=OmhNlrM9LGoZzs0iz2b4qdn8sdKlf4ct2qFQ+7Q7uu4Cq2qP0+gMrB9UQgh6YXGPqmkl5K//lRRBY0Vvh+/bqY76DCvwbN+s64P09E8grOgFZ5n+jsYwNM5Mg8KZKitk/5XjY8xXyvdZ1TTM2czfcOJ7cEwQgcJyWOYBD/qokcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742478112; c=relaxed/simple;
	bh=TAVawPDkGxLL74ihIlfzBahEtpEWWC/hEQDYBJRsftc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hhh+Ym4CWghDAW3AVMQz8XqQOPeYo2+1idRfq0vug2HE5gMP4vTmXvkYskokKcyPy5kbuP0XdYRj2sk96tSGAXNa3HsQgBWeptBTyZ1CurtSwYjKCAwyhIekf2CjvdFbueRrbas1ooqlfK7bcICgZLWMk+585Bm8sIMsj1t99h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PR29wAG8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394a823036so8033125e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742478107; x=1743082907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jSXa0ucjx2iw9Nq/f9zLmD2fUqwx8MG/5t679bVcACA=;
        b=PR29wAG8WWSN0yyq4Hft/fw9xhrHOvfs9BBzKDkvQikcoTOu4lqyWenLav54hKjhTq
         QnVzAU/OEPsA85d0OaH7zoYiGRpCPRh/2o0fy+/1bnjQdyE+m383AQU42nWUx+WsFmnm
         RDUYu29HxlpmmCamw1UWR0qUeXOiOHSSCjgcgsR9wtQQRKcfUsAGh8+4O3iRvTmkO6mv
         /2aZfcvU2Ylgm+SZYJmw88SWIpHcz2bzP2Zczv+IWC0ngEjY88itUjpAsG1IT7v7jqLe
         WIMNZxwYjcW0cLrrfiHITcqPMJCvvK/McgN6saZbhpKVJEr388nHLeFH37Y8odEANKj7
         rewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742478107; x=1743082907;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSXa0ucjx2iw9Nq/f9zLmD2fUqwx8MG/5t679bVcACA=;
        b=eFw7KMJTdZJC5nz+bOtIodSpa0q2oOQNXNgFE/+be/gPnT8C3jHnXXqtR4ICiM09fb
         uzo6RiIfa1uy5ixAoIXqZGgA1ywz8vc4n1ke156HR03z21YIuc11G17Olu4FvJiQeHr2
         Z57GXKYplwqdeOqE8wclNsJOtDHiuCUT/GuZW1/Ky8CFKsASXq0CW/CKGjYtSrqB56df
         HsrXHPtCKj2rjOhb7FY7Zu9eDAUxMLVYbSscIvM30wP2M2od4C6DEZuJfZrhhP6bgxGb
         Dj6EtiZbZ7+3rLlcAijExDhV91+vbcKJFElRrRMPlq2jAMTywDON1r8IybMIXbd7Jwyc
         Bxtg==
X-Forwarded-Encrypted: i=1; AJvYcCWJDZg2PZtL+SALvyL5np25C8JsxGhxM85oXKcffbHVUnBJlXlVu+IFbO2fp1epQWbECuq12ZBUAWmuFgk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoPOJMql+y0wK5ybT/6Y3ThqkjQIbBTmD6wW0gH9JS99rXmoxT
	LQQlnpCnsRG7PfHiI/vJOOZQiLy/nuwINa8VN2iP0gHe3TkWOeSMeMXGPziexQs=
X-Gm-Gg: ASbGncvjfK5/1o8nthl2YK5cFq1Khj2dRV+x4Jhk4grq9KMFxWUoBnlI7IwZ8PLJs2l
	wnxD7vzp2qboTKNtw4zEomZGOsK1eyxngdL3YLkSXh0zIzuhTbOz5ssVwOqFFs20nfYlq9Z7RM8
	DU47ioJjBAyhMzRyP8AQLa5HrsLHHNoOS/2FPuUGBRAqGyjS46U5o0viOgGZGtlpLPm9rBQar/h
	lMZNeVS3B2zt9xsDpUqdTSVWOEGa45uQabn8cSdz3kRBevwBi3tbT0mrgiBrlZrPdGkX/4WN/AQ
	LlxvyehFLaKDs8nvlRy8za+cZFM0JW3WCMREmb/hBksGzZeq2uCZr3iVa7fI+LUIrJiazPmtvl9
	u2d64coBye0M=
X-Google-Smtp-Source: AGHT+IHB8Jpq/dv/MF5Xpnl20lVwYehCBg2fUw2R2WxrWPUwJTYa2KVgSsV+p6JoZMdI4aYop1tDlQ==
X-Received: by 2002:a05:600c:470b:b0:43d:fa:1f9a with SMTP id 5b1f17b1804b1-43d438abb10mr66472345e9.30.1742478107437;
        Thu, 20 Mar 2025 06:41:47 -0700 (PDT)
Received: from [10.1.5.55] (88-127-129-70.subs.proxad.net. [88.127.129.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f8679bsm50112995e9.40.2025.03.20.06.41.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 06:41:47 -0700 (PDT)
Message-ID: <818de9a7-b308-4e00-9eba-3f58e1d89bbd@baylibre.com>
Date: Thu, 20 Mar 2025 14:41:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] firmware: config: ti-sci: Default set to ARCH_K3 for
 the ti sci driver
To: Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
 Tero Kristo <kristo@kernel.org>
Cc: Andrew Davis <afd@ti.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250220-ti-firmware-v2-1-ff26883c6ce9@baylibre.com>
 <c506a805-9221-4afe-8d98-af0ca97a1fd2@app.fastmail.com>
Content-Language: en-US
From: Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <c506a805-9221-4afe-8d98-af0ca97a1fd2@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 19/03/2025 à 22:45, Arnd Bergmann a écrit :
> On Thu, Feb 20, 2025, at 14:31, Guillaume La Roque wrote:
>> With ARCH_K3=y we cannot enable TI_SCI_PROTOCOL=m because
>> ARCH_K3 selects TI_SCI_PROTOCOL.
>>
>> Modify the logic to enable TI_SCI_PROTOCOL by default when ARCH_K3=y
>> allowing us to submit a future patch to remove select on ARCH_K3 without
>> breaking existing users.
>>
>> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
>> ---
>> Link to comment done on last serie [1] we come back on first version of
>> series[2] to not use imply but set deps on ARCH_K3 in driver directly.
>> An other patch will be sent to update Kconfig.platform when this patch
>> is merged.
> I just merged the patch and hadn't seen the earlier discussion,
> just two small notes from me:
>
> - thanks for doing it this way instead of the backwards 'imply'
> - there is really no need to split it into two steps, since the
>    change to the Kconfig.platforms file logically goes with this
>    one and I would merge both through the SoC tree, having it
>    as a single patch would make sense.
>
>          Arnd

Hi,

thanks for merged.

i do what we ask me in review in fact or perhaps i misunderstand sorry 
for that.

Guillaume


