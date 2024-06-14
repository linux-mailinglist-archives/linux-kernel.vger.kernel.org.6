Return-Path: <linux-kernel+bounces-214518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 30AE99085E2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEF4D1F227D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ABB51836E9;
	Fri, 14 Jun 2024 08:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ZG+gE0qR"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3032186E47
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352778; cv=none; b=tIPA22pmS1Qsc1r5MW6xSNb9Fn0CDNh4VnC1NCDIvNew2D9WSNpReoEgA+Pf5GvEW4gEIxE5EW6yLBOpFQAZMGwAIhGqiEFHdVTgszJutL+yss5npWMw6bM1gVakT8K1LE5HZJzN+oe1AIME+LvW+fzoU8fH1Lyj7BJT2AnQuSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352778; c=relaxed/simple;
	bh=rDqQbB8WtLI0sNUuiLmLKSokCC9jWiu+CRLfqoeNG94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ja1MGfpUVX2nEUv5s/Tl6Ki01sCBgVoVwSuV9IO7a243F+IsddFJu0lxJ1MPvKo+UioVr6AeNc8qRP9Zi0o7Hma8atUf2M8S+CMhPu8tg5aBjPYEpre6YpD3JIQADHu9GJjxEEJ6fgy29mtFd32AZxIYyokzugS2/7Y4ZAC+52A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ZG+gE0qR; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=X8SjZrtr7vYauQzzWhyTb2doGzFDtsUQAd4VY9QcFf4=; b=ZG+gE0
	qR4/l6m89NxA1cfDH+n/wgF34suN1R0ymF+jCl+Z6PTZbY5Tao7FqTIJy+G09vtO
	s598J//k8juh2k/SY7MUqEcA+miefoIMtl+yLEx10qNpmR3oy1KdO5zKrJtB504Q
	telfMoe47npiiefu3Vdx0YIQ2S9szU9HXhcW2R2E2CXyjtupUfnlM4CJuvbivM4G
	vh+5AIrIuurYeleTf6OtTn/MffD9EnaKfeHY+Hxf9ymwZoldmV6EyPApyzJlf/Ae
	SSzAZRPY9guvy6lFb00Z6nrSXHfRmS6LYnkXGeboAC4p0StFrV36UwWou3Vjcez8
	Ahxif/tHBN8+8Ycg==
Received: (qmail 1438207 invoked from network); 14 Jun 2024 10:12:50 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 14 Jun 2024 10:12:50 +0200
X-UD-Smtp-Session: l3s3148p1@lN59LtUaKoIgAwDPXzjQABqqX1QYyOSW
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Easwar Hariharan <eahariha@linux.microsoft.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andi Shyti <andi.shyti@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v3 5/6] docs: i2c: summary: document 'local' and 'remote' targets
Date: Fri, 14 Jun 2024 10:12:43 +0200
Message-ID: <20240614081239.7128-13-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240614081239.7128-8-wsa+renesas@sang-engineering.com>
References: <20240614081239.7128-8-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Because Linux can be a target as well, add terminology to differentiate
between Linux being the target and Linux accessing targets.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 Documentation/i2c/summary.rst | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/i2c/summary.rst b/Documentation/i2c/summary.rst
index a6da1032fa06..ff8bda32b9c3 100644
--- a/Documentation/i2c/summary.rst
+++ b/Documentation/i2c/summary.rst
@@ -49,10 +49,15 @@ whole class of I2C adapters. Each specific adapter driver either depends on
 an algorithm driver in the ``drivers/i2c/algos/`` subdirectory, or includes
 its own implementation.
 
-A **target** chip is a node that responds to communications when addressed
-by the controller. In Linux it is called a **client**. Client drivers are kept
-in a directory specific to the feature they provide, for example
-``drivers/media/gpio/`` for GPIO expanders and ``drivers/media/i2c/`` for
+A **target** chip is a node that responds to communications when addressed by a
+controller. In the Linux kernel implementation it is called a **client**. While
+targets are usually separate external chips, Linux can also act as a target
+(needs hardware support) and respond to another controller on the bus. This is
+then called a **local target**. In contrast, an external chip is called a
+**remote target**.
+
+Target drivers are kept in a directory specific to the feature they provide,
+for example ``drivers/gpio/`` for GPIO expanders and ``drivers/media/i2c/`` for
 video-related chips.
 
 For the example configuration in figure, you will need a driver for your
-- 
2.43.0


