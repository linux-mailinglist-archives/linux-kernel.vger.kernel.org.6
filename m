Return-Path: <linux-kernel+bounces-173539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D098C01F2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 18:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EDCEB20EB8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 16:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0397129E9A;
	Wed,  8 May 2024 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b="wnrEpz3G"
Received: from mx0b-00823401.pphosted.com (mx0b-00823401.pphosted.com [148.163.152.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCE9128803
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.152.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715185631; cv=none; b=KxU2d910x13Jlnk5enGnUmcNbdvshNum4etZjmR+U14PM3ztCXtFqc1qoWdn8TZKNqb/6+PmoqxJmr3vk8xub/a9HckpYawAEhbKcM5u8Ga5DYEn1NsifkQmCEGj4dcr1wtZWH7Km0ZC8KcIoU+7XDqw/Rt1/lzMaVE6dAduHRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715185631; c=relaxed/simple;
	bh=qpQIfCCGw5sp1thk0191lMWuGyXSw9tvH7iNZZtIgfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TvyXDm3ZdvpquQImJ16SsXBSH3e0JrxOlpzOmTjFkPhjG1CKnOaO2JS/fPACWCbAtLs3II4pu3xEPTLqoyxXeOr1S7SPbo9EqjUsXij34HB8Ib+ziAlxhbqxVo3mF03vHWFQVxAqxJjBLKfPHt+20HADA8T77B6+JU2uioqmvwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com; spf=pass smtp.mailfrom=motorola.com; dkim=pass (2048-bit key) header.d=motorola.com header.i=@motorola.com header.b=wnrEpz3G; arc=none smtp.client-ip=148.163.152.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motorola.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motorola.com
Received: from pps.filterd (m0355089.ppops.net [127.0.0.1])
	by mx0b-00823401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 448Fo8V3031572;
	Wed, 8 May 2024 16:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=motorola.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=DKIM202306; bh=TDqPstRDkCNbEJBhANBC
	AAhHmGuz+baE2EyjNS9FQes=; b=wnrEpz3GPEL85ly8cYUsAl7kxtEyKS2yaIb8
	+TQ6VVUDWEM8UPy3WLYVHIT50PRHfaAxuTFKpo3MdZ4Q1IjsGyydGTt1BF4eD1I4
	aKgCdz6mA+lueNXPMDuiu+urjBO66voa7we2oJBbY5Cafs0lPHMxq/vSNhRCiIIh
	58GO3E3ReA8hlWC4Rz6r9l+YLy3uOdleaPhJXPreboy8quasYxXiQzhOCz75V+RO
	44oOKcPDkONMsEGwkmI+2tnhT32Xg/27SJDeGUxP3DLmEkaphGNIsOEHlXwhQr0y
	GTe3Ls1gtkGbfIo3BQs1HF3TkPz2CIF4tfnMYo3Ns+KtHPWleg==
Received: from ilclpfpp02.lenovo.com ([144.188.128.68])
	by mx0b-00823401.pphosted.com (PPS) with ESMTPS id 3y00mf9nb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 May 2024 16:26:39 +0000 (GMT)
Received: from ilclmmrp02.lenovo.com (ilclmmrp02.mot.com [100.65.83.26])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ilclpfpp02.lenovo.com (Postfix) with ESMTPS id 4VZLBR33zjzbrVd;
	Wed,  8 May 2024 16:26:39 +0000 (UTC)
Received: from ilclasset02 (ilclasset02.mot.com [100.64.49.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mbland)
	by ilclmmrp02.lenovo.com (Postfix) with ESMTPSA id 4VZLBR2SsTz3p6jp;
	Wed,  8 May 2024 16:26:39 +0000 (UTC)
Date: Wed, 8 May 2024 11:26:38 -0500
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
Subject: Re: [PATCH bpf-next v3 0/3]  Support kCFI + BPF on arm64
Message-ID: <6gsdoxav3y46mvjqugb5eprz2gn4my7kye6bsfvf34h4s7c3kj@p4qdttezlusf>
References: <fhdcjdzqdqnoehenxbipfaorseeamt3q7fbm7ghe6z5s2chif5@lrhtasolawud>
 <mb61p34qs1uvp.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mb61p34qs1uvp.fsf@gmail.com>
X-Proofpoint-ORIG-GUID: xuKafYa-Zdxpgc5jyFHi5rdQp_Hiwcn3
X-Proofpoint-GUID: xuKafYa-Zdxpgc5jyFHi5rdQp_Hiwcn3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 mlxscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=694 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405080119

On Wed, May 08, 2024 at 10:05:30AM GMT, Puranjay Mohan wrote:
> checkpatch.pl complains about the patches like the following:
> 
> ERROR: Missing Signed-off-by: line by nominal patch author 'Maxwell Bland <mbland@motorola.com>'
> 
> So, you can change the authorship of the patch like:
> 
> git commit --amend --author "Puranjay Mohan <puranjay12@gmail.com>"
> 

Thanks for the heads up! To avoid spamming the list I will respin the
series with appropriate attribution tags on Monday, apologies for the
mistake.

Maxwell

