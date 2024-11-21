Return-Path: <linux-kernel+bounces-417510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C170E9D54F6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69C7D1F218F5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 21:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F8C1DE3A5;
	Thu, 21 Nov 2024 21:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpKkT5BE"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16AB1DDA3C;
	Thu, 21 Nov 2024 21:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732225506; cv=none; b=gT4J05O7Se9qC+1CRgrrhTcKx+dpqn/GjJgPogujkQIJ+xwar+voKg0AXOv8bIizMwrYk76/onDM9dq7XF5RkIzKRngK37OLpXPEx1aRuboeoTs/7qmZN6+pvpglmBarSULaszf09GgTdHjrElx3RDP3vuLJtkwp4ZwefPRZt2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732225506; c=relaxed/simple;
	bh=VOQRmfCf0BFv+WjkM03vRFzQtwbS5FU6xRa3ysdE+HM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RoRugSyPO8Rahs0x/pH6YBWpmfnyYzp+fokoTyS7qPch5jazpsXsXo6OpB6i/KkU+Zh8wqxS2YrawgDzpPzUHzE6vlfNkaeW+Us6OwshQVESqUTeQGIZSZWytB/OsPb/PY/Dl+nXCXehXEqVShgYCDniZM0CsTkxSaHrSl/oQQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpKkT5BE; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-431688d5127so11344995e9.0;
        Thu, 21 Nov 2024 13:45:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732225503; x=1732830303; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+vBJIxlTXCdDgKLk0dzLGrsKcGo3+bHCDMJbCtUdOXM=;
        b=PpKkT5BEOBwgwHyHPoXRXk8yHMDq0dL2f3GuL6DSCQyQFkuOmLrcurpWB7Xd9NCNkP
         XRycz5brVKc7XMaLKoqzQtUrf30UaCZt1ra3cLs2e7TeIoHgffwuFues1nFFBm0oaStn
         BdXQAgl8LS03rL4r+Vsa2UJ0dlZru2qTwA5D7Qkl72WAQX0ZxUZxkgvU68MxzsbJkw0A
         F5wGvHOOe8/6fXBRriOpIs9IUjraWnJJ+adpCsRWapRFhZP7ZiVciBgVTRZGfeYJQQkp
         HdW047s18L6+xKpQV38DuOrm3xQV7klXePH2IjkA8VDlc22COJNAxUoCYnL1Qv9RN3sM
         akCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732225503; x=1732830303;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vBJIxlTXCdDgKLk0dzLGrsKcGo3+bHCDMJbCtUdOXM=;
        b=tgDPfOUskiKXN8oaG7I3gW6KMGxWM54ECwxyA6dclWYc2OiWQqB8T6GwrPZwiWu6eK
         exmvTup+LgNkqajA5o0cDLc707zMBDINAEz0EIONiPQdKIWfaq/A/4cpOMQ4uonSHwnz
         NaY5gcY7jVHOmUR1/3qh9gIwJgqmrbfsvo4ae53kBn2eXkvLUYLZTIQdzP+HenptCNOY
         KwQGMcXP8SvC1Gj5BQA5dvmaTkIz4WhOZlDxNYahYsz6hYTUGBcrmdTQ1ntWsrl2QSZX
         DXB3nBCD1f3gaoEpI+VTzPTqjLA9rH1oal5qg7yEF1PlPjz/CFxkjd1nSxyhcUtziteP
         f+vA==
X-Forwarded-Encrypted: i=1; AJvYcCWfFZFVnJBkRvqDoE9k0TwGnxsjozqy1VK5xcfs0UYBOKB1ROtOCS3G/vZdAYF8SoK+m7umnEtVWf+i5A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxL9pBj4Fq7t13O5ihJ8dNQkDwM/z6PwYPIFH3Leg4HGgkOCo1i
	+CguEycjuRSRuVsYUG71oHSpX4YaMkVsx+qo04MurP1nS21/qnUJ
X-Gm-Gg: ASbGnct7rAlq7H7/B8NnsjaiKAKGiVAeVoBTUkn6At55nYQsDJ6NHwKEXxeWYmpUj34
	mrwQtRJgOo1zGrcTEBRqihd+GJu7Wh9lvsQ3I5Y4Grfv3ZjnRdaGYiMPtfM4xvds3uqIkWKaTn0
	pjDMrk1sE9XjoRpfyofGiBV2mCqbQE8i38eCeYgLsNqHfp2mZcV6GdnjRa3k0r5k3jj8CHF7k5y
	aDpueZyjvvNud1+I6E4vjcjoOfEDhUQHYNPo2llPFOU6otIo7okccBUmbRzNLQ3lBNOzhQJjBN/
	6vlr/36xz/OyZoeT/ojwJEulrOxlAE9K9IbepWf+SYp8vH8dRoqOYDXXaPLdDGEmKIO17NCR
X-Google-Smtp-Source: AGHT+IH/hpz9oWNvg+L3wcPu6JUnGofTntSkqo/Z1jfI2l4MR/d472iQlA95pTwX5EBz4DABeSKR/w==
X-Received: by 2002:a05:600c:3d8d:b0:431:4e25:fe42 with SMTP id 5b1f17b1804b1-433ce4e9e39mr2514675e9.32.1732225503019;
        Thu, 21 Nov 2024 13:45:03 -0800 (PST)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-7b6a-90cc-9bcd-a2c3.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:7b6a:90cc:9bcd:a2c3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb53858sm636694f8f.62.2024.11.21.13.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 13:45:02 -0800 (PST)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] hwmon: (chipcap2) Drop IIO in MAINTAINERS and simplify
 with guard()
Date: Thu, 21 Nov 2024 22:44:54 +0100
Message-Id: <20241121-chipcap_no_iio-v1-0-6c157848a36f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANapP2cC/x3MQQqAIBBA0avIrBN0KJCuEiFmY85GRSEC6e5Jy
 7f4v0OjytRgFR0q3dw4pwE9CfDRpYskn8OACmetUUsfuXhXbMqWOUs6jFqUwyUYhBGVSoGff7j
 t7/sBxOL4BmAAAAA=
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732225501; l=720;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=VOQRmfCf0BFv+WjkM03vRFzQtwbS5FU6xRa3ysdE+HM=;
 b=HXplWNbEuG+vTy+WAyzjPbxda8dORC+wfLsK1mRvOnnRYyg2Kp161UoMSU9886lY2RCR2ggif
 qIthVjvvvfSDcSpOh1sxY/o0OAK35gFPRNV3Zf4fDYiHUa5TYYn03/i
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Simple series for the chipcap2 driver that I maintain to provide proper
description in MAINTAINERS and simplify the code with guard().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      MAINTAINERS: Drop IIO from the title of the Chipcap 2 hwmon driver
      hwmon: (chipcap2) Switch to guard() for mutext handling

 MAINTAINERS              |  2 +-
 drivers/hwmon/chipcap2.c | 63 ++++++++++++++----------------------------------
 2 files changed, 19 insertions(+), 46 deletions(-)
---
base-commit: 414c97c966b69e4a6ea7b32970fa166b2f9b9ef0
change-id: 20241121-chipcap_no_iio-eb8050a25f82

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


