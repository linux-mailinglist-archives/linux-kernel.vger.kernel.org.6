Return-Path: <linux-kernel+bounces-422379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22AB99D98D8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 14:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04E3164267
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 13:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AF31D47C6;
	Tue, 26 Nov 2024 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="IAy4dB/A"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CAB193408
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 13:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732628967; cv=none; b=SSo/VsN3oEEq8InQlXSszMPpbRf65Ttp623wF/z5zlyXpuWUZ2Japg7bKN5CmsmggjDQDpVhV9XDnYhJCNjF/WTrimVlV9QAsewP7/toJv5sBBfbyKhPuvx8t7jKVQ/rWPt00XFgDL6uKz9T+8K51E2aH9BXm4jEqZca+xVcKD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732628967; c=relaxed/simple;
	bh=/bHQSrmFHKmitzV01woswDDbRYL9+kEc1S4HKQwpKqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t+B+uY4JMSg8mY0Z/hYb9dinq+5PMVVTuZqoDlpxqO1urXCiZIBHlvyJvrCRyitm4iynSh/cCF/OylI0YjY5KQHCwuFuZjdku6KJ1yZIU7Nz7IlY9d0MGySiFEsKQWf6i0aHzrsWOL2eUvdRouM0kJDLU///8T464/EtkWU86FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=IAy4dB/A; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQAkC7G030121;
	Tue, 26 Nov 2024 14:49:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	KedC3Z5LX9M+kf2Kz31pt6fO9ebLyhuhZY7jHYfTaKs=; b=IAy4dB/ABkVSrzev
	tslooVYtSHlNNxjrR23jOIp+EUUpR+oNbdFp2B71QszuJyELbyI/e4AAqRRPJO3t
	Nsgtko+n0KyMkyxZyDAJiiktd2oGDT41/5+Mjc2KmPeorbF2C/JZ6c2bSg+hzFPc
	8fXtLYjwsolp49kKUp4ysvUzzAXoa8IMtoP0HDtVJcQ4MAe2rLt5rhYYDkmX1pI1
	zvMAPyMW6RpnvdVCavgYNKl8eJbLqeq3ppMB+Tve98c5C4vKZEGp/MLD+9zF0/VX
	LKhlnNzaPPgHwAMZwRyXxgx6riNp09KQAV7S9JeMI5dV9VGCU7TrTzbqyA6schGq
	lrQtNg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 433791wapk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 14:49:05 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 2740C4004A;
	Tue, 26 Nov 2024 14:47:49 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 36599288B75;
	Tue, 26 Nov 2024 14:46:11 +0100 (CET)
Received: from [10.129.178.23] (10.129.178.23) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 26 Nov
 2024 14:46:10 +0100
Message-ID: <ed43f2f4-40f5-41c9-80ea-9470a1395195@foss.st.com>
Date: Tue, 26 Nov 2024 14:46:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/sti: Add __iomem for mixer_dbg_mxn's parameter
To: Pei Xiao <xiaopei01@kylinos.cn>, <alain.volmat@foss.st.com>,
        <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
        <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <--to=lkp@intel.com>
CC: <ville.syrjala@linux.intel.com>, kernel test robot <lkp@intel.com>
References: <202411191809.6V3c826r-lkp@intel.com>
 <c28f0dcb6a4526721d83ba1f659bba30564d3d54.1732087094.git.xiaopei01@kylinos.cn>
Content-Language: en-US
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <c28f0dcb6a4526721d83ba1f659bba30564d3d54.1732087094.git.xiaopei01@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01


On 11/20/24 08:21, Pei Xiao wrote:
> Sparse complains about incorrect type in argument 1.
> expected void const volatile  __iomem *ptr but got void *.
> so modify mixer_dbg_mxn's addr parameter.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202411191809.6V3c826r-lkp@intel.com/
> Fixes: a5f81078a56c ("drm/sti: add debugfs entries for MIXER crtc")
> Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>

Hi,

Applied on drm-misc-fixes.

Thanks,

RaphaEl Gallais-Pou


