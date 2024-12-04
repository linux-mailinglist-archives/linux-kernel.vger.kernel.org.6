Return-Path: <linux-kernel+bounces-430914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D81779E371D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E93328A5F8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877EE1B2186;
	Wed,  4 Dec 2024 10:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OXBCL0gp"
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2A81AF0A4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733306505; cv=none; b=hyp1s6EyymFmCTUmRsE8rPKUf3aRQJy624h35wYxaw5TiF6fRQvba1kpIXstcJTfCb80LO/eT3AssjQysk/jCybbFktwGfkQ5YBt9CrgAF49bi3GXPywoAqe3PARinX7jRhkSgKSQ4fg1//gE/dZS1MyH9GZ5paPqJzzSrJnLCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733306505; c=relaxed/simple;
	bh=z7cObjJ0P5i5PgvcZ+UzJLzGhCGsFnm5xBbnMdhHuI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QY6kBmqsAhTTKoHhtqJn+w1Uf9MTTSVcT+bA8VMvR1yAEkYzvgJYRNhPQKmUtoBKGSYxbFOpdSSpckK6oGuLPUpy7QPNmdIb6dGr+mopDwwTPCOyE3G6HknhzptQdSGS91YI7QYZZy+vNX1QjJ3nI/fIVHdfy17TTIiHcZH456c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OXBCL0gp; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-385f4a4093eso2186475f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1733306501; x=1733911301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0osI88+EL8Ir2uRVL1vR/sVTdCXha1R4tnCQw66w72w=;
        b=OXBCL0gpzjpfLR8P+aG2F4d7WL2TMajCMBr/V3KsOAG3M8pbIVV8tm0MySF7pPBdx2
         Thg5uvrCirVnRCLc8RTMYhl7KyprUTR5fN5SrewtZSfR+gC/pi35HTnaDlctKaioP0ZY
         INw0IIVnulQ5uAudShZ1FWqVWslS6ILm6N0/J3cy71kS4Xq/PjBzLFgZm7lksKfdOlha
         KOSzMS54rXPz+ScireKBTYok2Dl5JxqigW0Fnbg/ZPPlay0G11maYUvfBxdS2fiDpYPv
         BiuBjJP2akvtKPktkavvZliacFHZMDv1MzPjYWKLTWNTVzrv+QS9sil3FgNPvKNwDDVL
         of1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733306501; x=1733911301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0osI88+EL8Ir2uRVL1vR/sVTdCXha1R4tnCQw66w72w=;
        b=QyEyqKsYRDfnFZwVPzpFrDPom9cGmguDlgvmuJBFcdiqZwclLDQa6fwKGdsa45zT2q
         cEGJLqNq/nuZn7qrh3nHWUt+aBTRGrj7/xtTpmdQ+PxTeGglP2q6aEzWnrHYPhSuLY+C
         X7urzU7B2RYBFCgsUFsC9H/wqDXR4HBsYOGy3zVU0NwPXLMNDKhhHg4UhrsZGdiBGWAf
         /wI6RCa8BeQihYvnTCdViHdZnctfVE5jQ8rYzg9BnTV/B03t5ue5y8DSEUNTzmD6r6J5
         BQQIJ4oV7nFErEJQf7MH8DUSuDJ2M4xi3inPisZFAZH6aVtvCEeH1CXUCT0l7UiCpkVf
         tsRA==
X-Forwarded-Encrypted: i=1; AJvYcCVsoBgLe4cSj9uf9ujI86ZxQbTagQVnDjkPGb2ue3SF5G3gfV1hsDbJjeklqTO0Awy3rT5YdmcQyJK061M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/KUE9j1XZr+COu7sxidu1Bq+wEzV0Eu1BYMu2g6FRLl3QWFbk
	JfhGtCdIRYFxXYEkFSN60L/QOrNIV+14E4MN2yXvElRN7ewm/LO4dXlMGfnLKh8=
