Return-Path: <linux-kernel+bounces-410824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 215A29CE166
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A81D41F215F5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1CA1D3194;
	Fri, 15 Nov 2024 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GaKHY/z2"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0AB1BE87C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731681360; cv=none; b=DYPiucCl3tDmRYaNJO7ugDXwmhpzdMwgODgVZzrpaPl+ORLr/cJTiREL7ogTkdWtWWT8atz0rZ/eSWCDWXJx9/koGqJ1OuboAICNtk6++HIiH12pek4fCUyIJfCZeGBiacwCYd8Q8I8jHDQ/iRdDT53jUcnv67lxlDJdCra4UVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731681360; c=relaxed/simple;
	bh=aKFssPoMCbEZPG5Jve3taMTZ0CaJrhtVp1laAqMUheA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ILi0K90Fg/Tno1eTetR0Vx3ud+t9BRupivdYp/5UTcb8nsAO+XQD8sHtkpTy6eeI3Vw6ohl33VvlaKoD5Z6mR9mDyK8Gnq0zSDXuTefNM8RgZXbC4WPe+Fb8eovIzaLW/Dp9Z5L54fQV2WmI/uhQ16GUrGjvtXZDhV7h7C3kYtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GaKHY/z2; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53da353eb2eso3397434e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731681356; x=1732286156; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d43CGOrYwQTMl3TbKozwdFlBmEWO7EVgTabyaP0raws=;
        b=GaKHY/z2CEG8C5V+QDB4jq4+emRuSbks9O7z3BjQzaQJ3IXsNgWDdhFrXSHLL7LZ1z
         GpR75hDP3FACr6xsDBqk+X9Ph2odVxbcq4Ubl2+p6/Vl7EAYIT65FD8WffU/XpOiwieF
         OfGSplVrZdTsCvtJ29M0XP9b6g7D4dTC4ZtqU+YPl3hxy0Tk2bmNpzQlgyGYlVzY0DAa
         xPa5+5rHzqDg5qRSgixpVIFxQb3jOMFQDodSoHNqKqFFmXPGH9WUwlInuRjNrgw9j2Ml
         9vU40ujmc32qBvslnvFt+ltaLvZGP+zWTNOEyww7iMAy6+cINyX5DmjlmImwoJbQTsSi
         7B8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731681356; x=1732286156;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d43CGOrYwQTMl3TbKozwdFlBmEWO7EVgTabyaP0raws=;
        b=S+UxCSiaVDATzd6ah652boHs5ELy5R91GbKm2uIbyyvOB8zv4b6XExoNclji2WHNyq
         AZjvsmqwrHKZafrb4OdV8NL9GqmlXWLB76Z9/fX2zO3nHU7YMKtkHCXpQ5cFg/q2uuOb
         zXud/eCY2p0tJSJErAtrOcb5wibgBLDVyZ8ZlmBpGX5vzdFXl/gmVOvwNxsrMQYa59FO
         re3Mhszp3YQeoQioF9+6/gwPJJe0Ti8ti3pxlwseD/fu0CpIyKdCb5ug8Vynt82St5lO
         GwpSIDrnXET0aGjR656gJalANdjUzpb4pYse5WTluLVmJZr+ptQe8zwyh50PkzXumGfR
         uIpA==
X-Forwarded-Encrypted: i=1; AJvYcCWUhPTY53P1vWtMB8Q+3c66FBlaLDpqTo19/w/jXJlZSQclCRHSSmes8P2wDFlPtSJWI5Fdx9Cw026FDB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjzLM6ycqsfZs71wCNPamm4zPhZz+BNPvehZ/4+SIUEoHCMKhs
	goQqSt/UQQKuOsD9/k4jHFZoaqvlyDbr4HtzUVsjBkMRS0P5OEbVS6SNRKIn/ag=
X-Google-Smtp-Source: AGHT+IGLd55wpxXxX1fO2aUjNA5hPIFqY7ITl3o7gnKYbcvdkrET0x7ZnGF298YRTzlshfucVbwYBQ==
X-Received: by 2002:a05:6512:b1e:b0:53d:a504:9334 with SMTP id 2adb3069b0e04-53dab3b1718mr2002254e87.44.1731681355937;
        Fri, 15 Nov 2024 06:35:55 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da6500cbcsm586808e87.88.2024.11.15.06.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 06:35:54 -0800 (PST)
Date: Fri, 15 Nov 2024 16:35:52 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Akhil P Oommen <quic_akhilpo@quicinc.com>, 
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Bjorn Andersson <andersson@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Connor Abbott <cwabbott0@gmail.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 4/8] drm/msm: adreno: dynamically generate GMU bw
 table
Message-ID: <6bcdwzmm267x3657iydnoxdnxacexitzwjkvihzn3y57vxq3n6@vuhgq2x3iy5g>
References: <20241113-topic-sm8x50-gpu-bw-vote-v1-0-3b8d39737a9b@linaro.org>
 <20241113-topic-sm8x50-gpu-bw-vote-v1-4-3b8d39737a9b@linaro.org>
 <rvfrkb4v7cilzu3prv5dr2dni7m3jv3crhmto3uume5v5wxr5m@apvyb4lc2rre>
 <17243670-7e91-46f8-812d-3f21cee5cd2c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17243670-7e91-46f8-812d-3f21cee5cd2c@linaro.org>

