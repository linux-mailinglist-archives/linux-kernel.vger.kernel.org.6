Return-Path: <linux-kernel+bounces-423134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE349DA347
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D151C2835DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 07:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD857155333;
	Wed, 27 Nov 2024 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xAWT5veW"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE0A1547E3
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 07:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732693376; cv=none; b=A1Eelnq3TWAaYEM1p+6gtD45bfsChJJpzJOognw2q02qRfQ2TFS3cbIgCOBgAUM/CdCktAY7Mmz2gQSnMUTBFdCi+tGKQvCBUNGRNC1VHXHfrLm0KcpVkJFXa1/x7l4vV7a8CtgDkQ2qlRZRn9izbxX+GGcTXxnqhUKJ+gabkMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732693376; c=relaxed/simple;
	bh=LU6AwlYsk3CPKKY2s0mNL0hPX4NuZPGAywEkPk0vpeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNkXG8FiiFsekFc5vnhndGdzmKl9ApCo6/BOKgT3joCeQM0dcN7rr3FqQPOwtXkU+ZztU3g8pNeN1M+eVf/qhN+Igjw9MpFU/YKBZFjZPlKc6I2HpZzgL1mG40I31lvU8Xf9kPXWaKzrEukXhH1n4aJGB7WmqscVkeGCHFe3z+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xAWT5veW; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21200c749bfso63687435ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 23:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732693373; x=1733298173; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oMWDgk/n3j4GiaybswgAiKAVmYvm7oHmNlJIVMIMNac=;
        b=xAWT5veWFj/XYJ1A1tOPYsUPA5QLLbRSKq1cnhQPYGAcid7rDYrT61U9HlxPNax0QK
         2rok6R4SlfXLXShsS3Ae8TgXZP1Fr8A5FjLtZ+8/dtLgWgguCG1MeE/msauMNJyHWEe9
         6pA/Lgfrw9TzNDgH8l73V435/DD6/Yr4qyVTTdglwIU5gu4qpBd5z9siq4zGz7sngUrH
         tehw0J7GDcwIsgmrC6Fi1/RmtrW4rULmpDdNT/zKnTXK01H9LLPc6q+Y0RatrJPspGi5
         2gYi+9c1OYfJpUKty8iL5zGkrIuuxUTNj8ybKpthN2h94l898Y7HqduXYZeu4jmjeTwz
         nlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732693373; x=1733298173;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMWDgk/n3j4GiaybswgAiKAVmYvm7oHmNlJIVMIMNac=;
        b=ee6m+mi/E1+cN/ZZqnDdHODXxuSCKPxljtJgiTmYnjx/Kp9wrmNxtSTaiu5gIf6QVL
         nuHnA286uy5Co+9CjIfzUmZhwQ2tyUtGx6DpMwIfUKYMYS3yDBdDwZAGEKr0/t6/PMkq
         +1D/c7pAuUcDj9zXbj59CUd2qHyDDNxjN18ObSwYEbinVhSnpMD94zJclWgjaUaQ73lD
         NR2+qJVzn9LdR3Lz3eqxM1b1zLeEZX5Z4RiF2nkg3NUcuetjKRb67Uf208lmN9E/cXuG
         b/A/VDy1YjUnJOmqE2/8qTiFDgUpjJZxrQUQ2sMrtMIPznleKJUiAl08VW2k95czu6nt
         azQw==
X-Forwarded-Encrypted: i=1; AJvYcCV4viMC8TXV1EZDggE/7HwdneLgoWPT3J/wSW9OW7x/v8SJY/NSLoUmjMKpeJBZkpWK5m2yRPpCWM2Uwmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YztjS/M/gPg5dc9+DgrqY3+sm4ckcSc/uGthV9z+6yCin/OXuCO
	vHpScMOU5zFZyYHPDM+KBe09X3mhO1YJW52T+9JXNNcPNDhLVXx4ISf4AIzUFQ==
X-Gm-Gg: ASbGnct8rJOqGDb6Rd3s7s/R9fIKVAE+8rlDPxm2Jwcps7jSu0HkeDcER7weAr9bkFo
	eYD6OU/sBy8CYK6Zucf2r7xRmrSQIzl0lyO+JKMdi8hd6dhUO1Cjd745NVDiD8eZ+qLP08bA+ZA
	C+CicO8m1NtErVYVgF97Eyvwyr6wIvHlxhIDDVcvp4doG8FjJ4sQtLWaKdes8X8zez8RchqKWuv
	UHCgDBDJUXrfV50pgGClvuM318uVuOrtUcZaRCYq9Y7PvApxwMmB3HwJL9X
X-Google-Smtp-Source: AGHT+IGp9I4DmuKPduEUQ+Vs8HvCWxBrCkbO+5RyEgGe/YSQ1SwDti6JUnGKKHfl4zUAgD/Vk310rA==
X-Received: by 2002:a17:902:d551:b0:211:f8c8:372c with SMTP id d9443c01a7336-21501381ba1mr22923355ad.21.1732693373062;
        Tue, 26 Nov 2024 23:42:53 -0800 (PST)
