Return-Path: <linux-kernel+bounces-517894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEB1A3871D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 15:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 150F03AFDB1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 14:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6BF223716;
	Mon, 17 Feb 2025 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVurLB09"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6869121CC74;
	Mon, 17 Feb 2025 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739804269; cv=none; b=roI0MJBhQaCXY+Z722ZyIgRvZvTcmz1SKmyrmw17dQihyMmTL6851Z526V/Xn4LAV/SFNoCKT0F3RPvw70RtviHeNVbu3gW0qnD47U1mYBK/9/Ljm4u0foq/JhHGI4oy1gQWsbJk4ob35D4dfBlVB4yagbOtch/9RaNW8vIBhOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739804269; c=relaxed/simple;
	bh=qJqUYoEZSlIY8ZZFK2NOtBT4skKZlYw/05gC7EkpVck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NmnLD6yFzt9fpGHdqJ5HNhxUAFDjWCqQkQzfIdXqDDzMj8sJp5NAlWRP6DJ/wNKqmlUhV1LtyERwqcbclIFFTKcZB5/Se8FJdjhC1ceKy/YqmeKyPOLA7U7b8lVWA9jjm4F+MZV4RUQHkvJVs85g/CIv0znbPGwFZ8WT/oN3NF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVurLB09; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4398c8c8b2cso6342365e9.2;
        Mon, 17 Feb 2025 06:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739804266; x=1740409066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oXoBLoBhkmHAsPATjYXnbeVHXKCoJYAoeA07HXhsnTQ=;
        b=HVurLB0929XGSSseEYslKDuvayEoex9mIPxKCAt7x69lFb/aU66/8OMKuxk8cbTGk0
         svz2YRINryxy7CCcCG7f3RXH3joRggG9KzrdvWQn7sTqwGDuhRdRk4grae2ekqgvjlr1
         zk5xFQC3Z+4Edh9wpoTV7zwZMZYBWxmF0LSjz/tz0iQGXqvjNbm7kYntK8HLxNDVkUjU
         XvMuweQyOSjr7V259eEoXkV1HIbZC6gpARralAWQiKOGzysOCR82nUdhc7pKjjescqVf
         xsuBewUOvpxaQhLUxAWAre1nTZNhfhz0ChYKGnWuRNqKGEC9YJH9gXHjNI+TcUQ9tGmX
         2u8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739804266; x=1740409066;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oXoBLoBhkmHAsPATjYXnbeVHXKCoJYAoeA07HXhsnTQ=;
        b=oVRG6BZXSCplEcEZHY26ffZTrAhWMCWOjszr2fp2YjYuM+xJRo121NG9U6yCtImTvj
         vyh9J8Z9tjB+L/YUIKByydTbO6R+9UPTOlzKQujmR4I4qYWFLr01kylq6ishX0LL4WDs
         GUfF2UB6suBfw7Yp0V2dFLliaetfW72PmmTYm89fCz6LgrrNnjcrGsDcy6EkzgDmwVPY
         dnTP4DJMw9xBl5NPmRLgNkpLRSROEUgqh8LbebdunkideWo+/s+UwLExJwxDdwpI0VhB
         fqcU+/XjlvltvOwvtu1eHvlh7VmPfDyRFBexNJqlY7M50jWzzXNAT84hJn5Jg94S0fhq
         79dQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4P9EPNsVBe4qQU7aC3/PgfU/0MdWtUUn1IBiXAi0dCs1/b06/5H2PMwxuUrp7EZI5PJKgSKZurvRsWpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWAHZhoSEHOBmpoowJwl0miSc84AAWp2g7QpN5+2FhmdobNSxa
	FE33wpordR4GlYzlti/MFzIjnsVmz64hefr+M/xXzYKNo1GUplnV
X-Gm-Gg: ASbGncsFaj9Ehoik+Cngit5DfIpQc3/8UNzT6B2dzsFA1kNfHx+n29Wqe0yn9uoOmd5
	mFda51BxAhUGa7GNRHm2XG8okyeg4A1LZeL4isyVQe9JtyihxVf9fNueRIYR7jv//IAFaRGk6tc
	aA8jlbM7H7B5Oq3+Wk691UXgmQwLt0XJrV3Aa+yDJEKQ1r0hhlb6aBcJguWBnt4DSChURk4MITM
	9ejZy5NzLACMBi5I7iI2GbVRo9KAaYjCoxcmol+P7Nl1tVRj9A/P3qi7qyGwRsGDuhgdh5MRnfz
	LnxJiFd/GKi84/ulBLhCM/TlGKF3VEg=
X-Google-Smtp-Source: AGHT+IFXCMAdjJ/GydfAREXf0KPq6/DlSCRVX1j0O/vO0UDb9MfjoWtFC0m9aDzP5dEgyS4d1XL08A==
X-Received: by 2002:a05:600c:19c9:b0:439:5760:39a with SMTP id 5b1f17b1804b1-4396e716e8cmr101394035e9.23.1739804265610;
        Mon, 17 Feb 2025 06:57:45 -0800 (PST)
Received: from eichest-laptop.toradex.int ([2a02:168:af72:0:48e7:ac19:aeba:f677])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25915146sm12645020f8f.56.2025.02.17.06.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 06:57:45 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	francesco.dolcini@toradex.com
Cc: devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] arm64: dts: freescale: imx8mm/imx8mp-verdin-dahlia: add Microphone Jack to sound card
Date: Mon, 17 Feb 2025 15:56:39 +0100
Message-ID: <20250217145744.179213-1-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds a Microphone Jack to the simple-audio-card of the
Verdin iMX8MM and iMX8MP Dahlia carrier board device trees to separate
the microphone and headphone functions.

This resolves the following boot-time kernel log message, which
indicated a conflict when the microphone and headphone functions were
not separated:
  debugfs: File 'Headphone Jack' in directory 'dapm' already present!

Stefan Eichenberger (2):
  arm64: dts: freescale: imx8mp-verdin-dahlia: add Microphone Jack to
    sound card
  arm64: dts: freescale: imx8mm-verdin-dahlia: add Microphone Jack to
    sound card

 arch/arm64/boot/dts/freescale/imx8mm-verdin-dahlia.dtsi | 6 +++---
 arch/arm64/boot/dts/freescale/imx8mp-verdin-dahlia.dtsi | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.45.2


