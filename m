Return-Path: <linux-kernel+bounces-347570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 463BE98D54A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 15:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0CD9B21B36
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 13:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC1E1D048C;
	Wed,  2 Oct 2024 13:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmdzt1fX"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603391D0788
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 13:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875719; cv=none; b=RWHH0AazOuS2CVv27Wx8EjE/lPnQErwGMI7/NAHHX0cit9rBaswlYYz2pV1NLbQ1qAxwejK8X5MlMrH1IpYrMSIF+2KKk+w0r6iupns83/Jred9T/fPJb6DnmHhJqMnmFaFwGx78DcHrTLrewTlg3g6JnFQCDEqCcUxbqYKU9Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875719; c=relaxed/simple;
	bh=CP+LjX5Ha1RSIaKYk38UX/wez45MJy9R7FnyyIWbaNo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UB0Xba8z5b3UaO0Z7TvYPeGlukpjR0VcdbwcjISkFlgWyTh7XL+psSVGiVBZPfkXSFKDEBxZGPbT75n47xuwOS6A81v2Hl6OdnUfcbwiZ/SLkmnxUMuPvIHk5asmGOrivhtflOL+dtHnE52MlMe1u5ObBB23jkikCSRs+1LbsII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmdzt1fX; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20b64584fd4so30928525ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 06:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727875718; x=1728480518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KGEsc1vLwVoQWt+H2cqF3P6yuJ7Om9q/TgHm7xbL028=;
        b=kmdzt1fXB4PhFSSSUh0zW3qdJc6P11VpBo5+v4jlr1R7Ke+JW6BwEURSqNPxQuicN0
         h97iGfOlKdZwj22UGrGeLfDL6uSOxa/97wXUONLwgNIDg3YNI0xv2ZEt9djNHM9mLtSM
         u73sHWD8T3bAZY+g1DWL7vHeiSZk+9uSvnnOa7KlUaIvcTwtW6UEQLFeZ3FNi004YGTg
         fxZrxZgZ1uqSDfdSgt0U+fkUny/D6m3KzVJmVt758YdF3Bs6xBkwXQK3+eaJP9j6qfvp
         3K9FLZQxqc8f+kC7eRYYqduf76t/IkHxfOhMbNZ1b1++OfIbDRXnJr+4QDQaB3UMLreT
         yd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727875718; x=1728480518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KGEsc1vLwVoQWt+H2cqF3P6yuJ7Om9q/TgHm7xbL028=;
        b=Km0hsu+0Ys4abRmgW/Bqdg6Z9Sf8wcTSd3zMWJtWyoJZo+ucFWD748P2hV/84RvkFG
         hUW69UkBY6cn1MdMk6MHLGBO8paeCFZoTcktQmZVx63w/muXoh4c95FCQkx+rAa9y8gn
         wDNZvDYOV7s43kIufWxCzBVjO+gNsDSt1HXpPs4e7Rdm/rkNNL5bXj4XQcoSqtg1ZKfc
         M1TggnyM3KqQaWYclldRwIbTN9PcG92V19pUBL59CsuFkqcVZgv97X4d+M7e8uuIlX+q
         p246sB70TFSj1iRLzpDEHhuEkUNF079AKn+AIcnsKx19R0QXPlNfbmOMJwaZgc3kQc1x
         kxmw==
X-Forwarded-Encrypted: i=1; AJvYcCXmjvsVOxQPkAbVd3pN5imhPMghlvK0x9a3oM7EIBfEmz5uZR5WJ0M0RjGKSeHM+UckQqFfBtj4G7AU7+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQmBHAF1a4RmOGZdtNlCBAWaMdoptZBXplTHkWkE1ebmKkrg5p
	gWf4rHlpGs98bnsNNMzWYlQOeXXKUO4UxV33vjW9ej8OMqAB4SQ9dxmV5OW8
X-Google-Smtp-Source: AGHT+IFsKpNwqXE5x3dxm3/kt7gMGUNFQTOdgX0GXLjKfy1tHTtuqHZ2VTYuUx2B6kMnq7kj08Rt9w==
X-Received: by 2002:a17:902:c94e:b0:20b:6a57:bf3a with SMTP id d9443c01a7336-20bc599f0e7mr41246075ad.1.1727875717546;
        Wed, 02 Oct 2024 06:28:37 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([103.57.173.123])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f7734basm1528740a91.19.2024.10.02.06.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 06:28:37 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-m68k@lists.linux-m68k.org
Cc: fthain@linux-m68k.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	sayyad.abid16@gmail.com
Subject: [PATCH 2/3] drivers: nubus: Fix use of assignment in if condition in nubus_add_board() in nubus.c
Date: Wed,  2 Oct 2024 18:58:19 +0530
Message-Id: <20241002132820.402583-3-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241002132820.402583-1-sayyad.abid16@gmail.com>
References: <20241002132820.402583-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change help improve code readabaility by
shifting the assignment statement just above the if statment,
which was earlier inside the condition.
This makes the code clear and easy to read.

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
---
 drivers/nubus/nubus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nubus/nubus.c b/drivers/nubus/nubus.c
index 08cf585cb471..77da1d14a1db 100644
--- a/drivers/nubus/nubus.c
+++ b/drivers/nubus/nubus.c
@@ -735,7 +735,8 @@ static void __init nubus_add_board(int slot, int bytelanes)
 	nubus_rewind(&rp, FORMAT_BLOCK_SIZE, bytelanes);

 	/* Actually we should probably panic if this fails */
-	if ((board = kzalloc(sizeof(*board), GFP_ATOMIC)) == NULL)
+	board = kzalloc(sizeof(*board), GFP_ATOMIC)
+	if (board == NULL)
 		return;
 	board->fblock = rp;

--
2.39.5


