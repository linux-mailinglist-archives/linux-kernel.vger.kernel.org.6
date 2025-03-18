Return-Path: <linux-kernel+bounces-565615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E81CA66BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:38:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED06E17EDBA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9508E1F4C8C;
	Tue, 18 Mar 2025 07:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MGMtVzjB"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0031DE3A5
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 07:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283327; cv=none; b=M8E9yda6JRgrAuFV68hLesx/1KKsuElY8OJYR9FZ2f++1H3UlirgQweABk5nWcibrrj/IXYa/KLsyNJaW08iyubXMbesKjBn1TRfy54XnpYtLU6D3U9Z1vdXFiEr4Jr01OcndtCzvkEeX37Yay9NoNllwF6J9btK+rfp9GGEsYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283327; c=relaxed/simple;
	bh=bT2WkAI4t1LM3JXg9m1Nj3B6KFZFFVc1xKtjtfEM7vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpCIi2Wmi8z0NBSCydtXswEHWy7b2HUU3qrfDTgRHIkCZTnKqxdtrXdmU/firtW43qTcX33z+EMDTvvQuRDs+bEu6qP3MA0KfZFVtkDdiDJb94ToGJWS565b4STN2297zHV4fsCTEYeFcHCgqoSRl1RJFDIV0O5g7ojGWM3+lJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MGMtVzjB; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-226185948ffso34155275ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742283324; x=1742888124; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ti9mkkr8qvTbrEt9TTTW4ivjULJ5uCNkrYEb+oujtBo=;
        b=MGMtVzjBGvcgbTTagJpUCUqw0MQAxwa1eZ35tPIi2qRQ2dIr14Baz3PqJp2w8ZYhdW
         y4wNss2Z299JDVJPxcAPnDw1tjaWReMBE/PYh83etDMf5Ll1TTGdnVD2QTnuzpe81x6O
         tV5xe983f1Imxvw/Q5lvcDNgW0aFvrMtkt85nKNbXqLewbTPWZrxWQ/vjUMn8Q3SckAZ
         UQTx3wv3jr/7FdXPNoxvWb6ou6jcs1vgwT085R7dCC2BzttqxeN0hTKSQUE0CgzS8g8w
         7mvz/Udow/pakNIkPEJBf9YCekFf1lqbZ+LHRTCPB1dZMHjCyZZD4HTpQpFg1obXhUjP
         A00A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742283324; x=1742888124;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ti9mkkr8qvTbrEt9TTTW4ivjULJ5uCNkrYEb+oujtBo=;
        b=vUBqGTY6Sl0QDBka0ExOAXVT4FuNyG78gBQlD+MI00m0GSNrVdYmFt4MjSYv5ycpb4
         /gFt3u0KpydRdfEm4D+5y+0TMa7GOObusTEI79SLVfhza9/qir2MDxZswYbgRmYj/QD1
         FNU/K6VHlceSxFtoMDE5ozmUnWkT73nvR3D4/yhskYdHtIWkUHW8okfz9NbaozjX0J8a
         BEdS6yLGqUvaFWaVXH0qRgMw6jGDtoI2ZSd5Ei/Td4mRybg0+8P6qJzjKKAuWOF4/a8+
         oHccurreqd15BMRlEHp9AF91rXpvXzhge/RKv1oj3/OJ5xSzpA4fjnKZd59E5JyNCqGe
         G5mA==
X-Forwarded-Encrypted: i=1; AJvYcCUXkWYRlce9s3CGjIsTG5jvm8wG+RsAF19560UPXKTfnpy4DBEPK08k9WWo3N5MZHvm1+E+7KjoNjoTvvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVwhvgXYZamkBYamjSKcxhj/1oBeT0SMhn+f47v0GphECu0sH9
	kxnlRzQxzGBnfLqWHvbm7BbA1pw4cRLfgSqgiVkPhZvKPMmmyOlQ7xqfZzsSsA==
X-Gm-Gg: ASbGncvs9la4OlSI/8U4CvDp9YjhODyXvYoPJ81xa+AvcEHXDFI0T4M9/ZmXuH/oyYq
	wQGz22l/eoV3qX0+r+Me3f8DP+S37ZN1b2j3DIZ6awpV70C2Pq2kfaPp3IkixFlKr9qpBRG/LAO
	1eJIQWiA9Eq98kHhCMpvDr6diKVU/+PKfle131/dA16hfDNs37d89Yjzp5AJRj2/TZ+CvB38jO3
	/r1FRsMH1aJFSUcq2s2NtsfcpCzB9HET5D6IqmbJErsWWBsIkxHEVQwiGnJyrv7H3i1dmGZx7cO
	6QdNl9MRkXXIScSGab2Q/M+CwdiZr3lVCRIXRinvUglP9sUCrEsVIL0d
X-Google-Smtp-Source: AGHT+IHmw89wtVmgBhfVxX9PTZBqglKeGhES/xurGrbMglniid1oBlbFanI6j4PT2q5RJtFbNqS0gg==
X-Received: by 2002:a17:902:ce81:b0:223:3ef1:a30a with SMTP id d9443c01a7336-2262c611213mr25670245ad.45.1742283324004;
        Tue, 18 Mar 2025 00:35:24 -0700 (PDT)
Received: from thinkpad ([120.56.195.170])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd3d5bsm87724655ad.217.2025.03.18.00.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 00:35:23 -0700 (PDT)
Date: Tue, 18 Mar 2025 13:05:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Md Sadre Alam <quic_mdalam@quicinc.com>
Cc: miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
	broonie@kernel.org, bbrezillon@kernel.org,
	linux-mtd@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 4/4] spi: spi-qpic-snand: set nandc_offset for ipq9574
Message-ID: <20250318073519.pgise5vnlu2aha5u@thinkpad>
References: <20250310120906.1577292-1-quic_mdalam@quicinc.com>
 <20250310120906.1577292-5-quic_mdalam@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310120906.1577292-5-quic_mdalam@quicinc.com>

On Mon, Mar 10, 2025 at 05:39:06PM +0530, Md Sadre Alam wrote:
> The BAM block expects NAND register addresses to be computed based on
> the NAND register offset from QPIC base. This value is 0x30000 for
> ipq9574. Update the 'nandc_offset' value in the qcom_nandc_props
> appropriately.
> 
> Signed-off-by: Md Sadre Alam <quic_mdalam@quicinc.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> 
> Change in [v3]
> 
> * Added nand_offset for proper address calculation
>   for newer Socs
> 
> Change in [v2]
> 
> * This patch was not part of v2
> 
> Change in [v1]
> 
> * This patch was not part of v1
> 
>  drivers/spi/spi-qpic-snand.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
> index 8c413a6a5152..85a742e21cf9 100644
> --- a/drivers/spi/spi-qpic-snand.c
> +++ b/drivers/spi/spi-qpic-snand.c
> @@ -1604,6 +1604,7 @@ static void qcom_spi_remove(struct platform_device *pdev)
>  static const struct qcom_nandc_props ipq9574_snandc_props = {
>  	.dev_cmd_reg_start = 0x7000,
>  	.supports_bam = true,
> +	.nandc_offset = 0x30000,
>  };
>  
>  static const struct of_device_id qcom_snandc_of_match[] = {
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

