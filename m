Return-Path: <linux-kernel+bounces-409679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 420059C9000
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 068732816A0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 16:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C76218C014;
	Thu, 14 Nov 2024 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WI0/s8i+"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521918C018;
	Thu, 14 Nov 2024 16:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731602501; cv=none; b=S6vZ31q0W1kSYll+1RNDlvMEf8XgJp6l7zEkuU9Rr/X9VnbVBsz44f6JQ1wi9lpTfSzqMDZtOLyPNPWKRuFlo8UMD8ru+H8vF1AHpT3g/r06Jj4XhkZc8yyRRDV5psY4JwRKU6RqY4/jkjxZEbipuZh775HR8Uznr7eOqsvH6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731602501; c=relaxed/simple;
	bh=SCZ4T2AfHHXGBsZcQiCQq4xP+L73Rs0+AkjDB2k/9eE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Df4jAeM0zhQZ1u3/6R8660TRpdu4Zm2bnGXYg7XSBPgB4QCUasdBKIWgQ/+L0KL0OSuXFCDxJ+/1VZN3zS75t0c5bGXkuMGwOWuHjQ7cbjx5UUdokg/K6bvul78oDvZi6ZPl4IIde+fTn+lMZ6lt0lUDBk4tsSwKcD+5xmMa1NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WI0/s8i+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cbca51687so9486985ad.1;
        Thu, 14 Nov 2024 08:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731602499; x=1732207299; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YeaPvBcLvGGmvAXJtSbsLGjLypbsz77pojwpJkECM2A=;
        b=WI0/s8i+0EbHfGfH5fRwq7s4ByOFQY5wg8MT3S2iOXyH6jH7EYJiy9Ou2XSEGd1rjt
         iH6WjJ9olod7resV0Umuh1LUaxmAzRReFtnWrRhR70TE4NnW+94MnzL1HJTMa1jjK9TS
         z1BmC5tit9xI3KfZxgblcN+yv/VQj1jTl6Eh5L+//P7Odl1YCz6Uqao8YbnCBwmfVRDE
         vcXPXGbS004te44kjzoncylcoZjiLgpTNB7hxUeiID37rZK4UOcto+MbPhorxBK/heuC
         k8Fi29Zf60qR4M69nFs4IF8OHDId4tG2hRo6V5ATq/eTUNUAS0DOsNUq5BCixS81u55E
         ZJrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731602499; x=1732207299;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeaPvBcLvGGmvAXJtSbsLGjLypbsz77pojwpJkECM2A=;
        b=a+Q5VSto8yB7wdPBgtjb+f8nOM1CD6p9zexPxkPcsZVsKTu5O3W9jBVBhusZRRB83F
         pWgjaL3TlfjhjcNCxA/8sjL/RA89HFhoypIht0ZjOs+g9Cc3FsoEz9BPks+fJto1T5eX
         fOlRqGbbzVjw81Y+B0MViffn9r5S6sQAsmbeUBo2YnsjWoU6bUzR7a4ndzPoYWodT71h
         fpjZH+RHy5fiiXezguSLpL3Sne3M3HwdYcR5Nnbmqj91uTPrZVRODE7RmjfIy5QOYaKU
         xnDvqU5TeSC7z+mUecyJQKCoS0brV7mAbpIAzblngRw2vb2EX2kR+nZZETbNZfE755Fj
         kUmw==
X-Forwarded-Encrypted: i=1; AJvYcCUYGYzA/dUa/BhHz8lEAH9XXE+F+AJst94zexuafJ+phkw4/pqlu4oaDCWfrgimt46WPM08MYcBhiFK57UD@vger.kernel.org, AJvYcCWq/C/VmRrxXVQbYKk9dD7LbokUssic5zwUbWbigTL9KrWEWjPjojhvcRyfos0sEuhZu/T15XtJul8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMY0dIv0CezZmUFEhEUg04xuFsar9YoNtCvHqkAbKiRE80oJ4L
	97hZd9hne3rIjO7SFb/DQrRTNs1jKET50G0qeUdbhqYtY5OEKkVQ
X-Google-Smtp-Source: AGHT+IHJ1jE4dtrGk55++OXutHyktpDIdqvP/vOplWNrTQzNSe5mEzU5gmTQQqFKZz3bSVyIHRJL/g==
X-Received: by 2002:a17:902:dacf:b0:205:6a9b:7e3e with SMTP id d9443c01a7336-211c50c7e1fmr38508725ad.56.1731602498889;
        Thu, 14 Nov 2024 08:41:38 -0800 (PST)
Received: from [10.113.16.67] ([123.63.2.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7d24a00sm12844915ad.244.2024.11.14.08.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 08:41:38 -0800 (PST)
From: Hridesh MG <hridesh699@gmail.com>
Date: Thu, 14 Nov 2024 22:11:20 +0530
Subject: [PATCH 2/2] docs: sound: Add a new hd-audio fixup model
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241114-alc287-nitro5-v1-2-72e5bf2275c3@gmail.com>
References: <20241114-alc287-nitro5-v1-0-72e5bf2275c3@gmail.com>
In-Reply-To: <20241114-alc287-nitro5-v1-0-72e5bf2275c3@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Stefan Binding <sbinding@opensource.cirrus.com>, 
 Kailang Yang <kailang@realtek.com>, 
 Simon Trimmer <simont@opensource.cirrus.com>, 
 Joshua Grisham <josh@joshuagrisham.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Hridesh MG <hridesh699@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731602485; l=801;
 i=hridesh699@gmail.com; s=20241114; h=from:subject:message-id;
 bh=SCZ4T2AfHHXGBsZcQiCQq4xP+L73Rs0+AkjDB2k/9eE=;
 b=VkrW/BoJxCz2RgXsBcHi0H4NhwXo3jER3x9oXKKhylKYL30N9DysdKfCA0UfuI8CWlDAnIXvo
 SormJ/VlWF7DpojkfcNi1aMpFwpHpygDsx+8FylHasH+HNnrGmXBMoH
X-Developer-Key: i=hridesh699@gmail.com; a=ed25519;
 pk=otVQutD5ZTsEpajsGv/haM3pQj0yofkuYrdNcaX5AUE=

Update the HD-Audio model documentation to add a new ALC287 fixup which
enables microphone input.

Signed-off-by: Hridesh MG <hridesh699@gmail.com>
---
 Documentation/sound/hd-audio/models.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/sound/hd-audio/models.rst b/Documentation/sound/hd-audio/models.rst
index 1204304500147637407240907078f17029999614..d59d359c4638a19a371f965e116e87b66a72f5a9 100644
--- a/Documentation/sound/hd-audio/models.rst
+++ b/Documentation/sound/hd-audio/models.rst
@@ -265,6 +265,8 @@ alc298-samsung-headphone
     Samsung laptops with ALC298
 alc256-samsung-headphone
     Samsung laptops with ALC256
+alc287-fixup-acer-nitro-headset-mic
+    Headset mic fixup for Acer Nitro 5
 
 ALC66x/67x/892
 ==============

-- 
2.47.0


