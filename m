Return-Path: <linux-kernel+bounces-531687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C74DA443A6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66E218925A6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2E121ABDC;
	Tue, 25 Feb 2025 14:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFUNQiAp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB6421ABC3
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740495196; cv=none; b=aGzaJrY2/9XdFWJahadxaGI4NhPjZjs9aJ+EJpTZXFNRXyTxT5myf64VvvE9shrv9MiwCygsZeC/81Diw6ag0QUOcd5cGdxhEH9kyyrHu3Ca+Gz8d2Ffx88Dc/uzscjzdbITM8jyrWpCtb3earFtUCWnnI5PYa7j4i2beHWXMRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740495196; c=relaxed/simple;
	bh=AApGCBsvr9tpfVBZkpdLK46yPV5KUVWdAmG1lSIJSNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A+BGtdkPDdMW/i6sWMSVPMDZ+hTyedpsUR+QCMP2Vb8VZQQGGVE1Vz7BhrdThHBzZw+cXbeII4suGPM3T5rZWjoyIStlIF5cEhnlejK/op/L+HwMhIWKD1ZYgDYR9dJhTctWfpe2/QO5CvA4pw3UcW2qA5C74j+ed/5BKJeu2ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rFUNQiAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7358AC4CEDD;
	Tue, 25 Feb 2025 14:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740495194;
	bh=AApGCBsvr9tpfVBZkpdLK46yPV5KUVWdAmG1lSIJSNs=;
	h=From:To:Cc:Subject:Date:From;
	b=rFUNQiApVyb0E+zH4PnNkt+cpVDTa6I4tex4CsO7T68xs2rO/C7BGWR0O5iuWBqOI
	 7g5Ke68LpR9G3rsTNWlEwq09JRTbt8Dh4o8+dqBruPz9sQpJyVSZTf0MXItaMaoHYb
	 QkoGR/wkSw2HKm3GD+73iy3DN2rkpFUlzkKOIK+N7nAov9Ybad/ozPJ6Z89kyh6kab
	 LPpfAl6BGP0b5zR6oOdIoAUEIU5LjSIE3dABqZ1AIS4e+ZU2L5e2tb1oPvEbnlIBIS
	 BZPtSlkGUsyG9/LxVIuC80jISiTQTL5HJ8wWGPcFwwuKUcRgUZrmOlq7bB8RQ98zVA
	 4VJSzy+8iJWUQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] comedi: ni_atmio: avoid warning for unused device_ids[] table
Date: Tue, 25 Feb 2025 15:53:07 +0100
Message-Id: <20250225145310.1110575-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

When the driver is built-in, it produces a W=1 warning:

drivers/comedi/drivers/ni_atmio.c:209:35: error: 'device_ids' defined but not used [-Werror=unused-const-variable=]
  209 | static const struct pnp_device_id device_ids[] = {

The actual probe() function has a different way of identifying
the hardware, so just mark this one as __maybe_unused so it
can be dropped when built-in.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I sent this a year ago but there were no comments, resending now
without changes.
---
 drivers/comedi/drivers/ni_atmio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/ni_atmio.c b/drivers/comedi/drivers/ni_atmio.c
index 330ae1c58800..b4e759e5703f 100644
--- a/drivers/comedi/drivers/ni_atmio.c
+++ b/drivers/comedi/drivers/ni_atmio.c
@@ -215,7 +215,7 @@ static const int ni_irqpin[] = {
 
 #include "ni_mio_common.c"
 
-static const struct pnp_device_id device_ids[] = {
+static const struct pnp_device_id __maybe_unused device_ids[] = {
 	{.id = "NIC1900", .driver_data = 0},
 	{.id = "NIC2400", .driver_data = 0},
 	{.id = "NIC2500", .driver_data = 0},
-- 
2.39.5


