Return-Path: <linux-kernel+bounces-446908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B8D9F2AD1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 08:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65FDE161C8F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 07:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774FB1D279C;
	Mon, 16 Dec 2024 07:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="YpEKWB77"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0301B87F9
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734333610; cv=none; b=eQ3NRfy/w8QZo2oA3uI0GbBGLxWjQXql4X9RR25gWlTUz606PlZiz+/yCNgDsQHpQOfsXG6kwamYcvnYPMQSf1YkRBL0d4IvQ22hAONEMt2xhtfMV/YH60BSnAZwP5zzAHb3v138W7zwgGgH/Md2ble9vyeoF/5EwU3j7aPoLWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734333610; c=relaxed/simple;
	bh=7H+b53eqi9DiOlmG0r4AJgg7nxrSVI5qv94MdpvGEik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kHAGWVFoeZjTsSvB5vcdA6nEOyguehkuYh8bYNCmWQrYG4eRdNqeiyQsQYem9YhmHxedBL2ERo+ixpPUcTB+uYbD/K0yP2nt/OT5dRJEPFTisujmZvBBr0fVV4qtpQwzWxguHrit3unwoNseQdt2iLOKFdyz5dfLhRngUQpqyFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=YpEKWB77; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-540218726d5so3990576e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2024 23:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1734333607; x=1734938407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A37fHc27Oue7tYt3kSCSnf+lK1Jrrg8n8kixoTW3puQ=;
        b=YpEKWB77gdtab48SF5Al3qjMsTEvgHwzYWUbj9SnB6h1TyqQKIxd+mcUPG6lVc1PIK
         OSh8ivpuIz3ae9rHDRzGy1Qjg3le4lx3x+fyVmaNZLsdN8GtI0/zcgzBYjAwDuKVebkB
         y/lu8Zulb/tpSz/+K4lc8oAfMrB6lTD3S0qiFj+68BnAGkgkuXcTeYS33lXGoRJGwm8Z
         T8rhgIuAYfBhe/F/7iUC4Qur5tFIRIJM49DmEF6goUDX0T2AFXJmWmHHuW4Wlreihqc9
         xKqq3rWfZqzRGlwFewhMKbfwh3u00urxAXLqnQ4kc19C1EgkI3z5vnrHo3KPmAwdoN8G
         yK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734333607; x=1734938407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A37fHc27Oue7tYt3kSCSnf+lK1Jrrg8n8kixoTW3puQ=;
        b=ivJrmlbybB3OcJjJX6sX4clsniunA+MYDrc8swvhade2vPibJGbpX4msB6vbEn43Cm
         Vibazr1HZkIrauFyEgomFQ03IhyYb68wVduw9uhGQ7TsQPhSHanKY6PVVm48VXCeUUMz
         p3Zdb1I3OAmvhsKoiwdyjpKjKOP1bDnP9Aory+eJ7jkoiW0I9jZwoIfd47FpLTsjye6g
         yY4uq58RTxsJaw2xt2Ze0/tVF6LgiZUfyorutBDO7MCMw6W/gP5XBEAJB9etsLDqirNo
         3x4EOJCKpXFbMgHu5z+mW9WkQmjYr1rip/C9USs0tKe3Nox0WHAJ6xMfA/thZ74td++N
         Rhzw==
X-Forwarded-Encrypted: i=1; AJvYcCUowHVIwMLjIXpypNEfBBqSnmPcNpZRV2KrsJ3drJO/EThOP+2inuy4k/4xCc2VyEppcM5aT2fY0KKxH68=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFXE4u0aX0N2rk71kd72Vy3g74LpE/u3/Wb7W07b38fyG5ZETq
	qdhwV2WmjJ3ZiicMZpsC75KUXEB/4A++h2wTuB/2b+7Xi3SOuRdhANhEqqwVHPg=
X-Gm-Gg: ASbGncvsFhIopE12M6KYBrd7fuwjLJ+DQTA8UjrzwGhxxk1YW08MAVCAcMViNzjtcQ7
	BCa0LRRu5kIo8sCD2GvN8O5mVTjhBItyJD/dpbpe2Vra17+ID6pB6WDkA1EnyJA6aksxZzZYsH9
	i4wvrMWRDswxIZXXWqaQc0HlhO+nKry04I0htBszreRNvKapSq3Yr1awBqNnyvO6xSZxUZ9mPX6
	wG0gC+j+xuAAOIvE0SN6iVBeR4OFlRM/Sqv2fDviFEaX8rR/zO4I4Jw3RbavN3ArIC8Y8I=
X-Google-Smtp-Source: AGHT+IFZevgraoAzerxr2hEHYj5Vn6YWN6RGjMC+XJAc2rFLiXryY0wNygBr6mROD0KIKhDpCjOFXA==
X-Received: by 2002:a05:6512:33d6:b0:540:1c18:4e23 with SMTP id 2adb3069b0e04-54099b6d6f9mr3446396e87.47.1734333607243;
        Sun, 15 Dec 2024 23:20:07 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120ba9b2bsm748930e87.94.2024.12.15.23.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 23:20:07 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net-next v2 1/5] net: renesas: rswitch: do not write to MPSM register at init time
Date: Mon, 16 Dec 2024 12:19:53 +0500
Message-Id: <20241216071957.2587354-2-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241216071957.2587354-1-nikita.yoush@cogentembedded.com>
References: <20241216071957.2587354-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPSM register is used to execute mdio bus transactions.
There is no need to initialize it early.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 5fc8c94d1e4b..12efee9f75d8 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1166,7 +1166,6 @@ static void rswitch_etha_enable_mii(struct rswitch_etha *etha)
 {
 	rswitch_modify(etha->addr, MPIC, MPIC_PSMCS_MASK | MPIC_PSMHT_MASK,
 		       MPIC_PSMCS(etha->psmcs) | MPIC_PSMHT(0x06));
-	rswitch_modify(etha->addr, MPSM, 0, MPSM_MFF_C45);
 }
 
 static int rswitch_etha_hw_init(struct rswitch_etha *etha, const u8 *mac)
-- 
2.39.5


