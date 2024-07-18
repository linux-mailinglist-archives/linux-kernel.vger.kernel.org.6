Return-Path: <linux-kernel+bounces-256399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 799B6934DC6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 15:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0133E282A10
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 13:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09CA413C3F6;
	Thu, 18 Jul 2024 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qcM07StF"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C38613C67D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 13:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721308019; cv=none; b=sWatcMM9b8KNN9h5LFTZtAAO5uim0q8XvDtp0fs0gOgXxNMb29zzwnQC6SLIvAecOqwldvUYOmcS5h1y+EsiT8vVQerHJH1Gkpn6OpBYseTjTig6UDuOlbaqthqNG2Iql5zO20rgCZgPsqrToVDse4s2wLXziFFlHeA62k7OcRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721308019; c=relaxed/simple;
	bh=djFjnEapvar73YwrLaz07BFQzKJRi6JJDEjTOBaGgW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aC9xqUf6kDnEvVoX0ZVG17z92fb3rq5m1SVZ8qTaFfYa7DNY9bj3MUr4gOsnF3jsbgnJxNWg2SSG/THCgY+UMRqnuPQslQAibJb6KlCPrYkFRKHEC3pdUCOIViS15JBkk4tJmjlU5lShswJAiA1oJQcmf1VDa6omBp0q9Yzb1wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qcM07StF; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52e9c6b5a62so352265e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jul 2024 06:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721308016; x=1721912816; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pVjvPiW915O6hXy1dnjgZFJRRYTFWxFmRy/fpGBotgg=;
        b=qcM07StFqvpSa2K/5kqALJ7PfIaxnhN6BWUDya6UK3qxUnKV3NkdTIsLyqZWzrJrOG
         SpEoYB4wijq07EHTWGm3FZPiiLMC6sPtQhS0Z9CDXPGllOmlxw/wtFISO+MPrNEZ+rsJ
         S5lCs9NccExPO7TrPZ/kkT5vy9mArzEQpNqxjZDtmF+Duu/7Zox4oJWswLlGi6+LGpzl
         foTlNmnTkyUjzzEt3q+mCSfuIM0qUMaAhRqHRIS4IpEvoL/ajGmHW9oPvkZwYgGC6/de
         XTHWniCYUDP9pQaa4WuYS+SjAGxi3l8inxc86MjYrgwlQFrioMVu5OXNa6Z8+gbSlHOS
         n/vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721308016; x=1721912816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVjvPiW915O6hXy1dnjgZFJRRYTFWxFmRy/fpGBotgg=;
        b=fcHi8P/2hSJtIoL6BKgT/K6962+RUvMZ8qSSwBKpMfd5K7k1nq2o43d7UpS9uyK224
         t2C6CfqAldi4u2jFGtFSRunJEyU55rW3rO9VKCS2/krlOwhnVYQiFxbpUQcNSB0yTN0f
         koOZChyWj0uxbnsj25HRxCnMnEd9CMUGAsTQ1qlnsNsC6weOAt8xzFxXU+KyB6jzkpVq
         3vmMqhM85Rk2O3U6xjKIyRJYhNQzHmJTHyiK+EGgLMv+T0oc7CCn2eoRPb4FoKt9RjSn
         YUa3JOwbR6Mdi0kgJxkg6YUWPrPGzmosu1GzDwReA4LlnofDl8ai3vAi+6cgNXu8VHS+
         CtIw==
X-Forwarded-Encrypted: i=1; AJvYcCUhF2jRsa6gpXPWmcLM2Lxtc48lxYPPyXZRRCyPXvF8jeFjSWSUpKizFSoWy5DxYtEgGBt4TaFq+7FEdE4qd6H9XPDUCHEZxW6N6p4G
X-Gm-Message-State: AOJu0YzRH851HoXKl6opC6lvDIYWQwEAidFZcNNtaFrOLN62gezx0Bka
	U+RSYPnWK5ruRj48RZiAnzzn49mL3+mbaayAWOSptu1dSjWF9JQYMza5ecHmb9I=
X-Google-Smtp-Source: AGHT+IGTjq6DlHRN25DEtbrFtVEQIQANz99wGmd8fi4oStiY3LoeqmSMrCyvZ3dZ6fugBkOpxXHedg==
X-Received: by 2002:a05:6512:2392:b0:52c:d8cf:d4f4 with SMTP id 2adb3069b0e04-52ee53a588dmr3533169e87.11.1721308015652;
        Thu, 18 Jul 2024 06:06:55 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ef07a0442sm87103e87.275.2024.07.18.06.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 06:06:55 -0700 (PDT)
Date: Thu, 18 Jul 2024 16:06:53 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Amit Pundir <amit.pundir@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, dt <devicetree@vger.kernel.org>, 
	lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] arm64: dts: qcom: sm8550-hdk: add the Wifi node
Message-ID: <qitt2j5hw6pax7yekdooutxebhkznhdv3aafnhkysr5fjcbmd7@xqbp7h3ld4gs>
References: <20240718125545.2238857-1-amit.pundir@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718125545.2238857-1-amit.pundir@linaro.org>

On Thu, Jul 18, 2024 at 06:25:45PM GMT, Amit Pundir wrote:
> Describe the ath12k WLAN on-board the WCN7850 module present on the
> board.
> 
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> ---
> v2: Changes suggested by Neil

Which changes?

> 
> v1: Kanged verbatim from 490812872449 ("arm64: dts: qcom: sm8550-qrd: add the Wifi node").
> Link: https://lore.kernel.org/lkml/20240702091655.278974-1-amit.pundir@linaro.org/T/#u
> 
>  arch/arm64/boot/dts/qcom/sm8550-hdk.dts | 113 +++++++++++++++++++++---
>  1 file changed, 101 insertions(+), 12 deletions(-)
> 


-- 
With best wishes
Dmitry

