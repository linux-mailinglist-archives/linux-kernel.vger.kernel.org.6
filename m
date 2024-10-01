Return-Path: <linux-kernel+bounces-345588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 370BF98B7CC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693DD1C22BC5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF25F19D894;
	Tue,  1 Oct 2024 09:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+Pp6s7h"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF6919CC01;
	Tue,  1 Oct 2024 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773250; cv=none; b=TyLvKg3cZxAMJ+qiJPLSzI68DE/DQFAfElLViIcx8fiIW1WTImnZB0FHY2nD5pOGXDDlvEyh3nCigvh03fK7/Z7gVHqGwFlgMqrV45yRJTEHkB7/7bm2WiN/jiHCTv6gWzN0VzN4W9yCF6Hwp35IMLcRriC4DgPnU6Dp9trv47A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773250; c=relaxed/simple;
	bh=YYyX6j8uQn7d3Guk0PQtxICyQihBXK/fHoWUcUbez70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=izjpySuEL7Yw/Pt+/z28Fu2OSOnvFf6KqSDdVUUG3vPanmPHez89iNmopnVzwPTKK97eKKIJBbJ2i/Eljb02XpTh8lffDxu5008BT66FcW7OjCaEy3zjse6nQoHDFKXKDhB2TACE0R3x2UJNzyZ3RHqvvr3aGX4TEQCok2hF0RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+Pp6s7h; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d3cde1103so733681866b.2;
        Tue, 01 Oct 2024 02:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727773247; x=1728378047; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ta/M52vXDQGmyxnycoYjK6h0KssiYla75zVz5uuRkOg=;
        b=T+Pp6s7h5AMUwUiRN0lM5UOhh4vlPTLLi8B01gA5b8hkcjZ1gBLlEjJ/fS+2ganhdu
         GuTS9sdFRDQ7aju9wdAzoC5lr5gWWTijt3tkwPjRjJelHTlh4EVHnkKaTCw/da/OaAja
         5oeKvHms3/Bfu7EgIHDQgqI1Y9dVE1Fdyj7vW1GqByC5aCRB7DN0/v5U4Fn96iIWpLeA
         Q2Nq7/6jtQMYiFOGO0QUbhKXZSRbVCoqnnd3ZKfziunY8PTmGiv4aMJgL1uhN7A8hldJ
         IKV8JwGwZha3KBBb1KMgSNkgB4hQOYzWDfUQnKHNzcTVEInZQdMm0MIyE5J2xtrcJnU+
         0PMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727773247; x=1728378047;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ta/M52vXDQGmyxnycoYjK6h0KssiYla75zVz5uuRkOg=;
        b=LPFV2OVahFAKvmjiEdu93hJWQScBGn5SPPTr4i6qtOgT25Dn2f3Ujxft5Lb7yRXsfC
         NByz1B4bbDvlNabNLO93hK5KrZrV4k2RK0gMwOd4geQfVjnyLSLE6Yv8N2vdqQHeVHb4
         DiDZY2G/H/X9nV8Tp2Ay58OPyfwfNay5rEzczCQeFyoXC50eBIpCnHNgKCcovoZ6YEbH
         FLvZlkBqBgvQcTCpBptCCbw8vaxsyK8sY8Ua8FHb7MVipcWDspDb047YeOojYEWtzGDf
         4N5BIIx/fpf2xE7QPl2eZpeKXcG25Xl3U160HYPl+Gfydp1LN3uQxw22DJRGp4PCHYYG
         cjFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT07MBx8UESD8fzBY7/Nm3DuR0GMq1a1+MjH9mWR2DmMuoCUaFQijrMiJcrueHiuWof2G8vFYYafLQ2jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIeU1WRNqUBxC9TT4Ix2F85wVGcJ6Z29aXup/xjDu1oAv052Dj
	RtFtFw5FtAqeFR/nchEggKWYweQ/gRerfAYyNRZFL7LinSPsXiu9xBXjUSPo
X-Google-Smtp-Source: AGHT+IGZ5FpVDywSlALeip17hIK5NEsxEIfl8zZBTzwiKs73dSPcKdSH4ZAWONOjf6OHRfeWTz2OtQ==
X-Received: by 2002:a17:907:6d20:b0:a8a:66b6:58d with SMTP id a640c23a62f3a-a93c4a4e104mr1496812366b.41.1727773246301;
        Tue, 01 Oct 2024 02:00:46 -0700 (PDT)
Received: from [127.0.1.1] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27ed053sm675867466b.93.2024.10.01.02.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 02:00:45 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 01 Oct 2024 11:00:11 +0200
Subject: [PATCH] clk: cdce925: make regmap_cdce925_bus constant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-clk-cdce925-regmap_bus-const-v1-1-49fc11555b04@gmail.com>
X-B4-Tracking: v=1; b=H4sIABq6+2YC/x3MwQrCMAwA0F8ZORtoMz10vyIiW5LNMO1Go0MY+
 3eLx3d5O7gWU4eu2aHoZm5LroinBvjR50nRpBoo0DmGEJGfM7KwJrpg0enVr/fh48hL9je2KQq
 NgxBLglqsRUf7/vvr7Th+f2tQOW4AAAA=
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727773245; l=1219;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=YYyX6j8uQn7d3Guk0PQtxICyQihBXK/fHoWUcUbez70=;
 b=IDOMSzw1KMEmp04qNVmgD8Y05gJKzxqR87MBuXVLu2JIzuEGWlngFjqhzTBDeWUNrzaR6CUf1
 aRkLAFooHA/AO+8th20n+5MEnMGA1zBQluzzw+l4QB+QMPeek9ywuDQ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

This struct is only used for the regmap initialization via
devm_regmap_init() (which expects a pointer to a const struct
regmap_bus, as it will not modify the struct), and it is not modified
after its declaration.

Move regmap_cdce925_bus to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/clk/clk-cdce925.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-cdce925.c b/drivers/clk/clk-cdce925.c
index e48be7a6c0e2..c51818c1af98 100644
--- a/drivers/clk/clk-cdce925.c
+++ b/drivers/clk/clk-cdce925.c
@@ -601,7 +601,7 @@ static int cdce925_regulator_enable(struct device *dev, const char *name)
 
 /* The CDCE925 uses a funky way to read/write registers. Bulk mode is
  * just weird, so just use the single byte mode exclusively. */
-static struct regmap_bus regmap_cdce925_bus = {
+static const struct regmap_bus regmap_cdce925_bus = {
 	.write = cdce925_regmap_i2c_write,
 	.read = cdce925_regmap_i2c_read,
 };

---
base-commit: 77df9e4bb2224d8ffbddec04c333a9d7965dad6c
change-id: 20241001-clk-cdce925-regmap_bus-const-391d2fbd2cd9

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


