Return-Path: <linux-kernel+bounces-179591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD56E8C61D5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AAB9283C30
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8584047F6A;
	Wed, 15 May 2024 07:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="c4O8ie8v"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E5B44C88
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 07:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715758710; cv=none; b=qd76TXdFFS8DhJPSMAcwoBvi3cxfM/xDefHnGyZfSiIZF5Dg7Xr4GZiE5a83buSVBeWr1WBpzOHpGW6WtIuKPvmTOfyUTFr3GrrSrlC6aXMprYNYNO9lglxHTxaNLopJcuO06ZhXDEKI5pQKvh8RJN6YtXV8TB4M9PBYBskYHLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715758710; c=relaxed/simple;
	bh=M2DcaQa022yKAMxlKJ/RtcE7iTKuJE0pwFr9vLVuqbs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=soXEv8yWy5yLlnjMwjq9koZpaCcHeJKY7CJrM/qC9lkLDwhQmIVo++J2azU+Dsu0TvbEhZ0Ya3Qv7pdBx7LDGKJV47B5q7qYq98aeTp84a3ENZViyzi9eDvHuIXw9h02SvThPrd2+O8ez8Z553yBa+8ItnsowNIpvmlwvFujJKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=c4O8ie8v; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=JWlVGgM4WxsBCRWGiN8tEacLiYuKgkna6fVzADW0xEU=;
  b=c4O8ie8vWPJ0uSdN92/luS57dGrcQ9mdKUMBobUBfkY+YaoX7XiTvoak
   H/lbY3LoO8frvRnQ+SEs6fy4AaN14HO0zZduchtSoram8kRNQGuTzR58Z
   2DP8v1bPY/i53qKPKMXrXeJ+E3Dq4H/2JjRNhi7ClAEenIg4VywJ3GX0k
   E=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.08,161,1712613600"; 
   d="scan'208";a="165794184"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2024 09:38:20 +0200
Date: Wed, 15 May 2024 09:38:19 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
    Neil Armstrong <neil.armstrong@linaro.org>, 
    Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
    Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
    Shuah Khan <skhan@linuxfoundation.org>, 
    Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
    linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: meson-efuse: Replacing the use of of_node_put to
 __free
In-Reply-To: <768c3e38-724a-42d7-a51d-16044bc69ed5@gmail.com>
Message-ID: <b628913c-559e-67ee-efe2-913992c98551@inria.fr>
References: <20240416011751.93016-1-marilene.agarcia@gmail.com> <768c3e38-724a-42d7-a51d-16044bc69ed5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Tue, 14 May 2024, Marilene Andrade Garcia wrote:

> On 15/04/2024 22:17, MarileneGarcia wrote:
> > Use __free for device_node values, and thus drop calls to
> > of_node_put.
> >
> > The goal is to reduce memory management issues by using this
> > scope-based of_node_put() cleanup to simplify function exit
> > handling. When using __free a resource is allocated within a
> > block, it is automatically freed at the end of the block.
> >
> > Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > Signed-off-by: MarileneGarcia <marilene.agarcia@gmail.com>
> > ---
> >   drivers/nvmem/meson-efuse.c | 5 ++---
> >   1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
> > index 33678d0af2c2..400a9a075e53 100644
> > --- a/drivers/nvmem/meson-efuse.c
> > +++ b/drivers/nvmem/meson-efuse.c
> > @@ -42,20 +42,19 @@ static int meson_efuse_probe(struct platform_device
> > *pdev)
> >   {
> >   	struct device *dev = &pdev->dev;
> >   	struct meson_sm_firmware *fw;
> > -	struct device_node *sm_np;
> >   	struct nvmem_device *nvmem;
> >   	struct nvmem_config *econfig;
> >   	struct clk *clk;
> >   	unsigned int size;
> > +	struct device_node *sm_np __free(device_node) =
> > +		of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);
> >   -	sm_np = of_parse_phandle(pdev->dev.of_node, "secure-monitor", 0);

There should be a blank line after the last variable declaration, so here.

julia

> >   	if (!sm_np) {
> >   		dev_err(&pdev->dev, "no secure-monitor node\n");
> >   		return -ENODEV;
> >   	}
> >     	fw = meson_sm_get(sm_np);
> > -	of_node_put(sm_np);
> >   	if (!fw)
> >   		return -EPROBE_DEFER;
> >
>
> Hello everyone,
> Did you have a chance to look at the patch? Any questions or suggestions about
> it?
>
> Thank you,
> Marilene
>

