Return-Path: <linux-kernel+bounces-305050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BB79628A9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 15:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4FF6283A86
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 13:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A443187859;
	Wed, 28 Aug 2024 13:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FhQyBlfB"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA1716C864
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 13:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724851900; cv=none; b=JFgQ1gajArTcJJm92LCp4WsLOmQ7tJRxPqx4v+bIiNRLl6Uo7t667+sK4z+EjS/7e7yTksuL9pqml8uL4JJFq3XxDNq/1PfSFABbBY2G6+6fOsmFwY/bkrGWlHGqhJHK2i7BIvcVg1qoo7+Ub8tnUnggV0hpTv2xmGFAZp1auLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724851900; c=relaxed/simple;
	bh=aFunOdE2IWWGEtEGitXEh2j1fwzDFTJ8EAELatQZE60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTgw5volyMJofPO+419IxmgKyA5lJ7q0K2xZtAA8ACmzzNTiz7FbMU28+J857ffGwVLrJeGjjAq6yspAKyzpRq0xjnPPTOJRBFBIylpbfTctNUSK0noLg4MW/1JezMf649NMMc6PDVA+GD2tyFvjQTNL/eyuJDEZK2SC/o7eWUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FhQyBlfB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7106cf5771bso5653790b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 06:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724851898; x=1725456698; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ooxQLoKfDn6EQlD0rIDPMhXYCiCug8IilBfMsi5Lan0=;
        b=FhQyBlfBWoSppDFD4YNSBTqpYsxopU57NUtDNrrc5MzqPoECOvN1Tjx6Yx0QKsEhma
         Y39nhL9aLi76Tw44SV0mqUJpZ+GB0PM7lfxA90gGqz8V2L6+XbCYSlRJ5yw99PdYm+Rq
         f7peM0Mtu0A8GMXHkRjDAgayUQsSZltK2AfPZ7daeedAz9rp36IeXSHdhpVZECpISX/A
         OLW2PoXpOaoJbqsGyiqkEPEDOC0yPKjPNen88GU8LoZLYsLINOy9B0cOWHguqUmhJu10
         aZTVkmgvKj0pezUIVFvpr2uKeyX8Co7+fID4YMW3HHZGj2SSz6LqpeWEequH2N/cSmc1
         1IOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724851898; x=1725456698;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ooxQLoKfDn6EQlD0rIDPMhXYCiCug8IilBfMsi5Lan0=;
        b=diiLA2OFDRuasMCENJHeK/G6YQnO0vzP/IqgEwG7VZka9Ka1XxD81hnDeyd4yyU7N1
         aesaMgxxUHQM+KQqKSur+alR2lWtfQHq/Hr5/pNxUAQWyhs35cu+oeHLFyk8sjHFENKr
         QVFKo6qS8FsKj9Ee2Pj2v3EkVrpAjLvZc+rtTIe8WWO9l8OY6PB3dUKfkblcXUiTvCkC
         I8/jcDYEy0L/MR1mfgygfupclqWMlB8bi/18iWUJebElIBxawZYetb7YkOzKcae0RHI+
         06XprkM+N4tKjoSj0jmDWJ/8umj+jkiY8iDQSsmSyrzopf5jrOXuvHbM+TTPn2LlgzKF
         R4YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBWVmdD5aMwUemWaX9yVNBr89gRn1WKMQGtGe0ihDe4FeXJx1n67iSjcGv8fIqzYOUEKoUCrRQV/iW/cw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA81J7ZQDw05YPS3XbmDaWJbyOw9bD+0OQ+8c1e+lX/xOkii4Q
	TTRTxxHf9atbUlFphCWvDKHdStRaxTy7idwxFHZkqOPLD6qiaHT24lM/97QD2A==
X-Google-Smtp-Source: AGHT+IEINpO4o8xwOCNrCh0RMflT1QvZim19vykwVlDpRWD2mxcSv4yYUaeulVY/t40l8zuo0u5EGg==
X-Received: by 2002:a05:6a00:92a4:b0:710:7fd2:c91 with SMTP id d2e1a72fcca58-714458b4330mr18935675b3a.26.1724851898012;
        Wed, 28 Aug 2024 06:31:38 -0700 (PDT)
Received: from thinkpad ([120.56.198.191])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434316405sm10101761b3a.162.2024.08.28.06.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 06:31:37 -0700 (PDT)
Date: Wed, 28 Aug 2024 19:01:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Manish Pandey <quic_mapa@quicinc.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_nitirawa@quicinc.com,
	quic_bhaskarv@quicinc.com, quic_narepall@quicinc.com,
	quic_rampraka@quicinc.com, quic_cang@quicinc.com,
	quic_nguyenb@quicinc.com
Subject: Re: [PATCH V2] scsi: ufs: qcom: update MODE_MAX cfg_bw value
Message-ID: <20240828133132.zqozjegmbnwa7byb@thinkpad>
References: <20240828132526.25719-1-quic_mapa@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240828132526.25719-1-quic_mapa@quicinc.com>

On Wed, Aug 28, 2024 at 06:55:26PM +0530, Manish Pandey wrote:
> The cfg_bw value for max mode was incorrect for the Qualcomm SoC.

What do you mean by 'incorrect'? I extracted the value from downstream DTs. So
it cannot be incorrect.

If you want to update it, please clearly provide the reason.

And if this patch is addressing an issue, then a Fixes tag should be present. If
you want to get it backported (if it is a critical fix), then stable list should
be CCed.

- Mani

> Update it to the correct value for cfg_bw max mode.
> 
> Signed-off-by: Manish Pandey <quic_mapa@quicinc.com>
> ---
>  drivers/ufs/host/ufs-qcom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
> index c87fdc849c62..ecdfff2456e3 100644
> --- a/drivers/ufs/host/ufs-qcom.c
> +++ b/drivers/ufs/host/ufs-qcom.c
> @@ -93,7 +93,7 @@ static const struct __ufs_qcom_bw_table {
>  	[MODE_HS_RB][UFS_HS_G3][UFS_LANE_2] = { 1492582,	204800 },
>  	[MODE_HS_RB][UFS_HS_G4][UFS_LANE_2] = { 2915200,	409600 },
>  	[MODE_HS_RB][UFS_HS_G5][UFS_LANE_2] = { 5836800,	819200 },
> -	[MODE_MAX][0][0]		    = { 7643136,	307200 },
> +	[MODE_MAX][0][0]		    = { 7643136,	819200 },
>  };
>  
>  static void ufs_qcom_get_default_testbus_cfg(struct ufs_qcom_host *host);
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

