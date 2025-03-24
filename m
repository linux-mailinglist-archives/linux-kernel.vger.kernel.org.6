Return-Path: <linux-kernel+bounces-574536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58337A6E685
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 23:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C08E0173C64
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BF81EF0A3;
	Mon, 24 Mar 2025 22:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aut9WMNE"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CB71EF0A1;
	Mon, 24 Mar 2025 22:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742855234; cv=none; b=dQPEZ/PK/WD1JaUGDnNncpt9YSwK2Tqbbb1W6fVUeTezrcSfDBjbWdWk/ndH+TOQaRkAkxt0ovPb9tawzxWCqrTFnfaEC/+Ygs++3z/YLnp0yphOHQnnJE/Mpj7h0L6gIxS/PmP3FPHmAIJdyh6540nuu3WkrM74Hum05mxZaMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742855234; c=relaxed/simple;
	bh=0784U3cbzfDcMcUwJ1Z2FQiUKNAzW+0ZEUrprBOOBGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V4BFlJdORYFduVc2ttaUIMjEH/yDR7/cOBfOjIS4AMX6LF5rcpRACQPv5r2qgGVLt/PVxQd5VA5IRPhtdV5CRquJhF7y0f7dO8eZSS/taWzfmkYD13wfF54+vLMCYHPdAynAJ+uXUHR6+4H/Vys26f+jrP+LFR4w79jxgqC/z90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aut9WMNE; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30c416cdcc0so52039181fa.2;
        Mon, 24 Mar 2025 15:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742855229; x=1743460029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NAzfk87iezM32PqLJdjws8zIT6/Uji+J3cNW8Av6kTo=;
        b=aut9WMNEXp4y5HmLr9IBh2tBNC6NeZLz/ZXTDYHeQou/sAAvi63etxhCDbZOcCAnNX
         5Nq87kexauT1YMRCD3KQeFBYfjmtayNs9btVR1dtGKATb3lyNYLUEO9drtOFIQMowQTD
         I79vC5SrXd/Oj5YxU17TPms4bR2lpyL6O8OHfXp2/7QB0MURyhWe2IjVQR7yU+vE3aPT
         XBdHSoepWaVb8MP2YD1SrRJYFijKO+44cX1Odzb+dz3HdlqSe+VbRwz8FIYAXA5/JGI/
         BZLaspOxzQwlIHGNH85yZBZuEH4wBnREoiLUbwZk3XDqK80p4IaMuWrfVOxK41tu4e23
         w0JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742855229; x=1743460029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAzfk87iezM32PqLJdjws8zIT6/Uji+J3cNW8Av6kTo=;
        b=BW7YQMvMnF+pKyByHdpDBoxtUjtOSZ3KYs/cb//PiHjLmqNKig90Lb3KrWuWiYdzJm
         5fzc4QQEppdGz1axMUxoBttYqOZjRQ3X8SSpz3SDFLmoMfu53h5Wm8V6szekromiHbTR
         cVQEfTMZyf6oosPYII0gbQcVrV3Dbz+DURCBSmQacRA4TBpb1HO/KJcQJKtGN3GH9oMy
         MCUlBFEwge3SgMSLyYyp/vFrAryg8oBPZU9G8BcPJMU73xySzYMv0UsRT3VoxCHWCzeC
         AUTAQHx0E9H+7Ex3Bt7/8fJmiTid3LN6OFqE28vCbXmn2vuwDAfcNjE9bVni6MiThEvv
         dMAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdiqUia6jyNz9uwB41I/fXwDKgVjD5Tm4lmt8WgXAvIrey6QTMsDNO1/1JFEOvxcBeYkNaCm0RQawxMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwArfSGtRWfm1n/A9Wtx/yNPbZjoKIIfTbnZroCjpWNtvxiefT6
	oco7Ef+XW033L0vGOkdDylsEL1RuLNRAk5liFpxSegLQ9PaRXSUvO1REZ+2iuYs=
X-Gm-Gg: ASbGncuyPuUWpjAl3MOaR5gWY0rKSzM/MF9eg7/3JuKioC1VFhLOj+L7T342VdQE3bh
	o7STvUe0FciYL5FdHyaoWbyZlbJJJk88ac9teLXTiNMKWCEjCsLiGaVY6a3HWus9iLF+rmnlpIx
	jcI5IR0EcIZyj3B7QPlPd2vRM8bWHAFJdB4HufGZ7KaQLtAokvbHAvNTkBqJzp0mDPM+2NNQm0M
	ExEAk6swB8YXXyyyjPfn1RpxzKDyYLPDoc4XOS5lyk0t0SXTi9JMpItNl6C8boxrfmIZ1ztm6sw
	xQ7EPIIYYpvKAAkF+bNv2bH1uVEkyC1iFXb+IbVpV3PoG0TepAdaBHlMx5XuyE5KexAazga/Bna
	EvkFTxwuwCfMm1wHKcL4YQRqV+Dfp/Ft8
X-Google-Smtp-Source: AGHT+IE93FrFHpuUhZykoibhWy3bZ0e8Cd/1RbrmOT8R9DBtTL5kf6ciTVT616fkVohc/whsiTMNuQ==
X-Received: by 2002:a05:651c:50a:b0:30d:69cd:ddcf with SMTP id 38308e7fff4ca-30d7e0c652dmr55664341fa.0.1742855228935;
        Mon, 24 Mar 2025 15:27:08 -0700 (PDT)
Received: from buildhost.darklands.se (h-94-254-104-176.A469.priv.bahnhof.se. [94.254.104.176])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30d7d7fe8b9sm15860611fa.58.2025.03.24.15.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 15:27:08 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org
Cc: richard.henderson@linaro.org,
	mattst88@gmail.com,
	arnd@arndb.de,
	paulmck@kernel.org,
	glaubitz@physik.fu-berlin.de,
	macro@redhat.com,
	mcree@orcon.net.nz,
	ink@unseen.parts,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 1/7] alpha: machine check handler for tsunami
Date: Mon, 24 Mar 2025 23:21:33 +0100
Message-ID: <20250324222643.32085-2-linmag7@gmail.com>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250324222643.32085-1-linmag7@gmail.com>
References: <20250324222643.32085-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add err_ev6 err_tsunami obj files for CONFIG_ALPHA_TSUNAMI in Makefile.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/kernel/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/alpha/kernel/Makefile b/arch/alpha/kernel/Makefile
index b6c862dff1f6..34c75e76ced4 100644
--- a/arch/alpha/kernel/Makefile
+++ b/arch/alpha/kernel/Makefile
@@ -54,7 +54,7 @@ obj-$(CONFIG_ALPHA_MARVEL)	+= core_marvel.o gct.o
 obj-$(CONFIG_ALPHA_MCPCIA)	+= core_mcpcia.o
 obj-$(CONFIG_ALPHA_POLARIS)	+= core_polaris.o
 obj-$(CONFIG_ALPHA_T2)		+= core_t2.o
-obj-$(CONFIG_ALPHA_TSUNAMI)	+= core_tsunami.o
+obj-$(CONFIG_ALPHA_TSUNAMI)	+= core_tsunami.o err_ev6.o err_tsunami.o
 obj-$(CONFIG_ALPHA_TITAN)	+= core_titan.o
 obj-$(CONFIG_ALPHA_WILDFIRE)	+= core_wildfire.o
 
-- 
2.45.3


