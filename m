Return-Path: <linux-kernel+bounces-400000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379779C079D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 14:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B944B22EED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 13:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42025212630;
	Thu,  7 Nov 2024 13:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbFeDhyy"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011FA20FAA2;
	Thu,  7 Nov 2024 13:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986432; cv=none; b=tRZ+VsNO1keSw/I9jf4kaep5VsQxc4LE82mqfytk+RqOAiV/vRKNrVFBn95G5YOWHOoUhTA67EZNDpj5jfYJXwGdPGxZeEiVYIWazM+hUkpWHyFJPJWA0sbYPl/ac++No5pRbCVf03tLUC/CStNjWscg0sjFoK/DRhO5kLzrAuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986432; c=relaxed/simple;
	bh=E7vFx2yAcvc0WEyR9y8ZqTHmHaI00ioYVv4hf4bGIL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hNOesFBTviIG5I4FmZdjKfSdG/+Wen5mwI6STG2MhYWVCLKvCjeZLt/AVo0XlLpnizTlRrRcmdI9XVZcmI79UmiwI8LmsihIn/YpfU4YJeUWkBg7MsZzly0/cyAgkBAzKKGNPMWtqLlpW4jGTfGtSn44vFHiYaXB2X1G1QzmLK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbFeDhyy; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-53c779ef19cso1070843e87.3;
        Thu, 07 Nov 2024 05:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730986429; x=1731591229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ViY7sQ8AlwXM7+l1dCADz+1VsbIy8KN1FHcb7CbbhB4=;
        b=FbFeDhyyKLx/h94iPobS79I9Uhw/j4NEiaez0AaXOQc2IE/bg6UR7NcbxhNj0CKOqo
         E2YxkCx3Ze1dW9L0qxk7xfnBIn2LGogztPlyodrHUa5sP1fJnrPMZKjV6XuXkLH0UUqw
         2dr4ndk+16rB51TjJwduKlP3dIWujU3F3jadj+r8MV/eqJqLL5TidR8FM6lH4kRjVDMO
         hmsirSGVRi/FS/AmySPJLekGdZ62S+JGFiX/k/iLfznO87osWHUu8WlV8rh4f8sVPIny
         xtrgHReYjQsQLr1+SVyh76hSTRbm7aOtBoT8FvvRsb6ka7dlL4pf7b3e5Tkst00iIR3Q
         s3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730986429; x=1731591229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViY7sQ8AlwXM7+l1dCADz+1VsbIy8KN1FHcb7CbbhB4=;
        b=v1Qfaa1cJdiFOV0o1SBDgtODrq+fZs8kZgey1jjf7AudSEcQ91pIG2lKIeSPtoY40T
         3QHSfIY9dRIL/uSYVRSRX6p7GXgUkZtxEh7eBA6pDwoG0hG1nnsZUQ9UT0uGCC7WFq0D
         E+ap/8o0xUSgc+M7QC+Jvpf+9NClFXMMENpf7tnhdrbl/F+oOl6PM2siqL13Fhmda5od
         qL/4GrXqSg1pkcNVjqH1wE/bNXOONY7zTZbjoTpbiRbcEXX0cOcohmGp8CH87s+GfYr2
         VV+b+uz6wM49NA9xiKc0s54I8AWB2LPF4qki3+1Km3un0rkeTZl6vA8WnXprUK5NG6CY
         Aicw==
X-Forwarded-Encrypted: i=1; AJvYcCUknp0NQRPJPU83jjcDVPd/MSnFUD7ZJXzGXAp2/3ie2mUc9tHmyEN76TbbceA5g4vl6GO59/XkFSUE@vger.kernel.org, AJvYcCXuSrSi5Z0zDEklgjjEh5UDGtQuzt1857FNm4u3+6eWGls1KBY/50dCNcAdBzrdtUdHo1oMSqj27ofjjvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjHNpE83y1uV+5dBOGwJC10U5ZrDi081B7pYqNeSChwThDd6mz
	nft6fUJVL84JOFg9nsWBUc5Gc4NLM1tNP6w13aEnSgTtm3pBKgGBRndzAy5/7Dw=
X-Google-Smtp-Source: AGHT+IGi8aMkz8VklETj3YLnYjbsXQ19G2kmHejVsQwIGAn154UBvsSV0dD/g/6Mhpzmod6RADHaYA==
X-Received: by 2002:a05:6512:1321:b0:539:e7f8:7bf1 with SMTP id 2adb3069b0e04-53d858f36b8mr13326e87.2.1730986428811;
        Thu, 07 Nov 2024 05:33:48 -0800 (PST)
Received: from localhost ([194.120.133.65])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa709ec7sm62729315e9.35.2024.11.07.05.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 05:33:48 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Takashi Iwai <tiwai@suse.de>,
	linux-usb@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] usb: gadget: function: remove redundant else statement
Date: Thu,  7 Nov 2024 13:33:48 +0000
Message-Id: <20241107133348.22762-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

After an initial range change on the insigned int alt being > 1
the only possible values for alt are 0 or 1. Therefore the else
statement for values other than 0 or 1 is redundant and can be
removed. Replace the else if (all == 1) check with just an else.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/usb/gadget/function/f_midi2.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/function/f_midi2.c b/drivers/usb/gadget/function/f_midi2.c
index 8285df9ed6fd..5f3f6e7700c7 100644
--- a/drivers/usb/gadget/function/f_midi2.c
+++ b/drivers/usb/gadget/function/f_midi2.c
@@ -1282,16 +1282,14 @@ static int f_midi2_set_alt(struct usb_function *fn, unsigned int intf,
 
 	if (intf != midi2->midi_if || alt > 1)
 		return 0;
 
 	if (alt == 0)
 		op_mode = MIDI_OP_MODE_MIDI1;
-	else if (alt == 1)
+	else
 		op_mode = MIDI_OP_MODE_MIDI2;
-	else
-		op_mode = MIDI_OP_MODE_UNSET;
 
 	if (midi2->operation_mode == op_mode)
 		return 0;
 
 	midi2->operation_mode = op_mode;
 
-- 
2.39.5


