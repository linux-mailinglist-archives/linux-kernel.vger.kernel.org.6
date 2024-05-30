Return-Path: <linux-kernel+bounces-195536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470CD8D4E2C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB7C282562
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 14:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8CE17F50F;
	Thu, 30 May 2024 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="ooajDnRj"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7311A17CA0C
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717079919; cv=none; b=HeGsveMXH2C/qpQX+yVK3rvnahOBs++k5YcUVTL9F554nbc6CkxRr0hypLMkEcEyO71mBwYhDTuE2Qo3dNqclzxElj5Xuq26AnNFIwkiYoQ+YRq2TDw4EZ5TgtSpeB1YHmzQxehP9Bf6GbrC/LJR3uO44xZgKIn35JGtdsg9zao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717079919; c=relaxed/simple;
	bh=rmd9pEkZZkA58dCEx0iuoWDdo80Ziwi7JYACy68wpuY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FDmhrD6OcI8/ZyTigvrt7AyF3W8ARCvMOo4utZsmV5rfXA9j0HOZWha2jPnmvvecqgze2MGN7DzPtcANicH2F6qSCLpXz/xeAqH5ttAKhtUL9ouH2hAmptJHzjtqrMJFMwkHhqb3QeO/z4AMOa6SCsgjm3sNL8afFnbf+RcmnGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=ooajDnRj; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3d1b8bacf67so103520b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 07:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717079915; x=1717684715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vW0pwIYQgwhobA7Ixk7v6IauNiL+EOvg9nYymfAgbb4=;
        b=ooajDnRj6K9jtPN26Fy9q5dK50MDV/MIoogmsLa4dHuYY66tZbY4KsG5yj8VtDEVnW
         IQ9zgQHrK8/BvnP0LAxvIQRR2h3fKMI9/vii/Es/cCYVthJfCg8nadPrn5aWIAnwNrvb
         cDNlxREsa8YS0YZpF0+vGIzpY15V8E8F6OhTwDE8EzmttRnriurE5dQ4qvkMWnVDuDHW
         ErVKNsPQh0+YVih4yI549fYSc4t6aONw4VMmVWTcL/6rOLBvPbvKP9RU0DV9YYWzjTbv
         LeEfg9im6nZ3H3Aq6LAy8PZxPQLzEf3lJJtkqCRS0ZHUWrSB+3yckArWwPTtYCCnJCfh
         JpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717079915; x=1717684715;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vW0pwIYQgwhobA7Ixk7v6IauNiL+EOvg9nYymfAgbb4=;
        b=UpNgJclcpwshgCiOmpGbynTb1kHTXlReKLVVzpVyAYuBNtFvSb2jRmXrxxQhdPPJHT
         79b5M7W/aWEwlNgkf1Gi5/X7pzk0mOKF4WFVPeNmiLRCmDozSV3uHTCWf0NJl+0A6JLx
         jJkfc/2s9VQPYOW+65s0+gvdO8sOPhAjHoIkpeqO4dUVp+jwPXKjpW7TSdOI5yBgjM4v
         NNIUzYu6lDjMtJUv/+6G9pDTOj+Lky8OgZg0ACZWoe5L6lDBJI08evibZbfoKyWKuNwx
         Ttr5A+YsR2IecZUlgjj8vdIvNauHZYRuzLNrKxqbtCBWqlcPx6DHKnOhI8T6H7sj95Xf
         U/tw==
X-Forwarded-Encrypted: i=1; AJvYcCXJIabL/f1yLz0Q2Z0mnFotAsIxIvGFpXZZmdi+kNJkkHAISNWft/oZ+M6PyG7v/al50aFXbf94tewtrVKFPriAJ1AFx+1qSOsltTBo
X-Gm-Message-State: AOJu0YwdSadjMncMzlZC0HLUwBZnXtkQRi+/odbCSEwjEn23yfWfIn2S
	df/3HjMmR+zVm3IcHiAB/IpCIdn9R9pUzEp2FGG7GXVaj9/PkiEEf0y6eXzmMlc=
X-Google-Smtp-Source: AGHT+IGnpi2ad8K8urnHtPt8UyiK1mRhPi+UP24KEtxd03LWVUtuUqED9tg6oEeYjmLoe7AETXX4Tw==
X-Received: by 2002:a05:6870:f152:b0:250:6be3:3406 with SMTP id 586e51a60fabf-2506be351f0mr1768209fac.3.1717079915145;
        Thu, 30 May 2024 07:38:35 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-24ca1ff7c8esm3650660fac.22.2024.05.30.07.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 07:38:34 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Pavel Begunkov <asml.silence@gmail.com>, 
 Breno Leitao <leitao@debian.org>
Cc: leit@meta.com, io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240530142340.1248216-1-leitao@debian.org>
References: <20240530142340.1248216-1-leitao@debian.org>
Subject: Re: [PATCH] io_uring/rw: Free iovec before cleaning async data
Message-Id: <171707991426.532351.6222913434182120695.b4-ty@kernel.dk>
Date: Thu, 30 May 2024 08:38:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 30 May 2024 07:23:39 -0700, Breno Leitao wrote:
> kmemleak shows that there is a memory leak in io_uring read operation,
> where a buffer is allocated at iovec import, but never de-allocated.
> 
> The memory is allocated at io_async_rw->free_iovec, but, then
> io_async_rw is kfreed, taking the allocated memory with it. I saw this
> happening when the read operation fails with -11 (EAGAIN).
> 
> [...]

Applied, thanks!

[1/1] io_uring/rw: Free iovec before cleaning async data
      commit: e112311615a24e1618a591c73506571dc304eb8d

Best regards,
-- 
Jens Axboe




