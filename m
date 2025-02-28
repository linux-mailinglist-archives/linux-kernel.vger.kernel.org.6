Return-Path: <linux-kernel+bounces-537764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3059A4905C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 05:32:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B0D21892C17
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 04:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2851AF0C3;
	Fri, 28 Feb 2025 04:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHpD7szm"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B151A9B5D;
	Fri, 28 Feb 2025 04:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740717158; cv=none; b=Yio+BtWP2ez8cLCQdyYuCHmZKm0AfP5evueF6vD0Lsgoh4MHKYSpDFO9C8yLWGVWka+Dl9N8+bL1FKcSXtqRVlv8qSx2Yf9f0ht2gX9hqKOpDMdv+pJnE/Btxwur2suyOnagFLnCG2OA7f1FKxYmtPQWFQtE3UM8Ec6bhP6Y2Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740717158; c=relaxed/simple;
	bh=4rp4ZuH22jaaPDSR9maRyjVWUX85BHaTNLUELPlHAuo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qhCICIL2dMp97aMAboVeejrgVsUb2qiqW7tPRs7Sr9ScPigP89aS/UEfEMc1fKHRCOO9EvfeN3DIDammIBuDJMgfsFcko9FF1BVKyI2MiPBxGBb5fC8QOdeLBloDyA8TFubI596pVFXtuzDGcYoNGpl/MMDveK3GObXAadi0GqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dHpD7szm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2232b12cd36so24248475ad.0;
        Thu, 27 Feb 2025 20:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740717156; x=1741321956; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NbsovWlJl3HjP6zWFnVAwJ1WjNbEUYuyjrWcVHIxRyU=;
        b=dHpD7szm3EfAopFiSRzaFIyPtj+7PraUvPw20erBpQWrZ59ukCgbTUwxfdW4qUx2dB
         JEMrZ+biVuSqRgthouc3rFb4gm/3q9Ac4hRnSPm43uo/ipadlU56GEa39lPsYvkBW2da
         T3AQscyXoS8jyX8W4+Rbg8qL8KibchgcwALEj7Wpvf5JYKSbv5da0ZC2QyGv7eV0LPl+
         0vG7QUSTUhNPxKdhrd5O7+DFu0Q2OdYzNX6bOMpYIzz2SLE+OWEcsub1JMIst1nzOPy3
         JU1JNA3pYqVq0nhBCMbMmLbXa5B32Svrmh7TMpqOQkl5Acgzddom8mV5LJMAjL1i6Gko
         IYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740717156; x=1741321956;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NbsovWlJl3HjP6zWFnVAwJ1WjNbEUYuyjrWcVHIxRyU=;
        b=tHMcuMh5dqT0H3bFUa0HOiJTBNc+CU7zv8rkv6bb91GxEEwRNQfUytj6gv8+L3fouP
         Py7StogJSmYu7t9jxx+vgdVixiG6G+j/AO+MydC+9YQpuRkz3ei5QuEbNkeouoZBTr9n
         AwjJKMXY8TIv+XMxfs8yBjXBnu+DUvsSBR194p3Wswd4x3PbhpOl4ZOU4iOuteJTFrBA
         TgvhLyPyPFY51xA9wK9MBqwGhdi777UUKBuIsbxIdqgDTfBbQTqhhU1YaOXYWZF8zzCF
         mgyA6VuR2Fe24LT9lgRYU7nFEeXEUg7DZ3wS+p9p+oUANrVZaABPdhca0DYCFOGMslZf
         Lqtg==
X-Forwarded-Encrypted: i=1; AJvYcCX98DTO4P5HuetI7dIGRiP2bgahmrkosmYmKdMGiLTtEoffclq3j9x5aLRtv2z9Atk+VH6O1zGsfbjmL/NJ@vger.kernel.org, AJvYcCXuPrcHwP4maPlFrSX8CDa0S4A8KlIejX3rIJ4jg8RKhfRKZZ+PMQ9oMt+d7mGWAT+pgA2cr3Ugxp+G@vger.kernel.org
X-Gm-Message-State: AOJu0Yysp366jKVKt3Vj3DuUQvKdnKGxc2uSmOB+u/VnnUKYUojgYC6s
	fa/g1Mf+DEBffee0+3Q9ctSXseoJ3iM0QYpFuBh/G9CdT/NUvuTRkQqtUA==
X-Gm-Gg: ASbGnct5RoN4W9+WiNbr9YVz140BXgVYZbQ+NsMzciYzbv8cBmJJQFq9m77HcdeIupp
	eYrI4qDfmH0gC3WnaOgksoEbj4JIct9y5BST4r2xnBpdcq07mtgCCTQDpCXtwfbwZ9x44tDqeh+
	ev55PNMd95gzw/tKmghh70sjrElD3GjfkK4efJhjOQZKdsAKIwQ7ELp7zw4lnYKwfmdOmz7pGCr
	QmHSPooc94/BAN1LkU+8V4pRRIsk2EKvLOZSDu0U15FoA91IynhPxjwGRYgWXcvdURjoq0i4cLp
	wlkF4P1qEwwpx3co1k9TITdQvNFw
