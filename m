Return-Path: <linux-kernel+bounces-207740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A79901B45
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 08:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA72E1C210A9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 06:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5611946F;
	Mon, 10 Jun 2024 06:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MNNpsrM/"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D90E628
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718001094; cv=none; b=mC1hIxfz4eA4Kuu00WyX+KHTznL2QLE/t6TQCqrkYA+nU44imutJLiTb2Zt3eDFywP5DJZJvQ4qykgnrEKZzXwOMlmvaQwtoM6d6cHdwkjb/hzy6aaR1kwu1snx0nn7Jop/byNKFJ2djAEuUXOPsJ/HXKp2lWCme6UMasHzeEsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718001094; c=relaxed/simple;
	bh=N2noYsSnZJffPMWVBvrKUxmMIE7p3Vrjzwc2uv2QjfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkoQvyndPtCS4LglDh69yNCsDTilWRHAKsffmXSbw3aIBRgiUPFRjr+ntkTPqZCAj5lYX2pFeGxvxVTA3OO6NOJBypaaJP1ebNnkmCEco8k6p6SfbNbvrDgiddO7v9U+xLztVXPs8vtfoyCidCdFzKFtaZ83nFNj1xqNYq7A7mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MNNpsrM/; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ebe0a81dc8so10129521fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Jun 2024 23:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718001091; x=1718605891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0foBbzkj/yZAJLvDMQGWe5daB0oiOZ9HEzG6T9Jt6MY=;
        b=MNNpsrM/OKtH+5O43YIxRKWxKn+hrwPrZu/vHSrXmRQ2rZf/UmhwyYkJVOzOPbew1U
         V3zRtaip5J0z7Xt5vf59D1fDw4ASrcZ4uwrlt+wa6jEN70Jgf9U5zLG4pXJuEeMsbJFO
         TxWhax5DqPfUkWejzaLEy+3QK2F1OjUzJ+2up5DKcO7I5GFUFg//zioxk3nC95COoTy+
         3eECb527ZrTCgyoQIMHLpize4hmQ5HdFqpCNDCRcCoz6pZmDLPNWjWa2Cfoizw/Z9rXu
         WJePR8t9M0bV6pAt1Iqns8TgM3eM1LFuemG/wOcnx9MdDSaEYovMo8wTOAx+XzY8ZgAJ
         epsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718001091; x=1718605891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0foBbzkj/yZAJLvDMQGWe5daB0oiOZ9HEzG6T9Jt6MY=;
        b=rVEgkWgWDXczNDjKjL08d1GyWe1P6AOpJzvf5BK11E8AJIYrf4m9ri+61NMRGMp9j2
         CjKGTZmESQYoemSkreVLGOp3Kn+UHmVEKsJHyPAcFA81fn1p+SXG0A1aqAiAD/Prx+4D
         I73xcDUrSDOMdHbZTSkfD70H9mEsnnKUDAr40Sz6QDARw6Wz7CUwrXcUIInnUSQ8DLzT
         jKK+SxydOR9kkVlmGnOTcUDNCphkSVqpanhHxD3BmIW6UYn07Hu1S/ZEebiVBXUDBRFd
         fE3tkMnB6wMQq63vEsX4Zl54asug+IiPauRPLHXN7dXAux2rHX3qwEZimLCyKBTXQ7/I
         EAyQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQXQY2NbutM+t2fCD2zez9bNImJ9ppEJQPiD7M+68hLgyMRTsHal5EvkoHLxMAB25Ddx25EkCQ0xf7m1Dkl74MQcEdwYEkayFC4DpW
X-Gm-Message-State: AOJu0Yx579P/RMnaYbXmYwYhdTZHHxpoieWsD/XleNk1rcIF59TtiqKJ
	421LlCE2RayA31yWJ7JROIGune6XM1iVT8pqeMTqHIZqNc5lFRdilC5/UUnHnDY=
X-Google-Smtp-Source: AGHT+IEbjxnLFduuLjONOUTvHtbpIgLNsmw/X8E0xtaG1CKGLDAlODB+2oaqYGwqaaw0WtMBz4VOhA==
X-Received: by 2002:a05:651c:1042:b0:2eb:d5a9:40fd with SMTP id 38308e7fff4ca-2ebd5a942d2mr39653051fa.53.1718001090636;
        Sun, 09 Jun 2024 23:31:30 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ebe673fe28sm4103891fa.53.2024.06.09.23.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 23:31:30 -0700 (PDT)
Date: Mon, 10 Jun 2024 09:31:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Kiarash Hajian <kiarash8112hajian@gmail.com>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/a6xx: request memory region
Message-ID: <oa62wijdvxhcoamynii2szxaxfmutkzup5djstgqzrfe4sjizu@vnz73mhhlgss>
References: <20240608-adreno-v1-1-2e470480eee7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240608-adreno-v1-1-2e470480eee7@gmail.com>

On Sat, Jun 08, 2024 at 11:43:47AM -0400, Kiarash Hajian wrote:
> The driver's memory regions are currently just ioremap()ed, but not
> reserved through a request. That's not a bug, but having the request is
> a little more robust.
> 
> Implement the region-request through the corresponding managed
> devres-function.
> 
> Signed-off-by: Kiarash Hajian <kiarash8112hajian@gmail.com>
> ---
> Changes in v6:
>     -Fix compile error
>     -Link to v5: https://lore.kernel.org/all/20240607-memory-v1-1-8664f52fc2a1@gmail.com
> 
> Changes in v5:
>     - Fix error hanlding problems.
>     - Link to v4: https://lore.kernel.org/r/20240512-msm-adreno-memory-region-v4-1-3881a64088e6@gmail.com
>     
> Changes in v4:
>     - Combine v3 commits into a singel commit
>     - Link to v3: https://lore.kernel.org/r/20240512-msm-adreno-memory-region-v3-0-0a728ad45010@gmail.com
>     
> Changes in v3:
>     - Remove redundant devm_iounmap calls, relying on devres for automatic resource cleanup.
>     
> Changes in v2:
>     - update the subject prefix to "drm/msm/a6xx:", to match the majority of other changes to this file.
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 33 +++++++++++----------------------
>  1 file changed, 11 insertions(+), 22 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

