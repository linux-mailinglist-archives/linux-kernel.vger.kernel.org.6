Return-Path: <linux-kernel+bounces-317185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD32E96DAA1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54B2B1F21FB9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867151991A9;
	Thu,  5 Sep 2024 13:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxC3sF/k"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DD219ABDE
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725543963; cv=none; b=YTLqCPWO/OEPVTHRuqErIj1MSmSSDOTmUUbzpFpqDgEoG4FTPhwfRfRgX4EWSluuLXbt7H1xosQ/K9u+YlPYlCP1euyBN445gRmUEWQ25NQ/v56zGkGIs90uLtnANweupc6J63KduOGPNGWnIrNVTNd36f5SvELlfjou873lssw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725543963; c=relaxed/simple;
	bh=m5IMTqd7YUvgmJ7vSwi2nF/paIY7e6NZR8sqtfCd/m4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kIaoPfIcsrJobzvg5YyYd42tlUV+U9WYc98Pv0FG/z3Ot3dQCUhLJo6dZtsUfEkA0MaVjhDn3mhieqJC4cM4Eg9ck0jLBzHaeKq5weD+hQeV43MjZ36EQ9f22URuV9Xc/iJpjZhzzUQquGUKtAC+//6DM+TofF2iY3I1J7Y/WWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxC3sF/k; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-717839f9eb6so88506b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 06:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725543961; x=1726148761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zLrIGtrjGMvYCAPgpSbeYnDN/jGY3WpFtOUDcb9b6FM=;
        b=TxC3sF/kznag/Bwu12Kv35usq5o6E8OM/qgDU0ltjgfV9qEh5ufBTjoZfNxlLrAJOA
         /RMHwcRoK8bXuQz3mf0KABbvgQVnkyCmVoEFAn9bAZ2pqKkuTq/7VyhY1lZL2V8ozMJ1
         Zd9g+StgEZDVu+HUCkIemVHEe+Fb5PGUI9xlKngV7SHzxlEJm+N2IbHrpfNyxDaFf/bD
         OIFmhWuB2DHwk3sY4nh8HJW+a7rGHiVxz20pdD90CsAH8LfOdGiAjHDln/5h5WPC6Dg9
         e0OszMNBAwnqB3ANxHcBl9Ie/xIG6ueqS+fbtWfgllDChneIztBgt0/2iby1OuztL4lO
         k9pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725543961; x=1726148761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zLrIGtrjGMvYCAPgpSbeYnDN/jGY3WpFtOUDcb9b6FM=;
        b=uwdj2qIvyrF/i51S8EXkWwTV9+Q2N5E8lprC6Zr9xxXvKAORaPhoG3CIdwxhjtPRiq
         stSZ3SsXmBmPr9kY7j5VILgNUTvFnDfXC7DppTnxRqZaNS948ffQGCHbS7XHxLe55MXP
         KDLk9zum1RbhGlvJzwM47zWluGdh1rnJq4A8N60gcEVgi+M94FuC5pRrz5E7XYw5TMD7
         xzeicRdBbSEwXBYfOlqA9HH6zg0PeVg07E0o8wO4qwD9QZFN67/5JlCEeIpoR9ogZH98
         U7CU7F6K7jrdOIt3M404OHD4kXDrpj7qy9eb5PzplOYUCkz7kxQy+zcKDWAbziZnfBZQ
         rdMw==
X-Forwarded-Encrypted: i=1; AJvYcCXxcoUlBimjjChF0viCyZzIqM9hKsh6y3J0spgOkN4802dp/toOEm9CsRok6RZgzzFmASEZQM1l3OQ3JVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1hZ+POfLW/zyw3jg/hIgMSgrw7o9kfjDyrpKRyd0Idtey3/8R
	LuLUfo2EffUEEhJm5il6LbvpPVbbqM3WmGjMPLQaCd1Xg8H+oYQt
X-Google-Smtp-Source: AGHT+IHTG6m5a+YqgJ378/nJai2f+IufcP4BKwMpjbBW2YiqD+QLiySRaTR200H30C/v3pS/TmUCYw==
X-Received: by 2002:a05:6a00:2d92:b0:714:2051:89ea with SMTP id d2e1a72fcca58-717305c80b4mr12306175b3a.1.1725543960712;
        Thu, 05 Sep 2024 06:46:00 -0700 (PDT)
Received: from ubuntukernelserver.. ([110.44.116.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177858bfd5sm3224500b3a.133.2024.09.05.06.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 06:46:00 -0700 (PDT)
From: Roshan Khatri <topofeverest8848@gmail.com>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com
Cc: Roshan Khatri <topofeverest8848@gmail.com>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: include: Fix spelling mistake in rtw_event.h
Date: Thu,  5 Sep 2024 19:30:36 +0545
Message-Id: <20240905134536.4364-1-topofeverest8848@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes spelling mistake to increase code readability
and searching.

Signed-off-by: Roshan Khatri <topofeverest8848@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_event.h b/drivers/staging/rtl8723bs/include/rtw_event.h
index d48bae5416fe..62e0dec249ad 100644
--- a/drivers/staging/rtl8723bs/include/rtw_event.h
+++ b/drivers/staging/rtl8723bs/include/rtw_event.h
@@ -28,7 +28,7 @@ struct surveydone_event {
 };
 
 /*
-Used to report the link result of joinning the given bss
+Used to report the link result of joining the given bss
 
 
 join_res:
-- 
2.34.1


