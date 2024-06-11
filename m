Return-Path: <linux-kernel+bounces-209816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB645903B3E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06241C231A9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0565F17BB34;
	Tue, 11 Jun 2024 11:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTXKZQhE"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B745317BB12
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107085; cv=none; b=bNxTMuCnR6AKzJ24+2XyqBVMh+WcUyWP7LJJSnOnEgsiKk2xhxeNmeBqb4H45c51K0+sCRFQ2LtdTMl8+PdkCwQ4rlFdIXBGuF665upWuFENrH1KE/GsZtLWMDezmJU68q8xuZtz3uXKR1N2xa+YMqexFDNKjlCdOdtnxE1/hug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107085; c=relaxed/simple;
	bh=KQOQMNe/0O2p5NcAx9Wr8YU3xBI8taSDf2dxsX8eN+U=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QWpsv4bKSzlZ/mz8F7N/Nc/fnzYU4D3DFaH4aZ0yKj3YtAghIGYWUcUwaZM4Kqj9R3/IyCElDT8JSL2W3ZbgaRqzVNAgKT9EkOfiC70Vr02qgesHiPbUej35OZUbR7GsyTYTZ/ZcCQKWY2h8wptQHnnCmsf+yuu0fjPQv30moK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LTXKZQhE; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57c61165af6so4590020a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718107082; x=1718711882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8km0fCrQgO57gFXBsXFIYcrjuKczDYZLAASbYW83aek=;
        b=LTXKZQhECbbfKv/qkZCqUXiwri9YSZmnMzOpcOcBiGAxiX//EtvEs8CaahYh4Hlavk
         NdJVYFn6ZRh0wfmkpsI6XgV/oHsQNI87gpiReGDii1AFcIfO2QLPkZTdS92ChNjXUKHU
         VbVzQ3dHKh8wgXN/OQaLpOKMxiykQBSrW+rDA5aXq7GXDxfnRe1IUBwQlc6F+73JBngb
         CMdw5KdbQU85kcTzttxuSsCrYRNZbCH2dpkjXcB7Yy2x5ZqQSXjz5Z6KMSUr0cRUJpVk
         650bUQFLGSG64x653XGcQwCzDwR6azGKRzbHW9sjY+boMPUAGvTZexbMm9avCX7Gkzle
         uNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718107082; x=1718711882;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8km0fCrQgO57gFXBsXFIYcrjuKczDYZLAASbYW83aek=;
        b=iSV0apFVEvwxJERkXNbpAVpILkDLykzJjlCUQzGqot0MKrUHbnl9FqP1Ji/D3txr9x
         q/q7GWIckXI5f6EeUVMKl85b7yggIzd6c1+MK+vMVEdEioQzS8b3t+HmG7b8gYl9gSmu
         esbyaly1MB2oXGGZrL7FvCbuzaAKd99HfiawMyyrZeGpXYGIIGtwfuZPJ8Z+mmwbwbkq
         v8u5AvWhaDgDDss1/hywsceeS03iEFd4SWBYGfwhQ+B3KH3jV39wcxjQTiXm02r3gGTC
         +E2nN/aXZZoVU01RT4MqWacS5n9sgqo1JKOaijNn9dQmqH/jv9hIzBpeL7joXx9A2hrY
         rwGw==
X-Forwarded-Encrypted: i=1; AJvYcCXdXu3RGMh8fYf8o4ANCPQVDKIKCIlC1poysbFjwQYpr4ohc4o2VUD/ZQryGF2KltIGwpH0fiL2PCuJCtLLrAvI0/2Q2nApJUtFL4R2
X-Gm-Message-State: AOJu0Yyj4c/t0tBTxsLX9ESbfJvHlcgyiu5ygqiOUQgRleVtALeHpByk
	L8O/MidD3xHriL7BlOForGpLRwdWDNjQFQvYuIQBwNvyPWT89LfATx07P14gNDE=
X-Google-Smtp-Source: AGHT+IFE/E3oXsA/j5Sw46isYeAbfSwDcm+QTBQfzlRN7+BbqOoeqoLghf4L6f7cDyPU3Yb2H/A/fA==
X-Received: by 2002:a17:906:4eca:b0:a6e:f75f:be04 with SMTP id a640c23a62f3a-a6ef75fc386mr549563966b.38.1718107082022;
        Tue, 11 Jun 2024 04:58:02 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c6aa014c1sm6226784a12.41.2024.06.11.04.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 04:58:01 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To: Amol Maheshwari <amahesh@qti.qualcomm.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@quicinc.com, kernel-janitors@vger.kernel.org
In-Reply-To: <20240603-md-misc-fastrpc-v1-1-6e6d73d08315@quicinc.com>
References: <20240603-md-misc-fastrpc-v1-1-6e6d73d08315@quicinc.com>
Subject: Re: (subset) [PATCH] misc: fastrpc: add missing
 MODULE_DESCRIPTION() macro
Message-Id: <171810708104.74168.2910983617658418174.b4-ty@linaro.org>
Date: Tue, 11 Jun 2024 12:58:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2


On Mon, 03 Jun 2024 12:58:08 -0700, Jeff Johnson wrote:
> make allmodconfig && make W=1 C=1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/misc/fastrpc.o
> 
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> 
> 

Applied, thanks!

[1/1] misc: fastrpc: add missing MODULE_DESCRIPTION() macro
      commit: 6814f03445b30f6a136ff043cb54c0a86e3de982

Best regards,
-- 
Srinivas Kandagatla <srinivas.kandagatla@linaro.org>