On Fri, Nov 15, 2024 at 10:11:09AM +0100, Neil Armstrong wrote:
> On 15/11/2024 08:24, Dmitry Baryshkov wrote:
> > On Wed, Nov 13, 2024 at 04:48:30PM +0100, Neil Armstrong wrote:
> > > The Adreno GPU Management Unit (GMU) can also scale the ddr
> > > bandwidth along the frequency and power domain level, but for
> > > now we statically fill the bw_table with values from the
> > > downstream driver.
> > > 
> > > Only the first entry is used, which is a disable vote, so we
> > > currently rely on scaling via the linux interconnect paths.
> > > 
> > > Let's dynamically generate the bw_table with the vote values
> > > previously calculated from the OPPs.
> > 
> > Nice to see this being worked upon. I hope the code can is generic
> > enough so that we can use it from other adreno_foo_build_bw_table()
> > functions.
> 
> I would hope so, but I don't have the HW to properly test it on those
> platforms.

Welcome to the club^W Lab.

> > > Those entried will then be used by the GMU when passing the
> > > appropriate bandwidth level when voting for a gpu frequency.
> > > 
> > > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> > > ---
> > >   drivers/gpu/drm/msm/adreno/a6xx_hfi.c | 48 +++++++++++++++++++++++++++--------
> > >   1 file changed, 37 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> > > index cb8844ed46b29c4569d05eb7a24f7b27e173190f..9a89ba95843e7805d78f0e5ddbe328677b6431dd 100644
> > > --- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> > > +++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
> > > @@ -596,22 +596,48 @@ static void a730_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
> > >   	msg->cnoc_cmds_data[1][0] = 0x60000001;
> > >   }
> > > -static void a740_build_bw_table(struct a6xx_hfi_msg_bw_table *msg)
> > > +static void a740_generate_bw_table(struct adreno_gpu *adreno_gpu, struct a6xx_gmu *gmu,
> > > +				   struct a6xx_hfi_msg_bw_table *msg)
> > >   {
> > > -	msg->bw_level_num = 1;
> > > +	const struct a6xx_info *info = adreno_gpu->info->a6xx;
> > > +	unsigned int i, j;
> > > -	msg->ddr_cmds_num = 3;
> > >   	msg->ddr_wait_bitmask = 0x7;
> > > -	msg->ddr_cmds_addrs[0] = cmd_db_read_addr("SH0");
> > > -	msg->ddr_cmds_addrs[1] = cmd_db_read_addr("MC0");
> > > -	msg->ddr_cmds_addrs[2] = cmd_db_read_addr("ACV");
> > > +	for (i = 0; i < 3; i++) {
> > > +		if (!info->bcm[i].name)
> > > +			break;
> > > +		msg->ddr_cmds_addrs[i] = cmd_db_read_addr(info->bcm[i].name);
> > > +	}
> > > +	msg->ddr_cmds_num = i;
> > > -	msg->ddr_cmds_data[0][0] = 0x40000000;
> > > -	msg->ddr_cmds_data[0][1] = 0x40000000;
> > > -	msg->ddr_cmds_data[0][2] = 0x40000000;
> > > +	for (i = 0; i < gmu->nr_gpu_bws; ++i)
> > > +		for (j = 0; j < msg->ddr_cmds_num; j++)
> > > +			msg->ddr_cmds_data[i][j] = gmu->gpu_bw_votes[i][j];
> > > +	msg->bw_level_num = gmu->nr_gpu_bws;
> > > +}
> > > +
> > > +static void a740_build_bw_table(struct adreno_gpu *adreno_gpu, struct a6xx_gmu *gmu,
> > > +				struct a6xx_hfi_msg_bw_table *msg)
> > > +{
> > > +	if ((adreno_gpu->info->quirks & ADRENO_QUIRK_GMU_BW_VOTE) && gmu->nr_gpu_bws) {
> > > +		a740_generate_bw_table(adreno_gpu, gmu, msg);
> > > +	} else {
> > 
> > Why do we need a fallback code here?
> 
> Because at this particular commit, it would generate an invalid table, I should probably remove the fallback at the end

Or move this to a generic code that generates a table if there is no bw
data (like there is none for older platforms with the current DTs).

> 
> > 
> > > +		msg->bw_level_num = 1;
> > > -	/* TODO: add a proper dvfs table */
> > > +		msg->ddr_cmds_num = 3;
> > > +		msg->ddr_wait_bitmask = 0x7;
> > > +
> > > +		msg->ddr_cmds_addrs[0] = cmd_db_read_addr("SH0");
> > > +		msg->ddr_cmds_addrs[1] = cmd_db_read_addr("MC0");
> > > +		msg->ddr_cmds_addrs[2] = cmd_db_read_addr("ACV");
> > > +
> > > +		msg->ddr_cmds_data[0][0] = 0x40000000;
> > > +		msg->ddr_cmds_data[0][1] = 0x40000000;
> > > +		msg->ddr_cmds_data[0][2] = 0x40000000;
> > > +
> > > +		/* TODO: add a proper dvfs table */
> > 
> > I think TODO is unapplicable anymore.
> > 
> > > +	}
> > >   	msg->cnoc_cmds_num = 1;
> > >   	msg->cnoc_wait_bitmask = 0x1;
> > > @@ -691,7 +717,7 @@ static int a6xx_hfi_send_bw_table(struct a6xx_gmu *gmu)
> > >   	else if (adreno_is_a730(adreno_gpu))
> > >   		a730_build_bw_table(msg);
> > >   	else if (adreno_is_a740_family(adreno_gpu))
> > > -		a740_build_bw_table(msg);
> > > +		a740_build_bw_table(adreno_gpu, gmu, msg);
> > >   	else
> > >   		a6xx_build_bw_table(msg);
> > > 
> > > -- 
> > > 2.34.1
> > > 
> > 
> 

-- 
With best wishes
Dmitry

