Return-Path: <linux-kernel+bounces-180109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA568C6A2E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7F5D28133E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDA6156245;
	Wed, 15 May 2024 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="X3bF7e0j"
Received: from mx0a-00823401.pphosted.com (mx0a-00823401.pphosted.com [148.163.148.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBF9156230
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.148.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715789207; cv=none; b=twcksnIurrQ4p5lviAmomSxHkX2BV2cElbWaWRENeDPxf1MA6P6abWVB8j6LVE6jaEdhUAS7hkIucnKbKi+4zwSOMerAbgl3n75z5cKbDwuCTTBN35pPa8JEhYMmrHVJKWzwaQWoXL3G+EIvp1lYS3FmAFc7pnKC8uTQQZ7zxwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715789207; c=relaxed/simple;
	bh=CQoI8qblvBnFXMToGnB6iHPH9uPDiAUMiWYVzyuecRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGAv54Eb3xDLr2XiGCR/1YC/8LGY+Ci7FWMo3i8JJ0y5mvti9JI2H3C8k8IMBqlFxdcXPXVBAsPFnL59PiNdIruHpI/Z5WVIwTaikgcis7aXg1b+Y/6wZrVu5Y03UQNXVoxn/nwVUyYzV0+qI9vNornt3FWIE+64qfQlws8Imr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=X3bF7e0j; arc=none smtp.client-ip=148.163.148.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355087.ppops.net [127.0.0.1])
	by mx0a-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44FEPr0d004217;
	Wed, 15 May 2024 16:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=DKIM202306; bh=/levf1vi4fiFuX+cdPEC
	pOPG58FAtYg+uobYV/UdvOk=; b=X3bF7e0jXfVNXLnAkjZCrah5t/zRNI6JYVI1
	lqJySMm/8T3TS4I201KT0PsBAW+8n/Hj+IvNdI/KUs+SaNzan0UhbdxeUrJFiFCY
	RhpTCOSzidmnr1it+3vqu/V2kFaHVdBdPPtd6InT8NpD/x6px+YzetuJEoqz/4UB
	ryHA6k/B3Fwf3r/cVSQswXb6YK210L2RU+9acXvE1PmWzEG+ZlmqBhUbiaOYF2qL
	JbaPPg/8XxhGGN84/fRm0kuDQ6AcOYMIk5VL1v2FId9ti+gPImkTOnKngsiwfUvw
	cQGPPOSdVFAYjRSY+ymMVcyK/2iKbBnBnRgRy8rd8+mVxuq5Hw==
Received: from va32lpfpp02.lenovo.com ([104.232.228.22])
	by mx0a-00823401.pphosted.com (PPS) with ESMTPS id 3y4b76aj7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 16:05:59 +0000 (GMT)
Received: from va32lmmrp02.lenovo.com (va32lmmrp02.mot.com [10.62.176.191])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by va32lpfpp02.lenovo.com (Postfix) with ESMTPS id 4VfdPL3RGgz50TkV;
	Wed, 15 May 2024 16:05:58 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by va32lmmrp02.lenovo.com (Postfix) with ESMTPSA id 4VfdPL02lGz2VZ3B;
	Wed, 15 May 2024 16:05:57 +0000 (UTC)
Date: Wed, 15 May 2024 11:05:56 -0500
From: Maxwell Bland <mbland@motorola.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Zi Shen Lim <zlim.lnx@gmail.com>, Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH bpf-next v4 2/3] arm64/cfi,bpf: Support kCFI + BPF on
 arm64
Message-ID: <6aoo3zm5yzpjyt2ur4ur4zn62zlzlhtfofgusbv5ldfcsvhmwx@of32iuwyem2c>
References: <wtb6czzpvtqq23t4g6hf7on257dtxzdb4fa4nuq3dtq32odmli@xoyyrtthafar>
 <ub6a7msv36rhotqez3usccexkn7kdqqnsyklrnqy7znqas7fhe@cry4jnw3baky>
 <mb61pttj1k6nz.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mb61pttj1k6nz.fsf@gmail.com>
X-Proofpoint-GUID: 0uDBwK5koUtfTgFNJjS5v5QFKD7c1iT4
X-Proofpoint-ORIG-GUID: 0uDBwK5koUtfTgFNJjS5v5QFKD7c1iT4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_10,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=927 spamscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405150114

On Mon, May 13, 2024 at 04:39:28PM GMT, Puranjay Mohan wrote:
> Maxwell Bland <mbland@motorola.com> writes:
> 
> This patch has a subtle difference from the patch that I sent in v2[1]
> 
> Unfortunately, you didn't test this. :(
>
> Puranjay

Ugh, this is terrible news, I am sorry, it has been busy and I did the
merge without thinking, though that is no excuse.

I will respin, do more thorough testing, and resubmit.

Thank you for catching the index error.

Maxwell Bland


