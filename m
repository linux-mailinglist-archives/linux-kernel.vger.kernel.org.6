Return-Path: <linux-kernel+bounces-182018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B7A8C852B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 13:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 658CC1F21D1A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 11:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6023B78B;
	Fri, 17 May 2024 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHrZ/UuR"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F07B3A29B
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 11:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715943715; cv=none; b=pAaYHBS8+tM98QavjG5tpIoz5Wp4oxIjtoVrdW1YwwBI/3ymzuHSu5sd9eSizN0k8k1UGVENHdN1XSpbucx1WJ7ZpWoiDg1T10t4qX+4QeIYodHwbwLO3LBUmpu7Lj+snQnMC2nb5yphoJgfc7yHPhg6rdW8dYJA7ivmMOfO8hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715943715; c=relaxed/simple;
	bh=lkqTJqCIQGb5vjON63LNNjW9FCtTXs5UHpoEAB4xeC8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cOzm/odIEhGHJoM0/iMbr0Qh8d16/VFf4KB/tD+l4nkM/5FoHWG6PpceXGdPJnyx84vS2jgqkZBc0THEFHEaN3pCE4IDcWE+cgSJ6/DsvfFrJ+v5TLwPC+erhUtWW900d6okeYNwz+im8QcAkdGgm6nfKTqF8vX/EA7xcVD9qG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHrZ/UuR; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e43c481b53so21197991fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 04:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715943712; x=1716548512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=soH3v7AjKgEzN9pDh9CRbKA35VUs2CBjMotD1Xr5BgQ=;
        b=AHrZ/UuROx+YpfTj0YdCAIaQZ94ssMepRuLFv8BGJ7dHgWw1cu/PV5eHd9eYfDT2/M
         uctpm31ZrNZKvnhASzGJcD51n7uNEhwTKqHLyTBaywK2pRvm02ZvNsQh7bwg3kXmd17H
         f4+L0P+6vIfbeQMAbzuhIdy1HxzNcHXNB5IlyhWzWSN7DaEiDHUYvCjlrbNPgvljTAwK
         WHASmI2puq6zVSCQjjIQrdrIyeFBxwBGHLG9BfUbBBQ7PFrU+MyjgfAK5B/s4Ha0XN/G
         05hnnu9M3GwZeL4QyoFOs+Ln+E7mrqc7gw7ITFEOxV364z5tyqna0TLtO8zFYrnhCTwN
         S5Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715943712; x=1716548512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=soH3v7AjKgEzN9pDh9CRbKA35VUs2CBjMotD1Xr5BgQ=;
        b=HRi8YC66J+QCZoVbKtZIhI7tFCgf3tlN1/lkUbqXDmabT35boewLDBQlhX9FZMOqoG
         pTAveQQ7CGSCK3QA/AE3HiAv+rEfYs5Gon8fASDzzWmAmHYPNUgmoDZISZx8YZXhfCdp
         4bAEFnQMgKamrCckCoVSai5FNRdb37YIzlA6ODXte6D5neEKb2dnUOggQMDBCw2Et+l7
         Sp2aS6JoD6YfRI4S2eCRmgwsFi0oQwrL4Jm0hRa7CyTISk3eX1+D0ufF1VJooRgBKV9x
         EIlTbYZ9gkt/gEyxt9SCFlDyA86cL0JIl7eXBX72fznOoBkxU/gLyfN0LE+2kDw4uYO1
         z4ZA==
X-Forwarded-Encrypted: i=1; AJvYcCU9LrDiocs6mPJifwyth7g1BNoeNLBBiMmLtHctj0CbArPf6Q4f/1MqdWhOJFnXkr1dCyn9Ud9qYZyP0Ou3hjh12GJRrkeO7VhGAHk8
X-Gm-Message-State: AOJu0Yx0LaA80X7D4hxfel73l1k/vOEzZzKKi+sIPmyZcpKGoprVcnnh
	gvr7FBbQsnHx/QK2sHThUkxHo5/1HO4NTx7ObYI60OWuCn4/e2/b
X-Google-Smtp-Source: AGHT+IGWRUI+KkrY4q7GRyBZy+q4rOsmvMAtes0ZmS+o6XW+GOfg3unezpuOnZ6Zm1Gka0+HWIkwwQ==
X-Received: by 2002:a2e:9b4e:0:b0:2e3:8fa:6438 with SMTP id 38308e7fff4ca-2e52028daa2mr138676361fa.33.1715943712034;
        Fri, 17 May 2024 04:01:52 -0700 (PDT)
Received: from ubuntu-thinkpad-x1-carbon-6th.. ([105.99.23.217])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8fc6sm301201665e9.4.2024.05.17.04.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:01:51 -0700 (PDT)
From: Mohamed Karaoui <moharaka@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Mohamed Karaoui <moharaka@gmail.com>,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8192e: Fixes a coding style error
Date: Fri, 17 May 2024 12:01:40 +0100
Message-Id: <20240517110140.81732-1-moharaka@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adds a space before if statement's condition

Signed-off-by: Mohamed Karaoui <moharaka@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_ccmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
index 0cbf4a1a326b..b2af802b9451 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_ccmp.c
@@ -278,7 +278,7 @@ static int rtllib_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
 		int aad_len, ret;
 
 		req = aead_request_alloc(key->tfm, GFP_ATOMIC);
-		if(!req)
+		if (!req)
 			return -ENOMEM;
 
 		aad_len = ccmp_init_iv_and_aad(hdr, pn, iv, aad);
-- 
2.34.1


