Return-Path: <linux-kernel+bounces-324086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 310CD9747C4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 03:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF4061F27498
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 01:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2718A2032A;
	Wed, 11 Sep 2024 01:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yb4PSMdS"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C856161
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 01:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726018139; cv=none; b=N7TpqcJm0QModUKEQvdt6xUd4LQ6SeYyPS2x57LuQKzX2hkT3wDmlAP9LHlEtwLdRybxZf/C1OA8TEUq+sBKCfKEHXt3LdO+byArGUxBcOajEQU+yAvzoZFZ3+2LD5jpmvCno0vX7lSc1hvpKe26W7S1prg+zPWNK3mASKN0j8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726018139; c=relaxed/simple;
	bh=TtkmYfNRbMNOR7fvzuyT9Xv/6fHRT+Wh0XJEoff/I2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pm61D8JslsHtbi3e9gnU7kCLI3a/IP8x9qp+YuPUdp95CmPIOp2EPPzkFDR6eZu2qPWHZyptUHu+LZ6WSEN5NERVf4Q9rDVpa/1fTGmWkZRXztDJdD6naRqEhjDjLweeCVuzdkkW1Oc+E45/8tRX99CQVxSBX3rHaSKcoLOhNi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yb4PSMdS; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-39f4827a07aso25513205ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 18:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726018136; x=1726622936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ka8v+nuFAA0Gh9Hx/tLInP2OJKYP8TUm7K91UqDbkbY=;
        b=Yb4PSMdSQSL9SCaS58BMf54Iy7wBVr9hSqt3pcLTfwPL44GJ7UmlHWo1J3nkFAfHDW
         qhtP29K6kHtmGpvOSMWehS7+rRi/JnTRqafqAorWFvmCN8U5BYwtPae/PMHDjauwWeuC
         iBBkhrW3InmqRYt1tqneBEvaDQVvlckJV6kmhtjgLqLCu8lH5T07Taun8dsnzmLOE3rN
         DiPLtm9YKn9MKj3K37DRv/0Wuq5GBqV4tX6P+Vt4F0mZ//0B2ue1jKJN/b1WUzQ0dfK0
         uDDOlzfeE2RQiyOhHjSOm6vG091ygzljFsXyxBJC0Jts2jCwKwskr8UHJjVyGLDY5Yer
         o3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726018136; x=1726622936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ka8v+nuFAA0Gh9Hx/tLInP2OJKYP8TUm7K91UqDbkbY=;
        b=k7B7jHSJrGDZEiW7wcAlgqrK9GOdxZa+VqrptAI3NSXiGQz7X7Ze71gZonRygfchxM
         ZHyCMiWV0NBdyu7DKRr93+T9WYmfp0zmclE2PlGJf1LXN/2qcv1h4iydRcFld4500pgr
         zHDCYm2SeuwF7o4N3l07uCiN2jvQ7GA6aT80OGn2RCtOeGEARt6hUQL0rhvNruF94hm1
         8vvGmoTqIMCMXSNi+EoX7RlN+7GEoApTGSgPnYi02hfRNM3I1GCQH9ng2q3kK1b3Uw81
         83PjYYmjSEF0MIRbzxLu24+ZAzIIEsgDOyxauY+jvZ1b3cISCcAkq7M7fu49hY5/dOGc
         o1Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXPvrspEbVAzpzfs6AQA9+mb3CCRGfKDVKcAzU+8ar/cNaS9LTXppTl7A6e8Di8FGzLLxmsQGeV28No9Ek=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy21qxVUXx5T3d/umKitHfB0i09rWHMe+khENBtmfPIWS8J1zGj
	GdaGyPc8FSie62kJyzdO0iagwoGe+UmQKNonH22rMaNN+Nh2vcdt
X-Google-Smtp-Source: AGHT+IF+mE7+NwgL4kVINEDilY0cUwrweJIzqC5lwqmEt2ov9DI4+B+MFPZFyGsaQH8Hv60GO2chfA==
X-Received: by 2002:a92:874a:0:b0:3a0:65a0:460a with SMTP id e9e14a558f8ab-3a065a04863mr62567995ab.19.1726018136265;
        Tue, 10 Sep 2024 18:28:56 -0700 (PDT)
Received: from aford-System-Version.lan (c-75-72-166-104.hsd1.mn.comcast.net. [75.72.166.104])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d094561c8csm1917945173.62.2024.09.10.18.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 18:28:50 -0700 (PDT)
From: Adam Ford <aford173@gmail.com>
To: linux-phy@lists.infradead.org
Cc: dominique.martinet@atmark-techno.com,
	linux-imx@nxp.com,
	festevam@gmail.com,
	frieder.schrempf@kontron.de,
	aford@beaconembedded.com,
	Sandor.yu@nxp.com,
	Adam Ford <aford173@gmail.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Marco Felsch <m.felsch@pengutronix.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lucas Stach <l.stach@pengutronix.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V7 0/5] phy: freescale: fsl-samsung-hdmi: Expand phy clock options
Date: Tue, 10 Sep 2024 20:28:06 -0500
Message-ID: <20240911012838.944630-1-aford173@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, there is a look-up-table to describe all the clock options the HDMI PHY
can use.  Some of these entries in the LUT are using a fractional divider which does
not have a well documented algorithm for determinging values, but the the integer
divider can use an algorithm to calculate the integer divder values dynamically
beyond those listed in the LUT and also duplicates some of the entries.

The first two patches do not do anything functionally other than simplify
some of the register accesses and de-duplicates some of the register look-ups.

The third patch adds support for the integer divider and uses it whenever the
clock request is an exact match.  Otherwise, it will use the LUT as before.
The rouding is still based on the LUT if the integer clock isn't an exact match.

The forth patch updates thes set_rate and round_rate functions to use either
the fractional clock LUT or the the integer divder mechanism to determine
which ever clock rate might be closest match.

The last patch removes the integer divider entries from the LUT since by then
it'll be comparing both the integer divider calculator and the closest value
in the LUT.

In my testing with a AOC 4K monitor, I was able to add 4 entries in my modetest
table.  I do not have an HDMI analyzer, so I just used my monitor to determine
if this series worked.


Adam Ford (5):
  phy: freescale: fsl-samsung-hdmi: Replace register defines with macro
  phy: freescale: fsl-samsung-hdmi: Simplify REG21_PMS_S_MASK lookup
  xphy: freescale: fsl-samsung-hdmi: Support dynamic integer
  phy: freescale: fsl-samsung-hdmi: Use closest divider
  phy: freescale: fsl-samsung-hdmi: Remove unnecessary LUT entries

 drivers/phy/freescale/phy-fsl-samsung-hdmi.c | 596 ++++++++++---------
 1 file changed, 318 insertions(+), 278 deletions(-)

-- 
2.43.0


