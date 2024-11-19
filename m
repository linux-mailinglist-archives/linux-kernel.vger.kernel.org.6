Return-Path: <linux-kernel+bounces-415071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E852A9D313E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 01:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8885BB24C69
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 00:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352821D358D;
	Tue, 19 Nov 2024 23:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mGw4JYMW"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8788F1C3F0E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 23:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732060737; cv=none; b=VvBQ597cqN8knAByKiZ2kAt3XK8pnD12/B3JNuvUgruHo/j9RRkJhQ3panDQFitg4pJJAn4en7aEZmYQ7SRObkKdWMf/KF8BQzCadtD/G8J3HJTuEMQRtWS2pSVcigMn0f+44Ys566HaNG7EccyxA+Dk5QVyhaaLisB9bc3ur4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732060737; c=relaxed/simple;
	bh=v8rkMPyDLW0HQ7vVW3Sl7hrDub6ylysHEJRhUsGYOQk=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ug00+VFDxLyInYoyxZ0TRAm1L2VcV2VwPEQtHHIhZoRb+DX4Gq7Up5ppWbhHbpKD8Zx71c0R4NazbEa3EdYP2N4+lhojeCW4W6R8/Oe1Fq7ZQMz4sR4Idznm4jYY8aMG8QO1UMDwEZsX6Doch0LWf2daRsBHLh1Au7THez+V+rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mGw4JYMW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AJN2rc3010421;
	Tue, 19 Nov 2024 23:58:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=opuUdwdVnwNwxw2h/QUNRs
	ECU9If36UX2JB43AcWOwM=; b=mGw4JYMWrdstVVeMQ7sTfWMZ7ONIjugIfyoCfN
	RyAVLXNI/L/iCQYCPyUIxTjXqOAmcdO63F2MDowWgX9ryIwBhb/iuqQOoD3F58nf
	2M+IOY9PeKDeY71Pbf61jmt+288lvZ8yea+HLmflR25yJ5/f33s3jE83i3pmc7HO
	JExpr1KQxt6aqrxZ1Z9VA6pu7R9/CazoW8EqWIWhRdBSwmDuFsP8hpRo15bWn72c
	dqxKxIKDetkbhhMvA0KR8/Z+zqsI3iVeE2npwgjx6T8KU7D2nHjGn9xd2/tx6Pn/
	f3djW11w3mRbYUDIuEDfXIbitMGMdwV3Q5v6GWDvt/FDzbTQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4308y5v6j9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 23:58:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AJNwj1k015592
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Nov 2024 23:58:46 GMT
Received: from hu-cgoldswo-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 19 Nov 2024 15:58:45 -0800
Date: Tue, 19 Nov 2024 15:58:39 -0800
From: Chris Goldsworthy <quic_cgoldswo@quicinc.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky
	<senozhatsky@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>
CC: Yann Collet <yann.collet.73@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Question about extensions to lib/lz4
Message-ID: <20241119235727.GA26223@hu-cgoldswo-lv.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4ndoOjdAQI7jQFylaq2jGh8Amtu2Hv0m
X-Proofpoint-ORIG-GUID: 4ndoOjdAQI7jQFylaq2jGh8Amtu2Hv0m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 clxscore=1031 spamscore=0 impostorscore=0 priorityscore=1501
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411190176

Hi Folks,

Qualcomm is designing a LZ4 compression / decompression engine, with the goal of
being able to do single-pass operations (i.e. we only read input from DDR once
for compression and decompression). This is achieved by using buffers internal
to the engine that store:
 - For compression, the running literal we've encountered, which is used as a
   search buffer
 - For decompression, the last part of the running decompressed output we've
   produced

The outcome of using internal (and obviously fixed-size) buffers for the above,
whilst not making any changes to the LZ4 format, are as follows:
 - For compression, if we fail to produce a match after running out of input
   buffer space, compression will fail.
 - For decompression, if the copy offset for a given block extends beyond
   what we're holding in our buffer, decompression will fail

We don't want to constrain our HW as such whilst maintaining compatibility with
SW, and allow it to compress and decompress streams of arbitrary lengths.
Focusing on decompression for now, we've proposed an extension to LZ4 that would
allow SW to decompress streams compressed by HW like ours, which is described in
more detail here [1] in a Github discussion on the lz4 repository owned by Yann
Collet. The changes we've proposed are as follows, though we would want to add
a static branch check as well to remove overhead for those who do not want to
use this extension:

diff -rupN "torvalds linux master lib-lz4/lz4_decompress.c" lib-lz4-patched/lz4_decompress.c
--- "torvalds linux master lib-lz4/lz4_decompress.c"  2024-08-11 09:51:42.000000000 -0700
+++ lib-lz4-patched/lz4_decompress.c  2024-08-12 06:26:33.986693000 -0700
@@ -166,6 +166,7 @@ static FORCE_INLINE int LZ4_decompress_g
      ip += 2;
      match = op - offset;
      assert(match <= op); /* check overflow */
+      if (unlikely(!offset)) continue; /* skip copy with zero offset */
 
      /* Do not deal with overlapping matches. */
      if ((length != ML_MASK) &&
@@ -289,6 +290,7 @@ static FORCE_INLINE int LZ4_decompress_g
    offset = LZ4_readLE16(ip);
    ip += 2;
    match = op - offset;
+    if (unlikely(!offset)) continue; /* skip copy with zero offset */
 
    /* get matchlength */
    length = token & ML_MASK;
 
Yann Collet has indicated that these changes could be acceptable and implemented as
part of a LZ4 v2 block format, which would include several other changes as well
that have been proposed over the years. The timeline for making / socializing
this would be on the order of years though, if it does go through [1].

So our question is as follows: as part of submitting our driver, would it be
acceptable to take the above changes?

Thanks,

Chris.

[1] https://github.com/lz4/lz4/discussions/1517


