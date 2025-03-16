Return-Path: <linux-kernel+bounces-563194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E67A6380C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 00:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFB41163ECC
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Mar 2025 23:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A5B197A8E;
	Sun, 16 Mar 2025 23:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jdu9q+1c"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC71726ADD
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742167969; cv=none; b=DLH6oTfpq4IxlcfZdXkf4oTEYozM3SONTAnH4pGjpRWAgRZTED4DXiWsyJBRZTmkxvtARjIMDt+exFiidQZiN/n3nSFW/NrOxaGpHc1vW47b+NZsFjb8155qlPCn4ktphRiffpvmo5lkbga0JA59TiUaBpEk+b8ZtxQyfG3Nxwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742167969; c=relaxed/simple;
	bh=q+AdyHNrgptXjSmRFRiA7xv0+0EhY51wA5SoIvE7P8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBofO8gPvrzUTJjcgZDTrGfXviD2H2yW0rgc3hZli3IhcgRyHbZdNPJ7TkyJ9EjkjFlTYFfvYUycLTErL0m2rB9zE1Nx5e712Zd7e5MflfbgTMwEK4kpG0LlwXc2lG3dKTk0RSDs6tcwrChCzgH/zD0h8w2VYCdNL/1AU9GNrsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jdu9q+1c; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52GHAkXF019544
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 23:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=v+4z0pXri9D3MA/bSTRiP9pS
	Qb9e0AicJTboxk8OTXU=; b=jdu9q+1ccyzDR02tJmhNSh94ly3QUD3rp0/qBiFt
	lfErfDXE9MPf6UB0mzp2I+LdMPg4wkPW3BYgJ+/8waXYOIEjPtzsjCXrhZem0C6J
	yqjApI8/nXTzTuuGce1MrrCpCDasMKG1Wz0B7fxBEHd9D6UvR3YWynRG0bbXba90
	F9Q1pODyY7NpAztZlc8BpMyaAkTNs8SNggqwYYLJkMww2ZoweKgMW/Yc9YHfHAnq
	eLZrDsfkzvickyfc82T7fLpzLaDDQLpKTc2f7dDQE+CEAvz0qTCaNLljT8y9VTsK
	7mCbHnLQKP0dnQB1WRhrVrukKT4GThkR5jFvKdS1/n8trg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45d2u9tsdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 23:32:46 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7c54e9f6e00so882173385a.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Mar 2025 16:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742167965; x=1742772765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+4z0pXri9D3MA/bSTRiP9pSQb9e0AicJTboxk8OTXU=;
        b=lEF7sjLpbNmiNdK7OzXge+Lcm7xL7ihSbeVBgJDQUCsH780n4lnctiO10Y54KXHvQq
         +kmdcW3S/D6BByibr/NFC/OlHX0yTzdDpAulcvMnhnWtDvAOztqRb1Y1le3VK82LOzS5
         0ZZTHTtIin/0KqnjzcU4HhmRKK+iSs8Q3weSmcGJV8AIWnuk8ajhSyQmFEAAWto7CNi7
         xD99NTZoh+42Ntbku7vBvbwyY0UkdS3kb8LyVdPl7WMsq/42Jx9w7dqsKC8Wo0VMO5LW
         taOhWyAVsYHfF/CuXvhVizze6DvsZPH1UDQnjZ4dPghLjTWZQ9DBr0BrAHPPI7YJcd+9
         zq5A==
X-Forwarded-Encrypted: i=1; AJvYcCWTDyb0+RNL637xMKMBbYanXHvQgIUrbOCglCcMnWL9+qKlszpAdQE5R5qQR6VWhWwQXFRySEm9Hx3dc/A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaNk0r4TA2BAWErg8jdgoH40jkYFBOteGK9VRptMD1s7mUaXt5
	4bnrCO1A/ch+YdsDGPmbWCMTjDap5FP4ZIIiGYRlJXoq2FhUJFYMvq8gZHXeCDdLzOGn/GbH1DX
	GML9QT/izAHzaA4IGvytTeoKLitSndW6SKeig2i1M1YESaVPOPe3MTSqYkz7fXpA=
