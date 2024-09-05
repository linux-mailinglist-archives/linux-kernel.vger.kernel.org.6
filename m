Return-Path: <linux-kernel+bounces-317029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F8C96D867
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55EFD1F234FC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69DA1A38E6;
	Thu,  5 Sep 2024 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aNiKZVBX"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64D01A286D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 12:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538852; cv=none; b=radv026Maf2Umm4Z5nFxZz6OVdvKwW85mS5otkX9UeGMMRIXrPVGYLRzd26Ym6BIetKJWkOzpTKiAOfCcd83NwZtsCMj9CkR5hkxXgiLFEQZysrjHMQ78RzcVe+tJ1CzQ3sYGHER8icBbB8K4mq2b0PApQiFTBTfXeZdNRPdVT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538852; c=relaxed/simple;
	bh=fIL9B9Aylx6zP47IDwRHOji+WKHw2aMHkTk3odK3lr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P1kV9XD6dysFSluT4SsX14WdCmjFQlds6IplVOOAkZ5NMxdh2WB1KAb+Zg00K0TYc+RvvvlLHmXJjUlNNu1KrM5iS6ldVXaCOy625rbW6VaAjp5TIZWrxZIeatYdpknRIelGoCusud6LkNQw3psHMHxxlOg5sk8pYqCiGKEoouE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aNiKZVBX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-42c79deb7c4so5523015e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 05:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538849; x=1726143649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySXYpz4iv8/05NOLOUJH7PXyIj8ByexoEH2a7swYSIQ=;
        b=aNiKZVBXJw0dZ2kjucYtrHWxW5S9xMvGJtpUMX2vWN+M0LILdFkaSkjNzL3Sl2Vejg
         IlmNxaZOVSlhgE2k+CVIbKCFgTTHhTs6xMG6hnFrON1MdfYndtJqLFbnXL12jmHExZ8g
         LgIz4fWdFjKx1uwrAUU1ZLPSpNRbfF5Px5KkZrgN05AJ1gX8J8dKhz9bcFfva1kxr61s
         pHbbqBJX4at6gZnu/wmUz/WGBVXBV2O/cORPpWEvuFeqI4m63gf7cEfjqBOXDVPwKMnt
         KA+k64N89Tf/PBQncoekrPmpnz7EuRhF0omAMSIRfoO3h+K0Ry7lyt9UkN5UddjxgkTN
         xP+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538849; x=1726143649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ySXYpz4iv8/05NOLOUJH7PXyIj8ByexoEH2a7swYSIQ=;
        b=CUW49A2BuvG1J4AO5b6RTziSQn9Adjnju5Qp1SpnYeAColO7kWcGNlQTT1plnCJRA7
         QTHWG13J9lWBVXHwOu6BGoq6c8l7qkZJWfe9f+rsCL/bJyt4ailUflRB01udC2VYQU2N
         DDsnVYjtrF0llmNU5wCg7xvAk3PFj8kQAn6xGyywr2Z0ZWv3uTOG01bILDxUzVqziScL
         tgu6/cFn0rXGgNFPXOcdhGaSo7b58AgGYHiPxusmB3iZIWxs583Rteca1kN4bb4FpPqY
         E1ltNaPLinWUY1JQiPQk6S6MGietbS3IYdl4x+Ou+JYgDCkng+ldo4cH/HJFDB/FpYdU
         nbBQ==
X-Gm-Message-State: AOJu0Ywl53PbmId4j6Jxs51mLR0oSamKjhAzgY48Id+fvEWcmWWSDzRB
	PgozqaX94EPM/IIEdPPcJVJ36QoEGUKcRONfZmXwpY9gsR28d+fgRoO1cUjiaXM=
X-Google-Smtp-Source: AGHT+IEBUsoymW+5Cx+plkohG71ShqfP0FB3sHs0zn6ELWnhwz+71dJzvrn4+btpNJZi1vJlnvDhpg==
X-Received: by 2002:a05:600c:1ca1:b0:426:5cdf:2674 with SMTP id 5b1f17b1804b1-42c7b59e433mr131142345e9.4.1725538848636;
        Thu, 05 Sep 2024 05:20:48 -0700 (PDT)
Received: from fedora.iskraemeco.si ([193.77.86.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e27364sm230390515e9.34.2024.09.05.05.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:20:47 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 18/18] prandom: Include <linux/percpu.h>
Date: Thu,  5 Sep 2024 14:17:26 +0200
Message-ID: <20240905122020.872466-19-ubizjak@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905122020.872466-1-ubizjak@gmail.com>
References: <20240905122020.872466-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

<linux/percpu.h> include was removed in d9f29deb7fe8 ("prandom:
Remove unused include") from prandom.h because this inclusion
broke arm64 due to a circular dependency on include files. Previous
patches resolved this issue.

__percpu tag is currently defined in include/linux/compiler_types.h,
so there is no direct need for the inclusion of <linux/percpu.h>.
However, in [1] we would like to repurpose __percpu tag as a named
address space qualifier, where __percpu macro uses defines from
<linux/percpu.h>.

This patch is basically a full revert of d9f29deb7fe8
("prandom: Remove unused include").

[1] https://lore.kernel.org/lkml/20240812115945.484051-4-ubizjak@gmail.com/

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
---
 include/linux/prandom.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/prandom.h b/include/linux/prandom.h
index f7f1e5251c67..f2ed5b72b3d6 100644
--- a/include/linux/prandom.h
+++ b/include/linux/prandom.h
@@ -10,6 +10,7 @@
 
 #include <linux/types.h>
 #include <linux/once.h>
+#include <linux/percpu.h>
 #include <linux/random.h>
 
 struct rnd_state {
-- 
2.46.0


