Return-Path: <linux-kernel+bounces-421889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D429D9178
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 06:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D722843D5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 05:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DCC13B29F;
	Tue, 26 Nov 2024 05:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bRGWo8WJ"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCDE8831
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 05:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732599938; cv=none; b=aJy1Cj610JpWvx6jgmm6/FrUo4oMs4at/bIKyDEfftt3LeJU8GR4JKP6amqwCSiCtT+N0iyR5AyPLe+O89KOoJVoHgIk3XjTCuy6DGkECexDd9M8d0FLzQbxwIifLiyd3nRXFd5BXDK5Nx1o2f0HVueBooakYNHuYplHcQg2ST0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732599938; c=relaxed/simple;
	bh=LduKrUiuF+o4ID5hULsbw3YjGls8uuInoe2CDUqrjnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozyWMAehRxktaxMhtSC9Yc7EDVJoEFjobEuuWuYOaiGmQUL4RYEI/Jg/PMs0RfSdXk1GpIWGAu1eJeyjx4R0rjkRYevNFF5dtoTFViKgXMPJ8/mNLg1IHwCsHs23hitDrW7+uEtISAj85kwQf3wXjm4eU3i85xN3RVD4Wvnq10I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bRGWo8WJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7251ce598adso478667b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 21:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732599935; x=1733204735; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ru8A8FYea7pWk45ZPv+cLA69r/6TsIev+AJUTgUfZ+o=;
        b=bRGWo8WJxb23tBA4xwr0/64TqF8c63yT94NYh3lUJB6ihPMJi/HKi6o04Bjpl9/lio
         W7jF5TX5E7eaWlgvQ85cHnD8YOBuo1MMaZEJFjpCTdnZrLCkst9UZoLPmo8oiExm8oSE
         kThWDQI64P5xa4hKkusGX1fSMyqYqLR0OC+LwEle/UG4FZv8VihxMFKVaNe/Ap3tupM7
         gl5CDXrnxHyOJn2/pJ0aDVK1Ye+0kEpYJb0dPQ5ASFF1xkdI0bMGmqKAAdtiXQ5ysRxj
         FGDL+HCx7ZMDavP6BIetAmLWMzGtzlVNbgoQrvKsj8O8Xiammk/ezjei9oxayPgd8omn
         leWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732599935; x=1733204735;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ru8A8FYea7pWk45ZPv+cLA69r/6TsIev+AJUTgUfZ+o=;
        b=dkX5XERLMv5UZl31GGs5i9NcS8cJkNx+Ycz9BPIAmsAqBG0oaMABwRowQM0Y0Nh5ht
         KfufLGsRZlBEAJt6qgHu8r2qrid/aF/GmSDG0F0IAjaxFXgsX4fhYkH9TkDCg9mP27yI
         ak76wkW58IHlAzxuZgMTgbyswY8bwVMQ/Pm1fYds5Tk+MwEHtP1MJRyfLiabr/6YStDR
         2nG+GtSzGKDjZxSXPID0L5Qao4f0ejck3/bIwH3nh2uBVot9R+RLHJxRqWSyHCCVRRn9
         yIMVl3km0QBCvScRxbJV77yX3PxSEsZDNYTF4eQI1kJ8jd9ot+M+zb6jnuI++naxEaKa
         035Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVA95JUDqkZ8GnqseIpbsrsRNGRzv1jy/IJVcihLxUnVhF2o8IylmkNFEx/FPDdDPVAAKOqFpu1Vt6EeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycmay3W5DMxgUkQrpKg2KTPIhidNNRi7g94Phknvlu4Bg/uKKx
	ydAmskBxl4fRmVpfydDMxWQBz2Anjn+VAHZpU6SswrAVhDC2cXC3ww1zROg4yg==
X-Gm-Gg: ASbGnct/Gcpsd0kbbyEqLmbhXNCWL6R+AdLAkJCJCAx2snxvQNvY7N4zauGjZB+3EsG
	5uKyL05Y4eQJZYkgtqRAULEAFnvknNCdnrLBz3or7iyLop6D9oI94quRihv0ON3uRIStHEi2l6T
	thbqZYUterHDtb7/Wl6fMw/q/0siJof6U5r8/78WjjRpb1jl65irUXJAxcrtuMSjxiCLHD2ngh+
	XQPj8bY2DX5DOn1scGp/vmSUvOoF1DMgMV6sKvBVUTZplm2bjJmLM+gv7k1lWI=
X-Google-Smtp-Source: AGHT+IEBdAbqM+xFjnu+5Y3RUrCVenb/3lk9NHI94YHgWcVczPs6/2qW10NRSJW4WAL4o0zVcC2bbg==
X-Received: by 2002:a05:6a00:244e:b0:71d:f510:b791 with SMTP id d2e1a72fcca58-724df5ee500mr20478083b3a.12.1732599935009;
        Mon, 25 Nov 2024 21:45:35 -0800 (PST)
Received: from thinkpad ([220.158.156.172])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de454ae5sm7505161b3a.7.2024.11.25.21.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 21:45:34 -0800 (PST)
Date: Tue, 26 Nov 2024 11:15:29 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	bbrezillon@kernel.org, linux-mtd@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_srichara@quicinc.com, quic_varada@quicinc.com,
	quic_nainmeht@quicinc.com, quic_laksd@quicinc.com
Subject: Re: [PATCH v2 3/3] mtd: rawnand: qcom: Fix read len for onfi param
 page
Message-ID: <20241126054529.ewoajuaor4wpa4xe@thinkpad>
References: <20241122085933.2663927-1-quic_mdalam@quicinc.com>
 <20241122085933.2663927-4-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241122085933.2663927-4-quic_mdalam@quicinc.com>

On Fri, Nov 22, 2024 at 02:29:33PM +0530, Md Sadre Alam wrote:
> The minimum size to fetch the data from device to QPIC buffer
> is 512-bytes. If size is less than 512-bytes the data will not be
> protected by ECC as per QPIC standard. So while reading onfi parameter
> page from NAND device setting nandc->buf_count = 512.

s/setting/set

> 
> Cc: stable@vger.kernel.org
> Fixes: 89550beb098e ("mtd: rawnand: qcom: Implement exec_op()")
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> Change in [v2]
> 
> * Set buf_count to 512 in the parameter page read
> 
> Change in [v1]
> 
> * This patch was not included in v1
> 
>  drivers/mtd/nand/raw/qcom_nandc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/nand/raw/qcom_nandc.c b/drivers/mtd/nand/raw/qcom_nandc.c
> index 31ec3db1246d..e1dca4857754 100644
> --- a/drivers/mtd/nand/raw/qcom_nandc.c
> +++ b/drivers/mtd/nand/raw/qcom_nandc.c
> @@ -2926,7 +2926,7 @@ static int qcom_param_page_type_exec(struct nand_chip *chip,  const struct nand_
>  		write_reg_dma(nandc, NAND_DEV_CMD1, 1, NAND_BAM_NEXT_SGL);
>  	}
>  
> -	nandc->buf_count = len;
> +	nandc->buf_count = 512;
>  	memset(nandc->data_buffer, 0xff, nandc->buf_count);
>  
>  	config_nand_single_cw_page_read(chip, false, 0);
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

