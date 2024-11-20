Return-Path: <linux-kernel+bounces-416047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 507E89D3FE6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 17:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D9C8B3A63D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0090B1AB537;
	Wed, 20 Nov 2024 15:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBfsEzMw"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BB514AD3D;
	Wed, 20 Nov 2024 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732118163; cv=none; b=Mt96DHERUJXmTxlWd53xs7kqUq3w3zInccOg/iQamOdfhTLRRb/XKsT7pWsGTN4pTf5FyvaZ6AL7l7/jRtuwZ2E89OwK+Hn0LJoHUkBjLCuqP2lvrrf0d9K2qRofnh5m++sTW2ZOfo1G2bTHL+Thq1+Q0gg2Bf8m7iTqorrMMmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732118163; c=relaxed/simple;
	bh=Ou//29Ar9qWIEg2uWs4icTwUqoiHtGhD2hyQZSTq5Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PY/MjSHPgiETA/Fk7ndOr4SGAGITjxbTikWkIWvwQqZLK3ox5uBAIpnTUekEef6DGwQOtzIOobMVWPqeJbTwbAIZsESNXSpz9ByEvgLka4yS21v26vwry5dwRFIERWjgU+ijwM+7sIVtJCUpDjrF9SIlb4PXob60wK/0NBSLgKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBfsEzMw; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7181eb9ad46so1265636a34.1;
        Wed, 20 Nov 2024 07:56:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732118161; x=1732722961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xUjcMIPq9FUNVmO7WhCAuDNGDpLobM76UY/aeCnpGLE=;
        b=SBfsEzMwDGdQp8C5HjQIa0wd/9MVOTKt5Tb7QvGYXoSFFl5DfQ3UE0R19VA71Kb3lH
         AV0yx+f42mX9Sj20xuojWs22bDzpLkncCHetzZ5eP27dWWAtWpFbZyUsjRs02yaLwpvK
         QFYyQyuYVQawavjfqEv1XeijXwEhkbC+yaL/Tm1+0VznV6JsPA0Pwq3CS98SqmdSNiPm
         WKaapuVtw6HanqwNveVAZYE7Zb/k/RiXsAvPNsvGzewfZpMxr58DqQuOPT11LNonSHqO
         qv1uxKOvB+8p2T8/NDsXdzq1cROFsQ9KxIcFPu3XAcTUXbtZ+2O4la4RoCfGu0NneOpb
         LyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732118161; x=1732722961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUjcMIPq9FUNVmO7WhCAuDNGDpLobM76UY/aeCnpGLE=;
        b=cTslLx5rB1TG/+X/o1xUZp33ShXni0GuFrD/R8xv0O6BofX+QpvDOrTdpgOPNvAndf
         2UukcGAWj4WbEyX33ttsHZmZidHmhkFZvgc7c3qQBX6vaMTk+H3HtYUBE7HOA15zO6u6
         K4dQFwSZhixsyGcuyZE2DA/S3w7JmI1lwyeUCNCYN3HRoV/xglPsOyG63VB8M8RZud4l
         mkwSKWyMsQo2FA6y5phY7x7uIvidnbir97jtcOkT/fIubkLU+IQoSQXFb3aiyv9GBeLM
         RSFk1oyK12KHEsHXenSRtdC32s8ptzmauv3Pd12Kxpg0WdBnJUp5UaVgVsKYQ1Lb8pg4
         kzBg==
X-Forwarded-Encrypted: i=1; AJvYcCVH2hOcwY//HkY6riF0WMn3kcEzl7Dd71GSYM2ZUh+apdHRCk6q13hZphIAU7AKdHiQXOB2uLrd+E8=@vger.kernel.org, AJvYcCWl0ZBPQqZLnhYhM/R8O/cUs7269xnKZvSpS7k1qTzouwgWx1pm2/eDvVz64Fu9sCtCBGb1GV9OIGgb4CO2@vger.kernel.org
X-Gm-Message-State: AOJu0YyeeJ2h/eAxX5cSl7CVrbasRdh9kiJWxyCNRt2HVQPNX750SPde
	2pX7jITZXgpKgQVqBmxaac9luHihr9ZikdIH7zZCBK/TyCTewAYX7Ys3xDHmye4=
X-Google-Smtp-Source: AGHT+IHcKZrbaTU2tT7qkMh4am5/XKechOdGa9HHi0r8HWAUblV0ghefdWN5br52HmalYy6jvHJHuw==
X-Received: by 2002:a05:6830:e10:b0:718:6cc:b5a2 with SMTP id 46e09a7af769-71ab31f993emr2699568a34.20.1732118160932;
        Wed, 20 Nov 2024 07:56:00 -0800 (PST)
Received: from Hridesh-ArchLinux.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8c1c13354sm9691844a12.10.2024.11.20.07.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 07:56:00 -0800 (PST)
From: Hridesh MG <hridesh699@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Abhinav Saxena <xandfury@gmail.com>,
	Hridesh MG <hridesh699@gmail.com>
Cc: linux-sound@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: docs: fix dead hyperlink to Intel HD-Audio spec
Date: Wed, 20 Nov 2024 21:25:51 +0530
Message-ID: <20241120155553.21099-1-hridesh699@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the hyperlink as it currently redirects to a generic site
instead of the actual specification.

Signed-off-by: Hridesh MG <hridesh699@gmail.com>
---
I encountered the outdated link while debugging a codec issue and
thought it might be useful to update.
---
 Documentation/sound/hd-audio/notes.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/sound/hd-audio/notes.rst b/Documentation/sound/hd-audio/notes.rst
index e199131bf5ab..f81e94d8f145 100644
--- a/Documentation/sound/hd-audio/notes.rst
+++ b/Documentation/sound/hd-audio/notes.rst
@@ -42,7 +42,7 @@ If you are interested in the deep debugging of HD-audio, read the
 HD-audio specification at first.  The specification is found on
 Intel's web page, for example:
 
-* https://www.intel.com/standards/hdaudio/
+* https://www.intel.com/content/www/us/en/standards/high-definition-audio-specification.html
 
 
 HD-Audio Controller
-- 
2.47.0

