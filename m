Return-Path: <linux-kernel+bounces-241585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E660927CE2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 20:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BC37B22183
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 18:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DE8C132123;
	Thu,  4 Jul 2024 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEAgYZEI"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5E77344A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 18:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720116795; cv=none; b=p17ut/4+x7xRlfYqZfzQmcLAzEFUvlwxhrTucLHR312SJHeQdbI5XSz+TzNatJN96o8sipt7giHC463eS4nsqbNPUNHg1UxcIO/gxSLqFwjRLemAklQUdzTeSMqq4vxoQ9gbHA2DBJhm//SE2WBqxZyausFtdw80iaHVyMY5xCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720116795; c=relaxed/simple;
	bh=yw6A+yCfWRqd3x17ELyMTyI7zfAa2bHEvPqbnkerJT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CTd5tKSGDg3J8HykGGQjd4hh3uz3t8E3cAV0+AujwKgzvL0Vj2So9RBEtIDBhGDFLRhjtEc86VLpTlVDPo98xSHBhlvD0IbMPuxNNdnJDaGiE0YIwjlxCM8wgNltdgMs0xsd4HSAbz30cyDH08qwFWrQIlinAwOhwk3O/jGsJGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEAgYZEI; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so10444091fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 11:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720116792; x=1720721592; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zoCavlJx7g7j8XT0tqisnvgoFBj7EyxF9PN6T3+n+yc=;
        b=cEAgYZEI669asfl3v3IDl5lY4Pp+ZEc1L7Td3FAUrT5RJnQUYCKrzPVkq13G87H+mp
         2S/GclfE5drNT+zrKTgntR27LvJ/cbyr+/HISrKS05Gokpk3cxy+ZSf3fImJpo/1uMjx
         buvwvdpg3CRNrG/IdsTMFdZu0qe71xkSb4zH41gu/4LGbz61REsMsAJ4xaDlz17h/JDK
         AQZM6E86Nmb4t2QnhdOClBkkdBWOhDofJN1SuZD8unUWfedWiWFx3zj6wRP5ov2Qescv
         2yvd6Fk/aeT4x90UQMdVAk830MNfeyTw7ANSdb3OvYBJMUX+FBy2OmxcaTIHxQgNMoxg
         IhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720116792; x=1720721592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoCavlJx7g7j8XT0tqisnvgoFBj7EyxF9PN6T3+n+yc=;
        b=eTEvd4294mrxDx3SRN3nuv/XwtAvvui1kBq36wzG5fP8UOiRzdehl/gC757ECCg2g9
         /5v5xTXfU9EPdC1Fb7MXB2DuM2z9bCQFCqOZebhH+zTEs+CTWrIjOCuT3tuYRQcfIHwC
         M3kye358zSCpQRhw+qnnQvTX/vKtv9PxGn6eNJWYycFied1BliQQwH1i+84HqEFkuwsh
         0XrfzdA0rYtvy+BzIHjHaDpq2+LdwwdQLWz2DnOXs+zsHW+kruPnmlUA4WZ0SGlniAah
         pcprxxpbLZjURvdvYBQm/poxYjG++yVFQrJ33dG2H4CTYrLPO6yYvwV/Wubt7dW7i8vP
         pqZA==
X-Gm-Message-State: AOJu0YyXy7ENfsf+Q4H+0pB9ilPYqkuCWqHgpDqCBzxrbEu7lOEUs9cv
	59p4BaKrAVGBe+l3O/WAToF+mQDYxbHDINsZPNggSTYloPIaqhfw
X-Google-Smtp-Source: AGHT+IEj1KD0dtp4JnJyzCJRQrKFrJY6IkBxOQgn9ae435SZ0s95le76BIM7XiP2BVDb1FvPA/t6Cg==
X-Received: by 2002:a2e:22c2:0:b0:2ee:87ef:825b with SMTP id 38308e7fff4ca-2ee8edd3f90mr15540091fa.40.1720116791844;
        Thu, 04 Jul 2024 11:13:11 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-0b06-a203-2f25-a0f6.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b06:a203:2f25:a0f6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a25198dsm32993855e9.32.2024.07.04.11.13.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 11:13:10 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 04 Jul 2024 20:13:07 +0200
Subject: [PATCH 1/2] regulator: da9121: Constify struct regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240704-regulator-const-regmap-v1-1-bce0ddef63ea@gmail.com>
References: <20240704-regulator-const-regmap-v1-0-bce0ddef63ea@gmail.com>
In-Reply-To: <20240704-regulator-const-regmap-v1-0-bce0ddef63ea@gmail.com>
To: Support Opensource <support.opensource@diasemi.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720116789; l=1651;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=yw6A+yCfWRqd3x17ELyMTyI7zfAa2bHEvPqbnkerJT8=;
 b=9VETyCUm1lqJu80CryFgt/ivU0UeWNSKUtmpbivaxO+YX0ci932XgiL6FrZGJ4YZ/1NrqCiyb
 d2FqOCL9pPADiYBoFTi1QLCFR9QCPcRBE3OE9XDfve9BqmDVE0pU+1M
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`da9121_1ch_regmap_config` and `da9121_2ch_regmap_config` are not
modified and can be declared as const to move their data to a
read-only section.

The pointer that references those structs has been converted to const
accordingly.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/regulator/da9121-regulator.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/da9121-regulator.c b/drivers/regulator/da9121-regulator.c
index 3571b6242e3a..d97162f73793 100644
--- a/drivers/regulator/da9121-regulator.c
+++ b/drivers/regulator/da9121-regulator.c
@@ -865,7 +865,7 @@ static const struct regmap_access_table da9121_volatile_table = {
 };
 
 /* DA9121 regmap config for 1 channel variants */
-static struct regmap_config da9121_1ch_regmap_config = {
+static const struct regmap_config da9121_1ch_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = DA9121_REG_OTP_CONFIG_ID,
@@ -876,7 +876,7 @@ static struct regmap_config da9121_1ch_regmap_config = {
 };
 
 /* DA9121 regmap config for 2 channel variants */
-static struct regmap_config da9121_2ch_regmap_config = {
+static const struct regmap_config da9121_2ch_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = DA9121_REG_OTP_CONFIG_ID,
@@ -993,7 +993,7 @@ static int da9121_check_device_type(struct i2c_client *i2c, struct da9121 *chip)
 static int da9121_assign_chip_model(struct i2c_client *i2c,
 			struct da9121 *chip)
 {
-	struct regmap_config *regmap;
+	const struct regmap_config *regmap;
 	int ret = 0;
 
 	chip->dev = &i2c->dev;

-- 
2.40.1


