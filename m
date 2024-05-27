Return-Path: <linux-kernel+bounces-190574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B80D8CFFF1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 14:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4091C21507
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 12:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542E415DBCE;
	Mon, 27 May 2024 12:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zVM0rHud"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F6F3C463
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812647; cv=none; b=HxlImQrSyOEW786BocPffrDQejq8AbjXgvYUn5A1K1K4+Ff3+RQXkBqtihBlIXqcb28ImjLE4tKroxP96vEP5WqmuNO6EVccbqFoCdK/UOd4slBQcwxnb552PtnW1u7fFXaEQ35XLcPXtRBBYPRUc0lzFgK5+44WwejTy+/8Mdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812647; c=relaxed/simple;
	bh=u4pNQndhTwzjvZeCbvNzFIGllGB6K3HszRuUI2KOTno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Prm9UrZuzrZM3NgYkfLIr1jt1+9f6Gf9OaGmK/29xxaHcPgmEjnBdBK23jywxmdEanHk46haYFdpXO4UezgILHXrYe9oF6PNdYYj0ehvANozwF+4CGHKkkUB/o8RdVWYmXutRMczRyMIHkCbEqr5T1MD8iRTV2h+pnf4fiqQL7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zVM0rHud; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5786988ae9bso2543284a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 05:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716812644; x=1717417444; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kvByR1DQ2F9g5kyajsGPK2dl35siqeWB3JPTIt3yItE=;
        b=zVM0rHudB34o7ySW45Ii9I2XxjnADnmUel7RmSG1itp99BEBcP5zWvU+mI7enWC+M0
         2V2+IwGBOXUafWS4BhxsQritmUWiZ+1qNksWtivxJa/QddEPOp42Z3ZskHPmGj6wV8VC
         nZpelsWyi4IX/zh9SvHWhVacZ0yIseao6S+zqjILCVSu2wUQI6oyaQr5gfkgBvl1FhUA
         4f3DhnSvZK6F9ZCCkcdNY6g9oF/Pz2nPbRt1w0jZoEbHKnFjEDkxPgXjI4HDvmfENorJ
         985kSb51usfMVOMg1hg5N8WgE5aaleISNQrjrEdqaQLnDKu4sfNkYXuoYNzyvfKRKAcF
         GOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716812644; x=1717417444;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kvByR1DQ2F9g5kyajsGPK2dl35siqeWB3JPTIt3yItE=;
        b=W2VJQVeiQBXQZHfSfw1XAMD8p6MCFYWfxeG7h5QOwneCa+JBbXrtsJGNj8K4KoAYRb
         RuvTPYcIIimEygLXF+0bMnWH29ikN5s43AJRC+7biM1w+ckIKCE1NJOXak9O6A4Vst4P
         E3EM8w2qeWQ58wPVQdTW8u/IRfVW+xgf9H9NH7ii2X/dwzcNTOG0RCCxKSNbLFnGYDTK
         p0f7oJXrxHpPUB0zs9CVuDljIoMyutHVQVDUzf+00z0x/l4fxM3SeUPS62+VhlcLx4pO
         D3A+qrP1AxDMMmPc9ZY6GSezqHF/cn/Dux479iwfQN31eUqvFO1R2aaLrdoj76q3rBSM
         zyqg==
X-Forwarded-Encrypted: i=1; AJvYcCVHLegogeRb4wUxWJBpR8pgUZ/LNAUxCPZQxr+9NTGslRIq2gyqNdMrJuiOxjG1LoB+oNMJyF54giLT3k/QrywZRZQGjdrOCLTCKDOL
X-Gm-Message-State: AOJu0YwTNdExu2S9zrS5V4cHowa/zY2KBTgprZOdKz1Zr4Ms/pEywF/R
	GulrU2YbxBsNNsPnSgzvQWIaFuBUWyt1NJPKERCqkfqg/YkhW4nICn9yjL4wowI=
X-Google-Smtp-Source: AGHT+IHJXyIPVfQ3VM4Dz+dObdkePRCK0LaLG+DImc2OW2iQv0GkTNfNw3rFNPePQO/ok4Rkh6u9fA==
X-Received: by 2002:a50:8751:0:b0:578:6159:8976 with SMTP id 4fb4d7f45d1cf-57861598a76mr5909962a12.28.1716812643725;
        Mon, 27 May 2024 05:24:03 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.152.134])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578638009b1sm4178095a12.17.2024.05.27.05.24.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 May 2024 05:24:03 -0700 (PDT)
Message-ID: <9d93682c-5da4-43d2-a9fb-f05d3596e066@linaro.org>
Date: Mon, 27 May 2024 14:24:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] clocksource: mips-gic-timer: Correct sched_clock
 width
To: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Serge Semin <fancer.lancer@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240511-mips-clks-v1-0-ddb4a10ee9f9@flygoat.com>
 <20240511-mips-clks-v1-7-ddb4a10ee9f9@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240511-mips-clks-v1-7-ddb4a10ee9f9@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/5/24 18:00, Jiaxun Yang wrote:
> Counter width of GIC is configurable and can be read from a
> register.
> 
> Use width value from the register for sched_clock.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   drivers/clocksource/mips-gic-timer.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


