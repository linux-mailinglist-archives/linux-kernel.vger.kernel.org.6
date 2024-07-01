Return-Path: <linux-kernel+bounces-237085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CFD91EAF4
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 00:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4EE4B21DCF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 22:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7593416EBE9;
	Mon,  1 Jul 2024 22:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZVFKj0fG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBC917BA1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 22:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719874095; cv=none; b=g1J3F6lgP/nRB/PllDHyqAmybO4r5/n4rIbPHcnAOpeVamqqNfxM3h492zjSwyicvYHreNB5lNUmcsrg/GM7iud+K62dibpAo2ZX3Pc107n36Lcwqhjck2OjLLl9FIKDTIE5e1oGh3TCchx8DgFpPkWU4qPt1ymnSktUD1HLw48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719874095; c=relaxed/simple;
	bh=6MXaW4rBJSURoUHK9Char7gU9U5q2rkIHGoL3aJyY8g=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=IC7t8xQv29xkoA6lVTR8RhOG6aOB/VfBRzjt7b0Fm6sRIwbGZJkkyxG4bm51AIhPyPLUr2geHJcCpaxurI+erHA43DCb66MrV+BmXcnOvUXR0CwOm9MUG3r4YAlayGfMd9J0ME3ZEKfXhQqPj7O7lz4f8ZIxKLwvlbNmpyc8Sv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZVFKj0fG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461Jp0gp022894;
	Mon, 1 Jul 2024 22:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6MXaW4rBJSURoUHK9Char7
	gU9U5q2rkIHGoL3aJyY8g=; b=ZVFKj0fGlozLMZfQxb3GRnmcFsfXQcGVMz8auc
	iec6deAbnux7vt4qhRvJrclt2P+1ZgJKT2JQitT0waLkBfIgnaQSi09xKYh3qdni
	xtlC5VakucdNJ5tj+mVUExLz2OuQc8qOsv39XBqBiw2V2R2L9Ga6NRifzVEa/XI7
	z5rzePB/agibuBta3QNxEhzh/VtohZimfiBMQDOaKVANQhymvHInfSOsrhY4TEJt
	BpJMz9ieb8fuj0wR+br5u4oC10ijfoSsSbA8Thksk/qEYVwDpW6X4MfzciV8NiAY
	238D4/GjJwfgGgOrknhbgfX36gS/OwJzUzNQKRbh7lHIb61w==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40297rnqpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 22:48:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 461Mm8tP019062
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 1 Jul 2024 22:48:08 GMT
Received: from [10.253.13.74] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 1 Jul 2024
 15:48:07 -0700
Message-ID: <d2a150dc-1bac-4be2-a19a-d9dc6296e810@quicinc.com>
Date: Tue, 2 Jul 2024 06:48:04 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: LKML <linux-kernel@vger.kernel.org>
CC: Greg KH <gregkh@linuxfoundation.org>, <rafael@kernel.org>
From: quic_zijuhu <quic_zijuhu@quicinc.com>
Subject: Summarize my recent devres changes for code review and merging
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NljuN05FytykKIdA4QElWHB1YPhPOywL
X-Proofpoint-GUID: NljuN05FytykKIdA4QElWHB1YPhPOywL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_21,2024-07-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=755
 lowpriorityscore=0 clxscore=1015 mlxscore=0 suspectscore=0 spamscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010169

I would like to summarize my recent patches for devres as following:

[PATCH v2] devres: Fix devm_krealloc() allocating memory with wrong size
https://lore.kernel.org/lkml/1718537455-20208-1-git-send-email-quic_zijuhu@quicinc.com/

[PATCH v1] devres: Fix memory leakage due to driver API devm_free_percpu()
https://lore.kernel.org/lkml/1718804281-1796-1-git-send-email-quic_zijuhu@quicinc.com/

[PATCH v1] devres: Correct code style for functions that return a
pointer type
https://lore.kernel.org/lkml/1718631689-11929-1-git-send-email-quic_zijuhu@quicinc.com/

[PATCH v3] devres: Initialize a uninitialized struct member
https://lore.kernel.org/lkml/1719871765-14774-1-git-send-email-quic_zijuhu@quicinc.com/

[PATCH v2] devres: Simplify devm_percpu_match() implementation
https://lore.kernel.org/lkml/1719871779-14818-1-git-send-email-quic_zijuhu@quicinc.com/

