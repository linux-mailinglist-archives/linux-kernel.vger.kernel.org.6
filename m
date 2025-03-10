Return-Path: <linux-kernel+bounces-554999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B80EA5A44A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F110F3AE839
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FE61DED4A;
	Mon, 10 Mar 2025 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qUpt515u"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB75A1DE4F9
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741636852; cv=none; b=BR6RIU/UPM+1ICoexJzhriF899Pbxsvax143Vs8lzk/cPLyIkY4azaWwQpyA649GyMdilWxueYFVT/t9hAZ4bKDw1LmKCllOBN2yH8xxaquxhInw/reuaTArAMqHX2GhGrcHoIltW6P3qnZAyKyonM3qR5yA3D3ytKnZL4gfAcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741636852; c=relaxed/simple;
	bh=AGt2QKG+DtqFoUcbhQ3xw0t2YLyBDUEC2Yq67tszctM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XElxJWE4jZHqjDpCdrB8RGnpzlL4xxyvc0vLM8n4tXuChMmQrlISyjaVXd6GTGmhaZdWEypb2EOq5gawqds40CgleQdo1bzekSNTqwWy1wrHLTxeCEBUwkneH24dYcnpoJyCv5Jrsnb22cyNdI2Rxpyx1ZOGmx7jwMnoTTUKfRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qUpt515u; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso13139185e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741636849; x=1742241649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RrH66w6hjy8vTdk3/chb+sp4rDPMHTlBdbnwkF+r5mI=;
        b=qUpt515uw5B1Ei7onMIW5ikoEsB2Anjrxe5zfh8KJBdUy3NMHETsQvkOKMhaoUbR4M
         xYnh6JDEV5K1EnsRUybnIjKk4BjbuBT8MOpoybjA0K9iKiUD+Qps2WVS8zebXHpU2kxU
         aQ2t4+0Lq9DI5R7/w4AUWoWcz+sxtFrvsjcVt7te4+VweT3AyT9EGGbEfxiuOJqkxEu5
         e3C0w+KDU2eysvhBPLOWxr5zr2b40lHtYz74Q7UIbrHgw/Or40KGcxWzhbo7Oh3Wketl
         xCSSD/LHYVeFLeEDQL3ajpb4uuErhEKz8Z4ks66FfYqgy/GfL16eJeK9FYVCdwO989nc
         yagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741636849; x=1742241649;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RrH66w6hjy8vTdk3/chb+sp4rDPMHTlBdbnwkF+r5mI=;
        b=nWU2a2Rs4a3xH5RwfQx4kDfrswSl2jCcL5VRpab/fn+sB3jSEFs1ijA9Y+ybQ+Phfc
         n6ZoRX193FQWKseumdL/RlAnsEiJbfKeLm1zjrfJHrSdoqmR4HE4HEwb1KgbXUv8yD+S
         y3Vs1/sFEezW9YUlB+WslTqurXgQDzfoNE/joK55FlKYqJbUkrjgfzpxS2dwUFUA2MZp
         nMpDvXI8VeCr/jE7yPld/B+WtLaUga0WB1i1rTyqb1OLc+pZhaz1aP5LKBedwMJlDqDq
         cqpKettKhp2iALzhc763w+jT6As259bhtB7kdRsWOYswni7qkk8Sqn6v8Fu76fMTSH2w
         MeMA==
X-Forwarded-Encrypted: i=1; AJvYcCUUBYPrS1Edu0RpjztKUmxCPQWBja5TU2Yv1l1wkjOspeCYxTnqWNwky56SBa2M0/Dd9qsw4NeiXB+jeGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpVdVmGTr28AB07eN+dMqDxDB/7majRbq7lmWP2NNNUI+Y6nt+
	EnazxgXcUx+x7uNWOontZo6cX5SM8A5e5vikAPqs3OVPyWS4JJiORDIL117fkkU=
