Return-Path: <linux-kernel+bounces-563829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D257A6494A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C95C3B1C29
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCF823314C;
	Mon, 17 Mar 2025 10:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUF6kq6q"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70083221D8B
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 10:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742206550; cv=none; b=MAc0MyAC9ortdyQrCYZTstVSukb4KxCeLKg9JW8g/KTR5EmF0EmvDDsK5O1xXEpNrV43/yWa+7jDrKbXOiDIgx+EAlCHf2N5oa/hr9MceTkLUDk4lhQFaxjby974Ws5hl7x1C/y7nglQxITL89eHKFQrI+sxjKcfZU1V87zSSRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742206550; c=relaxed/simple;
	bh=1l7Q7mQCi20PJnWdAgkw5bwW4RtzSVmvw9PlHRaT1qQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cSTFzzcKyD106gPpCcVzbJ9yNhAbPSAs0gTdDSaFdCgQzTCy/3fngOJViGqNHsFVMwz7LyW3WQnIfthPN8D8UHbkFS2lea/HU1s6SuLeHii4NqLKdrecmi7Hrj+FsDmAhA4P4fIy350XZjLM8wKM2YHdcFYpsTNMw+QuEp0n5lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUF6kq6q; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3913fdd003bso2008893f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 03:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742206547; x=1742811347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1inr+33gW8u8hP4Pm7UkuMSAgyxld8yZU4o4J1pFB4o=;
        b=IUF6kq6qu6q395OE5Eu2kedpqKHkcYRpZSXEGF4txWWlSPeQJudIvWUKlSnBoOV9RL
         fgOEEoMdhPmMtWWjCx0NFC40Hd2R6xsoByYS85kEjtjsJKomFlzzazQU18rXd3nPD2Qc
         wnGOI6vhSIVln03TiRpM3jD2FACwen3XckA8dng+L5KF5KiniLmNBfL33MvwtSbLgTZw
         bjYkTMQw0mn3A4LDsPjM5LWXwimRVYNZN9G4KRQzuuGGAaLW4X7NsoYsTmBgVZX3cmA5
         d5jnj+/voVvCqM3IT9AqPqfrkhMjrdjPWFKwKowEwID7uPKQHGQlNo5zTEdfqxslmebS
         tzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742206547; x=1742811347;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1inr+33gW8u8hP4Pm7UkuMSAgyxld8yZU4o4J1pFB4o=;
        b=YzVZyD4j/mhTgVZ+cw0vSX5kEgF7ypZbyuq2GjCC0pNj1tyHUw+eT8fTIhARdo9PVp
         1vYMjIZFV15nm+Acb0UPo0+w6zqa7rkFI/v5FtU59/hvhGQORvTS3IKAPsJ912Llf7pv
         wUl2viekbcuN3gWqMQVomJ3ArDI+EMuwxS5qxuFBZsqtB2E+S+OpBGUgbaD0iGLUGOSY
         RfwSZtMcySQAKK4l25+1kXFMIWyycOWvbvm/31NRMrEXwPPFQDTauUAkSMms66RVwXwV
         +1WempkzfcZwD8oulojUHqDefIN4RQNdqsc01I4e0xIn7A8lyqx2CLVdm2LRD6tLRhiz
         V3+g==
X-Forwarded-Encrypted: i=1; AJvYcCVspYznDzXig3/fGlCnAMwkbEoT5AQg5niC69JrACiJ12avfdaaQhaOUB+ao0RYvVUHJMaIdwsEBralwsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO5p63hAtOt7PAQN0kBOj6iLLd1HHmSD5MsOrBH2aPhST1E7WT
	jzHdjFSZ0Tys2YiEeirzCpJoEAlYFihvM55AbchOB2+9u7U8pWxD
X-Gm-Gg: ASbGnctnAGvdwQ4qxT/syEg1cPUSo56MIVKtkv7/FL48jo6riUeBwx15JT0iCaS1XLM
	mOg+KRRgRlFdawI79A4hlNxVLruMlVyH9/dNM0MdywmY5pJV1Y8R750kERa+YSz/dEAn7r3mELj
	7I3KOxEGfEYTcIfLItNPR0U2V8TjuQgeS6IkOvwz2eIeFvqKmjm5a1idk2hC9JgGp9M+K7AiG8K
	DCK1CNnjsdTWVB3aXc/mEQr6eQmwO0e3u/wpajDAD25gWQ3pyTMf7ao//O92CX6DhlOIhySXwym
	/qrVdnPWFgkjxGIxL6owDdNJUBik+bmXukJQCK/vtk1H
X-Google-Smtp-Source: AGHT+IFLlVRG9UZxYzimW02KbeiSJnPjwwmBF+OFjbkEFVEbZGHX/pcf48br8RKhpFuzAASnYKk9Ww==
X-Received: by 2002:a5d:6d83:0:b0:38d:d166:d44 with SMTP id ffacd0b85a97d-395b9a1c648mr15775914f8f.23.1742206546408;
        Mon, 17 Mar 2025 03:15:46 -0700 (PDT)
Received: from qasdev.Home ([2a02:c7c:6696:8300:12f:b743:681a:75c6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffbf901sm99582255e9.15.2025.03.17.03.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 03:15:46 -0700 (PDT)
From: Qasim Ijaz <qasdev00@gmail.com>
To: miquel.raynal@bootlin.com,
	Frank.Li@nxp.com,
	alexandre.belloni@bootlin.com
Cc: linux-i3c@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] i3c: master: svc: fix signed/unsigned mismatch in dynamic address assignment
Date: Mon, 17 Mar 2025 10:15:16 +0000
Message-Id: <20250317101516.19157-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

svc_i3c_master_do_daa_locked() declares dyn_addr as an unsigned int
however it initialises it with i3c_master_get_free_addr() which
returns a signed int type and then attempts to check if dyn_addr is
less than 0. Unsigned integers cannot be less than 0, so the check
is essentially redundant. Furthermore i3c_master_get_free_addr()
could return -ENOMEM which an unsigned int cannot store.
 
Fix this by capturing the return value of i3c_master_get_free_addr()
in a signed int ‘dyn_addr_ret’. If that value is negative, return
an error. Otherwise, assign it to the unsigned int ‘dyn_addr’ once
we know it’s valid.
 
Fixes: 4008a74e0f9b ("i3c: master: svc: Fix npcm845 FIFO empty issue")
Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
---
 drivers/i3c/master/svc-i3c-master.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index f22fb9e75142..eea08f00d7ce 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -998,9 +998,10 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
 			 * filling within a few hundred nanoseconds, which is significantly
 			 * faster compared to the 64 SCL clock cycles.
 			 */
-			dyn_addr = i3c_master_get_free_addr(&master->base, last_addr + 1);
-			if (dyn_addr < 0)
+			int dyn_addr_ret = i3c_master_get_free_addr(&master->base, last_addr + 1);
+			if (dyn_addr_ret < 0)
 				return -ENOSPC;
+			dyn_addr = dyn_addr_ret;
 
 			writel(dyn_addr, master->regs + SVC_I3C_MWDATAB);
 
-- 
2.39.5


