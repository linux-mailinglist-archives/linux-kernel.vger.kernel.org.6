Return-Path: <linux-kernel+bounces-266526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8800940128
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 00:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84785B20B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 22:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9A118E769;
	Mon, 29 Jul 2024 22:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BLOeGHy6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF6A16F278
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 22:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722292628; cv=none; b=MmDee7j5ac9HPdkoqkAuV5aK956RxnIg0xRTX1iOx3ZiETZoFhBYUDWnRlQuPr2c8o2jxPvSgWSAgmFBVuwBsHtm4Zv7cK3w/huCcYd9T4qpAN91hHRAKUpwjxBUZdQV8lua4eWl9sRTzcJq1w7e8fhcuK98CMpO/g9Rb8kZ5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722292628; c=relaxed/simple;
	bh=WG9SD2wD3Kn82vDHoqLK7EYev24Fn6Ab/6ah9v+cdGc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=VUZk4vkpIfEg1nNqSxw8Gx7jX/GFCDL5GPun9lD+VDJbGGcCEHHLXq7utoWkF8e7AvP0YauA+5VvfPBp0DZtADWQLhuIStzol7juhuicNKRwmpeptTyfkZ7uFfrSXMgkzDMnFW6zao6wTRm3bokaN8EJJ80+s7ZO844RPW08K1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BLOeGHy6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4F7C32786;
	Mon, 29 Jul 2024 22:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722292627;
	bh=WG9SD2wD3Kn82vDHoqLK7EYev24Fn6Ab/6ah9v+cdGc=;
	h=From:Subject:Date:To:Cc:From;
	b=BLOeGHy6Qsk4NB+9ktUpm8yTDgnNkL01CcaI4hnIJPTW5aF70ygunHUzeAYf1SBlh
	 SSotHm1jV2mPUA0DWkHs3hYxmv/ymGojD3FCXbttIb3gATjluEqj+b33v8UV5Jweyx
	 R9LV0HF0vS3PYvQEYyp+ldVYqQiUrfuvu+cLWfQyUmsXZUeKwbsIm/5OctQ7Su4a8w
	 ybPKu2GAGObGzoJx7ikKwTuaFBN3lA7EfCWT+RD5TqqTjag1ZCE3vPmgOwRoCkU6We
	 SUHXCJav+DupQaSbXseWW4Q70fMcGRVUiMc3+QzGlLSvyFJNK809sHF8hcoa6nVoqI
	 y3lz6KLx4kMLg==
From: "Rob Herring (Arm)" <robh@kernel.org>
Subject: [PATCH 0/2] cxl: DT property accessor cleanups
Date: Mon, 29 Jul 2024 16:36:42 -0600
Message-Id: <20240729-dt-cxl-cleanup-v1-0-a75eea80d231@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHoZqGYC/x3MQQqAIBBA0avErBtIKcquEi1ExxoQE60QorsnL
 d/i/wcyJaYMc/NAopszH6FCtA2YXYeNkG01yE723SgV2hNN8Wg86XBFJO0mMQ1aKWegRjGR4/I
 Pl/V9PwwXuI9gAAAA
To: Frederic Barrat <fbarrat@linux.ibm.com>, 
 Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev

This short series replaces the custom DT property accessors in the CXL 
driver with the common ones. The one difference is dumping the 
properties read out is removed. If that feature is really needed, then 
it should be implemented in the DT core for everyone. 

This is part of a larger effort to remove DT functions leaking DT data 
(e.g. of_get_property()).

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
Rob Herring (Arm) (2):
      cxl: Drop printing of DT properties
      cxl: Use of_property_ accessor functions

 drivers/misc/cxl/of.c  | 207 ++++++-------------------------------------------
 drivers/misc/cxl/pci.c |  32 ++++----
 2 files changed, 36 insertions(+), 203 deletions(-)
---
base-commit: 8400291e289ee6b2bf9779ff1c83a291501f017b
change-id: 20240729-dt-cxl-cleanup-eaf8185a99fc

Best regards,
-- 
Rob Herring (Arm) <robh@kernel.org>


