Return-Path: <linux-kernel+bounces-511635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C9FA32D8A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 18:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9FB73A8113
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 17:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B466725B69A;
	Wed, 12 Feb 2025 17:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zGx4OI/Z"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6727025A352
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 17:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381599; cv=none; b=RRhqcayODM+AGRRI9gvVvcL3mIf/uU/p+AJRWEw0ibKtv+ApHklFopRfjCwHFZeY8bNDdZSjrIhdmvJc5vokpH3kGgkgzpwvyQJpbl/k8/E9KY3EsJXe5XQ8A1xLjkQQZt+wGpsct+Po8HaK3UNKw8EdLOo6aTqddAYBDwJUSdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381599; c=relaxed/simple;
	bh=B1g6AzazRCgkIqFxO7X73LKacsa7eOHkEAE6UH19rcs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ear9qL/k8g1zLRBhEDNtyIo1cPnCxFxpZ6wP+VXv/714VTJSUNKHfA5J6L7mILCn4tV2hkkR+MaKoWBX8wPTH5IbKhvem0kN0ilKeltb14ZpeW5Ls0U/KshQbuCrxFdiK/9FC/dI3pL9iuuW4UfG5DmnI3F709EHaaxj1ZtR+KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zGx4OI/Z; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-726f1de8190so370189a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1739381596; x=1739986396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NuXBu5wQZcfkE1eIt6Hp4PI/AP72eaH4UoRf+T/2qfs=;
        b=zGx4OI/Z1FgwQBL0t7UdpfQSR/F+Q9iAC8wl5982sTFpsVo4lHzzj+N2ENNwuddcE6
         Sxa+GdKTfRGrSVDHZGOXncAtbQk7ezJkQY34YoP13brpJKbCQnOH97cQsURDPix6T28J
         dtas0JDJid1kxdd7LyhHKtOnONYMCS9U1PFtZM5+l/suENkAX9HrikMFogkQUa034kTE
         R+3Y120PwmsY6J8sAhLTUodJYY7f1HEn/wdTkS8DK4p+js+Gz8lAxxA1xXQ+GqDwSax/
         3JuEDmiavWvr2MLtjto85fQG47myCfFFEJqtzjNFGUIxNuDdeVGZGaeEO70hQKSy2mqf
         EaWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739381596; x=1739986396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NuXBu5wQZcfkE1eIt6Hp4PI/AP72eaH4UoRf+T/2qfs=;
        b=EIIa0z0xZn3v92jUeKIwHhuJiK9pEZlnb/lah6wvq6nKuPCE3ibPif2Dno4Uj3IWXC
         dWoJ2c/4f0y4eIOJLTKhHRL7x+JKN5xCkBG5WKL7c4UZuUUH3cLxZa1rPcru+CPGZr0m
         gmzQv107Aqu0cAr9J2mG9RPrBCJtevBlPKx6urOekTJhj6hrDeXtPk4wYAXehXPWXEiv
         lBmiJkVSC2zzAZ6QwfAIn9JhGtheV8nfSsLhI7Dqxcp9LH/m5mQ8dBumUuNdvSrwJyDR
         71W0vHJDT46R34Xm8e4X7kNEbfxFQ9LmTlIbVLWEy3OHLdvnITXTX06AsiSnrDcogGl/
         bIyg==
X-Forwarded-Encrypted: i=1; AJvYcCXZwnAuocwtGo3CLbfC86czyRfRiixPcMBvMDzykG/8IdygID9XoQvcpmPyXR3iUKtBYyyNIC+dIanEaJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz1ZW4PbFunipIjTZsPlqc+qqBNPzhMzDfsdLyalAYIM3APEHS
	Hve9CNGtPRosPiWzUpfZowO7SQVf6a4Dd1t5HmJ3yyYv3M6jo1TpiYUlRgYUT60=
X-Gm-Gg: ASbGncv7s0vyjMfHWLKR1v933fCTPL4h/6FLMelYlYwHwpe6xGRH1PGF9FJtFOLDYfh
	TAwgXBYv7YHfZPC2JCDCAsjQtj7s8Oh1YRBgKT/mfFgJwTWcxb8l9ZfQZPVH6tjK6g1nvN8sPz6
	oDzguNgGDw+K7lZP0BHdS3dllCzs3ZH/ZI4UePZKh4xs+Jgc2e/RDcYlqKkbxsxDSuRcQ7aIzte
	F2raJ/TOiT34ZWIYwhkjJd3kRyM4M8Qfwek3lKc0i004jkQc745cVQK54PeVyP+qAU3xpeHH5O6
	Ow+Fo8ZfxvSi46FYvr6CF4Xed54YyzUorcMjz5tqF6S/VGk=
X-Google-Smtp-Source: AGHT+IH8B4NGBtMmhRiQ/vHuU01a+cpa5l0bWXWrrnKprXX9WGO+UMNPvz2PpfCZT42cv1JFIcN2Dg==
X-Received: by 2002:a05:6830:448e:b0:726:f0e5:1fc7 with SMTP id 46e09a7af769-726fe7d8ea9mr97957a34.20.1739381596186;
        Wed, 12 Feb 2025 09:33:16 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af9343c2sm4720190a34.20.2025.02.12.09.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:33:15 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 12 Feb 2025 11:33:12 -0600
Subject: [PATCH 1/2] spi: fix missing offload_flags doc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-spi-offload-fixes-v1-1-e192c69e3bb3@baylibre.com>
References: <20250212-spi-offload-fixes-v1-0-e192c69e3bb3@baylibre.com>
In-Reply-To: <20250212-spi-offload-fixes-v1-0-e192c69e3bb3@baylibre.com>
To: Mark Brown <broonie@kernel.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Nuno Sa <nuno.sa@analog.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>, 
 Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: b4 0.14.2

Add offload_flags to the documentation comment for struct spi_transfer.
This was missed when adding the field.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20250212154356.784944ea@canb.auug.org.au/
Fixes: 700a281905f2 ("spi: add offload TX/RX streaming APIs")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/spi/spi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4c087009cf974595f23036b1b7a030a45913420c..8d5c7da39c855ea35ff37cef4fddbeccb9a9388e 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -973,6 +973,8 @@ struct spi_res {
  * @rx_sg_mapped: If true, the @rx_sg is mapped for DMA
  * @tx_sg: Scatterlist for transmit, currently not for client use
  * @rx_sg: Scatterlist for receive, currently not for client use
+ * @offload_flags: Flags that are only applicable to specialized SPI offload
+ *	transfers. See %SPI_OFFLOAD_XFER_* in spi-offload.h.
  * @ptp_sts_word_pre: The word (subject to bits_per_word semantics) offset
  *	within @tx_buf for which the SPI device is requesting that the time
  *	snapshot for this transfer begins. Upon completing the SPI transfer,

-- 
2.43.0


