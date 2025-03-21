Return-Path: <linux-kernel+bounces-571430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F28A6BD08
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:35:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 273C2188996C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EFB1D6DDA;
	Fri, 21 Mar 2025 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gUmRVEEP"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453241D6DDD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567656; cv=none; b=A/OVLEtJeDsKIjpucoXfmTgoKu1uBWRi8B23kZfJ+aa9y/5uCsS9mXeX2DfanFKUtqdfu5Ot5irexTjOWmRoVuJWPX3K5ipnkV95Wq7Xikp2BdG4VFS0EeG2ynUoLXmHKMmUkDCdNwOy1efOfWJTJnT4sXjvhrvt5WHxfstUEaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567656; c=relaxed/simple;
	bh=6MoXFu4CLfosp+15aOYuT+yR51crnXpBLzFRutHhie8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VyEZ5/bW7PkVrX/2a+ByZmok7nEBjk+JbZvhNtKKCWkbCDKJq7O4aP6vcF5uqudUkOQ6yEaJXl7DhCuqxrILOI8zwMr+V06V8J4TVBnnYgwQmwnZ2K4LoXJfFdNmzh6sUe6ummWcyr+5QZaOP0bdfBYpHBp77qWxXyIvVaW2Wv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gUmRVEEP; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3912e96c8e8so1263467f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 07:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567653; x=1743172453; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1kqVdYeLxFWfGG4ab3N4AIVapOQ8iQyK3/JzY3rIwWk=;
        b=gUmRVEEPhIr9cMyEt9TTnQUDVTF6Y4fYxaJtt6CpdVuuPkcVNKGpOtuihXBBJiCGp/
         dKjmlXbJENFSZ+XKYLNCULG7J82lE2nzQTOwbCiQe4P2tfTKgP2UBT37YzsieV2eDt26
         fwyRdLoZv8eI0wMeIKJJxaCTb9OaD8XvNn8ufDRaHZzX59//FezpkUnRDUIpht4gJg2r
         3d0CQYXEBD/VKUBED2fUAOEVHoxgoXp594PNsTpddcDxKfh0/ErDwf0ake0tfd7NdnPA
         g4wiJazFluguLgv8v7JoWXGu5DYNytca4Ept4C6fLUyuPgwo7wGtndW3PzjPIZgQd6h8
         eMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567653; x=1743172453;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1kqVdYeLxFWfGG4ab3N4AIVapOQ8iQyK3/JzY3rIwWk=;
        b=i+nqAKwHgt8AElFSBmb50iLYQUEWdL4ly8OGXgapSmzMoRQHowEKqeIiA+zPzxDyz0
         O+dTuoZc+I/zEyuIFeVcfn1QXg0n5bPXlmcYfKUuRGgZ9tNUU/4kXDwlwOLZKfl0DsoU
         CZSq+feBSnDy/FAit87kwkNCAhkA7JMnQ1FSrg9tKOxLBRD00pInORALaB2zazAN/AYG
         BJ1cvUjGCwJ21PGoG4fWDUZI1jSdPXOfCb0++hUovp6t2Sb2GFXCsHLsMiccaEM6ERla
         jSog0fjoh1hyfbOsyKDVNmQVNfcaDWr/RgnhOyPBo11LnwQifBaIjbiqZpmhYUWXjelU
         SIzA==
X-Forwarded-Encrypted: i=1; AJvYcCWfPRLTp8+EbXOvz6s3izR/SV65LUYRM6S0qGFAasEyrx4/7BvMEBfwiVt2qGqpE8zij1PjIiz1ADH9aL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuMlddr7NRTuuEz7/gBzhXC88/56O5CWtFDVSLIAjbll9sHNXD
	2M6fOw6u3Pq/8ezh4ra2rcpXeLYLjxPXkHrXDxZT9NAR6LCWSz1lQp8qSjw8sG8=
X-Gm-Gg: ASbGncuUiwkJj08NB9Lz6wmpRLr9VWUbhtVHpennFRB7b8H46mHa2HfajzURSnj2oYF
	RxGXrI1o032piEwf3XBU7uhVxXIr3G73QW6qyveprKGGghip+wvsFNeZC6/LYyHgBLsjOg/VawF
	EKbXkqn7rlBj4SG7++7Dnc/q0ZF/OSNztqyg8SKxHkUD78dcRWg0skPorxWBSTvb6RcgQE3v0ig
	GEyObNpHNkCIHf0IpYppGglrkWMleRQfZZqYoTUHNQLFFxd+HZ/YTCx+g8Ws9V7inVTBxYfg7YC
	qROyH6kn2+Ty0Wo77ZiKwvWasEeEnqdgylypp+pxEjtC5BmmDg==
X-Google-Smtp-Source: AGHT+IH3J7mR0ItKLtQh/BfAHr2Qv0TD83WieWbRHva+BSl455obiV7i95/cpX3n3cQBcn7spSf0kw==
X-Received: by 2002:a05:6000:18a2:b0:390:f9d0:5e4 with SMTP id ffacd0b85a97d-3997f8fafb1mr3799744f8f.21.1742567653378;
        Fri, 21 Mar 2025 07:34:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f99540bsm2503365f8f.2.2025.03.21.07.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:34:13 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:34:11 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dzmitry Sankouski <dsankouski@gmail.com>
Cc: Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] power: supply: max77705: Fix error code in
 max77705_get_health()
Message-ID: <0ea50e87-2b63-4062-8c2a-17537495f481@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94f55158-1776-4f2f-9296-e307e83d569a@stanley.mountain>

Return -EINVAL if the health is bad.  Don't return success.

Fixes: a6a494c8e3ce ("power: supply: max77705: Add charger driver for Maxim 77705")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/power/supply/max77705_charger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/max77705_charger.c b/drivers/power/supply/max77705_charger.c
index 329b430d0e50..0e347353c41e 100644
--- a/drivers/power/supply/max77705_charger.c
+++ b/drivers/power/supply/max77705_charger.c
@@ -285,7 +285,7 @@ static int max77705_get_health(struct max77705_charger_data *charger, int *val)
 	if (is_online) {
 		ret = max77705_get_vbus_state(regmap, val);
 		if (ret || (*val != POWER_SUPPLY_HEALTH_GOOD))
-			return ret;
+			return -EINVAL;
 	}
 	return max77705_get_battery_health(charger, val);
 }
-- 
2.47.2


