Return-Path: <linux-kernel+bounces-207848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72218901CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 149EDB2355F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4736F304;
	Mon, 10 Jun 2024 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SM/Gm++v"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3173BBC5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 08:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718008236; cv=none; b=BPKp5X6v6kuSNc7z6aoFXFsMr6timdZtgUj5QoqdAztY9+bPkAt5O73U1YpQAXqaxlx1NcoW1OAXTSYaA5MmXrn32j15DW1W7+U0qSyG0oj5vNIe4CQuqNXehYO0R4W2ejk7hf5QEV5mRZNRBjUzzD442sJ64XSK6krYwdFeAfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718008236; c=relaxed/simple;
	bh=EnoWGYl97+j7vCHrv1rQF/RSu9FWTMYFGZnWNoVOV0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k5T/ifcYfeRQQZRVXR8hHgihqBJiPwBfqQFxE9r9wWMMCYAEKaKoWJA1LkXc2D6X8icNeVJ8PDaeIzsyln9PIfebJ4cz3WhDm/KhbIr9ieL2WhUvCLzZL/2g9BnKHltcAfLTF9gnSSAWhPxiPFMzAXX3zGuVcC9r9v0lTmjjnd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SM/Gm++v; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4217926991fso17185425e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 01:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718008233; x=1718613033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m4JDwhV2cR7Ytuzv+1Ii4Ke1NBV1K01e2T3BpGYXfFw=;
        b=SM/Gm++vw7p920kagVbeTq3k5iDUSwo9+d4S6vvNC5bgqOuDRB+4aDOqRZ3DzelxVG
         bieEiKw4lZfigOOXZ0TJht6459gB5am+FGsb6NteuSq7hIqwCt9YC06r/Z2fXLhM7iJl
         xFEESfIxs65KUWr+okPRNxXJZA79W54OCIYNChfoPThstZzWL9OTWET+6gWBB/HHLf7d
         jedajsgeEZCboTdLwEN2M1dcrPqgbOhfKX0C03ol1vlpS6GmgN5gg4OnQz7sQFAEWGaZ
         Qby5nzFRCWeZl/rmG9cmuuk64R571MunO4JdoUyHA2j9Y8659axqOh2Jnu1+0yz8abxu
         HUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718008233; x=1718613033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m4JDwhV2cR7Ytuzv+1Ii4Ke1NBV1K01e2T3BpGYXfFw=;
        b=N5zb5yvtQI0dFfWU4eOLY+30KTbWyWvvSTpqHuvQFUtcHDZvQ7nbZ1BOq0x2PISaPU
         qwLoMkX1vEzuFTgFB0qewUwNOHzIQnLFkvLByPLSS+oCGN9Bd4wYYhF0VdMqD+800NlQ
         6O3iyIOKUG66FGonh97gWNT5fr0O4TggZryTscwSN4Mt03Z8q06R35QeDnZm9/UfOC5a
         4XoUULR4wFK04SZ3ciR+xcIx/A0r3nMkRTbJCzNkR2zGo5KvEUanO9ftWT1mtAqckWs8
         vHSun0m4H2HDsEQiJ6hkn6PBSEThmHw5Ie2HtVsmqNUcsYyL8G5nrXpKrNk4ACS2Z4Zq
         dM3w==
X-Gm-Message-State: AOJu0YxrHfY/n05mMomlwwY6olZ29NOue94l2fiE1gQdypnThCbCLWV6
	K+yxG2VMgVcrzDPpilVosIUFtNDKgJqFRI6qINmsVo4mYc75cR1E6rEV/sEx7Sg=
X-Google-Smtp-Source: AGHT+IGu8HEy2ECkQy+srCdXICGvsMf6pP/ZcnT5ejLki1U5ZO+z4kgCcRxa8Ls4ntIqJASrv31eDA==
X-Received: by 2002:a05:600c:138e:b0:421:2df2:2850 with SMTP id 5b1f17b1804b1-42164a21d60mr90029555e9.31.1718008233244;
        Mon, 10 Jun 2024 01:30:33 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3? ([2a05:6e02:1041:c10:bb3:9a3a:605f:c4c3])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-421f23d06ddsm15371805e9.8.2024.06.10.01.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jun 2024 01:30:32 -0700 (PDT)
Message-ID: <b4daa6ca-d05e-4fe1-8f4d-a9586b992daa@linaro.org>
Date: Mon, 10 Jun 2024 10:30:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] thermal/debugfs: Fix up units in "mitigations"
 files
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
References: <5794974.DvuYhMxLoT@kreacher> <13533101.uLZWGnKmhe@kreacher>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <13533101.uLZWGnKmhe@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/05/2024 16:55, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Print temperature units as m°C rather than °mC (the meaning of which is
> unclear) and add time unit to the duration column.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


