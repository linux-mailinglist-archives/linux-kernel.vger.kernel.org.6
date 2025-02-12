Return-Path: <linux-kernel+bounces-510831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B64A3229F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:42:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC60165578
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E6D2066E0;
	Wed, 12 Feb 2025 09:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3l3gtxw"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE0F205E0D;
	Wed, 12 Feb 2025 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353316; cv=none; b=WnA3XAq6yySw2lRtXaB7Z3AJtsq8zyYtpV+lDgWhg7xF2E6T129aTtuLFaiEjSA4X+MXMiQ4egBjVamrKun5gXiiYgHvS28tzdTnvB9LVJKnqGXUFlSmrvcUhTdKiHU32bST+JQphjjSkGDwO+YI0+4ApkY9BVsZ0hGEI3VhVts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353316; c=relaxed/simple;
	bh=dUap/SXaXQa38UanPgSSKRcCPjZHGhoEnFAFFOYB3RQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=I9rC70/ip+8NdZKstm0fw6xR2F9mMzd7gP9KSv87tdRuMzIx0xSukiSpl+ByxAYHt52p2CpTs6JnEPNZEOzyEDl+RylAfOHXNuIIsaLeI6kAUgKX3aLmpFngrbStn6sEqqsXqOyFnC1w86qOuuns5mE7SzE+p7ia/eNneA8dNNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3l3gtxw; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-726cdcec232so1823509a34.1;
        Wed, 12 Feb 2025 01:41:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739353314; x=1739958114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2lYXt/3Bss7OL7a9qiIyaDSSXu34p7TnxlM9/4leqMM=;
        b=J3l3gtxw0sLk3tYIzW2ANYNjBg3+3az5KJ0rNg4TXALYmZguVfX6jlcHXdgV0B3YbI
         FYb1UjAVwOz9tbKQr7YJCZfkTviBtFvYJ2fZ2uGGFt+ROZOWVxuIeb1XaWb/2+v6UbgV
         aIMLzlSdJb2UpcAYP57JkXgVsShherxGoGCkeFAk/X5qKa+RQxgR0UDglxiddXb0/LCN
         4pkg8/36pSaDe1IthUFAva6lKeT654Gqg3DhS+R7L4/TjiwWu5cKq64GCiHfgyOjd3VJ
         73LTDpwBAzJKA/Eh9uen/m410Sm0RMD8rTZqpbHEYxNsnU4lOEzkJf/vYS7Z1GSeMXBv
         OrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739353314; x=1739958114;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2lYXt/3Bss7OL7a9qiIyaDSSXu34p7TnxlM9/4leqMM=;
        b=KN5W/GbwITsBZc+DC7C5FXCaUzQGxP1e0P99BBzTK0hgTyqQhE0gKJPiQU7stkl8TJ
         yGX4Tw/600svEhNI5vUY0ST3YMHTgmEJUbe4lI2QVUbVdM/QvWvfiv8ZkfeCRyBgXQvq
         6HHwkE5qPgkbyt7axZTPTqAYhXRLuaOICRIjY1pOXdZkowdaGCoG3oYjYXiKuXxN/XxG
         H41TzkhlhNFWI+763eZXmEvVhsWHpO76JekMzufj7g6UcFST8WBLpLe/PA9EbURQJto6
         tdA8wvzUG/xkkymYcRcEYf9NmUHqhinB8N0HmK4TOuvX686v7MYSXX1CRI9ekCQCulBb
         e50A==
X-Forwarded-Encrypted: i=1; AJvYcCWp7fd5j4WX+pgbGjZOE3pqZF5yMldfoqYw6OmHSmdLYy9a5BnAOOir8OpUdf9LC+r7ZAFvd9Tgiz11@vger.kernel.org, AJvYcCXAKrIltlRNfbKP2VSFaRRLzvFQl55e7cNqB7IVuIyRHpdGz1YkOeK5vWsOE7qaFjNX/G3jySln25rwrTIZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+QhLs7bk/C7p619+JWuWbRTkNAPNNxmLzy7tScEgnEFco7nlH
	0jhezbPqQAvu06W1nC0pCWGW596G0zw2Kc0sDnTZt43wOYeQY5x1
X-Gm-Gg: ASbGncu0PyTY1ZhmcrwWYBjpnEpEAJaPhX/2CLkNNRIDvyzPJPM7d+mFcPkhhj50ZtW
	sx7UzKQtGTYebLpHPpAPmmd6aUGyQkUCjM+H6qoz2jUXPMtv8hkrd119cUKI9viCIe3K7XZ7Pgr
	NU04w9dpFg3ZPuhFh90To2YqzrJqSTF2K/xeIrNCslLRWQjaHfMdwfXIWOsU5YInaRXhkUw5sjE
	7YiDGxehbAGbNqyyLEQc/obeo6peY750my23M3U2djGxda2PVubJV7i7VjgzdFN1Im2DzRaFLW7
	y2dJKLeFR/l8HrRmZdrjYUZzwQ==
X-Google-Smtp-Source: AGHT+IGMUCgL6dH7JKQmunmpmXk80dIsegcySmRMCkVerehVQyr2tMV4lRmcqcwVBrmjBGppiol5gw==
X-Received: by 2002:a05:6870:56aa:b0:29e:f61:3b62 with SMTP id 586e51a60fabf-2b8d646fab0mr1704840fac.7.1739353314366;
        Wed, 12 Feb 2025 01:41:54 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b8a2ab07f2sm2417113fac.13.2025.02.12.01.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 01:41:53 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	guoren@kernel.org,
	inochiama@outlook.com,
	krzk+dt@kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	chunzhi.lin@sophgo.com,
	inochiama@gmail.com,
	sophgo@lists.linux.dev
Subject: [PATCH 0/2] Add pwm-fan for Milk-V Pioneer
Date: Wed, 12 Feb 2025 17:41:44 +0800
Message-Id: <cover.1739351437.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Milk-V Pioneer uses fan as cooling-device, and speed of the fan is
controlled by the first channel of pwm controller of SG2042.

This patchset depends on another patchset for the SG2042 pwm controller,
the driver part is now on pwm/for-next [pwm-for-next] and the dts part is
now on sophgo/for-next [sophgo-for-next]. If you want to have a test,
you need to apply the corresponding patchset.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git [pwm-for-next]
Link: https://github.com/sophgo/linux.git [sophgo-for-next]

Thanks,
Chen

---

Chen Wang (2):
  riscv: sophgo: dts: add pwm-fan for Milk-V Pioneer
  riscv: sophgo: dts: add cooling maps for Milk-V Pioneer

 .../boot/dts/sophgo/sg2042-milkv-pioneer.dts  | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)


base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
prerequisite-patch-id: c4b7f2697276f9278f13e3f2f54669eabed14157
prerequisite-patch-id: e6e1753842784bbc41eae5917470d4abfacd21a0
prerequisite-patch-id: 768254e961eb246d230258ff33922e4f2a36597e
-- 
2.34.1