X-Gm-Gg: ASbGncvYo7yj/oDo6HbdqKYCwqnM2hxYQzf5dDA6a7fyRo2cIqGb2lPoV4Mn6bG/Bmy
	8agcmqaDsiZeHcT5QtZnAmxyYue+ZGvuusMR3Z3Gi5iwYSMOgA4ejanICxl6jgHtgmMydw1w7Ed
	FpOOKfdM8+TW0wCoFiI/xO/jMNl4TpsfrpcQYTRxVM7Upl8+TK7jmjl2w8CwKGGWvTFOFFqWGxq
	fbGmXZojVQmyOgy/qTYWhlWUBtvJeW6lb9owoCEXGeZDVzvTnOnUm0SS5zc/v0L0I8gF/nw9L1i
	oqaXv82leEDZiBeDUqm8YYDan1u4gy7vIR1t8uBxz9z52gz1Q4z4H2b/150JuPR2GnTeuzs0aYk
	nu54=
X-Received: by 2002:a05:620a:45aa:b0:7b6:cb3c:cb81 with SMTP id af79cd13be357-7c57387033fmr2218283585a.18.1742167965424;
        Sun, 16 Mar 2025 16:32:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvMr4+3BmMeA4wBPnIO4xs9pC+f/i6v3L0AXx68Mbmu7j3jPeem9oGJdtBp4jFNXmmA3OQBg==
X-Received: by 2002:a05:620a:45aa:b0:7b6:cb3c:cb81 with SMTP id af79cd13be357-7c57387033fmr2218281385a.18.1742167965073;
        Sun, 16 Mar 2025 16:32:45 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-549ba8804a9sm1150832e87.168.2025.03.16.16.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Mar 2025 16:32:42 -0700 (PDT)
Date: Mon, 17 Mar 2025 01:32:40 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anusha Srivatsa <asrivats@redhat.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Tejas Vipin <tejasvipin76@gmail.com>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] drm/panel/sharp-ls043t1le01: Use _multi variants
Message-ID: <zs4tt57ur6hbesipab3kuiost4gokfu6tmfsicfwtdwri2wwli@fylnnpu3xoen>
References: <20250316-b4-panel-ls043t1le01-v1-1-ee38371b0ba0@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250316-b4-panel-ls043t1le01-v1-1-ee38371b0ba0@redhat.com>
X-Authority-Analysis: v=2.4 cv=JsfxrN4C c=1 sm=1 tr=0 ts=67d75f9e cx=c_pps a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Vs1iUdzkB0EA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=pGLkceISAAAA:8 a=cm27Pg_UAAAA:8 a=20KFwNOVAAAA:8
 a=abSFfuejC0CNeSHrdi0A:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: WiYUAXO2aawSFERzEeTIfEwAZa9J1Ix6
X-Proofpoint-ORIG-GUID: WiYUAXO2aawSFERzEeTIfEwAZa9J1Ix6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-16_08,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 suspectscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503160175

