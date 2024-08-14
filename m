Return-Path: <linux-kernel+bounces-286574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB57E951CAB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 16:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50BDFB238E7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A021B32D5;
	Wed, 14 Aug 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DOIdSntf"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124581B32A2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644630; cv=none; b=NkLYTQWFL5KWlvdKXSXqYbNJB4GRlZfaATqhg69jqwahh3XbtQJgSVl+/UOnL+nMB4CX9HdRHhX7hj/GIqVohVNk8jAAsFeEjZyR/CMtEMonSRqdwxiBMp1kDoS6pTFCXUmVBp3F3zcQwtA26WWSTaHGw+hNKwb6xhDf+vGsYfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644630; c=relaxed/simple;
	bh=vp38zeRtBhr0Du4XKdqxpDAT1Y5lZXNhVALLlf72ji4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HVV0G1m8JtAuE1KPLq3vNkqHqjMKl7Bpa9C18Nk6ZNC0sPK9KvnYCfcQyW6udjuPfq/AMx2ST5U7hf/0MsJZzgvp4RaE5ltnyaQRqsZdjSbgSn0LiLoGtN3HCANE4dE0tNUIn+SZYIMpIYjE8SN7nJWetBzcpcVcI3UNeBoZ/Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DOIdSntf; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b7a0ef0dfcso36109526d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 07:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723644628; x=1724249428; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uYo+0dQT7iwe+mv2wovfeJr7dQUIMIBCbUbhTd+y5Bg=;
        b=DOIdSntfJuLhqBsdLRf4vsRRrqW4xHj2izzLjPEF8HzzD7EO2QqR4ubyKGn+iHpyLk
         7tR+eCMg8ePM6rFYekomMdTkCrLtw8Pm+GwXC0/+4m2QF6WuBdBn57NiFYPXCsFyS8ZN
         mH5jSvAQV8+0TMo9cqcl7liLSdaYAnRA6y2ZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723644628; x=1724249428;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uYo+0dQT7iwe+mv2wovfeJr7dQUIMIBCbUbhTd+y5Bg=;
        b=gWjIB5+Hm5yP+t2vbdXJJHN9HI9cjMzc7dUhkn9hOcDooRDErWjXw2iC4keklOyIip
         lNt/AlsuBNQIiQY973aV4PvjqY2bFkFvSMBMQTHpSkwOYov512gtOqor+f/q8c2DETOO
         sNrgi2jjE1LskZtEBSaN0Z3BidSK7ujdKFVVv1kPIgJFl2KWUzChRBNzAtQC4tAT/klT
         qfb2KQvIiQASnT3Wu/sqbGog9xA5WkUBAO40z+A+nKCIMAxuviQLkuYEuQ9XKV2AOpm9
         8gY2MYjRXOFImBGcW8ZivlyuP7LEOiLFjCFAHpQ0aPcR9ArMIov7/WRsRO2cNaROYhZf
         SyDw==
X-Forwarded-Encrypted: i=1; AJvYcCUN/p84iUQOLKSQgO/j0hpPpTnshDrp7ffXjoIrO2qXLfAfIWL6hYpsMF7keTeROFN0eCbhodvn6zBKilps0fuQnYa1dtGubrCV+9bs
X-Gm-Message-State: AOJu0Yz3sfpKMMOuaauEzlCqaiIO/T3oKHm2BYeTfejiJ8L0JaQBGybb
	Ea0OuwuljOOh+i/RILjOmA9J11aWDgakrJhlo21JhRjlZwgpCWoGUORqY8iYpHsqZc3M2ojB9Sr
	T6Rn9
X-Google-Smtp-Source: AGHT+IFlOhfv9e4YzS6CVLrhTnkiWmVIBOuyem99ZCg8FKMTyJjZu279PJkXqi5t3Ebj54cnLdjzHQ==
X-Received: by 2002:a05:6214:3a09:b0:6b0:9479:cdd7 with SMTP id 6a1803df08f44-6bf5d27e53emr29696446d6.54.1723644627395;
        Wed, 14 Aug 2024 07:10:27 -0700 (PDT)
Received: from denia.c.googlers.com (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82c61637sm43861036d6.7.2024.08.14.07.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 07:10:26 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 0/2] media: Follow-up for coccinelle lock fixes patchset
Date: Wed, 14 Aug 2024 14:10:21 +0000
Message-Id: <20240814-coccinelle-followup-v2-0-88b4e4a9af56@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM26vGYC/32NQQ6CMBBFr0JmbU07CgmuvAdhgWUKkxSGtIIa0
 rtbOYDL95L//g6RAlOEW7FDoI0jy5wBTwXYsZsHUtxnBtR41ZUxyoq1PJP3pJx4L691Ua7sKnz
 ounSoIS+XQI7fR7VpM48cnxI+x8lmfvZ/bzNKq95hT7VFd0F9t2OQidfpLGGANqX0BZCG/Lq5A
 AAA
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

Hans requested some changes for this patch:
https://patchwork.linuxtv.org/project/linux-media/patch/20240506-cocci-locks-v1-5-a67952fe5d19@chromium.org/

Refactor the patch and try again :).

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Changes in v2:
- Checkpatch fixes.
- Link to v1: https://lore.kernel.org/r/20240611-coccinelle-followup-v1-0-df2de9c2f320@chromium.org

---
Ricardo Ribalda (2):
      media: drivers/media/dvb-core: Split dvb_frontend_open()
      media: drivers/media/dvb-core: Refactor dvb_frontend_open locking

 drivers/media/dvb-core/dvb_frontend.c | 159 ++++++++++++++++++----------------
 1 file changed, 86 insertions(+), 73 deletions(-)
---
base-commit: 03a979b74dc1ad5aeed8026a84d8771842cb1631
change-id: 20240611-coccinelle-followup-f5a62b095f20

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


