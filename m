Return-Path: <linux-kernel+bounces-571547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63404A6BEA3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 16:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA50A1892BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 15:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A182253BD;
	Fri, 21 Mar 2025 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xtcma/df"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F5E1DF268
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 15:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742572192; cv=none; b=vDWisxY7ofrMPSTHHG6gcUxbNR4VSViZSOeWcDaARX+0t6wwI7FJOaEZZZWmkyZFCa0ylG7WWs+gh/uVzqEhZHZKp4by5Ki2Eb7nWvAQLi6+FZpgn7yRZxoMfTCMegImqbjU4fzyo+TwCHnjYG9mYalInJGHVtAgollpdHteNCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742572192; c=relaxed/simple;
	bh=wCeSz2KOSGVmdMZOiZU8W8jgejAZEJTjS3rVeVs1xl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZtLH/0ftyWlGbMXb2vuhEHMSzFtaV4ryONy+pKSls/Atboy7qz/2YzaCb9jewXZi+KlqCsnz0qH5e75ADCNIz/73qbMQzgakK+NPh/nMZj0tHzRIXcwAu/+jAb+jMwFVupI95YiNVXqs95a0b97baCSAz6EfGD08qqOkxh/QVOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xtcma/df; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-399676b7c41so1214286f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 08:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1742572188; x=1743176988; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SWFCHXs1mgub0TbB9Hn2Mniy/vRwxESdKz1h7VjDaWc=;
        b=xtcma/df3IUcWr/xqv1jO+TTFDN2kw45cPh3pTCgvBB2ZwrEaFgwXmZfobybwtK1Go
         Z82FGHyjnwXJezDXymgFL0AABkl9oFR5R6ehOCDxXusa9yLxW6NAuFL5yXjjMdhHyPhG
         DpZxouqJvww5ESeWPCNzqi17z8knE1IQzG3vIav1x1ekwWQa3v7aY+BOG4zHa+ng46Nu
         +Q98p1Ecf2gOtxy61NmUsvIcC1pY/rlIkuVl6EJRp1iNSuuKKQQdinNdDpuw+7Rj+nqy
         8QSxylatQPMLEeEjIYBH8FbIEhiQggWfiWu7IkDo/M5kOQeCKxDX4x4yPts4Aa5uuX5P
         Grlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742572188; x=1743176988;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SWFCHXs1mgub0TbB9Hn2Mniy/vRwxESdKz1h7VjDaWc=;
        b=toHs/rUPDG1hS01CHdPjSvZ0BC22+slOKqp90PdXdn/TaltXKkFC6mD5JB8/UVyU6Q
         qUeS3Fr5nNywUOBS+5SCvxHPgMBOfkvV7CcBedsRGasLCfy3N0KHj1AiWaLSt5sTW24F
         3+dUvCopulAJjfV8/pJr1qg3odXe4WpcUcDhLUPK8ij+hrDT23xfncZkxY6wsAsatk1Q
         12Ff7yyGM0BuYbUd347fvdL19X6lNneul+VCnWb4a42ijl179rcFp2qzGnZnkjNxnvF5
         yAZ2B9Ag7bA8F7Vc/Civ+HSKVdd2pUoT/xIh2ZPbYWH+1mg4Tg3x+55WID/mJfwtbGp3
         rsAw==
X-Forwarded-Encrypted: i=1; AJvYcCWLhJgLofUMEgGDHMj+V7AgYBjqSWhU+RhrbE+/qnE2hS0TGLxD813xp4nTeVWcXOawpITEYqbY7CrdhrE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp4mBcCRg5Rz0cLOkQ5zMjcaGukXbegSNDYCOMYixNG9zZMFzM
	VusApAlw9a0itRwK0opbkj17Kw2r0XMt/4cBRSD7ugthmhIdUBxCPPJFOwRfuIH//Zb8es7M36w
	J
X-Gm-Gg: ASbGncsBg/1BWZ0hg+E+jLOv+3GOlAwb22br6WfFH/IAQdj80v1XyzJNX6LnFPhMh6x
	QvLQlwhiaPOZjJ2FBgkDDZPhR83tQz7vywYyBO5S6HyRUHiz4LvwReFpTU/hFAuug+ILVQVMU+w
	ytH9NTHPaOlRL6vVEucEW3BqZZe/12/BSJsjlKlH1nULPNWK6ZOVGF7ifC17skTtXoCoUTbqdr7
	pYM2ZqJZREoNs2110JZAOeYCTIHyXP7xIPtJRRS3euCDQdCp0bo6iwody4xARBHzD3nno++g8Ci
	CyjSa4auF/jDGCG9ftfnjn7yAt5xSNa/K/R02Q==