On Sun, Mar 16, 2025 at 02:58:22PM -0400, Anusha Srivatsa wrote:
> Move away from using deprecated API and use _multi
> variants if available. Use mipi_dsi_msleep()
> and mipi_dsi_usleep_range() instead of msleep()
> and usleep_range() respectively.
> 
> Used Coccinelle to find the _multi variant APIs,
> replacing mpi_dsi_msleep() where necessary and for returning
> dsi_ctx.accum_err in these functions.
> 
> @rule_1@
> identifier dsi_var;
> identifier r;
> identifier func;
> type t;
> position p;
> expression dsi_device;
> expression list es;
> @@
> t func(...) {
> ...
> struct mipi_dsi_device *dsi_var = dsi_device;
> +struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi_var };
> <+...
> (
> -r = mipi_dsi_dcs_nop(dsi_var)@p;
> +mipi_dsi_dcs_nop_multi(&dsi_ctx);
> |
> -r = mipi_dsi_dcs_exit_sleep_mode(dsi_var)@p;
> +mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
> |
> -r = mipi_dsi_dcs_enter_sleep_mode(dsi_var)@p;
> +mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> |
> -r = mipi_dsi_dcs_write_buffer(dsi_var,es)@p;
> +mipi_dsi_dcs_write_buffer_multi(&dsi_ctx,es);
> |
> -r = mipi_dsi_dcs_set_display_off(dsi_var,es)@p;
> +mipi_dsi_dcs_set_display_off_multi(&dsi_ctx,es);
> |
> -r = mipi_dsi_compression_mode_ext(dsi_var,es)@p;
> +mipi_dsi_compression_mode_ext_multi(&dsi_ctx,es);
> |
> -r = mipi_dsi_compression_mode(dsi_var,es)@p;
> +mipi_dsi_compression_mode_multi(&dsi_ctx,es);
> |
> -r = mipi_dsi_picture_parameter_set(dsi_var,es)@p;
> +mipi_dsi_picture_parameter_set_multi(&dsi_ctx,es);
> |
> -r = mipi_dsi_dcs_set_display_on(dsi_var,es)@p;
> +mipi_dsi_dcs_set_display_on_multi(&dsi_ctx,es);
> |
> -r = mipi_dsi_dcs_set_tear_on(dsi_var)@p;
> +mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx);
> |
> -r = mipi_dsi_turn_on_peripheral(dsi_var)@p;
> +mipi_dsi_turn_on_peripheral_multi(&dsi_ctx);
> |
> -r = mipi_dsi_dcs_soft_reset(dsi_var)@p;
> +mipi_dsi_dcs_soft_reset_multi(&dsi_ctx);
> |
> -r = mipi_dsi_dcs_set_display_brightness(dsi_var,es)@p;
> +mipi_dsi_dcs_set_display_brightness_multi(&dsi_ctx,es);
> |
> -r = mipi_dsi_dcs_set_pixel_format(dsi_var,es)@p;
> +mipi_dsi_dcs_set_pixel_format_multi(&dsi_ctx,es);
> |
> -r = mipi_dsi_dcs_set_column_address(dsi_var,es)@p;
> +mipi_dsi_dcs_set_column_address_multi(&dsi_ctx,es);
> |
> -r = mipi_dsi_dcs_set_page_address(dsi_var,es)@p;
> +mipi_dsi_dcs_set_page_address_multi(&dsi_ctx,es);
> |
> -r = mipi_dsi_dcs_set_tear_scanline(dsi_var,es)@p;
> +mipi_dsi_dcs_set_tear_scanline_multi(&dsi_ctx,es);
> )
> -if(r < 0) {
> -...
> -}
> ...+>
> }
> 
> @rule_2@
> identifier dsi_var;
> identifier r;
> identifier func;
> type t;
> position p;
> expression dsi_device;
> expression list es;
> @@
> t func(...) {
> ...
> struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi_var };
> <+...
> (
> -r = msleep(es)@p;
> +r = mipi_dsi_msleep(&dsi_ctx,es);
> |
> -msleep(es)@p;
> +mipi_dsi_msleep(&dsi_ctx,es);
> |
> -r = usleep_range(es)@p;
> +r = mipi_dsi_usleep_range(&dsi_ctx,es);
> |
> -usleep_range(es)@p;
> +mipi_dsi_usleep_range(&dsi_ctx,es);
> )
> ...+>
> }
> 
> @rule_3@
> identifier dsi_var;
> identifier func;
> type t;
> position p;
> expression list es;
> @@
> t func(...) {
> ...
> struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi_var };
> ...
> -return 0;
> +return dsi_ctx.accum_err;
> }
> 
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Tejas Vipin <tejasvipin76@gmail.com>
> Cc: Doug Anderson <dianders@chromium.org>
> 
> Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
> ---
>  drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c | 36 ++++++++++---------------
>  1 file changed, 14 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
> index 729cbb0d8403ff7c0c4b9d21774909cc298904a2..9803eaf18e95d70742ece88e82932751476fdda8 100644
> --- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
> +++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
> @@ -36,15 +36,14 @@ static inline struct sharp_nt_panel *to_sharp_nt_panel(struct drm_panel *panel)
>  static int sharp_nt_panel_init(struct sharp_nt_panel *sharp_nt)
>  {
>  	struct mipi_dsi_device *dsi = sharp_nt->dsi;
> +	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
>  	int ret;
>  
>  	dsi->mode_flags |= MIPI_DSI_MODE_LPM;
>  
> -	ret = mipi_dsi_dcs_exit_sleep_mode(dsi);
> -	if (ret < 0)
> -		return ret;
> +	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
>  
> -	msleep(120);
> +	mipi_dsi_msleep(&dsi_ctx, 120);
>  
>  	/* Novatek two-lane operation */
>  	ret = mipi_dsi_dcs_write(dsi, 0xae, (u8[]){ 0x03 }, 1);

Anusha. Please. Start reviewing your patches before you send them. This
is a MIPI DSI call. And it wasn't switched to _multi / context. You
should have cought this. I don't know why you didn't. Please review and
check your code before sending it upstream.


-- 
With best wishes
Dmitry

