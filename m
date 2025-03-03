Return-Path: <linux-kernel+bounces-544791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36002A4E4FF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A8007A675F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 16:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DF427814D;
	Tue,  4 Mar 2025 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WaTvUjDQ"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4222924BCE8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103296; cv=fail; b=XqthWY5/mWk1z0mp4FGh0JeTdVky8ORzljzyxVYHR4DlT0xt0eO0RudvQl2cG5Glqu7B5ls9TQ3ucijpfbBqkDCsxvorTQweynWr1BKW7FQBnrKLmoV9szmvnfCBxWhSIiami0ko1LGSCHbWpqoHZQtPgLj+gpac/lmcnyrBQzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103296; c=relaxed/simple;
	bh=A2DhGNw9YXj+yiRvIrrUEzsMLlNCo746xfE24ULxn4g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zwuh2spxOreL+VYZnIWo8bzzs5lDla4r2csYhHAyEHaJs8wVZTV3jCFKPei53+y7yZyEVC8yA+IZocIefwJxhwXUSKaq+EMNb9Z+fs43owRCdGsUtl8EL1pB1ny+AiwpuRiL7EBMjx2RMNsKOQwS0pko+Bcwk5KfFnIqdoHxk54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=fail (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaTvUjDQ reason="signature verification failed"; arc=none smtp.client-ip=209.85.167.44; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 62E4840D5725
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:48:13 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WaTvUjDQ
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g2Z1rB5zG1G8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:43:50 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id B3F9F4273A; Tue,  4 Mar 2025 18:43:36 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaTvUjDQ
X-Envelope-From: <linux-kernel+bounces-541664-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaTvUjDQ
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 8D53D422D5
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:09:06 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 22A5B2DCE1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:09:05 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAF7E3AB209
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6C520E701;
	Mon,  3 Mar 2025 12:05:15 +0000 (UTC)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038261F3B92;
	Mon,  3 Mar 2025 12:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741003512; cv=none; b=LFLgEtpC9fs3AVG7Q/wvxFKtNPu1OR7Wl3Z1+eF1AgM+NonNykbDttG6SbmVUOr248ujIZ1gJMaz2M7PjrXhGTd1G2/bx8ieaPD1mI4NGmqAPJQj/jULS250gaiS6fuc4FDUYDUJ9WdU3GSMrkSvPnkQq+idWgLfIOhy19gPn98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741003512; c=relaxed/simple;
	bh=KPrNJ2CjcJgUp4GR4bg6cHXy5cWcuRUCJUll2hZL/t8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oLVZ2E1RhgCeRkDrwVCEZc+TOf2cMIV8aJmamfqKfXK3LtHamgrLOjekaIqI5IjmeHs7UcH5/PiAZLlxRTAyD5qytxtTnxy9PNKVG6aUr+YBylJ7qEkzRc1hYz2KU/GH3Aibvxwe+Ttedt0RsuM8z+T9lsdzSlrELWt3yHklLDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WaTvUjDQ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-54957f0c657so2732891e87.0;
        Mon, 03 Mar 2025 04:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741003509; x=1741608309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZD/Y8XoH6xZnndtrVVRfg4SWXIuS1zcDn5ZHGdab0Cc=;
        b=WaTvUjDQYBGNMCcbJlFB4tgXMQ1WqJXxA5dkRp+C0woXNfSGtI57GIH0u2nl4D48h3
         atGGzTddo0L/tkBCH6vJ8KCbxvyrzZLamJ8Y6WNOKI5a2BseX2J3hdol9SHyoES5n/8j
         BsJ7llJD1TkdGAvCm7rOxwEEgX70MKt9xeLpIpDH2rUcSt7zuOFYf8z9zp/+iOqKNxRY
         S+569GXo7iqWAqT4AoeAWogl1N2i9aQuzGHgaz+pCoRC5ixK2mn0igCtpiR5TDXzaRFo
         cW+KctsQCG7kJDRQ6uRUH6Uud4WQrXYeRD9e7+JkLoeD+EGtWvf9yRisn5wQYSrILKhA
         OSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741003509; x=1741608309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZD/Y8XoH6xZnndtrVVRfg4SWXIuS1zcDn5ZHGdab0Cc=;
        b=DHKhFP3y1k9Y9c4jC05Pl4e09XJbArX59rqAm5/o1Hs4oD6fcKrSoZOiKgY3mh5+cj
         jcI28QtAeAahumuoJdZCraVauATvoIeaBsQlvEzEiSqjbmrK6ewuKllyGop0ARE7dUp2
         TpBl6kwBSFEhCmJrC0JdnEPbOGFQG6bPUZn2LfnKimd9w//OCGOl0uUOnAjB1lNXiOZE
         TIIzpmujk/LvXrJlzJ1LX6rCjqUGSBJ6V+G34atap0JywuV6NzQVZN6vomYt1le+tVc1
         0GxGU7idUWT/BY+sQVNGgj3p3ihIMj/bTaQfzxLkvLaLrhSSdAWWVygFzncFcrO6EiSI
         q/9A==
X-Forwarded-Encrypted: i=1; AJvYcCVpPjbmt9KfM1N/5dmsSOQ5LFEp4W/wFQM90MLvmUrvVH9otURWN5oWeixpieCO/o1Sos2mb1l8T1VE6IhZ@vger.kernel.org, AJvYcCWBe0J4XDcxunKUsGE0NnwCjyrzSpgVTapw0rTVcLTZpj4neP1WgEP8VWSC17d+HV/xBSl8rZrS5biV@vger.kernel.org
X-Gm-Message-State: AOJu0YyZg1DkyUxmb6GEsK0KugHGn+zp3znHRoUvIwZqWaVgRdgTujQf
	mngaGZGhcqKESTFmpi9fBKa272Cxnna0LrGZi44+h402yha/WCdp
X-Gm-Gg: ASbGncsc/imUGeI56e0US2FIGsZFNa3rpVOgbfgGxxXKGMmEGF2LVb23D9dq66dlEjn
	DFq2YgJQn8FTscfe4YoF3r1/zwHT1rSCuczoDJJvw9Ckh39Jj4OXiEHVmf8pIMiu06YSvapwzpN
	ZmP6nBiGq2i58sPdZh2mBRCAotB6XK+VoIt/NM4w5Ry0rhRS5FguRBjXPZv/6rc+zrTknlOr8YJ
	dYVzxOtBG6iKqts/7pSR0/9BrBUbJ9Lv7TtP1yPFbIDKpZUFVsDf8pYBwB21a/WhNzTwFSEYby3
	hGHGvXqCONjeFfvGPEfTcQLrNxAJ9LmYyszA
X-Google-Smtp-Source: AGHT+IFajLosPc/MMTY5likqjVO4/GgB93fvKU661xoydwj1RgBeY4c9Du1+nVVmh/F5sHfpMzHNmQ==
X-Received: by 2002:a05:6512:ba8:b0:548:878b:ccb3 with SMTP id 2adb3069b0e04-5494c3756a6mr4633661e87.25.1741003508733;
        Mon, 03 Mar 2025 04:05:08 -0800 (PST)
Received: from xeon.. ([188.163.112.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549576b88d9sm869095e87.12.2025.03.03.04.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 04:05:08 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Maxim Schwalm <maxim.schwalm@gmail.com>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] drm: bridge: add support for Triple 10-BIT
Date: Mon,  3 Mar 2025 14:04:52 +0200
Message-ID: <20250303120455.90156-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g2Z1rB5zG1G8
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741708001.67644@Yg59QXTG1lQjN+j8DwO2eQ
X-ITU-MailScanner-SpamCheck: not spam

Triple 10-BIT LVDS Transmitter is used in Microsoft Surface RT and
MStar TSUMU88ADT3-LF-1 HDMI bridge is used in ASUS Transformer AiO
P1801-T.

---
Changes on switching from v2 to v3:
- place mstar,tsumu88adt3-lf-1 alphabetically
- fix typos

Changes on switching from v1 to v2:
- sort compatible alphabetically in schema
---

David Heidelberg (1):
  dt-bindings: display: extend the LVDS codec with Triple 10-BIT LVDS
    Transmitter

Maxim Schwalm (1):
  drm/bridge: simple-bridge: Add support for MStar TSUMU88ADT3-LF-1

Svyatoslav Ryhel (1):
  dt-bindings: display: extend the simple bridge with MStar
    TSUMU88ADT3-LF-1

 .../devicetree/bindings/display/bridge/lvds-codec.yaml       | 1 +
 .../devicetree/bindings/display/bridge/simple-bridge.yaml    | 1 +
 drivers/gpu/drm/bridge/simple-bridge.c                       | 5 +++++
 3 files changed, 7 insertions(+)

--=20
2.43.0



