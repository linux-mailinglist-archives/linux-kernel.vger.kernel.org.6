Return-Path: <linux-kernel+bounces-428346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC339E0D31
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 21:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 108EA165302
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A421DEFC7;
	Mon,  2 Dec 2024 20:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DnmVeGT8"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F131DB375
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733172150; cv=none; b=QNZjxwhKWYJCy8KrrPEO4VUlQFn6Pxx5bTYfYz9hiwweCfmn0QO0tyfJVAQS1c+xeoHuqX9uAGHgzFOcwGiL0okcZi61Yh/zFaGiTC1U8EvPuoxdyzP+Hl6WjEkzz+UVxHTRj6KQO0bUlu68O3JP0N+xxtVQmiR1F/xKAvr7pa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733172150; c=relaxed/simple;
	bh=So58BXuncYIboiWaENrBOfZ+bpn/0USfmTRKvrJYBx4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ak6ABbbeCSo508rgSQz0Gtr5DdM0Smp6ns6ZetwZips523sGbJfypN4gEnN7MdaL43ZHGXFauxGJ1QfrMtP2rvsoFtSP29OzAqDz8TIjecR9UOSwp1Pmt7g5dr4jX2HSMfVCEegmF+Nw3yjJjx++G44pxaJhiPeqAtqq019rs5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DnmVeGT8; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6d842280932so47392166d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 12:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1733172147; x=1733776947; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7WWNnGM1SseVvgF623+8aFk1sTvlHCnrRssC64Qo0+w=;
        b=DnmVeGT8Wyh47dHy46LOXoInSwa3dr249MoP77kWNBSqGI3MxsxQefqJ7iW83dosvB
         zTFFzKGo2wyK5m+RM/lo2MjlLe+bqqAlAwQG2qG2Zz+/KIR8pGKneRMIri/B0Sb6oZif
         dltSS5RdrEBy6BgdUIAaPbJyEWi8wnP1a+4xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733172147; x=1733776947;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7WWNnGM1SseVvgF623+8aFk1sTvlHCnrRssC64Qo0+w=;
        b=uTHn1IbjR3dLeCM4K0fRH/cl5YTQvgovWIKFfDrncZTGYcaOrdZwZWRnadY9pAkZx5
         EY7SrKrFqiH2h1kYpMWekhC5WWXMhA8v9ccfqT5P9nQWy5xheR6mmUydiOgxj8zxKyvR
         X+LzvBVEJPYS5+NOFm0lomL0tY0Igc6EydAT5FddzU1q4bP9FoOCCi5NVlY6bdcqo4A/
         4ut2w6ttCOWCMac9aDaes+a6Vfo0ZICS0eDMFzOl2NOS9BHJCuv1HxzcKZEoz3hhMgbn
         STM3szZri8Jtwb3YkjpXp2MHzxWXOhZ34v0imruH+pFGsu2SOIVmUizJdSdA/6oFXhbF
         sROw==
X-Gm-Message-State: AOJu0YzxSaG+uMOZUmlGPs9dOZg3V56Jh3xWR0ZFKMdp+CiPNbkuV2dY
	FRZmTKGu+t6VZdRIG8O4XIZ4R5AsUsqgy0PO7KwneD8O8My9heEtPSzLvwQcXQ==
X-Gm-Gg: ASbGnctxa2R+3Zu98NHebSVH1o7T+FzIxDzZNlINXA7+np3hrkX7gA7/FRI1TtMZcXo
	8KBNS56R6u536ZmlXowjn3ROXHhuXcbKdQaPa2dyIDnYfBJ9TsXGH4FzqYV6lfodZLKlhEhvs3S
	UsEhrsYB7u6Mh4M5rdQbsZx26uP7VLoEorDdXHo0YDhOyDJ2f9cM80I7Iqh1xAZrmhRWsp2N7Rq
	anSKZBDz4zT9qZ2xD3rnvmbEuGEoxexdLfOYbN7+OXBIkQVUqH6w3Gzy2F8Sl1MUJ6MKuGnQq5j
	L+5MYdBoMn81xRhEPZCUaIoi
X-Google-Smtp-Source: AGHT+IEe8uxCWTfFC27oIC5bckcBwtRIg7jGfYnts+IYz5lQueVIl0W6RVCDU2McJuD8C7Tq4aPVjg==
X-Received: by 2002:a05:6214:2501:b0:6d8:9062:6616 with SMTP id 6a1803df08f44-6d8b72e17b8mr792916d6.7.1733172147490;
        Mon, 02 Dec 2024 12:42:27 -0800 (PST)
Received: from denia.c.googlers.com (5.236.236.35.bc.googleusercontent.com. [35.236.236.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d89c2f3d02sm25681276d6.52.2024.12.02.12.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 12:42:26 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 02 Dec 2024 20:42:24 +0000
Subject: [PATCH] checkpatch: allow multiple Reported-by tags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-multi-close-v1-1-a68240379db1@chromium.org>
X-B4-Tracking: v=1; b=H4sIAK8bTmcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDIKGbW5pTkqmbnJNfnKprnGpkbGBilGJqaGGqBNRRUJSallkBNi06trY
 WAJzF2MFdAAAA
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
 Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.13.0

If a patch has been reported by multiple individuals, allow a single
Closes tag.

Given this patch:

: Reported-by: kernel test robot <lkp@intel.com>
: Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/
: Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
: Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/

Allow also this:

: Reported-by: kernel test robot <lkp@intel.com>
: Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
: Closes: https://lore.kernel.org/r/202411221147.N6w23gDo-lkp@intel.com/

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 9eed3683ad76..d6a79993fdf1 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3189,7 +3189,7 @@ sub process {
 				if (!defined $lines[$linenr]) {
 					WARN("BAD_REPORTED_BY_LINK",
 					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . "\n");
-				} elsif ($rawlines[$linenr] !~ /^closes:\s*/i) {
+				} elsif ($rawlines[$linenr] !~ /^closes:\s*/i && $rawlines[$linenr] !~ /^reported(?:|-and-tested)-by:\s*/i) {
 					WARN("BAD_REPORTED_BY_LINK",
 					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
 				}

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241202-multi-close-3e23042d5185

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


