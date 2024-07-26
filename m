Return-Path: <linux-kernel+bounces-263698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED9593D968
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 22:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23B381F23296
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 20:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679E51442F2;
	Fri, 26 Jul 2024 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="DbZEPssY"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF39502B1
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722024002; cv=none; b=sfv9+BWEMFY+q/K9WrnN1PsUteBd2pL3Weo4o8A8pCU3HcRALiG1CdZIiNL7VtrUPzl1Q9Qcgyrl3t4Ad7xOPT84ytTQ6BlgbEFiA0XFKSSLxn+WE1r/5mqRBxuiov4KJWi8Dsn83ILfD0p2g5t9C1lvuicM58C//Nn4bX40Kqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722024002; c=relaxed/simple;
	bh=2PQcgbWLbtXARhLwKAm+bgtTE2bCYz79iSNxQ2FSVhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L5/PZyu8RBsdvH0mLdq/HuI7uwn4Mj/Q/kbee3DyJSuMBDHRlwSLORQoaMJLJ0VcXlV2kDgurLN/gEZXfJPv7wUjLy0sITYb7WKDjhNmea4byr7JzLco2eukrhRAALoOv5hQjM4euXctQkMMF2NFH/hdcTNJnuO+rrpqFLnESiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=DbZEPssY; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-585e774fd3dso2297801a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 13:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722023999; x=1722628799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Bqzco2JjQhGyZ8/rxo6FZtwpdhib502jq1p6hVB5sM=;
        b=DbZEPssYqauWYlHUsmjaxksLjrRqRxJMxA5lTeHityTM0MACb4kNM/ea5X6i+Pa+YE
         ThAn067USIkIzIXvUWS+fR2YxxmzMhE0XJBxbVLary7DzjgmDguVt2FL+5xHtQfld54M
         311JtQo4ve6xQkms0DRumdAU0nBGnrdvMvI4tQwlWUs6/O5qr8ao0LHKgy3xndWj/2/P
         6YRIOfI+b3wdLE3kJeQJarS+gbpI1Dts9eChW8PY0mlt9dPyGbbXIzKgAujgNtjrCNSf
         DCSr1T8fDOLNCO1TeB14HP1Yq3i/zTiCaqriW1S7LKp5XbS7+79QdRTgMVcd6lyo8Akt
         nx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722023999; x=1722628799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Bqzco2JjQhGyZ8/rxo6FZtwpdhib502jq1p6hVB5sM=;
        b=BMchiwtzZywNPE1ceFSUkGm25BkB6ZC/9Jn0Vx9lNxrn2+YwffmkRGzC19dE3AFIbi
         QBHP0iAKdEmS9GtODWsbimbcN+VK/IKyCUS1DbCv8KXEI/u/W9bR6TpkMnu+rI1DT+6Y
         5GkDYMKD8t1UlC5vuOJweF3LBGuDDr1Rw54JTSGbAYxU32jUH3pMlg66RFpA6fgPOXR7
         rhhv6MNN0+GDY1YsbUsGrIIr65NyWaR1LVVJF1Sq/J3YY0vKzXhevAhbrjsoogUikXPd
         Hr0vOOtzS4ZwJtnV+ILsBg0/La+/idl18nicFHRKscmJn51+RMMv8T+xU3bK5LQt8aHb
         4BUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsficZ+G/nkDcumSi0SLMi/xAUDDSC/a4crKzx27BA15PKLgM+SJs9GWrA//+SH0/y6hDZoPaxFRA3kwC31oiFsUv2lUp7YxDzYhP1
X-Gm-Message-State: AOJu0Yw2nRxFJRY2HdYd5eVCmO1o/LQGY7yeNh2hKUFOW6hhNyG2j+Kf
	2h8YO74IkIadWyDGPP7YjFXzhN8RRCT5tIAT51QNHa4IZIcGSLsFrFuMCbpZ/Hw=
X-Google-Smtp-Source: AGHT+IElOd6Hbyj7HaimN+4QJo+h+BZ0vbB+q0ffTtcWjCu5PlF6st8XKrKRtSnxr7Yb4D2rmkfsog==
X-Received: by 2002:a17:907:1b13:b0:a7a:a33e:47b6 with SMTP id a640c23a62f3a-a7d40188f75mr31627866b.60.1722023998808;
        Fri, 26 Jul 2024 12:59:58 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a245:8609:c1c4:a4f8:94c8:31f2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad90e1esm209999166b.151.2024.07.26.12.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 12:59:58 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Markus Schneider-Pargmann <msp@baylibre.com>,
	=?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Simon Horman <horms@kernel.org>,
	Tony Lindgren <tony@atomide.com>,
	Judith Mendez <jm@ti.com>
Cc: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Linux regression tracking <regressions@leemhuis.info>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] can: m_can: Fix polling and other issues
Date: Fri, 26 Jul 2024 21:59:37 +0200
Message-ID: <20240726195944.2414812-1-msp@baylibre.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi everyone,

these are a number of fixes for m_can that fix polling mode and some
other issues that I saw while working on the code.

Any testing and review is appreciated.

It is currently based on v6.10-rc1 + a patch from Martin, mainly for
review purposes. Once next rc1 is out, I will rebase it, but it should
also apply cleanly.

Best,
Markus

Markus Schneider-Pargmann (7):
  can: m_can: Reset coalescing during suspend/resume
  can: m_can: Remove coalesing disable in isr during suspend
  can: m_can: Remove m_can_rx_peripheral indirection
  can: m_can: Do not cancel timer from within timer
  can: m_can: disable_all_interrupts, not clear active_interrupts
  can: m_can: Reset cached active_interrupts on start
  can: m_can: Limit coalescing to peripheral instances

 drivers/net/can/m_can/m_can.c | 112 ++++++++++++++++++++--------------
 1 file changed, 67 insertions(+), 45 deletions(-)

-- 
2.45.2


