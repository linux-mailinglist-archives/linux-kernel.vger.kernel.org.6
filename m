Return-Path: <linux-kernel+bounces-198769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C258D7D2B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 10:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71EC7283124
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 08:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60B5B57CAB;
	Mon,  3 Jun 2024 08:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="H+sHq3o2"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E013955C0A;
	Mon,  3 Jun 2024 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717402713; cv=none; b=ny3jj2q11nIvOFbcevkh69d5p+n53QiTcqXSHzoCts3Bh1EAO2BbkJSWwF6ykBqyE4RJyg725iD4l9dpwcc+It5L9qZ4AuLQiW7veTea1tHuY35ybfvkO8KdBzdUyoU27rLNBPOG0iP8wpZqP7PjqtaOaDJGfQcZJdfoc25HjgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717402713; c=relaxed/simple;
	bh=3AttaUkpZheUTQu4LxQ/6eDePa6nzJciotjCxL/3DuE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgRnhFB8JAqG1ILbg+oExxzX7F0AB/bqri5SOghdubpGJ8NWvuxGVLC4tjocuKA8APTDQ0ProNwaqfFRowJtVa+lmjDa+wB87B21rJvloAdQIMUL/KaBJluyM6KOZiVZwjkYRqP9zICtfFZaIl23sw74LmfJ3QR83eil2McofYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=H+sHq3o2; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4534bd8r027721;
	Mon, 3 Jun 2024 03:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=kqzYoKK/xn5/xaTv+q
	5s3bSIwJX2AbDTSqYAE+s/rc8=; b=H+sHq3o2bsjyseyXQxb45PVyPePoyP0pdd
	XD+Rok3Gv2wx5qf3sz77FM579CS+XUxQJ0/LIT6xe26drhyjKfuONhebRX/0pc00
	YYCIrekSk1fs5/ruHaZn8FohS+HhHU94K5hrhoVoxI5w1txZjcyo0xFESt5Fxp7k
	hojLgKZMpuM88Q0PBVCazUoscG5vrZAoOZRO/owHyznLMwGQx3Mr0Xm91Gk8a+3J
	5RFvHFVNxlBFFWteUW3lEy4rmL987nIBaZD4ae7gwf9Wl6HCnttz5AqOhsjNPRaO
	zc3/PogxfjMnlFXnPBCithlziHC3w5xvQb6ZjWfbcfdkSynV/n/Q==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3yg02hha2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Jun 2024 03:17:58 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 3 Jun 2024
 09:17:56 +0100
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server id
 15.2.1544.9 via Frontend Transport; Mon, 3 Jun 2024 09:17:56 +0100
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPS id AB4B8820249;
	Mon,  3 Jun 2024 08:17:56 +0000 (UTC)
Date: Mon, 3 Jun 2024 08:17:55 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <linux@treblig.org>
CC: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-sound@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] ASoC: codecs: wm0010: remove unused struct
 'wm0010_spi_msg'
Message-ID: <Zl18MzMHGbE8B7/U@opensource.cirrus.com>
References: <20240601225446.183505-1-linux@treblig.org>
 <20240601225446.183505-3-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240601225446.183505-3-linux@treblig.org>
X-Proofpoint-GUID: -r9T5ub-_Fk7GKDeykYpbbSwa_HlL39h
X-Proofpoint-ORIG-GUID: -r9T5ub-_Fk7GKDeykYpbbSwa_HlL39h
X-Proofpoint-Spam-Reason: safe

On Sat, Jun 01, 2024 at 11:54:45PM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'wm0010_spi_msg' has been unused since the original
> commit e3523e01869d ("ASoC: wm0010: Add initial wm0010 DSP driver").
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---

Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>

Thanks,
Charles