X-Google-Smtp-Source: AGHT+IHhtq1BnYFSnAx+hQUldveVt8mQWVWOnxup2iKacPQKCdLxIWbQZ1BsfJD3AfGXvy0PBof5Ig==
X-Received: by 2002:a05:6000:178d:b0:391:2c0c:126b with SMTP id ffacd0b85a97d-3997f909b3amr3044992f8f.23.1742572188033;
        Fri, 21 Mar 2025 08:49:48 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:1aa4:f3ec:847a:32d1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3b4bsm2664406f8f.25.2025.03.21.08.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 08:49:47 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 21 Mar 2025 16:49:34 +0100
Subject: [PATCH 2/6] gpio: TODO: remove task duplication
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-gpio-todo-updates-v1-2-7b38f07110ee@linaro.org>
References: <20250321-gpio-todo-updates-v1-0-7b38f07110ee@linaro.org>
In-Reply-To: <20250321-gpio-todo-updates-v1-0-7b38f07110ee@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1024;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=3OXtQ/TM3u4P6aWQ0VLana8z2BYniuHiDEU4Ow69oxo=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBn3YqZAtbyd4w8ChdhqRb6d9B1Lx25V2PE39afQ
 GvVFC3Q1oOJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZ92KmQAKCRARpy6gFHHX
 cibgEADWd2wS0zrLjqLVLT88hL0yhhDlmU6PEog+zjF15b1fZEAaK2DgSRBGGibhLDlCfzKgSXj
 07yuSf+zDdWSID976vbSHT/QTqWiFI4EWkToYXzDgcZx5EmH8qXGGgfhx/vvPR1awBUYrQL+2jU
 1Yb62BXMMq+SPiNkb7XAtjTcJTif0WYSPKsj+HvFAMXtLvOM47U3MEYVrDAtJ7/C5XCqyK9Nbeb
 xfUFD43wi7TCMVq5kE6ghFvf/vnNsayItrnW08LKyhL/FEM8vowJD0KpDxjVld/fGtdjBLdg0+F
 yg5AgfAN16UHPsicmfzDo8wu74L1IZAbB4jYyW+hmVBYuhUxDCwxp6fJmkdwlxYFFRIDmMuIDOs
 NnjKSx0YDLHOMzZ227DS7ze1otfjChmkbCdU0A4Z7aEQi0o54rT9sFRwcIRa758aaqxeoL/PYdH
 m5h7UkXDb9JnGlOWijZI5pM6JRGxdsipkYNvoyooOa5DyXQrHGt1LONewNMF/qLTHy8gFNKHyHW
 gd6tKPVIyjznUc1sOjVtF003zm9V5ruLsRdjQbyb+tTRQyp2dztetRD0Mlk1QMBWriuJIaibZHd
 C1LddJcPlt7PLzL/lpDofCOuOpFE0j5cdmr+MF57fuv6BpMAhN7XbFPgKdUi0KdU37aHmRxlPb0
 LSJUxIRbU0s2xgg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The removal of linux/gpio.h is already tracked by the item about
converting drivers to using the descriptor-based API. Remove the
duplicate.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/TODO | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpio/TODO b/drivers/gpio/TODO
index 9cf7b84cdb869..ff955befd0ccf 100644
--- a/drivers/gpio/TODO
+++ b/drivers/gpio/TODO
@@ -86,15 +86,6 @@ Work items:
   CONFIG_OF_GPIO_MM_GPIOCHIP from the kernel.
 
 
-Get rid of <linux/gpio.h>
-
-This legacy header is a one stop shop for anything GPIO is closely tied
-to the global GPIO numberspace. The endgame of the above refactorings will
-be the removal of <linux/gpio.h> and from that point only the specialized
-headers under <linux/gpio/*.h> will be used. This requires all the above to
-be completed and is expected to take a long time.
-
-
 Collect drivers
 
 Collect GPIO drivers from arch/* and other places that should be placed

-- 
2.45.2


