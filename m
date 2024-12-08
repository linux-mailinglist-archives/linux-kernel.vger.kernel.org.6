Return-Path: <linux-kernel+bounces-436354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C22069E84DA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 12:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD15F164652
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 11:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A232A1474CF;
	Sun,  8 Dec 2024 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JGvh3o1E"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41EC5145346
	for <linux-kernel@vger.kernel.org>; Sun,  8 Dec 2024 11:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733658999; cv=none; b=mH7L0P0X49paOQT1s6t+JCR2JX239hBpiIxzytAueOwz5k71a2CA5yZvuNeTmewsaYFm9N2db/nX5lDhMVdiL0UfWyqBWTbbOA1IunioD5DqKlGRj/QZsK4xIoVtEse+8zLFiSIGnVAANyQ2xVdOtl6AwGFjAMJWgdwyqDZREwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733658999; c=relaxed/simple;
	bh=VmlsOWxzrS1Noa1Caa2HARbWaJt1C9KgrLAlAN0Er10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DftM9ObYOH2gbQdhZXsw0pOarUjS8X3BAWITb6vMGXDSD1nZMDoTMBAJlskPC7TyModSsTpmLZ+D61B0oN5Q+nW10tQ/eucsQc1n1tAlXAddl4BPKd9JPv7+d4SQqdvcNkteAwtolUjsg7LvvkqdvmUxI8TizNtheXVxMX/kZ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JGvh3o1E; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53e23fb807dso3161028e87.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 03:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733658995; x=1734263795; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pOAwyqX0ldTVE84PV+ORU4SPmAJDMuBSaqC47OQg++s=;
        b=JGvh3o1EOGrsQkXk0UUCaQn0i8ci8FOfW+zQ0nnog6azhdtlbgFDhewfNWCtp5KHAo
         b5p/yENLo4MuUKd5mJINlkjz9YWwMF5UzeWcTbOgheWEfW8PDSsou8WV2lLJAGvM93gV
         Jl3VXcr0A6wjVBaPRdHOtbaLF0QY97CsQ6k8wSqoe2tC9skXsBl87U33yh6ayca5Ofl0
         CWTItohHVmRc9EpTKylW2oAifRum5yHW+Zu/+GqnzEz/9RzRo3dE6qJ5laP8gQ352quo
         nrEAF5eCY+oWPP1GDJM+IvGzkpptGVdQz3ZnWgrCOk2Y5g/2iK7BKrnUE/5O6/ACOEGh
         KYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733658995; x=1734263795;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOAwyqX0ldTVE84PV+ORU4SPmAJDMuBSaqC47OQg++s=;
        b=obj8kcxzzFKpL9fWqkMz5N3y8bvgaOuG0SDzXtkVVEnj5Ci1qebao1YuGyWCEnNNzb
         KjI2qYGG9hfzK1JWBdeH+DxN4B1v4LVpb6pZBpqTk8vh1cBUuNjbX5tc83+5Ulr3YKlI
         BoFnFlAqW7vZ7/4TRupb/qFSo2kilGFV9lSMszq+yWaeN0/q7CmvdP4hgcHmJ1bkaypU
         Mo5NKuUKq/DlGAuA0PAzOzm4pI5YjdtQE9gf3yB4u/iiPVfeQ3CqUWVwg5biKtC2T5Eu
         Y63OmTFCIA4KqvdiA2YdGqz5Eqctpac1YpdnaYFcl/bl0ooIMjzckwvJvi9PKDbpipvO
         QDQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbeRxzyhvUAC5EhJtJf1GDSEaQHTq+L5Co8AB2HL7RO3cfD8iHL2EDmeIAQ5Bs0xXME6NVYGu4TvHjZWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPVHvcPeV9T3EmbX37xUKK6NVFBeG4Sp4XlYb5BMjsigK1Rn3D
	j9CQeI4Ol43d5F12y8TbaVr5gYrq/mMrKXfoC1/Zd73oIHHPbLhGnHfIzRaopyQ=
X-Gm-Gg: ASbGncuin03MN0k8Cyv59mEAayHKROw73wZeHgyWo3pjNCvIJaMEej28YmBss6W8yXI
	mrKHglIyaiCf7Nw5YHaiikycxyGjXRIRBaR1HZh3wjjtXwTVcCTJZq5VzOTyQ3krCZcWCiYFJKn
	I+tzKmrwVaeUTT9AkZBIsWznEcqcE6hNRfCc00bLmrQgcxQ9I4wgSXHQYnGg6lgw2AaRVkjt4B4
	ykP9DgnnfwjdiToELojXD+gi8NcT8ODv8wYmGcgn7N4xNF8Bc2/gc/Xr6xH6r+OFh9iVXjtfVhi
	111a3MVnJRuMdYu8kDWJYLZb6llK+g==
