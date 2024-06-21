Return-Path: <linux-kernel+bounces-223992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3A6911B98
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B03E7B24A46
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92463155CAC;
	Fri, 21 Jun 2024 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nSYnOUQW"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE8012D773
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951010; cv=none; b=bMllWbz+anprmnqhUBLG613XukZT4s5+e76Y64cyOD+U4ojtDqMKYF5g2H1F76nC2bfHvlnlkwPvLlKwcUYiKFHPkFbuujcWNNuk2qn1s8L4NDF/TcvSmul6GOZ+FotsuQRQBXyfQR1ChV6j5OA5kp8V40KZjMhVAO994h2o198=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951010; c=relaxed/simple;
	bh=srVvD7HVss2RcU2p6v6VTDCoVlILB5rAU2uw0cXOokE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Rk1vAp7ehQD/F8zqSU1OmokxWVdgxf8hkliVmbPhYHrSkGl+1JhwsA6zLoMI+R2r+ESz+eBXT9bvoE2sjrdKeklkjB05i1PbPUWofQmv6hyb0vvPp83Qfbr2yUYbwUKA1ItfJHAPK03MqoPlxIjfMJf3Ds9YxgMlqC0W/O5DwHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nSYnOUQW; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-362f62ae4c5so934835f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 23:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718951007; x=1719555807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSTFejqy3D/uJvo9d5Piv5WiCvKpQae7b38TSTQDNPk=;
        b=nSYnOUQWbDkrJ7q2PjrAuj41GRCwDQi6T7ySx+znGApNKSFF9M9DJrP8RCsPCh+Zzk
         4FYdjzQbxSco7iQTOBkvcqcIJ9U375tqAMYm3fwtHYS34nP8/UiLXQ2rF5JDFjsc1zfj
         HihPl1qXxFvu016i4YFXlnFucpGmDV0p9S4/QuzQT5dJ8fAD53+3nsw0Qp/qwL24UIpY
         ZY6Ku2GAR0Tg6HjF5XFP2PGpGsAIqk5RKXX1EulEvA4R2PXWNu0xq+tHGF6tVnFKDs7w
         lDyfsRlLag5zCA3VaG244Ygm3BfKHqFgzE1P3lulDQ/5Kyfka6sU3Uyuo6lWDKUtnrKR
         4nIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718951007; x=1719555807;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSTFejqy3D/uJvo9d5Piv5WiCvKpQae7b38TSTQDNPk=;
        b=jxp+DI2FWnlp65G+4iZfJjxMOzqocI3QBCFtnddb+GJ8r06xgutHgHWkKQFzPBxpRU
         h5sb+sAbdNGj2jBZF0ivRORuDo8hvTg0e/T1+8bTdBjtm6pFPT1LWNAEShX0Jk02+xco
         AyDJG6boTh2gLJUz0lbBrkByRb8DLsyyAfPuhpkT3YjoEQtPG2wxmWOOA2wTTNBI6hU+
         9fM1LVU14DsnO5imKli++bXbOTh3KXMaER1+2xKtTTRYr+tWwqf9CBPUOG2hShfbHH2U
         z/qvFePHfbp5zJoXCskcpd1CIFMDMd/C9Tb39I4UyxOoXNgXRhugxwm/2QgTPysVUkga
         saUA==
X-Forwarded-Encrypted: i=1; AJvYcCXMR4bXo3Ktfe9mKtL0ZJjw8v7cbVGrViRvlJSATj+369FTbYMd2lsduHNcB1WSWNRiMHupUKUOyQPa3RJynVZKbn/7Q9kdJeuRsb+c
X-Gm-Message-State: AOJu0YwhD7yjxqonwCL9sfQcTbIo0VlR45EA3O35XQf289x0Vqy+5F0m
	cuhd2/eFeNFebUrF2hwc1qQS4VYBbDQH2YWZFBcgDYDzXLK4kyIVUS7El53zSTQ=
X-Google-Smtp-Source: AGHT+IG0iGX0t3lNlYtnvogVlhJQiyMgokqT9gSK9cdmSOHSR5MCOKAxL+BQj9ux3uttWBRmZyVkNw==
X-Received: by 2002:adf:f691:0:b0:362:e874:54e8 with SMTP id ffacd0b85a97d-362e8745790mr7067636f8f.30.1718951007595;
        Thu, 20 Jun 2024 23:23:27 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-424817aa340sm14204335e9.19.2024.06.20.23.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:23:26 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Joy Chakraborty <joychakr@google.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20240612083635.1253039-1-joychakr@google.com>
References: <20240612083635.1253039-1-joychakr@google.com>
Subject: Re: [PATCH] rtc: cmos: Fix return value of nvmem callbacks
Message-Id: <171895100542.14088.10936476837707237106.b4-ty@linaro.org>
Date: Fri, 21 Jun 2024 07:23:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Wed, 12 Jun 2024 08:36:35 +0000, Joy Chakraborty wrote:
> Read/write callbacks registered with nvmem core expect 0 to be returned
> on success and a negative value to be returned on failure.
> 
> cmos_nvram_read()/cmos_nvram_write() currently return the number of
> bytes read or written, fix to return 0 on success and -EIO incase number
> of bytes requested was not read or written.
> 
> [...]

Applied, thanks!

[1/1] rtc: cmos: Fix return value of nvmem callbacks
      commit: ac9b2633e85f6b53cf368f90ae7589553e8998b6

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


