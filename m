Return-Path: <linux-kernel+bounces-443227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6529EE90B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDA9284782
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D42215178;
	Thu, 12 Dec 2024 14:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="Wt8IcLbu"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9567C215712;
	Thu, 12 Dec 2024 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014253; cv=none; b=ANzr1AOgPFrrC7zcs+SPPPzyG/BKwGHpnPjZipNWdL74glnfRvuGfmCZ4u520pyGMBv+2Xn4yA5k0kyhI6zBROgjQgnU7eBxpQ3mqtN8yShvY4I5DsNm47uUhFv1diHI9rkgJ42d2tz/pZev4J1dVWUqTVu2IGfpsAi+Ije0UP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014253; c=relaxed/simple;
	bh=78sWgZdBGxbod6547rPTQ2cocp/EFlBPa9w74OIyOk4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Oavgnr/pInVhCAsMpOoTUhcVAcsQH7B+Hb3gxv9SeG+YNjc/r1P4dgayZLkde5d4nqczkEG0I6ecDYjb2ljy3BkYQuxgl+2S3D1QsxXldCANmidYoLrkDBKlP+kYSDrKFgDK9QJZ/oYt0eBsyL+Tk2hw9J+HoTlBV1l8CEaCk8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=Wt8IcLbu; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BC5LAlm019383;
	Thu, 12 Dec 2024 08:37:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=Po7RT8svQWVGIYs1
	Oz3T/sjJTTfe7hulGCmY644+1MU=; b=Wt8IcLbua5MbjGO+oRpn6rC38cXLnb+R
	g6Z8h83Llw2YV2mPG/DvkJa79n3Ln+FN2g9H5DmXaCEWfE24ZI46ds6APWFCkFu/
	QKKkJVU73GHgC2Ulm1JytZFCgabLvMqXsHNCL7Z7xzS7LvLO4yKeFeg8/0L9diWY
	4aUAEjmFBNnFXcVaugbGzYNIrgKIkcaYMMV2Zn5f8GYyylXNNLhYkljFCCiBCyNY
	Tb7TEku+JtaSemx3arX8cZtgjy0Dh51F1ptbvEacjLVTJ1M8MbRkSvKJwhKPld7u
	4RQg3yIn83dxVdQ7HisaOWG9PEs81spYXkCn7KOe7c3v+rSZ1wvNzg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 43cknkexdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Dec 2024 08:37:26 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.13; Thu, 12 Dec
 2024 14:37:25 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.13 via Frontend Transport; Thu, 12 Dec 2024 14:37:25 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 1923A822541;
	Thu, 12 Dec 2024 14:37:25 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>
Subject: [PATCH 00/12] firmware: cirrus: Add KUnit tests for cs_dsp
Date: Thu, 12 Dec 2024 14:37:13 +0000
Message-ID: <20241212143725.1381013-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: gtMawPbcHSFLl0IBAREUkx617Wqk0g3b
X-Proofpoint-GUID: gtMawPbcHSFLl0IBAREUkx617Wqk0g3b
X-Proofpoint-Spam-Reason: safe

This series adds KUnit tests for the cs_dsp module.

Most of the functionality in cs_dsp is for downloading firmware to
DSP memory and interacting with "control" words defined in that
memory. This doesn't require any emulation of running firmware,
because it is only reading and writing registers. So the testing can
be done using a dummy regmap. The way this is used to perform testing
is described in more detail in the commit message for each test.

ADSP1 is not tested because this was only used by the WM2200 codec,
a long-obsolete part that was discontinued in 2015.

Richard Fitzgerald (12):
  firmware: cs_dsp: Add mock regmap for KUnit testing
  firmware: cs_dsp: Add mock DSP memory map for KUnit testing
  firmware: cs_dsp: Add mock wmfw file generator for KUnit testing
  firmware: cs_dsp: Add mock bin file generator for KUnit testing
  firmware: cs_dsp: Add KUnit testing of bin file download
  firmware: cs_dsp: Add KUnit testing of wmfw download
  firmware: cs_dsp: Add KUnit testing of control parsing
  firmware: cs_dsp: Add KUnit testing of control cache
  firmware: cs_dsp: Add KUnit testing of control read/write
  firmware: cs_dsp: Add KUnit testing of bin error cases
  firmware: cs_dsp: Add KUnit testing of wmfw error cases
  firmware: cs_dsp: Add KUnit testing of client callbacks

 MAINTAINERS                                   |    4 +-
 drivers/firmware/cirrus/Kconfig               |   20 +
 drivers/firmware/cirrus/Makefile              |    2 +
 drivers/firmware/cirrus/test/Makefile         |   23 +
 .../firmware/cirrus/test/cs_dsp_mock_bin.c    |  199 +
 .../cirrus/test/cs_dsp_mock_mem_maps.c        |  751 ++++
 .../firmware/cirrus/test/cs_dsp_mock_regmap.c |  367 ++
 .../firmware/cirrus/test/cs_dsp_mock_utils.c  |   13 +
 .../firmware/cirrus/test/cs_dsp_mock_wmfw.c   |  473 +++
 .../firmware/cirrus/test/cs_dsp_test_bin.c    | 2557 +++++++++++++
 .../cirrus/test/cs_dsp_test_bin_error.c       |  600 +++
 .../cirrus/test/cs_dsp_test_callbacks.c       |  688 ++++
 .../cirrus/test/cs_dsp_test_control_cache.c   | 3282 +++++++++++++++++
 .../cirrus/test/cs_dsp_test_control_parse.c   | 1851 ++++++++++
 .../cirrus/test/cs_dsp_test_control_rw.c      | 2669 ++++++++++++++
 .../firmware/cirrus/test/cs_dsp_test_wmfw.c   | 2211 +++++++++++
 .../cirrus/test/cs_dsp_test_wmfw_error.c      | 1347 +++++++
 drivers/firmware/cirrus/test/cs_dsp_tests.c   |   14 +
 .../linux/firmware/cirrus/cs_dsp_test_utils.h |  160 +
 19 files changed, 17229 insertions(+), 2 deletions(-)
 create mode 100644 drivers/firmware/cirrus/test/Makefile
 create mode 100644 drivers/firmware/cirrus/test/cs_dsp_mock_bin.c
 create mode 100644 drivers/firmware/cirrus/test/cs_dsp_mock_mem_maps.c
 create mode 100644 drivers/firmware/cirrus/test/cs_dsp_mock_regmap.c
 create mode 100644 drivers/firmware/cirrus/test/cs_dsp_mock_utils.c
 create mode 100644 drivers/firmware/cirrus/test/cs_dsp_mock_wmfw.c
 create mode 100644 drivers/firmware/cirrus/test/cs_dsp_test_bin.c
 create mode 100644 drivers/firmware/cirrus/test/cs_dsp_test_bin_error.c
 create mode 100644 drivers/firmware/cirrus/test/cs_dsp_test_callbacks.c
 create mode 100644 drivers/firmware/cirrus/test/cs_dsp_test_control_cache.c
 create mode 100644 drivers/firmware/cirrus/test/cs_dsp_test_control_parse.c
 create mode 100644 drivers/firmware/cirrus/test/cs_dsp_test_control_rw.c
 create mode 100644 drivers/firmware/cirrus/test/cs_dsp_test_wmfw.c
 create mode 100644 drivers/firmware/cirrus/test/cs_dsp_test_wmfw_error.c
 create mode 100644 drivers/firmware/cirrus/test/cs_dsp_tests.c
 create mode 100644 include/linux/firmware/cirrus/cs_dsp_test_utils.h

-- 
2.39.5


