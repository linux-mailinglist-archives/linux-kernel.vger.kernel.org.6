Return-Path: <linux-kernel+bounces-250750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 366D792FC3D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 16:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6697D1C224EA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 14:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E136317166F;
	Fri, 12 Jul 2024 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwhnwjHe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D85A171094
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 14:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720793319; cv=none; b=MjCmsc0fHUxvjZfLwSUBXF6yrMlNWe5GGRCx1myc/a7cSwPB/81X/mYQ7cnP5tACdgOJb+QzQBVIoOs05XQbr67Y1uJgq/0d8v7LYy9JA/Zp0L8nqjuKdEEE9zyTVYu67CbWkBQ9YYhq/vtkacdG5YEp2GpAd3qxxGtU2v75uAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720793319; c=relaxed/simple;
	bh=ow9AJ//jVwfGZhSB8AYloU9hYnkv2FQyvwvJeG3Nqb8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gvq5B89AUv+s4uZ5TGKmudNI7PhzCyzkNP1ZLuF8QXVFZBqPwNugN+8fO/PMNxE7W9OWmHUpheS1DZumlbk7LmJaRKzMY7YYCaWMCbw8/EUkzVVN+mv63tD4ZvqCtWBqqrT/QIh03opYx/JYYPSazDoS5TC0vHJIfP0rpIxRt1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwhnwjHe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5964C4AF0B;
	Fri, 12 Jul 2024 14:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720793318;
	bh=ow9AJ//jVwfGZhSB8AYloU9hYnkv2FQyvwvJeG3Nqb8=;
	h=From:To:Cc:Subject:Date:From;
	b=qwhnwjHe/bs9hFRqPBA5OcGzX/+Ph3eCc2+KHYf3Ln0cdqVHqUh0Uj4z+OkdzJepN
	 pelVzaV+IbazGfsjf89t67zvzw2n0CyAP2eL2IQ2HBCB803pjx2xqYgtl41w70fxkd
	 pykJ9PL+oAVz5aOxXpew8ycct/bo2+Zm3pmDOEHtnGlhgv4NaxDOSqsczCOhV6z2SK
	 2r3iDRg8Lxr0tABGbLmqXv9Y/HKshe0otW1PUhLruxFqwRBF9fsAH+1hruxT/06xZi
	 td24v/o1hl7FJDSH/Y3UdsObYXGqm3tlUrkq7+AfouLAcTKo4HhFas1N0RbLbzxZ1r
	 nlgZ2SKiERTKA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1sSGwv-000000006KB-2TJT;
	Fri, 12 Jul 2024 16:08:38 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v3 0/3] soundwire: bus: suppress probe deferral errors
Date: Fri, 12 Jul 2024 16:07:58 +0200
Message-ID: <20240712140801.24267-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.44.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The soundwire bus code is incorrectly logging probe deferrals as errors.

This series addresses that, cleans up the soundwire bus logging and
drops the unused soudwire driver name field.

Vinod, I booted linux-next yesterday and realised that these bogus error
messages are still spamming the logs when booting x1e80100 and making it
harder to see the valid warnings (which there were too many of). Would
be nice to have this fixed in 6.11:

[   18.815950] wsa884x-codec sdw:4:0:0217:0204:00:0: Probe of wsa884x-codec failed: -517
[   18.825093] wsa884x-codec sdw:1:0:0217:0204:00:0: Probe of wsa884x-codec failed: -517
[   18.832335] wsa884x-codec sdw:4:0:0217:0204:00:1: Probe of wsa884x-codec failed: -517
[   18.840870] wsa884x-codec sdw:1:0:0217:0204:00:1: Probe of wsa884x-codec failed: -517
[   18.848463] wsa884x-codec sdw:1:0:0217:0204:00:0: Probe of wsa884x-codec failed: -517

Johan


Changes in v3
 - amend the update status error message with "at probe" to make it more
   descriptive (it's already unique)
 - drop the patch dropping a probe debug message

Changes in v2
 - drop probe error message completely
 - drop soundwire driver name field
 - cleanup probe warning messages
 - drop probe debug message

Johan Hovold (3):
  soundwire: bus: suppress probe deferral errors
  soundwire: bus: drop unused driver name field
  soundwire: bus: clean up probe warnings

 drivers/soundwire/bus_type.c  | 19 ++++---------------
 include/linux/soundwire/sdw.h |  2 --
 2 files changed, 4 insertions(+), 17 deletions(-)

-- 
2.44.2


