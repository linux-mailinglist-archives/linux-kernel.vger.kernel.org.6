Return-Path: <linux-kernel+bounces-250738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC0692FC1B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6241F228FF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD45A17108A;
	Fri, 12 Jul 2024 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f0b7joZp"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A865215DBAE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793067; cv=none; b=mYVyQ4sSC4zdltUKgo9nspZeMKnjhN/Y4kM7fhXx3nyi94ekr7foLA1r6DYUCSDal2F/eR+uO4WTNlR4B6li2Ob7aWk4wIM9ltVyDAAC2CYmvIbodNpw/vFruE5ETx9djY6tZlhP6JzZTZdM1jauxFG+ippkqG4dDbo4EvKNeM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793067; c=relaxed/simple;
	bh=f4nPJBWcL+FWBNNP7qtZLWX3gQIx7r3DtuJMpTD5/Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=m2zhTVZDdVGkDZ8LTWMGMG/GC86/dlgaiNpHHW8y2u0R3UmuDXdvsZMCN6Zxd5JmSCC2awd8d6Zg4dp7oiyYaZQ2rILdJvB27TVKXzaYRHwO2UDs+SDAmsv9OUWlg1cK8YnjXy0zsOnZ2LjGfno8zjF2/lAkc7OViZCIkTUFmvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f0b7joZp; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3d932f991f6so1174235b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 07:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720793065; x=1721397865; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0tPaSbJr1gyBPbW9jKrvoYL58n/60/CIcsiIcRMhY0=;
        b=f0b7joZpWTP8fSOeBxnqbFRMdosp5K1RcfFP+hC/sDV+1OzFwX6ZtGwHoQ48Nl3+IN
         H/Fc6XjWHrJ1AK1n3YgzeQ5OmzsslrMG40EQ4o3rWmUy/SeMet1dLj67WZYLKHYcD2Pe
         VIGj76q4f31QYBGqp8I04aLK6BhV9qla1ZG90IDkWK4kwKkjQNacLHuaW/4DxEwNzSuB
         GCuuLEO1WP9NAuvgokD+eD4GWm4XdRoLjbu8U2UeqfVSvMfLR1bhUH2Ev6UxJAO9nUyp
         PBayEX2WCg4WZAU58S83wGYpxTR1CX91oKcLaMpQAkVL+FflvowXAmEEn4pEekyHJCLA
         G++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720793065; x=1721397865;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0tPaSbJr1gyBPbW9jKrvoYL58n/60/CIcsiIcRMhY0=;
        b=JkIEwaB5P/vHOpXR9ctGCfdXB4siirhdTRaxomNciqYUb0QyntNdabxXDHaunLi+/F
         +tpCbEb/n+R0OlY0dpJohGC2xGH/PQtt4lxW5P1YJppx1PA8Ni5b6NttFTGo+3nTHJOd
         K4tzwKSnldfboPEOSdpXowV5dhKpwDcHM0VO/EPEBmVtuq8CFwuyFRedoaloKZDf705y
         k9t6NCJEdT1DsA8apzy/VVz8TKw5Untbjq9wZOKdhqFfFcpqjOWdtXO9Qp15j3aT8Opz
         00J3LjkP5IL+8mdX3DtQJ9VENeJ3Jmu3gvkXdNQ6bCHjNL6ymQHcDfk/rHN7LUdRsq8l
         4wVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUT35WgLiiaD8vHpNqw6kGPQEowKc7YTr7XxhqhoBes3MFmvmy45T0DTJm6wDIZJnqy+aM3JXiJgObRk2inbqADIp/HQ2B4Bbo5vJ7
X-Gm-Message-State: AOJu0YymSDWR6LhoEghEu9bUx8dHQtcO8xd7KrHDgUXaCbIY1pqnRQpU
	qaptnOXpKZVkIRymSpk2A2pz2rtUIbMq46VPH10taq4vOdIszNSSu/WU02awfNY=
X-Google-Smtp-Source: AGHT+IHvKRXgbYK/Cei1uAHdNU9V5NaySuUO0ey6pJOZHrm9szgI1TMI8MwHwey/7TIGHSFFHYqcjw==
X-Received: by 2002:a05:6870:ac26:b0:25d:7cc4:caa8 with SMTP id 586e51a60fabf-25eae74ac40mr9611788fac.10.1720793064654;
        Fri, 12 Jul 2024 07:04:24 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:d26:9826:56eb:a2e5])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-25ea9feb5a5sm2154367fac.19.2024.07.12.07.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:04:24 -0700 (PDT)
Date: Fri, 12 Jul 2024 09:04:22 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Armin Wolf <W_Armin@gmx.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] eeprom: ee1004: Unlock on error path in probe()
Message-ID: <b5c51026-a2de-434b-8f45-44a641ab1c82@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Call mutex_unlock() before returning an error in ee1004_probe()

Fixes: 55d57ef6fa97 ("eeprom: ee1004: Use devres for bus data cleanup")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/misc/eeprom/ee1004.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/eeprom/ee1004.c b/drivers/misc/eeprom/ee1004.c
index d4aeeb2b2169..adba67cef1e7 100644
--- a/drivers/misc/eeprom/ee1004.c
+++ b/drivers/misc/eeprom/ee1004.c
@@ -272,8 +272,10 @@ static int ee1004_probe(struct i2c_client *client)
 	}
 
 	err = devm_add_action_or_reset(&client->dev, ee1004_cleanup_bus_data, bd);
-	if (err < 0)
+	if (err < 0) {
+		mutex_unlock(&ee1004_bus_lock);
 		return err;
+	}
 
 	i2c_set_clientdata(client, bd);
 
-- 
2.43.0


