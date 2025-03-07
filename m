Return-Path: <linux-kernel+bounces-551358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D172A56B76
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 16:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 617BB7AA945
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D8C21D5A0;
	Fri,  7 Mar 2025 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b="kEnnOKjR"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0B421D59B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 15:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741360188; cv=none; b=PEQMZnJrBV03bk04pJY/jAB1WgSGIxk9rI53Wf74zUSpgOLxqiEqoduJ3s6IJ0ie3zXmwZ52OW88WJHjMJ+CvAUl1pix7X4hXTDx4Mb5Qogjb3wxXoNTGH+lopz1sQAOubeipaULFGEMrtB3+HGx1z1g+iHRgaWIrBFysiGt54A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741360188; c=relaxed/simple;
	bh=gE6FGCV28DwkTHBBOESRmnTDsWzJHMdNw/Oj97QoaiM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e4zRT7znJ5WKnIWPNQSgYF06ugyfpH+tGRNZzTk+loEEKAEvWsMpYZ5rg8/goJF6zr0i9iHEAT6f/WHfvDhz7KfSav5+HGG4rOUVfKbX8QL6I+A/z7Apioi2inxu5ugUsJpUIv75oWrlIe/mN8trQxgJgl76DyPNxu2WNfw3UuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20230601.gappssmtp.com header.i=@readmodwrite-com.20230601.gappssmtp.com header.b=kEnnOKjR; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39129017bbbso865073f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 07:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20230601.gappssmtp.com; s=20230601; t=1741360185; x=1741964985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BP9EZa+ZXL6z9j+n7AY1mhAuXOFT2kVu+uBWLrEP2JQ=;
        b=kEnnOKjRVDJkPhTH4NAr02m0uIFW40H0+iQBKyvXSykYEoy3j9Q1Hecgq5l0jipCCy
         mBIcYvvK4ka1jHl51nPY/lYpMi8tI8+iHeHvTM27u+F0mohPwJMc4AwBxtCn9WjOUSVM
         3QW9XS2CbcKbedb4V1knjAnuUVmAqPIJGCAo3GGKYIpl9FS0ENHQF8SZXI8nmOZ+PAX/
         bvhl2G67nnPymVBNIH40iP7iYpsN74ieOrTNf0YVsw1meyB4F52GyGhdG06sYPTMXklm
         +WXSr5FiCNmjVjwpiBFTcyhl2m0eYWFcOoxg1zMrey594RfnwyhNevlfUQxvYBL+3z6y
         EpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741360185; x=1741964985;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BP9EZa+ZXL6z9j+n7AY1mhAuXOFT2kVu+uBWLrEP2JQ=;
        b=QtdMQ3M8LiiQtE0g5gzwAFYTnE/StU2lun6bnUBtqsghlv/JFvXEhIhDY8ufIoH3/F
         6ziCqgu/mUa5EZsaN62AylsVDvVd70TWbus+ubZLDBMLH+e9N7sOuIZGf/yKCy9BNAqj
         rBGUXcfpsc4XSwtiul2VfiPaESdUOeM26QJcDF6TtnvdC5HtTewY2uYHKB06Efm5bLgq
         7g8CbGpziItycXvyWeQGMscdloaNjGkPPsXYCud6ztGH6eDs1J0Rk/ZZv0B+2FYt7u/O
         qfgt6dX8nyM873KGqYy5G6XsSkUxEdu4nUI6W5Veiq0Vb5gy/FOvWHbJ2nSoKurzFm0k
         KbMA==
X-Gm-Message-State: AOJu0YzQ61IH4FD6ue9cFe37uSiOpcpQFV/3nJz1mbvRnb3Gr4F1Q2oF
	CIOCo7VqqOgCRG/sfis11oogSam0WGRhAZxtLcSzDnDh7QdrKZB3vErORaW7Qn8=
X-Gm-Gg: ASbGnctUbL9x8AkN6mprW+fjZaIq7qi9ijTvpcJA36a221yc+fOK1rSB6RNMwvUJ2bh
	dWqTgb4WfPvhlYm2lDtNyyZULHF5Hgc6588aRiS06jxBnGqbVoy2eMs62otHic72crgMhW3Gu8s
	iA7FVWXYFH+NQ5KFm/xUtNkw0uLp7NGO7n2Pg1N1PIFQzK0cECgWX3fdke6wNUOMccAHlaMczq5
	OHrpjDbdM3Z5XbLM8ZWzPhgVkXR3aVTQNzOvTWepSWXHAXicFPzCoI6siGT0dby6NHD1qZbwd7S
	u7vmuBY0yNFwXpZTVD0ddVj9QuVrunvjPLBdFGkQI3be1LYy
X-Google-Smtp-Source: AGHT+IFk6NYRxZEBXy3AmEUNEKnHoFzQmS/X6I0jyvaiFDvAd5Hny94unW35ookz2eoEpTTH6nqtPw==
X-Received: by 2002:a5d:5f8f:0:b0:391:2e31:c7e8 with SMTP id ffacd0b85a97d-39132d66e3dmr2518912f8f.2.1741360184367;
        Fri, 07 Mar 2025 07:09:44 -0800 (PST)
Received: from matt-Precision-5490.. ([2a09:bac1:28e0:840::179:137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2b6asm5703574f8f.66.2025.03.07.07.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:09:43 -0800 (PST)
From: Matt Fleming <matt@readmodwrite.com>
To: Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH] kbuild: Add KDEB_COMPRESS_LEVEL to control compression level
Date: Fri,  7 Mar 2025 15:09:40 +0000
Message-Id: <20250307150940.1309703-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matt Fleming <mfleming@cloudflare.com>

Give users more control to tradeoff compression time vs compressed size
when building debian packages with a new KDEB_COMPRESS_LEVEL option.

Here are some examples of using KDEB_COMPRESS=xz with
KDEB_COMPRESS_LEVEL=1 through to KDEB_COMPRESS_LEVEL=6 with the
bindeb-pkg target:

  Level Time to compress Compressed size (bytes)
  ----- ---------------- -----------------------
      1        0m36.771s               476909176
      2        0m40.335s               474832644
      3        0m43.635s               473845600
      4        1m13.839s               472260012
      5        1m18.657s               464442676
      6        1m20.658s               464355000

Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 scripts/package/debian/rules | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index ca07243bd5cd..616ecf1d4d1b 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -52,7 +52,7 @@ define binary
 	$(Q)dh_fixperms $(DH_OPTIONS)
 	$(Q)dh_gencontrol $(DH_OPTIONS) -- -f$(call mk-files,$@)
 	$(Q)dh_md5sums $(DH_OPTIONS)
-	$(Q)dh_builddeb $(DH_OPTIONS) -- $(addprefix -Z,$(KDEB_COMPRESS))
+	$(Q)dh_builddeb $(DH_OPTIONS) -- $(addprefix -Z,$(KDEB_COMPRESS)) $(addprefix -z,$(KDEB_COMPRESS_LEVEL))
 endef
 
 .PHONY: $(binary-targets)
-- 
2.34.1


