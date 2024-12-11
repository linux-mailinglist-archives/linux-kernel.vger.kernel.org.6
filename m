Return-Path: <linux-kernel+bounces-441332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033FC9ECCF5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 14:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774CC284DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61287229153;
	Wed, 11 Dec 2024 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qjLT3ahG"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CB8225A5F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 13:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922933; cv=none; b=cokHBzuGcyXMGNfszJjq0GmkWBo/I1rnUCBNERRmyNIMZsNy7i3om61pt6gmi4ClYrTV5CO4OpCsydBi/amMnf8jleNXavI4uc3Yrzik3txUu7mtop3INWFNJMu8zEHOLdyKkL1tRnjFKHAuebYSGhpnZPk8j4TYWow8wO4qseo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922933; c=relaxed/simple;
	bh=jUViW32COeGoeYELh9LbBlj4465oJrhfN7e+K2CTTdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ku1KaeGh65QIIM9Uspc7L4CNWt2plCIo0SeZkX3nlA4vyR6cGFXMDUpiA3vRtx5ImMpQvaF6FPmTE5kwVNqs1CPHrEObWJuQaa6b1GYZpws0AfJjyCTlXNC7RcR2DHY1uNcLe2bE+ydosxaklp4E/thGT7ZPJd+Inbfd3c158E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qjLT3ahG; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3d0205bd5so6203264a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 05:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733922930; x=1734527730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2wwyxsApnY4hDVPBOHJhItY5Jgr+I4T7A0sablhlGmg=;
        b=qjLT3ahGjn3eV8pVibROAMaRsVIcgYOEdLyRb6jQWxEZuzTqhKUqQ42MvK64iG+kws
         hRo1nTr2srA0QpZ/JdEp3u4inEkM7qQshpvWJCcbceQ49s2lQTsP0GYC4QlZ61SZ/bZB
         0nGd1MIqB8l0vYEYrWhkEKZB+Qu5wGhOajHW4x7L+P5+ipaVMU0IV/SE5FdbsIhfgd8e
         7eGTiFfUbVJkiKXx0NLs8A871P+07wF7ypis8275KaZx2nqHiUQOT5CY92uB5e5WfC5T
         dbXZwtOL5WBGgZ/xeQ9dPtcRjqyY2c7krCOSxdxtMoNxEsOf2kBb+mgtG3JDewNFGT6M
         GGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733922930; x=1734527730;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wwyxsApnY4hDVPBOHJhItY5Jgr+I4T7A0sablhlGmg=;
        b=Ub2MPOdDWjJDWiB0BRss/Yth9DmUkT6cCfVKZ+8zU8pyJih3nF8sckneVg64v6Viuf
         y9urYKgK9Ylpgusl4IxsXV0l7GLQETK+AJ+7EXcrVonwrT4GfZkyuPGd+VPuJTNF41Ag
         8sAdO2re8IWXRydBqggX1oOyeJ+cIEpcZUcdxwKGYyO2cKDZA3Nv55niHSxgmHdIGqX0
         3H1+haYIxA6H5ZuRUjo5zFfWu5Iw6UgEPb41BPmgbXXFSMvqENxUwM4+9sVzHWmPU2g/
         UtTgZxU/x0NIP1DlzwuoE68H0Z8fLY2ULdfMq5fhluePDQUDedm78AnOCpArjjs72aDX
         i9iw==
X-Forwarded-Encrypted: i=1; AJvYcCVxDIvasrxz9zXJvuzDwReum0OO5P3lWGDcc1WsCUYIVzDAXJeexYkFbS+PyVzyBHMZFzks+NFGSBfALro=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBJbs69FQbhQxBH5D2/s4fiHZqO6+GLk8WsmNwo1f/tZ3PL3E9
	UiqTV6fZ3qVzXclNIUY02E6CqQYY4lECbqRKHw+5+f0vEPod9DbAZoH7MFZ2DdGBZPrg1NHIYxZ
	K
X-Gm-Gg: ASbGnctniKVgG5RSU3QcVkS4KR5qYuIDOJDRrirBn9oaMU/4r2wuR2zH9liC8+BIhpB
	xScDe9mGiaHww5Cr0sqrHd1iGheus1FzRNEQnrjWPB/4onlcBHannRUAYQC6XucHnQ7B2p223lX
	J45FN72KhAU1p7lftlBIWCrBisscFVJvGZ7ORvzoIWE+LQSc1dfNKoKh8A2tjMDA1NJgwyFOpZj
	N5yECbPZ1bp6qSmXjxO3fWCk4yHPK79rGzM5tMg3QzcNnCbQsEmRM2CZANgIFP4DY8=
X-Google-Smtp-Source: AGHT+IEQ3VuB9AehLYFtF0JsGB2XRiyuFHW63nuUHnZmuZQ3vdkrpWWLByAocPF8PI57hfUSLB2v1Q==
X-Received: by 2002:a05:6402:2553:b0:5d1:2534:57bf with SMTP id 4fb4d7f45d1cf-5d433170532mr2909736a12.32.1733922930525;
        Wed, 11 Dec 2024 05:15:30 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d149a25ce7sm8914783a12.5.2024.12.11.05.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 05:15:29 -0800 (PST)
Message-ID: <19ac5167-017c-45a4-b9ef-9b9e11b216c2@linaro.org>
Date: Wed, 11 Dec 2024 13:15:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] clk: qcom: Support attaching GDSCs to multiple
 parents
To: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v7-0-7e302fd09488@linaro.org>
 <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v7-3-7e302fd09488@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20241211-b4-linux-next-24-11-18-clock-multiple-power-domains-v7-3-7e302fd09488@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/12/2024 00:27, Bryan O'Donoghue wrote:
>   takes care of hooking up the GDSC to the clock-controller.

This should read "hooking up the power-domain to the clock-controller"

I will update the commit log.

---
bod

