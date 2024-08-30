Return-Path: <linux-kernel+bounces-308296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D71689659F3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7CD1C215F7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 08:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A37166F05;
	Fri, 30 Aug 2024 08:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="TUshZIbE"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0943FF1;
	Fri, 30 Aug 2024 08:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005886; cv=none; b=HpiN034WBD4fPCv4AZ/NBbG1Hes/FjoI6+rjg+Dtq08bKAmb8M2CK8L7alexWcd98p6461koiAhcLWSnackeRqCAzpVuA9xw46Bufg8S/LSUy3CSScZx/hNOOc0z1uzfkiEJ1tUIMEoBPLneb7QRYtMI738zeOmXYadrV46kijg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005886; c=relaxed/simple;
	bh=PvpR8U7gWZr3H8JbQyG45V9BPVBKlv/mk1ETgNTT/o0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S1RGpf9Ky4w7jb9vpN1zpNRpPjKP9EP2dn/dYR78ERj/N+g2YWdNXDHdVbhGEIL/nfSa3T4P5nbsTf4dTjou7ocGxpTPhL6LXTr4FwjpS85X8m/p9fPQqrRqAAnWbUaK8fgg9PHa4tDwDzZCajVNWKzEbP44PiJDU8Y3ea0vqRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=TUshZIbE; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47U6g4O1029742;
	Fri, 30 Aug 2024 03:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=iPQvNt4NrjPXbMYc+3
	you9iuaI5VM9JsQvJ3x/6Fxbo=; b=TUshZIbEvYytLwR/UQ+ODt6DdSp6uvjLHX
	1Atq0yrj+d7gvXz/7nUypAB/VQLR7tpuLHwcvPp0QDgFoiZcOYHJwOcTlFFIIFYb
	AxAX4x0u9zJ/BGcdOctCHEKbUgHd1mNM3G9njBBfGW4e8cwyQ2MzyO9YuFGMeUtI
	QOyKeGsJoO1500F3xpVruvf5kYQTVKxpFVu7Yaxo1isWIX1/gOlYXPJ4SOgJatsZ
	JJi1MKTrrsepnyx90OI8MEBYF51IBzXkc5USy8au2GRwDsvlxY0l7JGJRb+SjI8W
	NcH7C4BEpeyYSmBoadlkVoTYKe4JarzM4vK6LjhX+caTiujU80Lg==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 419pukbg25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Aug 2024 03:17:47 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 30 Aug
 2024 09:17:45 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Fri, 30 Aug 2024 09:17:45 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id EDBF9820249;
	Fri, 30 Aug 2024 08:17:44 +0000 (UTC)
Date: Fri, 30 Aug 2024 09:17:43 +0100
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Yan Zhen <yanzhen@vivo.com>
CC: <rf@opensource.cirrus.com>, <tglx@linutronix.de>,
        <linux-sound@vger.kernel.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <opensource.kernel@vivo.com>
Subject: Re: [PATCH v2] irqchip: Simplify with dev_err_probe()
Message-ID: <ZtGAJ0JnVAUMrG6j@opensource.cirrus.com>
References: <20240830070504.289450-1-yanzhen@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240830070504.289450-1-yanzhen@vivo.com>
X-Proofpoint-GUID: wiVYXE83PLsTliYSk365iFajLcM-N1uV
X-Proofpoint-ORIG-GUID: wiVYXE83PLsTliYSk365iFajLcM-N1uV
X-Proofpoint-Spam-Reason: safe

On Fri, Aug 30, 2024 at 03:05:04PM +0800, Yan Zhen wrote:
> Switch to use dev_err_probe() to simplify the error path and
> unify a message template.
> 
> Using this helper is totally fine even if err is known to never
> be -EPROBE_DEFER.
> 
> The benefit compared to a normal dev_err() is the standardized format
> of the error code, it being emitted symbolically and the fact that
> the error code is returned which allows more compact error paths. 
> 
> Signed-off-by: Yan Zhen <yanzhen@vivo.com>
> ---

Subject line probably should be irqchip/madera: but otherwise:

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

