Return-Path: <linux-kernel+bounces-183494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 771298C99D2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 10:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01DB3B20D99
	for <lists+linux-kernel@lfdr.de>; Mon, 20 May 2024 08:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B2F1BC4F;
	Mon, 20 May 2024 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkEd3pvG"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495016AD7
	for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 08:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716193816; cv=none; b=Tl4Tx+PNVRZl+30HDBs0WrGSAX12f/YHh3yAymQVTRmoiZyc7z1DO+Xj6GV8YcU0Ea+VXUwRBGeSYBbQd4WlX08LzG2rIo2Njb2mxF6V7QpmhacP6eMPAkRTrenimWb52HLt/eCSy5Bk0y/W1wUlA2/iTz6Xqo2P2QWyu9QZZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716193816; c=relaxed/simple;
	bh=v6Iyqtc8wfN1VDirNIoRyLWxOS50eG0jPJIfKCj8GPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ARantpqidXEAuIE0mAbvwyV4xEL8bWUvoGMcF0V3D6/DiO6MGDyc4/2rciuHt30B032zSnOhJD7Haj9mdesTqbP3kC1pvu6G2OYnpRzm7QuCHgJ4noPSNmB/t3xvq5oMKYdJdYdOH1dNY3GUQjLUHDZ/HUBP/ckFN8P/75tYbpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkEd3pvG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-34db9a38755so2283757f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 01:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716193813; x=1716798613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K3/H26ugfi749Iso620GWcwRHXKuJ0GDNWWDX00u2LI=;
        b=fkEd3pvGdNeZu/zPwfi+cSkXMyDdfU9lpaLMx4g+xVurDDBscyH8JViQ5NU9pQdILw
         SG9bNOI06G1D6KYgqJyFl2vciqq/mH+/diDgfg1WxVgDU1XPnaNVUf8WRuXyyDYixZCn
         mvkSNoZfcpw2RM2UXLCKFAAIz3cn3gO6gddUQxDKO1xw1Z6/qt/E/cUkKtPaE1RiYEJU
         kkWcIDayKM5ume548Iwui8Bc2AbxiPqonMk2xQXVjUyrlp9Cf/VUDnJTDkRlBktVvlEL
         PPtnUlW/HoOBPgxL/eIiX+GHxIBNvMduY7ULGPrzO2EZPnvicw4YycRnFLoiKuCO5Oii
         6WTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716193813; x=1716798613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K3/H26ugfi749Iso620GWcwRHXKuJ0GDNWWDX00u2LI=;
        b=P+po5kYScmQPIU6ENGYKWvRpIu6shKtplLmo148/RrOl4yHr5wmX668nftBjRgpTq5
         dKEBrB0EQKRdTNicUTWloeHUl2GukPta2R8R8zWArG2Ar/ZFMnkdBz48CfTauhSbEfGy
         FQh274avNaT+wz6HcYtQEir5GiMRTsotscU0Nia0C+GOz/gx38KFYPjlKcd+nYc2N5Hq
         NvxqumhUf1hTE0ma5s6rnMpH3ZMnun/57wWrJEb5rYai6MkBXJJspk07MTpsY5x4DRFH
         5r2iyTgCoFiS/m74Bzqsxbtd/64PpAgs2q1iz7/dcAP5TROastUGGoadRZ/1S3Q+dVPH
         oT7Q==
X-Gm-Message-State: AOJu0Yx6oU571fva9aZBgXvOrikUBcFMGsTLzLvNeQOIxQYMe86kJscn
	GoD3oTwH8/q2ZbtuBLAhDK50e3DZKOxkdKOyqVhXnqju8ysVTh/aippcymnv
X-Google-Smtp-Source: AGHT+IGQtngzTTWsaCq5wXW8QE5DjEvu7A57Ej2MaQZX96OOeOi5rPS2Dohu2BWKbRTdhnt9eonSKw==
X-Received: by 2002:a5d:530a:0:b0:34d:9aca:f4bb with SMTP id ffacd0b85a97d-3504a73727bmr24212026f8f.19.1716193813139;
        Mon, 20 May 2024 01:30:13 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbbf9esm28376437f8f.91.2024.05.20.01.30.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 01:30:12 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/boot: Use current_stack_pointer to avoid asm() in init_heap()
Date: Mon, 20 May 2024 10:29:55 +0200
Message-ID: <20240520083011.135342-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use current_stack_pointer to avoid asm() in the calculation of
stack_end in init_heap(). The new code is more readable and
results in exactly the same object file.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/x86/boot/main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/boot/main.c b/arch/x86/boot/main.c
index 9049f390d834..ac78f8c01908 100644
--- a/arch/x86/boot/main.c
+++ b/arch/x86/boot/main.c
@@ -119,9 +119,8 @@ static void init_heap(void)
 	char *stack_end;
 
 	if (boot_params.hdr.loadflags & CAN_USE_HEAP) {
-		asm("leal %n1(%%esp),%0"
-		    : "=r" (stack_end) : "i" (STACK_SIZE));
-
+		stack_end = (char *)
+			(current_stack_pointer - STACK_SIZE);
 		heap_end = (char *)
 			((size_t)boot_params.hdr.heap_end_ptr + 0x200);
 		if (heap_end > stack_end)
-- 
2.45.1


