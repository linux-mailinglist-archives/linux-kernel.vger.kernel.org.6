Return-Path: <linux-kernel+bounces-201580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 451828FC049
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 02:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF897283497
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 00:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0C865C;
	Wed,  5 Jun 2024 00:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BNH7oVyn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433411C27;
	Wed,  5 Jun 2024 00:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717545748; cv=none; b=kmVbl+mCptA0WaKi1sRU1nLfZl4IkDoj/HsW+43Ov6SQBO0A6rI5uqnvz9zZ9ZmzFDPBDcGfyS5A2BHkEMVOcOisasWp4WxMIqQdH5wqPqhkTirRq6vcH0t3jshfV8H68iMp8haiN4EnmD/Oq23yNqCUlJ0VzsAgA9QRy2sRdE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717545748; c=relaxed/simple;
	bh=zbchVJpN8CtKnOtJCSxgSZT+M5QQnqyJvmlSKZIv2Xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o6nVUTUn4fsem3i9UHVkxA1H5k8h8b3Kb7wHmPwadCU3TCRgxQUA202zQYLh5DozdyKZYXEkeCPMcL20ArGtWGgsKbH1Ujv+FVxMaFD5rEmTndxGS3M8Zac7J+ENw3DrJSk1W13jPGIuIgRSxriFnAXGvoxISqKJcr78wB0J2N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BNH7oVyn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 454IIEe0006678;
	Wed, 5 Jun 2024 00:02:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2cTX+tDsHPj5h2dpCR1ziwRegx7pqfUXJVgw+e3/P7s=; b=BNH7oVynwYZLaB1R
	cMhSF8boJHJ+Kl+2TZcsIYc99w/69wVDu+dOkBu6QmkkE3PpJYSPKf7G/oJe6ik3
	N0dn1COsTrMiZ9w4+3IuCcma4J2u1z7axiJLyaRxPCW7VF/bZbq2kJTH/8NtBmvX
	hgHO2F2/d6RHbb84h8FPRmGz+mskDFphY8JHsqsgtN/ikZfgch+C2sHOmhjwhVlt
	wVx+w8AL+/5byQd3v78a4pO8538DngPn4cD+XdMknlHyjT7L4RoHw7SPj+OoPNPW
	Nti3ms6kZ/dqOhCsoRkO6dykTYwlmNQhHJ9fG+noML85NxxEMT6zE15jkpaTgpyN
	9GAcvA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yj8300kra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 00:02:12 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 45502BCb012993
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 5 Jun 2024 00:02:11 GMT
Received: from [10.48.241.109] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 4 Jun 2024
 17:02:07 -0700
Message-ID: <6f9d7066-9592-4a14-a811-c2451cbc33fa@quicinc.com>
Date: Tue, 4 Jun 2024 17:02:06 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: qcom: add missing MODULE_DESCRIPTION() macro
Content-Language: en-US
To: Mark Brown <broonie@kernel.org>
CC: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami
	<bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela
	<perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>, <kernel@quicinc.com>
References: <20240603-md-snd-soc-qcom-sdw-v1-1-101ea8bcdd38@quicinc.com>
 <0bd0a518-4d85-4251-9bf9-d056dc3d7b08@sirena.org.uk>
 <be0ee1bc-336f-4960-a54c-8bb71449fd1c@quicinc.com>
 <1acb74e5-e768-40f0-9eff-06b37c0d79ee@sirena.org.uk>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <1acb74e5-e768-40f0-9eff-06b37c0d79ee@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: EDj6ebt_bWiWvtkF7p8yfoReQrMkAZBA
X-Proofpoint-ORIG-GUID: EDj6ebt_bWiWvtkF7p8yfoReQrMkAZBA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_11,2024-06-04_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406040194

On 6/4/2024 7:14 AM, Mark Brown wrote:
> On Tue, Jun 04, 2024 at 06:59:31AM -0700, Jeff Johnson wrote:
>> On 6/4/2024 4:56 AM, Mark Brown wrote:
> 
>>> Is anyone getting any value from these MODULE_DESCRIPTION()s?  This all
>>> just seems like a huge amount of noise and I'm having trouble thinking
>>> of a use case.
> 
>> https://bugzilla.kernel.org/show_bug.cgi?id=10770
> 
> Please include human readable descriptions of things like commits and
> issues being discussed in e-mail in your mails, this makes them much
> easier for humans to read especially when they have no internet access.
> I do frequently catch up on my mail on flights or while otherwise
> travelling so this is even more pressing for me than just being about
> making things a bit easier to read.
> 
> and I'm not seeing anything in the above link that articulates an actual
> use case.

Sorry for the terse response. I agree with others that it was premature to
enable the warnings before all the instances were cleaned. But since things
are as they are, and since I saw others had 100% cleaned drivers/net, I took
it upon myself to clean up some other top-level directories without worrying
about if it made sense or not.

/jeff

