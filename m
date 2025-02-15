Return-Path: <linux-kernel+bounces-516320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 405B7A36F9B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 18:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08E6E16C937
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 17:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81511E5B98;
	Sat, 15 Feb 2025 17:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7gKlt5s"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1A91624EF;
	Sat, 15 Feb 2025 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739638856; cv=none; b=H2PM0FMD95AnApnFPwAuBLCA7dWUZdqJjjmyadyS/Y0nmmj4FWpCmNBvmvxeSvxzfi7CY6MJHO7k11qabJ43SVXXkUi/ymyYIsSstdVZZ82MEECrj3qYbrmy0Tn0tagweainaHoNXBUgzoPctGoxwr1y5Jhj+5sWOQ1E/QqmkvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739638856; c=relaxed/simple;
	bh=uy5cH16JsX4JeqEfRAx/FFIcMBDLoTmq8s1tlKdmEhc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=t0ayUAu0psa3iJWVD/1iJ+Mj0v95pqXVfHrYB+65rjfw02uqviLsCN2laYpnx2PcJ0gfM2m73N1zgZOUz/Vkbq/Lfj43wNIAwFd08leKFZPbqtdOwt0AJmG0QlhMSC7AYs9hq2WnftrLedUlb8H0HkQJ/bVFQknIh3ecGznVVa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7gKlt5s; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-72703b0fe2fso1451178a34.1;
        Sat, 15 Feb 2025 09:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739638854; x=1740243654; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fFgotg9MMog9YPyVCTVdN/A41r7u9eJzo/q5sMJJgW8=;
        b=h7gKlt5sc06Ta2tb/Zt2ai0BdAWauALgj5w5VsPvGg4rPWE8F3hvI7jEaQzXcA4iBb
         1qQKuXb/YKN2LoHL5yJYB0kef/sC857VkUcQaHWElN9u9Ke6aCI/iZzQeHAiOQY7O7Nk
         JVP31NuLrqWNDaSS+2hQdshd2OfLL9M8iCQaBNDg39o0n5+tvpfJlJESpaGTc5ROqhtU
         tCgjlvhWn32Rc2EaZTXqtww4eAGct6MAFR9ZPLssScsQI38q804MgpSC1nHFZ+LgIFzy
         C7oDj7jMcG2eR6HTlH4OJw3gaRRpALs1rU/SPAkZEFiQt/0UQFOQOzWE5gHTcBmwMpLN
         wJsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739638854; x=1740243654;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFgotg9MMog9YPyVCTVdN/A41r7u9eJzo/q5sMJJgW8=;
        b=R2XJVctyAacPMeKQnoO2GlBUcY99yuBseA36/DX0dyonBq/3z1S3Vt7M2/WkmsT/5M
         3oCmOnjU2DKZoXvbwnFiPpSgX5HLFS/WcKR5DHqjbectlz65/9fU+WIVxAciS8Dy2x6V
         OihEhWlMP2t6yR+JJooO2wohASh2Ki2dMwpYOEu4r/qBNAVSIj0pGZCa5hnJp5U79Tt/
         biGLW/ZNW4f7qeJRFwmi/+0aYlzEOzA3KUui8LHaE6q648hxdBpzMBHcPLGeZagdEbEo
         f/cBIXrxD3QlNOfxZuQ5219LQ2BkGCmuIYQCePDfW3zPUibONrUYUdLU3YlCplkOi2a1
         aP8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxn/W8hHuJmM5FtzoltdhUhI/f3Eo3lqANJwzoqxnegGM/9mo5+ltFf0Ya4nMAlFV8Pc/BRoJFZEs=@vger.kernel.org, AJvYcCWP/DPMs7K1FtStaRncCQ51leSvBUAGa6/rjZkbkD4b631eyu/p77IJSCEiTbs/7Xl9fVztOEy+DdHZrZyM@vger.kernel.org
X-Gm-Message-State: AOJu0YyuwZo13O8cQFCrPHYif70eLh2rtueVkjvQjh5gMIBnEra+muhb
	dt84pgqmvKVoxhbvF0uURm/cfvsRFMo2S4cFT+SJge63Gk111dQD+7EAD+x/rFuCQlQ8iB9wWT4
	ufjA68HhC6vdjaohd6yZPSxe0RJM=
X-Gm-Gg: ASbGncu9AGnTPPVnn+wiuUAEHjfL4ZGqkE+t6Xis8Rf+lQViYoy1xcIylcj716QQY8d
	oLATaKMDWB/qPpSqnUa6TUDQWiZoId0lYpBDnY6+eFmgXALrvhynZ48dn98dQCnx2QWyYEqY=
X-Google-Smtp-Source: AGHT+IFCE/ujiPdHP+4NuCAT8iQjlOyrijo3LcUM+5WICOd0f0Wy1TP+CpF11sc0YvuV5vk3xilB1nbZdK6s7ywGhF8=
X-Received: by 2002:a05:6808:1447:b0:3f3:bd43:8870 with SMTP id
 5614622812f47-3f3eb127cb3mr2685351b6e.28.1739638853708; Sat, 15 Feb 2025
 09:00:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Sat, 15 Feb 2025 22:30:42 +0530
X-Gm-Features: AWEUYZnjUakxvfVroE4-xJQ6oTeQ2JVIPhF7OnNS0SB8lYYBB3LZ2DiPulj_kzw
Message-ID: <CAO9wTFhe4sf1eVVgijt2cdLPPsUHBj7B=HN-380_JSpve5KbvQ@mail.gmail.com>
Subject: [PATCH] Documentation/mm: Fix spelling mistake
To: akpm@linux-foundation.org, skhan@linuxfoundation.org
Cc: Suchit K <suchitkarunakaran@gmail.com>, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

The word watermark was misspelled as "watemark" in the balance.rst
file. This commit corrects the spelling error.
Signed-off-by: Suchit <suchitkarunakaran@gmail.com>
---
 Documentation/mm/balance.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/balance.rst b/Documentation/mm/balance.rst
index abaa78561..c4962c89a 100644
--- a/Documentation/mm/balance.rst
+++ b/Documentation/mm/balance.rst
@@ -81,7 +81,7 @@ Page stealing from process memory and shm is done if
stealing the page would
 alleviate memory pressure on any zone in the page's node that has fallen below
 its watermark.

-watemark[WMARK_MIN/WMARK_LOW/WMARK_HIGH]/low_on_memory/zone_wake_kswapd: These
+watermark[WMARK_MIN/WMARK_LOW/WMARK_HIGH]/low_on_memory/zone_wake_kswapd: These
 are per-zone fields, used to determine when a zone needs to be balanced. When
 the number of pages falls below watermark[WMARK_MIN], the hysteric field
 low_on_memory gets set. This stays set till the number of free pages becomes
-- 
2.48.1

