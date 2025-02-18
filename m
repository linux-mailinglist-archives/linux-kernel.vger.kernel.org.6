Return-Path: <linux-kernel+bounces-519480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB93A39D58
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 14:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11C73176A3A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 13:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC38268FC4;
	Tue, 18 Feb 2025 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=shkspr.mobi header.i=@shkspr.mobi header.b="QROs0wp/"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E7A248161
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739884918; cv=none; b=NF1Dgq+5x1J3MTJn2/JnzVVs9gL5zOTggiQpljCKJ2Yj4CcNg48PdAAFuLMrozLuG+WVsApVK48TuXMrWw3qtVr01oZpbhwP08T9Ci/z9jwiHldCAswKpBfXgNxjF6J2E0rtk6ILhDfnbn2hJvwN8zM65KGa2PLJu5JrFuAV7rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739884918; c=relaxed/simple;
	bh=HHOR+ZHUuxKVWPGOIKWQ+Fft+jN2FThtcVTnSzlPmNE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=pNzUYDTpYg5kSPpJ1UYAEuILHnIwPqWnZzBLL6Ay3OHgFFjeQJ98APCiXgzMrSaOTT/maIudeGImM6TD2o3JqvJ/t/4CINNEA4JdzF/VqzacU99r/JWlLH/0OysQXMgBbci1WlfEoIBtuxnjJ97F9NLaL7fBvj5vlkmdNPL/Aes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shkspr.mobi; spf=pass smtp.mailfrom=shkspr.mobi; dkim=pass (1024-bit key) header.d=shkspr.mobi header.i=@shkspr.mobi header.b=QROs0wp/; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shkspr.mobi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shkspr.mobi
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220ec47991aso56013795ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shkspr.mobi; s=google; t=1739884914; x=1740489714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vGyNh+yUFFGrKndGyRtq3BCCKJ9iF/NeUQj7XuO4dpk=;
        b=QROs0wp/wk1I6PVebuTUbF6NEd/Y9vqP1rI9BJrbReXRp1KKDrw6+49YVc5AsIEMEs
         FFnVrU9CI2fxLGkuw3F7zqfChkVsLeCHMQN5DlWV3AEDZ9x/TrPHb4FvQQKkB7ptFO53
         KQO60Qu2ZhB5myjhKw8Snelyz5peFDN7rIIRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739884914; x=1740489714;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vGyNh+yUFFGrKndGyRtq3BCCKJ9iF/NeUQj7XuO4dpk=;
        b=WxSeW9/fL4Vf29Qbr2sshV+JpK7uc1UjZoXa05OKA7clbLEmyQC9s58MNWN3yu6MVb
         9BTUA/wu/Li3XKaR91Vp4h+Oz3CBzvAbCUwkGqyi1lOYLww0+R61pJ9Aaze9hIb60PPK
         UE4uFZqiy8QSqtpO4M4PKbvwIj6Km3JqwdQYlLnDukYU4dNq64dzm6TYEIn9+jnI0FNJ
         WaUML9catctA+QqXcgLsXLajfsi5mqzEZmDg3oCR9GCFL305urAnIdUkA6lhlX/THiy3
         spz54LXeuK5SPbaGaLy8WhSKH6YzzCJd1kpj3/m/nnf5FIcZ5nGv/g7RnDUVKrTMJtDd
         Tubg==
X-Gm-Message-State: AOJu0YwY6V5+Ur9pNQCGfBD7zrM1L6STF4iwuYGvNqD7pJAHGv3lSmgU
	8Cm+e0ELZgiZAPSwp3f1Sj0rYCETyVuqKttl67H+uYYpM0Wp8Td/9H9jaZ0fZnBPAHnkYbzZaN+
	pjJ6qIG/Eo9ePVdAnUUwR478KqGtfnhhSVBYwTDuCVU1W7OmdzHC6Nw==
X-Gm-Gg: ASbGncuuWySercGQdWaWOKiZYD1jV5OvR6kWheoRmlna+GgSSR0IeGM7em74drwg0f7
	lubvoveOBgfCTHAfqjWhWBwEbOLLgCZQRT5HQunBHIqsa+XNcyBf/dJklXhdvHDL8F01QiOc=
X-Google-Smtp-Source: AGHT+IGYwISPYytG4IVY1AqTmQX/s2MLmXL8bShNS5ZPRZoYIRdhPBN8vgROTeh4Z/BJ4LWALp6umK9K8/EdyTFXp9Y=
X-Received: by 2002:a05:6a00:847:b0:732:2170:b69a with SMTP id
 d2e1a72fcca58-732618ba2d2mr24395367b3a.18.1739884914593; Tue, 18 Feb 2025
 05:21:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Terence Eden <terence.eden@shkspr.mobi>
Date: Tue, 18 Feb 2025 13:21:42 +0000
X-Gm-Features: AWEUYZmGwytYCELLGP-V_6kd9Ja-_X391aaL-yyzeVP2m7qXb7s_IEoCtQYbBPE
Message-ID: <CAPFVDHokn+kfyk9AxTHuBJjRKMNJjZy8w=e-qzvXaA8Vfcq6Dg@mail.gmail.com>
Subject: [PATCH] Fixed a spelling error in the comments
To: maximlevitsky@gmail.com, miquel.raynal@bootlin.com, richard@nod.at, 
	vigneshr@ti.com
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Continuing the work of Commit #8ab1b51 /
https://lore.kernel.org/linux-mtd/20240923065649.11966-1-shenlichuan@vivo.com/

Signed-off-by: Terence Eden <terence.eden@shkspr.mobi>
---
 drivers/mtd/nand/raw/r852.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/r852.c b/drivers/mtd/nand/raw/r852.c
index b07c2f8b4035..136589f9a0e9 100644
--- a/drivers/mtd/nand/raw/r852.c
+++ b/drivers/mtd/nand/raw/r852.c
@@ -242,13 +242,12 @@ static void r852_write_buf(struct nand_chip
*chip, const uint8_t *buf, int len)
                return;
        }

-       /* write DWORD chinks - faster */
+       /* write DWORD chunks - faster */
        while (len >= 4) {
                reg = buf[0] | buf[1] << 8 | buf[2] << 16 | buf[3] << 24;
                r852_write_reg_dword(dev, R852_DATALINE, reg);
                buf += 4;
                len -= 4;
-
        }

        /* write rest */
-- 
2.34.1

