Return-Path: <linux-kernel+bounces-521978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFC2A3C485
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 17:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C55F3BB10A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 16:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802711FDE01;
	Wed, 19 Feb 2025 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="LqSHTHpe"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6ABB1FDA85
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 16:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739981281; cv=none; b=aguXThFXwVsb2nF+7bBfLwS8gPveMDpmW4ihEYlx85zZi/OHvt7iVUlqUVlqeAkySg3avkFWiI1wJX2TJjosm63KXZinULGzmUHjCV2T/UmHMpYkFNKzRnf43wbN47XQoxxtigM51vsLXOzRxfjysahEHQsQ8ujOadXyIACbrzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739981281; c=relaxed/simple;
	bh=kudtpuxsWTIFCFoKJSMw9KCgS0xd5Fcnm1gsja5/LfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lU0CrASHo+8hyj19sX6qI9y2rh9gCbZacDi35W3hmSby0y6tYGtbVNysvlIgQ/3OOcIac68TXJnXXeHHooLdGYBrVrxWFI0BF4a/FqWnHziF9ZdbS+9CGbe6t/QncZ2UNpVbC7PNGPAinqVV2NFQJ7KIBwq8k6Vv7VVSeECl0/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=LqSHTHpe; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab7430e27b2so1173994266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 08:07:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1739981278; x=1740586078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DwMMGNmWOuotqPv4IxkXyX8g8+4F3yGXxMrg8cS3U8o=;
        b=LqSHTHpeck28688smqBzzVnK+ow4sAKr/DVBi/7QsTH9K/Ha5EC3/cYKEpp1jIHm30
         4ABE7l/DQBRPzmkgXFMfcERNrPfR/VDV28UCxKo1jOeO81IJBU3fQt0Id+VaMIt/RPBC
         iO/7vMQ+i1tXcWjmEVMYC1UwnQtkHhohHA2/VllDtGihY80f9rCCmyrvNH1ldk0OdKGi
         YAroX78iM4F97B//OxL9ZYjnDpMvHKmnlogxFbcxl3j+vgxDHAuKM7/9yLbT6vPD2Xnj
         m2ksoUlxdVhg/+21VklB+6H3bX+dsxJ13Q0t69Q5gzYSNZrtFD58iBJTToZX/DGkSwTF
         gW8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739981278; x=1740586078;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DwMMGNmWOuotqPv4IxkXyX8g8+4F3yGXxMrg8cS3U8o=;
        b=gkifRtGFqaSsaqWG0CT6cTkWyu3gjaRAFFeDkwYu9wlS5NxsTuLZW5ru8B/V08fFO4
         cdD3EVf7q8XQ4jvMDfZsVmcnjzabS8gZj6Q79RORE7F1VUMbZD/U4LBJvmcJdHS16q2K
         kELcUTcfelf4Q/qW3NwxLutfIHJ50gXTerNGZIShx0P+M4y8zINrd0Z3hbWxcx9ykpYB
         JWi55ZswDx3PRvD57cA8VOpZbBy5Vyu3N9QBUY8x35JUR26vj5bCW+YlMar8S2OhBFdO
         tN/KSLBCQMDk76BLcecNOyuc1D3+riltlu8yLavXt2B7NXvbmthQBOmIfaGWtPWjN/7K
         sI4A==
X-Forwarded-Encrypted: i=1; AJvYcCXp8fNKPi1B5B89VUBcNIku/7LKJ/2BhalfZS0doSX3mw6cmy8XyEDvqs8QClkfFrTihcNiyFa7IcFIdJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUPujrJx1mxiSJfPeLqqegRkFclUcziGXHISD7tDWGWRJ08GnL
	EKNIZ/3YZxlsQHxQVytcMnGtGhIF/q4VbHdhqbaI/KfqC84S3VFotktplNbCMbE=
X-Gm-Gg: ASbGncsetUfKyt0bTHq5uZBuvWjlN6rw5QTdFwrbAUCCOcvfAUGOMIwAY2jxcbmICWW
	EKru+rlRSKUgdOUMIaTMZWTJjpmpBxKOrV+RHrXGaFBVjyoZA7nWg6rnyosdFpveXbOc4iuCRuu
	r+knZ3RiyvM4tSAMXLKC7L+Kn8UwMVzos0Ig5tE2xBsQ4Z7u6Z9dHAHrWMtqPBGn5JRQby8nc5r
	kCcWr6egYvYyAMunM6HPjHN5ZQuSSGAablvAuIPFiRCgsrSo65ZmuQwywcDz4/gtzDDJqIkW57n
	IvWQQZio2/SFc9DlpJ2QkKhID/8j6gL2vr0J+LbzKzsK
X-Google-Smtp-Source: AGHT+IFb8j7IIkxOR/n0tzGJ+yjodWKnwFUug+Qx75yEhRVyIDQOoSAzY1twMqg5YS3jbZDvVYlQxw==
X-Received: by 2002:a17:906:9d2:b0:ab7:5fcd:d4e4 with SMTP id a640c23a62f3a-abb70d6b001mr1606723766b.41.1739981278058;
        Wed, 19 Feb 2025 08:07:58 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbc0d0b882sm327791066b.109.2025.02.19.08.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 08:07:57 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: yoshihiro.shimoda.uh@renesas.com,
	vkoul@kernel.org,
	kishon@kernel.org,
	horms+renesas@verge.net.au,
	fabrizio.castro@bp.renesas.com,
	robh@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH RFT 0/5] phy: renesas: rcar-gen3-usb2: Fixes for Renesas RZ/G3S
Date: Wed, 19 Feb 2025 18:07:43 +0200
Message-ID: <20250219160749.1750797-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series add fixes for the Renesas USB2 PHY driver identified while
working on the Renesas RZ/G3S USB support. These changes are
needed for the upcomming RZ/G3S USB support (especially for the
power management support).

Series (with [1] on top) was tested on Renesas RZ/G3S with consecutive
unbind/bind and data transfer tests before/after the unbind/bind.

The unbind/bind was also tested on the devices with the following
device trees but w/o checking the data transfer (as I only had
remote access w/o USB devices connected):
- r8a7742-iwg21d-q7.dts
- r8a7743-iwg20d-q7.dts
- r8a7744-iwg20d-q7.dts
- r8a7745-iwg22d-sodimm.dts
- r8a77470-iwg23s-sbc.dts
- r8a774a1-hihope-rzg2m-ex.dts
- r8a774b1-hihope-rzg2n-ex.dts
- r8a774e1-hihope-rzg2h-ex.dts
- r9a07g043u11-smarc.dts
- r9a07g044c2-smarc.dts
- r9a07g044l2-smarc.dts
- r9a07g054l2-smarc.dts
- r9a07g043f01-smarc.dts

Please give it a try also on your devices with [1] on top as well.

Thank you,
Claudiu Beznea

Claudiu Beznea (5):
  phy: renesas: rcar-gen3-usb2: Fix role detection on unbind/bind
  phy: renesas: rcar-gen3-usb2: Move IRQ request in probe
  phy: renesas: rcar-gen3-usb2: Lock around hardware registers and
    driver data
  phy: renesas: rcar-gen3-usb2: Assert PLL reset on PHY power off
  phy: renesas: rcar-gen3-usb2: Set timing registers only once

 drivers/phy/renesas/phy-rcar-gen3-usb2.c | 134 +++++++++++++----------
 1 file changed, 74 insertions(+), 60 deletions(-)

-- 
2.43.0


