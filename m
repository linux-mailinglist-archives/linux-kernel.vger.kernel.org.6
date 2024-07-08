Return-Path: <linux-kernel+bounces-244164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C0592A017
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A4771F2288D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 10:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28A577113;
	Mon,  8 Jul 2024 10:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="voTcisUh"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7C97406F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720434242; cv=none; b=M7wldM7Z26vC4nBNCr2jk+64+H1z6oEDD1RSbL+1nnqTBQE6xdzh0Q9v3rElQbK+qJyWt919DLu6iHsul5gytlRmzQNSIc2wti+ReRzdFbtGebsNEpuyRwp7ZUVuO2ViEjLO7Ym/JVQsbD8aLvKZK5FHB7FjlxSVBZJxPaAuiHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720434242; c=relaxed/simple;
	bh=SmSR9+Zy5h+7+91csxjnolavjIEWaulnUtgKd7wHjBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ke4+bxCDw+z2LDTCxejnUgn1dTuTA+UQLGbwKNowqkv11aXDcv57TcCWFL867eKN210Spth+UeT+fOqEU/Gyb+uNGeFjqy7cs89nQGAVBku4nBSB4zJYQPcWOC0ee/+v6nMBXReryE2evG3cVemm0x5aefRco91m57uoLhZZtZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=voTcisUh; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ebe40673d8so49939181fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 03:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720434237; x=1721039037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SdHyc3E9lDPINEIoBlnhtvfdKjc0jZ+mb9i/W3sps1Y=;
        b=voTcisUhgwers2jzBYpNlrDV0MozMtxd2gnT1RtnCHLhNX6JKmN5vOgc+JudQmugZI
         sPkcfQyNcxZ/YM3qVtt47uqUbkkg2zyxeRb36YiCfJsle0G6YWCQClnoY5KzNTCd9m7O
         yXkDTUpBETX4cigabAHbj3QFh6lwq7fDpwA29J1qdm6tG5a+MjcjS5MliAFqKTjrmjJd
         IZAZBbxUdawQ9rwh5NOoTSEkseALXSQWiwlmHn7dJD2sjzh3KOZYciVh/Iy3JtOinEfF
         DfJko7C+AERH24qUDIdMBDqWueCuEP0fqPbK6cSxpFSZr+GpjyuSlKUuAq52gXJxUWFw
         egjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720434237; x=1721039037;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdHyc3E9lDPINEIoBlnhtvfdKjc0jZ+mb9i/W3sps1Y=;
        b=xI29VgWwQKVJq0w2/EwP7oQbHTPpRs8fH3AaE0pxJLnk3eRteAqdh7w9as2LYOWVvg
         aY4b4CFqXoTUZZT2qo8G4RKh17x3A2kQj44YLBddQCCDQwgUND5C52qHWIzxLjIwfTV9
         jW8u2C/L3vcs4VZC5bSigP5OOQyyftn0MFCjcgMGg9rcIKAHrD5PSboA9psh1PgF2pN0
         zgmvgVQbjWueCc2Lsjrdg1lA6hBM2/yBI+nyOtjQVwaUL8ADQmZXvk4nf0UQveuW9uVJ
         LwDzGseI2Pjd0mljah7XOKfAr/A73KXzwEFwVNNkFqAuAt/24gehnfZtTXJmCFJbrWgr
         hhSA==
X-Gm-Message-State: AOJu0YzL0gdBcYPutyoxpt/V7FrwdlgT0V6gEW6yASN2Y9b9t/LVo/tc
	BMn0dGBpPD5340taLFNXhtUOG5Ah8oY5kkdMEzyrp44PA/4zucMoHyg6Gn5koo0=
X-Google-Smtp-Source: AGHT+IGtGJ2uxprR9XwTilWfavRjiJbPES5/C+lYbwqGMTXjQPenf6skImCxag9NiDg4gG3mANhDtQ==
X-Received: by 2002:a05:651c:1071:b0:2ee:8698:10e8 with SMTP id 38308e7fff4ca-2ee8ed5ed71mr68114851fa.20.1720434237238;
        Mon, 08 Jul 2024 03:23:57 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0? ([2a05:6e02:1041:c10:c49e:e1a5:3210:b8c0])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4264a1f22acsm159963515e9.24.2024.07.08.03.23.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 03:23:56 -0700 (PDT)
Message-ID: <4069f1b9-658e-4b18-8219-b575903b627b@linaro.org>
Date: Mon, 8 Jul 2024 12:23:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] thermal: core: Change passive_delay and
 polling_delay data type
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <2746673.mvXUDI8C0e@rjwysocki.net>
 <5803791.DvuYhMxLoT@rjwysocki.net>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <5803791.DvuYhMxLoT@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 05/07/2024 21:44, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is better to use unsigned int as the data type for the passive_delay
> and polling_delay arguments of thermal_zone_device_register_with_trips()
> because they are implicitly cast to unsigned int anyway in
> thermal_set_delay_jiffies() and if they happen to be negative at that
> point, the resulting behavior may not be as desired.
> 
> Update the thermal_zone_device_register_with_trips() definition
> accordingly.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


