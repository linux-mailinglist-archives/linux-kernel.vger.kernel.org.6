Return-Path: <linux-kernel+bounces-208471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55EE7902585
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 17:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468E028A42A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 15:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D02D14B967;
	Mon, 10 Jun 2024 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="IOoTGm1q"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382B613C819
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 15:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032793; cv=none; b=i7EPMjcNk0MqweoeLAHwAeCmx+vpb5X4qN2RCKtdV6S7gVmUxVN9Hp1jgNztSElJlWLsCUo8FhdLroRhDxsDAD91GBl2I7y2eDJrvdhdfJZXkySdR8cbxFWySWK9xGVdSq73Jdw8bgqm8TK97J68n+0vKbGzA3jJJJ407diNWMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032793; c=relaxed/simple;
	bh=jQ6iraW9wZ/32s77kH/CLkpMkRpj08dMpTRjYPO83Wg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMmDbM4FlDlKXDImWN4qnpLxlWhExWw7EmMBYfP15JmD3Va+5WX4w19QYmTrQuZr0T3Vbn6VnMmtWQ/yVjCnfh6sHZHAzw5puvxJywwAvkz50Ovgvakc38Rdid5RAX1VzeLxgCsU6hdEYFvmOCW2tyONwRekOfGyqE9YTbO4AyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=IOoTGm1q; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45AEOOUx020276;
	Mon, 10 Jun 2024 10:19:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=VuIFm0hFHHWeDLcAy+
	luhI4ftuGgKwb0lS6iv6cXHXY=; b=IOoTGm1qU2LdLM0EJTiWo8OvLinnX008V7
	YIAeDw//ZuwjA5n+CW+uVYPhthyrr5kew+fVKObQuU3v2SJYsV7EttnoA5+1Hw/l
	U8+yKPhUYEmBXQE6gy0fmnkO86EOHJlYo93syd4MLT7AlLbxKERkK8PGN0GvXEbE
	5GrNVMHzU765s13fQ4w6tRvXW4yrj1BWB2ANEAvTAPTT47wSTWkITbt6pBiaDxK/
	03MkoAaqt4Hl8a2CECIrvdDXezd7BexBcGkiGKk2GCU0/9IuXLvQO0T5KpfQ++Yz
	QmwjTiI6Ms/tIGXjDFaDXYOEjCv3g8m2xc/wAe9rsaOVT4679CDw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3ymmq09ncf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Jun 2024 10:19:35 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 16:19:33 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 10 Jun 2024 16:19:33 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id E99DF820249;
	Mon, 10 Jun 2024 15:19:32 +0000 (UTC)
Date: Mon, 10 Jun 2024 15:19:31 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski
	<krzk@kernel.org>, Lee Jones <lee@kernel.org>,
        Shawn Guo
	<shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Pengutronix
 Kernel Team" <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers
	<ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt
	<justinstitt@google.com>, <linux-kernel@vger.kernel.org>,
        <imx@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <patches@opensource.cirrus.com>, <llvm@lists.linux.dev>
Subject: Re: [PATCH 3/3] mfd: wm8994: Fix Wvoid-pointer-to-enum-cast warning
 (again)
Message-ID: <ZmcZg+c0iOZtjqjr@opensource.cirrus.com>
References: <20240606143648.152668-1-krzysztof.kozlowski@linaro.org>
 <20240606143648.152668-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240606143648.152668-3-krzysztof.kozlowski@linaro.org>
X-Proofpoint-GUID: D6D9nm4QIDDFz72zwe_qm_GuO0SYswrl
X-Proofpoint-ORIG-GUID: D6D9nm4QIDDFz72zwe_qm_GuO0SYswrl
X-Proofpoint-Spam-Reason: safe

On Thu, Jun 06, 2024 at 04:36:48PM +0200, Krzysztof Kozlowski wrote:
> 'type' is an enum, thus cast of pointer on 64-bit compile test with
> clang and W=1 causes:
> 
>   wm8994-core.c:625:17: error: cast to smaller integer type 'enum wm8994_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]
> 
> Year ago this was solved, although LKML discussion suggested warning is
> not suitable for kernel.  Nothing changed in this regard for a year, so
> assume the warning will stay and we want to have warnings-free builds.
> 
> Link: https://lore.kernel.org/all/20230814160457.GA2836@dev-arch.thelio-3990X/
> Link: https://lore.kernel.org/all/20230810095849.123321-1-krzysztof.kozlowski@linaro.org/
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

