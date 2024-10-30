Return-Path: <linux-kernel+bounces-389267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BCF9B6ABB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 18:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33C11F2622D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 17:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AB521A71B;
	Wed, 30 Oct 2024 17:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOB6Hy9Q"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E93B21A4D6
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 17:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730308263; cv=none; b=TfUVyIBeO5GJ1wGwy9hYhO2iBLKyh5Kll1WDuLE2/2t9i9/4dhiOiA//Iky/Pqr2q/eki+yFJ213wIh4paLVLfSRJdXfmYZG+AEaxeWvDcTvO0llGv9mUUw52+8IBNQxT3tgMuJEqPMVj/cVgxNZGf4OSwzogJMfDbeIQ4oIrXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730308263; c=relaxed/simple;
	bh=OndDXqKtEJ3cA9GTwb1q2oE8eowa7SIjG7xCrUy6/yc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iZwdB2luKzr+BJYVvvdtZSbhkRecJF0uBIpuiueqUYJjYm9F03/ganIhbLxmx5TqcaF8TuM8lpcbfD/pobbMZOKE56qIBOAtcMS/yNG+3wrl4GZfEIP2nDmXliEft5q8sOPBjHNOhV/z3/lxTrDcluWX10ZuKxmNUBLwz1UiLeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOB6Hy9Q; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2fb5fa911aaso97325101fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 10:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730308259; x=1730913059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pJvO6m6VfJq7jLiXQGCAJ+rgJ6VzC5FKvl/I4BvuxQc=;
        b=YOB6Hy9QRfknjVIi4jep+E2t0gX9awKWmmaBdaf0z01ocmSDNk8hsGJsWaEWY/itmC
         xLIEvb6H7a1bh5qPgtXgJ7Ea5xiUASzFQqC6K/WPqUhyWudYk2QdK6ocfqtgNWFIzKtK
         dTbUjXFIgAe85dwqg1tGPTbDTKn9Ss2qGVEMEjY5MMnH7TjkBIoRVRze92HursCC313x
         u/opqCxRyKjfSayI9n1m3pTxnj8n+YfOT2Thhw6AJYUMP4Qrw5MwJMWuOwdFIkpIwO66
         k1ZIcAPQiyMUpVcTpiB2jfL5LiBg9e3sSJPxxnDrV+sInnFpiAJUhbVdbhx2MxXDsu20
         eCHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730308259; x=1730913059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJvO6m6VfJq7jLiXQGCAJ+rgJ6VzC5FKvl/I4BvuxQc=;
        b=r+6LcCQYof7ofJnwLoSqYxm/qmriNRPTBVkos2Xp/90RDIY61W6RtsIDhO03XTQYbl
         pC2lkV5Jy5LYVRAb/uTCSweFDV/Je/2LwEy4LEbFbSM9OIorInNTD4v1rg2LkwsVlpDJ
         5lUkYBbbM/loa+j2vj+3H68KqsP9VObyjaYFnTDCgKgzSWVnJgIf/vHvf0O5GNaQFACM
         4tBiKSxKkImO8RO69nT9B62QKAc/x6QoDULz9nTVBJuSscaoMem3zqvNn+2lXPkNrTSW
         jnh9vSBfmjXyUzUvNzK29Q8663cwcqceRh46hWwnWR7ZmBcjcqXUHLKoPFPbNv1tq/C/
         Z86w==
X-Forwarded-Encrypted: i=1; AJvYcCUS4w8tqSYzW3Zlbs6j02tu1llJ1SbC6VRm4x3lRcYuyrVX2b0PsFZSoCG4X9RXotQhJ9ck/6DX+hcpPcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdSvyLp3gWMp1Powubk0izw6thfIc+7NzrknE+q1g7QQm6immK
	uhPOl6sKI8i1XUkjtU2Hv6m+dGSRGkqRoRlCVF74cPU8v99PT0ze
X-Google-Smtp-Source: AGHT+IE9t0eBimyH7UiH84hK6DgH1SFcaijILVkX0wzzcYM83S6LqN3c4d1isUuteAfU8x3BfYI/tg==
X-Received: by 2002:a05:651c:514:b0:2fb:5206:1675 with SMTP id 38308e7fff4ca-2fcbdff1ffdmr135616061fa.27.1730308258955;
        Wed, 30 Oct 2024 10:10:58 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-fbf3-0656-23c1-5ba1.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:fbf3:656:23c1:5ba1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd9a9faesm26828985e9.35.2024.10.30.10.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 10:10:58 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 30 Oct 2024 18:10:45 +0100
Subject: [PATCH 2/2] drivers: soc: atmel: use automatic cleanup for
 device_node in atmel_soc_device_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241030-soc-atmel-soc-cleanup-v1-2-32b9e0773b14@gmail.com>
References: <20241030-soc-atmel-soc-cleanup-v1-0-32b9e0773b14@gmail.com>
In-Reply-To: <20241030-soc-atmel-soc-cleanup-v1-0-32b9e0773b14@gmail.com>
To: Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730308255; l=989;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=OndDXqKtEJ3cA9GTwb1q2oE8eowa7SIjG7xCrUy6/yc=;
 b=4PSAgRDXw7LxIptekOdlnHv1UbgiZ5LgxiPU3wDfeyUAV/VockQb3gdRTkZabAt/nKdictWHL
 ZmQj0gg9UejBJkOLxrq5kpZ/MLBrGlreE1U+n05iRMIZ+vjHKy76MjC
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Switch to a more robust approach to automatically release the node when
it goes out of scope, dropping the need for explicit calls to
of_node_put().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/soc/atmel/soc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/atmel/soc.c b/drivers/soc/atmel/soc.c
index 64b1ad063073..298b542dd1c0 100644
--- a/drivers/soc/atmel/soc.c
+++ b/drivers/soc/atmel/soc.c
@@ -399,15 +399,12 @@ static const struct of_device_id at91_soc_allowed_list[] __initconst = {
 
 static int __init atmel_soc_device_init(void)
 {
-	struct device_node *np = of_find_node_by_path("/");
+	struct device_node *np __free(device_node) = of_find_node_by_path("/");
 
-	if (!of_match_node(at91_soc_allowed_list, np)) {
-		of_node_put(np);
+	if (!of_match_node(at91_soc_allowed_list, np))
 		return 0;
-	}
 
 	at91_soc_init(socs);
-	of_node_put(np);
 
 	return 0;
 }

-- 
2.43.0


