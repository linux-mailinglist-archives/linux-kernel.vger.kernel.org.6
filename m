Return-Path: <linux-kernel+bounces-547612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FCFA50B97
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:37:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A9223AF7CB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FE0252900;
	Wed,  5 Mar 2025 19:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX5xc6TG"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0646C78F3A
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 19:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741203413; cv=none; b=g1bm2A5m9dKdHZxjDRa3e8ZJT9ukcOxfmxDD3JDe2K7ADCCFuM5Q0vOTYbQXv/jOsNYCISb0uU/99ZRDuo6uJGz/jS4z98nn5lrcZg9krmEeTdQFYECKefNF0etbo5BE5NTDYDqqGN/wkUazp11orRKnvq2Cs3qxSm49tco09AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741203413; c=relaxed/simple;
	bh=f+EcBHq0gIuPChKTRpZ/xjUmV0aa5c76pyhQGIXjb54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imRk5oVJdHB/ntuqX+g6YkNH7wyHDIbMDxJCa6h0Uu9G9HUDGwQeDJieDmWa1ItklO9wMPROPhrIorVRZmYbnUtQ03XP2DQkys0k50qayIBcC6xHbSgKzWBTD288r3YVFFeALeF/MWBmuuSii2LH4pplsEmIPo+WjVP4qwRLvOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX5xc6TG; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2fe82430bb4so1882168a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 11:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741203411; x=1741808211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sk/Vps+XrXsj0EE9YsBttNsi6jhkGXsUnHgeSBsXBQE=;
        b=gX5xc6TGRvMFclW3JZ57E1R8cc86YMI6wAQ3vT6pcwYlVeSStdC07s2cZ5GyNZLHBL
         654BjVhAYib0L1Cp/nvK4/CCZNakwknhgJ6emQyyx1s/uneySuyovr3LhAade8OTu0Uf
         zqaeIpC9qkG/pJTVMrh1MrqiEL9SDmguOPG5pgMduMxo9JJZExK7PY1JLOMuOTYW3U4F
         kgIEvsddYJtDfLmtm8cu3fw1Haj/ntwP8H4F8uzu3p3GH6ugMzVZikNSXQA4CV4OQM8v
         tLardeaNBg/S94A59dlkAjmXPeCeNP21b5T40ZZFFQAbK7xR68k5KJmKvtf6VYBEuxAi
         cmOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741203411; x=1741808211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sk/Vps+XrXsj0EE9YsBttNsi6jhkGXsUnHgeSBsXBQE=;
        b=iC+hjjykmg8pdHCpRYTn+s47VbOKNV4R0bADhienriAF0C07IJ098+Agui2FFEOuEf
         B8++ckYwOEUgGEHeIJmieF/6OrDPsq2fLw+RVL9pJiX7pXKyb4Rqo4MVffFs+fbX/+0F
         vhltMFsn/2vNCfEHXcLdDKnCaVO+5BzQ9CMXucrZPB5hWJ0PoqXPFP6+I5aYllmwWhSG
         U9oz26LeWS9Dz9YAtRd+hZzOjqYmNQ09hMFVeUMlPX8FcTrd/JCVUNgZMkUarx9liX6N
         zf6h6gPz4C1JW86jTLRN2/M9qo+kNyBYNNr/mL5ZsELe9Vty6qYt5bH/gZK7KRiEJawM
         ZL5A==
X-Forwarded-Encrypted: i=1; AJvYcCX66lMwOEjayMMxRU3TiK9owXbN7MaZ3LPxsnKyzBQmG7iNpzbPHbHLDHagZkD3rQ8VEyDsnngbdOb+oIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTHNROrieT2FLwfjOPntJu6IYw1VnPoYy+3UsfcKbXcELZx62d
	q88MIAJzAPeVA+pNwEfekQBCadoN+/eIYYAmW0tFthbNMR8vfOIP
X-Gm-Gg: ASbGncuUG4IYlNfVLjpvIU2FwYoz7nswsS7dVkgWeVHEu2pNwoNUkIh/jQ0wDh/o+ol
	nytUcepnxVKQenOJogD11rYT2CrbNiBXenJdoa3Q/9+OvbebubnWZjJmZDZGFdnyJmm10qqNUm2
	Ri63RzCK2iiwGY2zVLWRPwSvRJnN0KgOrHvQ4af6xCwlLN+9tzeQsHLFWrxvmWw2nLigRPJLb10
	KC/gQ/1afBcwtLTe56XeycQPo/I3pcWx61xtBHUaPfwIKJ9m5a62UT6UGnBATY2Pa5uFj0chF8b
	UPZ+QZ0EPlShI1FNUYB9ZRvIw4pILSkjC+WtX+6coZ8gRM4oCAFHH7vpBvoV
X-Google-Smtp-Source: AGHT+IFQ9HwEoVTVlmufm04/RgIQIMt5CoKXcTADkaczq5WVDkpG/N4C0fD8ORB3wOOwpnFJIdaf5w==
X-Received: by 2002:a17:90b:5344:b0:2ff:4be6:c5bd with SMTP id 98e67ed59e1d1-2ff4be6c6ecmr2272508a91.8.1741203411157;
        Wed, 05 Mar 2025 11:36:51 -0800 (PST)
Received: from localhost.lp.veng.com.ar ([200.10.125.114])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ff4e7a2bbesm1898148a91.37.2025.03.05.11.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 11:36:50 -0800 (PST)
From: Gaston Gonzalez <gascoar@gmail.com>
To: linux-staging@lists.linux.dev
Cc: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	dan.carpenter@linaro.org,
	arnd@arndb.de,
	niharchaithanya@gmail.com,
	jiapeng.chong@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	Gaston Gonzalez <gascoar@gmail.com>
Subject: [PATCH v2 1/4] staging: gpib: fix kernel-doc section for write_loop() function
Date: Wed,  5 Mar 2025 16:32:16 -0300
Message-ID: <20250305193614.39604-3-gascoar@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250305193614.39604-1-gascoar@gmail.com>
References: <20250305193614.39604-1-gascoar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a colon character in the kernel-doc section of write_loop() in order
'leng' to be picked as argument by the kernel-doc compiler.

This change fix the following warning:

warning: Function parameter or struct member 'leng' not described in
'send_command'

Signed-off-by: Gaston Gonzalez <gascoar@gmail.com>
---
v1 -> v2: no changes in this patch.

 drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
index 50faa0c17617..eeabbdb39057 100644
--- a/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
+++ b/drivers/staging/gpib/lpvo_usb_gpib/lpvo_usb_gpib.c
@@ -232,7 +232,7 @@ static int write_loop(void *dev, char *msg, int leng)
  *
  * @board:    the gpib_board_struct data area for this gpib interface
  * @msg:      the byte sequence.
- * @leng      the byte sequence length; can be given as zero and is
+ * @leng:     the byte sequence length; can be given as zero and is
  *	      computed automatically, but if 'msg' contains a zero byte,
  *	      it has to be given explicitly.
  */
-- 
2.49.0.rc0


