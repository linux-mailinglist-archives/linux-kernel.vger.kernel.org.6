Return-Path: <linux-kernel+bounces-324478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAE9974CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 10:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F65F1C2577B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 08:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9AA715C13F;
	Wed, 11 Sep 2024 08:45:38 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A92013E05F
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726044338; cv=none; b=kmD4clr+zVE8oyy+NfY2WnmWnNyTQDCi2NGSgviLD3wxqHyW8/UfdlawE3TT+QKE718oljYuD8nIJxi6bRj71vVOyC6qBGKzU89gyJKnL2pHUODowzPwHjD467yyZjJt/hI3Tu6wehc7YCqKTef/3lj6ijJOVO3FD51KnQXopHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726044338; c=relaxed/simple;
	bh=KsJDe9Bok6Du9C+BSWYMCjn52SKb3MGmSqcwhKcc3kM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kt2Ijm3YMywRNaMs9pB7BI+tb7HgBNoT6T0IynALy4eqbR6ey2u7P9cX1AM/pQk3OBbXQhQ2RMtlyxdfXvEVgxwiAj8xzFf7wv9ZOnSpNa72lQU4pVdBIxXAe8MwqJnW7hsShe87gbQabvzEnvuI8MpSGhc7PUIQeY/7BuJoLVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1soIyl-0002f1-9V
	for linux-kernel@vger.kernel.org; Wed, 11 Sep 2024 10:45:35 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1soIyk-00760J-E0
	for linux-kernel@vger.kernel.org; Wed, 11 Sep 2024 10:45:34 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0A59B33815B
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 08:45:33 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 115B2338137;
	Wed, 11 Sep 2024 08:45:31 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 0a04ff54;
	Wed, 11 Sep 2024 08:45:30 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 11 Sep 2024 10:45:25 +0200
Subject: [PATCH can-next 1/2] can: rockchip_canfd:
 rkcanfd_timestamp_init(): rework delay calculation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240911-can-rockchip_canfd-fixes-v1-1-5ce385b5ab10@pengutronix.de>
References: <20240911-can-rockchip_canfd-fixes-v1-0-5ce385b5ab10@pengutronix.de>
In-Reply-To: <20240911-can-rockchip_canfd-fixes-v1-0-5ce385b5ab10@pengutronix.de>
To: kernel@pengutronix.de, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.15-dev-88a27
X-Developer-Signature: v=1; a=openpgp-sha256; l=1358; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=9WfFS70YrDr2qrfetTrD2fcBkV55eVvJHa3bbG4uxs8=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm4VinquE+Tws44QEClswYLm8kNwf80a6ISQYBA
 mPD6Zr1Ds+JATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZuFYpwAKCRAoOKI+ei28
 b0oAB/4g5Iqh2BWMbyXjya4wJb266mMCniZpg89eUuNb1jSWxUfSFVOkqdif+aLiaQ+MPiY/2fS
 oR1lDkgLs5zbSMwZgK5GnPgDtS7ziBYK20IdVE8Li5COjb8Wti/36hW6bPvRJ/1KMuDvJkZMD+m
 vnUP8O+8KBEBzp4YqgWSKb+XKgMt2ETWuoZscN6J7rWDrHmaavJCTBq82TpKUCVyoFW3Hn17Q+K
 xR0Z/LtOibuy+X3SuQd1ogL4z7Hf5jVtNwrjxlfmpaKYIseJCBEJMFM9r/MBmS/3lhvKnvmNHKu
 f818F71y4FhIkTCQZvzbuqrlRxGBdgGQI5MpiUfuV8aVUW1S
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Rework the delay calculation to only require a single 64-bit division.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[mkl: port to on-top of existing 32-bit division fix]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/rockchip/rockchip_canfd-timestamp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
index fb1a8f4e62172b06570b95e6f32c4c0f70fe1ea7..43d4b572181215c50dda9d4f8cdb2d22b7938b38 100644
--- a/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
+++ b/drivers/net/can/rockchip/rockchip_canfd-timestamp.c
@@ -71,8 +71,8 @@ void rkcanfd_timestamp_init(struct rkcanfd_priv *priv)
 
 	max_cycles = div_u64(ULLONG_MAX, cc->mult);
 	max_cycles = min(max_cycles, cc->mask);
-	work_delay_ns = div_u64(clocksource_cyc2ns(max_cycles, cc->mult, cc->shift), 3);
-	priv->work_delay_jiffies = nsecs_to_jiffies(work_delay_ns);
+	work_delay_ns = clocksource_cyc2ns(max_cycles, cc->mult, cc->shift);
+	priv->work_delay_jiffies = div_u64(work_delay_ns, 3u * NSEC_PER_SEC / HZ);
 	INIT_DELAYED_WORK(&priv->timestamp, rkcanfd_timestamp_work);
 
 	netdev_dbg(priv->ndev, "clock=%lu.%02luMHz bitrate=%lu.%02luMBit/s div=%u rate=%lu.%02luMHz mult=%u shift=%u delay=%lus\n",

-- 
2.45.2



