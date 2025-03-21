Return-Path: <linux-kernel+bounces-570819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 631D3A6B50B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 08:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E58A189F16C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476CA1EF090;
	Fri, 21 Mar 2025 07:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4PGKK/e"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5648E1EEA31;
	Fri, 21 Mar 2025 07:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742542113; cv=none; b=J2CItLvCD3hDeV9apaY7+FUf/RjlsPzxEXrell4t0RP8wYGJD6FbBe3EMmtgE1WTzHYoxtT2CBvS57sKblK4rL0iB5r3TW/HsbBZwB8ASPrjomIu/9GgBASNIGEjnOj2EO6M1to/QEalEPlN9a/Z5Pr0GsmLQV4xgSTWW+4Pm6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742542113; c=relaxed/simple;
	bh=P26V4Vll3LYpWjYPKGRYB+hCja9t6ZA02VGXue+Ra5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AHYy0/R97YCKpUuBZPKL1kZ1gvRVgKyBKld8+b3wYJJhNcpHYXT70e685L3FIxsXnlIm9omnASbdfkiC0IdhMK0vIovfj9RqN+xleV9xz4QEsio4CPPU+bkWfu8N7fjT/Mw6gWf/k5L1MZ7A9kgeK3YuLy64LDtVJIJRBKFw7+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A4PGKK/e; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-223594b3c6dso36654825ad.2;
        Fri, 21 Mar 2025 00:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742542112; x=1743146912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQ6AZvpz6rhEfIMNob1PWyEst8krux8q3uqPjk7Bggg=;
        b=A4PGKK/e/d8TZUu2A7RGpyJbrESw2Zm61RF4asNFGnhDxumiht6B18YpXzfppOO1yE
         +ZRB9nTE+S6WJSt9bckP0+/L152Azcke+iYjWdVVvSD7fCnOPX46rMt0unA8uc45hIrl
         oQ7KoxA+IEl1xFcmRJquFyBx44FRwtW2UTCteQHKrpTv4mh3sLWN25UBt4nAuhzideWQ
         ZLUOZe+ypM/v/D3yhzeqHZ6G6M8AZOKEEWAlFc77XPojOOGww+ko9YeaW8oYsEtGbYiO
         sKJ9qbRRg5yv0SCuMAwOEUnK1/Ic46lvWqa05cGSANpiVe2K1pUsY8Q/shBDh52AQ/o1
         fiTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742542112; x=1743146912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQ6AZvpz6rhEfIMNob1PWyEst8krux8q3uqPjk7Bggg=;
        b=uAVzW48TnDUSFKBq4MylWFDfTmmfb4pkip4YBI4A4znNiwOZIi3Pb+B/b7o/AOVZs9
         uCMj6i1zZM8hiHr2v1EV/CUM7yfPCKyL+QDPWaDM74TW3wu10IZlzE4hwLs3qkgljJ7x
         /0a32mUmTDCX1/NqfIF3JrjEHQYFHbfZ6yO0p9NvPJYgK31B8Ntx4oRw63mpE89TKAQJ
         C4PAWszvxXRKUVUQxFNnXfid4MdMAzUrzDNND1orS+zSGtJwUM3cgXClreThr81oEjdu
         GmzgUnt6ExJ/ebY9xtnM7muOBD0HOQChSNr8vm7n5Xj1LDZ1ok399lhr0QGh07TFvKU8
         cz2g==
X-Forwarded-Encrypted: i=1; AJvYcCWW/zhZi8GUeTXMIDDEafy5b6mjR3lbtC8qPHDV7yYYwdItnM2IdH41+1s97Rfu7I+1aVFCfyiNGRIgpUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXLpReXabHRkt6m1O7ImLyMR++WTEFYj6y7XVZdD/Dz9625/4E
	BJsl5ZpwlJWhpjCQYbmgv6qY0tDhEXgC4SwAfMjUe91zVn+SJgXO
X-Gm-Gg: ASbGncsSwNIvAoT+c3Up13nH/RPxk3IMI76CmvF3TMeZ+TSMA3ABY23690xg09pqQ/e
	5psFHOblAdJHG6y8w3Bb5pimZptgMb4oHmVXfTrOcP15UbkMifVSbsYNm5s1WQysaY+Zzbdg6nj
	7NOLQvbP1MYDWw1ES+Q78Vfvu3qGMS706Rl34dNOo6lkDchOCqMTrp1YgW7/vLMRWkAT7o3ObB8
	9Vg+i3U31kxhx2FQ7Q/sClW/+gIIBY8+FDwpWqTC7hYIK0XnQg8J8YAkHxgIcCyQQF7rPrNBCoz
	Wb5FBg1fn8BK5AlyPC7LzjRe6v616xHOJ89+KDfGt+4EsIifsNWSPDdZ1C2g5WSR+ny017ODm2f
	Z2oy2PHz4hDopGqF0nWgxWg==
X-Google-Smtp-Source: AGHT+IF7FqBLTpoqu0WbqKOuE+QLRcd920+js8xSlAK+76OhtVDhNbPYQwPAH2OcbN6qA0DGpJLXxg==
X-Received: by 2002:a17:903:19c4:b0:224:912:153 with SMTP id d9443c01a7336-22780c546b4mr50211195ad.5.1742542111611;
        Fri, 21 Mar 2025 00:28:31 -0700 (PDT)
Received: from localhost.localdomain (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f396fasm9862265ad.27.2025.03.21.00.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 00:28:31 -0700 (PDT)
From: Potin Lai <potin.lai.pt@gmail.com>
Date: Fri, 21 Mar 2025 15:26:03 +0800
Subject: [PATCH v6 02/10] ARM: dts: aspeed: catalina: Add Front IO board
 remote thermal sensor
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-potin-catalina-dts-update-20250102-v6-2-4bd85efeb9b4@gmail.com>
References: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
In-Reply-To: <20250321-potin-catalina-dts-update-20250102-v6-0-4bd85efeb9b4@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Patrick Williams <patrick@stwcx.xyz>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Cosmo Chou <cosmo.chou@quantatw.com>, Potin Lai <potin.lai@quantatw.com>, 
 Potin Lai <potin.lai.pt@gmail.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742542103; l=882;
 i=potin.lai.pt@gmail.com; s=20240724; h=from:subject:message-id;
 bh=P26V4Vll3LYpWjYPKGRYB+hCja9t6ZA02VGXue+Ra5U=;
 b=1jyEURlt/5++JQucdIxsVJF68m7y51O3IBeyOync7w+P29hPHxy3fEcN/cXhDXvIy+QwRU4Q8
 AjZOawK25tpDUsS4J+XGCbz04FMJf03ZVOY2JXgxX3inZSerlbJpg91
X-Developer-Key: i=potin.lai.pt@gmail.com; a=ed25519;
 pk=6Z4H4V4fJwLteH/WzIXSsx6TkuY5FOcBBP+4OflJ5gM=

Add a remote thermal sensor node for the Front IO board in the Catalina
platform device tree. This sensor enables monitoring of the inlet
temperature.

Signed-off-by: Potin Lai <potin.lai.pt@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
index d5d99a945ee4..307af99e833c 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-catalina.dts
@@ -544,6 +544,12 @@ temperature-sensor@4b {
 				compatible = "ti,tmp75";
 				reg = <0x4b>;
 			};
+
+			// FIO REMOTE TEMP SENSOR
+			temperature-sensor@4f {
+				compatible = "ti,tmp75";
+				reg = <0x4f>;
+			};
 		};
 	};
 };

-- 
2.31.1


