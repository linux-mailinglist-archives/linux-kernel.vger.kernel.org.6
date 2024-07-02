Return-Path: <linux-kernel+bounces-237578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3130D923B16
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D41E31F2263B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAE7158DC4;
	Tue,  2 Jul 2024 10:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImhVz14n"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EAE158855;
	Tue,  2 Jul 2024 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719914989; cv=none; b=WC8yz3fTPiLr+XxQQVe9o9ymjyrVrIFc/c+nJyJRwINVDJq6TtHMsnPgU9UCsATGhnUnd4ZzqimNZ8YQLWJw3B6LH1Wmaagy3O+Mj+m0+1efHwtYUZh2LfPMjVghh7vS5+rZDv4Bcy92BDeIOiY28qcj6yNZIIfGQEH+sVECzVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719914989; c=relaxed/simple;
	bh=oZ25HGm1WskMrpM2SiLY9dyX8i/9H4MySbCexu3lbvU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SzMwzTZeMC9VXb/ES3vAVo/SC8W6z/oGVAsWY7MP4hvppVcDRCJPyuCOAXEY8votu281uuetKCW8L7qmQfYIsVSbfZy2dsgJTuEdQZfJux9gpabtZGuzffB9RIQWwllbAnFlbWWxQ8MZWLpJ0iyHJiLWqFL58wqTHJ3OF4cQ4ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImhVz14n; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52e7693c369so5300586e87.3;
        Tue, 02 Jul 2024 03:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719914985; x=1720519785; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8yfO8FKExVi6B1kfdL1UgjFknobWGZjtLRYC9nkW/P8=;
        b=ImhVz14niPGhflZRGgDJ2m5xiLIbdmnZR6KEplVimfrQJXnHQKzdzBOs62UhUEWOao
         IULF/CHPd1dT/YKq1aUaaQNJUzgunTemx146LWODIWM3JE4Td1E2Gxeg1M7hcOLZ9VVQ
         Vhj6oCE8YgoRFVJB2Rn4Wyj85pjHmJeNnzbX+KPfJU//tcuhjHMmikZGv2XpXlaLhnFc
         3V2MCN2eotPO/De/T0mSjEnuKI+zXgZV/36gbm1FWVcK5fauFGqPEsuFwzkQZ4JAMhXN
         r3zpwskSV/Up8n99eAtNbsTtuaEKIlPRs0BoDO664gHnw/ygvB9ST9MItaSix0OkDACW
         ijNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719914985; x=1720519785;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yfO8FKExVi6B1kfdL1UgjFknobWGZjtLRYC9nkW/P8=;
        b=l5FPEb1j2AxKpXGLG+X/zBYQ0CVlPV3Y3WzDaqlyrNE4IfSnJVlypwGA8Fl+OptHsn
         QeVlcmgPGehMzI3FH667PBsfB5rve35PKWVjwpBK6GVWibboyoxFpxKfHkiWe4DveZlB
         ZvRv2lUqnbtYH7jxpk6p6xc6pl68Ee0l3/Fxd8DHijerpd7PZARRw2Ei32Owt/kwOUN9
         i2ZCkHOngZwIRu8rUegRTZu6kMmKyua288wzmOQ3VEInOEGQ+nWlFyTHr6Lf79b7HWtM
         K2rR0rOCGCGV8w/lFhMDt5w+ImvpYuCypGLoov+MBQq/QhpOKzvVRyRZ9j1di5JyqSDL
         hOUg==
X-Forwarded-Encrypted: i=1; AJvYcCWHhGILnGNGIBRLDEuryWZkyt+oSEyksl4em5PGZ0GvkkjqfX/aNz+Tife/9x15MElpHDuyKQFCEi4Yfo81iv9c+iKCjNY6ynfZ/uJ2
X-Gm-Message-State: AOJu0YynGqTLzCBrzUTd5iXtIVZ8I6K2wwen/AwPpn9jNLQMoJUA1LhG
	g8pLjoJEfJBx3IbMO/MI1wfNEyKquAWwBjzjY97TzbSWoR0S4JBNcLJLRw==
X-Google-Smtp-Source: AGHT+IHJlWcQgPFFqrto+UAKXu4a7cTbiGeaEMN3nuIytHJW6HEpxx8tcHu9lvfdBo0Mk1+0TlvCoA==
X-Received: by 2002:a05:6512:b17:b0:52e:7d6c:dfd9 with SMTP id 2adb3069b0e04-52e826ee716mr5446774e87.44.1719914985144;
        Tue, 02 Jul 2024 03:09:45 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b06377dsm192630315e9.28.2024.07.02.03.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 03:09:44 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 02 Jul 2024 12:09:32 +0200
Subject: [PATCH 3/3] hwmon: (tps23861) Constify struct regmap_config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-hwmon-const-regmap-v1-3-63f6d4765fe0@gmail.com>
References: <20240702-hwmon-const-regmap-v1-0-63f6d4765fe0@gmail.com>
In-Reply-To: <20240702-hwmon-const-regmap-v1-0-63f6d4765fe0@gmail.com>
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Eric Tremblay <etremblay@distech-controls.com>, 
 Robert Marko <robert.marko@sartura.hr>, 
 Luka Perkov <luka.perkov@sartura.hr>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719914978; l=719;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=oZ25HGm1WskMrpM2SiLY9dyX8i/9H4MySbCexu3lbvU=;
 b=zC6ngfSxFZuk7fQLQnBnQ5AgEe+WiKIP0hex01fRvlb9JNTmzTzyniyMQGKb8OIKgcEFO7t+L
 HWFSd9+mvuFAiTaZeNE9sjtvxq2zNQqaSffLY+Cp9GuxS8iaGZrrj7H
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`tps23861_regmap_config` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/tps23861.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
index d33ecbac00d6..dfcfb09d9f3c 100644
--- a/drivers/hwmon/tps23861.c
+++ b/drivers/hwmon/tps23861.c
@@ -117,7 +117,7 @@ struct tps23861_data {
 	struct dentry *debugfs_dir;
 };
 
-static struct regmap_config tps23861_regmap_config = {
+static const struct regmap_config tps23861_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = 0x6f,

-- 
2.40.1


