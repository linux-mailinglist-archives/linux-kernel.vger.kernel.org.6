Return-Path: <linux-kernel+bounces-554955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FACA5A3C8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F2C41735E4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 19:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADD423643B;
	Mon, 10 Mar 2025 19:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kA2Is0vS"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651B618FDAB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741634862; cv=none; b=hZNKhjJrqcgIx0xsdM3dyuKtooeKQUx2xfhTcIEBEF3CATbXllMXgy0K1qllmtmMssqWZr2lKP8FLvd/uook7hEa8MpKICNTtBUm0J04TIsPS4Eu0x9P/ucF25gdT4q7nYqBx7lMEkVD/wkTcpFMwQLjGVrYMKghPTCsqGjIBMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741634862; c=relaxed/simple;
	bh=7LKU0kJ16VYxkK8s6lY89w1ydzFDPQufI2P154/QRQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6/lK1+YpueCvyILWWSvtc2sxJyY5/rjM0imocqYydeW07nO8Mm8PpxmvorJeNFvHwHkRImjQyMBG+LsKmlk+ErLEsX1l9o5uSnM9Hz+/G+9CfUDQcJZJVjEd5s5X/pcwkeNnC8WX+R6tdhejPMBe5l2Z+4J+Dj5O9b/fa9LiYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kA2Is0vS; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso3740719f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 12:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741634859; x=1742239659; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dlpjAiSLLJUkqO0ugcAgjSoBJydtUnexkUj1lX29pb0=;
        b=kA2Is0vSvEtEPMa4VzDtsTjsEwf1cGF/C+S99rJuyzaZnwshhszWpvdhdcY/HFi1Xs
         Ihahol53XNJpJST2KySGRVUi6DdEmLpovx8Fpl+v3oX5q/LHH+OeQ75RQEuihjxObmEJ
         jAm72NfS2w3qMOfAQQYVImyyKcC0hsEJFLgtcAYBGCTaofIM+C918SeTm8IqeTHyZQEx
         dmcam9mACH19eLFszBQrYptTxjT3I0tejkgYw3IJzOetZmkUoYX26ov1Worh/ga4GGQq
         meP6rmuWlKS+7mEKkcm9/wZPNnp7tDhAZHOWNzZ5a5JzRvKCv/sGW39fMvN2Whtzoh4m
         SodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741634859; x=1742239659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlpjAiSLLJUkqO0ugcAgjSoBJydtUnexkUj1lX29pb0=;
        b=vZvNRKkKAyZ0keiUMQrxLImQ90C4AOHIGGHXXsOCWT02eWsnNR8HBRhBW3J4mSTiE0
         KtlD1a+EHoLCfelBuk0JPSjYJVgVSkhj0/Ht+tFDh1MXcpwNUqij9ExKvMe6QppWk+2D
         luwJK9ZgbjHrMV5rLjhZhh/i4gLtIZa7rgXu1mgx69z24z2LJ3o2tfbRedL/IWXlW7te
         wikntnD0XQ6+n5gzLFX6cGGAomYCYp/tJSLin5NzNyr+IrTdvgSUq4uB3ZFCV+Pteuj1
         7y2AmOJp4KejVsCQL3yqaChayvCYHBMSJaZucztqpenY2FqBnsHUCm/wKXRKMGKPQ2Cd
         X1Uw==
X-Forwarded-Encrypted: i=1; AJvYcCXPqP/VMyWh3uXg+i/FOpJ+fTSt+sFsocR2qPsclwla/RyxxBVCk1z/cZ8/YOCLE/gzAT3fAbSgeWXsFis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAublETWOWv63riwq9cRhr+Mxwa5XtcvNvBJFOyXtPsUZUxsRg
	8BHTVTXAgIjkW2eRkVOnIu9l8UEsjb9YU1thPE5iv95bsydQDxpVtm6O7HnlhNJeG0IVwNtk4HM
	s
X-Gm-Gg: ASbGncuO8whFc7xlpa+pf4gNtUldPdAvo1wfb7CxbWNg0CCgWepiPkjJm4QuX7O7Itm
	mKvyOcoVmY41EPhqAJuvz7Go6VmuI1bRl64BFa4O4oCEpIsKQCuzYXeJVgaxeRmnekcPVQAZgis
	DJ+QeGCulqHdVkb0UucivesKEt05XtYPvkwdtSbqxv86gfovo+0YYA54l9v5RePJMdkJ/q3g2gP
	sLi6o+X3747dEJe7liI24AesZrUZUOKiNInE7UBXnSYIjre00eVDQdo0CVnCVTFq3aucZPMrFBX
	9xCrcKZu4O+BmzzD5mxaWahH/LXQgyQWwwYkroZdou48igLysQ==
X-Google-Smtp-Source: AGHT+IHyKkXj7bFHamDlhb852Q/c2KxdopTfCVoENlr9lgDt39iEHp5/omYhrGf0mlW3wl80G2nrEA==
X-Received: by 2002:a5d:59a2:0:b0:391:1218:d5f4 with SMTP id ffacd0b85a97d-3926d218075mr917718f8f.23.1741634858689;
        Mon, 10 Mar 2025 12:27:38 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3912bfdfdc5sm15554352f8f.25.2025.03.10.12.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Mar 2025 12:27:38 -0700 (PDT)
Date: Mon, 10 Mar 2025 22:27:34 +0300
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
Message-ID: <aab6d5f3-7ef9-4220-8b67-ee9b09a5f168@stanley.mountain>
References: <eaab1b7b-b33b-458b-a89a-81391bd2e6e8@stanley.mountain>
 <Z87e75UV0Qc4oY64@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z87e75UV0Qc4oY64@localhost.localdomain>

On Mon, Mar 10, 2025 at 01:45:35PM +0100, Michal Kubiak wrote:
> On Mon, Mar 10, 2025 at 01:48:27PM +0300, Dan Carpenter wrote:
> > This was supposed to set "FIELD_PREP(MTK_QTX_SCH_MAX_RATE_WEIGHT, 1)"
> > but there was typo and the | operation was missing and which turned
> > it into a no-op.
> > 
> > Fixes: f63959c7eec3 ("net: ethernet: mtk_eth_soc: implement multi-queue support for per-port queues")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > From static analysis, not tested.
> > 
> >  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > index 922330b3f4d7..9efef0e860da 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > @@ -757,7 +757,7 @@ static void mtk_set_queue_speed(struct mtk_eth *eth, unsigned int idx,
> >  		case SPEED_100:
> >  			val |= MTK_QTX_SCH_MAX_RATE_EN |
> >  			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_MAN, 1) |
> > -			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 5);
> > +			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 5) |
> >  			       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_WEIGHT, 1);
> >  			break;
> >  		case SPEED_1000:
> 
> 
> There's a similar bug a few lines above (line #737):
> 
> 	case SPEED_100:
> 		val |= MTK_QTX_SCH_MAX_RATE_EN |
> 		       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_MAN, 103) |
> 		       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_EXP, 3);
> 		       FIELD_PREP(MTK_QTX_SCH_MAX_RATE_WEIGHT, 1);
> 		break;
> 
> I think it would be reasonable to fix that too in the same patch.

Yes.  You're of course correct.  I'm trying to figure out why my
static checker found the one instance and not the other.  I will
send a v2.

regards,
dan carpenter


