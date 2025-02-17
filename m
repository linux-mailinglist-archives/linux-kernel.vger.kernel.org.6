Return-Path: <linux-kernel+bounces-517633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 033C1A3838A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 13:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB1EA172E3B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 12:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2F221B8FE;
	Mon, 17 Feb 2025 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDd3QtRw"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4962621ADCE
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739797005; cv=none; b=fQD3mJD6gt0Qky6NEGmGPzYcUQ8xElnFoXVo+SWOtIbrxmQ5/51Z/q+N6UvK+n9BD/Fqu7HafCn3y0COyfHgNXHfxlopwYnwY2KpZh+1mjTzddoAcRwaG8GIk7GuNROSc8CHPKuUdnXFafH/7uGoJJLFP4L/5J2bk6MUJ0vcgxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739797005; c=relaxed/simple;
	bh=RzszDZP0yG2wXMCuyILVdPYmMGztwNcJ7s4yFtngP8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=of/iHF6yQYjvcB2uYFZPxdhs0LRtWSBYB6jyiHGadBdRFwaYI+EwF0Xew+78T99vmybclgKr4SdjwHYNhJWxaR/NnJ0oBWf5LlAH6PJb1KAJC4STWsBRMtD+nTbknjZ9bwNT/hNZiDiIvdOiT5a2MUhTl0U7KgXpWbhMFVdbZcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDd3QtRw; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-221050f3f00so33992185ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 04:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739797003; x=1740401803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMv/zSSTQbD/xLU+9HCbjZPBCs+m5GIXQdkA1TcQxe4=;
        b=BDd3QtRwJ0W0hdTtuzCT3oLG2JocPakO+PPi5YsaZ4jh+f2VsFC9VctlpfB+UNhoLe
         KTSqZJWQX+u+CNUSLoLnaxc76sfH84aXWzhjkQiSUdlW/iEnUvv/LgTEPP0Ggy+M5mHI
         ejxxDl8tKVXUjZY9go0vk+VFHixeG09FJMOb+m7gPdDQF7FGsyfUwKc8Uy91OgmXYuwb
         Esq7rvS4If0RTyfAy2WPxaW8uJWM9sZnaRAFbdNMByPQTvVrYhbOMJ+dkdoSbOKSA8pr
         GCq5qEQTeuAyq7vQLPmsjaWu5fszg1b0mTYXg7q9eF0IHJRvKCWO8Pp/s5Vdt+mEYA6S
         Szhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739797003; x=1740401803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMv/zSSTQbD/xLU+9HCbjZPBCs+m5GIXQdkA1TcQxe4=;
        b=QWpyLHmyubYb+K0BTQlEXYW0FmTQLCRNDIaoC+38jwN+npuEgW/BfQsOdlFI1BIiF4
         ac9r02xPSrIHlUmr9PyFP31oUBGkU44mKg6Zpk3JU47pgFlvi0ZQHm+NouMvcfOzgdTp
         DpCdP1CSeablVjp4LTIp/P9ThJ9xxN552cgK6rhMj1wKqcDtmCbKCWzzr+kkZSJ+qmZa
         eB1I6xIc3/BFeWDJl2gcWXB6va7qHqjaY+mQdGcDuM/s6AWEmobKmGbBnA207cMcwaZP
         AGSdEClApTQtMRIB+tpv7FQcTBAjtJFVGTrAdaATIKplGtrUJR/Y2FV0PqF2katiDm8e
         2iPg==
X-Forwarded-Encrypted: i=1; AJvYcCUPDGlCDk7eC2uwm714a/y9/Ls5sIBpxcv4nV9jD8RWucrzvmkBIBE4JejvcVe5DbhB7w46hnGVj4KAomQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRoOe9Vzu7O0Kxhg0LyMpfUeQAEjOhL02f7v3TCR5+rncFkwik
	FhIusxvTZuV0HHMaEtV0G3Y9MoEh5fJf8he6nrVjOL1lQcZlBrBd
X-Gm-Gg: ASbGncu0/evOC7SUCdndIqFGSJSbKhTpc6ZhHB3JbnI9/EVqVwwCztMDSXkCkife38r
	6vZFh+juFxJg75tbcsEUXxG+/K9DwxvEE8zVub7F4tftSP7GoHqcXZCIMa1cgF1rcrr4gnqwiF7
	toftQgy+bbzS28Bx5WbBMnUvvF2VCgbBmuLLLik2xI/4VbMIF48Ild1tA2y2QSxX63ttpAk7NL9
	ju9154cYYUpljl0XfMYHXSMJ+6EWSzRvjpGL/D8yeFfcj7MT3TWqkWF5HLcFfm8w+o8eQauiIwq
	H7QLEpll8MycAInUCa/9
X-Google-Smtp-Source: AGHT+IG7RfJ78Ke3TOD7UhjYlnkWAAzlWWZixmgLKPiIceLEOn28Akbe2ZRpNs/gev9QvJ6MiFecKA==
X-Received: by 2002:a17:902:e545:b0:21f:6dbf:1850 with SMTP id d9443c01a7336-221040bd704mr164901815ad.40.1739797003521;
        Mon, 17 Feb 2025 04:56:43 -0800 (PST)
Received: from localhost ([2409:4066:d04:319e:1d76:db25:b6bf:4f52])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-220d5349047sm71475415ad.7.2025.02.17.04.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 04:56:43 -0800 (PST)
From: Ravi Kumar kairi <kumarkairiravi@gmail.com>
To: dpenkler@gmail.com,
	gregkh@linuxfoundation.org,
	kuba@kernel.org,
	rmk+kernel@armlinux.org.uk,
	broonie@kernel.org
Cc: arnd@arndb.de,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ravi Kumar Kairi <kumarkairiravi@gmail.com>
Subject: [PATCH 1/2] [PATCH 1/2] staging:gpib:hp_82335: Fix error message format for invalid base IO address
Date: Mon, 17 Feb 2025 18:26:16 +0530
Message-ID: <eb8368ee9fff0076ea1f97d154ff2b07d2fec572.1739794938.git.kumarkairiravi@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1739794938.git.kumarkairiravi@gmail.com>
References: <cover.1739794938.git.kumarkairiravi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ravi Kumar Kairi <kumarkairiravi@gmail.com>

Updated the error message to correctly format the base IO address using %#x
instead of %u, ensuring it is displayed with a leading '0x'.

Signed-off-by: Ravi Kumar Kairi <kumarkairiravi@gmail.com>
---
 drivers/staging/gpib/hp_82335/hp82335.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gpib/hp_82335/hp82335.c b/drivers/staging/gpib/hp_82335/hp82335.c
index 451d5dc6d3..f1c2045570 100644
--- a/drivers/staging/gpib/hp_82335/hp82335.c
+++ b/drivers/staging/gpib/hp_82335/hp82335.c
@@ -274,7 +274,7 @@ static int hp82335_attach(gpib_board_t *board, const gpib_board_config_t *config
 	case 0xfc000:
 		break;
 	default:
-		pr_err("hp82335: invalid base io address 0x%u\n", config->ibbase);
+		pr_err("hp82335: invalid base io address 0x%#x\n", config->ibbase);
 		return -EINVAL;
 	}
 	if (!request_mem_region(upper_iomem_base, hp82335_upper_iomem_size, "hp82335")) {
-- 
2.48.1


