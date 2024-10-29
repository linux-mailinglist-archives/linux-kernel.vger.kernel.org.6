Return-Path: <linux-kernel+bounces-387383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A081E9B5042
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659D6283F04
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE441D6194;
	Tue, 29 Oct 2024 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uThwPnrp"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F6A19754D
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222438; cv=none; b=oj/VAcegRj/1jY6NpH3WSYo+Ov8PNLF0a+ATUHLi6vIPyIUQW7oW4gqs8eR5zOkdPhkuEKUWnsl+MCBIKz1fP+rOLGXgLUW+AoIHhvydlaxypBTcMHSfCTDaaUS05zUrhd627Oww+JBVax1YO/yNjGZtB3P0Y+ukOP9YCfDehiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222438; c=relaxed/simple;
	bh=a1G0i/NLLTyCcwzqXP9Sw+DHZFP0plS5ycVSGr3uIgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DXvvD+2EcxMtkyMayMH8PlB2UieTLdmUP8t3eYADNcp/J7bXHnpwTR6eIDCUcC1E/yqlYOv8MgmgkegcGzdBP4z4TiEiCxWManIbFa4YbTXcfDMOo/6pjsyHfTNrrr23LCJKhGr8qbfhKbLohWaklv8DZNSsMoIff4OV9ixvuLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uThwPnrp; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7d916b6a73aso3668156a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 10:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730222436; x=1730827236; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hcPztDRBbO+gnBgnc/GAPOLS8SXyF7AibdYbZdEAVk8=;
        b=uThwPnrpqcdSGmiHRTk+UzDaSuReIcBsYjSHJrJpVpMwSquVErl1rmMKpKBbxcOtU+
         nhQ8Tp5TmcLKioEdxe7aDcXClfqxo6iSw2ULyM1w4SgnL391/Swv9QU816xqWJOED06k
         E+mT0iSpWkhS9QqzT6nahWy6/WLJQUPuQeb0OeLujGxw5pxbolWFuoZE+zYV9jSkveme
         YcTcchknpqIwP+dtDV8C95/alrpf1YZK8Fv7FrHJMgECIHAM/YqgI/8ZoE+5hrk8Ans3
         wDptMBOYP2iIC+BcTWBvyl9FmPP3JR6r53IPvUUGhcN6fO0qbQJr66q19dnerztIyrFK
         hN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730222436; x=1730827236;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hcPztDRBbO+gnBgnc/GAPOLS8SXyF7AibdYbZdEAVk8=;
        b=ok0FZhvJ2zMTK3xqTA0JcF92RC/wMzW9YUK3pQ4q0VtXTGVMGFfK3ePS6jM9Y5NguC
         z2zy/0GkyYUlld3I8tR3dl1dt+6KTjRFyPXX30Aufa78n3AoVzvulsowKyg6KZB6UoS5
         z/RIAgu0FlH0RbFHniggftQ7APiIbo6r+3F5X17rVzpN9hVZYEyYVXgzML5aYdSsZc8a
         cTmX3LIOk0sYacxHFjk/B+TwpxqaVE1egvI1555CwSHHlNDsu6c5k9T0ywP5wt1EGynM
         5GhVhxfcBplsiCa/tbWlnV8lvKWs5ccnv7a1b5gRNQB80s1EkFOabj2WFDKTybD2vQVE
         oJLA==
X-Forwarded-Encrypted: i=1; AJvYcCU9jtsVhOgsSCNdoosLYgnhzuYimQxkcTmDTukVvFhZWEuMzJpXCQ6PJvsWw03YaIRJvsmwQD7KeZkZdgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJewWZq8zIDoysbs3fzH7cv5FiTpc1OiKqefXp2rnrAVoKZ6ue
	ZLAfAk+zFNJ2Jo25ZL2EzJKWhxz78fdiUt0dKEDm8vHfhTdO7FZUFu9XB26sOzU=
X-Google-Smtp-Source: AGHT+IGXgbfzo6Ms367VDY/GcpMQ7HVMkDfOeOP/erT7USrt8i6Y/MNFKDgqCnyTLccduA/bLvdP+A==
X-Received: by 2002:a05:6a20:e613:b0:1d8:f62d:3585 with SMTP id adf61e73a8af0-1d9a83abbbfmr14336348637.5.1730222435747;
        Tue, 29 Oct 2024 10:20:35 -0700 (PDT)
Received: from p14s ([2604:3d09:148c:c800:303f:610b:d879:8715])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7edc8a3d0c2sm7728212a12.77.2024.10.29.10.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 10:20:35 -0700 (PDT)
Date: Tue, 29 Oct 2024 11:20:33 -0600
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: Andrew Davis <afd@ti.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Hari Nagalla <hnagalla@ti.com>,
	Beleswar Padhi <b-padhi@ti.com>, linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] remoteproc: k3-r5: Use IO memset to clear TCMs
Message-ID: <ZyEZYRD+o2jPoTkq@p14s>
References: <20241021204557.929823-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021204557.929823-1-afd@ti.com>

I have applied all 3 patches in this set.

Thanks,
Mathieu

On Mon, Oct 21, 2024 at 03:45:55PM -0500, Andrew Davis wrote:
> While it should be safe to use normal memset() on these memories as they
> are mapped as Normal Non-Cached, using the memset_io() provides stronger
> guarantees on access alignment and fixes a sparse check warning. Switch
> to memset_io() here.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/remoteproc/ti_k3_r5_remoteproc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> index 2f996a962f557..e1fe85e5eba6a 100644
> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
> @@ -487,10 +487,10 @@ static int k3_r5_rproc_prepare(struct rproc *rproc)
>  	 * can be effective on all TCM addresses.
>  	 */
>  	dev_dbg(dev, "zeroing out ATCM memory\n");
> -	memset(core->mem[0].cpu_addr, 0x00, core->mem[0].size);
> +	memset_io(core->mem[0].cpu_addr, 0x00, core->mem[0].size);
>  
>  	dev_dbg(dev, "zeroing out BTCM memory\n");
> -	memset(core->mem[1].cpu_addr, 0x00, core->mem[1].size);
> +	memset_io(core->mem[1].cpu_addr, 0x00, core->mem[1].size);
>  
>  	return 0;
>  }
> -- 
> 2.39.2
> 

