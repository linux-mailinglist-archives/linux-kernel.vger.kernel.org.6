Return-Path: <linux-kernel+bounces-343465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33421989B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E838D2833DC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BCD915383D;
	Mon, 30 Sep 2024 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="Q8ZCwIQq"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9A114386D
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680628; cv=none; b=B4EZQ/YoKO8UvB0ZuiSXVnsTib2mAVDfdSduhCJW8Mqwv8yeOEbbiHc7h5io+AqgGWnUh3030v/aJ9tXkyMs15EP/lHXg6qh5uliXZNuuUVDmXx2GwMlCIuEvtWjjAb3Ps5cQlJn6pcGvV+470/TUyNRrGJPfHBixzVGKzMd+Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680628; c=relaxed/simple;
	bh=+WSYWb5zuZ3ce7+vEdasSuujef9LTNe/rREu1EmZRfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=j3vPtYczDZtW+Vu3DFfQeG4FG3zYZ77hOReDIjeeHMbtqHS61FnV9kIn5vY1A6zS39EtR6+IVwJedlIXooOvLWiuU7cyYBupWDWq1lIH09mralr4xXb7rvFyUP4zJQUEY3EWO6RiSMvp31iilhyVnfvOlVBgQ+1lXBMD2rrM6zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=Q8ZCwIQq; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1727680614; x=1730272614;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+WSYWb5zuZ3ce7+vEdasSuujef9LTNe/rREu1EmZRfQ=;
	b=Q8ZCwIQq1eEP+Z91GDz24IwcglzI4swQbdZWsiYd0d/GeCvLqxz3x8HbwPNJqfQd
	Bzm7dJs33hSV88gyHPG0dKp4O+XN8K9/ks4RxwuOP3e9gUcWUJz8jkJ71w4RlG4I
	84gykcIEvNH6zSqsjlSRTmPoysOzOt1JRL06kWGTwIQ=;
X-AuditID: ac14000a-4577e70000004e2a-9d-66fa506665e9
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id BB.50.20010.6605AF66; Mon, 30 Sep 2024 09:16:54 +0200 (CEST)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 30 Sep
 2024 09:16:54 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Date: Mon, 30 Sep 2024 09:16:46 +0200
Subject: [PATCH] sound: soc: codecs: tlv320aic3x: Fix codec gpio-reset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240930-wip-bhahn-tlv320aic3x_fix_reset-v1-1-c040d86a4b93@phytec.de>
X-B4-Tracking: v=1; b=H4sIAF1Q+mYC/x2N0QqEIBAAfyX2uQXTHrRfOSI22zsXwgsNC6J/T
 3ocBmYuyJyEMwzNBYmLZPnHCl3bgA8Uf4yyVAatdK+cUXjIhnOgEHFfi9GKxJtz+so5Jc68o/f
 kOku9tW6BWtkSV/kePuN9PyDKxEZxAAAA
To: Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>, Baojun
 Xu <baojun.xu@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>, Teresa Remmet <t.remmet@phytec.de>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <upstream@lists.phytec.de>, Benjamin Hahn
	<B.Hahn@phytec.de>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727680614; l=1640;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=+WSYWb5zuZ3ce7+vEdasSuujef9LTNe/rREu1EmZRfQ=;
 b=N+mcYfPSpYdHeYhTnv7KrB/jqd17s0RSTtUYij5tcfS5VbGi3Q86lKNPD+t2+mfRINbKKAMY7
 l5RO+yHzA7jC0LJE9FpL/POWY3qawyLKed1H1b6o+qCf2TBPPXDDgwP
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjkeLIzCtJLcpLzFFi42JZI8nAo5sW8CvN4O0PDYsrFw8xWaw5co7F
	YurDJ2wWH+7/YLX4dqWDyeLyrjlsFnOfTWG26NzVz2rR1atvseH7WkaL7nfqDtweGz43sXns
	nHWX3WPTqk42j/7uFlaPfW+XsXms33KVxeP4je1MHp83yQVwRHHZpKTmZJalFunbJXBlrFl6
	lKngFU/Fg0vSDYxXuLoYOTgkBEwkdhyI72Lk4hASWMIk8eDmWTYI5yGjxNPnz4AcTg42ATWJ
	XW9es4LYLAKqEo3n28BsYQE3ia1bZrOA2LwCghInZz5hARnKLKApsX6XPkiYWUBeYvvbOcwQ
	JUES+xbvA5svIbCHUaL/Ugs7iCMiMJlJ4sDFCSwgDrPAIkaJY+e2gbVICAhLfN69hg3C3s0k
	sfpYNMTZiRI7X8uBhIUEZCVunt8CVSIvMe3ca6jWUIkjm1YzTWAUnoXkvlkI981Cct8CRuZV
	jEK5mcnZqUWZ2XoFGZUlqcl6KambGEFxJsLAtYOxb47HIUYmDsZDjBIczEoivPcO/UwT4k1J
	rKxKLcqPLyrNSS0+xCjNwaIkzru6IzhVSCA9sSQ1OzW1ILUIJsvEwSnVwGgfrlBre3Dj9lOM
	6QdbtYSeVkgzr1dpXnB9Q0+7R/2/VNG/V2p9l/HYzapewDbrm2Lk478XXvdt/RNrXn62amXG
	z39yize4r3dc9ttC9U2ZCldz9e0ffBuv1CZ1NbM75Hz4zDi1bunE2oi4slviSv4fT2l/vR30
	0aV41jPboOKL95Sm7FPvPavEUpyRaKjFXFScCAD6+GPKoQIAAA==

The TLV320AIC3007 requires a hardware reset after power-up for proper
operation. After all power supplies are at their specified values,
the RESET pin must be driven low for at least 10 ns. Even though the
datasheet sais min 10ns, I needed more than 10ns when testing this out.
15ns worked for me.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
 sound/soc/codecs/tlv320aic3x.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 56e795a00e22..d002fc0b99b5 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -1367,8 +1367,11 @@ static int aic3x_regulator_event(struct notifier_block *nb,
 		 * Put codec to reset and require cache sync as at least one
 		 * of the supplies was disabled
 		 */
-		if (aic3x->gpio_reset)
+		if (aic3x->gpio_reset) {
 			gpiod_set_value(aic3x->gpio_reset, 1);
+			ndelay(15);
+			gpiod_set_value(aic3x->gpio_reset, 0);
+		}
 		regcache_mark_dirty(aic3x->regmap);
 	}
 
@@ -1813,6 +1816,10 @@ int aic3x_probe(struct device *dev, struct regmap *regmap, kernel_ulong_t driver
 
 	gpiod_set_consumer_name(aic3x->gpio_reset, "tlv320aic3x reset");
 
+	/* CODEC datasheet says minimum of 10ns */
+	ndelay(15);
+	gpiod_set_value(aic3x->gpio_reset, 0);
+
 	for (i = 0; i < ARRAY_SIZE(aic3x->supplies); i++)
 		aic3x->supplies[i].supply = aic3x_supply_names[i];
 

---
base-commit: ad46e8f95e931e113cb98253daf6d443ac244cde
change-id: 20240930-wip-bhahn-tlv320aic3x_fix_reset-cca918a4889d

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>


