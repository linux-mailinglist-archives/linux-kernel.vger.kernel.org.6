Return-Path: <linux-kernel+bounces-192247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 954AE8D1A9B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 14:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A850B277B3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F13416D9B8;
	Tue, 28 May 2024 12:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M7A6YcIO"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF0916D9A8
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 12:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897867; cv=none; b=uyqsT8fzqv2NVtKqPoB4cPe4LB9mwXkMJ2/cuHoOxpMAzj1QtGMZysBwqOorxZ+tQD+5Skp0TXCcDk343hNLyuGqIORjxn6yzPCmzhqObDOxh94uto/pmSP5Y6n4tMb60uGC8ekcDMXgIlLa6nYbPUowhWtzkk5rX/iFkpetd3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897867; c=relaxed/simple;
	bh=0Ij/KINcYLHPBuKsXbihOyL1OmkuLW0/wwn/yRXpAPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIRCNUGNAeCYhTX3AAHNdqtrgSHvhzM0tdpxfZ6S+fz/jgKNTPf4VE4k1ULhVmxQ5+J4E/TV6dK3Y3rMwI+MSyJv0RDfSGRqi37LEFXkbAzZWtxHmDw9lo+p4Z/zTUOPIEwpMQ2IkpdqRjqQO43Od7HLX4S38kjmHKDdMdusdH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=M7A6YcIO; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-529be98ad96so460439e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 05:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716897864; x=1717502664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k2n1mamSB8aQSoN8jQVWr+bWDjxdAuW2QMP/FZUKGCc=;
        b=M7A6YcIO3qiC7ut2bLihDd1x9duWN01yTvxox4yDOaqnlicjikjPJZfn33RHvrZukE
         oCuNNEHcr2L7I2E7z8+MTjjId/rA/iG3EPUcCbcobX1aLvkAN+8R+n8HVzioTz4SEz8J
         KRoz0Tl2yE1mYkIwGCV8e5ZoaUDB56u1C2eaMNRbCLbS95TxrvN8qvS1NidWbXx5uDhc
         euxjrMbPyoLFDjRxvX8tcNLioYeVm+Ovb0ZnwkyeQ9Qk8KJChSyMmx0ERYMZd8O/pdGS
         icEl+AsfT0DKHg9l90bmzjAQ8Yt7kH1OXhilU9HemtlO3pRTiD2O7H69jG7C/pcT08Pr
         InRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716897864; x=1717502664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2n1mamSB8aQSoN8jQVWr+bWDjxdAuW2QMP/FZUKGCc=;
        b=C8d0qsHrZScmDX/7qdJnzvn7cghNuGecXWBubyiUuvTORfOFrcNRs37dCgp7NjnXdT
         udUdNHQQkD12O3e3ePtbVDYZW2X8q/U4K1CgJ7PCRuKfFLzZJDFOlOjWQHExA0iyhvTL
         DDXCIoEBlxGC3X6sMq31WRDgyqId5pH4BsCjpUHowuAlMB4rd6nz9rwmfjHNhXwt7BgZ
         LFtpAwdPG1gzq0luR6bvpRi/tNGcJlfzHtnqhcvaoZ7tH0vbQuunuJcTyxfN9agaHcvk
         9nLV7rvcB3xZDVL4wawAeUlRJDsQAEOV++dYZ+2EB/CV5dCVONj6IrpV71IA17u7XY+g
         sHfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj+uWC1eAH0ftUIwTgyB1tg/dnMt33LhvQkLH98T4BEXDpe/2H89JhUMyVOY8rE7Vv3hH0ODmzJ+kdDaC45uf4H7M7sGrsEM4YlZ11
X-Gm-Message-State: AOJu0YyyRpyNojQ71HF/EWILz5XRqKX4ZsYRMBnTONmeg3e6aVFMD8ze
	HsN2cnsXdK9DMRy0x1MG30WDCTfS4BUpgxV9vEd2MWd6ReuWoLLPx9Ly5bgOvik=
X-Google-Smtp-Source: AGHT+IEIY8A2npesmQ3mUf/n2t3PJAROyuphDhmkYyXfqog/2OjGf7gOc5Dbz4rYw0IFdScb/Le5lg==
X-Received: by 2002:ac2:4e94:0:b0:524:6cb:586b with SMTP id 2adb3069b0e04-52964baf2ecmr5596283e87.23.1716897863607;
        Tue, 28 May 2024 05:04:23 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52970c33106sm937924e87.190.2024.05.28.05.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 05:04:23 -0700 (PDT)
Date: Tue, 28 May 2024 15:04:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com
Subject: Re: [PATCH v2 1/8] misc: fastrpc: Add missing dev_err newlines
Message-ID: <shdxqx4x5mghqt3dcvrum73ox4ygm4xv2cclkjnbvqqbe2y465@uboh3rl6kbt6>
References: <20240528112956.5979-1-quic_ekangupt@quicinc.com>
 <20240528112956.5979-2-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528112956.5979-2-quic_ekangupt@quicinc.com>

On Tue, May 28, 2024 at 04:59:47PM +0530, Ekansh Gupta wrote:
> Few dev_err calls are missing newlines. This can result in unrelated
> lines getting appended which might make logs difficult to understand.
> Add trailing newlines to avoid this.
> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

