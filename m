Return-Path: <linux-kernel+bounces-233155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACDC191B2FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 01:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 138A9283751
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 23:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E4A31A2FDD;
	Thu, 27 Jun 2024 23:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ANg6MnLv"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F561A2549
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 23:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532426; cv=none; b=ioLejMGPR4398rOUKjUNp93KqRi8HB7y+R7cK8deuRsQA83Z7RR5kXcodSBvGg2IhmDk7wCn7Y2LZzzuzArGH0jRbw3avirkeGjpXmZeCz7XbwJ58nmKP/2o2wellEe9ZYZNghUJ/gCefWbka1nCRY5mF/O/ATXYi1NT9nvDrJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532426; c=relaxed/simple;
	bh=8TDzL4LG+A2ddCLi6fgg9V+G2E1PrISrQcbK/zNYedM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rcAka5z1UThvuHUCTwVxoSANszMvWyI4Cxq7YSUUdJADsZ04r2VqMBmiFT/UmsAX3wzc63CYD83uYXk7R7IhExfOsxW/XUAEqrRNFB88cQCyln/WqKb6nkcR8MGPIM53ZJVYhWWc49jxJCo4AvZ71jLI0Nq+PmBW6ub0vu3VDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ANg6MnLv; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f4c7b022f8so40615ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 16:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719532424; x=1720137224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GvgNRfUrYC3vDPSHgELOXCgco+1ty8Hri5LXWyU0EuU=;
        b=ANg6MnLv9Nt+cvvg85p7tHx6wWPzblkE5JkOrwBtxxh7KZzqH0/h8E0lN1BGqnCYSv
         hbsR3B9eeSWxC10BuGLA32B0N63v3ewnnBwazfYnhz0mKDgcGBTqV6ovY5uj3oK0U9GB
         TUFDgcSof5vgtRJuvtX2ZO1bqUvbbbQ3xUMmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719532424; x=1720137224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GvgNRfUrYC3vDPSHgELOXCgco+1ty8Hri5LXWyU0EuU=;
        b=qYPF77w78SwsJXQVvgF8Kf7BfN3XjmK1/qxQPCac8CfRwwrDufWMrPV6ZoQw6EnhOv
         bD+AY+N53mwOobe0IqbPNUcqrBFKmtmL7vGxB5+/KDbk4MCxNgsUi+nWc9UTlg9Ap1Zm
         KW6IqB/jqW7nZQtnvCmlVEHGpIyhO92mGJFeEIxR4GOJ+Ie5nNUWNoA/FmFQoirdxuDD
         ISr6ESKH2+/UovaMZnTZh83ABnePdb/VEy62mIcenDGlL/iezbeD7850JGkENOLFk8nO
         NIBsKtfCfqqxGz3VJRMXLTeym6jKWGmOUPqTSIVx0bisnNyuS79mh9rf2j2w9mI7hC1z
         jcZw==
X-Forwarded-Encrypted: i=1; AJvYcCWoZF+kQrUVABVTyZT3hQY36GMA2oCwIJ5xivaSHYZbuUkOZTmcE4PCYlbeKWCoQFCwtRGAqMW+WcvPJRSJWnFPsht+Oi1lYgAxDS2q
X-Gm-Message-State: AOJu0Yy39VcMrsfbIyamH+quLynrz9lXhZGZSKnp/f3zvWghtYU0Rg5/
	NclbNUSf0oe30vcjFIKNNz2Q8DImlHIpDKviFqhRBXCug9N9qjg6/7UgNRo+iA==
X-Google-Smtp-Source: AGHT+IFTGJHi0WhKn1jfdIqcqfPQxr8jYnm7Tq2RVmaHgug3fRpbKxlPiPDM9y6uifF4i205XhWnMg==
X-Received: by 2002:a17:902:ea08:b0:1f6:5013:7842 with SMTP id d9443c01a7336-1fa23cd95edmr158375265ad.27.1719532424505;
        Thu, 27 Jun 2024 16:53:44 -0700 (PDT)
Received: from pc98uv11.mtv.corp.google.com ([2620:15c:9d:2:cf5d:cb26:248e:ee00])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac11d8cd2sm3366595ad.107.2024.06.27.16.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 16:53:44 -0700 (PDT)
From: Daisuke Nojiri <dnojiri@chromium.org>
To: 
Cc: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Reka Norman <rekanorman@chromium.org>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Gwendal Grignou <gwendal@chromium.org>,
	Pavan Holla <pholla@chromium.org>,
	Lukasz Majczak <lma@chromium.org>,
	Ching-Kang Yen <chingkang@chromium.org>,
	Daisuke Nojiri <dnojiri@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>,
	Prashant Malani <pmalani@chromium.org>,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 0/2] Consolidate ec_response_get_next_event
Date: Thu, 27 Jun 2024 16:53:06 -0700
Message-ID: <cover.1719531519.git.dnojiri@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
Changes in v5:
 - Merged changes in cros_ec_commands.h and cros_ec_proto.c

Changes in v4:
 - Change subject line: ARM:... to dt-bindings:...
 - Add description about keyboard matrix v3.0.
 - Add cover letter.

---
Changes in v3:
 - Remove CROS_KBD_V30 in Kconfig and macros conditionally set in
   cros-ec-keyboard.dtsi.

---
Changes in v2:
 - Separate cros_ec_commands.h from cros_ec_proto.{c.h}.
 - Remove Change-Id, TEST=, BUG= lines.

---
Daisuke Nojiri (2):
  cros_ec_proto: Consolidate ec_response_get_next_event
  dt-bindings: cros-ec-keyboard: Add keyboard matrix v3.0

 drivers/platform/chrome/cros_ec_proto.c       |  16 +--
 include/dt-bindings/input/cros-ec-keyboard.h  | 104 ++++++++++++++++++
 .../linux/platform_data/cros_ec_commands.h    |  34 +-----
 include/linux/platform_data/cros_ec_proto.h   |   2 +-
 4 files changed, 114 insertions(+), 42 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog


