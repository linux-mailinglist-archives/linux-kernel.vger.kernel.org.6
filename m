Return-Path: <linux-kernel+bounces-190223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AFA08CFB91
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 10:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEE3B1F21AA4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 08:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C2E85C603;
	Mon, 27 May 2024 08:34:35 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6207435280
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716798874; cv=none; b=HJcfcAig2HokonwXQ1Bo8V18SrfcD+zZvEBY2tfEHUKkCgkvHoUMIBYMF+uoWZxM5kttyXYY61ThX7nzw/lkTdrcrZQiqQl8uortDtyUq7zzrDDPJB2ESuv+bFFGgIO9soilf4chPuf3W3H7TOrocmMzWOu6kXXCQa/U2tG/cIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716798874; c=relaxed/simple;
	bh=sggMS46y9WzgFILiZWzlDCQJYPlf3mGpYmCkF3+cMQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WyedTmXUBQAw/8+uUAG87t2nuAC2Q+eRHKWOHjjFywwEOD/c+vOna30RTiysZnKnxC3HF0V5uOB1ZP/HqCyYGGQdwloeuq7iJ5+LaggN/mw6Mf0ru6OLpYFsYk8jTb/W9zRucYpAFZlZbwJwpJhRRUnnDpW+xw6U2NTmsr/uep4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1sBVoK-0000Ca-AT; Mon, 27 May 2024 10:34:28 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1sBVoH-003ABK-H3; Mon, 27 May 2024 10:34:25 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1sBVoH-00CzoY-1M;
	Mon, 27 May 2024 10:34:25 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.de>,
	=?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
	David Gow <davidgow@google.com>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nishanth Menon <nm@ti.com>,
	Jeremy Kerr <jk@ozlabs.org>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Thierry Reding <treding@nvidia.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dave Jiang <dave.jiang@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH] platform: Make platform_driver::remove() return void
Date: Mon, 27 May 2024 10:34:15 +0200
Message-ID: <20240527083416.1177106-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=6739; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=sggMS46y9WzgFILiZWzlDCQJYPlf3mGpYmCkF3+cMQo=; b=owGbwMvMwMXY3/A7olbonx/jabUkhrQQ145MZem1h6b6SNrdLP7lYragOKghYU3V7jUpx8652 i63nDWtk9GYhYGRi0FWTJHFvnFNplWVXGTn2n+XYQaxMoFMYeDiFICJxM1n/2e2qbR8wwUpkUqT GT/DLok13ay58fZrnOgE06rqhxcLj5rL3T62nPVUf9iqij/xXpttPrnHOl7waZ7Bpvjgxym5L14 9PAaxM+cKKBY6/ZwSYWtew1XXtHqOu6jjiUlB/0sqQiRFvondtt22cYNrmLB/6/T77yqW/bOMrw y0s7N6ELCHxSDFvijSNnCXkcrOH5fWPXu0P6RJ1Fo5P/Cdvq3A9KZYZ5m0U1Vz/uWtDy/4Vrncw v1bypv4DP+GuwmFrA89D2dPfvuvWnR7U9HtR7UfVs5345jgvlU4+13d//M/jPR/50it3x+3vilw i8cT+/VODlL3Lc96zLgd+EXMkkfgVblfoDfrCd7DxywCAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

struct platform_driver::remove returning an integer made driver authors
expect that returning an error code was proper error handling. However
the driver core ignores the error and continues to remove the device
because there is nothing the core could do anyhow and reentering the
remove callback again is only calling for trouble.

To prevent such wrong assumptions, change the return type of the remove
callback to void. This was prepared by introducing an alternative remove
callback returning void and converting all drivers to that. So .remove()
can be changed without further changes in drivers.

This corresponds to step b) of the plan outlined in commit
5c5a7680e67b ("platform: Provide a remove callback that returns no value").

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello Greg,

there are only very little platform drivers left in v6.10-rc1 that need
to be changed to .remove_new() before this patch can be applied. They
were all sent out to the respective maintainers, most of them suggested
to apply the patches together with this one.

You can fetch this patch together with all necessary commits from:

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git platform-remove-void

If you have no concerns, I can also provide you a signed tag for
pulling. I think that's easier than indiviually applying them, but I can
also send out the complete series if you prefer.

The overall shortlog looks as follows:

Uwe Kleine-König (18):
      reset: meson-audio-arb: Convert to platform remove callback returning void
      reset: rzg2l-usbphy-ctrl: Convert to platform remove callback returning void
      reset: ti-sci: Convert to platform remove callback returning void
      Merge branch 'reset/next' of git://git.pengutronix.de/pza/linux
      fsi: master-aspeed: Convert to platform remove callback returning void
      fsi: master-ast-cf: Convert to platform remove callback returning void
      fsi: master-gpio: Convert to platform remove callback returning void
      fsi: occ: Convert to platform remove callback returning void
      pps: clients: gpio: Convert to platform remove callback returning void
      gpu: host1x: mipi: Benefit from devm_clk_get_prepared()
      drm/imagination: Convert to platform remove callback returning void
      drm/mediatek: Convert to platform remove callback returning void
      gpu: host1x: Convert to platform remove callback returning void
      gpu: ipu-v3: Convert to platform remove callback returning void
      nvdimm/e820: Convert to platform remove callback returning void
      nvdimm/of_pmem: Convert to platform remove callback returning void
      samples: qmi: Convert to platform remove callback returning void
      platform: Make platform_driver::remove() return void

The patches to drivers/reset were applied for next, but Philipp didn't
come around to care for them entering v6.10-rc1. I merged them on top of
v6.10 with his consent.

For the samples patch I didn't receive any feedback even after two
pings. Also the nvdimm patches didn't get a maintainer blessing. The
others are fine.

I'd like to have this in next early now. I don't expect any fallouts
(allmodconfig builds done for arm64, riscv, m68k, x86_64 without
problems, mips failed for unrelated reasons) but it might affect new
code entering in the upcoming cycle.

Please tell me how you want to handle that, I'll do the necessary
preparations then.

Best regards
Uwe

 drivers/base/platform.c         | 10 ++--------
 include/linux/platform_device.h | 15 +++++++--------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 10c577963418..c8aa1be70526 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1420,14 +1420,8 @@ static void platform_remove(struct device *_dev)
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
 	struct platform_device *dev = to_platform_device(_dev);
 
-	if (drv->remove_new) {
-		drv->remove_new(dev);
-	} else if (drv->remove) {
-		int ret = drv->remove(dev);
-
-		if (ret)
-			dev_warn(_dev, "remove callback returned a non-zero value. This will be ignored.\n");
-	}
+	if (drv->remove)
+		drv->remove(dev);
 	dev_pm_domain_detach(_dev, true);
 }
 
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 7a41c72c1959..d422db6eec63 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -237,15 +237,14 @@ struct platform_driver {
 	int (*probe)(struct platform_device *);
 
 	/*
-	 * Traditionally the remove callback returned an int which however is
-	 * ignored by the driver core. This led to wrong expectations by driver
-	 * authors who thought returning an error code was a valid error
-	 * handling strategy. To convert to a callback returning void, new
-	 * drivers should implement .remove_new() until the conversion it done
-	 * that eventually makes .remove() return void.
+	 * .remove_new() is a relic from a prototype conversion of .remove().
+	 * New drivers are supposed to implement .remove(). Once all drivers are
+	 * converted to not use .remove_new any more, it will be dropped.
 	 */
-	int (*remove)(struct platform_device *);
-	void (*remove_new)(struct platform_device *);
+	union {
+		void (*remove)(struct platform_device *);
+		void (*remove_new)(struct platform_device *);
+	};
 
 	void (*shutdown)(struct platform_device *);
 	int (*suspend)(struct platform_device *, pm_message_t state);

base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
prerequisite-patch-id: 34124516ca38cd2c66a8a871c499ce3ae96e09ab
prerequisite-patch-id: 8ea26f3437cebce13a4975cef291db6a2e15bb93
prerequisite-patch-id: ee4b519fc5515807ae72877467e5f1c83c93d19a
prerequisite-patch-id: 79e7647450348ef0cca53af2bc5e5a0033dcec57
prerequisite-patch-id: 45568b19e28a0cb3f46699ff945adc654eda07d2
prerequisite-patch-id: 7daf4547e4b3785959e0c024ce95141cd1d936da
prerequisite-patch-id: f3c1f5b72e3b503760d4b70bb661ceb8381c4822
prerequisite-patch-id: b63f367f8354d56916d33c4236c79cf8e1c7d67a
prerequisite-patch-id: 4b8d2995e96ae290599d752cf1c1d2537e47bfab
prerequisite-patch-id: 5915e9d3dd78f832ab0017c81df770f443b32169
prerequisite-patch-id: 5626ccc5644f4edf610c083f2ff7c1308c6aaf27
prerequisite-patch-id: 712d0c765bdecbc60d72e62b10b329b525dfd16f
prerequisite-patch-id: 85e037f468c34b7a904f926e0cc555d7863c2cc7
prerequisite-patch-id: 48554c57f1d06553af3ded861ebf9b88ee6b03c4
prerequisite-patch-id: c26315d8be3a746b04dea921d41c903d054b774f
prerequisite-patch-id: 8eca4420a223355531ddfc5331729feb5fff9812

-- 
2.43.0


