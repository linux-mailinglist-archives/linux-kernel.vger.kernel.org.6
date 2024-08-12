Return-Path: <linux-kernel+bounces-283394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 146F294F1EE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA918281F27
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6A71862BB;
	Mon, 12 Aug 2024 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzrL3qjd"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19B513E022;
	Mon, 12 Aug 2024 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723477399; cv=none; b=aKGaSHCqti1JCKR+PKa9LzdbxAgO8tSC46LTjLTZhX5F6bYv69wKXfss1nCUXd1XSNBPbd+sJYCXzX0lbtzLCm0e2fJ+O29SarPTqU4K+4IxWM9dXTod4817Jra+Svxp2iiq328Zg0Adr6ctxMZR4jgetFqy+HYQ+fWBy0KjQuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723477399; c=relaxed/simple;
	bh=2atFC6N/vaLVNHJuH0O5e2noPBaxOUdAzlE9V94AAXg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MgB2qBaSQaeP8aueY/LwHO3cG8UfmNsJ2C5WsDa7XW2XXtloY1tUXT3ITWjBAc+zF6Ow9EmNXG8i1Uj0b63jEqqn1XxRvKieGHQMNrB0dG6JZPWjGzFkG/FUwZl9UF5XG8RZbJOUN2aKxpCjt1NhTnfoLsnwFo1yVu7e/yOpjbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzrL3qjd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42808071810so34482875e9.1;
        Mon, 12 Aug 2024 08:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723477396; x=1724082196; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=buI9Ko5ZDG8/IEDGLRiJRvZNs9QL9HWCq0F93tw6IHc=;
        b=TzrL3qjd1qSRA0gjO3CtqDB2EwuOmeV7lD2NDdiE9pGsPxR4JA2EXnoU+Odh1TbIF1
         3eDVqUWr0/QcsLFxVAuj2aIfyMZp1/TbUVe2ktAC4SbkY6rVLj4VtnzvB0A6deXbRl9P
         /QbMh96Ztjuh6Y5PHvJgaBSXmNvbTU8Dt3KeKiKUYlh4gsvjRCiYoBR4YrOHXcdrTYyd
         nTRPE9GiX5ylmkQcEtSfwcIdEyjnWQ5goTKD+MSH0cd65agsyufnzgo9Kg5Ea2ucyXEw
         CCNhsZya6b+7JS9/e+pwVZ6bGz2IpEYPY+OmiD89A5zD/IAkY/HArilrzSHQAjCbU1Tu
         QcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723477396; x=1724082196;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=buI9Ko5ZDG8/IEDGLRiJRvZNs9QL9HWCq0F93tw6IHc=;
        b=Q+KuHJ5eXs1O+VGI1v/efXWO51OzWwf5lKGfBIPooyhu0gbgj8uCcTA7/pZxp8+mkf
         giOfJBHcrBzsnUOERQkoTh6k3o/NWhd5KHMlWX2WIkFlGoNz1vIBRk3qArQ8fdzPCrvS
         O+1+3RXk8H+8sMPy4hogHLd1GKfl03nTwXWvRhaNfTCNpXvQR18un/x/WG5uJT5Hk0vF
         qi99ZASmfSIih7TkJB0cLV8GOwIGhyXph/YrbscnxNrfF76mkRiDWo9swtpwzypmy0Fu
         82+Gn/8SkwHsXeLaQ6SjFYQH+DJ7Oj3CsxqRBvOQyHrZLKzdsgvBjiEVYgN/yhSdOzFz
         Zj0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVhfXkQ1r+Y6rY/LDej5fPWdjZ4gmtoc/jJDAGvwj54TIuELMG4D1OrwovS3giKPDmQZ97hWCjcKStlJQjyxvM92jsaoGrlI2vsP40G
X-Gm-Message-State: AOJu0Yz1z80JaCnkJwle4ZHC80VX8D8y2fM8GXggKP9fStwafMwsCFEk
	LWl2LgZSw/NrKlcwMu0CZKLvppCN96uh8a9aZ0SSZpBe9ijDcM/+wN0oOQ==
X-Google-Smtp-Source: AGHT+IGlQTA8XQFSIRQepdrd1h2T8uOH6GkOw0ZjyBZZXoTjSwkUFofJU2xury6YpSC/MrlT2/WM/Q==
X-Received: by 2002:a05:6000:e0b:b0:366:f469:a8d with SMTP id ffacd0b85a97d-3716cd0115emr490669f8f.35.1723477395662;
        Mon, 12 Aug 2024 08:43:15 -0700 (PDT)
Received: from [127.0.1.1] ([213.208.157.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51eb47sm7859713f8f.88.2024.08.12.08.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 08:43:15 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Subject: [PATCH 0/2] hwmon: chipcap2: small improvements in probe function
Date: Mon, 12 Aug 2024 17:43:01 +0200
Message-Id: <20240812-chipcap2-probe-improvements-v1-0-3cdff6d16897@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIUtumYC/x2MQQqAIBAAvxJ7TnDNQ/WV6FC25h4y0YhA+ntLp
 2EYmAqFMlOBsamQ6ebCZxTBtgEXlriT4k0cjDZW92iUC5zckoxK+VylHsKbDopXUW6wG9oOPZI
 HOaRMnp//Ps3v+wHbdcjNbQAAAA==
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723477394; l=688;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=2atFC6N/vaLVNHJuH0O5e2noPBaxOUdAzlE9V94AAXg=;
 b=+ifSgcyjWO24xuuBIV9BWYqX3BXYnKFe4B3m+cnSExQsqHtTWcnE+8dMhEeoafwQfb3mSTSwU
 GRKU5Pp+QUFCJi76X6oDi0mAyOjzijAdVOFJMNquEVepb2Q14moO2Qr
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

These modifications only affect error paths, simplifying a case where
dev_err_probe() could be returned, and disabling the sensor if getting
the ready interrupt fails.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
Javier Carrasco (2):
      hwmon: chipcap2: return dev_err_probe if get regulator fails
      hwmon: chipcap2: disable sensor if request ready irq fails

 drivers/hwmon/chipcap2.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)
---
base-commit: 9e6869691724b12e1f43655eeedc35fade38120c
change-id: 20240812-chipcap2-probe-improvements-c94d1431f1ef

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


