Return-Path: <linux-kernel+bounces-533481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F85A45B26
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 11:05:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2CE53A915E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 10:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FE123816F;
	Wed, 26 Feb 2025 10:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="QusQmhNj"
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com [91.207.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C5A1DC997
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 10:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740564302; cv=none; b=pGqux9pWOqwSvzf9KQmEdS61rrwEepCwg3oitxypEDA2bcBLZfYrQuvDTIy58H/6tlZpvkyxbBGOTQGGaEv8zL5Ha1kpzJRCQP5eOzj+yMU8QrYEgS85aTwBt9Bhtw2Qb8+3XW2DclSBPyd1wwK4tj7e+6suQOp9+b1itQD48fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740564302; c=relaxed/simple;
	bh=lkXvFAFJ4LrxyJ5nie3SWbPFgwf9r/hzAHjEEMlbhE0=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=BWUsy2xbmMk6DKwXukHxNWU6SgqWIiZu3oMksbCIfR6E5j0iO0W8iO/txnJX3xyeakYlXWWwvCgRplUCZFIiXTSgA+y+7qUwjxcYO6t8XulyO894J31Knu8uegCYdhSEZ8N0/em4izucegld7Wrqb2zm+N3zOvWRmGwz9WTqr2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=QusQmhNj; arc=none smtp.client-ip=91.207.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
	by mx08-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51Q7M4FB010391;
	Wed, 26 Feb 2025 10:04:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=H
	NeVkcyhJTDYPqzpSDY2qxIpZaWs6DnKv2b1WJOnJt4=; b=QusQmhNjZGkf2LIws
	xzW3CJIVDf8kwQ5BZZ8n2ZgY+pnGsEdWjdfeo7iVK/PzAcgCSMAkaVMZqEzqMem7
	Ga7o8JyeByu+9p8+aU7fGMbuQUvvRFww52ZHyiyhaOTDtIGeGGDMvJh9Y75cuH0z
	wUxbJQfmF+cvOVRvZthb+aQ+xgHuhi3lFPauc0y0HaUYmixwXLwD/Ze5uXHNp6Yv
	OAxhAWo8BpLhoQ2LQCpipuVO36nplFng8KQhf8BNsoptRKr/jugfrfKV+Dk8mxCi
	ilVV8seRBcMlGKlsjeOZEv/Jd09/o5/DUs9gi7+9HA6Do7VwoXc229P6+I5Q5ijC
	ynmmw==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 44y5qxass2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 26 Feb 2025 10:04:32 +0000 (GMT)
Received: from Matts-MacBook-Pro.local (172.25.7.33) by HHMAIL05.hh.imgtec.org
 (10.100.10.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 26 Feb
 2025 10:04:30 +0000
From: Matt Coster <matt.coster@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Masahiro Yamada
	<masahiroy@kernel.org>
CC: <linux-kernel@vger.kernel.org>, David Airlie <airlied@gmail.com>,
        "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
        Thomas Zimmermann
	<tzimmermann@suse.de>,
        <dri-devel@lists.freedesktop.org>
In-Reply-To: <20250210102352.1517115-1-masahiroy@kernel.org>
References: <20250210102352.1517115-1-masahiroy@kernel.org>
Subject: Re: [PATCH] drm/imagination: remove unnecessary header include
 path
Message-ID: <174056427082.17179.5057304555659162001.b4-ty@imgtec.com>
Date: Wed, 26 Feb 2025 10:04:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-EXCLAIMER-MD-CONFIG: 15a78312-3e47-46eb-9010-2e54d84a9631
X-Proofpoint-GUID: B7ua5HpXOp3VEP3ICcYKjWDxBZznJFv_
X-Authority-Analysis: v=2.4 cv=OLPd3TaB c=1 sm=1 tr=0 ts=67bee730 cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=V9sbW7EuxLoA:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=r_1tXGB3AAAA:8 a=5yNAjN4o7YE2XUz26QkA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: B7ua5HpXOp3VEP3ICcYKjWDxBZznJFv_


On Mon, 10 Feb 2025 19:23:50 +0900, Masahiro Yamada wrote:
> drivers/gpu/drm/imagination/ includes local headers with the double-quote
> form (#include "...").
> 
> Hence, the header search path addition is unneeded.
> 
> 

Applied, thanks!

[1/1] drm/imagination: remove unnecessary header include path
      commit: 2e064e3f3282ec016d80cb7b1fadff0d8e2014ca

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>