X-Gm-Gg: ASbGncvha3zs9kjfdMaJNqV6exFccrMRCAegUTNsM7YX18Zqd9EEB4fvkkD8onQKeyv
	aLzDxNYvK6r5dZns1syjH8oY7V9F3s2zFULukTs8rzJIx3qk4JPpmrGP+E+x8lU6SiMA0CN7nwJ
	noWyRv4rL/gZIm+SNhqVfEdko5UrvR6Zep2Jp2B7TZoSCMeruhu0CfOSewEK5Suu6a6zCYW1K6w
	LEg0ybwlEis+qSleHPgsOJPhcv0v68xEr1PG4AIL03fIc64l91lirAsGlm0gHfpKRxk+jRvqpqZ
	t1o2
X-Google-Smtp-Source: AGHT+IG8t8AZXtxlaeWRrueqJ99ZpThtNNMUSTKR1p6c+AsIJcP/BhfG79U39WiCin0b3LiMLsAPQg==
X-Received: by 2002:a05:6000:4604:b0:385:faaa:9d1d with SMTP id ffacd0b85a97d-385fd3f15camr5276803f8f.35.1733306501268;
        Wed, 04 Dec 2024 02:01:41 -0800 (PST)
Received: from localhost (p5dc6838f.dip0.t-ipconnect.de. [93.198.131.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ef3824dcsm9269843f8f.23.2024.12.04.02.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:01:40 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Matthias Maennich <maennich@google.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] doc: module: DEFAULT_SYMBOL_NAMESPACE must be defined before #includes
Date: Wed,  4 Dec 2024 11:01:11 +0100
Message-ID:  <3dd7ff6fa0a636de86e091286016be8c90e03631.1733305665.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1733305665.git.ukleinek@kernel.org>
References: <cover.1733305665.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1199; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=z7cObjJ0P5i5PgvcZ+UzJLzGhCGsFnm5xBbnMdhHuI4=; b=owGbwMvMwMXY3/A7olbonx/jabUkhvQAjXIlXvFjLf9d/Kpqt0sdW3PMbZ3Rap3zjB5zLDz/y j1//fJ0J6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQATWdHG/lesNP7j3SP2tk9O 7yjO8Ez1SxTP5iiPvi/8xnZL9ZPoC+UfprkHSj999a6j5PSLMwkCDAVHN9+5aDw3vc72r7aSS9N Vh/2NCY9P+mqEXFkU7v1dahPXzA+XZa3mljd1L/Pqec+x6qJye3ZaRrxlaqn1I6EHt5jNtPOmvL lc/fWEbOPifawWPvfD78bNU+mN2SX54nzXBVspvznvDn2TfWfK41jU8cn7T3DEtb13C1qU1Jw/z jcVZw300te1ujov8Z6lVK3v3CN71yR6Ze2e7tizaFeXaG1m8pkQvVXz2HOtXnor7f8nJN2i+SqC c1Nl04z508KEFcPjtQ27lW9xXQ213+Zptuet/qwFOX91AQ==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The definition of EXPORT_SYMBOL et al depends on
DEFAULT_SYMBOL_NAMESPACE. So DEFAULT_SYMBOL_NAMESPACE must already be
available when <linux/export.h> is parsed.

Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/linux-i2c/Z09bp9uMzwXRLXuF@smile.fi.intel.com/
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 Documentation/core-api/symbol-namespaces.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/core-api/symbol-namespaces.rst b/Documentation/core-api/symbol-namespaces.rst
index a08a3448cbad..d63e4245a9f5 100644
--- a/Documentation/core-api/symbol-namespaces.rst
+++ b/Documentation/core-api/symbol-namespaces.rst
@@ -80,8 +80,8 @@ unit as preprocessor statement. The above example would then read::
 	#undef  DEFAULT_SYMBOL_NAMESPACE
 	#define DEFAULT_SYMBOL_NAMESPACE "USB_COMMON"
 
-within the corresponding compilation unit before any EXPORT_SYMBOL macro is
-used.
+within the corresponding compilation unit before the #include for
+<linux/export.h>.
 
 3. How to use Symbols exported in Namespaces
 ============================================
-- 
2.45.2


