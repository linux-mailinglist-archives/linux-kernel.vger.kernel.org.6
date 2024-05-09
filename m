Return-Path: <linux-kernel+bounces-175083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E668C1A17
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 01:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508CC1F242A7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 23:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC719131E41;
	Thu,  9 May 2024 23:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a/PmO4f3"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5460131181
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 23:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715298960; cv=none; b=ogvJ1l2AulpceVuhUMFlYH6L+WbXX/pOdEuP2WGZPCGazFO3Thfx8FUF8exnK5FdKZUE/EyV1/k1LjqoQnDBe6GWNAUzDcqAjjL7PowVadaF6A/1MCsJ/p552d6voZ/7an2bQixXaCvuMpNwCxO/THUh3z+ao0mTRGik2XAYw30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715298960; c=relaxed/simple;
	bh=UELlES2ACAhJ+mM1o0XO08v+CHkaw8b0lYLbPsI3QG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rI5fAq2llHVHdS+ZPPct6k3OFkrYLsyrZ4Khl854xoqgzYaYRDaWVtde/Dsi8djRsznfh8EeqqoIJrbEZMrsfKPSIc/kq94WmfLSe/uhlpjj7EaUhsTPub8NpbXWMEuajvGvBgSbGQ1AeP7FvNsvc+Nfjj9ho+szDRATe9Jbr4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a/PmO4f3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-34da04e44a2so990823f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 16:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715298957; x=1715903757; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fb74xBYRIqFq/c6DAFovtzCXTBDOLi3/e8KUftSNAMs=;
        b=a/PmO4f3GsR5OW05O+LTKCZVK6FHw3ga2S2Ha3lHtTElGwTMKAe3t8TIKC/5aXHv1j
         bsKrb5rmoGpJ7h3u12SnsIpf8UFt9Sid8+kbiqpmV+MBbKdotl9+8HyC/3W6A95L+KL3
         39fXyt3vCuKvAX8ngfQV0AJ+v0GzHJqu/UrmbDZ+m2SzrHW+0tIXEihxowYshX0QFHoh
         daqWdRMqHeBIZwOPmGsYZ2iNyA+RpCvGPMSlENR8zxRDiI76ZOJSD042U78lD2o1cXN2
         LElE5GJ8vO/WD6nsFZHJykH60e33uC5ZClWpVsnQF3ABunYB/0egRs1+qEGNKj/yU5Xp
         GJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715298957; x=1715903757;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fb74xBYRIqFq/c6DAFovtzCXTBDOLi3/e8KUftSNAMs=;
        b=gXfJtK9mHc9A/YBtQQFDCOi5+eHKFjRPvBHbKmD0RQPkof54xmidQtkpVrdONuXI6t
         mKUmyavImGeDMG8P6heCe41BPiR/9mEso9NOCw2Fw8o3Eomy2+hFCcmKMbHC+ch/qDr/
         /ynYAn/qRlO6dDM1MWnxN87EhZVFAtz91Ke0Nx2eJ+mZisc5/7OYdBcWSc0AspeU353/
         BbEYREyKKZfStlOYlmToEkJC3PToW1jPq/YEdXUPNVifhyDOcLgqICsTXVVCfoCm/S/S
         4llY3dCQC6r39Gcz24vVbaw6oEWPgBlE8lt9eNTzrRzq0bvu5A2/W3ua2ocOKF6BI7DF
         /ivA==
X-Forwarded-Encrypted: i=1; AJvYcCUAxcrb/l8CMPaZtbvB9WMlD/9oG9O6VdhEly2NUwlaWi5UUPtegk5AFny0T9Igw3U6fGfy1WOLm0xEXFqEjqwkyLxFbFv4szSwMezO
X-Gm-Message-State: AOJu0YwX7kF32Iduzdn7a4GVLPzbx9yvekOEtZVBZFi4M6WCYz+CBiH/
	d50gpjU4J128HD2HAyRLz5e0CHkGgHtdTGM5UjyRZuKdzwOO0wVHh4HtRifGX1Y=
X-Google-Smtp-Source: AGHT+IHHTos/0O6mSj0vcqtxpJUzThg3PhGLr+9dwKKxXxyrjutvQ+cZS1AVYmAw4ywi/ws1vni/mQ==
X-Received: by 2002:a5d:5490:0:b0:34d:95e2:c5cb with SMTP id ffacd0b85a97d-3504a61d36amr646271f8f.3.1715298957086;
        Thu, 09 May 2024 16:55:57 -0700 (PDT)
Received: from [192.168.0.3] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad058sm2909803f8f.66.2024.05.09.16.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 16:55:56 -0700 (PDT)
Message-ID: <0e6ad5e7-ab20-495c-aa76-77531a53d459@linaro.org>
Date: Fri, 10 May 2024 00:55:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/18] media: venus: Remove unused structs
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Ricardo Ribalda <ribalda@chromium.org>,
 Michael Tretter <m.tretter@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, Andy Walls <awalls@md.metrocast.net>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 Hans Verkuil <hverkuil-cisco@xs4all.nl>
References: <20240507-cocci-flexarray-v2-0-7aea262cf065@chromium.org>
 <20240507-cocci-flexarray-v2-9-7aea262cf065@chromium.org>
 <5eec6d69-badd-46f8-9da6-a578d5f7c3ba@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <5eec6d69-badd-46f8-9da6-a578d5f7c3ba@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/05/2024 00:35, Bryan O'Donoghue wrote:
> I think these structures should just have the "[1] -> []" conversion 
> done and be retained instead.

They won't have the same sizeof() then so ignore that thought.

I still would suggest dropping the `something[1]` in favour of 
`something` because these structures document the protocol between host 
and firmware and therefore are useful even if unused in the code.

---
bod

