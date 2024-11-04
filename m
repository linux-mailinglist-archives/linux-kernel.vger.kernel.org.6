Return-Path: <linux-kernel+bounces-394871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E509BB528
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3504B23709
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB3F1B81DC;
	Mon,  4 Nov 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="F+PLu82O"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015881AF4F6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724931; cv=none; b=eb81mqarqwPwLG0kjJDXgKO3xP1bD/Z++x1vXVcVcqRTdc9f6qL4X/CGKFipWDXhi+3/Sc4VxCB3Y5PVGDvwbCtgfZ8PAGEoa76PT6Ef8pwPs15+3vIpNE4nr6PMAYHJaJb3VxfLjSDRIT9nbOdRZhON0FY4YTLIGifxFyrbGCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724931; c=relaxed/simple;
	bh=wMQqOv2i9jpSD1GCk+gH/LpMZLCzxoID0qLFQkTCEzk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=MCPGi62YDqlt1ZsY+xEmm7JW3YusVqU8VbrxBDZUM62EMR/9xS2THlr4cfi/5htl3Xm8zzTRyJrPTBB92gTjNxXrM0p5ExPB2+epqiZEl8Ss3VwOISN0IYr0K5HhUJ5axBGTFaHYnGrXo6wdZ4tNh+ZQs7r6e1OdEWt1xeLdByA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=F+PLu82O; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2b9480617so3251925a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 04:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730724929; x=1731329729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUT2MUhoOe9iu2p2kd8BI2aLF+LB/mKyYJdsiPsn1AE=;
        b=F+PLu82OP47bO09itx5AP22edIU1Pni/VSHyOAmh4lTu7XJI2KA/KVrR+qzouMlhtf
         TESqMGIPmox/7IZ+0H9Nv/dJ1du6MOQ/4PlGIx08H8t9zFyFC9MAqztfFj83TwAn+LYD
         cbi5pFnCqpkBNka4xVN3pJ5gslmF7bMkXtjTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730724929; x=1731329729;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUT2MUhoOe9iu2p2kd8BI2aLF+LB/mKyYJdsiPsn1AE=;
        b=TR6coFAzHdTllizKeDp5RQbg38aawefc2yYN0+X3wjnBj1xcAkC+WkhPz6LCaZMLmq
         EV6Cie6AIp1w9wbFr1mVd/Y/oVsHyzOur0l478nfYu48moe4mvNzpZkbd+3x5dH2VnMV
         ImbvVr/BaisYV+c2PLNF6uk5zcypvumFZlPMXby9dzH/tHAOBrZRaSkM2nPIKrnPvGNo
         9NpR2zX9okL5KR93kmRiJ8z8NhFGEmpjWtfbu4qpYfIt8DuXJv11t97DcOVhi3dVVoG0
         lobEly6FmndVYrIbVO0G5/fDunGwqsYDK7NgiSWxkjxqts7EMgxJ+lYEfTlj8an2R61X
         C2gA==
X-Forwarded-Encrypted: i=1; AJvYcCU0bI7gPoU4kGZSS3jVmjUOzxiA0gINmUMxf5YWxQEJN74pJPBiZbR1sq3PsWY41N1KQVd9ol8JpXii1UM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO1YEy1Xjd1SUCJy4oj/2t2MJnXOihZ6RruU5hKGvnwBlz+ljs
	zTA+9HEosT72FM3DOSAIrH9OJduwSGBhi+fG0+CVIOtfm2wT6iPNfSCnX2SKiw==
X-Google-Smtp-Source: AGHT+IGw2My2dH4dIXYJt5UAfh9QheTuaxvz/yW07aa/c8zRoSfhpBhW/1Yv0E1txryL8w9UJYPxAg==
X-Received: by 2002:a17:90b:250a:b0:2e9:5e21:24f7 with SMTP id 98e67ed59e1d1-2e95e21257cmr10927134a91.38.1730724929339;
        Mon, 04 Nov 2024 04:55:29 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:f5f8:ffa1:d9e0:6eab])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93daacb4dsm7534611a91.24.2024.11.04.04.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 04:55:28 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 stable@vger.kernel.org
In-Reply-To: <20241029095411.657616-1-wenst@chromium.org>
References: <20241029095411.657616-1-wenst@chromium.org>
Subject: Re: [PATCH] drm/bridge: it6505: Fix inverted reset polarity
Message-Id: <173072492636.262894.11094550143215575349.b4-ty@chromium.org>
Date: Mon, 04 Nov 2024 20:55:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0


On Tue, 29 Oct 2024 17:54:10 +0800, Chen-Yu Tsai wrote:
> The IT6505 bridge chip has a active low reset line. Since it is a
> "reset" and not an "enable" line, the GPIO should be asserted to
> put it in reset and deasserted to bring it out of reset during
> the power on sequence.
> 
> The polarity was inverted when the driver was first introduced, likely
> because the device family that was targeted had an inverting level
> shifter on the reset line.
> 
> [...]

Applied, thanks!

[1/1] drm/bridge: it6505: Fix inverted reset polarity
      commit: c5f3f21728b069412e8072b8b1d0a3d9d3ab0265

Best regards,
-- 
Chen-Yu Tsai <wenst@chromium.org>