X-Google-Smtp-Source: AGHT+IFIFTXj137/X/rmkDNf2WcTJ5lhprjIpnLzgn+Cb3Ywj0z6i3TumH6T6qK6jrOETPuJoy2hTA==
X-Received: by 2002:a17:902:d48c:b0:223:5a6e:b20 with SMTP id d9443c01a7336-22368f6a0femr25154815ad.7.1740717156275;
        Thu, 27 Feb 2025 20:32:36 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-734a003dcafsm2738204b3a.132.2025.02.27.20.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 20:32:35 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Subject: [PATCH RESEND v2 0/5] arm64: dts: apple: Add DWI backlight dt
 nodes
Date: Fri, 28 Feb 2025 12:32:11 +0800
Message-Id: <20250228-dwi-dt-v2-0-69e450bc4bfb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEs8wWcC/12MsQ7CIBRFf6V5s5jyqBKdHOzqoKPpgEDbl9hio
 EFNw79LGN3uuffmrBCsJxvgWK3gbaRAbs6Amwr0qObBMjKZAWvc1Yg1M29iZmH6oKXqhXgYvod
 8fnnb06eI7nBtb+3lDF3uRwqL89/ij7ys/6rIWc6ywUZwLYUUp2FS9NxqN0GXUvoB9S7ck6QAA
 AA=
X-Change-ID: 20250220-dwi-dt-c9c7af33bd16
To: Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1830; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=4rp4ZuH22jaaPDSR9maRyjVWUX85BHaTNLUELPlHAuo=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnwTxg8y3rR5I3zbiOGRc9dw3HOraEEJaxBIm1t
 EUiMRlANGyJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ8E8YAAKCRABygi3psUI
 JAAND/4qzqZlQz3BLTSbeu8maFlAIG7yGIZnEvuAovtFJ9y/J0skR1s2VSx+IQHf7kyfIe7omYf
 /MPTjOiFG4NfeXGUJLUSu4awYgUrn9ZT7OWLfwu1aQtdgrogq2gqbL6C/T9dVTINYdPhc1eMpHE
 QxuZWX61bnCtui/lfuA/hxrPYaM73bacMqCbTkMAcUqAY2gEik+d9/DVvORncGjlIXwJBtsEwhW
 5grg3wukTWwzq9pSbgD5mehNcU6miA8aaT/35nSbzlsrwh7DjI8YA0MFvEsu9w7j3ir8ibRyId5
 VC6wLAgppug8MVcEdj/iIxyMZwGJmDbH+DK6I7vyVHtFKMyVf+tTgpbydoDbvexp7eqJXAc9r4i
 MCeaf0DwyBp8l+La2/6BgNqh1t1a/sh2bBMbzU0XgxYTanzt0IIlZCe2Jcp5t6eYOkS16eiRYF+
 VXzWdWd/EHl6XFqotn+TcjdgjMYiFIbWCS/3s5Ji71ToeViZzsvDOyGlnsSf6gkNOsmx+mymPgt
 THbznCQB0qAfCUPEk2DxZkFLYHE4y9qszprG/RxvQURMRXdtv2FuiP4kI2F/DBQA+xlqyVTIe0g
 eBf1s/gwMbi3AzFH7K55wVzM/3em73ix4atBLLVxgnaJsTt+tSsKz9psJlVs+ZV35saoncCvFkN
 fZUc+zJCt35abDA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add device tree nodes for DWI backlight found on some Apple iPhones, iPads
and iPod touches. Not all devices have this feature, as some devices
instead have their backlights directly connected to the WLED output of a
PMU or use self-emissive panels.

Resned because a network error occured and some patches failed to send.

Devicetree bindings are in the driver series. Last version at:
https://lore.kernel.org/asahi/20250214040306.16312-1-towinchenmi@gmail.com/

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
Changes in v2:
- Fix typo s/iPad touch 7/iPod touch 7/ in commit message.
- Pad "reg" property with a leading zero when needed
- Link to v1: https://lore.kernel.org/r/20250220-dwi-dt-v1-0-d742431c7373@gmail.com

---
Nick Chan (5):
      arm64: dts: apple: s5l8960x: Add backlight nodes
      arm64: dts: apple: t7000: Add backlight nodes
      arm64: dts: apple: s800-0-3: Add backlight nodes
      arm64: dts: apple: t8010: Add backlight nodes
      arm64: dts: apple: t8015: Add backlight nodes

 arch/arm64/boot/dts/apple/s5l8960x-5s.dtsi     | 4 ++++
 arch/arm64/boot/dts/apple/s5l8960x.dtsi        | 7 +++++++
 arch/arm64/boot/dts/apple/s800-0-3-common.dtsi | 4 ++++
 arch/arm64/boot/dts/apple/s800-0-3.dtsi        | 7 +++++++
 arch/arm64/boot/dts/apple/t7000-handheld.dtsi  | 4 ++++
 arch/arm64/boot/dts/apple/t7000.dtsi           | 7 +++++++
 arch/arm64/boot/dts/apple/t8010-common.dtsi    | 4 ++++
 arch/arm64/boot/dts/apple/t8010.dtsi           | 7 +++++++
 arch/arm64/boot/dts/apple/t8015-8.dtsi         | 4 ++++
 arch/arm64/boot/dts/apple/t8015.dtsi           | 7 +++++++
 10 files changed, 55 insertions(+)
---
base-commit: 5744902a35798e516def50348356f867a6c1f1c7
change-id: 20250220-dwi-dt-c9c7af33bd16

Best regards,
-- 
Nick Chan <towinchenmi@gmail.com>


