Return-Path: <linux-kernel+bounces-550614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CED5A56206
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802DF3B2C5E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 07:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651B21B0F11;
	Fri,  7 Mar 2025 07:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QYvq0+LU"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908F11A5B91
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741333824; cv=none; b=Xt88BQccHToOKo3boPgcb+KdoXhDJweQwDng4zuVpTHw1LkVt1pmoMWvYkZly3MapJewAockxExVUmYj9Xnokf6hFct7tTfY2pC/aPsFl511oDs2FfJF+Dul7PBUBH1xx6UgJBwbE+FqdunIhszLNPGYzmGRBebPKKfUzYh84OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741333824; c=relaxed/simple;
	bh=bqH27dhm4vqCW2KMETRfbzKIt9nb2UJ9bHwplDfeGC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LsqENaK+55Ig6d8ihdblXwIkuetQ/1ZjSMdSrGIUlvisDcO2AAoE8NPnrcEZsE5s0hegcVaGaxBOAsE66RFS0jNSkXa96B0BEQwikdauTc9RytHjPdv6K1BW5igCbRiJlfI2JZgvcWETEVRrV9yMaSo+AuRx84mzxkxSXHCFtlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QYvq0+LU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e52c1c3599so2406943a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 23:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741333820; x=1741938620; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zfctkjh729cDVPkdN9atc8gq/aSrxKUuXnRIylg+etw=;
        b=QYvq0+LUYtGaowqmWUKGU/PorqKBuQ8FMqyEF+ZXfW3s9dXwYO+ZbqJE70zIQLS4G8
         x6a94RRKWTJnTDWZA4rQ7ZaUQaDLJ6PhdYoLJWeQZGxUQvWvXbJIlxJFumJj9gjCTPIb
         6vX94fDLoC9bm0Bkw32EIUnzNRmmpeDPH7wJ7XNrL7HevfW5zswsha0gi3VoL0yFB4Gs
         Jq1fhrZe7IWnxU8bAMIZabIlfZT+AHqgcv1T3qM+0M0OU+Lh6ZPNuhitvku90kn9Oj/i
         fl3xXs+b9CGc+b5unLvoai7EeFcSoTDbT4jn8Ye/vNvj/heSQy+4esbaMTCQrNVBMkRf
         vWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741333820; x=1741938620;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zfctkjh729cDVPkdN9atc8gq/aSrxKUuXnRIylg+etw=;
        b=oUf1dz+0mOjruF2nIdkIWUDaLKCFYxDnwMVDh9uEZha6tO5rXjkCtIziHxpG1ZrQob
         6DAAkxYPVq+6zEckVhTQ/q0QYDJ3ZxE+yzLypMwpU7xjCdPQIiW/4/5SMDxwstDhWpzU
         T9hW31MPZxEOpAmy06XuCHSROglPylLHPgK71aADevsKrowBulu9kttK0nq0RgSZ8ntQ
         HhW/OPdy4NgnQP4VXDsDQ25QBu3LGrBOtCxuTbcncoG6x4MnQ6ik1huyDuJBEq8dxElA
         hgR8vq1hqcpcmfar3br4UdUeqOWpU2NzpKcErvAxZwvSeyAhATndgipQQFIwRS2TphXD
         zVEA==
X-Forwarded-Encrypted: i=1; AJvYcCWYC5mqZauhsPoPcC3zFaCSxBn8zs9byM9H/slIjotl166SgVg7joXQnwTiBJ5Uef+tEpazXAiaZMTL/sI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSaYVWWgDgmn/6jNXl+bdApnBk7yX4mxk75z95F3VWovJUsNdd
	At8By4L7UxWl2gm+dJzH77ZI8Lu+oAESnUJAIPPRGqMFeiOQ7T1VWJo30AbfOHc=
X-Gm-Gg: ASbGncv1UeMO9hqAk6PelmJZZgqOA0aIhlDvVOFhx0L1QMjhlR+zAAfuk1mv3UJkkXc
	C8VExArVCS6zhhwl+8bLjTtrvLtDe4Q8zQee/CxVrPrIA6TNtuvNcGcJ+6Ue7ACvMibWRIaxbgK
	7hrKpcklzEEiy4KOa85c2tjssO9sH6wsGshsWJw65gPJA0QJIhTADFAWdkGooke2SCqAnnbaZHt
	5xV3DLTHTyZtJPVWj2cNR3gwI76pB4oQhlvHxfrtlHMh7MmkELwUY0Hcd6GlVXr8pdZXgcKNB8d
	aMwvk6n3w/NlrLZkY9PRtV671YSlCLFpyDxxbQquq6+Ga50AmMSqNYUtXqbJP81DHL+txbmDxce
	DpkmSriUNQmM4wmMEGQif0fTFiq/m
