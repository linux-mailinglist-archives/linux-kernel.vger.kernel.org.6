Return-Path: <linux-kernel+bounces-252047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50085930D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019BB28144B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 05:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D438B13A89C;
	Mon, 15 Jul 2024 05:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aaSUbhqP"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995DE28FA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 05:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721021139; cv=none; b=RUDIwV7slCe45Lfu+nanS+kpoCFgS4rax1I29htcAqALeba36jQo6gGUHmUuZ/mC4x1OsavbBJpfGnieQShrY4vqYxwlZJF7rUXyMHLx4TH49wKa6CYpGL9uxzA1zk5Op1oClzwRIhYxYP0G/ffsYns/9fNHsN3q+YpcBf7akE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721021139; c=relaxed/simple;
	bh=uNybm9312UyQuk/4xWwaFU9BCHY4RwMbo06sAoPjLTc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K1MqvZ4jRfrPDZgkpxId8Lf+vAD4GxOjH9I+W+VEvxE6mZdUIBqnqQXYtMvInp6CcHUHx1EJ0zFZQDde4NHBEcAC2lyZp4vjeQ43Dlu5N4gk+T6vI2LfEQDQ5fX6/Qed1O30wSNZ72VAZtEu1oZQG5fUNBf9pqtIy89L2ozY3cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aaSUbhqP; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2eede876fcbso18191711fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 22:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721021136; x=1721625936; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NwhTp8Ti17hnGwDmFn16RqjJNm3oP1ckY08+U4d/ArI=;
        b=aaSUbhqPx/ghGXze5ATB7kwwI3ZilMf3NlYb5mJhN69Kh987L1ABMpT1qWD/hKg+dv
         ToFhSTdjsgMvlQyuuJUNTGwGdfGTc+hWzYO7ryq1tatm86iS6+TVKrEKbZJ+HP+77C9L
         eTyuutSpV1iTR9kZSB387fpHK3KMb9Em/cvbtt9F5jV5TgHVWanikagOIs4kQ3wCXEgg
         r3mZy67tRoVwxfWJ4VCZpvQIwg4zHDgTiyaFLcLEb2R70ZXgtKqZYxss7qqp9h+7kk2E
         ih3OgZFyuHpMggyU9+ZCLcTQPc7Rbhv+RWq6e1pB2MVhR3NhlhMguTfaqLsVY9DsC62M
         EdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721021136; x=1721625936;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NwhTp8Ti17hnGwDmFn16RqjJNm3oP1ckY08+U4d/ArI=;
        b=EDNVf2CE8Uen1gTXKGnTSJdg6fnpDNghcxr1bRWbb2vg0NvO5uDwY9NnwJTPOrMHon
         6vxuW7PkZ+KkF+oPfiZEu7zhOLva2UHwk8XTCRcT/hbzpfpFgxwDvBZbTwTIwaDavEWE
         erM1+GnTZWkl5DhnRNYLhKqeJYsq1zf5/+QGucKWZfjzQMfT5tfeN/sPH+QuKhzp/2Xt
         nbzU97TW0yaWX7l88rtCccQgSdSeIenTyAyZQunVCDOvUfIlfHe3xcZanJSJ1ASKYxd7
         B2+eMQZCRy/m7h4Un8ftSpvziWSY5rolBztOKzvxDPJm3N9CirT5/V0iCVSYs4gQRcxd
         5njg==
X-Gm-Message-State: AOJu0YxfhPyEiUURY8toplQOnUT2W5C9cti450QqUR/bMOI4IjDoCM97
	qLt6jpr8ggkRP/pHX/rjwCvs44wb78o8dJKlIels1j5KP+T30+DAYZK2
X-Google-Smtp-Source: AGHT+IH1ECnnWRB3AAShm1EzZxhFoPpyVTRRF4BnBkPvQf7K4mjnVSRNJY3o+wtxNPfKwRRVGoieHQ==
X-Received: by 2002:a2e:8784:0:b0:2ec:529e:6522 with SMTP id 38308e7fff4ca-2eeb30ff03dmr112718161fa.31.1721021135480;
        Sun, 14 Jul 2024 22:25:35 -0700 (PDT)
Received: from p183 ([46.53.249.76])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b24a76fd9sm2928581a12.3.2024.07.14.22.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jul 2024 22:25:35 -0700 (PDT)
Date: Mon, 15 Jul 2024 08:25:33 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: scrub ia64 from poison.h
Message-ID: <c72e5467-06a8-4739-ae6a-7c84c96cad77@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/poison.h |    6 ------
 1 file changed, 6 deletions(-)

--- a/include/linux/poison.h
+++ b/include/linux/poison.h
@@ -52,12 +52,6 @@
 /********** arch/$ARCH/mm/init.c **********/
 #define POISON_FREE_INITMEM	0xcc
 
-/********** arch/ia64/hp/common/sba_iommu.c **********/
-/*
- * arch/ia64/hp/common/sba_iommu.c uses a 16-byte poison string with a
- * value of "SBAIOMMU POISON\0" for spill-over poisoning.
- */
-
 /********** fs/jbd/journal.c **********/
 #define JBD_POISON_FREE		0x5b
 #define JBD2_POISON_FREE	0x5c

