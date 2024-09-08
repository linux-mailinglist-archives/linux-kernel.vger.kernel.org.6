Return-Path: <linux-kernel+bounces-320123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B62970661
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 12:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84D531F21AC1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 10:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0AB14C591;
	Sun,  8 Sep 2024 10:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkjwJgnd"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC00614E2F1
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 10:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725790288; cv=none; b=SexptgBB+sY+v5LX+/4B9K3VKzJcoQVLNZHHiR8suifYttBZb0MRjyqQADJ3ep+QPt+CmsnO8u2SubyF+E3X4MK1CSlbwyR9Pffj4YohL5extVoxtiXyiHutqJsbin2jwYT+FLC+PwlmbPhRrIF1QmlbL4xyfV5oavhiCUPaMkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725790288; c=relaxed/simple;
	bh=ZfsGGGDbjW9NU9Xyaf6CER8qH5KsnUL66JuoMyHNjZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HGXE3NbtouScK2Qd0Y14lE0AVVgpKQ+DXoUixkPfzoK/vC9m+a4NB3lkWmjvW+P7mV+1IZP+gl5W2nQRlk6as0je4fXNU8UOj6OJtaFOet9mdXKgrbA7wfyGaSfEYPo4wCnCxNdTWXdLaMqNQUALQDD69cfVduZJYuif8kpWyCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkjwJgnd; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-710da656c0bso591501a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2024 03:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725790285; x=1726395085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gl8Z+gv7OuYv4fDWlpGtlGw52NOtDXPmfGSv0nC3Rco=;
        b=KkjwJgndCbbb+UMFBeVS22570EoPQJNWEJVCxAolWR4TySIG67SSYh3cUb+Gp8NbKO
         uEFeWHb9VKVVEVOoGPlp3uFKT/cYbLuYnEcUKyqhSrDNPs3sCtdXyMxXp97VgIXO/PEy
         AUp2d6/Wsb8pqvZwQLl7Jc5omf85LBp965tmbby6abxW9qF3twlyIJhTmkXjngKR+QCL
         jyt9NLhkNJY3pN1uhPyHqKXCXvKHnMRlcAw5iqClPg1TRFeuUYdSurErJ1UfnuGW0ukh
         E62N3A7X7CUg7eUP+vLi+9AfTBQ36zOuGwJAmuhkcjx7/4AOMufz1vypwlCUab+ptQhB
         VDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725790285; x=1726395085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gl8Z+gv7OuYv4fDWlpGtlGw52NOtDXPmfGSv0nC3Rco=;
        b=i5KEow0tTKFnFVwuSsFsPeihcQlaoBZ4GYVcOBkeMSciL4OXe4VOz8Ct/gG9daIbga
         O+ODPZnP71fyekDxZ0/ihKVk/LdODhB+bbl927tg6jRjj4JEmEqcqfpoEVxuMaVzE7Sz
         BbAIfISqwZ09L2AmQj3U3UQfmxkQ0RwkG5EhBjJRhyntC1twphGwCTcUN0R6CRxaeBIW
         LkBEqWq/hABDIG/ZPi8Ka4W1cIwkJyBkwhI+DV9aZj5DKD4rGjcmrB+llRLzW/wNHEeV
         RvPAKrQLp9OwazpIXpi8QLjeI/7afextSaHp9JfdZt/NfmNWgXR7ZiLnZOBtc08H/lnx
         DmIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWN/L9LzYDJWqIJTMZORyT1MMWFqn3gXDKq2UnjUh+DO013FVqyuV6is9uEiHWi+9QdzcLVoUpIsD+YxA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7codnoGINsY1Vu9A76sLjXhtUdSjlQoPWH1pTPL60yAXlwyDO
	x01WvjMeGg7vOLLihLyp94zwKexc+XiGUVQEKJ9Tgjs9DOiSFJ7L
X-Google-Smtp-Source: AGHT+IGDRXfL5Rxje2ZS0pH0f6MX1/MypbBV2EBxSOIxd8qQfmbHsxHX1GPpjXyGTXEa9xaXWaDl5Q==
X-Received: by 2002:a05:6830:6e8f:b0:709:3a05:36c9 with SMTP id 46e09a7af769-710d5d06391mr5984332a34.29.1725790285658;
        Sun, 08 Sep 2024 03:11:25 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([103.57.172.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0782dfsm4589379a91.34.2024.09.08.03.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 03:11:25 -0700 (PDT)
From: Sayyad Abid <sayyad.abid16@gmail.com>
To: linux-staging@lists.linux.dev
Cc: philipp.g.hortmann@gmail.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	sayyad.abid16@gmail.com
Subject: [PATCH 2/6] staging: rtl8723bs: fix position of opening braces
Date: Sun,  8 Sep 2024 15:41:06 +0530
Message-Id: <20240908101110.1028931-3-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240908101110.1028931-1-sayyad.abid16@gmail.com>
References: <20240908101110.1028931-1-sayyad.abid16@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the coding style issue of opening bracket "{" being on
the next line.

Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>

---
 drivers/staging/rtl8723bs/include/rtw_security.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers/staging/rtl8723bs/include/rtw_security.h
index 487d69460cec..3ccbccf92417 100644
--- a/drivers/staging/rtl8723bs/include/rtw_security.h
+++ b/drivers/staging/rtl8723bs/include/rtw_security.h
@@ -170,8 +170,7 @@ struct security_priv {
 
 #define GET_ENCRY_ALGO(psecuritypriv, psta, encry_algo, bmcst)\
 do {\
-	switch (psecuritypriv->dot11AuthAlgrthm)\
-	{\
+	switch (psecuritypriv->dot11AuthAlgrthm) {\
 		case dot11AuthAlgrthm_Open:\
 		case dot11AuthAlgrthm_Shared:\
 		case dot11AuthAlgrthm_Auto:\
@@ -191,8 +190,7 @@ do {\
 
 #define SET_ICE_IV_LEN(iv_len, icv_len, encrypt)\
 do {\
-	switch (encrypt)\
-	{\
+	switch (encrypt) {\
 		case _WEP40_:\
 		case _WEP104_:\
 			iv_len = 4;\
-- 
2.39.2


