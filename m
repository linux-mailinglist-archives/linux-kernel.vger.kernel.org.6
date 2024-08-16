Return-Path: <linux-kernel+bounces-289075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C07E29541E3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6991A1F2363A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 06:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D3685654;
	Fri, 16 Aug 2024 06:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ysfnu2hl"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F29085260
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 06:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723790052; cv=none; b=mZpEOLjL2wKH0OZX75qI3ccxB+RD/jU6v1CTroWmm8dc2Tf6vZfgjw7Mz16iADF8teKhMEKqW6UCmtOtuMx+dWAqjhKntRRYtMjt6j6TdhV5zdsnpDnI3A3gtvmnZfjT27ZiuilsK3zrBxXnstM5xBD8ke3B+ffXbcKB6b0vpEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723790052; c=relaxed/simple;
	bh=4uCrMhQ06N0SQ35tVNzYs2DOgiGlKcWDSHAS0/JjxSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fXySt7BsAMgwgGDJuLh6NQmuo+4togBYS7GAVRijHZ0N/IGCpCq8hdR6EHNv8sFB8AhGxCkG+8kcUP5Qf7LYwezb/+1sFEbQL+FxmqZf/c9fN4fUjewphHCH4Z6v9Nea4Uyi3AkwuYV7rCD7Q6mHHW+AT62UpZ7Hk4bcBscHnec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ysfnu2hl; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d3e46ba5bcso371542a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 23:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723790050; x=1724394850; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a/uavK0PbYy3J4bVDBO5APBAVCLocLDlmvM+81JXjMc=;
        b=Ysfnu2hlkUEu8IlxTsboeRoAeaCIkQbrGsaUMJIKNc51johwkvr2GVRzVJ/bOlzWG2
         +MOSRjvBp/jJQaMkSrH1E783Bb0t0In72EQum3wLyryRsVLZoo7FWFUe5rVeQy+HTSAK
         ygewqtszz2NK4dEoyKrRNKEU1APcwqNsRbqvY9sdss5dyTo61yYq5SSWptvvBeSVym6C
         AxZCghq5zTB3trEIDgSVwqec1oFX+lQ9vzbvB9OZQicwRbqLdoCa68vCTiyRdwBfv891
         35ap9vKFylSHhKadDHGgwA9x0n/BF3S4Y5pfuvGGcLANgHGKPmutNadwDe+j5nAwyiMF
         013g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723790050; x=1724394850;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a/uavK0PbYy3J4bVDBO5APBAVCLocLDlmvM+81JXjMc=;
        b=iEBh0CminBg3PeloFHp0F+q6fZ8U2pkSw+6dnF9lyAAfqMedoCLPyjnX4B6NAD58DS
         D5qqsXq0cSpieufmGZynlqzjZivYeyHR8DTBeVCnBr5yX6gvHijHXk4yHaa8YXA6pZJK
         gLQQ6fh5XInUJZu5FRuBbTUKZctu6opUoABCWS/uHaXKdhz7SO0LiuOUBxQpx/h3ofjP
         ncU7OWBGiF2oUs1epU4nJbXGj8IFgdwzciGfAf5QXYm1wb0OO2M8LaiM7F3L9VlkhCih
         VR1WR6YdATZUsViAbqPm6ztDfCwP/XBO15O9kmil4ptkKbunjrD3mYfZjwfrbOz3H4LE
         a2Ig==
X-Forwarded-Encrypted: i=1; AJvYcCUFMyNO7Vy9A0dsQ21240MBo/AVUBoRj6GeRqQHH7mk43FUzHlpC/yQ8LPuAD4m0kfZ4U7JJGRn21jvtnkFkZPBmMRgD7j/5Ru36Mo7
X-Gm-Message-State: AOJu0YzCgSgHJPNtA809fPn3dbmelaEB9sAcT5PZMbqzY1POq0f0V2wT
	ulEM1FbEj4b6ij3zKDf+4T+PBj+ra1x0i2iaaHxffcTGevE5ok0DEwyb03vOKg==
X-Google-Smtp-Source: AGHT+IG+rI3TLugumIXccrhydXWKglvJJ/DXhaBKWiPX4142sdMZr6blJoDC4km6y3HgiGXYFRfx/w==
X-Received: by 2002:a17:90a:ce11:b0:2d3:d09a:630e with SMTP id 98e67ed59e1d1-2d3dfc29dabmr2190989a91.1.1723790049604;
        Thu, 15 Aug 2024 23:34:09 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3ebf665sm970485a91.56.2024.08.15.23.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 23:34:09 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:04:04 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Rob Herring <robh@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Brian Masney <bmasney@redhat.com>,
	Nitin Rawat <quic_nitirawa@quicinc.com>,
	Can Guo <quic_cang@quicinc.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: ufshcd-pltfrm: Signedness bug in
 ufshcd_parse_clock_info()
Message-ID: <20240816063404.GH2331@thinkpad>
References: <404a4727-89c6-410b-9ece-301fa399d4db@stanley.mountain>
 <b613d16f-1167-456d-a5cd-807db875adb9@acm.org>
 <6beba3f4-dfa1-4871-829c-ed1e44b5bd39@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6beba3f4-dfa1-4871-829c-ed1e44b5bd39@stanley.mountain>

On Fri, Aug 16, 2024 at 12:35:22AM +0300, Dan Carpenter wrote:
> On Thu, Aug 15, 2024 at 10:47:30AM -0700, Bart Van Assche wrote:
> > On 8/15/24 4:24 AM, Dan Carpenter wrote:
> > > The "sz" variable needs to be a signed type for the error handling to
> > > work as intended.
> > 
> > What error handling are you referring to? I haven't found any code that
> > assigns a negative value to 'sz' in ufshcd_parse_clock_info(). Did I
> > perhaps overlook something?
> > 
> 
> Rob's patch in linux-next.
> 

It would've been helpful if you added 'next' in the patch subject prefix.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> -       if (!of_get_property(np, "freq-table-hz", &len)) {
> +       sz = of_property_count_u32_elems(np, "freq-table-hz");
> +       if (sz <= 0) {
>                 dev_info(dev, "freq-table-hz property not specified\n");
>                 goto out;
> 
> regards,
> dan carpenter
> 

-- 
மணிவண்ணன் சதாசிவம்

