Return-Path: <linux-kernel+bounces-294655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5251A9590E9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 01:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A04285267
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 23:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DFE1C824E;
	Tue, 20 Aug 2024 23:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="bAKyBv0N"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910B7107A0
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 23:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724195446; cv=none; b=VM6fnvwl+DfyzbhH9hgS2SBteSNkfF0Jz5MmF2XoUEhrQPhZONROzWu/Y0Ek/5MFOKjHgFtUDmWrFBqkEqYem7fYY9JP7h4mF6eIa+cEg4A/ztbhAyBenJgK1vSlskJCOza9/Qt0mzb42W8QnAty1JYJt6NLEFAvHYlCGnexpis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724195446; c=relaxed/simple;
	bh=ODDnHjkbTp+wYrdvszMzX59oMIz5z1+6NAsNCpIoDQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hiYeDBgB48FDGLiXyeOJWx70oQWT7B9JKurUSimzyzMWBkE6/Sn5FSKt6EJeRVR3CF/8/iv6XOGp9kjTcgQH7WjQ86H816IsmQn7rVTondSkLRL+fnzw+GbpvW7gkjxe2aKvCLVVzPdBx+8TYabU5WI8DP39lxd5Z6GBfw7uI2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=bAKyBv0N; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bec23c0ba8so839052a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 16:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1724195443; x=1724800243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SX1ezoSJDugDwPOdGtHosBZWeg1iz+1d1+OhQfBUV7o=;
        b=bAKyBv0NYS5g3NOaTMjwc5svxX44GxWnXgcN7xj/ajFscSrBBqHC+7N7oJ+R5w74lx
         izauDxVqVumofJmlkVOOuCiDRnopb7lrUEhaSsbBCepQv4DaCpjGrdqvjQrv9NcbmPTv
         Vxn97MCAHhN7OjtVCUrdWcd4LoYYIo7qmw7YkN7y1QK7ro9o+QR7la0mzY2ou4L9jor3
         GxTb28ym1+/wWpuyCAvBPWPcHDcJ6ZdKDoAQNWcw0HuuBUahWJsY6VAkA5kB70yrqaX1
         W4iN9lbvJHLqzn1buo1JZY0RKkQTRuFkSJd7ufWMPleTNUr0H4KztLqC0nyuPqQCLWXg
         8/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724195443; x=1724800243;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SX1ezoSJDugDwPOdGtHosBZWeg1iz+1d1+OhQfBUV7o=;
        b=PZX/DOlX/SEn7isvbvIMYbGuY/4Y91pkD4zLze2NAx3vp6+qEKlaejULDyszuNC2Qj
         54HRYtE65qP9ZVVnbcG6j0on4gJihrGkWX/59qxrJPad9ckY1V+kUOKZNRjo3sz9rrkl
         jYNT3anowO40cgvdqEGeJBMR2S+vPiSF6Drz+Dyt5aLM0oF0Qe/FAK8uII1QzmKHhGVF
         FjyMY3BaEbnIjBs6xeu4JbjjfzW+9ug5h5zsBWdfI9cx/Z9XS8eIKEZTQHPJxwTEXDgP
         SSsgr5YHPDAWRou+3Yu+iIDB7YCaXbLwDIQBxuo+v+vfqbf1JD8h4TU0XL0Gw3Z1nkcV
         JclQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrGQTPUQNjaL3ruvp1OVzsIn5RekDuOPl/GEwp+T7JH4agUg6SpgX5pusU5Uv2WX7GZlK1X89RB6JXQ9M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ZQcSZnCAqabOAe+xHfJuXGX57CkD61bUsC2B2jkDrHHf7+P/
	OL86/aEC2DfISynt2iD5D8YwJMeLzkYCQnO7OKkWdcKUNsqQb5tCcicWgcXxgD8=
X-Google-Smtp-Source: AGHT+IHd9wFtG5D4Yy4a6ZJj8Q6kNR7yCZjSUshvttK1guXdXKAD1IWyRtKuhTvTSIFJnSPmC+d5Iw==
X-Received: by 2002:a05:6402:51c6:b0:5af:6c44:6807 with SMTP id 4fb4d7f45d1cf-5bf1f2c1ef2mr86786a12.6.1724195442641;
        Tue, 20 Aug 2024 16:10:42 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-228.dynamic.mnet-online.de. [82.135.80.228])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbbe2623sm7280801a12.9.2024.08.20.16.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 16:10:42 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: obitton@habana.ai,
	ogabbay@kernel.org,
	ttayar@habana.ai,
	fkassabri@habana.ai,
	osharabi@habana.ai,
	dliberman@habana.ai,
	quic_carlv@quicinc.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] accel/habanalabs/gaudi2: Use kvfree() for memory allocated with kvcalloc()
Date: Wed, 21 Aug 2024 01:10:28 +0200
Message-ID: <20240820231028.136126-1-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use kvfree() to fix the following Coccinelle/coccicheck warning reported
by kfree_mismatch.cocci:

  WARNING kvmalloc is used to allocate this memory at line 10398

Reviewed-by: Tomer Tayar <ttayar@habana.ai>
Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index a38b88baadf2..5722e4128d3c 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -10437,7 +10437,7 @@ static int gaudi2_memset_device_memory(struct hl_device *hdev, u64 addr, u64 siz
 				(u64 *)(lin_dma_pkts_arr), DEBUGFS_WRITE64);
 	WREG32(sob_addr, 0);
 
-	kfree(lin_dma_pkts_arr);
+	kvfree(lin_dma_pkts_arr);
 
 	return rc;
 }
-- 
2.46.0


