Return-Path: <linux-kernel+bounces-430912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 303B09E371B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAEB328A0F9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DFA1AFB36;
	Wed,  4 Dec 2024 10:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LDcmDFTW"
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA4A199EA8
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306503; cv=none; b=QYDqDX7aIo+HJj/IIac4usWrDD/FCLI8xZ3JtkaUDsJJKD5DW75jgFPaZFiw4rSlNe0hNPTCcxPbu83/+HCuXb+7D5d8ML+do0YekGrhbel6efGMXt8/3ILer5AqepTSBu5YZw57rZYKesqu+Ed4UCpfwKgRNhyoe2HS3qlCEu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306503; c=relaxed/simple;
	bh=OY51iaNt++wUkGeXL/3RGnmJazb5JgcstUIT3FLQ2nU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BwOs/xEn3p2+pvftzxgFJbZUrQIubj4uFmzwUJMaJM04pWtrZ3G/nkTHt2r0dQuHSJ1YtkspAzd/KiKbElHY9trxU71wCAJIibZrrW3DiR2fmeoQsaqrl9Si+DMbIVnsINLto0NkaRi0fYBuw3c+9BFq6EcEymemviZAmG46WEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LDcmDFTW; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-4349fd77b33so54239415e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733306498; x=1733911298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zq3RJq2fqhtYeZuvz6OgfpNyrnUUP6rae9B6jpa/3NQ=;
        b=LDcmDFTWoVfNE6DiEg6Kv+8VGR7SUzSNqBHCzRAANQsQ57b3O1s9RpWsSvbhZeg+CR
         p4CpnlLWEyhXaWRZr4cN2aAmnYvGVAUYT9IoKvhB8Jja30GPj5AVK6QJdqjshUpQCL+v
         njkCTyVN2qNRev73kbEmPAxZ+JJ14wGM/cIe6hFm6ZWQPD0MglxeSURNr4jAxPmxKbtY
         ywZUuk/Vm+gEDzopRp0//4X/V29nw173w99VwEFDOSH+7JfUZtyPzPiNiyTMHqKSBr7x
         lHSzXb5F+bUjax4uuuVsVYokMY7CRsAgrkzwwDUqyC4Uhv/su5Cfcm0kBVeoGGxGrpXi
         sdiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733306498; x=1733911298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zq3RJq2fqhtYeZuvz6OgfpNyrnUUP6rae9B6jpa/3NQ=;
        b=DW1ZlOJMPQD5DcHI+XIuhFg90tx/tJQAZO7rVkLSn/cvmJkwM817JaJ/rfziAe5Oco
         IiJWvIVYkJb7Sv8wXQDLModZ8i1mC5QIOf4Ve1Im+szwbYTQbX/+RpHIrvBMW4y3mgDU
         /i+mLVcIcmgH0q9fD15q+A7fvp+9bSSCdpcWa45V4xEs67iWuhesJEDCAi8xuwgQCPpg
         3fLB8vCrDw+WQ+jSgJ7XZLQCZm3K6s/Vm4Z8Lc8nLwKOncbsRrezKIZh0GP73/sA5CCr
         wU54k00cRQCA3/WAEgaltfxB8mgQhCJgJ259ff5BusUtKT6GWJYT8WoXkt47Bqs7lhC2
         Vogw==
X-Forwarded-Encrypted: i=1; AJvYcCUeNSNCDJ+EgmevvoG8k+fykDi+1i5C5JZ2yu9QrRlhmOo+yvSJPMLJSmXHaTrCecOizg85AhreYhXUbFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFvoLKTM1K87uHzJ5LKQ/CabJ8wKUZG3SNoaJPAzjg31Px8PX9
	u1ofJRedIYjIGogt9E9K8rAPlX5jyjwpdIl1Oq/Ow+yUSeetrz558l3Ilgskjno=
X-Gm-Gg: ASbGncvscFM274VZp8p01rAVJ5wkoiNICWoJ5Mm1/qO1KJYhOzdQb81V3WBXEdfORY2
	Kmr3KZJ4pzgWeBykCA983SahY6UJsM9zxgQtjlkLab3y8uB5SgnBLa8kDTxMangcfqYSKYasEZ8
	zNVY6qLyoo40fLO+/nBqgVmOx1DXxwjBhb85ZFWhctNPLUmpkGUpFAI3+JK1wmmI+JOshLUiyDc
	GLyhtR1T1ZIIhvMlhHKmB8sW+lJ04jVsSEv++Y/swlfkT6JAHUq3dwn7qvSJ0cwY1kC3rW0ZnfM
	r9tP
X-Google-Smtp-Source: AGHT+IH5bQavvdT/WYtMf/I6+6DOVMJd5U0IR8N6Tg4dhOQ0CbdP86UanWwhVFCSXQzoS7tY5qNJuA==
X-Received: by 2002:a5d:47a6:0:b0:385:e055:a294 with SMTP id ffacd0b85a97d-385fd55f1b4mr5108948f8f.59.1733306498432;
        Wed, 04 Dec 2024 02:01:38 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd3a71bsm17746611f8f.55.2024.12.04.02.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:01:37 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Maennich <maennich@google.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] doc: module: Two clearifications
Date: Wed,  4 Dec 2024 11:01:09 +0100
Message-ID: <cover.1733305665.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=864; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=OY51iaNt++wUkGeXL/3RGnmJazb5JgcstUIT3FLQ2nU=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBnUChlzSf6ehtUHG4Ml6mJXztndF29No3czo6y0 VRUSTjT/+GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZ1AoZQAKCRCPgPtYfRL+ To54CACTMayUGPq5eZTEqhC7RTDHvYQT3rPa/qu9lfxIT/vkclG+sDQm/bhB2pRPw/IP2Jef+fS Z3SkdMEpKdOFpPUKbOzLw2Qr7ZV/ZWe9Kejp725QNlsWqa+FAg7FxmFIzwUCcqheyLHthxjazr+ b/tyWpVj+ADvPiNdhU7xDwaTvee3I2872hhTHRF2Xm0w3Le+GNA6luiQ0HG8kQaIN7fNWoON1i+ o3rIXx4/vMdqba+I39LzabSfmORhJssBUu7RqWTW7SIObr4H8QyES2EYgSkauHNhPlOHLas+5Ls bH2wUy+jXNIIjf9hpCEsh+dw0cPUm6aKLK+qDvnXH+o75QdX
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

here come to fixes for the symbol namespace docs around
DEFAULT_SYMBOL_NAMESPACE. The first updates the text to say that a
namespace has to be a C-string. Before it claimed it should be a
preprocessor symbol. I'm not sure how to understand it, but today it's
wrong for sure.

Fixes a statement that Andy pointed out to be wrong in the docs while
discussing the respective fix in drivers/i2c/busses/i2c-designware-*.
(See
https://lore.kernel.org/linux-i2c/20241203173640.1648939-2-u.kleine-koenig@baylibre.com)

Uwe Kleine-König (2):
  doc: module: Fix documented type of namespace
  doc: module: DEFAULT_SYMBOL_NAMESPACE must be defined before #includes

 Documentation/core-api/symbol-namespaces.rst | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)


base-commit: ceb8bf2ceaa77fe222fe8fe32cb7789c9099ddf1
-- 
2.45.2


