Return-Path: <linux-kernel+bounces-211307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA67A904FC0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 11:56:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25B2282E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 09:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBB816DEDB;
	Wed, 12 Jun 2024 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="H/PbhyXA"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1BA1A34;
	Wed, 12 Jun 2024 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718186197; cv=none; b=qYTp8+PL2Ii0NIc576pw8L+M6ZSdztmdjA52JFYHMjRiN/XfkDzrCLkW2oaUUVPL5+KGehs0MjBeuN0c6Lfx0oMAO5o+/0w3o2IT2oRB01Ubi8xqNg20chtNPr+DX0BkFAaZu6lO6Iu7HwGQAg+iDxkqtAGrhiOn4u/tKsIjIFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718186197; c=relaxed/simple;
	bh=GmQfuVpYVMoxw//+VZkcA4DLbCRQkx3EyZHDcLI2H3s=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eobqVWCp6vQDupBtFuOp/41US6oXypgM+24tp8U3OQj17X7hxo0BbTnSZwYzeElTSH4yITmAbeGlYuumCsI5hmueqljryaqduAl2pE28X8hs23xUhnHEkiySCxYPBktp/yXAO0IKThz7tK9hEXFFE5knoFsU6wEk81S54B0JZLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=H/PbhyXA; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C30uOU015315;
	Wed, 12 Jun 2024 04:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=m1LLXHsEtF5yDASxKC
	g2mH1kucWQQIwecALYO2Nn7dQ=; b=H/PbhyXABZPsI0qZBjTf79pbGc80MKPxQR
	2zU5mJeUrWK90a3SSbFzMA1C/rsaWDtljR2b5cv31y4KM+aalvij0uFWsBn1O/3i
	ATH0/xUj/2Qa5+6jD0J2TEOoJWBWRPbBLQpIYbjqOFgySNdtJ4sRc6XhNDtl314a
	MExkKgiLoiOYf3JzMqdvOYx4jPUdmtGRhs2JK6LqheR1fOcwvz7+cuNoy+hLZPuY
	Hmj3U0j+9I6Ehd+g41yhl0hoPLgQ0rkfu6Klv+G3F17mshjp7RwRqrPhlsrwvAxa
	e3MbKf34c8thkHio3ZJ4rJuDmZA7o/xyfh8nBiDFR9X/gLnd9hYQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ymkqhuunx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jun 2024 04:56:29 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 10:56:27 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Wed, 12 Jun 2024 10:56:27 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 8F080820248;
	Wed, 12 Jun 2024 09:56:27 +0000 (UTC)
Date: Wed, 12 Jun 2024 10:56:26 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Animesh Agarwal <animeshagarwal28@gmail.com>
CC: Daniel Baluta <daniel.baluta@nxp.com>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: dt-bindings: wlf,wm8804: Convert to dtschema
Message-ID: <ZmlwyjHXjAwFvy01@opensource.cirrus.com>
References: <20240611122258.47406-1-animeshagarwal28@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240611122258.47406-1-animeshagarwal28@gmail.com>
X-Proofpoint-GUID: 3tPNXNwug9zjDl2wtWSXcMk_QYW-sygG
X-Proofpoint-ORIG-GUID: 3tPNXNwug9zjDl2wtWSXcMk_QYW-sygG
X-Proofpoint-Spam-Reason: safe

On Tue, Jun 11, 2024 at 05:52:51PM +0530, Animesh Agarwal wrote:
> Convert the WM8804 audio codec bindings to DT schema.
> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

