Return-Path: <linux-kernel+bounces-517296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4050BA37F06
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8671168E8A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 09:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84DC12163B9;
	Mon, 17 Feb 2025 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="fccD9gij"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6549212B3A;
	Mon, 17 Feb 2025 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786136; cv=none; b=n9ansA518ThKcgYvj6uoII1S+GcvrOrat6YYlQomLXZ3xBXoriCGhKHoC7IERSuZwpxtO7O8tIWcaIOG5p/1qcd0oG8Kh5Y3FU8mHqGjsOhPCr0rjVCIRMYiGL37oxFQLPN0Hdd9wfYRTgXtSFA1BG7BCrg6g4exeQNVG+zTbK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786136; c=relaxed/simple;
	bh=tpn46eI2tbdNHKTRTV+W9UMHPv4VKyZwIxuF36MkbTY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCP2xUcuZXGw0zMSzLaqZWgftdbY8EKga5Z9wpAasvEH8TNLelpmjKT5jDAorS4RrOfqSrPzSkLrbKxk8llhOfVOoMd/9fDH67BykNFSPGdPSN9vop8Mwozmyd418A7ABG4nll/loCxwcUMgGRGr7ambVO7ads034Zuzxh5XMbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=fccD9gij; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H7w1P0014998;
	Mon, 17 Feb 2025 03:55:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=aQZC45YarKjbG9j7IH
	XW7Lik11BDu7BTcIDKLkWl8xo=; b=fccD9gij8k0kcf6X7bFaxsWA6YnkyoOWJs
	64vtOydWn4lyYi0+KSB9/QqFRjFQ6o937A5TtyaxyB58ZZ+0S77alT4wuDqzAkFl
	rcz0LHQhdPrW+VzSOJ+k/451OdTzZpz5mVeDDHAlEaE5XQeKGhh1+aQj8ZyDxmdj
	i3g1GgWw7Y9UQ+1XwB8WsRJ8mWmQ62zgPOgNFbejbH/1DuysleH6DZPiNFNGYBv9
	JaUlVRSe8S2nSOlcwN0G73gf7PRZ+/fQf9xt1XTvoM1HW1j1c+aL5XyFPB4VDGsb
	uENdEtuH8+20GDIJoyUyhb++Z7jc3XmmNXDtYyzoWo82RM13cJ1w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 44uwg18har-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Feb 2025 03:55:02 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 09:55:01 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.14 via Frontend Transport; Mon, 17 Feb 2025 09:55:01 +0000
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id 14DB2822561;
	Mon, 17 Feb 2025 09:55:01 +0000 (UTC)
Date: Mon, 17 Feb 2025 09:55:00 +0000
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
Subject: Re: [PATCH v1 1/5] of: Add of_property_read_u16_index
Message-ID: <Z7MHdLahL9x+uB6l@opensource.cirrus.com>
References: <20250206163152.423199-1-francesco@dolcini.it>
 <20250206163152.423199-2-francesco@dolcini.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250206163152.423199-2-francesco@dolcini.it>
X-Proofpoint-GUID: L0XwHZrnUsgiAFk3R-4fCOqm38TuouL_
X-Proofpoint-ORIG-GUID: L0XwHZrnUsgiAFk3R-4fCOqm38TuouL_
X-Authority-Analysis: v=2.4 cv=CYzy5Krl c=1 sm=1 tr=0 ts=67b30776 cx=c_pps a=uGhh+3tQvKmCLpEUO+DX4w==:117 a=uGhh+3tQvKmCLpEUO+DX4w==:17 a=kj9zAlcOel0A:10 a=T2h4t0Lz3GQA:10 a=m8ToADvmAAAA:8 a=w1d2syhTAAAA:8 a=a5Ts1rH5jafQVb_QePAA:9 a=CjuIK1q_8ugA:10
 a=kCrBFHLFDAq2jDEeoMj9:22 a=YXXWInSmI4Sqt1AkVdoW:22
X-Proofpoint-Spam-Reason: safe

On Thu, Feb 06, 2025 at 05:31:48PM +0100, Francesco Dolcini wrote:
> From: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> 
> There is an of_property_read_u32_index and of_property_read_u64_index.
> This patch adds a similar helper for u16.
> 
> Signed-off-by: Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

