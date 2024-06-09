Return-Path: <linux-kernel+bounces-207497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB5F901811
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 22:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71901F2134A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 20:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C4B4D599;
	Sun,  9 Jun 2024 20:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CYdW4E5z"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B304C1E492
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 20:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717963586; cv=none; b=tdikJVlH0QOo6ctNy3maRbA5AFFvRygvKrsAgz0YrfZAZV3EgeN+3UkQs+tOfOMBLgs3NFuvT0Gx/gr/x6deBFVnitD63tl1YHtV+DeAJ7uctP2vlVZmJRsRd6WXaiGeme5jpdRU/8Axebp4x7O2A3qVBOmWRNa6rXhF+DmW1fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717963586; c=relaxed/simple;
	bh=Y2g3hBH20Ez6tjr+gS+RmV88OyRJw9ykCZUclisL2Gw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ek29BWBPclhUU0HjBcCDWikC/+kntaSgO/Uy0R7fiUyh+lPs/nY+5HTPqqFkXfVhQzMjHH3r5xV7iaKBVFNKoSdroN8kCGC+kpjAcEMLTsidlNdjRDd1w5Cv7Ci89DcpXUO3HzrU3zgpwS+UUIhFNIBlt2yCNy02gRUvATTIwAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=CYdW4E5z; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b53bb4bebaso2002825eaf.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 13:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1717963584; x=1718568384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zH1+NlAL7sGBrxSanA/FtA/g7DCFzhSaqjwGlIqeYk=;
        b=CYdW4E5zxWh5IWcXejzYoEslcvehPyPu5TRnvnKy2LuGE6XhQFy2s62bOjtxRoQRoe
         bWkYlHamm1eLwTb/YnXWn9Cb/GOwagOkO+rp7DaEG3l/NfbBCqck6r2T1CvuIIK1oSa7
         nxW9DKzma1i19RDENg3xJngRmnmC6ASxLKrC5/VBEQ3CEgit4RKsyhS8YNgqcJCOzyRQ
         mQiz4f+hX2YtHRotGqhKshiux+yDbXmImxDVZpJR4N1wQ5wGoPv7ctRGLXWu6ujY995a
         Ee+JiecsSNE73od4mPgGCLW43zYJGnKXQdAXgsetCY1G48N9C2ubmc+5Bzbdww3QOlo+
         E5JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717963584; x=1718568384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zH1+NlAL7sGBrxSanA/FtA/g7DCFzhSaqjwGlIqeYk=;
        b=gE00eCYDiujVeJ6Qsiy2mJsKxqjAumXDrvPwRQFuArb8smEKgkd8NKTfYkPudSyag6
         4d38lIeFoyKPhRDpe4RJgssd8K2/ZgQD1lXuLp5suKhapgwEw1YT4mFA+yQRqrhOiPuA
         XIM2Y51HhhVw1DDeWwuUz9jAxHcl+ZIqha6yusL/lh1V4jyQyFoI7abE27Mf58YmIFmg
         y/l4w8W1VQllZeArSKraOrRwsNDpP/f4IsB+mbqQKJrB8QrJnNSdDftpL3eP8pecE3T0
         vmRpI5iceg1AtBRcLcWZORO4TZcxHpd1PTEsaJvSpvyCXJoQe8XlIrtanvGEXX/AgVh6
         U/bQ==
X-Forwarded-Encrypted: i=1; AJvYcCVq3YY7ihhsY0oGxQYWavO6plz6hj3UOwOKHbaYLCn0UrgedUf9R3bChX/pwMe9BVLseUVvl1g8X4SUf2sMB5yTahUOQQhil0yZso3Q
X-Gm-Message-State: AOJu0YzhlE6+4P19mFckXC00oAU1ER83VlqDGaZN1WG/sbCs7HA3bD6g
	G0V12OjG+cziqGtRWiRs3KHv3o51nAMYdJPwbHbYy6vOFllkIb1mWrLaUBvqBhI=
X-Google-Smtp-Source: AGHT+IEXyblMhCU92LHpLi9n5C30rLt+Oo3AAw9gr5DqMdj5QvfaoFkMH+K9Ls0kXQ5UXrqpIjKi2Q==
X-Received: by 2002:a05:6820:1691:b0:5b9:f2f4:6a95 with SMTP id 006d021491bc7-5baae76ba19mr7502787eaf.5.1717963583757;
        Sun, 09 Jun 2024 13:06:23 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5ba977e121bsm1413278eaf.28.2024.06.09.13.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 13:06:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: William Breathitt Gray <wbg@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Judith Mendez <jm@ti.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] counter: ti-eqep: remove unused struct member
Date: Sun,  9 Jun 2024 15:06:15 -0500
Message-ID: <20240609-ti-eqep-cleanup-v1-1-9d67939c763a@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240609-ti-eqep-cleanup-v1-0-9d67939c763a@baylibre.com>
References: <20240609-ti-eqep-cleanup-v1-0-9d67939c763a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

Since commit 8817c2d03a85 ("counter: ti-eqep: Convert to counter_priv()
wrapper") the counter field in struct ti_eqep_cnt is not used anymore.
Remove it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/counter/ti-eqep.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
index 072b11fd6b32..30c35b6c6050 100644
--- a/drivers/counter/ti-eqep.c
+++ b/drivers/counter/ti-eqep.c
@@ -82,7 +82,6 @@ enum ti_eqep_count_func {
 };
 
 struct ti_eqep_cnt {
-	struct counter_device counter;
 	struct regmap *regmap32;
 	struct regmap *regmap16;
 };

-- 
2.45.2


