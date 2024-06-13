Return-Path: <linux-kernel+bounces-213335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAD5907429
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 15:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD361B266F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC79F143C5F;
	Thu, 13 Jun 2024 13:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="I5kJt75h"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0BF1448D8;
	Thu, 13 Jun 2024 13:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285878; cv=none; b=ERN26E+S3v8jABa2dr4GodBfJpb1dvwVL+ZC27eUJmX7/rd/4HguGHQPqirHBxU4eaTIdmUvlWZE15pnbHfj2TZsWex8Y7mptkrg9ze1WyZygfw8ecTcc1S6eBRzDd+tCR/fuGbTk1vMyQE/6J9zjVvllXifoakhZHE0yjgq1pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285878; c=relaxed/simple;
	bh=FktdJ3dpxYgLwv3mOnNq66XfSBNmbtiWt8nu4ZUssjU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f4bRwUogMH0OW7rCRIsX/M3BWl0K7+4ZFxFOtegHnvvjrQOr6SjTrDKAIwUONK5GeYKy6VDMoriK5mhai+RWOMNQEGxK0GC9rNQD4GofBSC42hGd7+mYsC9yntA+/TW2zHX4oqwJInsaoYA6q147UWhrWPpiIvrw1iHnWjIGdyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=I5kJt75h; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45D5pN0K001648;
	Thu, 13 Jun 2024 08:37:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=QtBgSUb0MZHTNV1Q
	4UZmYBvp+K84oqTEqIP2wfhcxF8=; b=I5kJt75hgkxNUT5w2+y9mbI+3srSVPnn
	5lGCOpM0W8bscHn4p50FWaiOq0Px2AD0ebeWwcdwSC+dauRsdwDkciyKGKto/Q4v
	hpMW3RGakWl4l33O2BBhrVlnH+SAsBki/wGxfl8fFT6B1Iv4/SCpc89/n+6VkEnJ
	wLGtwUZ3JlITtJXnJP8+v/1fR/7xQMUOmiSmdfpUuZWbqUo9IsKvJMCwXQNWk59n
	I9rsVShN84EsNLjE7UCLnrZxxSFljYeMJnTFaSkDljmc7Y5T/HXqxNO2D3NtC2fg
	12sgdfI00spZ7uT2u3tPTmfgZ19fZ/isZGx8qyigEgUTZvNksZZ0OQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3yqskgreuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 08:37:40 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 13 Jun
 2024 14:37:38 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Thu, 13 Jun 2024 14:37:38 +0100
Received: from EDIN6ZZ2FY3.ad.cirrus.com (EDIN6ZZ2FY3.ad.cirrus.com [198.61.65.41])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 8F38A820248;
	Thu, 13 Jun 2024 13:37:37 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <soyer@irl.hu>, <shenghao-ding@ti.com>, <kevin-lu@ti.com>,
        <baojun.xu@ti.com>, Simon Trimmer <simont@opensource.cirrus.com>
Subject: [PATCH 0/3] ALSA: hda: Component should be unbound before deconstruction
Date: Thu, 13 Jun 2024 14:37:10 +0100
Message-ID: <20240613133713.75550-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: fSH1mpGTINbxL0twFSmqDta3asQgSHwc
X-Proofpoint-ORIG-GUID: fSH1mpGTINbxL0twFSmqDta3asQgSHwc
X-Proofpoint-Spam-Reason: safe

Small chain of fixes to correct hda drivers using the hda component
infrastructure so that they unregister their component before proceeding
to deconstruct the driver.

These three patches been separated from the chain "[PATCH v2 0/7] ALSA:
hda: Improvements to hda_component"

Simon Trimmer (3):
  ALSA: hda: cs35l56: Component should be unbound before deconstruction
  ALSA: hda: cs35l41: Component should be unbound before deconstruction
  ALSA: hda: tas2781: Component should be unbound before deconstruction

 sound/pci/hda/cs35l41_hda.c     | 4 ++--
 sound/pci/hda/cs35l56_hda.c     | 4 ++--
 sound/pci/hda/tas2781_hda_i2c.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.34.1


