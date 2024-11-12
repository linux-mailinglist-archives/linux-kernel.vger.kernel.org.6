Return-Path: <linux-kernel+bounces-406258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAEE9C5CB0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:02:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC177283C05
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88CF207203;
	Tue, 12 Nov 2024 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhQUZYXV"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96009206E9B;
	Tue, 12 Nov 2024 15:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731427120; cv=none; b=XYplMtBWuOEzseh9EG3iH+vXaihXAOX6BQ4IwMS9C5hWtyw+oIAFQ9LcBlHO2Tzu2bcsOzdZ9RY0GBhChUzB/28Ff8JbY6wuGtPBvCPJSv8hhEnyt26nwKxIWVe4q1JjNifgXshEf1SpEClnzf+RONWdSxlrsyGHKWnLZxMqdEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731427120; c=relaxed/simple;
	bh=O4AvFer74LkEoJ32uQUsWCZt7z9HiKEdzSP0dkJ7rZc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nnoPCu1OS/B+pi56IIhRp/DeGZiyqUp4A947FS/qMXYtCM3I9XrJUHOScWXcLsB1dNEoW3qGe3btjdEF5isCm4bOpNkf3C4n73t1WbDIaaKwuwAF3QeU/EdOhgaQnmk7FW2Uel8idvjBfN3MJwUiwq2g6mZ4E2vjUXvtpz4S7r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhQUZYXV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d4ba20075so3930943f8f.0;
        Tue, 12 Nov 2024 07:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731427117; x=1732031917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdY3Vsmu+IF4zfDZEiWUDqDaXm10hp+1m/IbDQWsUjk=;
        b=mhQUZYXVz6NXeOfHKXlobY2zySWtMvCgUQVKzf/obSf+d0ZMWEisp7YCl6Hbc+dlO4
         2tHPJ2sxxu9f3GR4wek5+ZgJbDTr1VX6FbJ6kdj89gFi0fDBlfCxesPfrIkAQacAwTKP
         P3C1TSfghcsLcK8gJDTRR1YH3sHhQ3FXzY+/21hotWiityb9c7Dl7BhPI7RdcmDkhLZ9
         iNIuqVyCbfGOf7se9JV8iiBwPHKL/sOTXfXgSDawdPfpT3FQ7w1VrlTQNZ5GEdp6G8Fj
         +fetrOe9Hvoh0P9JTmUqUxRTAfkKJJAKQZJvlTzNCpcAAWtnch87ICfXYQY+HbKdhPwg
         MvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731427117; x=1732031917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YdY3Vsmu+IF4zfDZEiWUDqDaXm10hp+1m/IbDQWsUjk=;
        b=f7YK4vRUfieO+IE5ePv7+xJLR7hSFfKDnJiY8deim8Ur37iJ6Gjor0rhX0JeKAx1QO
         b/diiRrk0FzlgYRCupg9m+RAzhmaReopotqtxbJ8QzJKorLXC3CCxguXTqqzKHHKpz4L
         BywLrtagtM02bT35U2ygBQI9+o0MUutuqb11Qi7+AzA+IJLixKVvAamu/zGq517Z5GNU
         Fwteup/iHPjEp86Kzx9vtMlnnh1nTGQaXkwfo1Q1MAtyd9HQ+T9sr2Li7y3/beNVjbrI
         Eyh8FrrUo4jH1F5YQGe4xQrfGWj3fU3wTum6Pd77wK/xsZRH9aVFyP4afEXpFelJFIZa
         eykg==
X-Forwarded-Encrypted: i=1; AJvYcCVKXFHwN2ZgfCYM31ZhW2IxiBmasHD2ey5KEKWvKnY5EDdKm+1krbgSt1g/+QvdPtW/G6j6gAy8mqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsJK2sl2JgMptkOCs79eNgOhd0IjcDHN0K6chfcdt7zr9pxzaM
	zFOa3wvnmKuPQGlrIeixb3/thKW/ECfwPW3RXd567YuTkcibEZf8
X-Google-Smtp-Source: AGHT+IEk5cRyDkDwbtRzoRMZemPPxSCgDgj1ja1/Qas1wY9h9mscgWXEcczgtTnkR7b7cd4xSSzqtw==
X-Received: by 2002:a05:6000:4009:b0:382:424:94ff with SMTP id ffacd0b85a97d-38204249572mr4094085f8f.18.1731427116898;
        Tue, 12 Nov 2024 07:58:36 -0800 (PST)
Received: from work.. (2.133.25.254.dynamic.telecom.kz. [2.133.25.254])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381edc1104asm15991136f8f.88.2024.11.12.07.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 07:58:36 -0800 (PST)
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
To: gregkh@linuxfoundation.org,
	andreyknvl@gmail.com,
	b-liu@ti.com,
	johan@kernel.org,
	oneukum@suse.com,
	stern@rowland.harvard.edu
Cc: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	snovitoll@gmail.com,
	usb-storage@lists.one-eyed-alien.net
Subject: [PATCH v2 4/8] drivers/usb/misc: refactor min with min_t
Date: Tue, 12 Nov 2024 20:58:13 +0500
Message-Id: <20241112155817.3512577-5-snovitoll@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112155817.3512577-1-snovitoll@gmail.com>
References: <2024111251-spill-hatchback-72da@gregkh>
 <20241112155817.3512577-1-snovitoll@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure type safety by using min_t() instead of min().

Also add the explicit `unsigned int` as scripts/checkpatch.pl warns about:

	WARNING: Prefer 'unsigned int' to bare use of 'unsigned'

Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
---
 drivers/usb/misc/usbtest.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/usbtest.c b/drivers/usb/misc/usbtest.c
index caf65f8294db..8d379ae835bc 100644
--- a/drivers/usb/misc/usbtest.c
+++ b/drivers/usb/misc/usbtest.c
@@ -2021,7 +2021,8 @@ static struct urb *iso_alloc_urb(
 
 	for (i = 0; i < packets; i++) {
 		/* here, only the last packet will be short */
-		urb->iso_frame_desc[i].length = min((unsigned) bytes, maxp);
+		urb->iso_frame_desc[i].length = min_t(unsigned int,
+							bytes, maxp);
 		bytes -= urb->iso_frame_desc[i].length;
 
 		urb->iso_frame_desc[i].offset = maxp * i;
-- 
2.34.1