Received: from thinkpad ([120.60.136.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc12f22sm96678915ad.186.2024.11.26.23.42.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 23:42:52 -0800 (PST)
Date: Wed, 27 Nov 2024 13:12:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, Amit Pundir <amit.pundir@linaro.org>,
	Nitin Rawat <quic_nitirawa@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] clk: qcom: gcc-sm8550: Keep UFS PHY GDSCs ALWAYS_ON
Message-ID: <20241127074245.4fhr3gypxbjipqnq@thinkpad>
References: <20241107-ufs-clk-fix-v1-0-6032ff22a052@linaro.org>
 <20241107-ufs-clk-fix-v1-1-6032ff22a052@linaro.org>
 <tebgud2k4bup35e7rkfpx5kt7m5jxgw3yo3myjzfushnmdecsj@e4cb44jqoevp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tebgud2k4bup35e7rkfpx5kt7m5jxgw3yo3myjzfushnmdecsj@e4cb44jqoevp>

On Tue, Nov 26, 2024 at 10:21:10PM -0600, Bjorn Andersson wrote:
> On Thu, Nov 07, 2024 at 11:58:09AM +0000, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Starting from SM8550, UFS PHY GDSCs doesn't support hardware retention. So
> > using RETAIN_FF_ENABLE is wrong. Moreover, without ALWAYS_ON flag, GDSCs
> > will get powered down during suspend, causing the UFS PHY to loose its
> > state. And this will lead to below UFS error during resume as observed on
> > SM8550-QRD:
> > 
> 
> Unless I'm mistaken, ALWAYS_ON makes GDSC keep the gendpd ALWAYS_ON as
> well, which in turn would ensure that any parent power-domain is kept
> active - which in the case of GCC would imply CX.
> 

That's correct. But there is one more way to fix this issue. We can powerdown
UFS (controller and device) during suspend and the ufs-qcom driver can specify
the default suspend level based on platform. I think that would be more
appropriate than forbidding CX power collapse for the whole SoC.

Let me cook up a patch.

> The way we've dealt with this elsewhere is to use the PWRSTS_RET_ON flag
> in pwrsts; we then keep the GDSC active, but release any votes to the
> parent and rely on hardware to kick in MX when we're shutting down CX.
> Perhaps this can't be done for some reason?
> 

UFS team told me that there is no 'hardware retention' for UFS PHYs starting
from SM8550 and asked to keep GDSCs ALWAYS_ON. So that would mean, there is no
MX backing also.

- Mani

> 
> PS. In contrast to other platforms where we've dealt with issues of
> under voltage crashes, I see &gcc in sm8550.dtsi doesn't specify a
> parent power-domain, which would mean that the required-opps = <&nom> of
> &ufs_mem_hc is voting for nothing.
> 
> Regards,
> Bjorn
> 
> > ufshcd-qcom 1d84000.ufs: ufshcd_uic_hibern8_exit: hibern8 exit failed. ret = 5
> > ufshcd-qcom 1d84000.ufs: __ufshcd_wl_resume: hibern8 exit failed 5
> > ufs_device_wlun 0:0:0:49488: ufshcd_wl_resume failed: 5
> > ufs_device_wlun 0:0:0:49488: PM: dpm_run_callback(): scsi_bus_resume+0x0/0x84 returns 5
> > ufs_device_wlun 0:0:0:49488: PM: failed to resume async: error 5
> > 
> > Cc: stable@vger.kernel.org # 6.8
> > Fixes: 1fe8273c8d40 ("clk: qcom: gcc-sm8550: Add the missing RETAIN_FF_ENABLE GDSC flag")
> > Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
> > Suggested-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/clk/qcom/gcc-sm8550.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/clk/qcom/gcc-sm8550.c b/drivers/clk/qcom/gcc-sm8550.c
> > index 5abaeddd6afc..7dd08e175820 100644
> > --- a/drivers/clk/qcom/gcc-sm8550.c
> > +++ b/drivers/clk/qcom/gcc-sm8550.c
> > @@ -3046,7 +3046,7 @@ static struct gdsc ufs_phy_gdsc = {
> >  		.name = "ufs_phy_gdsc",
> >  	},
> >  	.pwrsts = PWRSTS_OFF_ON,
> > -	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
> > +	.flags = POLL_CFG_GDSCR | ALWAYS_ON,
> >  };
> >  
> >  static struct gdsc ufs_mem_phy_gdsc = {
> > @@ -3055,7 +3055,7 @@ static struct gdsc ufs_mem_phy_gdsc = {
> >  		.name = "ufs_mem_phy_gdsc",
> >  	},
> >  	.pwrsts = PWRSTS_OFF_ON,
> > -	.flags = POLL_CFG_GDSCR | RETAIN_FF_ENABLE,
> > +	.flags = POLL_CFG_GDSCR | ALWAYS_ON,
> >  };
> >  
> >  static struct gdsc usb30_prim_gdsc = {
> > 
> > -- 
> > 2.25.1
> > 
> > 

-- 
மணிவண்ணன் சதாசிவம்

