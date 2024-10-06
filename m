Return-Path: <linux-kernel+bounces-352515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC1099203B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041D0281942
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 18:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959B7184F;
	Sun,  6 Oct 2024 18:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kwtsEHFu"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B59A932
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728237947; cv=none; b=lXvVWv1yCI3hvkVYezLwV0ilWK5A+77PvKY6UBlzJ8NIexfW8glh5ozzc1nsYYhAYB5spqy85TYejG9FKjfvzz6jv6a4RN2NvF/QlbCG3qtTrCzHKJviTRxE4GKpW3dGjoWz35qOfoUKLvqcgBiBx657KeWAUyb6RV3OU0P6ORg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728237947; c=relaxed/simple;
	bh=CeCY6OlU97fOl5fAIAjg4El2sF2r4zcPwjhHQh45MiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1PkD9D2jb8eyyLgCy1WgQM643kldAmWjMyYmSsydOPzJe3AGNS0tah7Fjf/TLWU+tzsnnn5UQ6KC3nDlxoFE0ErqdrdRtmr4akf2EdAOaHHFzqTfVG8HHdRtu+s4zDLMcOnfnAJWmE61bRDTy7HN7WqokC3FjRqnVvVNf0fBt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kwtsEHFu; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e07b031da3so2650297a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 06 Oct 2024 11:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728237945; x=1728842745; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+egSknvcric7COXOJEt3WaLe0bXI3f03zAkyGMKR7x8=;
        b=kwtsEHFuIMVi5ibp/IOe4hPtivXcP/uV7Z5Pss3um9fnVNrp+C/caKsgnLEKA1Onc9
         5FXxc9Di3gho/j7soJnHBcp+/iNlIr9SI8qmFD67IWCvUFR8LH3hMJVS9PX/NakROP/F
         Yseo5G/KGmYEC2cngkdYolZfh9qGvHvU152GI3nnkiE8ggzzPTFEWHPVGsgKOlHYWNGj
         mi1Fcf2pKwqVnhEfLtW/CD/q47fbu4c/mKxANtEVc61uJkvra4QNkguXwx98n3+pOICF
         WRjnNTOOVhL5bqHTRKalVsDTqUHrXXXWBY8kp3cGaFl3IyQqeZXtAlz03UDF15ZzHyFY
         Isaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728237945; x=1728842745;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+egSknvcric7COXOJEt3WaLe0bXI3f03zAkyGMKR7x8=;
        b=gVu9chmogiAXFc180/UQc6ZVJccbPqyV8fA70H96YfeBtZU2AI4oYak8n25Z19OItC
         kou8hg7Haftjtzh+uq9zuKrAgyIn6ZE5MWRQON7vOPLpfG371d/BtDIBWrOirY6y3K/J
         74790KZ+zcVLCFh95JLxH0E0lQEkX6T9BA6qRS7dsLcg5ohIEIWZP1fCXZVNwhYNmKVG
         HX2EtWZaV/OeV2fmgiUksZZEujL51lY804dxRyfm0Mn6ulKTPzrsrdZQJ8SDKufSYDnk
         tJerdZWwgljBDOjY0Q18VmdL5RJDqxRl0xb2MuvixM2RpU3J2+PU+dxQqsGVNn8mWLS6
         sqJw==
X-Forwarded-Encrypted: i=1; AJvYcCWZ0tDI51csFGPhoBOjSM02pnC77a4sqVGXcNZgMCos/mU+UQERwIDWoG3lMvJCo7Ikar6SlQE43kBzf/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqMt3yJglu6ECHSb1hP+5UQyYK1eSH9bDc9JTMFCaNzxfXWWPD
	D/6T5Vc5DaC1VGwfoEQJx9WJ2I2gjpIyPnfSkWObz63dYuXmaD0qgWQGrEkB1Q==
X-Google-Smtp-Source: AGHT+IFNIq/a9CYHxz6Nm/b1lVN0D3Q3ap4lFm5Vk/bWNcJrztvixtRP8zufCmXOjRckcJJ0KhVydg==
X-Received: by 2002:a17:90b:4a45:b0:2e0:921a:3383 with SMTP id 98e67ed59e1d1-2e1e620f326mr11675222a91.1.1728237945016;
        Sun, 06 Oct 2024 11:05:45 -0700 (PDT)
Received: from thinkpad ([220.158.156.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20b0f7690sm3689924a91.42.2024.10.06.11.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 11:05:44 -0700 (PDT)
Date: Sun, 6 Oct 2024 23:35:38 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Carl Vanderlip <quic_carlv@quicinc.com>,
	Sujeev Dias <sdias@codeaurora.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Siddartha Mohanadoss <smohanad@codeaurora.org>, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] bus: mhi: host: free buffer on error in
 mhi_alloc_bhie_table
Message-ID: <20241006180538.l6ghaz5vopld5qa5@thinkpad>
References: <20240207065136.18316-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240207065136.18316-1-pchelkin@ispras.ru>

On Wed, Feb 07, 2024 at 09:51:36AM +0300, Fedor Pchelkin wrote:
> img_info->mhi_buf should be freed on error path in mhi_alloc_bhie_table().
> This error case is rare but still needs to be fixed.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: 3000f85b8f47 ("bus: mhi: core: Add support for basic PM operations")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/bus/mhi/host/boot.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bus/mhi/host/boot.c b/drivers/bus/mhi/host/boot.c
> index edc0ec5a0933..738dcd11b66f 100644
> --- a/drivers/bus/mhi/host/boot.c
> +++ b/drivers/bus/mhi/host/boot.c
> @@ -357,6 +357,7 @@ int mhi_alloc_bhie_table(struct mhi_controller *mhi_cntrl,
>  	for (--i, --mhi_buf; i >= 0; i--, mhi_buf--)
>  		dma_free_coherent(mhi_cntrl->cntrl_dev, mhi_buf->len,
>  				  mhi_buf->buf, mhi_buf->dma_addr);
> +	kfree(img_info->mhi_buf);
>  
>  error_alloc_mhi_buf:
>  	kfree(img_info);
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்

