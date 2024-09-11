Return-Path: <linux-kernel+bounces-324856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E38F97519F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91044289994
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5488A189F2D;
	Wed, 11 Sep 2024 12:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RSAfgosv"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79B51891A9;
	Wed, 11 Sep 2024 12:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056749; cv=none; b=BFIJHQER2+36I5hheBYHIQ7ARNm6P8eu3xMdYh2z/C3wGGK6OmcuS2NXfUZ2uxHYrrkH1p2eEfZUOwjdi8VIavheG5KD8t5xtSb9ZBFV1Gi0ATNMfN3Cy8qZdqpnXGXTlxsWoASRdu0WU/55nMKq5j8SAjgWBfKytpRpCmCvHxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056749; c=relaxed/simple;
	bh=cSCzmdNsxwCze2MNd8Y3FRZkMMVzVlJgnJPwxFkrP9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oB0ssybptswTfKLo++b1ZjU9TINDz6Ho1/IvZUwr8ZttFYI/yo/eHeM1qCN3ytB9zeypq+46CjBc+0p6nGqehGlk5CRYITvhJrXJe0aBIhiiSVd2bef2YGOprzQs3c1wjfmh+X6fB8eHEcmcsGaHH499aZC88gsQMigUbd6jDMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RSAfgosv; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=yNsNUIh7Z32QBJGGMFVvTAKKOX0vPwFSxf2ClIPyrEc=;
	b=RSAfgosvE/k6YmHb+X1z8imyHhXXTmvp/d2nKVSFt6s2STOs3JhNL8Ap+d5kPr
	WFnIWcCzb9NytNXBmRR9Ke+de5khtVWrUk2MyoGzBhhnsXChgA5Ve3tRMqyZYQI0
	HNQlAnjMCrmIZhv7sZnx3gl0Vn4qc4jIi5T2Qi70ggrF8=
Received: from localhost (unknown [120.26.85.94])
	by gzga-smtp-mta-g2-1 (Coremail) with SMTP id _____wDnj2IFieFmfO6VFQ--.4817S2;
	Wed, 11 Sep 2024 20:11:50 +0800 (CST)
Date: Wed, 11 Sep 2024 20:11:49 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Mark Brown <broonie@kernel.org>
Cc: amergnat@baylibre.com, angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com, matthias.bgg@gmail.com,
	linux-sound@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: mt8365: Fix using uninitialized value "i2s_data"
 issue
Message-ID: <ZuGJBQA90j1UB9En@iZbp1asjb3cy8ks0srf007Z>
References: <20240911001516.47268-1-qianqiang.liu@163.com>
 <9ea8731a-7888-40a2-a183-4598884bbb27@sirena.org.uk>
 <ZuGAwQGPWdpO1-G9@iZbp1asjb3cy8ks0srf007Z>
 <eb21bcab-333d-4ab3-9222-058764ced720@sirena.org.uk>
 <ZuGG3jk6oqq7sUMw@iZbp1asjb3cy8ks0srf007Z>
 <8d921122-7271-451a-8bcb-83a1066b7b87@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d921122-7271-451a-8bcb-83a1066b7b87@sirena.org.uk>
X-CM-TRANSID:_____wDnj2IFieFmfO6VFQ--.4817S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUIPl1UUUUU
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiLwdXamVOGQ7YCgABs6

On Wed, Sep 11, 2024 at 01:07:52PM +0100, Mark Brown wrote:
> On Wed, Sep 11, 2024 at 08:02:38PM +0800, Qianqiang Liu wrote:
> 
> > How about this new patch:
> 
> That looks good, thanks but an equivalent patch has already been sent
> and is in my queue:
> 
>     https://lore.kernel.org/r/20240911111317.4072349-1-usama.anjum@collabora.com

OK, got it, thanks!

-- 
Best,
Qianqiang Liu