X-Gm-Gg: ASbGncuwweYj5Bdm0H7y2IV2yab3i7zORFf1o2kjtuWZv9TvfoMFRnU7VdH8MRGcdj4
	TiRB7sT6eUcXJHfVRwtxxCnIFPAx65XqOHa5ZBhoIsBv3dXcvkIG/nIbt5krcOX1+n2QnssoGJs
	MZ1saxlqEPIYRahOBwFzavDfUJAJQRdzkO869vTeOj1wAm13LFUEVbVH9eFfbTLLzTHAfTCT2qf
	VTMKgb1z1yAAPCnpr50dzvXx79LsHcL9xRcSbWx6vMj3TJpPh10FcVRsYP8Bw9WP348ECQkRM+j
	3y4EJK++UUoRD+V75KZOnPPWf5j8c0JNh7HgGuGWWhZcyTgDPw==
X-Google-Smtp-Source: AGHT+IFM0bk3L92HPL0a5ZdSUwgEKFaDtW1VyX0wWUqemrb2A9UISJTLPEdrw9TUJkHbZkhUzucD2Q==
X-Received: by 2002:a05:600c:3512:b0:43c:fded:9654 with SMTP id 5b1f17b1804b1-43cfded98b3mr28404325e9.19.1741636848948;
        Mon, 10 Mar 2025 13:00:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfb7aefsm15672875f8f.20.2025.03.10.13.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 13:00:48 -0700 (PDT)
Date: Mon, 10 Mar 2025 23:00:44 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michal Kubiak <michal.kubiak@intel.com>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: mediatek: Fix bit field in
 mtk_set_queue_speed()
Message-ID: <20f34718-e60f-4361-9ad7-311d3f67e40b@stanley.mountain>
References: <eaab1b7b-b33b-458b-a89a-81391bd2e6e8@stanley.mountain>
 <Z87e75UV0Qc4oY64@localhost.localdomain>
 <aab6d5f3-7ef9-4220-8b67-ee9b09a5f168@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aab6d5f3-7ef9-4220-8b67-ee9b09a5f168@stanley.mountain>

On Mon, Mar 10, 2025 at 10:27:34PM +0300, Dan Carpenter wrote:
> On Mon, Mar 10, 2025 at 01:45:35PM +0100, Michal Kubiak wrote:
> > On Mon, Mar 10, 2025 at 01:48:27PM +0300, Dan Carpenter wrote:
> > > This was supposed to set "FIELD_PREP(MTK_QTX_SCH_MAX_RATE_WEIGHT, 1)"
> > > but there was typo and the | operation was missing and which turned
> > > it into a no-op.
> > > 
> > > Fixes: f63959c7eec3 ("net: ethernet: mtk_eth_soc: implement multi-queue support for per-port queues")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > ---
> > > From static analysis, not tested.
> > > 
> > >  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > > index 922330b3f4d7..9efef0e860da 100644
> > > --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > > +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > > @@ -757,7 +757,7 @@ static void mtk_set_queue_speed(struct mtk_eth *eth, unsigned int idx,
> > >  		case SPEED_100:
> > >  			val |= MTK_QTX_SCH_MAX_RATE_EN |
> > >  			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_MAN, 1) |
> > > -			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 5);
> > > +			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 5) |
> > >  			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_WEIGHT, 1);
> > >  			break;
> > >  		case SPEED_1000:
> > 
> > 
> > There's a similar bug a few lines above (line #737):
> > 
> > 	case SPEED_100:
> > 		val |= MTK_QTX_SCH_MAX_RATE_EN |
> > 		       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_MAN, 103) |
> > 		       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 3);
> > 		       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_WEIGHT, 1);
> > 		break;
> > 
> > I think it would be reasonable to fix that too in the same patch.
> 
> Yes.  You're of course correct.  I'm trying to figure out why my
> static checker found the one instance and not the other.  I will
> send a v2.

Oh...  Duh.  if (IS_ENABLED(CONFIG_SOC_MT7621)) is false for my config so
first line wasn't reachable.

regards,
dan carpenter


