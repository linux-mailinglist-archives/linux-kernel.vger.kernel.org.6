Return-Path: <linux-kernel+bounces-421891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE629D917D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 06:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F24BB23FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 05:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEDA15575F;
	Tue, 26 Nov 2024 05:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tnqzw4s1"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC267E76D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 05:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732600175; cv=none; b=s7Zzbk+vtbOm//N/WTA3GjnLjZ4hYzY7ZvWTznfDw7rQH+A3Ex5yMLff90Xp6KHCvapsVxKGraw892jYECNpqs6Bip2IdtI/bldyZeGU8e+/Ij0sQQG6L2o1mg5P83aXpMJ8OuEdu3pSkTKqlqtQ/YNU877l47w7Q4m8FX2rZ2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732600175; c=relaxed/simple;
	bh=MKtnIf+LS1N4QSySgV/jc8UR+T4LSGB7cnpXs46QdME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdmSZMRcX7fJ92MaCxnYNpHJJkPAgC2twWLxJa3ULYxTBpTECpg0C30SSL9TFRBbEx1nQGBcHorAcndLZX1PoXrD30syLcm6oz+TfVLJfFhCQl0MWLKA7QGZRN8oFoW+toxaUl9rTQA0Ny7D6HXj5TDjVanHgVBW5gs83YiySCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tnqzw4s1; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ea8c4ce232so4636725a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 21:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732600172; x=1733204972; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UB6HIiB9fYrnHWsQY2vK1iIVeNJm/snUPz8wyR7wZsQ=;
        b=Tnqzw4s1M2eLcNsPMwnqrxp0yvkTKRbm5Hg9CnwfEc9MeCURz701QX3Jb8kOxMT8vM
         zgP/PsEmH84hdoRoUn1stW2Rgqy5rUzJZKd1d9xqJ/XHZe7nxHWdLRdlraalsoE3ib34
         +AGn3VU+wTWjm/U0Q7rJJZ3a/gOtp5c3iKrG97zubezLVG1pWxFiJrbJQOrEaBi/2XAi
         Rm5Utj62DBxuy5ntO8K3Mae4d7EkIDD2+etZpc4/vFuZKWFSO+cPAP5TYktqJkD2vRZ9
         xShmuDC9aG48BHu+jjSoCdueFJ2/J71ZgMHCJbZUJiYq7+cDQFUe33a3s/B1NLedz4J6
         +4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732600172; x=1733204972;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UB6HIiB9fYrnHWsQY2vK1iIVeNJm/snUPz8wyR7wZsQ=;
        b=K0BknfO1qV4R5V+dcKYZoXyI7yLMJO43gYKdJ7MiGOMedm/Hq3+BwoWYFIwzcyI+FY
         sbJpNxZsUGIuc3YAgLSCYjglx6W2EdllveRk7BudM2rbL9u0j4jlv3bFKwF74FeuJEoA
         mqGoE0wD/T91B6neBIpiFqgRVSWqWF74/SRxgR4JCqRUyFMkTMJOorlLhbw5Dk7Arv8S
         X2NsWiyxiGxmSfpfWiwmrj2s2e9uUWRLDgebYt7TymkMkRGy7gvFcLikxscGwvFvUcGc
         lJGcdST57fn4ZmS+y5KlduLWvqCB6LaZ9NsuCHlB7b6vHSQegl4QLvVWVftXlEiyUXr9
         5x9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUj9Bb/Kzvks+esZ788UwxhX22Qmz66kMvHRlZs0tSjoDMq4H+hpnEA9PXP/4QodoyUFseKFwT9UteuR/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YymEsfDi3ErbUYOnj0nw5DcCQXFHRkJ90oNIsOUJuNkUvWRbAY9
	xt0ak1D0lYPm+NvoYQ3TdSzujqkoNCcZrgSqwdNkP/BFTk1NsS4ZCCGaCoezvQ==
X-Gm-Gg: ASbGncvw69rdhtbpBEGMUMBXCwoxYPrmhNB2kngUa02KDyCrEaKKON/u3qxMqlYtcAy
	fkPLU36JKGCp3jIwNa663TbwDDIcaTbMLh2WJ1unoz0KJHVwGOpCrInR7kaTI2P0qjtVapTRwBW
	VcfEwVZibjjdstcmMhdIpg6Pkc1ktg3MhD0Wx5Hr/Vkh+w/aKrdP7di89EZ/ulNJv36sF7Iw8BC
	aLKDIfhi4I8+u43BdxpNxlprGBJAL27hS9QxdGTMjVAM+Kwgad/JKFqjfxn/OY=
X-Google-Smtp-Source: AGHT+IH7A4RpJtC++YPuYB5MX3HiLhpx1EDYwGMi9/FEGgV6zpbeHZux/sYsnjCByhEA+eq00AHWQw==
X-Received: by 2002:a05:6a20:9d94:b0:1db:ec6b:ba13 with SMTP id adf61e73a8af0-1e09e4178aemr23288221637.12.1732600172510;
        Mon, 25 Nov 2024 21:49:32 -0800 (PST)
Received: from thinkpad ([220.158.156.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de474c9fsm7503389b3a.44.2024.11.25.21.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 21:49:32 -0800 (PST)
Date: Tue, 26 Nov 2024 11:19:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	bbrezillon@kernel.org, linux-mtd@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_srichara@quicinc.com, quic_varada@quicinc.com,
	quic_nainmeht@quicinc.com, quic_laksd@quicinc.com
Subject: Re: [PATCH v2 3/3] mtd: rawnand: qcom: Fix read len for onfi param
 page
Message-ID: <20241126054926.w2y3q4qnwiyatw5x@thinkpad>
References: <20241122085933.2663927-1-quic_mdalam@quicinc.com>
 <20241122085933.2663927-4-quic_mdalam@quicinc.com>
 <20241126054529.ewoajuaor4wpa4xe@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241126054529.ewoajuaor4wpa4xe@thinkpad>

On Tue, Nov 26, 2024 at 11:15:35AM +0530, Manivannan Sadhasivam wrote:
> On Fri, Nov 22, 2024 at 02:29:33PM +0530, Md Sadre Alam wrote:
> > The minimum size to fetch the data from device to QPIC buffer
> > is 512-bytes. If size is less than 512-bytes the data will not be
> > protected by ECC as per QPIC standard. So while reading onfi parameter
> > page from NAND device setting nandc->buf_count = 512.
> 
> s/setting/set
> 
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 89550beb098e ("mtd: rawnand: qcom: Implement exec_op()")
> > Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 

This was a mistake. I didn't intend to give this tag.

- Mani

> - Mani
> 
> > ---
> > 
> > Change in [v2]
> > 
> > * Set buf_count to 512 in the parameter page read
> > 
> > Change in [v1]
> > 
> > * This patch was not included in v1
> > 
> >  drivers/mtd/nand/raw/qcom_nandc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> > index 31ec3db1246d..e1dca4857754 100644
> > --- a/drivers/mtd/nand/raw/qcom_nandc.c
> > +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> > @@ -2926,7 +2926,7 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
> >  		write_reg_dma(nandc, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
> >  	}
> >  
> > -	nandc->buf_count = len;
> > +	nandc->buf_count = 512;
> >  	memset(nandc->data_buffer, 0xff, nandc->buf_count);
> >  
> >  	config_nand_single_cw_page_read(chip, false, 0);
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

