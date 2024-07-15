Return-Path: <linux-kernel+bounces-252865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36096931919
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 19:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01411F21F53
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 17:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E27146522;
	Mon, 15 Jul 2024 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mG55TXvq"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AF2446AF
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 17:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721063895; cv=none; b=b04qI5HIsTFdKlry4Fp3Ua8fzo4C7VlOBkmF5DCT8pwPfNL4ngWYAOliCKkRc8OQe+yAbe06ExHLgmL+aoRXe0QGmW8C/v46/URKZM/KXOTYFC6jbzhW46IJF8O/ikCnGHutkTH7KuhbMCADxgRQy5UpfZAYT0BBe65s94jCayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721063895; c=relaxed/simple;
	bh=sGPIgRMwOQgcxTqDzLkA2Xc8d8mFrxEg2vsRuPNY3Mw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MJVZMfSSpXb69wXQW4AySBDde2SDTLFjy6D0u6eFQ6hqsC/1UPMWqlYVj1g4W3medohm47iYf5ZFobqagME7TRHLGldk9q/vQE0yb9xZlPgF0YsxAetdRJsAnI3x5wqe9mH/5Ua0uPJMEaGNHf0OJ+yCCjvmaPnu3v+Iqd6bRgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=mG55TXvq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7669d62b5bfso2661717a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 10:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721063893; x=1721668693; darn=vger.kernel.org;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YtGnG3lGdf/hkcfvEvKJE092rxHnVgPs69DM8LjlVo4=;
        b=mG55TXvq0O/N1NzBVF6Wns3pj4tXvxgTY1xZPstntxqv4zf99lndhHSHOuRKQ1TbhL
         1qPHRF0xhkFmexghKHz3xLaTk0TfAry2mtGSNsjCgrGfwarcaz+yWIK4z4gL6Wi73bcN
         ePWrw5u5yUwIyaf83qTLvimfW69RswXl7mJBYY0dYDvonJQUoWsfYOAI95Mwdushobg6
         MXP1QcmMblps8PPWQfdwa3mBm/U6W/KNgCzbH96hBPA2iDs72Iefqxr5yju+u3kxjToe
         gemFjQuh58pqMW2J26ztHNURQ5/q5cWgGVW2PLIt9D81oQyIQ3JyIDpGA6YO/1PRs2Mh
         DYLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721063893; x=1721668693;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YtGnG3lGdf/hkcfvEvKJE092rxHnVgPs69DM8LjlVo4=;
        b=Hs5Uwd1pIixZQ5E+ErWQbrtVHyDesaL1KxyFCOMZm0pNUiJqW5taNDAZnkDqMRzmNZ
         4qMSonLuOOza+NY0shzViBvPe9UWZ4QWvTBlARCGxW5If0iuSvpRvr9UH47dZUOCnKiA
         wPT0zI6NhNoiv1utEITFZ3+ZCBsxoGqIVK5UFBGINllBItEB9hsPTMyauhIE18rnDar0
         49WSomrZTVI422Mt54jbGYdsMZD7hxdRxxr1s4V1h7n5c05lXse/jr6jkj8ezyqITX/P
         2V7NV5VgBV36BrfXBuScfUwgMUkz36P6vpdZ14udH80r9qk3yXvrwSSf3yjnCe/yYYju
         j7JQ==
X-Gm-Message-State: AOJu0Yx0rmimEX8eRnTfM0n3wgfZj+o5EDZncRjhzRvYPVi6SitO6OmS
	MtlWsoWaKipiWWnHQdhbB9C6oPj78u+3WBA74SHPv5ZfPe/T9f93p3PKIBBSv/I=
X-Google-Smtp-Source: AGHT+IFkOvHGd/UM3S2hiTAQyUuVpiY253uZl4jwquwLi7WE1eLM3bsAejx6xdhGzui9w1giQpsydw==
X-Received: by 2002:a05:6a20:9146:b0:1c0:f315:ec7e with SMTP id adf61e73a8af0-1c3ee98f09dmr622567637.28.1721063893162;
        Mon, 15 Jul 2024 10:18:13 -0700 (PDT)
Received: from localhost (97-126-77-189.tukw.qwest.net. [97.126.77.189])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc516dasm43405355ad.288.2024.07.15.10.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 10:18:12 -0700 (PDT)
From: Kevin Hilman <khilman@baylibre.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: update omap branches for linux-next
Date: Mon, 15 Jul 2024 10:18:12 -0700
Message-ID: <7h5xt67ewb.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Stephen,

I'll be taking over from Tony on maintaining the omap trees for
linux-next.

Could you please update the omap entries for the trees/branches pulled
into linux-next?  Patch below against next-20240715.

Thanks,
Kevin


diff --git a/Next/Trees b/Next/Trees
index 13308bb5322b..22b02f8c81ba 100644
--- a/Next/Trees
+++ b/Next/Trees
@@ -63,7 +63,7 @@ v4l-dvb-fixes	git	https://git.linuxtv.org/media_stage.git#fixes
 reset-fixes	git	https://git.pengutronix.de/git/pza/linux#reset/fixes
 mips-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git#mips-fixes
 at91-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git#at91-fixes
-omap-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git#fixes
+omap-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git#fixes
 kvm-fixes	git	git://git.kernel.org/pub/scm/virt/kvm/kvm.git#master
 kvms390-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git#master
 hwmon-fixes	git	git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git#hwmon
@@ -134,7 +134,7 @@ drivers-memory	git	https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-me
 imx-mxs		git	git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git#for-next
 mediatek	git	git://git.kernel.org/pub/scm/linux/kernel/git/mediatek/linux.git#for-next
 mvebu		git	git://git.kernel.org/pub/scm/linux/kernel/git/gclement/mvebu.git#for-next
-omap		git	git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git#for-next
+omap		git	git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap.git#for-next
 qcom		git	git://git.kernel.org/pub/scm/linux/kernel/git/qcom/linux.git#for-next
 renesas		git	git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel.git#next
 reset		git	https://git.pengutronix.de/git/pza/linux#reset/next

