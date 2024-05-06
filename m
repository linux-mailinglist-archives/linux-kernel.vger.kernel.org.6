Return-Path: <linux-kernel+bounces-170425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BAD8BD6AB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 23:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 620431C20BC9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 21:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8BD15DBB7;
	Mon,  6 May 2024 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AD8v238k"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4442315B966
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 21:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715029834; cv=none; b=WkDEYhLW4jK6vkop6jZGTkzy0SHNpqsYnqDmgGVofu9rsAznKxSU99fze+pgyXpQGqv/CM2QK3OSPkCuAUuPZfTlWlZIko00RGaUyIjZ+r/X9QJ4HdX7JRO7wfFslAn4pR6rKxaTNDhtfwMvLmmgdkFbmcwOiYZK1AQSqD842WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715029834; c=relaxed/simple;
	bh=rmMHfZ07Kd9lTZW6PwC3rqA96g9FbrjW5lK3extywms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dJnTnMjCMHHV4tuqxfyl6Hb+KqQLoz8bYeSy8HO2fFOre81bN1z1CinKdNIHSr9kXaWtx3/i7MUslu7Xf5o5XRmB8GETvKAwb9obfoFM9kkqxaoVYXDRy5yeSqaGTl+W4I9rwt9z8a/YwKyng4shTU7A7JKCntfP+ntzCBv8nXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AD8v238k; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-792639cf4faso260818785a.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 14:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715029830; x=1715634630; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GChtxSEHiZ0rsnEnXBszudDorgEfMXDvam+C+CQ8ysU=;
        b=AD8v238kG/nRmGskPklFvxXewBA+3TI+A2uSOWBNUYHNym1YT14DlD/dUc0YpjsH+d
         ZiyY+x2FX2Zx6tatsr7ebbwclChoXX6QC6WQb0fUSQQzuT9aToTXu4jrT1bPQ2qUnN2n
         Y6vGYnqE+O706qslQb5NRtbF4W3TtkKtiTsls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715029830; x=1715634630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GChtxSEHiZ0rsnEnXBszudDorgEfMXDvam+C+CQ8ysU=;
        b=rqCAiqjHv5US0Blnj0fdqff2u7hVYXN1yUY3/RnVRU9Bs6SgUwVhN6EsZL89DDb7Ug
         yPm3FHJrrpGXmkuV7FAnYX+CiDHfw0i8RurmbY7oPw1SUu9sois/o4JhGwvii9bDQyBc
         sEf70z4ysNQZSoVPSmv2Xu/Oge9r/p/eCSeX9Vi1L5BTf9Y/7vxkCk/yrVMRxvix1IS7
         XkMvNYkxXYRPyvu/0tUWtumoagcdaXs5vi1cMYndxJrJK0B/TsAifEuePc8yVUYs7vbu
         Pmck1KbCQ9WrwL39q/XJnD/03bRrIw4bB56monozX3dycKbBZbES9z/+pvNexhMzTYaK
         Ih5A==
X-Forwarded-Encrypted: i=1; AJvYcCXbDnQTWONNMNhSN9qt25loT/DL98OJ58qH2e31t0WpuQiyRTANAq6+pJvlCOyMLsY2MXUejA22bsh+uUBb95VbVtTz1kA9Nz0Re1KR
X-Gm-Message-State: AOJu0Yy4UXizJHMYBHCbmedN+DKnuP3LdEwEt7BQPMNMWuKyp4ivITmQ
	YDp9IG1Wsz0neD8x/AP2KmmjTaj7HBKfszVX5/1ONqFkjNouHp3TNF0T97zCVA==
X-Google-Smtp-Source: AGHT+IHCIfstPtI+qCxYBl/8IeI1JeUuGRWhMdpvvDoh1G+j87TAujBrzH7bpSdDG6tDvHp9Uo2iFg==
X-Received: by 2002:a05:620a:89e:b0:792:93ed:2e7c with SMTP id b30-20020a05620a089e00b0079293ed2e7cmr4684450qka.76.1715029830157;
        Mon, 06 May 2024 14:10:30 -0700 (PDT)
Received: from denia.c.googlers.com (114.152.245.35.bc.googleusercontent.com. [35.245.152.114])
        by smtp.gmail.com with ESMTPSA id pa20-20020a05620a831400b0078f13e59dc9sm4224921qkn.102.2024.05.06.14.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 14:10:29 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 06 May 2024 21:10:27 +0000
Subject: [PATCH 2/5] media: imon: Fix race getting ictx->lock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-cocci-locks-v1-2-a67952fe5d19@chromium.org>
References: <20240506-cocci-locks-v1-0-a67952fe5d19@chromium.org>
In-Reply-To: <20240506-cocci-locks-v1-0-a67952fe5d19@chromium.org>
To: Andy Walls <awalls@md.metrocast.net>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Sean Young <sean@mess.org>, 
 Jarod Wilson <jarod@redhat.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

Lets fix a race between mutex_is_lock() and mutex_lock().

<-mutex is not locked
if (!mutex_is_locked(&ictx->lock)) {
	unlock = true; <- mutex is locked externaly
	mutex_lock(&ictx->lock);
}

Let's use mutex_trylock() that does mutex_is_lock() and mutex_lock()
atomically.

Fix the following cocci warning:
drivers/media/rc/imon.c:1167:1-7: preceding lock on line 1153

Fixes: 23ef710e1a6c ("[media] imon: add conditional locking in change_protocol")
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/media/rc/imon.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/media/rc/imon.c b/drivers/media/rc/imon.c
index 0b55314a8082..8f1361bcce3a 100644
--- a/drivers/media/rc/imon.c
+++ b/drivers/media/rc/imon.c
@@ -1148,10 +1148,7 @@ static int imon_ir_change_protocol(struct rc_dev *rc, u64 *rc_proto)
 
 	memcpy(ictx->usb_tx_buf, &ir_proto_packet, sizeof(ir_proto_packet));
 
-	if (!mutex_is_locked(&ictx->lock)) {
-		unlock = true;
-		mutex_lock(&ictx->lock);
-	}
+	unlock = mutex_trylock(&ictx->lock);
 
 	retval = send_packet(ictx);
 	if (retval)

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


