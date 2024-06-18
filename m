Return-Path: <linux-kernel+bounces-218479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12F190C06A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B1528315B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEB3568A;
	Tue, 18 Jun 2024 00:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NV+xiIy5"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3AA20310
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718670980; cv=none; b=jDXXXDHkIZVIQom9V1su0VrB/bLzRvOHy/0CPFVM41kfxmHeC0CadBPPElv+F9solSCB9cD3CcjsyX7AMYh81ht1hTbzFd6d0FCfbd/cZAqJ+diRUq7SIltkQwgc5l1mJhU/vrQIwFZdceYN1yZWwzBdZ12d+chTx9ZUkdBT3t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718670980; c=relaxed/simple;
	bh=VqV1fDw2Zlc+m3rdHu2iF9oyLQ5D6wuqsU87JbobZZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Esc7yLItOOxgzGTkpnJr1cW5hjsH9Fwa0ey/9+Qa1ASG35oylR7XNrZ6vl3AO9JRYrOWspL6caixEDUuBWJLs97v5k7IUqUptk3OHx06OwOkjmfGeofTfQBjXGK82oqmKpdqNmS7T9kUvm6+nPd7dHoEbNUct5z/VoZT0G92ZoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NV+xiIy5; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7043102dcc1so4412998b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718670978; x=1719275778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXtDQlH3qupn0qZjK7Kqht//pAWQBswDysjbTh2Fp0I=;
        b=NV+xiIy5QCL1SIGU9IGhlfDoRXlNIEB2H5EOa/B9BTCKzGON6v53DYfId6ogG3gWKm
         3zz6tJb0YRtlMUiec91HhhnAOWOYfZVBjGfnYKXSD7osNvlVR2f/1oiV1LWO4BXbNnr5
         L7RCjXBjAp6deYqZ6AhanNesKBIOcECNXrEbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718670978; x=1719275778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXtDQlH3qupn0qZjK7Kqht//pAWQBswDysjbTh2Fp0I=;
        b=OXM4lQC7os/1fYPIxOFlAGtVX4nclE3YEaI1uxNRtZCNLrZeaZtBg+WAvyLX6ld0k9
         KuzxyVf5KLL6LmmQv28Kjj7ri8DF5mehMfapiLpfHhTJyUqMHiIkYtpvYF22b5BLJ1Dq
         nAda9JXfgMwcOjh4O4x1Ma4uo3i4/J1zFLY8S3Km5TQ3C1X6fj2BXoc1QNO8W4ALfgqZ
         wwdtsoyXOde0vMQWiPPAb2fLxygVO85pwB/RKSPeMeuufZaEU++WbYDszvzRV205dwZ/
         xZQ/2XMcSDON2ymKAGMyIur8w6vE7XwK3mbYUUSk/8LrFeQwrTzQ/fhvrRNj/JDeN/D7
         beqg==
X-Forwarded-Encrypted: i=1; AJvYcCXqqpCUUHC75viExTRped4NvA39PVq9MY2f9hk1lyviVB/Xm1pOIoNPf55hcx/1TklJQmN7nGOr9UXgJhjhkxU5XJiS5XfkYpzzKLdF
X-Gm-Message-State: AOJu0YzdwvMbVaqqxhF3jBS+gLEGS9g8KEePPRirjo7EdEuYo7JGgFz8
	IIMNz8hWljBYw/ADHEaRWaImrjVRSCqiM+OsjDpF+rl3rtrXse+HZiv67K6PFw==
X-Google-Smtp-Source: AGHT+IH/u84DuulPXx+yw5N5bMm6/HzUFv8lvpttz7Qy/cBPuO4uzd7/a1OmwA0vYyZyQV7iEYNYpg==
X-Received: by 2002:a05:6a20:7288:b0:1b1:c77f:56c3 with SMTP id adf61e73a8af0-1bae7e0c23dmr13733218637.7.1718670978386;
        Mon, 17 Jun 2024 17:36:18 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:1798:e71b:11ad:8b94])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb99f4dsm7905917b3a.216.2024.06.17.17.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 17:36:17 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
	Douglas Anderson <dianders@chromium.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Jason Wessel <jason.wessel@windriver.com>,
	Thorsten Blum <thorsten.blum@toblux.com>,
	Yuran Pereira <yuran.pereira@hotmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] kdb: Remove "mdW" and "mdWcN" handling of "W" == 0
Date: Mon, 17 Jun 2024 17:34:40 -0700
Message-ID: <20240617173426.6.Ia1d546061f9430a90df0e7521097040e0e939c58@changeid>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
In-Reply-To: <20240618003546.4144638-1-dianders@chromium.org>
References: <20240618003546.4144638-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "mdW" and "mdWcN" generally lets the user control more carefully
what word size we display memory in and exactly how many words should
be displayed. Specifically, "md4" says to display memory w/ 4
bytes-per word and "md4c6" says to display 6 words of memory w/
4-bytes-per word.

The kdb "md" implementation has a special rule for when "W" is 0. In
this case:
* If you run with "W" == 0 and you've never run a kdb "md" command
  this reboot then it will pick 4 bytes-per-word, ignoring the normal
  default from the environment.
* If you run with "W" == 0 and you've run a kdb "md" command this
  reboot then it will pick up the bytes per word of the last command.

As an example:
  [1]kdb> md2 0xffffff80c8e2b280 1
  0xffffff80c8e2b280 0200 0000 0000 0000 e000 8235 0000 0000   ...
  [1]kdb> md0 0xffffff80c8e2b280 1
  0xffffff80c8e2b280 0200 0000 0000 0000 e000 8235 0000 0000   ...
  [1]kdb> md 0xffffff80c8e2b280 1
  0xffffff80c8e2b280 0000000000000200 000000008235e000   ...
  [1]kdb> md0 0xffffff80c8e2b280 1
  0xffffff80c8e2b280 0000000000000200 000000008235e000   ...

This doesn't seem like particularly useful behavior and adds a bunch
of complexity to the arg parsing. Remove it.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 kernel/debug/kdb/kdb_main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index c013b014a7d3..700b4e355545 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -1611,11 +1611,6 @@ static int kdb_md(int argc, const char **argv)
 
 	if (isdigit(argv[0][2])) {
 		bytesperword = (int)(argv[0][2] - '0');
-		if (bytesperword == 0) {
-			bytesperword = last_bytesperword;
-			if (bytesperword == 0)
-				bytesperword = 4;
-		}
 		last_bytesperword = bytesperword;
 		repeat = mdcount * 16 / bytesperword;
 		if (!argv[0][3])
-- 
2.45.2.627.g7a2c4fd464-goog


