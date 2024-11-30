Return-Path: <linux-kernel+bounces-426129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F10FD9DEF49
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 09:11:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D8D7B2188F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 08:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3293A14A60D;
	Sat, 30 Nov 2024 08:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="R3oRwHav"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBB21C6A3;
	Sat, 30 Nov 2024 08:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732954278; cv=none; b=rsTvu5GZcAG7frhmfI4kL9rJhQTbZYaaHpeQek4W/yRK1MJ4+92LAfLUJ8gy/swaw0XlD/LXhKRQ7TpQ7HP8GHxWPGl2V4ldw3LBx8BwURLm17m9w2GKYKSlRXVLNfAZ9jFw3b4fdbsKKksbFVZbjVC1MprVyRIktMPe+yhJ9nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732954278; c=relaxed/simple;
	bh=EtUbSjB4gtYtVLUlsE3YgcWWNyk4Mo2DOpSuiOaiWDo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kNIJFnMWAx6WSwPlGe6ZI6OlD1MzLrf81NYo+rztL1hIBV/3v0RQFyY/pNFP5+mH54zMtc7CMvTqfIZuXshM+JUCj6+gSQAWTIDI/TkHd2QzVpQTREuPvfQ6jMaeL9no5kJ7f8kVSjPYe7rnJIlIPqmqMUVOPZohT02+5VUxlPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=R3oRwHav; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=X2vAk2Jq9L5dNEBtMuEUntil+Ke6M3OyswhQsebpvUE=; b=R3oRwHavtQnGWQOOjXuLJXkKHd
	WfmUf8yXMLRbGXKe/+veBABRIgGniAqspkruHm9uJD1f45/5NwbRE5FT59GAwVcOj8ji4uI2HTw8I
	ZmmYx5lT7xHtIV7oA23Rogx7jqzj1lVtF4NIOn1SSaELwtv03mVFEb2oYdCS7BeBSFfR4Gu7EvVEz
	xBvWk9+nxbrbDKciq3kPPMLi0FQI8sLSQ/fCJGj7hVQ7LcJmZ+npp8zKA9msoNSicA2/xt/1La5CX
	0LGyBGR+rQN0bfI7NUQE26Q6XFxft42wFhzztLFxi0Sc+G0xHb1PjmegS0J2j7oNqTxPZC+RSw4w9
	L262T6UQ==;
Received: from [50.53.2.24] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tHIZK-00000001bnv-2tkA;
	Sat, 30 Nov 2024 08:11:10 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Sebastian Fricke <sebastian.fricke@collabora.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	workflows@vger.kernel.org
Subject: [PATCH] docs: debugging: add more info about devcoredump
Date: Sat, 30 Nov 2024 00:11:06 -0800
Message-ID: <20241130081107.552503-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Correct a few small things in the devcoredump synopsis and then add
the devcoredump APIs to it.

Fixes: a037699da0a1 ("docs: Add debugging section to process")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: workflows@vger.kernel.org
---
 Documentation/process/debugging/driver_development_debugging_guide.rst |   20 ++++++++--
 1 file changed, 16 insertions(+), 4 deletions(-)

--- linux-next-20241125.orig/Documentation/process/debugging/driver_development_debugging_guide.rst
+++ linux-next-20241125/Documentation/process/debugging/driver_development_debugging_guide.rst
@@ -207,17 +207,29 @@ resources, that can cause performance di
 device coredump
 ---------------
 
-Prerequisite: ``#include <linux/devcoredump.h>``
+Prerequisite: ``CONFIG_DEV_COREDUMP`` & ``#include <linux/devcoredump.h>``
 
 Provides the infrastructure for a driver to provide arbitrary data to userland.
 It is most often used in conjunction with udev or similar userland application
 to listen for kernel uevents, which indicate that the dump is ready. Udev has
 rules to copy that file somewhere for long-term storage and analysis, as by
-default, the data for the dump is automatically cleaned up after 5 minutes.
-That data is analyzed with driver-specific tools or GDB.
+default, the data for the dump is automatically cleaned up after a default
+5 minutes. That data is analyzed with driver-specific tools or GDB.
+
+A device coredump can be created with a vmalloc area, with read/free
+methods, or as a scatter/gather list.
 
 You can find an example implementation at:
 `drivers/media/platform/qcom/venus/core.c
-<https://elixir.bootlin.com/linux/v6.11.6/source/drivers/media/platform/qcom/venus/core.c#L30>`__
+<https://elixir.bootlin.com/linux/v6.11.6/source/drivers/media/platform/qcom/venus/core.c#L30>`__,
+in the Bluetooth HCI layer, in several wireless drivers, and in several
+DRM drivers.
+
+devcoredump interfaces
+~~~~~~~~~~~~~~~~~~~~~~
+
+.. kernel-doc:: include/linux/devcoredump.h
+
+.. kernel-doc:: drivers/base/devcoredump.c
 
 **Copyright** ©2024 : Collabora

