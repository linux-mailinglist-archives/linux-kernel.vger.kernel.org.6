Return-Path: <linux-kernel+bounces-217963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F121190B6F4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 18:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F34861C235EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 16:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56AEB166316;
	Mon, 17 Jun 2024 16:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="iWpLN9U9"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3639C161904
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642833; cv=none; b=u+F7OAPm/Ha/AljikRKdRMnkNk5I0Xn03Pvxu6kqYNB/exlGgAKluhzw3cEUzllEOVNmmLJXmDdfZukLC80uHbY9s27CO1oMgeoCL+lRzY1V3e78sezpjlmiUV+M3X+S5yS8ipuyfNXM5oGkYvhi0yk7eFRiqeBajgQL0xYzD6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642833; c=relaxed/simple;
	bh=h2YviOske7O2TPcfa5tW0K0jMjjD7vn02FDgSx2WDcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD1UDTfcum/N9ynpw1rNBqUoI+s+AzLCrJHGnmANmj9YpDTd1XkRTa6Qd3s1CE4qtjWaEe597/yWsFmxp1KA/54hrESNY730XF2SbcBGTGm+BRPdDTQIMudxSXwlWpTE2bTwn3wUk4U8XCcBCkw335bh4/SO1U82i1wNFbP+rjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=iWpLN9U9; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355091.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HCO9C5026396;
	Mon, 17 Jun 2024 16:46:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM202306;
	 bh=X4dJsGQtk2DxwZFqhEBHgDozUFxcgumfjnL0nm6nunA=; b=iWpLN9U9iFC0
	EDJewOCyZbJFQwbUYgrdKiDYVTHygeHeRbyxvL6zAwx8YnrfiH2aPpkMo1FTb9Ot
	Xa2/ET8a0JxA8Xr1y6aaxA/QwgfW0O3KuTbEIrpuP6WuHyqzVhcYJ6ZOoQcJ4CkM
	dnJeZahy/wwWU3lWNAeb1ktZnvslqofjAQkl8Hw5bPxbPH5XiJdaPvV2m7lGgkeg
	iunl2rACf7m4F6oAdQ4hrv+LrBZmWrY4aZaB+4WJg2zEVJRoN4RxXfbsTzSG6tPC
	KWmQ/E5UEJgVDkNCObqg8Udp3I3heV8wByyrufJzj8kN5DJyEHxGNJu6m1wKDvgF
	vrzIdnau3Q==
Received: from ilclpfpp01.lenovo.com ([144.188.128.67])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3ysr2gjx30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Jun 2024 16:46:36 +0000 (GMT)
Received: from ilclmmrp01.lenovo.com (ilclmmrp01.mot.com [100.65.83.165])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ilclpfpp01.lenovo.com (Postfix) with ESMTPS id 4W2wl0181xzfBZq;
	Mon, 17 Jun 2024 16:46:36 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp01.lenovo.com (Postfix) with ESMTPSA id 4W2wl00RlQz3nd87;
	Mon, 17 Jun 2024 16:46:36 +0000 (UTC)
Date: Mon, 17 Jun 2024 11:46:35 -0500
From: Maxwell Bland <mbland@motorola.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Puranjay Mohan <puranjay12@gmail.com>
Subject: Re: [PATCH bpf-next v6 3/3] arm64/cfi,bpf: Use DEFINE_CFI_TYPE in
 arm64
Message-ID: <g3qlk7mpcn4wussku5jubbfnxn6ihhysenlmmlocmvw6gc724r@fem2y2oactzc>
References: <illfkwuxwq3adca2h4shibz2xub62kku3g2wte4sqp7xj7cwkb@ckn3qg7zxjuv>
 <c6fsgv7bjt2d2ejz2uuin2g475fkvpyenp32wehdqlcf6ihqgx@5gicsaw4u37f>
 <CAADnVQK6Vh-pv_ewS0RjBBfL5KUsMXpdMNFvv5F0OPWzABEsAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK6Vh-pv_ewS0RjBBfL5KUsMXpdMNFvv5F0OPWzABEsAw@mail.gmail.com>
X-Proofpoint-GUID: De9ZZ3vPhjb_CdLWo1RUJ5PlMKvTN6lD
X-Proofpoint-ORIG-GUID: De9ZZ3vPhjb_CdLWo1RUJ5PlMKvTN6lD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_14,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 mlxlogscore=566 adultscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406170130

On Wed, Jun 12, 2024 at 10:07:09AM GMT, Alexei Starovoitov wrote:
> On Wed, Jun 12, 2024 at 8:32 AM Maxwell Bland <mbland@motorola.com> wrote:
> 
> Please avoid the code churn.
> Just squash it into the previous patch.

Sweet, thank you and done:
https://lore.kernel.org/all/ptrugmna4xb5o5lo4xislf4rlz7avdmd4pfho5fjwtjj7v422u@iqrwfrbwuxrq/

Waited 'til Monday to lower the frequency.


