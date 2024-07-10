Return-Path: <linux-kernel+bounces-247449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EACA92CF90
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515391C2161C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEB5198841;
	Wed, 10 Jul 2024 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="hr2Col9X"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DA5197A6B;
	Wed, 10 Jul 2024 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607815; cv=none; b=I9mg4Oq6+3DzfrlHsxkv0c5L21RAT8wyZpi4v8MNycsMp0eLmSJEvY9UfqtnCJwj4G/diCHLXtS1OW+C1lG0nrgem6RxDv6n+Mq20ToGK0juDWjURawp+J+XSU++bMBhLgEJvj1WnXu+Fe7YJu0uR0vNZ7O7NW+EmWa8u07HXHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607815; c=relaxed/simple;
	bh=zF/m62KFHKl1kmqt/e6pzUb5JBWZP5A6EyAaMuq66Zw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPFtJhClkTHs/eUV5ErCjPH8WOPjMWhM/gavzwM8BcxlEut/9gHk48KZT1HKP3Fk62brQT2IPlgSti6PGQgj7jLHOlY9eFzEyIvyzglxPuXynARqAv2+kWH93xt9QH0DFI17pa+KFjceopjA1jsr7mqrxLrHMSlzVUGuRTyqI2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=hr2Col9X; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A4s4Gp006601;
	Wed, 10 Jul 2024 05:36:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=jko0pG9aWSLJku4a2f5zSYrs/rJboXoCk1FQ/DCAegY=; b=
	hr2Col9Xy6CMQG6iuIqeQVbhGIkibfGsHI+9WDF/OYy26ncDLuBpIY9Pv021cv/H
	zhwwCk2ygzCY/INIS87MQldUI/l+UXve/ZJBLu2NCEnq8uIBV5z/ylb/7pB45nuV
	I2z29A9gsKSxqVPZ9yt6shET0Azn7OAQ9RvfChybb511hobt5cbtY8oP+GQUnXxh
	U1J82950b/AKc+53rWb4GPW0oYMJ3hnUNA7ydjf2CYsXVj+fO/fILVsMFd+ZBK0P
	wzGs17XJfiJqG6HgxE8YJv3y2jyXP9NdgP/QBAKytopoyx1N+QSGslo1GEASeSJ6
	N41qeC7qkLOs6SlmLWaJfg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 409c9a8h0p-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 05:36:46 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 10 Jul
 2024 11:36:40 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 10 Jul 2024 11:36:40 +0100
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 79866820258;
	Wed, 10 Jul 2024 10:36:40 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
Subject: [PATCH v2 3/4] firmware: cs_dsp: Clarify wmfw format version log message
Date: Wed, 10 Jul 2024 11:36:39 +0100
Message-ID: <20240710103640.78197-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240710103640.78197-1-rf@opensource.cirrus.com>
References: <20240710103640.78197-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VByPUurzjj4azDBKUwiZFAqV67xWOHV9
X-Proofpoint-GUID: VByPUurzjj4azDBKUwiZFAqV67xWOHV9
X-Proofpoint-Spam-Reason: safe

Change the log message of the wmfw format version to include
the file name, and change the message to say "format" instead
of "Firmware version". Merge this with the message that logs
the timestamp.

The wmfw format version is information that is useful to have
logged because the behaviour of firmware controls depends on
the wmfw format. So "unexpected" behaviour could be caused by
having expectations based on one format of wmfw when a
different format has been loaded.

But the original message was confusing. It reported the file
format version but didn't actually log the name of the file it
referred to. It also called it "Firmware version", which is
confusing when a later message also logs a firmware version
that is the version of the actual firmware within the wmfw.

The logging of the firmware timestamp has been merged into this.
That was originally a dbg-only message, but as we are already
logging a line of info, we might as well add a few extra
characters to log the timestamp. The timestamp is now logged
in hexadecimal - it's not particularly useful as a decimal
value.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
Changes since V1:
This is a completely different commit from the original V1 #3.
The V1 commit merged the wmfw format version message into the
INFO_TEXT message.
The V2 commit keeps the wmfw format in its own message but
clarifies the message, and merges it with a trivial message that
logged the header timestamp.
---
 drivers/firmware/cirrus/cs_dsp.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/cirrus/cs_dsp.c b/drivers/firmware/cirrus/cs_dsp.c
index 1bc2e0b6d40b..cce81a3f68f9 100644
--- a/drivers/firmware/cirrus/cs_dsp.c
+++ b/drivers/firmware/cirrus/cs_dsp.c
@@ -1502,7 +1502,6 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 		goto out_fw;
 	}
 
-	cs_dsp_info(dsp, "Firmware version: %d\n", header->ver);
 	dsp->fw_ver = header->ver;
 
 	if (header->core != dsp->type) {
@@ -1526,8 +1525,8 @@ static int cs_dsp_load(struct cs_dsp *dsp, const struct firmware *firmware,
 		goto out_fw;
 	}
 
-	cs_dsp_dbg(dsp, "%s: timestamp %llu\n", file,
-		   le64_to_cpu(footer->timestamp));
+	cs_dsp_info(dsp, "%s: format %d timestamp %#llx\n", file, header->ver,
+		    le64_to_cpu(footer->timestamp));
 
 	while (pos < firmware->size) {
 		/* Is there enough data for a complete block header? */
-- 
2.39.2


