Return-Path: <linux-kernel+bounces-360938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2861599A183
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 12:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D07851F22D47
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 10:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1172141B9;
	Fri, 11 Oct 2024 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="BW8uka/n"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC6B2141AE
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 10:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728642937; cv=none; b=TAm7OtdJFTh03kCtQw+FlH6vQU7HF8Q0EyRkWuxoGJJ7gl9Rd/KAUJrC7RlhBv3QQ6jkjHtKlObNKRsdfCDtv85xAwulY7uJnqXiZ9qhoCxZfufplzeH30IpQv45poJVBfjbQVH1YboUJcZwVnmI1isOB0/fIamhmr+qPgmpf4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728642937; c=relaxed/simple;
	bh=aN7qz/p2yFFjWdhvlvJcw0UJXrJvejxwLpb3F/G3N2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSq3ezFPs0J1m+BNmud3+9G5oGQ3IzfMB+EGEflNSMVVZzEWtPSunNwRPFhITRNXYtmSmbc+RWFAgITFxYa6QKWPIpUNKyEkP85F6puHOymqU4aByRKajHK9ZSI1jiy2lAIR6aSOHctAZEEXMmtA/RBx0MLUgl0LJ57f6hMHh2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=BW8uka/n; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c949d60d84so602744a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 03:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1728642933; x=1729247733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o0y2fOVyD+icRBtf7f6CfcDIS1ruayl7XHPLwSR33SU=;
        b=BW8uka/n/Twh4GQgweOn1o6p3G8SpMS8fLv5fXa8avARLA8AIonb7AO+OeDr/7DmFB
         R3jUtNPW56idInfOruv2UP06DeYUTSUQKiHglHD/WVZZix2pH0/Wgw5hWoR5m+gzLRrr
         fmgTm1TvpP81QuK9TYe5k7ZuIXJFAZ6mKhSbtQgKJWwwRq+Lf2ZJFRzmlv9YePwEPC/S
         I5PQDSIBOtXGJpw6itU/72QRwt4xrOvPfZyvhtsILmgrl0yMTSxceikxWbsoLzTEDLwR
         nHB/ENdeTeJteciAnM5QIRWe3vKxb765aA+bHNjO2A9nlxcgJ7Zb3a7rXYf4digMH/rI
         FW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728642933; x=1729247733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o0y2fOVyD+icRBtf7f6CfcDIS1ruayl7XHPLwSR33SU=;
        b=xF7fNqQBvVFXoQxZbZrOwPWIKYeN6VvPIa/ElTbdPdDlyKYWZHLHN7gb3oG85OjH1U
         4UDR3Gg9hRLOecVt+em4bnjoDSLi2BrYXIhty881ilghp0Ob5Q9eQBMASwT++dbS8Upy
         2ymfVpoK0UdXfP/b+/CtizCGwKV//APfUJtaNKhmly/hb+KD1yDGf8/kCTZj3bsKX3bK
         gscbrYWRxp89zXWZXp3LfmNiyIk3T6+EY7AnCuK+HHSiKspVPSyp19ZyTlS09U9Re9MS
         QnZ6WMI0fs5YS+Vo/L2WbZrzP9AMnfdiC0+WiYe5qRId2r/ObSQ62sXSfTdOHq1K6G8U
         fJVw==
X-Forwarded-Encrypted: i=1; AJvYcCU0JR3p08fSbx3qwIkCv/7vhQa7yMY+FjfGHFk4sqLQrBOlnkIhE7TQ3MepJu8F8AJL6U33vPsU7epz630=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTmYEkmu1Pem0WKWT8L+NuWmu20hoFX0Iye8fbpw1QlxKmAVH8
	ljbpSV1z8xBoozFuEQRxaT7UVerDOkqirJSS7SW+c3JmzpNsWAQ2YZx2NABiFxI=
X-Google-Smtp-Source: AGHT+IEWku4cnKDqq8+sEC5b+rV5vE8pgHZmbSfpqorU/XvE+cyGXVrqZWvhJWGUPU4OX0LOOxg6oQ==
X-Received: by 2002:a17:907:f796:b0:a99:5cb5:6175 with SMTP id a640c23a62f3a-a99b9436b1dmr182178466b.35.1728642933155;
        Fri, 11 Oct 2024 03:35:33 -0700 (PDT)
Received: from fedora.sec.9e.network (ip-037-049-067-221.um09.pools.vodafone-ip.de. [37.49.67.221])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f29besm195353466b.211.2024.10.11.03.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 03:35:32 -0700 (PDT)
From: Patrick Rudolph <patrick.rudolph@9elements.com>
To: u-boot@lists.denx.de,
	linux-kernel@vger.kernel.org
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>,
	Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 35/37] bloblist: Fix use of uninitialized variable
Date: Fri, 11 Oct 2024 12:23:16 +0200
Message-ID: <20241011102419.12523-36-patrick.rudolph@9elements.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241011102419.12523-1-patrick.rudolph@9elements.com>
References: <20241011102419.12523-1-patrick.rudolph@9elements.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initialize addr to zero which allows to build on the CI
which is more strict.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/bloblist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/bloblist.c b/common/bloblist.c
index 2008ab4d25..cf1a3b8b62 100644
--- a/common/bloblist.c
+++ b/common/bloblist.c
@@ -499,7 +499,7 @@ int bloblist_init(void)
 {
 	bool fixed = IS_ENABLED(CONFIG_BLOBLIST_FIXED);
 	int ret = -ENOENT;
-	ulong addr, size;
+	ulong addr = 0, size;
 	/*
 	 * If U-Boot is not in the first phase, an existing bloblist must be
 	 * at a fixed address.
-- 
2.46.2


