Return-Path: <linux-kernel+bounces-189876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8DB8CF619
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 23:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE49281862
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 21:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA16139D01;
	Sun, 26 May 2024 21:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="XmjO/I9h"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD8A55C1A
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 21:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716758621; cv=none; b=CG8/h4MMcrmzIN7/SJqhq93rT/oWRCx6I0/Jo/WHXQezfsxcBw6tGNd9kXyxZwIQBzCT8kKjtGjOD07X+hXFec2G3Lp9j2e93Z385xsjGfv/V8XmsGdAI7IXLd4w57TXHYjqGwcnZTlae1P4u0ALVXeDiAPHz2Z04A9f4eHodao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716758621; c=relaxed/simple;
	bh=4br1+bsqarhpsUSUDMHnPY9ItAu5sQzF64WsQKB/4Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAkMWAoYnt6ZqBFWb7eU7kEP4J1JXbZLCzkBdidGqYafAiFelhckk3t2ZFCVtX08UiwbrzPTjBmxoAq6JDC71QAJXyeZIIa+KoHHZwZfRG8WycO6YwgbmRzX7vo6VolcflEx2bqsqafsIWyGERBls5w7GPLzb4dd0z1nYyfek1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=XmjO/I9h; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-354e22bc14bso3972009f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 14:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1716758618; x=1717363418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qbk0UNvpsQrSUqN6RzC4hENS9R3C9NfeLNOx5djjey0=;
        b=XmjO/I9haUhiyklbPuZ9WpTglsUZdxk9OmWkuSxY6sNAUOyzp/IR/oUhSthm6XcE3L
         wJmuerQQprftAOKfkl9baTQLYH6T36DkBMkmyNLzzcVNizzheJu/zoe/hqGeLvGM4xFJ
         +cFcNtMMWq1Kj2gQpoXAFFWhodzuiJHLp4gFEOJ35YagajD7/2Ky23oABy5shch5Hkm9
         RxcXrW93bZepY62gWQnbwK4z89bXIhXdoRgtHoM8OICVbw4qnEX+D06h9U6TwFC+OLbD
         fxE7V63w6kBqOWvtS1En49gwNijuIOJEWyzOK8Jbn4eDETFSKXIwNYRkjgPlpgSrCJNd
         ff7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716758618; x=1717363418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qbk0UNvpsQrSUqN6RzC4hENS9R3C9NfeLNOx5djjey0=;
        b=hnjfJBdarmYltGjj5YlfH88hlrJvA5/E9VpF/++NEtHjwVQOvfQaEp18bquMGILfXi
         pUakJpydjs5pwJfFTEzZ1A8vmUsk9u1QDy5yuMVK5no6WjkmMWWaNa7ZsXEVuZPqOq70
         gwqho6UHV8upF6ikIN8vGnRXZ+wPAJqNC2Ym79qNv4QSactS6voElLaHaC7qBuXsCpky
         Aw/J4FYnP/SSIQkZzd3Yo0CEKx/Yuu01Z6b8w7VZYKeTByFqTzyksSHq4XSRycwVd7VW
         CJxC25dHGu2EoPxW8+KGgBttVgA8vkvd3mTJvClqb3TYtyfLz9OYkwKZB7LFD4hP6rJC
         NffA==
X-Forwarded-Encrypted: i=1; AJvYcCWzI95qUvkwtzo6v/+75KWOU/FU77nv08pD49hPPochK6lub5eYna2oi4f6lSaakcasBV/PVnlO34Rl01pF6wM+LdB9MxWEaqNsVlLi
X-Gm-Message-State: AOJu0YwOIYUgbEJAp+o2Uy0eMC6WEB60dvDpOW85hu7myiCvUwPfT2Oe
	1tYN/LEYYzQdCboQkFZTc93GpM1YTTloK/jKsx5Da+VKKanQOTjmN+X2BhHacUc=
X-Google-Smtp-Source: AGHT+IFy5L/fF6HnmYmy15FzQ2I5Aj94AJhD6S8HOgJeCGnH2efGYlzLjxrfvdfR5wJ4GRUcUbR/8g==
X-Received: by 2002:a5d:4e01:0:b0:354:f1de:33eb with SMTP id ffacd0b85a97d-3552f4fd249mr5166115f8f.26.1716758618179;
        Sun, 26 May 2024 14:23:38 -0700 (PDT)
Received: from fedora.fritz.box (aftr-62-216-208-100.dynamic.mnet-online.de. [62.216.208.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7de1bsm7224197f8f.13.2024.05.26.14.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 May 2024 14:23:37 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: bhe@redhat.com
Cc: amir73il@gmail.com,
	clm@fb.com,
	dhowells@redhat.com,
	dsterba@suse.com,
	dyoung@redhat.com,
	jlayton@kernel.org,
	josef@toxicpanda.com,
	kexec@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	miklos@szeredi.hu,
	netfs@lists.linux.dev,
	thorsten.blum@toblux.com,
	vgoyal@redhat.com
Subject: [RESEND PATCH 4/4] crash: Remove duplicate included header
Date: Sun, 26 May 2024 23:23:10 +0200
Message-ID: <20240526212309.1586-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <ZjcvKd+n74MFCJtj@MiWiFi-R3L-srv>
References: <ZjcvKd+n74MFCJtj@MiWiFi-R3L-srv>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file linux/kexec.h

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/crash_reserve.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
index 5b2722a93a48..d3b4cd12bdd1 100644
--- a/kernel/crash_reserve.c
+++ b/kernel/crash_reserve.c
@@ -13,7 +13,6 @@
 #include <linux/memory.h>
 #include <linux/cpuhotplug.h>
 #include <linux/memblock.h>
-#include <linux/kexec.h>
 #include <linux/kmemleak.h>
 
 #include <asm/page.h>
-- 
2.45.1


