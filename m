Return-Path: <linux-kernel+bounces-181398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E51838C7B8D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 19:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36E11C20ED7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 May 2024 17:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5089D15746A;
	Thu, 16 May 2024 17:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFx7Uqoz"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FA4156871
	for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 17:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715881500; cv=none; b=sbCAQUKgX6jWYjVoTc4EnQvQFRJ58P8KQwZ7YeXnXKd+0BqLMjkv8lfdKyuBZE+jfHviSnHeHtLYb3zB1ZAwPX3EkYE5uE9vp53ShQEX7I8fxHWzyLNtK7MiBb3Bdx1HMnVHMkFlhdm75+4DD2/5HGpkTNiDtvO+b68oX55I+Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715881500; c=relaxed/simple;
	bh=W/ixAni8SUOXaOT3Pv81/RNqnJOi7m94kvHfKRq5YLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScS8qPb5NPL/VghrGlzGODG/ZIzNPfZIoPURKebnds1U9lby3yBpiI0FyY9mYZ2V6QeEYsTowgGcJwkvViJI4AFaXJj3x6P/vDaJE9BqtY7l9bNkFd/+YxWGOMhxnDDsKczSvvA/DKh4f/ylx1UQdMr6K6tIIcS9cKTqAB2yx0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFx7Uqoz; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7e1f984312cso63551639f.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2024 10:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715881498; x=1716486298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4LvzjOZ0xVdD8uYH97G1FDu1gcEeUac6frsU7264pgw=;
        b=AFx7Uqozwfk+rVCjww3FdQL95H/A1dIBABpiIyokuSkGZ1ljq1Hxz30/sYzQ3yIjZ1
         wHBYUsiIaQ5v9HI5Zomgm8f0tQJkDqdl3PL0i5vRuxjNoz5+6oCNKcAxFz1xatYPCda9
         LxQXpczECasua1H+GomRGBzj0hlinfr/QHClVIN4SDL8GTcj16p/5idVHV4kWQcSAOd3
         1occz3VQ7b2laRYnmkcUZxtZ4C0A/hBkktmT/zYAby3HE1Z3nRoLxwDNmrsRz3K2s8xe
         QTNsHFtqOkVSuAUZ4UrVu3KD5YCVQpuKCPVfS6Fw2m7Z5y1Wxroydoum1xpJJrBt4ZwO
         LZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715881498; x=1716486298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4LvzjOZ0xVdD8uYH97G1FDu1gcEeUac6frsU7264pgw=;
        b=iL250IHir0NotaKGbML/N6g4ZtUKTJNoL5YlJZNZj6qSmaQPmHb8LgGPrh8R1R7ylq
         30+D6HGf94r3dFj9GlWzVtLzOABzsjSxwtzWnIf8KxpcBVl159Wm8vW1aUdcR4ZOu6Zy
         HyesP7kWyHsWuYpwm8CVgm9qvKvHWXSzKrJMu8idk+QDmZPmC0xRM/YvkScIf8ctg7Rs
         oB3l8P3SZ+bJnCrmdo55hvM06HhISwKcqwRsybJEbYVnCG/TpEgEFvkQBtvhOR0kfZof
         qzHJUysGjbj11IsF5x1jEP1PVPd63ctLGVmX23hR2EDUea3NM9dRUfaH6AAV9k3X4pHi
         E6Mg==
X-Forwarded-Encrypted: i=1; AJvYcCX9lOTW7ZIsNeOyryRMm6HMC+pZ8mgojOy/oHJ+iJQ9GkajezS0a2WNTxg+iX4fcxd5JHsNIzx7iY4EPi0/a3A/GL2lWhH7ddZXfVt8
X-Gm-Message-State: AOJu0YypB1fRRGCyL+jmDcp+H/FuU2Pn75RoqPzUK7CO5v8Ig8mXL1zr
	WXV3SN/oRDFLswg/GlwizMa1Hjwbk9Y0PVWH2sPD7MF3W0MiBwsm
X-Google-Smtp-Source: AGHT+IG2t3CLzVhccHNFJALnZQQF9jN79yA0Fk1BHpJAX96dBY38lPOcN56wRktBOzE/GeIKvSUx7g==
X-Received: by 2002:a6b:7b08:0:b0:7e1:8633:5a80 with SMTP id ca18e2360f4ac-7e1b521b447mr2122214339f.19.1715881498384;
        Thu, 16 May 2024 10:44:58 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id 8926c6da1cb9f-4893715057csm4273595173.80.2024.05.16.10.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 May 2024 10:44:57 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: ukaszb@chromium.org,
	linux@rasmusvillemoes.dk,
	joe@perches.com,
	mcgrof@kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8-RESEND 17/33] selftests-dyndbg: exit 127 if no facility
Date: Thu, 16 May 2024 11:43:41 -0600
Message-ID: <20240516174357.26755-18-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516174357.26755-1-jim.cromie@gmail.com>
References: <20240516174357.26755-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test if /proc/dynamic_debug/control exists, exit 127 otherwise.
This distinguishes an untestable config from both pass & fail.
The 127 choice is pretty arbitrary, but imitating bisect.

That control file's presense guarantees that dynamic-debugging is
configured (unless /proc is off, unusually), without dealing with the
<debugfs> mount.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
index 1be70af26a38..cb77ae142520 100755
--- a/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
+++ b/tools/testing/selftests/dynamic_debug/dyndbg_selftest.sh
@@ -11,6 +11,11 @@ CYAN="\033[0;36m"
 NC="\033[0;0m"
 error_msg=""
 
+[ -e /proc/dynamic_debug/control ] || {
+    echo -e "${RED}: kernel not configured for this test ${NC}"
+    exit 127
+}
+
 function vx () {
     echo $1 > /sys/module/dynamic_debug/parameters/verbose
 }
-- 
2.45.0


