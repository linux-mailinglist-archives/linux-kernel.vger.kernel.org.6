Return-Path: <linux-kernel+bounces-350856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B39D9990A8C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC0931C21112
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 18:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1DF823DF;
	Fri,  4 Oct 2024 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cEBnjt3C"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798371E377B
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728064884; cv=none; b=SgGBmUKV44hw3EyMVYWBA0/Z84nUpaWbCz3dy6SYKulJvTcQODFn72w8AmFz2IAU4mEUeUVGYUviLhKK0HREWv8TwNCeT4QeZTz7/lkdFKwDE87wXlup3VR9TI+WEHPuRXBh8A3J/Yfr+dAN4ll0JvJ6ah3ma2xMAtlEhsAvyIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728064884; c=relaxed/simple;
	bh=uWPZ3ufbC/wfGebvblqb3Mr0rz7AR9cnbkpxqvS2umE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gdz6TtWgahhUbAFHG+A+Wlyik75HUkNqlOsDaCsoOSK0RJsPDDQh2doPCa6Otz1W89aT1gkL5kOX9SWal9L/ikNd7ABqM+oQWjDuboXaQGzajb7GPlppj0jenRmSraBSdOX3VK4SqxP4JOMz9Z9W/PqQYIBbgdKNUq3hClBrt4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cEBnjt3C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494APai9029115;
	Fri, 4 Oct 2024 18:01:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	qWeHTzzr5dKEVUmcLYSOmzmVGfE/02KwSjMavnSpS8w=; b=cEBnjt3CsOcpyUg6
	g4oW1gkoeaQwbijs3SxX7cHQK8NDnHVIbl/9egJKaARbde0m8Qr3vo84p75BuLKs
	7/jqPQrWsipJT7nl/rdChKz9VYtFZcVVM6t9KYiXgkesWS4knSmiaE2rtLJ8z2Mx
	kd2ZA9HDZMkNzVOzEtbcBiKNP5/GQtQHIC8so6dNAjj0d+rMciif8RRzo84xf+ER
	0ZqcYxwbLNwqiaXfn3a224zaC/C5tNLXxJf1QHQA+JbV0U2bKFMkKoO5mOSGrL9E
	46hMmRfh2fG6ycXHaXuZUwOn+XevTwEMSjk3L+61eiU30ZFbm9hHeHxmtq77afZ+
	QrpgIw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42205hawq4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 18:01:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 494I1H3f003827
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 4 Oct 2024 18:01:17 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 4 Oct 2024
 11:01:17 -0700
Message-ID: <8549424d-bd22-8308-c661-c2ef13cdc441@quicinc.com>
Date: Fri, 4 Oct 2024 12:01:16 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH V3 07/11] accel/amdxdna: Add command execution
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, <ogabbay@kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC: <linux-kernel@vger.kernel.org>, <min.ma@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <king.tam@amd.com>
References: <20240911180604.1834434-1-lizhi.hou@amd.com>
 <20240911180604.1834434-8-lizhi.hou@amd.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <20240911180604.1834434-8-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2cBXhKe3-JPb7Mob1bWJOBauxhG2eP64
X-Proofpoint-ORIG-GUID: 2cBXhKe3-JPb7Mob1bWJOBauxhG2eP64
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=723 phishscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040124

On 9/11/2024 12:06 PM, Lizhi Hou wrote:
> +enum amdxdna_cmd_type {
> +	AMDXDNA_CMD_SUBMIT_EXEC_BUF = 0,
> +	AMDXDNA_CMD_SUBMIT_DEPENDENCY,
> +	AMDXDNA_CMD_SUBMIT_SIGNAL,
> +};
> +
> +/**
> + * struct amdxdna_drm_exec_cmd - Execute command.
> + * @ext: MBZ.
> + * @ext_flags: MBZ.

I see a check for ext_flags, but not ext

> + * @hwctx: Hardware context handle.
> + * @type: One of command type in enum amdxdna_cmd_type.
> + * @cmd_handles: Array of command handles or the command handle itself
> + *               in case of just one.
> + * @args: Array of arguments for all command handles.
> + * @cmd_count: Number of command handles in the cmd_handles array.
> + * @arg_count: Number of arguments in the args array.
> + * @seq: Returned sequence number for this command.
> + */
> +struct amdxdna_drm_exec_cmd {
> +	__u64 ext;
> +	__u64 ext_flags;
> +	__u32 hwctx;
> +	__u32 type;
> +	__u64 cmd_handles;
> +	__u64 args;
> +	__u32 cmd_count;
> +	__u32 arg_count;
> +	__u64 seq;
> +};

