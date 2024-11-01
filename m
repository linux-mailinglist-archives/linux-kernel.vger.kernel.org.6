Return-Path: <linux-kernel+bounces-392661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFCF9B96C3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564E128311F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D331CF5CD;
	Fri,  1 Nov 2024 17:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgPYIjOa"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E61D1CEE80
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483275; cv=none; b=NeJAhEV/NL9pVtEsNQadG2kE00/rgrV8+MpcSkp2N5WbbsSg3TnUVMRUpJMPLUydqtWFbgfReNrtWFW1+yuCgLwwQvGpEUGyGxvbZwN4qU74uFM3ntZi3kiZzl+I9oPeciZWJE9W1+u2TtOPp1HVrAHu1jTPViuWW6R+RVZzM0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483275; c=relaxed/simple;
	bh=vp9brIm82+sri2wgQZ8jwsv51grmgrK+Q9ybRLWbnu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQ6pyHscaYEmFpTMgTy6Pui4Bvo0p/biDEZr/e7eq0HtYpckckzor4fcGaXeeXFf8Xr+RAgeJmGmBS0Yx8HTFpTM7eXozjRqsPInDqG7ZTPg+ATYpncJKvWKB9xPJ3ie/bREQyMjNP99MCaAZbT/jBRStTzleFeVTI9RCF5/Kss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgPYIjOa; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d55f0cf85so1519253f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 10:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730483272; x=1731088072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PxfRaBd2Z4IAnFtE1pVDi1Drl+tQCB1zhAZtdVbCCqk=;
        b=MgPYIjOaZQlZkOyVEJ/PTvUCaNpBpa7s1JAQQBeVWaP1MYXNhXjJ/2rIBJN97J7Qb9
         i0VMYYjsNZun2eCim0CKo9Vc9S1w9ZTpFRYTKTsuet98eFF7dHvec0pcsZef3s1xpXxp
         aHtXk6y7VAabFcgYvQdxzLt2iR5qIvh3ZM0GS9w1wuvaj81OQlkefYuxg5hyxkEFe9cN
         ILViaXTQx5RHQeIIJntniXsvoxgrhCOKM/Uke7MWlpH2LTFCDcp7AOCvGvmZ6pYGAY7g
         X4FnK6xE/PguEhEDA62rLmuuZc2BS1pZcLqL1qnTWkQ7UHdK+0dGCtTsb5XfN5oPgjrr
         x+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730483272; x=1731088072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PxfRaBd2Z4IAnFtE1pVDi1Drl+tQCB1zhAZtdVbCCqk=;
        b=DHzxi0Fbf3MqArcY71LvcVXOUauoZUgc62tCkeLj16WL2rxv7cxjNQuObw0BVXu0pW
         ojo3BCMbWRUQu75VZBFr8hjfKNcU2AdEePx/hL69MVuheGw0Ih92y2+7gKfJL1hWNe2A
         hSVnuIn+5/1fS0ugllx2dz/Qe45IZzBdvyYadp/YZqP/GOhew+O+/fKstxZWrMveLYfB
         AgBonXHruCP1HS1soDoODMus3MEiD7ARXG0ektMegRAAWN9WFuG2XYf7rmmY1dPWVrUK
         2yIwjh3WjHcTwBqeNMDWa81iZTGrrYlnZyX1XDM5Tb2DkkMBjfB3z1LO95L4LMF5Ub59
         ICDQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2B7fz+5Mm/UrckqRp5g+zuiaDzkYmHcMYlBwRpXWNVqx/0nGI+nbadqnrERDn4LUE78Rfr7Dz9M4Lfrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEiJiB5bEgKU09npnFd1I5n3G2yLBTlPObQ79dk3DXT7ygy6l6
	+UeZOMjBGGxkcYW11ak2APbzSKPrppsmZ/vlW1QCMUJYbUpsKGqu
X-Google-Smtp-Source: AGHT+IGLOQm2Hs7TEtonoWfGm48x/Hh2jXZbzg/FowWQbD3IP/YZNteRD9TAQtsjxuFjEOkgSWVguA==
X-Received: by 2002:a5d:6da8:0:b0:37d:4e03:ff8e with SMTP id ffacd0b85a97d-381be7bae0emr6837279f8f.28.1730483271730;
        Fri, 01 Nov 2024 10:47:51 -0700 (PDT)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c1185b4bsm5732933f8f.112.2024.11.01.10.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 10:47:50 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 9/9] Correct check for max secondary address
Date: Fri,  1 Nov 2024 18:47:05 +0100
Message-ID: <20241101174705.12682-10-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241101174705.12682-1-dpenkler@gmail.com>
References: <20241101174705.12682-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

  GPIB secondary addresses can be between 0 and 31 inclusive
  unlike primary addresses where address 31 is used for UNT and UNL

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/gpib/common/gpib_os.c | 3 +--
 drivers/staging/gpib/common/iblib.c   | 4 ++--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/staging/gpib/common/gpib_os.c
index c0b774a831a6..65ab190ac68e 100644
--- a/drivers/staging/gpib/common/gpib_os.c
+++ b/drivers/staging/gpib/common/gpib_os.c
@@ -525,7 +525,6 @@ int serial_poll_all(gpib_board_t *board, unsigned int usec_timeout)
  * SPD and UNT are sent at the completion of the poll.
  */
 
-static const int gpib_addr_max = 30;	/* max address for primary/secondary gpib addresses */
 
 int dvrsp(gpib_board_t *board, unsigned int pad, int sad,
 	  unsigned int usec_timeout, uint8_t *result)
@@ -538,7 +537,7 @@ int dvrsp(gpib_board_t *board, unsigned int pad, int sad,
 		return -1;
 	}
 
-	if (pad > gpib_addr_max || sad > gpib_addr_max) {
+	if (pad > 30 || sad > 31) {
 		pr_err("gpib: bad address for serial poll");
 		return -1;
 	}
diff --git a/drivers/staging/gpib/common/iblib.c b/drivers/staging/gpib/common/iblib.c
index fc57e760c144..5678e8bd709b 100644
--- a/drivers/staging/gpib/common/iblib.c
+++ b/drivers/staging/gpib/common/iblib.c
@@ -498,8 +498,8 @@ int ibpad(gpib_board_t *board, unsigned int addr)
  */
 int ibsad(gpib_board_t *board, int addr)
 {
-	if (addr > 30) {
-		pr_err("gpib: invalid secondary address %i, must be 0-30\n", addr);
+	if (addr > 31) {
+		pr_err("gpib: invalid secondary address %i, must be 0-31\n", addr);
 		return -1;
 	}
 	board->sad = addr;
-- 
2.46.2


