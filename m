Return-Path: <linux-kernel+bounces-418248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D119D5F47
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 13:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3274A1F2278C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 12:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB8A15531A;
	Fri, 22 Nov 2024 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="euAhNgAx"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B88BA20
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 12:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732279861; cv=none; b=EOAYKLl5ACcrCOteF97os9l6iYv8CT2apIk2+4z+1XvT+tnsnv5uq5YNIl9OLIVJkNUjPCDqu9Ho8IGsU8y33UeE7LmhLarrS7Cx78Sk9X9OuZcphfKFKVM3pX6U+DhppnNneIkxKh43rTdFUmfc75Oi/bVacN5diMY8Q0fdCW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732279861; c=relaxed/simple;
	bh=JBHOh4rUnLADzXtOwvC84g7/JrNLMPYtlQhDKTzIkJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gGmyTGr5AyZRQwqsOBkzr7CzjWzCcYtzaTcwz6+QnDp635/jtqyBMUmpDN8NZ6oRIc0gOFsxv2bbEYVpV1G5ga9G3GURovJ6ESZo5lGKwJ7D11v86UwRm7HFVTS0q+uDnysTmV4wlFtJZImW0THhFyigl3jIlZ1TarQ4gz23HhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=euAhNgAx; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3824038142aso1446946f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 04:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732279858; x=1732884658; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KISqflzqP4C+qpQH2POLD8D91UlEquq5DIx6lhdqv9U=;
        b=euAhNgAxorUVFsIASQSjJa5dVhdxz+PiPyB5faPqRuOSn+aKWBG1XSpIl/VtWkKuwE
         Bdw8vLDl8bK7tPpnovrsliIbLi8LnW5uodLlL6Ul+gIPrxi20foUl4G/ZRXgxjxbtsD7
         7op1n9gMyGQZ6g90HwJtVnu6jY4nwcm8pwBCKDc+rjqtMWkiC2kydcTeujeEJaMfI1d3
         cE5/bvgkjCBEnpRWhLXxRvIaIpqb1xBpj2606A0HQ/fdtTyjBsgvLE7FSmoopUN4Ja+M
         VJiE3BjevBK1/LfB4qbqdh9scSHNJgwzqRnD3RJOQY1evJ8MzW/Vj2po8Kk+FK4enI4E
         SyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732279858; x=1732884658;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KISqflzqP4C+qpQH2POLD8D91UlEquq5DIx6lhdqv9U=;
        b=lyAioweCG6gCk5PiY+6Fpbaq4P95eCF0BTJYvRxu4uxa/uM1DVm0Tc+RRQIPGpHgea
         VcE3qAGYcwiApQmzRhzpP21glyyaNY+2pRYL8buIeq1paqhRDGgtW1eFkhMeG0Ctuj1b
         OIdKrknIGwmeeP9/1w4a6b5+mT+f1qZhJV/4XJ7qEoiZ22tWT/jjbrlE1qslWIH5c4Tm
         JMEFVRwDKKPW1ZufvE4rGqzu9VG4J325CVtpYPxVaNuNWYpmEP+h8sh2M6OoS0eTn5aL
         R4PvvJmyElNxRKpG5sd20MDBnzlciHYuremRoWTroC9RXsT5mp9iM/jekTAOWNyYOWrj
         VqHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8XokPWXWpZVmHhE21ShdBNoCHApj8jZWx7m/+DZv128gDSiLUyrSXLK5+IdwPNLca6IxhQOPqav5yItM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWpmH/r895FD5zE7FcjS/XGNlB+7gnXo58PlaFBP8WN+032kS4
	FJI6mUhNW2rgfOcXZcfAjkev0KDYPZ6mvUWxHyViQ4fVbG6QX6no/7jacH6NuTU=
X-Gm-Gg: ASbGncvJYeh2IHp4X1BS73lwxGrhcjAb3mmV80kFlGzlmhIpF6s4oBSxGGJhoZYyINR
	Q/Uf8NSo0KnyfQm4Dm1oVOsbqxd0gSKedFudpB1Bk6IXfacIa9EWoBPScYPBr/nI2KKpqwEIC/Z
	OmmNKWzEN0X7I/ZsweubO+CHvrHIGpgmmtUrS9oLrzL/450LfZVB4mcUnbbhdCdNp/0+FboqF0k
	V9udjg4bT7p/xr2LImowfEx6kPsc1yHlHCCPcA8IiJQWYWLYS4Y58rrS0U9zVo=
X-Google-Smtp-Source: AGHT+IH8paRTgv6TgTv/fMTI/UYofpz859HmfaEoTHqkrdKZAJ6nGDUeZc0w5K8HyhUYuBIakIZLDQ==
X-Received: by 2002:a05:6000:186b:b0:381:cffc:d40b with SMTP id ffacd0b85a97d-38260bcd023mr2225909f8f.39.1732279858025;
        Fri, 22 Nov 2024 04:50:58 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbedf63sm2333104f8f.102.2024.11.22.04.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Nov 2024 04:50:57 -0800 (PST)
Message-ID: <2299ec8f-4b80-48ea-96ed-d1eb40998e55@linaro.org>
Date: Fri, 22 Nov 2024 12:50:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] venus: pm_helpers: Use dev_pm_genpd_set_hwmode to
 switch GDSC mode on V4
To: Renjiang Han <quic_renjiang@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
References: <20241122-switch_gdsc_mode-v1-0-365f097ecbb0@quicinc.com>
 <20241122-switch_gdsc_mode-v1-2-365f097ecbb0@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241122-switch_gdsc_mode-v1-2-365f097ecbb0@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/11/2024 10:31, Renjiang Han wrote:
> -	if (IS_V6(core))
> +	if (IS_V6(core) || IS_V4(core))

sdm845 IS_V4()

The GDSCs for the clock OTOH are


static struct gdsc vcodec0_gdsc = {
         .gdscr = 0x874,
         .pd = {
                 .name = "vcodec0_gdsc",
         },
         .cxcs = (unsigned int []){ 0x890, 0x930 },
         .cxc_count = 2,
         .flags = HW_CTRL | POLL_CFG_GDSCR,
         .pwrsts = PWRSTS_OFF_ON,
};

static struct gdsc vcodec1_gdsc = {
         .gdscr = 0x8b4,
         .pd = {
                 .name = "vcodec1_gdsc",
         },
         .cxcs = (unsigned int []){ 0x8d0, 0x950 },
         .cxc_count = 2,
         .flags = HW_CTRL | POLL_CFG_GDSCR,
         .pwrsts = PWRSTS_OFF_ON,
};

I can't see how this series will work on 845.

---
bod

