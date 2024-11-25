Return-Path: <linux-kernel+bounces-420726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDA29D829C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4EF16398C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F01192590;
	Mon, 25 Nov 2024 09:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EfFPD5Oc"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B965C192D6C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527363; cv=none; b=rnIF8qyvidJvL4TiIKoK4eE8rWvVqzL8ankcRE1MpJi8loMhvbuVF84377qVo7OOQOJ5J1ixXZ3oBndJi1VhpZN3X8jUMFMUyJRrlSq3RNYAYX0GdPFQKNAnpbMawHvHp34pxbtn4jpac8ZsPEObMG4M7+sk8r3BRNIms++ZvYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527363; c=relaxed/simple;
	bh=SN1ke6h10N1tpIjFi42fcVYTTBA9mbS9XqPXAsZIIgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=srtBFS4XlpYCkEyhyp5DKbmAQeLqKEZa8RM4mEHZ+rCGKqktvUSHYSF5U2HP0nVW5rHfpbWSrzPDAXnqCySBY2UNtBZYxmzeIuEOsvCqzrqGIibk8zzRbPAik1JmJkFeWsUk3xVzIEb1bKoQWRblhB2Gf1lgDDFGCvbl/2bO0MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EfFPD5Oc; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-434a1639637so2427625e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732527360; x=1733132160; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SN1ke6h10N1tpIjFi42fcVYTTBA9mbS9XqPXAsZIIgU=;
        b=EfFPD5OcRby8/avfdKh+W4e1LF5kp1IiC3AVaUpPdRVW0T4K5dcKT+aqcxMo+Jfcip
         9b2hgOtXTY7D2OX4LNZR9S1KLT9IZGDiKsZlmTloQHt9jOWmsRcvwXwhUn8+r0va1ZjS
         rJ6D2kIJga+EqekfQkH9W/OrIsWWOrP08zb8uu4b/89uvs7krbfYgpMe6VK4Qg/I1u8j
         HxUAYlOGv68XJ5jrEYQm9LXROnMuKCpRUXkZoXJLd+loA6JcZ9C2fTGQyMe9FzqFYGc0
         iD9hYl+dbzuGLQZLUeViMnjepLBglwqla9RxSMsCzNMG+7qLkruQ9J/XaW6BmcC1tMd0
         U16w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732527360; x=1733132160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SN1ke6h10N1tpIjFi42fcVYTTBA9mbS9XqPXAsZIIgU=;
        b=LCPk0IdZms/V1eJXMtYINxdbmyJpIEMgPhwr4cEufl0QBBmD4cVwZkzhdfcl3pUPds
         rIwiSCOW4gQliO1mYmELMq+45lJOjLoUmHDwUAnphDIaXwct0soP7KzFj9Oddd8A8aIS
         pRXqYN5X8i8r+Srrnm5+nMoXdRmssM5dQlUNxb0fMWJ4AWoVRLfwvN58sCCXcuHLPgfj
         bNS3uDSXkjHXQW/W3UBw7WqLns3I6CZCl+2KBN4c6EXMkPfgFPEveGBJQV1GZVyF18FQ
         SbpoHPInYD5ZJt1H1ggmtV0eOQY1kXDZPdALQ+h9gKfpX/nlHHcIxIcZZfzmNl8754nj
         X/5A==
X-Forwarded-Encrypted: i=1; AJvYcCWc8NaS3NlovJQTfug4gdPa8OTnmr4zpgCj82wQF9XuRmMSKcEEWkvetE4jgn4eCFPM54azpKrBWDl7xEk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4aPizmaeFtEWVbO+SFW2lnNoJ5+7v2tRZMB0Bjpd8aM1LesP/
	S/faEbgjEJ2lyK79zOi3F9LmU1ssyXMB03CnbuujSCB7gHZPbKeVN9NqXNh9eWA=
X-Gm-Gg: ASbGncvZ57+/iwxJ56MtuDttYfCsUoVBemjvWfV9GxYOhI1F5lXQxLJPxkYFBzP56Oo
	mZBkvouUSDyfDFyLSLg52j1aEfEtHNrTh+9h46ijZHhcrdutzvd/FVab2UJMvIwIGEfsqdKwhqg
	Tvt5KZoN2HAkW+ofr8OelT+TPv1VJ/qDTWoP5EgKMZ/as9p6pbA23Q9xd3z+JHplIKI1vMlne1h
	kek+xzYOMXIfA5nVYuCR65QS4xiU99EF3m6kS6i+HQs+oPaTHg6DKSgVcqf9FI=
X-Google-Smtp-Source: AGHT+IGGanB6M26FvTKDaJXED8zAo9zRUZhfKFIRCk7WD5/Sjbv4DRD3EJV+JM26XNm588PaSZdgMQ==
X-Received: by 2002:a05:600c:4704:b0:431:5a0e:fa2e with SMTP id 5b1f17b1804b1-433ce49128cmr97088715e9.21.1732527360218;
        Mon, 25 Nov 2024 01:36:00 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349dd9a597sm45357745e9.5.2024.11.25.01.35.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Nov 2024 01:35:59 -0800 (PST)
Message-ID: <970a37f0-ccb4-4c23-972f-4100cb6c4e81@linaro.org>
Date: Mon, 25 Nov 2024 09:35:59 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Use APIs in gdsc genpd to switch gdsc mode for venus
 v4 core
To: "Renjiang Han (QUIC)" <quic_renjiang@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "Taniya Das (QUIC)" <quic_tdas@quicinc.com>
References: <20241122-switch_gdsc_mode-v1-0-365f097ecbb0@quicinc.com>
 <f7c31279-8492-484c-94c4-893d98f53afb@linaro.org>
 <2212eace0ed44c439da117fb05f2b1db@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <2212eace0ed44c439da117fb05f2b1db@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/11/2024 03:49, Renjiang Han (QUIC) wrote:
>> What help do you need ?
> Since the GDSC flag has been changed to HW_CTRL_TRIGGER, the v4 core needs to use
> dev_pm_genpd_set_hwmode to switch the GDSC mode like v6. The video codec has
> been verified on SC7180 and the result is OK. The same verification has been done on
> the latest QCS615 and the result is also OK.
> In addition, since the videocc of QCS615 uses the HW_CTRL_TRIGGER flag, QCS615 and
> SC7180 both use the v4 core in venus. So the v4 core needs to use
> dev_pm_genpd_set_hwmode to switch the GDSC mode like v6.

I think you need this tested on sdm845.

I can do that for you.

---
bod

