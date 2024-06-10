Return-Path: <linux-kernel+bounces-208558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7869026CE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6641A281577
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E7714389B;
	Mon, 10 Jun 2024 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mGzbU5cN"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2141514387E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037261; cv=none; b=Rp9pC3INC3cW1Qvpq1ekZ+QKJQwaPloCFgY/6BArMbNLyf0Z2KNbusBuV/JSYt3GEKqYllATV2nKoUjRWUvqGXNkj62cZFqaWclPnX2cI7Q53syJ9uV5w11eG0+EEcx8ok7MT23iF1RsQ37/ckgW2M/arW7iCAR5vnHZsUyUD+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037261; c=relaxed/simple;
	bh=piTSS9jjVGMaUmkjcHVWQ3lRn0ub4PfPACxHNXWXx5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4q9uCdNJkZsoNi9TLn6L/x28os0LnjGIajJKxyVwZuw8GaYmIXGRbkRd0iteBXKCzdE2R5pmdu3dChRjD5CvjDncC4deFnbLBbR8uB2nyyHlT74PjYpUSKkQHpxL6kTEKiiXeYmrwONSX9AuCvkJ4K+ZEEaey8v+YSqnvwPyXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mGzbU5cN; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-6e620302b01so1738606a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718037259; x=1718642059; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5ZVwjIOaq5V5ku6UjCPO2SyGYT7pllWaiMtecMSfuM=;
        b=mGzbU5cN9lw39SBQbZdW06hKPmf1PLfH+VOTGybIzcFqW4EV/wxYfVB/LqnHJjLIne
         hWW1DrQO27VT40Yvc9O8FzbOtn+iLsb631AihPHwcVtl4l06J8Qqfkn3FrlxhH+4VU9e
         EXeq2mmo9AZdxio4NmZ/F32azI07evhqRa+e1rlrZcabNDgihk6UqJX3pb4JK4dbZlXC
         hlbBffrAggv1hn2qgRL1Qx1Ttdx3gwy37TUkokIDnt4ILjS0sBq+AYqVJxzlvcOOBUSY
         fu/2es4+7ovJHVYvDxXW9cnab3WPJ5vFYn7VE+ORN+3Nwr0vF+WRvvj/mzBcXreFT92P
         GIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718037259; x=1718642059;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5ZVwjIOaq5V5ku6UjCPO2SyGYT7pllWaiMtecMSfuM=;
        b=vnrO/0BnEdF7RtNSZo47RmhTSvuLeegQ2YrdZn41eq9bx68NS1dDUJvSKV/plihmFm
         2Pj3oVmc0LBJ+iPY+cGHBwnqOWYnpoU4H86QxYE+FbFwKLYjBRJvYbkwOxjUFvojdIO6
         EIN78fgGQf/VareXIawvJheN0Wev9vIR34ayVp3IS305Olh/tgsYKHU9qmqEkrwpZRcn
         A2CZb+ZvK3Pegt+ycbi4yzXZForGi/yd9ZXrLsRrhiNQgYCif+6fEcZNKDQjhMLvGcIY
         I8KNXLL9yKOVI1kpd+7d9y1wZs9ZXcaUo+x45ctOK1E05BTWacpQGmyR/0istX8cHuZ4
         UwcA==
X-Forwarded-Encrypted: i=1; AJvYcCWRvLEA0z+kHcvnpIVVQMZ91jY6wzR2eaFRskqeQlPtcZEnHuOq2Q+ymCq6H80Ws+IW8ld5fUgj6EFgtoTlKSBPX08IZD3mZPji245p
X-Gm-Message-State: AOJu0YwS4vo959GuP1dqIiyrqAoCGUAUM2EGlS5SWJ1LePDU3fYYJHDj
	eKSh8RWfgtsPVuF1mo6mwMFI/dmdj/zLQ5TSGaWddrVPqTGZiYbDd3hFHGS/zwA=
X-Google-Smtp-Source: AGHT+IFiC+4Uq+TF9IRTc1VdS1ljR22BVVSd4bbzZX2VtGNhB8sV09mNvEyNr5N0F8tE3bUBY+/nLQ==
X-Received: by 2002:a17:90b:33d0:b0:2c2:fdc5:2619 with SMTP id 98e67ed59e1d1-2c2fdc52e9bmr3594071a91.31.1718037259439;
        Mon, 10 Jun 2024 09:34:19 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:9b34:fecc:a6c:e2bc])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c2f8fbc87asm3495711a91.47.2024.06.10.09.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 09:34:18 -0700 (PDT)
Date: Mon, 10 Jun 2024 10:34:16 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jason-ch chen <jason-ch.chen@mediatek.corp-partner.google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Project_Global_Chrome_Upstream_Group@mediatek.com,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Jason Chen <Jason-ch.Chen@mediatek.com>
Subject: Re: [PATCH] remoteproc: mediatek: Increase MT8188 SCP core0 DRAM size
Message-ID: <ZmcrCLOCo0Q0W6AU@p14s>
References: <20240606090609.3199-1-jason-ch.chen@mediatek.corp-partner.google.com>
 <bc12b046-d2fb-48ae-bd5b-a6ef6cc78c07@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc12b046-d2fb-48ae-bd5b-a6ef6cc78c07@collabora.com>

On Thu, Jun 06, 2024 at 01:00:11PM +0200, AngeloGioacchino Del Regno wrote:
> Il 06/06/24 11:06, jason-ch chen ha scritto:
> > From: Jason Chen <Jason-ch.Chen@mediatek.com>
> > 
> > Increase MT8188 SCP core0 DRAM size for HEVC driver.

This is telling me _what_ gets done rather than _why_ it gets done.

> > 
> 
> ....so the second core only gets a maximum of 0x200000 of SRAM?
> I'm not sure how useful is the secondary SCP core, at this point, with so little
> available SRAM but... okay, as you wish.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> 
> > Signed-off-by: Jason Chen <Jason-ch.Chen@mediatek.com>
> > ---
> >   drivers/remoteproc/mtk_scp.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> > index b885a9a041e4..2119fc62c3f2 100644
> > --- a/drivers/remoteproc/mtk_scp.c
> > +++ b/drivers/remoteproc/mtk_scp.c
> > @@ -1390,7 +1390,7 @@ static const struct mtk_scp_sizes_data default_scp_sizes = {
> >   };
> >   static const struct mtk_scp_sizes_data mt8188_scp_sizes = {
> > -	.max_dram_size = 0x500000,
> > +	.max_dram_size = 0x800000,

Do you require to fix a "reserved-memory" node in a device tree file to account
for this?

Thanks,
Mathieu

> >   	.ipi_share_buffer_size = 600,
> >   };
> 
> 

