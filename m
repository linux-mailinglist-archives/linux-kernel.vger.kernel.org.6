Return-Path: <linux-kernel+bounces-435512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125D39E78D6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 20:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E368316C288
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 19:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE7B202F9C;
	Fri,  6 Dec 2024 19:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="DqNtanWt"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800562206BA
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 19:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733512909; cv=none; b=KTANHvyN9aSyvJR1B4ajcmoFdKU2Eu1IIsbKAAQuEucG5FCs6QHRqdFEOLngZgxmObu8bD7oCyCbliBU8sRlE4QzD+8J/nOmBgCxJKDL+98rdenfWwN7FZOEDXF8/UJu6pW1d+6JH/Owz+BL4kow/EnVWKZESt5WCSMYBHmjB8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733512909; c=relaxed/simple;
	bh=0GFGArkZIeu9YFzFvIo10D81sChF5r/4lriL8Wgz9mM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lxbCWMdcefwzPxlXhOB2/YHEJIVz9EupNcjrJTbjAS+2/mRBqvxvVFfqovMQAxpvZuMfvddMzdNS9Z4I/IeWSGXbbamOPrah3whYYHUy3R47I+MDH9ZIBYULhTyDyYLrjKc1KMun9SU0y3ljnZ2FXrTB1DBCUn0Lz9X1ufrgVwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=DqNtanWt; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ffbfee94d7so19983691fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 11:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733512906; x=1734117706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=alKzgZIWJBJQIC3RtpQ5nlO/OOrtZ6jVpTyw98aDLPE=;
        b=DqNtanWtwkaJW+jNdggEKnNE0Y/rILIyu6YBbEz/XJZalfM78u5z1asQT3VBkCoZON
         n9phqGQLt0Tx/lkDxt3Y1Yl26xbvn9Ca3NoTbcKinHuY63Guu4qVb1IArEAa05N6qx9t
         sSnh0WuxC9OCh4psgjvPGbyoqar0LTW84+wlaZgMm4fEGDx+XhVSPxUJaYSR94TKnCF5
         ESGy4hL3/SUkKEeX8sWrounWjgPabMABp5eVVNNvJ93xBeI6XUDZQUQrxfiH/6VtFxby
         koJ5UhAhVhD5Bzbgq0muHfbYxNzdkCeJl/CWTYuUllBilSYnogGwXty0pkX/b2JDjM0H
         Dnaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733512906; x=1734117706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=alKzgZIWJBJQIC3RtpQ5nlO/OOrtZ6jVpTyw98aDLPE=;
        b=AjiQ3IakVMQvO62HUIi1Zy8TQdhXcatUTjwZs3CKOLarALFVtx100pAoEwMMlisedM
         /dV/2JxHmVi44ZWD/5awkK3p+L9mMu3PAaMAnM2bATf0IuN5fyrjsEax3t1prBSnTvir
         cEN3bzeIa0biI5xVoOkIdQbhGq6mrjV7HZ476KBtpzriQS54IBox3WaWhsB9ZUiL+XND
         Rq2e7aUzlaBkTMFJB+7V6EvaluTnmRyKeADhMXtGzQ/fljdgxmkzjKb0K1zH/j6eplYR
         tDvwcHCEt5DRPn3Bb2tDeMvuudq48gBhe2v1Y8rDozmW+7JTWg2YfQOrg+v/Wz9OeGbh
         eBbg==
X-Forwarded-Encrypted: i=1; AJvYcCWioToViePQWPFXmS7VYBEUNwP1SSmuDl6KGmGNvu7WPG0eVgy5S3AcQ+Km6UVT7EfaQmxGTotxr1O0fz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWeBaiYj95izWuuT+Xat94dDjUO8iu7peJBL9phk2l8f71edcq
	Z0BZIUtUfONi4VioPia3uSfCvG0EchtJDeD46I9WN3AvmvWTpF5kptwI3//JZQo=
X-Gm-Gg: ASbGnct4Mh6usVL2h3C4T5K3idlGs2LzokdKgDJiWgb3UObyvti1bizq858YIbG0y8N
	c8KSQQys9Svlobih+iuhiU8SlOVi+NBBKMRjWu7ffLZKvdtXxWo6cl1rIZLCAPgKHZPFtk3pK0S
	tF7R4lQfyX9GlJ0vIqgBm/T9zEyXjsXZjM2YIirpVBapMABJdHRv9As40b4+RyuQrk6iOkI96WR
	McU0+v68/EEnOBReIPK/iVUodbiQoZLRpr3G7Cqt4F3gGKBJq08OIoHHSCVpl/8
X-Google-Smtp-Source: AGHT+IGXrMN3PorF3VW/yScaTvpLE0Z6C7mKmkFF9Kzew6G834zYw9FfFy4W2LNLgP2XaPcVO5ogvA==
X-Received: by 2002:a05:6512:2316:b0:53d:dd02:7cc5 with SMTP id 2adb3069b0e04-53e2c2b12b9mr1148864e87.7.1733512905680;
        Fri, 06 Dec 2024 11:21:45 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e22974f20sm590041e87.70.2024.12.06.11.21.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 11:21:45 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net-next 1/2] net: renesas: rswitch: do not deinit disabled ports
Date: Sat,  7 Dec 2024 00:21:39 +0500
Message-Id: <20241206192140.1714-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In rswitch_ether_port_init_all(), only enabled ports are initialized.
Then, rswitch_ether_port_deinit_all() shall also only deinitialize
enabled ports.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 3b57abada200..cba80ccc3ce2 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1527,7 +1527,7 @@ static void rswitch_ether_port_deinit_all(struct rswitch_private *priv)
 {
 	unsigned int i;
 
-	for (i = 0; i < RSWITCH_NUM_PORTS; i++) {
+	rswitch_for_each_enabled_port(priv, i) {
 		phy_exit(priv->rdev[i]->serdes);
 		rswitch_ether_port_deinit_one(priv->rdev[i]);
 	}
-- 
2.39.5


