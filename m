Return-Path: <linux-kernel+bounces-181421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 426508C7BAE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2BAD284AD7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C971156F48;
	Thu, 16 May 2024 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ue3VJ34d"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0FC1553BD;
	Thu, 16 May 2024 17:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881949; cv=none; b=Akk6CHMPCkmRSVt0TIWSMB4WLNll9t7Ha4jTYvCxWh2blxVgDd0xUG7M6L2VzGo3A7oROxDzODr75GmYCZyrgv9725DwR4xvG48LrQlwTf/5b+RBfU1k9ZRaFu02JS3cgG3aD+xeOHZF4BUeI3z3kZeaANO6caaet295HgmEoh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881949; c=relaxed/simple;
	bh=zOc0bq0Q8lD7wXxEGGsJlN5D1ud+1kdpAHTSlJsG4v8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KuFuou37Q8JqDCFK7apKKlAgRM32tBu0A71y0ThQDF1nJWtfr63E2k8ysiAuFqy2NaBxh5r1VRQVbE8eBmV/S0EmbfY3JbU8NaBoSTs+oJ2E1YuTNHjC6Bg3TT309pH7w60z2bT69qkqaSD3ArOcK6mSmF8wEqhkN4W59yTZCCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ue3VJ34d; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f4521ad6c0so448010b3a.0;
        Thu, 16 May 2024 10:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881948; x=1716486748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gDmhWEiMJ5CnV3oGozg5alnQWKxPvnqmiaAt5RGDDRk=;
        b=Ue3VJ34dkWiOpQ0VLAW82PPmPtIL29V6O8JIuj4g6LTJHIpQ2ir0EhPJ8LddQ8vswr
         CWKuQDVsJL00t1PLpwKASyKdDZTDQHcWfMeRtCDWGZ8MHyog7VhMPi/RLJw9F1Yy2SlB
         LAVDNciL607H4dk/v8nrj7o3pHsQRiV7s2IKKbPMvfdRN+3B6rHHMp7u4aAXQm+j8UqW
         7yBA2CU8f6fAgZH0t1OFsgoMiuzUKhfmXv7d7P9lgETJariq78BD3TPiYxaw65tNkRfJ
         ZFiS9uDACrUps1UAyhxkT3WPPnPhr90tVWS/FmSEfiRmVzqwj2WNN9ggSdT4IapWw4GE
         jsww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881948; x=1716486748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gDmhWEiMJ5CnV3oGozg5alnQWKxPvnqmiaAt5RGDDRk=;
        b=WfJ2/qAj3sL25uZ84jDDhlRQTdCt4ynjiLpdDP7Tf7KUqy58+bpDip31UmqsL/zdKh
         3KNW+yODWkxoXyoNNh9XH9XaR0PvXBGsV+UctaGz7+JoTF/RsXs5coeFiyD0sw4/4t6P
         a2PJUVTO/v46IBxEW+uZcPP+X+yHSftGgrz3GESpOYdExofuteus9uazq8jkiJkiyQfk
         D9q5WdXUbFzZ186WkQhpO3t7bdeTJ14ymdoYKRx0RTsvYgsVjvaEeU6QkpokhQqC6fv/
         jg7jwgKoHAOozfH+ytdMjUU/R8B0Gd+B/OAt2lM0IpGXR1Zl8nGpKl0ilhMsol6Ypk4q
         JoKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmelqf6t7NKeBd/qwk2m+j+FjMzlj+Ztj+njQ6CsORQPIjW0O8gFwTwAGL5fMaNNiF7oreNm7Dmo117rdGOH5iruV1w7rgZgamu8RPPD78i99riMXiOvdxXVonPdO+MPwX2WGD6XJOrJE=
X-Gm-Message-State: AOJu0YxJ+LaaFCqrMRwp77KxDRCOHIHzUO/Nk7NO8/R9OcPqwUqDdRXH
	ZlcBUH1nIdi4Rd3fGREC2zTfyjKek/pN7L7MCBiuH3MvYC68VAO2+Uh0Up5ZpIs=
X-Google-Smtp-Source: AGHT+IEqqTKsoVZ8amcaBaR5SBa3obXoMNGF0fq41SqYvXalybmo7t+x8s8FV0XSDLDU1WYqXds51Q==
X-Received: by 2002:a05:6a00:1ad0:b0:6e6:9f47:c18c with SMTP id d2e1a72fcca58-6f4e03858b3mr23691543b3a.33.1715881947854;
        Thu, 16 May 2024 10:52:27 -0700 (PDT)
Received: from paran-QEMU-Virtual-Machine.. ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4f2cdedb7sm9727615b3a.52.2024.05.16.10.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:52:27 -0700 (PDT)
From: yskelg@gmail.com
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Austin Kim <austindh.kim@gmail.com>,
	shjy180909@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yunseong Kim <yskelg@gmail.com>
Subject: [PATCH] line6: add midibuf init failure handling in line6_init_midi()
Date: Fri, 17 May 2024 02:47:38 +0900
Message-Id: <20240516174737.415912-1-yskelg@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yunseong Kim <yskelg@gmail.com>

This patch fixes potential memory allocation failures in the
line6_midibuf_init(). If either midibuf_in, midibuf_out allocation
line6_midibuf_init call failed, the allocated memory for line6midi
might have been leaked.

This patch introduces an error handling label and uses goto to jump there
in case of allocation failures. A kfree call is added to release any
partially allocated memory before returning the error code.

Signed-off-by: Yunseong Kim <yskelg@gmail.com>
---
 sound/usb/line6/midi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/usb/line6/midi.c b/sound/usb/line6/midi.c
index 0838632c788e..abcf58f46673 100644
--- a/sound/usb/line6/midi.c
+++ b/sound/usb/line6/midi.c
@@ -283,13 +283,18 @@ int line6_init_midi(struct usb_line6 *line6)
 
 	err = line6_midibuf_init(&line6midi->midibuf_in, MIDI_BUFFER_SIZE, 0);
 	if (err < 0)
-		return err;
+		goto error;
 
 	err = line6_midibuf_init(&line6midi->midibuf_out, MIDI_BUFFER_SIZE, 1);
 	if (err < 0)
-		return err;
+		goto error;
 
 	line6->line6midi = line6midi;
 	return 0;
+
+error:
+	kfree(line6midi);
+	return err;
+
 }
 EXPORT_SYMBOL_GPL(line6_init_midi);
-- 
2.34.1


