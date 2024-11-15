Return-Path: <linux-kernel+bounces-410473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD459CDC05
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 11:01:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FD25B2315B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 10:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C13A51B0F25;
	Fri, 15 Nov 2024 10:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KJIUcDUY"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADB71AF4F6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 10:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664854; cv=none; b=qwkB/0Boyb2lVZyBS/37Qt/69U1Xm5SVc3KKZMDATAAvZC1dYf3olZQbad1j6qik3TEnYuGM1ksmDb3qrjhfjVQ5nrbyTtmPlp/qyqg3RgYYTsP0rnsyJhTCO4cx+0xwZ+XEIqdS2c4aOMjvggOSnjaQC0ApfF8naDDN/AVDLXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664854; c=relaxed/simple;
	bh=Y0l6MYL9FxYgkAobyrV1dEFhx51cciq6fBBoBftTGmI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OK7C470ZATrQyzycUzf8FtKLJBeycZnhjOfsJCrO85zE92m/P7DNKqVdL+jtmkC59wGG3g1rPqYCmBwC5xfvC3FP8BCi2WOuupak0TB627lmVvQqpk2Oc5U0GtasC2Muy/096J2HspjP8WK74kRu2uZCCFt6sG3R/g0/663p3jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KJIUcDUY; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539e5c15fd3so1577568e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 02:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731664850; x=1732269650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJgKGB6f22K0gvP8aMMCcAaLzCd5tDQzwgfcDLV3EIs=;
        b=KJIUcDUYnDJmflc7cRSKo+CRHyffV+LmGgiwE9ochJCLgHzc+EEsDarqDZIbnI7TeQ
         qJBifzWJM8Xz1KhAbXEIWGTWAxvTSeWLuUMXM1VzmACzbhB7h6n7Grn0/5ymH8Siczo9
         1L1tzJfdGIkbZicFZ9xo51NI+53UrdEq+/wx+pJ3me1d5wh+JTOeQKmx9CdLmJADAY7m
         XtloV11IZdQW7ri3nwDGZeDb+FjU0BOAf6gvN95KVAEyaYwLAnJZRNODfAqSqeCNFFtg
         tPrsn313gf0AwQngc0yq8Rw9lIJk008Fw0GLYTPtf6vBlm171ulyhfJ1E4BMFJSImRrq
         SOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731664850; x=1732269650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJgKGB6f22K0gvP8aMMCcAaLzCd5tDQzwgfcDLV3EIs=;
        b=nWib3PfFU7LIgEhBkHFDpQdTyKxsO8nrCZUX5Djl8LR8KP0XFOM5795Fnc+wL2JsjZ
         yk4da0BG8H2u9cKAmqu0H/WL/3COLzbtaviNI9LWIcDEk3SENqJGvAAtJEYPoG1cSGUM
         TTXrxkrsdQMJDRxR63Fy70ipk9StGZnqVjrVmmUpNAHDcdd9LeEbbGgEcwABFjCjtnYk
         FGgV0RzNHKuOI0mBDmZcdO0nJVTXPoD9Bn1Nt3WhsN5bmUgHIy7zqTL0UdX8u4VS/yj8
         AUW25mGQgl7x+sJ7PtG6dTbN2rlP41OwbppG4owfZnwBidGZO5bD9HHb/dkiGmbaDl76
         V33Q==
X-Forwarded-Encrypted: i=1; AJvYcCXD9w3PYgcj1udJd9zpcxGTJUJkuGuDlx9Tzwxjd3Fx3qBcPfQms2lh9USFaFq9ZvhCcZD05fPrk6Me2vI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFzanHhTf6KWYzEGzJTB3ErmKkupuvCIH0UolHy7AUYItEG0Eh
	TR+NTFu5a5e/mufK5obqN6eyn6EvTopkdu2L/AmJz9LY0PdbHsxTsgo33JW+/KkY7rl5EH6Oti9
	P
X-Google-Smtp-Source: AGHT+IFjnu0mql1AWmnPV6lQab9zoQWnmE3byvz9cEBkk9nA7T4JGo1IHamARfz9EQEozoujyBSePA==
X-Received: by 2002:a05:6512:3c95:b0:53d:a9c1:f6d with SMTP id 2adb3069b0e04-53dab29ba46mr831016e87.13.1731664845746;
        Fri, 15 Nov 2024 02:00:45 -0800 (PST)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6548c3csm500950e87.261.2024.11.15.02.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 02:00:44 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [GIT PULL] MMC fixes for v6.12-rc8
Date: Fri, 15 Nov 2024 11:00:42 +0100
Message-ID: <20241115100042.116738-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a PR with a couple of MMC fixes intended for v6.12-rc8. Details about the
highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit c4dedaaeb3f78d3718e9c1b1e4d972a6b99073cd:

  mmc: sdhci-pci-gli: GL9767: Fix low power mode in the SD Express process (2024-10-28 12:30:27 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v6.12-rc3-2

for you to fetch changes up to 1635e407a4a64d08a8517ac59ca14ad4fc785e75:

  Revert "mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K" (2024-11-12 19:40:40 +0100)

----------------------------------------------------------------
MMC host:
 - dw_mmc: Revert fix for IDMAC operation with pages bigger than 4K
 - sunxi-mmc: Fix A100 compatible description

----------------------------------------------------------------
Andre Przywara (1):
      mmc: sunxi-mmc: Fix A100 compatible description

Aurelien Jarno (1):
      Revert "mmc: dw_mmc: Fix IDMAC operation with pages bigger than 4K"

 drivers/mmc/host/dw_mmc.c    | 4 ++--
 drivers/mmc/host/sunxi-mmc.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

