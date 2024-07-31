Return-Path: <linux-kernel+bounces-268934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A31AB942B4C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA275B21EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ED31AAE06;
	Wed, 31 Jul 2024 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IBMXOKwL"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B8A1A7F7B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722419714; cv=none; b=ElPqZNarEScIQG/DqNcX+LtPC38vSl6kqNztfNE78f+ryCnlycz3EiZceB1mlGe44YbSq95nPX3cHZfnG1YWySv0p06Njj4dOOaUCzZuJ5ojHs91lehExZqzi4f8ci407dDpdgJQEJT6GPTZieBueRU5CbjT4e8C5zfaSC10Odo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722419714; c=relaxed/simple;
	bh=0B3C9JxxjcgQfOHs2SgS0HcTOQnZaqkotYxhOGjlBRQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VwtIaWZs/K470hwv5okdCiO+YmRla9ZgWDchXFvA5BzFafYxGyCiDxvh5E2T6iAxABx4tEccwBB4RrL+TxujxG+QWaaj7dgGJUZaGf8Hl+pL78mnfxk4jaNsh9nCvTYK1sDWeqmhnOerTRp51xPCGswF+aYjPptHv2+n7oIMmRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IBMXOKwL; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722419713; x=1753955713;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0B3C9JxxjcgQfOHs2SgS0HcTOQnZaqkotYxhOGjlBRQ=;
  b=IBMXOKwLnGoPQ20mshdAkC9KDQXqNZaBBoU4FtjiLSEjZojx+yT+kVyD
   TyUXkAz/12QdJ+NFZHuzQplFhrf7y0uDFjlZSmJxB3vSvRKv3pmehi7eU
   RqdcbjyVcJh79vUbmSCEktbWYkt3CjzCMRM3gpke3tZQP0BCxHGeWYqvu
   1ac152P5CupbmKlHxjn88h72UvZq3fvt3Qx2FG3MmvcF/z/BCCUlR6/4p
   qSAo45qe1d5wjwAMkTjKWQ3AhCWfxDKHFSqN9pJhEgfeNNg2AnO0Xx7NO
   SiSxebuEHa6lJOQ+jFS7kqyayRD2JUKnL9/mXtHmN9B6FCY/yUBbhzGgJ
   A==;
X-CSE-ConnectionGUID: WVfwLa2kTEOgItdP97sJxg==
X-CSE-MsgGUID: QkGha9nvQ4yCPzdCerf3kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11149"; a="20469373"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="20469373"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 02:55:13 -0700
X-CSE-ConnectionGUID: PmnEOhUlSl66HvTN+auPVA==
X-CSE-MsgGUID: GZmV5F3uTc+QMTGzSpxfAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="54518666"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.118])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 02:55:11 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] comedi: adv_pci1710: Simply for (; cond;) to while (cond)
Date: Wed, 31 Jul 2024 12:55:02 +0300
Message-Id: <20240731095502.2930-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci1710_handle_every_sample() has a for () loop that only defines
condition so it can be converted to while () which makes the code
easier to follow.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/comedi/drivers/adv_pci1710.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers/adv_pci1710.c b/drivers/comedi/drivers/adv_pci1710.c
index c49b0f1f5228..f20399fcc98a 100644
--- a/drivers/comedi/drivers/adv_pci1710.c
+++ b/drivers/comedi/drivers/adv_pci1710.c
@@ -412,7 +412,7 @@ static void pci1710_handle_every_sample(struct comedi_device *dev,
 
 	outb(0, dev->iobase + PCI171X_CLRINT_REG);
 
-	for (; !(inw(dev->iobase + PCI171X_STATUS_REG) & PCI171X_STATUS_FE);) {
+	while (!(inw(dev->iobase + PCI171X_STATUS_REG) & PCI171X_STATUS_FE)) {
 		ret = pci1710_ai_read_sample(dev, s, s->async->cur_chan, &val);
 		if (ret) {
 			s->async->events |= COMEDI_CB_ERROR;
-- 
2.39.2


