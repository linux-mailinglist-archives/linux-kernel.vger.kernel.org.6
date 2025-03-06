Return-Path: <linux-kernel+bounces-549468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24267A552F0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 18:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06D5D1764AE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5602526BD93;
	Thu,  6 Mar 2025 17:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Eo2UUSmp"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2767A269B0D;
	Thu,  6 Mar 2025 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741281747; cv=none; b=Lv3vSVpBU+FgEA7YtevfiqKiBVi7mGeyRzXrIb4h0kqjvz74HaQAs8WZt1moeuAgvlk6ql/IcZHITG4PAdm05KWHUdVUNDXawjh1/Lcyyap3DbO8YA5lsQd1O5rMet9SilzGD3CuF+9G7QGBxzXTfJqAJ5nxQWzTmHnDQWpLAsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741281747; c=relaxed/simple;
	bh=08P9t7z+0iaP9AReeQLGEWl2CRs3dzKlUMMTS6H0ozA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EGiMvGUrl8FyEPE3eMNZ9bImkcBI68TWdoeyCf39rvzp8SOs7VLWcT5g+QND0ehzac1+eotQ17eILzkTWUqdpFer6NLXptaS9TTiRiW6qqBnJPKvUHtS8lFAMrQD7Wz1dlwLSIoQuC6WfZHtkiVcF1CUasPKMEwZbnA+kwIKl2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Eo2UUSmp; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526Gv4Kt023582;
	Thu, 6 Mar 2025 18:22:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=/PPklAG6geLL4eMw+nR29j
	qi4fEzvDe416XEvTDGmSE=; b=Eo2UUSmp+fVNGsZtxD8V8W4f7Vy6WVfo6f+WRo
	o15jxIH47UHALSR9amF2Im5ysPL0Qgr1dm+ehWepJCjCO6PLwlQj9uYTKx150S8b
	IcasYSg/cRIvpnJxm2ro8yeZIX7IYulmcgBDvHs6UuQXPFnxqxS0sUppQ/t8k/26
	hKV9us0mxfCD2Rn/BB+xyCEF6J6CQIyUD7dMBQGiiGEj1uh6OWcz/5ubvCx2R8C5
	zIz+za0EzaiAJuM3CaNvCpzmBVqns2dQJAktseFrQYWv1oF5hcPPzA6wSl68bFvK
	YlrrWW00ZnjtxYl/6uFLc7mnKrhH1IiGDc2spUf7Z+qNPqrw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 457dr0h88y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Mar 2025 18:22:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B1FB040078;
	Thu,  6 Mar 2025 18:21:30 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6A2895B9D6D;
	Thu,  6 Mar 2025 18:18:48 +0100 (CET)
Received: from localhost (10.252.22.44) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 6 Mar
 2025 18:18:48 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai
	<tiwai@suse.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
CC: Olivier Moysan <olivier.moysan@foss.st.com>, <linux-sound@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] ASoC: dmic: add regulator support
Date: Thu, 6 Mar 2025 18:18:38 +0100
Message-ID: <20250306171840.593443-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01

Digital microphones may be supplied by a regulator. Add regulator
support in dmic codec, to allow power management of the regulator
through the ASoC DAPM widgets.

Olivier Moysan (2):
  ASoC: dt-bindings: add regulator support to dmic codec
  ASoC: dmic: add regulator support

 .../devicetree/bindings/sound/dmic-codec.yaml |  3 +++
 sound/soc/codecs/dmic.c                       | 19 ++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)


base-commit: 989180be7182f518e3cc7c8057c6c23ffd6ddf47
-- 
2.25.1


