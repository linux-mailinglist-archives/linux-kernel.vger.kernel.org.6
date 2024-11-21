Return-Path: <linux-kernel+bounces-417580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 764929D5629
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 00:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D6BE1F230A2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAB61DE3CF;
	Thu, 21 Nov 2024 23:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dy6Vxf3d"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235B01DE3AB
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 23:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732231559; cv=none; b=udRaxmP0WqhXGaQu2WBthSwT8e91WnpMPlVbijN6oZyFa0sBpC9eDNWVwmg0HZRA3WgU2YlzOpTIK8Zbc2RjJynQ3E5PPUeUzXW7TA9JEKMf9SCuiW0vwZlZNCvbDL4GB/rnpEOUtCGJcnYKb8MquBVpwIkSXDnSIF4pMkjSyNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732231559; c=relaxed/simple;
	bh=xYgsEyqX/nrv64zgWbndRQLzhHiaVrJMeBBnEJnAUf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KmtGqdyZQVompZhNYi57ZLaH6qPE4daQmcgvcMRrtpQQ4t03O8u1V/wyLjMOeI2uts2y0FQv3AjZ/iKK4mLmG0xLu5isKmUPpNY+39kzbvwZZZl6AUsYNOrgevWILVFcHI/xZ0lYwCR1QKSnyrkOJL+6KJ3GGYEDvslBantz8tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dy6Vxf3d; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-382423f4082so954648f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732231556; x=1732836356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Iky7t6Q+RBwcmkvNugtP0jm94OiaVAYR36AYKJtXDso=;
        b=Dy6Vxf3d/FGxyojuh9/Q5Caf94q7crHU2fShvk97+F56Qoy5VTY3pm7992PKpPiEU4
         ZYna5PIy3r/+DedxcMWxXjs74m/zeYcSYqcziAsVP/V0zcxefx51NFnQcnEbZuoFoNP2
         1IGKW42wI9NVZuUYqwSWWRQGtNcxMR7tg7J8RZZXN966X6gwFz1vroK+Pm9WlXLQ1PfR
         VxioUyqRWE/G//oXpn9iFPShk7BUqRPZhM8w1Np4S6KQWqxaCqKkCD9yUooeMZYwBWhm
         TzL0OdIF1U+3+1NMsM6CWYTSnhMjg7IJz8OiwklnnO48iFW46h7RrNmezmKWOfKdKdR5
         EG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732231556; x=1732836356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Iky7t6Q+RBwcmkvNugtP0jm94OiaVAYR36AYKJtXDso=;
        b=HQ0+Z87ZMCR/UaYF/kCCv2vwyESIgmFC+fiHG4n2JhIYVuIlSh5yHLIv26VRnDdb5r
         70kjFxOgqsFw8yofpTfxA052RYy+e1D2p8uQ7VGbhvgW2HS8SM3PsAM3MX2glyWlogdR
         E0css/Ho6MzZpNmr7ExT6dU1utmRKtsmqTG9x/q9h6u/unyRjUiHd5GMbYhFPHG2vPMz
         42f/2WPf3ubR7d07sidhi10vcBRuJOvhMXptExVpz+ajnwZM861UKd8mnTfd/wiCdY//
         HryOro1zgcn9EjdI8V2zZuaPKeBYu7uHdSb2x6ufgwQ/f3wetvY6C1J0SsDdZtpJZAJF
         l3xw==
X-Forwarded-Encrypted: i=1; AJvYcCVPHnZ4exSMjntokY0r0s8UoV/6f/Nf4UCyKImGDzm27dGD+zzALnaFqfJJDMf9u7pNGFJp+GCzOKwoL18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxphfRKVny8Ay7U2DmsEEc3BlxXItrLI2eA5v7kcxIQJQGd/Z0O
	Ona2PlUUIBJBk1JKfNMSMDYjrQykwF/wxwIYOIc+ufb9NYykywF1mOFhyL9hJBc=
X-Gm-Gg: ASbGncuTRZt2uMr/yWdOp85wYOnUZAAtjqMlB4BMfkIbZpD0hS7T4HfDx50fcmeMOjL
	zM0vr2yxAqRWoSopmLxZTXxAfk2qrLDTMYQooZzfMLfkirUpOlK+hHgXqGRpgbJ2DlPDAAkMKTJ
	8tqWUzziPEHNtZJ5U0FDokTK3sPtSTZL6KvspxEDjPtU4pB2BUlosKQ0y3lsR0fH4GMYP4FbhO+
	QdLLMXmHBqIKDB1JhqeJRcB8REPbJolzmSWjj0gFwsODkSuchbICTe+rMrhHUZ0
X-Google-Smtp-Source: AGHT+IHZlEqAmC4u1AVb59drMSS6PU4rPjTcSOo8R5q0avIDJN1hm3vFKz+q9yZBVRK9BRRyVbVDzw==
X-Received: by 2002:a05:6000:2712:b0:382:495b:7edb with SMTP id ffacd0b85a97d-38260be6712mr444022f8f.58.1732231556248;
        Thu, 21 Nov 2024 15:25:56 -0800 (PST)
Received: from [192.168.0.200] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fbe9013sm820052f8f.88.2024.11.21.15.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 15:25:55 -0800 (PST)
Message-ID: <92d71031-c148-43e3-9a8a-2cf92e9808bc@linaro.org>
Date: Thu, 21 Nov 2024 23:25:54 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] clk: qcom: common: Add support for power-domain
 attachment
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-0-b7a2bd82ba37@linaro.org>
 <20241118-b4-linux-next-24-11-18-clock-multiple-power-domains-v1-1-b7a2bd82ba37@linaro.org>
 <u6azgqlmncadcwiz42pk36q7rehwajnftvwfjh4aoawskdwkof@ao2imoy34k4y>
 <587de15d-06c8-4f12-8986-f60a80fe5ad8@linaro.org>
 <hfkvbshgbhz3dst44kbdxxy34phrqtysxbfchuvefars7ibrwt@jqjl4oca6g2k>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <hfkvbshgbhz3dst44kbdxxy34phrqtysxbfchuvefars7ibrwt@jqjl4oca6g2k>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/11/2024 21:59, Dmitry Baryshkov wrote:
> Is it for the MMCX or for MXC domain? If my memory doesn't play tricks
> on me (it can) I think that on sm8250 I had to keep MMCX up to access
> registers. But it also well might be that I didn't run the fine-grained
> test and the MMCX was really required to power up the PLLs rather than
> registers.

I see MXC is also used by the cdsp.

I'll have a poke to see if I can ensure both PDs are off and see what 
happens to reg access.

Perhaps my first pass test didn't cover it.

---
bod

