Return-Path: <linux-kernel+bounces-401468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8707D9C1ACE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEEA1F23895
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 10:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FA61E25FE;
	Fri,  8 Nov 2024 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OGuntJKV"
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com [209.85.208.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32ED1E231E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 10:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731062340; cv=none; b=GnfBf1V+XLY3bwAd0n4NAyTEsVQwN1rnjH4AD2mOEsG8WZoJuU3ooNkNi7+6r8QMfnX0nV8gPZOxqoqj/H4S5VigNKtTfRmeFfGpzlTGF91cMpnSGC0YENmM9Mq47MtemBFW6lXwc2tTE8vAE2QyVd4fmzAp04SzkM/xQujBdzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731062340; c=relaxed/simple;
	bh=mcaJwPbIfL1eOaJCBeghMP/S25nTA8NCJStg51856fg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R7cw/+tCXFX0Q8AgyTOS2SxesPArlGGWT8ntFMpD8J9X5T9f3PTFaw7ZHmZ0VzPJR4ghXcfhMyWfQW7DuhO9D2CVmmXsqkKrOdUhvwBN47VTS+hDdZ949LzFDE5PufecShBriRlrEpvJcxYoIt3t11Pbi7y81ak7OoVAA9rKwlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OGuntJKV; arc=none smtp.client-ip=209.85.208.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f196.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso32431371fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Nov 2024 02:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1731062336; x=1731667136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SaISgbIGwpAO1EVVDtgSTHmyzi3HxAQHzUJmlDOmvT8=;
        b=OGuntJKVk38iqi8zoKos9l2LLHr7leql72l3DBj/4YfFli3Lir/RLq0wQMlFWdFd0N
         OTMUd8r56RvZG3ZzgLlWs5x3bVdjR8h9OTaCxTQneYA63JQiPsfzPhQNduL9SQtXRbNA
         iqjdvoiULVb97tRDN5Po6P4hF6x8z14GE1DdSqPplXprXYgWAsrkpHvQBCN+l4ptLRgr
         kiduGQv4MpbPhaD47wTul/OZBOE3hbDu3G32Ug3IDzMs1EVX3ew0OyJkjliwfdsos0OM
         bP6BSOLDpuQBEzvEa7Ohwerf/MEWLjdodx6JiIqiq9ADOgcWvE1FQC29WEwlLjC+/NHO
         E7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731062336; x=1731667136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SaISgbIGwpAO1EVVDtgSTHmyzi3HxAQHzUJmlDOmvT8=;
        b=sXz8IFdnMTfoqkxUeO72KiI8xpnWzuUbfFvh6OEXK2FWfZE3M3paXOT456bu+COIn+
         iWaSMFgrLW5nE3GgX0zPdS08bP6gTMgduRSoQ6n/4RP3DNl1pg43kIXLpGtsp62IBTyP
         +uWVxW50Jk655iZT9h564pUM3IikbEZgqDkGI93ngyi02X+XMXSFR8+hsflyy8zMqXNw
         mE3XwwrK/yvV9jxuaHKalStuzq8eK9meKjzLGd+lPzRxB6UmgU++7uwkmaW81hlIIlbR
         6sAKe1953oenbFYPnig2+vnRMk8LshR93sUSY62YDjH+53784jHWGEXAYW9BMseaXx00
         h1Jw==
X-Forwarded-Encrypted: i=1; AJvYcCUUMbOIQsdHff1+P9l4V/9fzfSZSWpgtCiOBs8mub9dcxwp8+3YFfbJlAoWUrFyj2d0ZOu0eVacC58L9C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNwcjqFYE/xbcJZpzXBf23apeofmUgkvGjlVLxZvoneJk0uGkt
	kAWxTDA/tS40cBH5RI4DdAKeai6ZgSPU3QSuOhDOB6xikXnAPS2gTpXCLWYAQhU=
X-Google-Smtp-Source: AGHT+IH5UNmzHaes0cojtKWppdmffN914U6rvrc+ZzaB03JePe9nRLbAK00wuir/DGJiOezZXD0K2Q==
X-Received: by 2002:a2e:be89:0:b0:2fb:51a:d2a with SMTP id 38308e7fff4ca-2ff20188132mr19417491fa.12.1731062336127;
        Fri, 08 Nov 2024 02:38:56 -0800 (PST)
Received: from localhost (host-79-35-211-193.retail.telecomitalia.it. [79.35.211.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0abe6e3sm213730366b.84.2024.11.08.02.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 02:38:55 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: Andrea della Porta <andrea.porta@suse.com>
Subject: [PATCH 0/2] Preserve the flags portion on 1:1 dma-ranges mapping
Date: Fri,  8 Nov 2024 11:39:19 +0100
Message-ID: <cover.1731060031.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Empty dma-ranges in DT nodes using 3-cell address spcifier cause the
flag portion to be dropped by of_translate_one(), failing the translation
chain. This patch aims at fixing this issue.

Part of this patchset was originally preparatory for a bigger patchset
(see [1]). It has been split in a standalone one for better management
and because it contains a bugfix which is probably of interest to stable
branch.
I've also added new tests to unittest to prove it.

Many thanks,
Andrea

References:
[1] - https://lore.kernel.org/all/3029857353c9499659369c1540ba887d7860670f.1730123575.git.andrea.porta@suse.com/

Andrea della Porta (2):
  of/unittest: Add empty dma-ranges address translation tests
  of: address: Preserve the flags portion on 1:1 dma-ranges mapping

 drivers/of/address.c                        |  3 +-
 drivers/of/unittest-data/tests-address.dtsi |  2 ++
 drivers/of/unittest.c                       | 39 +++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

-- 
2.35.3


