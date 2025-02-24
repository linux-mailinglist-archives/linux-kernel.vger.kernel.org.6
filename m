Return-Path: <linux-kernel+bounces-529664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC5CA42977
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73CBA166C54
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5EA264A71;
	Mon, 24 Feb 2025 17:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="VTBupOZ1"
Received: from mail-io1-f97.google.com (mail-io1-f97.google.com [209.85.166.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8EF262D07
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740417825; cv=none; b=kLiOjwU7T12+6eTI6oM+8X/ZwwR73Mc18UoLkjMKOWcW9K/B84lJcIcS85YxsLyvpbMTDjlZIx7dvGvU+aSkRthz9E4uLAOtW2QcGyZAlFe8s2ND8I82TR2Nal0yogEsEvkwLivU5ky2ruWx3HMTmjQuJNOeoRMm6Tzdl9Vgt/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740417825; c=relaxed/simple;
	bh=4Rv+qso5EosFUpf/IhEJ3R0luVIjkQtyWVZSNnagglA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MD2h8ywSp084LmY8TcsbkPO7pmBUWbNh3DGUw/fiFWmis4oN/MqpX27BQPeVviskAPAkXo5KltvXUsuMeYONWA1gqQhbDpbKyLmEwlIPhzDNAmrkBHhjSu37+um/gp1mfXxKqLQEgBG5fCxv4XTsw2jYlVqz71Zebq+rlWNN9MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=VTBupOZ1; arc=none smtp.client-ip=209.85.166.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-io1-f97.google.com with SMTP id ca18e2360f4ac-855a9566620so13429739f.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1740417821; x=1741022621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p2UgCWe2nVWlOHQP1unFoHEREXqq14l2rqeEiZsuv8s=;
        b=VTBupOZ1/S/wyEcw3ek8A+Wb+zBo/B1M+7s1u0G1xHgt1ID3dHse5XaeWJqRXzVDKw
         yrFnh4kNbUjpx3/p0iR6RzEa1yFCM/noCuuR+x5+dgD281/BeVUB2CB8Vbvr8FpRh0E8
         Bxgm1kHr+GVX88zNKVuatH8XZUAIndyUi1w4KJnDKdg3ZtUEkHKJ0qnxZ+LtwFrXkZky
         uyCzl3+4CgXjobvul9kNfyfSa6Q6BKWqnattoMhKl0zg7eCZv06m5Rl1TkN9UTiVJydn
         7JPDzaQFu7EjUCUu/TTaCeduAUiSx9sIdLl7w2TkdtFyw0fl5YNUdVOjEzluHMntHoGN
         m11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740417821; x=1741022621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p2UgCWe2nVWlOHQP1unFoHEREXqq14l2rqeEiZsuv8s=;
        b=UedJRZmT8eSogsQwoDTN/4rtTDM5CJvIlvbAJ+8zPGEN1CHa5yqEtqOzfsEvbcOsoH
         xqUBdetBjqYP3t2gYj8g4YqM7iXsAK3YJZ/mI6zdXFcLQY564XkGh3O7beEMYMFhe66g
         Tue5rUYYKUiO4Ri0KJG3DarV9emV9kvuE1DYVPycNMS6suaXtHGBNqiHExE+A5ojt0K3
         qHECGFIZO2KGqPjpOXs4DtXAGnsE6esf52hMwVC33MDzHLDvqKqb+G/C+8LjiPko/824
         KCPSuqGXa9TGD2V/Gik7y9tKaOAH7kZl42hSP7WtVW1qZqsH2+z/ChagXgKD0amfW5og
         zIlw==
X-Forwarded-Encrypted: i=1; AJvYcCV0FRtzRh7Lq5nY3qRCJqGY7x5WnMH2RT5W0rx9VPeg9gSlGLuI5+2YJF+k2WWpvzk4GfrGHMD2lcNjvbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3YrLJt1LFYIPc7tGEXazD4QDMGPIJgmgSOnBaVZ5V7NFwQctZ
	tPx4kzhNrRmZ7OAi6srrdXYSDxm07aIxLRkdMrJ8f9ed2QMTeN4TcZVTARQ6ehnwoB2DNsyCAF4
	gYPK+z7Xxe7PD7QpwrHEFX84dVx+2s5Qw
X-Gm-Gg: ASbGncsKW0Ol+CzWj15Gw9ueylB4PiH6XjiOlaRz1GhJ+m4N6oOjBA57bMcnOxUrwi8
	IwcCSKhIX5sHIS5OvW0PqNTk+Ystq+L58nv+rEDQ27k9H8sMIsFfneS6PwbJp0fTa4J1nDP1O7y
	y0ek1Xt/uJlYqAY9BZnyMKzUp3MygdrFvN0itBzQpwMzmVTGJ802YsatpHqLPx79PmqxfHU/NqL
	vJ3mYMcmcZ8P0v0X78WxGrEGha7z/4a0c2IX1vYD8x06zr3fm1/mAjdCHLz0U9wCRCbRom7fQoF
	n0nQgpMegcy1c0TLjD+9UiqGqGs+wtQr3EGOkVDKli3shSPv
X-Google-Smtp-Source: AGHT+IGFqhhLEKvt8578AEoTows5+TiUaWB2QXQN9GVzloVyiOnLjkpFAvTONnfScTuh/yBGXSPSHTLcLQYd
X-Received: by 2002:a05:6602:140c:b0:855:d60d:1104 with SMTP id ca18e2360f4ac-855da9cf953mr395841639f.2.1740417821269;
        Mon, 24 Feb 2025 09:23:41 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id ca18e2360f4ac-855a2ae2fc3sm69797339f.2.2025.02.24.09.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 09:23:41 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.7.70.37])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2F9473400EA;
	Mon, 24 Feb 2025 10:23:40 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 2D7E5E40F7C; Mon, 24 Feb 2025 10:23:40 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	io-uring@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] io_uring/waitid: remove #ifdef CONFIG_COMPAT
Date: Mon, 24 Feb 2025 10:23:36 -0700
Message-ID: <20250224172337.2009871-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

io_is_compat() is already defined to return false if CONFIG_COMPAT is
disabled. So remove the additional #ifdef CONFIG_COMPAT guards. Let the
compiler optimize out the dead code when CONFIG_COMPAT is disabled.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 io_uring/waitid.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index 4034b7e3026f..54e69984cd8a 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -40,11 +40,10 @@ static void io_waitid_free(struct io_kiocb *req)
 	kfree(req->async_data);
 	req->async_data = NULL;
 	req->flags &= ~REQ_F_ASYNC_DATA;
 }
 
-#ifdef CONFIG_COMPAT
 static bool io_waitid_compat_copy_si(struct io_waitid *iw, int signo)
 {
 	struct compat_siginfo __user *infop;
 	bool ret;
 
@@ -65,24 +64,21 @@ static bool io_waitid_compat_copy_si(struct io_waitid *iw, int signo)
 	return ret;
 Efault:
 	ret = false;
 	goto done;
 }
-#endif
 
 static bool io_waitid_copy_si(struct io_kiocb *req, int signo)
 {
 	struct io_waitid *iw = io_kiocb_to_cmd(req, struct io_waitid);
 	bool ret;
 
 	if (!iw->infop)
 		return true;
 
-#ifdef CONFIG_COMPAT
 	if (io_is_compat(req->ctx))
 		return io_waitid_compat_copy_si(iw, signo);
-#endif
 
 	if (!user_write_access_begin(iw->infop, sizeof(*iw->infop)))
 		return false;
 
 	unsafe_put_user(signo, &iw->infop->si_signo, Efault);
-- 
2.45.2


