Return-Path: <linux-kernel+bounces-246089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8073492BD79
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B37A289D38
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C7519CCFE;
	Tue,  9 Jul 2024 14:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="P6XIFkDF"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A6E1E864;
	Tue,  9 Jul 2024 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536738; cv=none; b=e3ENGJtFPiqlAFXSvFo6cp6ixOkTmHHlkgiYJ5Pc+zTsUz0CJ8ECMhuFLgr4yzcFl1o+lB20fXYyKtCBMBkIoOlIuyqLNaS9MJ1sJ7Z59pVolf8RSrMMbffSRysGKlC501NWDUoiEiK9giMXWj13ge4wMV/iVf1k1OCTtXqeYJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536738; c=relaxed/simple;
	bh=MR706r9bLwg1kUgwL9MzfqWo4JfFZnbjwXcQ31JA2kc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DXIpvaGNdD40FFfjpVEI+jt4PoPfvaz+ccvFL/3gKNjicbP1DorwoR5NOr1/tUBQhw38zRKQNisv2uoVuu8GmJvdab7HamGvHuGLrbx3+yYEZ+JBmQy34WXPIlO9moON4V8Dkg4YMp/ZQLrbjWvilfNBCbShnE1smzKoi4mrTrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=P6XIFkDF; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4699TeIa016166;
	Tue, 9 Jul 2024 09:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PODMain02222019; bh=2astjUORRu3bICmB
	shlYDX/v1GBiyMqqTFXMnbBfoLo=; b=P6XIFkDFH5YqHQW3oJ6LlSWPeIa+k5l+
	dl0CqOjzDSO2prXWV0thmc9F3vv/GS9vLLdrexxnRIjEKpRU7+gJV9/OvN44R0Ta
	+ZZNORdt8RTS+Mnh9bUoZWbMGtBSunB2rggcVm1Bj7+Fw1xLXdltIhAG7fJG6NUu
	3qaymwh4I23xsm6DDO1GEeK/3iHJnGWitsn5Hl1NhlUf+n8S1ZXzLFZbMkwAqG91
	KzFkRGf9mvW3HoTgDzGU3ezT3BRRinkrHQRob2KvxL3hd7VKdDu7GO792sdBByD7
	oxoWme4Q7ywHhU85u2T8F93gK1GWLqiCHMprB30l168dzbzDmAvlYQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4073axtqje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 09:51:59 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Jul 2024
 15:51:57 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Tue, 9 Jul 2024 15:51:57 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id E3BC1820244;
	Tue,  9 Jul 2024 14:51:56 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH 0/4] firmware: cs_dsp: Some small coding improvements
Date: Tue, 9 Jul 2024 15:51:52 +0100
Message-ID: <20240709145156.268074-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: oKq_uKdNqpJY3E0sieEU2OuMNcQGERy2
X-Proofpoint-GUID: oKq_uKdNqpJY3E0sieEU2OuMNcQGERy2
X-Proofpoint-Spam-Reason: safe

Commit series that makes some small improvements to code and the
kernel log messages.

Richard Fitzgerald (4):
  firmware: cs_dsp: Don't allocate temporary buffer for info text
  firmware: cs_dsp: Make wmfw and bin filename arguments const char *
  firmware: cs_dsp: Merge wmfw format log message into INFO message
  firmware: cs_dsp: Rename fw_ver to wmfw_ver

 drivers/firmware/cirrus/cs_dsp.c       | 64 +++++++++-----------------
 include/linux/firmware/cirrus/cs_dsp.h | 10 ++--
 sound/soc/codecs/wm_adsp.c             |  2 +-
 3 files changed, 27 insertions(+), 49 deletions(-)

-- 
2.39.2


