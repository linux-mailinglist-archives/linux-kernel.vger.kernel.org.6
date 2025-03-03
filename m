Return-Path: <linux-kernel+bounces-541686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6934A4C017
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 13:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 987AA3A7BC8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 12:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DA520DD49;
	Mon,  3 Mar 2025 12:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b="rz/GZhXy"
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com [185.132.180.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89341DE3D6
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 12:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.180.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741004314; cv=none; b=FBcbRxfVk8z+k9KX32c1z21gaK/h2HA36umq1+9SYSkvLp8tWqNtMLiFjePGBNRYQ57Le+Us/QpqazDGC2ie4ngJsZyUWo1TJvdtOpQ8gLfIATHP4T8pKGe10bfiQs79rlGqnfcCWJln4dee2/9Z2kbbSG3sbki/85MG7Jrjn+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741004314; c=relaxed/simple;
	bh=Z9XhnRddREALCKPlkrclKfvDLiwpE2VI73c8TcUKDeU=;
	h=From:To:CC:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=IwNHfr+0U6QnV5jT4hiKst8TxgevWj62pm07RbzrHFETRpENK/xynUz+MWKyB2niN0/vMl/tjpCCzxQjLQqx5o1lw5qwFKtGJ+l2opZfM1YfoCVgfWr6AXf5OESu+YAcutAdG579v5n8lZrixqbSGwZ9i6JAPHFF+KsSb5pjiIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com; spf=pass smtp.mailfrom=imgtec.com; dkim=pass (2048-bit key) header.d=imgtec.com header.i=@imgtec.com header.b=rz/GZhXy; arc=none smtp.client-ip=185.132.180.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=imgtec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=imgtec.com
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
	by mx07-00376f01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52366LPT030025;
	Mon, 3 Mar 2025 12:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=dk201812; bh=I
	ACcxyKg7TW1vKNpcncfde9wIFZQNcBnyTKlGa9d23M=; b=rz/GZhXyOdw86R0qr
	SlmjMILVOlWpcNsnblhWkzL/9WI0C5ALtgxInILRzpZxv9+23RVB5wFq4qOcMwfs
	MtIIvExJAPo+nwG2zy0WLze+rterJ7infujy+z/LMB8OozLA6G6p2E9JKhMtFMoi
	8Ip9Xf8VzTLShRoxEGEYjsOgbfroyLZcQtJk5WJfjhH/seryPU5TNr3I7camaAaB
	0Cb148WNrrEXkhjJu7l3LiPw+5MOEbWzwOvb+1xLS5R8Wd/9VhPS+5j/kqH1PjmL
	3ajnCYpWCjGvvhWjU3a1z2lCXJvcyv2wXxK/B0k/b4eDXRicaVKfmFqo8Syx2mnM
	aPJQA==
Received: from hhmail05.hh.imgtec.org (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
	by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 453u711fgx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 03 Mar 2025 12:18:18 +0000 (GMT)
Received: from Matts-MacBook-Pro.local (172.25.8.157) by
 HHMAIL05.hh.imgtec.org (10.100.10.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 3 Mar 2025 12:18:16 +0000
From: Matt Coster <matt.coster@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>,
        Alexandru Dadu
	<alexandru.dadu@imgtec.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Alessio Belle <alessio.belle@imgtec.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20250221-fix-fw-trace-timestamps-v1-1-dba4aeb030ca@imgtec.com>
References: <20250221-fix-fw-trace-timestamps-v1-1-dba4aeb030ca@imgtec.com>
Subject: Re: [PATCH] drm/imagination: Fix timestamps in firmware traces
Message-ID: <174100429775.48500.17495795495631967155.b4-ty@imgtec.com>
Date: Mon, 3 Mar 2025 12:18:17 +0000
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
X-Proofpoint-GUID: TpCqr_jqam6nbrfmskjOPEz6n61kqCLe
X-Authority-Analysis: v=2.4 cv=LrJoymdc c=1 sm=1 tr=0 ts=67c59e0a cx=c_pps a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17 a=LHZ2_XVCwAsA:10 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=r_1tXGB3AAAA:8 a=C5DFhOZCARBVFH9tFowA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-ORIG-GUID: TpCqr_jqam6nbrfmskjOPEz6n61kqCLe


On Fri, 21 Feb 2025 10:49:35 +0000, Alessio Belle wrote:
> When firmware traces are enabled, the firmware dumps 48-bit timestamps
> for each trace as two 32-bit values, highest 32 bits (of which only 16
> useful) first.
> 
> The driver was reassembling them the other way round i.e. interpreting
> the first value in memory as the lowest 32 bits, and the second value
> as the highest 32 bits (then truncated to 16 bits).
> 
> [...]

Applied, thanks!

[1/1] drm/imagination: Fix timestamps in firmware traces
      commit: 1d2eabb6616433ccaa13927811bdfa205e91ba60

Best regards,
-- 
Matt Coster <matt.coster@imgtec.com>