X-Google-Smtp-Source: AGHT+IHSTYkSFpMW1RFfKaWXb1ATMwztSGSZ5Ez0LczLYAG6rFexYL/a+DB0sXugidVUGNZyN8XuBw==
X-Received: by 2002:a17:907:9705:b0:abf:7026:13a2 with SMTP id a640c23a62f3a-ac252a9e2fdmr207923666b.17.1741333819756;
        Thu, 06 Mar 2025 23:50:19 -0800 (PST)
Received: from puffmais.c.googlers.com (30.171.91.34.bc.googleusercontent.com. [34.91.171.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac239483a18sm228224166b.43.2025.03.06.23.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 23:50:19 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Fri, 07 Mar 2025 07:50:18 +0000
Subject: [PATCH] power: reset: reboot-mode: better compatibility with DT
 (replace ' ,/')
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250307-reboot-mode-chars-v1-1-d83ff95da524@linaro.org>
X-B4-Tracking: v=1; b=H4sIADmlymcC/x2MzQ5AMBAGX0X2bJMq4udVxAH9sAcqWxGJeHeN4
 yQz81CACgK1yUOKS4L4PUKWJjStw76AxUUma2xpclOxYvT+5M07cDQ0sG0KoGisq5FR7A7FLPf
 /7Pr3/QAg3/T6YwAAAA==
X-Change-ID: 20250307-reboot-mode-chars-294ee492d8e1
To: Sebastian Reichel <sre@kernel.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

This driver's purpose is to parse boot modes described in DT, via key
(node name) / value pairs, and to match them to a reboot mode requested
by the kernel. Unfortunately, DT node names can not contain certain
characters, like space ' ' or comma ',' or slash '/', while the
requested reboot mode may.

This is a problem because it makes it impossible to match reboot modes
containing any of those characters.

For example, this makes it impossible to communicate DM verity errors
to the boot loader - DM verity errors trigger a reboot with mode
"dm-verity device corrupted" in drivers/md/dm-verity-target.c and
devices typically have to take action in that case [1]. Changing this
string itself is not feasible, see e.g. discussion in [2], but would
also just cover this one case.

Another example is Android, which may use comma in the reboot mode
string, e.g. as "shutdown,thermal" in [3].

The kernel also shouldn't prescribe what characters are allowed inside
the boot mode string for a user to set. It hasn't done this so far, and
introducing such a restriction would be an interface break and
arbitrarily enforce a random new policy.

Therefore, update this driver to do another round of string matching,
after replacing the common characters mentioned above with dash '-', if
a match hasn't been found without doing said replacement.
This now allows us to have DT entries of e.g.:

    mode-dm-verity-device-corrupted = <...>

and so on.

Link: https://cs.android.com/android/kernel/superproject/+/android14-gs-pixel-6.1:private/google-modules/power/reset/exynos-gs101-reboot.c;l=144 [1]
Link: https://lore.kernel.org/all/CAAFS_9FuSb7PZwQ2itUh_H7ZdhvAEiiX7fhxJ4kmmv9JCaHmkA@mail.gmail.com/ [2]
Link: https://cs.android.com/android/platform/superproject/main/+/main:system/core/init/reboot_utils.cpp;drc=79ad1e2e9bf1628c141c8cd2fbb4f3df61a6ba75;l=122 [3]
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 drivers/power/reset/reboot-mode.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/power/reset/reboot-mode.c b/drivers/power/reset/reboot-mode.c
index b4076b10b89376a71ff6f6c3ba807b20e673de86..fba53f638da04655e756b5f8b7d2d666d1379535 100644
--- a/drivers/power/reset/reboot-mode.c
+++ b/drivers/power/reset/reboot-mode.c
@@ -23,20 +23,29 @@ static unsigned int get_reboot_mode_magic(struct reboot_mode_driver *reboot,
 					  const char *cmd)
 {
 	const char *normal = "normal";
-	int magic = 0;
 	struct mode_info *info;
+	char cmd_[110];
 
 	if (!cmd)
 		cmd = normal;
 
-	list_for_each_entry(info, &reboot->head, list) {
-		if (!strcmp(info->mode, cmd)) {
-			magic = info->magic;
-			break;
-		}
-	}
+	list_for_each_entry(info, &reboot->head, list)
+		if (!strcmp(info->mode, cmd))
+			return info->magic;
+
+	/* try to match again, replacing characters impossible in DT */
+	if (strscpy(cmd_, cmd, sizeof(cmd_)) == -E2BIG)
+		return 0;
 
-	return magic;
+	strreplace(cmd_, ' ', '-');
+	strreplace(cmd_, ',', '-');
+	strreplace(cmd_, '/', '-');
+
+	list_for_each_entry(info, &reboot->head, list)
+		if (!strcmp(info->mode, cmd_))
+			return info->magic;
+
+	return 0;
 }
 
 static int reboot_mode_notify(struct notifier_block *this,

---
base-commit: 0226d0ce98a477937ed295fb7df4cc30b46fc304
change-id: 20250307-reboot-mode-chars-294ee492d8e1

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