X-Google-Smtp-Source: AGHT+IElZN3RNDN+oy40fWovlokmqjWYMAvL7r94k082zliwfNbajhQWzK7ZKlu/0oW09/kjFwm7PA==
X-Received: by 2002:a05:6512:131d:b0:53e:23ec:b2e7 with SMTP id 2adb3069b0e04-53e2c2c4b9dmr3131142e87.34.1733658995453;
        Sun, 08 Dec 2024 03:56:35 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53f232a9629sm387293e87.25.2024.12.08.03.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 03:56:34 -0800 (PST)
Date: Sun, 8 Dec 2024 13:56:31 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Stephen Boyd <swboyd@chromium.org>, 
	Chandan Uddaraju <chandanu@codeaurora.org>, Guenter Roeck <groeck@chromium.org>, 
	Kuogee Hsieh <quic_khsieh@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Vara Reddy <quic_varar@quicinc.com>, Rob Clark <robdclark@chromium.org>, 
	Tanmay Shah <tanmay@codeaurora.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH 28/45] drm/msm/dp: add an API to initialize MST on sink
 side
Message-ID: <6xqscvg7kuxd6l3kjfhrbqedijjfmaql5j3ie2lsnsxt2htx76@4u5iub577mg4>
References: <20241205-dp_mst-v1-0-f8618d42a99a@quicinc.com>
 <20241205-dp_mst-v1-28-f8618d42a99a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241205-dp_mst-v1-28-f8618d42a99a@quicinc.com>

On Thu, Dec 05, 2024 at 08:31:59PM -0800, Abhinav Kumar wrote:
> If the DP controller is capable of supporting multiple streams
> then initialize the DP sink in MST mode by programming the DP_MSTM_CTRL
> DPCD register to enable MST mode.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index e69cdfbbe10484e47475ef189849f8ff6628bd7a..033d238e956263c1212fce45aab01316ef341edb 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -380,6 +380,35 @@ static int msm_dp_display_send_hpd_notification(struct msm_dp_display_private *d
>  	return 0;
>  }
>  
> +static void msm_dp_display_mst_init(struct msm_dp_display_private *dp)
> +{
> +	const unsigned long clear_mstm_ctrl_timeout_us = 100000;
> +	u8 old_mstm_ctrl;
> +	struct msm_dp *msm_dp = &dp->msm_dp_display;
> +	int ret;
> +
> +	/* clear sink mst state */
> +	drm_dp_dpcd_readb(dp->aux, DP_MSTM_CTRL, &old_mstm_ctrl);
> +	drm_dp_dpcd_writeb(dp->aux, DP_MSTM_CTRL, 0);
> +
> +	/* add extra delay if MST state is not cleared */
> +	if (old_mstm_ctrl) {
> +		drm_dbg_dp(dp->drm_dev, "MSTM_CTRL is not cleared, wait %luus\n",
> +			   clear_mstm_ctrl_timeout_us);

"is not cleared" usually means that we wrote 0 to it, but the value
still stays on. Please rephrase the message, drop wait time.

> +		usleep_range(clear_mstm_ctrl_timeout_us,
> +			     clear_mstm_ctrl_timeout_us + 1000);
> +	}
> +
> +	ret = drm_dp_dpcd_writeb(dp->aux, DP_MSTM_CTRL,
> +				 DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC);
> +	if (ret < 0) {

if (ret != 1) ?

> +		DRM_ERROR("sink mst enablement failed\n");
> +		return;
> +	}
> +
> +	msm_dp->mst_active = true;
> +}
> +
>  static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  {
>  	struct drm_connector *connector = dp->msm_dp_display.connector;
> @@ -414,6 +443,9 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
>  	 */
>  	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
>  
> +	if (dp->max_stream > DEFAULT_STREAM_COUNT && msm_dp_panel_read_mst_cap(dp->panel))
> +		msm_dp_display_mst_init(dp);
> +
>  	msm_dp_link_reset_phy_params_vx_px(dp->link);
>  	rc = msm_dp_ctrl_on_link(dp->ctrl, dp_display->mst_active);
>  	if (rc) {
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

