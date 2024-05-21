Return-Path: <linux-kernel+bounces-185228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6698CB269
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19DCEB227FC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4D62E620;
	Tue, 21 May 2024 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P1vr8UKl"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F51F1FBB
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 16:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716310058; cv=none; b=HALcrsoTgD9KZwBYefNBAi+hGe20D8ALOl9Qn73bCl1SOL8eDObcvPx3lx+5JwdbwuczE48RAdKm415l/CF5iXFCXvHiiHUSrmrtug8k2v0qKVGmeC7faQNgH/ZgLP5CQzk3ODewYKtmm8re+WmrI1zFZOcBaCBgZ+SobTvmR0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716310058; c=relaxed/simple;
	bh=7iOACG5IfAwJdby/0fwuDdIGvtdK3YwQtEFtX0fPrkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p8DaDDJI6FqxaxHaNIUq9NcfJgSvIGaGY/BScU9lNFWiM845K7Iax9qdThvgz/BNLdaIarjv8ou4jvyT1NZyZ2iDgOyhW8iDMLcZs9tXcUpMzwB6CvmsM8H1266gpwv0DPyRwShvISRTkvT5cYl/aMcBSG4PQ6AJLmfYdg76SQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P1vr8UKl; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6f67f4bebadso557075b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716310056; x=1716914856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PZAIDSZz5noc6if4QKqooN9MLNYkeL9UbakI+8iRBos=;
        b=P1vr8UKl70aTwginlilJZb+vlUxgG6NpmM1BZ8cHGDE1j3UirMTlGYF1UMF4bqTyrG
         x02MCGUxqFpjwERKKh/qAQPKtzxN679ahg29hNLRkAH5SboMnYsBULDhGhdLd7ysCI2l
         blmkyU8J49BSz6m991r0ULZnYpPo6zqkR0ne0X9Mac90Dj9yczmO1cyAO4SdVvH0mDI0
         5O8rFf5CyLnOtdT6oRbx5TAVrCmThYkOLBY39sH4c7fQbBdwRfDtscl9V5hCclbR/DuD
         hdlJ0HLGeZ8Ta93Hn8cLNVrBkXOEK/L2O7K/oeVhaWqVhSo16ZtRBr8wNv3nokLElWfk
         1p9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716310056; x=1716914856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZAIDSZz5noc6if4QKqooN9MLNYkeL9UbakI+8iRBos=;
        b=emdwWuJMOfRbgQHqLJeCcs2AREA3c0H8dPPws6FVgTHyeqQGP8YuCZFqd9YCmpE4IS
         sfjMpfwx8nXp8FRC5tbrPE0qgpB2pKe/vEtVV9uJAME9arP8pIQN86OMP+RzOn7qEraV
         2NyIDivmDa28+3UQEm+3P4ziw5ee13fKWoMPvPp5MPg4QA9khOngu/bcwp40LfgKOJAV
         Po5B3Q6QBVzi0wuHR0wNTh/pmQooW5d1n0i2N0mIDueSyowiZrAVDV7sq14q0ZXq8plr
         JTh3M1wPz9X5adl+sLl6yD0pCWWovtbVObXNhA08u0dnylTAWgS8FBx2ljM1G3Gz1wEN
         CZYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4ikF9UYpR6rr5NvFAZpVLkYEEjyxZPNve9hHgc9gQ1V36hVykQeOUBUlHKDxhXT7hpPj4qgTptwkOHmTCCsZEr1Wn7t6v1BaMTKTO
X-Gm-Message-State: AOJu0YwG8igvkPj4OCf61HVVFK3BP8jQ9lukxVUtGvR01yZbBEdeJnIL
	9JIt67tdeW9WCZ07P4yAkhQ71aG4KJo3F3GrSgm41m/JCDZcUb7XMVs21pkPwis=
X-Google-Smtp-Source: AGHT+IEM61ROSOw0CzG0X8FSdmCEEg6WGFlarYhclikyQ2fR7QmVIqgP4xaOcvcYDgnr0vf49H+LBA==
X-Received: by 2002:a05:6a00:2284:b0:6ee:1d68:d33 with SMTP id d2e1a72fcca58-6f4e02ca2abmr35478343b3a.15.1716310056526;
        Tue, 21 May 2024 09:47:36 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:df1a:22de:40b2:f110])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6584e7897bdsm9707304a12.21.2024.05.21.09.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 09:47:36 -0700 (PDT)
Date: Tue, 21 May 2024 10:47:33 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: andersson@kernel.org, matthias.bgg@gmail.com,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH] remoteproc: mediatek: Zero out only remaining bytes of
 IPI buffer
Message-ID: <ZkzQJepyjPz4Su+k@p14s>
References: <20240520112724.139945-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520112724.139945-1-angelogioacchino.delregno@collabora.com>

On Mon, May 20, 2024 at 01:27:24PM +0200, AngeloGioacchino Del Regno wrote:
> In scp_ipi_handler(), instead of zeroing out the entire shared
> buffer, which may be as large as 600 bytes, overwrite it with the
> received data, then zero out only the remaining bytes.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/remoteproc/mtk_scp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index e5214d43181e..dc70cf7db44d 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -117,8 +117,8 @@ static void scp_ipi_handler(struct mtk_scp *scp)
>  		return;
>  	}
>  
> -	memset(scp->share_buf, 0, scp_sizes->ipi_share_buffer_size);
>  	memcpy_fromio(scp->share_buf, &rcv_obj->share_buf, len);
> +	memset(&scp->share_buf[len], 0, scp_sizes->ipi_share_buffer_size - len);

I will apply this patch when rc1 comes out next week.

Thanks,
Mathieu

>  	handler(scp->share_buf, len, ipi_desc[id].priv);
>  	scp_ipi_unlock(scp, id);
>  
> -- 
> 2.45.1
> 

