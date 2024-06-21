Return-Path: <linux-kernel+bounces-223987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8988911B80
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6BD78B2533D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 06:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B961216B39E;
	Fri, 21 Jun 2024 06:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAYfOf26"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D467152DF7
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718950852; cv=none; b=k/oBActINDhdBoLrco1pNXzlWvxKULSodmVZDq1lQKNE3my6mVQHGda/+6D0fy/ph+iNOdyTrT+G26cD4pgLK3u6xSZYT51XfaUocVLc57Z4XqbDo+b1NpeXGZp82t6kdiw2ZgV2UHD2RuxORCGXRRfPZzQvE+Jk0pwoetWlZdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718950852; c=relaxed/simple;
	bh=pzznvjSHoz5NeH+lwjs11KQGbqaQ0CPi/WrRnIneUK4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KVAzmx9BIaOKUDNvYtxkwuFXLiRzv/76NSgxfvmmpc74uDn2+qzpcIgXYz09J/S9srYkbjGX832mTjpL0nuIPBW3K5PgRnkNXJ2XIgp7LeBdyonPmWwqA9E2djSAhPJ7M17+sJf9J8HKJMpk/vgPAaXRDrK2ejySZtqYODjSno4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OAYfOf26; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42179dafd6bso16547865e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 23:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718950849; x=1719555649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KHAfx12iBUWCAlcKtyTUwpmghkl7Maz7FDQTyoaU5A=;
        b=OAYfOf26USwyPurBx/UFDIQg6pqdAhHXLttvpA678TqjaFOISifW5Ek+EjAolEP4Ct
         6jd6s2qpTU9QxiNmKnA1ZdWNRJE6+Dx7CNHqJOkziPv9mPlMLivoiKbbWv/6csOyMjxZ
         H3uzPvfOCsUhXFo3nB97fdCuy55YtMmXi46ozw2Gtilwj0+jbs6LvSw/M5S0iXshD7jx
         fykQk0Z9rG7Jo5jxhclceT6LGyZ4K3FDKPlz6QfuVmN9Abvuw0seUqmTzcn1felmKRKa
         CKLeEYEHkSjsyUlQkcKjjt2FH3l3mJAQ0+Ewm9uVdPOn4ppOkBOdggWcOKGcDpQSFQmM
         4nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718950849; x=1719555649;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KHAfx12iBUWCAlcKtyTUwpmghkl7Maz7FDQTyoaU5A=;
        b=LoZsAOilESmx1fn3z2PaydY5nft31HZhTgXwypU46LNogYg/5wWH8gPeW09AgGKSS9
         GNP6N6ULS08n9fa5LGwU4Gy7Mq/B80APOWgRAKrKArJjY+68Ko2TAgxuXZP4mp2fuieI
         VeN87/bqTHddA7pZfIfzzNwCFHxlOFoecrmXz3JZN1vTBYeXB+IMZs3Ekgh7JT2kt0dv
         CaWx+ZPvBxCmLRGBUIJ1ZuN640Ye4al7tJK4KbvpyfMLTLKLfbzoJbz+7svWtJL4n6us
         LUuOxe2u05PJypAkyF+7PsV0y1tWp8sA8BXN87WrgZkyLF4Qh9pWggE+5DSaDWxZBUDS
         9MiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXybvPEygH1d/PPMNs45jJxDMYh4rGOFn+hGKHHD/H6kcsdXglOLgA0qixaIDbgCreGnYYUzYng8ulcqvO3hz78DtDV5z1tLMDqAZrx
X-Gm-Message-State: AOJu0YyyCiTDLRxyXHp5lDwBb4+17RlJjx7CSBdz5b4kwiu3MQE6areF
	LHDplW9d01EVfsDADiJW7ypmf8yE4hvC/2c33EBXN01fEBNhMzeXjTH0nE8efqo=
X-Google-Smtp-Source: AGHT+IHk82aIQYKYEtQX7Uz1MHYN42vv3RdD9qqs//tlwYYsTyH4qxtVCmWjPGXP/YNoH1n1uKt4Bg==
X-Received: by 2002:a05:600c:319c:b0:424:71e6:258b with SMTP id 5b1f17b1804b1-42471e6273bmr89995035e9.6.1718950848757;
        Thu, 20 Jun 2024 23:20:48 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4247d0c547asm50299815e9.22.2024.06.20.23.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 23:20:48 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dan Carpenter <dan.carpenter@linaro.org>, 
 Joy Chakraborty <joychakr@google.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20240611145524.1022656-1-joychakr@google.com>
References: <20240611145524.1022656-1-joychakr@google.com>
Subject: Re: [PATCH] nvmem: meson-efuse: Fix return value of nvmem
 callbacks
Message-Id: <171895084703.13918.2428522284763807031.b4-ty@linaro.org>
Date: Fri, 21 Jun 2024 07:20:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Tue, 11 Jun 2024 14:55:24 +0000, Joy Chakraborty wrote:
> Read/write callbacks registered with nvmem core expect 0 to be returned
> on success and a negative value to be returned on failure.
> 
> meson_efuse_read() and meson_efuse_write() call into
> meson_sm_call_read() and meson_sm_call_write() respectively which return
> the number of bytes read or written on success as per their api
> description.
> 
> [...]

Applied, thanks!

[1/1] nvmem: meson-efuse: Fix return value of nvmem callbacks
      commit: c87ba397647e1ad84d2771461a6035a63d388198

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


