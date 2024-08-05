Return-Path: <linux-kernel+bounces-275105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A45DA9480A8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E87D28196A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1549515ECF2;
	Mon,  5 Aug 2024 17:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="SzF1IOR4"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A34253E22
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879928; cv=none; b=Ues5JloxAPTFl38zEUQ3a4MWVaNxIZvVqhh85mu1LRXgn1D9F/5J471wmRbDYM5Hhzw+p1/tZe2Dt+R6IJmbmVS+rIoIKOthZPphC1dGZseVS2edFT6/roDPqyRhx2+HO7xea+zgCCbR3K+RTT9e24Z9We5PYv9DqNiattiGe3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879928; c=relaxed/simple;
	bh=Uaxu0Fd3qGZpGrDLqe+EQaH1BhuffTJKALpVCVhB7gM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MQlG61ckQUFHAjqFT/9w/U3XcPRcoJis74TMtcQORQFJxR244q1+0WbZbwby9CAGJnTTQUw8sixNJ5533ozkK1khhnD34xjYfqNaz1wBwIMxmQwPNj54vE6KnEp7tlXK5bAzJrLMYgT4DuJRRKG9bNoocxpBA7Mep7zNveTOweE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=SzF1IOR4; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2cd48ad7f0dso8262051a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722879926; x=1723484726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x5RzMw3ZUuWLDwmLaXVM1ORpqGRrPuwXY8qwQ1cAdMA=;
        b=SzF1IOR4nZGObNA2HtShXo672GU2KvDLmR41zuDJW+ZHApAW3VlLzZqwTkeDxyWp6n
         XVgpMyCK3BqTrjk/3hLvFM0tsLOOxR5c1nsrroV1TR4uCWW9raH5wZghc9hWBoYsYalf
         9j5K5ZpWXr7uiXCb/RdKn0SdkENsUgUOcJA6HgD4Q5/Dp40YknFVK5vbILLH9NsUu9UY
         vXK2jl7nva0cbhGp01EeH64RxitYnZyDy28UadWFg7gUe3mzc8kRs7f8+j8S0Y87VyVv
         +JuWYzv8PAYW4Vb2G3Xb2LiAQ7hekw/YPUwP1oG8qWBriecdxNLgHsl1d/bZkWzeV6Y0
         TT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722879926; x=1723484726;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x5RzMw3ZUuWLDwmLaXVM1ORpqGRrPuwXY8qwQ1cAdMA=;
        b=UK0M7+bXlwRAu8tc+0wcB6SEiybNBzRf9Rk5yuezgTzpIMkUMoTrYQGmz+9CFAeaxi
         wnvBTL0lp4HEheennp6JNWwg+7CNgaCQUIsTe/sVb4r1a7TJTBNglRfzASyHEgiQ89j2
         /TxrwwVL/PnI+GwmB/EdEaZfOeAFscpxCqhPCjdgSqJgBbhfnnKCH7iykBXuYIv8mrS2
         2WvtEiDCU6t9dCOqZIYp8iIsQCkW806isjPCaZqcauFIYLCfXkA0L5AmRNrzF1Ch2TW+
         4ktjyl4qPa0j2j341b7WHa+S74D9M0kaAgXel+PailT2s+on0V8SFqv8tnD8Work+Imm
         mr2A==
X-Forwarded-Encrypted: i=1; AJvYcCWcEP7eXopE9jWKEtFy6eO6sbkGGVfRUioPkX5/eS0UrNwRytYeJzQ/CtgKPBK5FFLBvySjs+BGdSdjrKXk1z/E+ySEoxY92kjH+CM4
X-Gm-Message-State: AOJu0Ywy7PQ2IboNQw+K3RI6Nbdvin9VYhws0ZvVN4YM4NyRrrxNjFh8
	tYdKnTqwNPo36KXbGazhCNU7+CANJduIx98RWY0PZ9Eo9NXaHDZeewEGNQA4w1A=
X-Google-Smtp-Source: AGHT+IHTM1/ezbIZBE2uR35RCwAwDmp5iDZNt+OTvJsP/ECyALo6612uOaNAwDpBtjvT0Rz57eu4YA==
X-Received: by 2002:a17:90a:bf14:b0:2c9:758b:a278 with SMTP id 98e67ed59e1d1-2cff957d120mr15400044a91.35.1722879925901;
        Mon, 05 Aug 2024 10:45:25 -0700 (PDT)
Received: from localhost ([71.212.170.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc45b3f0sm10836812a91.26.2024.08.05.10.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:45:25 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>, 
 Andreas Kemnade <andreas@kemnade.info>, Roger Quadros <rogerq@kernel.org>, 
 Dhruva Gole <d-gole@ti.com>
Cc: vigneshr@ti.com, linux-omap@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240805101118.427133-1-d-gole@ti.com>
References: <20240805101118.427133-1-d-gole@ti.com>
Subject: Re: [PATCH] bus: ti-sysc: Remove excess struct member
 'disable_on_idle' description
Message-Id: <172287992528.309299.6174838584531179104.b4-ty@baylibre.com>
Date: Mon, 05 Aug 2024 10:45:25 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.1


On Mon, 05 Aug 2024 15:41:18 +0530, Dhruva Gole wrote:
> When built with W=1, the driver throws the following warning:
> 
> ../drivers/bus/ti-sysc.c:169: warning: Excess struct member
> 'disable_on_idle' description in 'sysc'
> 
> Fix it by removing the excess description.
> 
> [...]

Applied, thanks!

[1/1] bus: ti-sysc: Remove excess struct member 'disable_on_idle' description
      commit: a80a3d92dc600fed760edb8a633ea80712faaf98

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>


