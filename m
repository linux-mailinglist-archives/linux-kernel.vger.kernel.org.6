Return-Path: <linux-kernel+bounces-324793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B779750ED
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C62461C22482
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B79187343;
	Wed, 11 Sep 2024 11:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fNhJXhPr"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FF6186606;
	Wed, 11 Sep 2024 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726054637; cv=none; b=tL/I5QP2pA4b72m2DjGcPtFH903ocMUe2r/7x2kJYUezyXkhSvqIGx7dWffr8Yi11unsG4ogM0pz8DrOxH/mC+VaS0EdilElxE7j9QT0yN+I2Waw6DvDm4CvG8MaZTCvr9oVVXrvgyHBkWP7XSzyLxzu0FlJY7M7PGI62JjkpQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726054637; c=relaxed/simple;
	bh=2S3baaKsySUw2pJxN0dk18QLC85lSeBIY8gdzsYTiuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmRhF9kF0o8bgl3JjksVFgbbeP0193yDrjKtrBk5PqoawNkkwcbvWObSc41my/afnwSfAuQSQYbt8lAA+0pQiVbAroUEXIy9A8OrY/3ndhO1JYXMYyDgVzmvRF0kVGzujzblMTzGzSBFZELH3w6B2cjl3kbRxOD6Aopfy9yDFew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=fNhJXhPr; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=EuOHph7C0cmfKRGlQa8YH44Sz/5FhEpWHdlFSJkUp78=;
	b=fNhJXhPrwwfzGOT3V0zYq91zOqYugXl++GmOk20RCgQF1+5KMCmDPcIU7haxL0
	osw9ldjnPaE2YNTRksIKmbaDCE93IEAZw2jA7XEju+PzQ0XJ09ehvtJrvB1vvZQc
	ns3wYoiqpJvnuoOLC6zi0mlQxeVMyUhX4FF3Eg6RwNtLU=
Received: from localhost (unknown [120.26.85.94])
	by gzsmtp3 (Coremail) with SMTP id sigvCgAn1wbBgOFm3jcXAA--.2464S2;
	Wed, 11 Sep 2024 19:36:34 +0800 (CST)
Date: Wed, 11 Sep 2024 19:36:33 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Mark Brown <broonie@kernel.org>
Cc: amergnat@baylibre.com, angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com, matthias.bgg@gmail.com,
	linux-sound@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: mt8365: Fix using uninitialized value "i2s_data"
 issue
Message-ID: <ZuGAwQGPWdpO1-G9@iZbp1asjb3cy8ks0srf007Z>
References: <20240911001516.47268-1-qianqiang.liu@163.com>
 <9ea8731a-7888-40a2-a183-4598884bbb27@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ea8731a-7888-40a2-a183-4598884bbb27@sirena.org.uk>
X-CM-TRANSID:sigvCgAn1wbBgOFm3jcXAA--.2464S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIJPEUUUUU
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRQJXamXAo2LUZAAAsu

On Wed, Sep 11, 2024 at 11:52:58AM +0100, Mark Brown wrote:
> On Wed, Sep 11, 2024 at 08:15:17AM +0800, Qianqiang Liu wrote:
> 
> >  
> >  	spin_lock_irqsave(&afe_priv->afe_ctrl_lock, flags);
> >  
> > +	if (!i2s_data) {
> > +		spin_unlock_irqrestore(&afe_priv->afe_ctrl_lock, flags);
> > +		return;
> > +	}
> > +
> 
> Why would we look up i2s_data without the lock, take the lock, then
> check if we actually found it?  That doesn't seem right.

Just check the "i2s_data" is NULL or not.

-- 
Best,
Qianqiang Liu


