Return-Path: <linux-kernel+bounces-517331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8D9A37F4E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3E067A48EE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C514217645;
	Mon, 17 Feb 2025 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="C9XXRLqq"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030F515278E;
	Mon, 17 Feb 2025 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786724; cv=none; b=OvLKD9wnZ9hqPAyAtjaqS0orqj8DpeYqKY/pjNR9AcA/mpo0wAjliftF6SLRxYtSXV53rdwIZK5hO8cy+d3lUOCuFExVPNqbvfqRLnXYNO4hLcnpSHiW1MJSlWXGYWVSt9g1yKOn6WAq5eqTCBP6RzEJZRpw6nVaRj4p/TBmkCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786724; c=relaxed/simple;
	bh=MbLGiFPw0BviblpRBDxgF45OB1YB6WtJVJ4j6noJOlg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PrWp7Mr2AIO4DtOrzToADJif5CUBP0pp0Yc2WPX2l66LyQwRhpeXnUQNu3i/yJ4zawber3TVUd4fiwEhTBsiEDYGyoAqh8UyrlNBK1UJlsd6zTVR1wdMREhFQsfF8nUcspVvML4rtlr74IxXoC+gDD7DoWD79mZf+G1l4xsDgL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=C9XXRLqq; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H60KGZ016956;
	Mon, 17 Feb 2025 04:05:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=+AKz3PxkgrQ2fR1liQ
	UtFRny2oU0WB6PMxdh8i/jLek=; b=C9XXRLqqp2Jwo4Aut2lQW7qSFH31tI7qhr
	1DNmD7QpmjD6JmW7jAHQyrblVMgftZUvBgDFim0YvMtUxeyxeXQzJ+kkFFASqs8f
	93PJcJh7a3FYx+zl5Hs20KeTWBJbWl25OzCVSOLk9TE2O+YxlVK3MLQssm+AAWvW
	7PfeQ3H+HYc4R2EZKwe5zGTwodhJBfUNfszBz3ug3XBWu8q8jc+w5Vgn/kDoIp9c
	xaZzHmHvzOjPNsyiHAaRDX/R3bDJTgLK7yU+VVDLOpqz10ORynm2yIrsw7tunWLN
	HpH+ZIWXgnKNFSXIncag7UcWKAbaz0nZW7KcHQ4Bjwb4PO7zyw8Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 44ts75uj7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 04:05:07 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 10:05:05 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 10:05:05 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 15098822561;
	Mon, 17 Feb 2025 10:05:05 +0000 (UTC)
Date: Mon, 17 Feb 2025 10:05:04 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Francesco Dolcini <francesco@dolcini.it>
CC: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        <patches@opensource.cirrus.com>,
        Ernest Van Hoecke
	<ernest.vanhoecke@toradex.com>,
        <linux-sound@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Francesco
 Dolcini" <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1 3/5] ASoC: dt-bindings: wm8904: Add DMIC, GPIO, MIC
 and EQ support
Message-ID: <Z7MJ0IlOSAd4YdCd@opensource.cirrus.com>
References: <20250206163152.423199-1-francesco@dolcini.it>
 <20250206163152.423199-4-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250206163152.423199-4-francesco@dolcini.it>
X-Proofpoint-GUID: 4SUv7R2l17ptoWHijpFi3Q4U62P0TeG7
X-Authority-Analysis: v=2.4 cv=fepXy1QF c=1 sm=1 tr=0 ts=67b309d3 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=w1d2syhTAAAA:8 a=m8ToADvmAAAA:8 a=kPAxZCdUXx29zqvt4jMA:9 a=CjuIK1q_8ugA:10
 a=YXXWInSmI4Sqt1AkVdoW:22 a=kCrBFHLFDAq2jDEeoMj9:22
X-Proofpoint-ORIG-GUID: 4SUv7R2l17ptoWHijpFi3Q4U62P0TeG7
X-Proofpoint-Spam-Reason: safe

On Thu, Feb 06, 2025 at 05:31:50PM +0100, Francesco Dolcini wrote:
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> Add two properties to select the IN1L/DMICDAT1 and IN2R/DMICDAT2
> functionality:
> - wlf,in1l-as-dmicdat1
> - wlf,in1r-as-dmicdat2
> 
> Add a property to describe the GPIO configuration registers, that can be
> used to set the four multifunction pins:
> - wlf,gpio-cfg
> 
> Add a property to describe the mic bias control registers:
> - wlf,mic-cfg
> 
> Add two properties to describe the Dynamic Range Controller (DRC),
> allowing multiple named configurations where each config sets the 4 DRC
> registers (R40-R43):
> - wlf,drc-cfg-regs
> - wlf,drc-cfg-names
> 
> Add three properties to describe the equalizer (ReTune Mobile), allowing
> multiple named configurations (associated with a samplerate) that set
> the 24 (R134-R157) EQ registers:
> - wlf,retune-mobile-cfg-regs
> - wlf,retune-mobile-cfg-names
> - wlf,retune-mobile-cfg-rates
> 
> Datasheet: https://statics.cirrus.com/pubs/proDatasheet/WM8904_Rev4.1.pdf
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

