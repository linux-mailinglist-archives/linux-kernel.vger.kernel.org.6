Return-Path: <linux-kernel+bounces-244512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C75F892A54C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D7A31F218CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C7313D29A;
	Mon,  8 Jul 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="L/eUG8A8"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F98849C;
	Mon,  8 Jul 2024 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450828; cv=none; b=g5y8pjVbJ3eT5vYSy+NS45FD7tpG2vmMEYCKuMGzAQvhw/cw8/8hWF+zmZONDX/g6noCiXuTz1fbojmEHfxfVBi7muqftfnul2pXrpakZmZbMGoQ8UskxIgwnab9DRKCEXeJBKmIw5JpCTo+ssPNNE4os3b7ufH+LtOzkQFrqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450828; c=relaxed/simple;
	bh=GkJPSDPVlqWkpaY7O36uwo7fVzHGxLGGcvZQxBA2Hb4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=osh24IKx8MFKdpfcAQ/C9H6wdQ2JqpDF8xJLuLQWKly7+Z/Ba6mjOP9X5/DFusUFfBdLdcBw9bWc/NeWugDEZcVoBteBrUp5sDxKGO8ikEFdKSTCAl5iGI1hibdmH/hrm5yacEhgRc3F4n0I9t+m60vj3kKGu3P00av6wWchCb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=L/eUG8A8; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4685b6Vr018003;
	Mon, 8 Jul 2024 10:00:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=cvmmguTLgovTIrwesbPF/aWvLQBDAGZHlCL6dk/5Sa0=; b=
	L/eUG8A8gVOU81nEl+n2uyuBVMcM79jrgACyzVhP84xJuVlQPkZONrumw53p8zjP
	SNOg2iekxcAXD5QSLkVbdKKFibSXQYHjne4GNl4B0Z8SEJcgK26jNNLMVhjOHyZF
	yJY/LqN2ZcDskzYZoP40h8kPkohdMnlMkya4cEX/oV//Eg3P/Duj2jtKl9W+63/h
	3CLZB/Q4+evq+lvUg9o5WmO5+yVpbRFsMnEv0RnnREzxGsw62zrqKi25yV0lxp9H
	1EJIVmjHlrWW+b34Kc7d41WCnkvxA3EguhU5YUEDuh0TliWvUIfbuD28sGtHNylP
	ZSvOkf2A8Wutl0dtcUKkQQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4072bj9mfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 10:00:08 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 8 Jul 2024
 16:00:07 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 8 Jul 2024 16:00:07 +0100
Received: from [198.90.208.18] (ediswws06.ad.cirrus.com [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 37878820244;
	Mon,  8 Jul 2024 15:00:07 +0000 (UTC)
Message-ID: <de44f274-4e02-4c66-b784-41031e99c33e@opensource.cirrus.com>
Date: Mon, 8 Jul 2024 16:00:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: cs_dsp: Use strnlen() on name fields in V1 wmfw
 files
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
References: <20240708144855.385332-1-rf@opensource.cirrus.com>
Content-Language: en-GB
In-Reply-To: <20240708144855.385332-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: D4bEonTxS4WC1HX6qRWzBqepH8NnP1Oc
X-Proofpoint-GUID: D4bEonTxS4WC1HX6qRWzBqepH8NnP1Oc
X-Proofpoint-Spam-Reason: safe

On 08/07/2024 15:48, Richard Fitzgerald wrote:
> Use strnlen() instead of strlen() on the algorithm and coefficient name
> string arrays in V1 wmfw files.
> 
> In V1 wmfw files the name is a NUL-terminated string in a fixed-size
> array. cs_dsp should protect against overrunning the array if the NUL
> terminator is missing.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: f6bc909e7673 ("firmware: cs_dsp: add driver to support firmware loading on Cirrus Logic DSPs")

Don't take this. It applies to 6.11 but not to 6.10.
I'll try to sort out one that applies to new and old code, or
send separate 6.11 and backport versions.

Sorry about that.

