Return-Path: <linux-kernel+bounces-550436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E71BA55F93
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 05:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E0F6189410E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 04:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2146F1624E0;
	Fri,  7 Mar 2025 04:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EScLyunr"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774B1C2E0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 04:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741322232; cv=none; b=RbFGu6mF27yoRpV0hMh+1rnubX5JtzJrAV/DOfH3JY7njZP6FED4T0mRz0N6fE8zQkWJh3aivL/amKBM8mmq8/5+Sri/1Z9M8GonFlHF/qJzZKT+imeFkOCfVq9pYzIO0MrXCVOsiXQSaNrxzrOBG7v5RP9TicwulpgGi+OBohg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741322232; c=relaxed/simple;
	bh=FifKKZQ5nqjlii3tlFw26zbBfkJOW/ccCHBtOwD16XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFtIIA6BWUlCe5EnR1MkizNwbp++Y49kq9EXHsLAa8PXjhOiqw85vFQmQ+wTc3I+ZsQyM20R7JbGcd6vVuKCob2agXqHUZzSVCe3FhQsrUaUVn5hR0RzZ/3tciUstvDJxSfbfwiEQCFmVe/IwoxIQqgOiaVNjGM4MyNO9JaBUsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EScLyunr; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5494bc8a526so1580920e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 20:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741322228; x=1741927028; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D44Ht247p5X2IacT/H00G0KgxP5FZ6f/aPx0Tfu79bg=;
        b=EScLyunrXqUflsfMHP4AKjomovKGmEzUSkmGmctFcxpFV1SEyWkQXQGjqFKbv13/+V
         MvAGEvuiXRUG7LRhGX5r5cnZnyP9FrSCslSaeisTJReYw5mUOOc68gbKEimskA8ZJgU2
         n8YvBAy2XTDpsE+dswYtfTWXlYOUQXwPIi1HUzVojs2+WHH/duHf1ij34U3sYS3l6drT
         hTC7Z2cxoAiyn6K1avJ4Q1QCOTgqVyOkV6lsTNgfQp9lvc0510WN2dMSijGsiNAn8YeJ
         7Y5kyEvMMoAg5lpOUZTAI9WuXhp+vbDTu+xPrRZlRdxmIbKjnNHVGUE1kO6XPuAlSr22
         9DNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741322228; x=1741927028;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D44Ht247p5X2IacT/H00G0KgxP5FZ6f/aPx0Tfu79bg=;
        b=IsYdn26iCF+/V3zWVNp7tlLCAPJELmXAT5wB5HpZDON8X52JQhItb3fmqIRFNV+Im8
         A2aDiGmsOrQwFPwF4djAcAY3lk2ZhFmxbpnEZf4bWX9eX8XUKuL3VCUcyE6DFSp81aFW
         AvJzqWYBTgKuId9hxysiDBxTqz8UkhDfYXfDpLEEqr0kePNPi62o+tnfmoP/jr18cRnR
         psTXsqMaBsCg8Nym4zzdOaPQDmXSDUH1udra+vJ7KBMdHJh8/C4ERdceBcl4QapgJEk2
         69MHc+hoAeJrYS3h4DQ3z5qW0kNgLqJTq+odcvFOSO+B6GdM2EYNVDOB+HTxMD5qi3Ca
         ZWRA==
X-Forwarded-Encrypted: i=1; AJvYcCV9JxDDohsrsTLUkfi5OUS9qSbiC9B2S6bDGxreEDcFZ/NdqRgCn7DSbku6E1NRh2quvxaAYxxEl/MTKms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG/qEJSfmmq6VgoMc5NA9A7H788Yrgca1JCeibRQV4OLQSkYtF
	uuJF1zF754mPghVv3jLOt/F37oJcPGC/XCp9ucBz8zZoNopk1kulNntPVOrmc30=
X-Gm-Gg: ASbGnctx8Ctyx5Cx2LBccnzoVbpiX+fSXwKZd4jieYV8eyDMGZ739nSBIvFjBYnWOCq
	8dyoqcyDmgdxduP/o3z3VoZGVluYVnbZo3Qkg1WlSjocoFngmW1L57YMpDdCVmmijFUFgQpDsBM
	VK3XTy7nn+iFe5fVwGXKc79IzXZEmMkXhnaJCKXGT4nz1ZnneUvcVrnm9k+IQHsNVVDAO9js7k8
	01qx7RbPOn9MlAQ9i678r8vS9wYazpMQlEPbJwKmcCR7Qf3Lg27wNZwidMZPGAstGCt7J7h6SZn
	+/QcR2VIKpT5zVfuwmdUcMuYidzHhU2kNXrvxmG3qToeVui+Cq0lrovwGbNi06OvnDsmU5e7c+j
	/+FnQGnQVNam4t+BUfWIXW4q3
X-Google-Smtp-Source: AGHT+IHgNHqKB7KlB9uYThtwbLU/NeMyGpitbkGHoqHOlS38yLdzWQtqtEd33GHB2srLLCDq7+iGzA==
X-Received: by 2002:a05:6512:281b:b0:545:2c40:ec1d with SMTP id 2adb3069b0e04-549910d721dmr588204e87.44.1741322228445;
        Thu, 06 Mar 2025 20:37:08 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498ae461dfsm370344e87.43.2025.03.06.20.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 20:37:07 -0800 (PST)
Date: Fri, 7 Mar 2025 06:37:04 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: Doug Anderson <dianders@chromium.org>, neil.armstrong@linaro.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, 
	simona@ffwll.ch, lujianhua000@gmail.com, quic_jesszhan@quicinc.com, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Anusha Srivatsa <asrivats@redhat.com>
Subject: Re: [PATCH] drm/panel: novatek-nt36523: transition to mipi_dsi
 wrapped functions
Message-ID: <ejcvjq5nttlnjlvv2gf46bvxzg7mhvhh4dkgif33iarfjzcq7w@ubs7duhhsdkl>
References: <20250306134350.139792-1-tejasvipin76@gmail.com>
 <ca5b0825-a485-4bec-bd93-b57a8d7ced99@linaro.org>
 <CAD=FV=VoW-Zm5wY6Y9sr=GqnvfMP4urGw_zW8NJRHpdC4=rHXQ@mail.gmail.com>
 <0d473dc1-cbbe-4a1e-933a-938438db24f5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d473dc1-cbbe-4a1e-933a-938438db24f5@gmail.com>

On Thu, Mar 06, 2025 at 11:08:18PM +0530, Tejas Vipin wrote:
> 
> 
> On 3/6/25 10:58 PM, Doug Anderson wrote:
> > Hi,
> > 
> > On Thu, Mar 6, 2025 at 6:05 AM <neil.armstrong@linaro.org> wrote:
> >>
> >> On 06/03/2025 14:43, Tejas Vipin wrote:
> >>> Changes the novatek-nt36523 panel to use multi style functions for
> >>> improved error handling.
> >>>
> >>> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> >>> ---
> >>>   drivers/gpu/drm/panel/panel-novatek-nt36523.c | 1683 ++++++++---------
> >>>   1 file changed, 823 insertions(+), 860 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> >>> index 04f1d2676c78..922a225f6258 100644
> >>> --- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> >>> +++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
> >>> @@ -23,10 +23,12 @@
> >>>
> >>>   #define DSI_NUM_MIN 1
> >>>
> >>> -#define mipi_dsi_dual_dcs_write_seq(dsi0, dsi1, cmd, seq...)        \
> >>> -             do {                                                 \
> >>> -                     mipi_dsi_dcs_write_seq(dsi0, cmd, seq);      \
> >>> -                     mipi_dsi_dcs_write_seq(dsi1, cmd, seq);      \
> >>> +#define mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx0, dsi_ctx1, cmd, seq...)      \
> >>> +             do {                                                            \
> >>> +                     mipi_dsi_dcs_write_seq_multi(&dsi_ctx0, cmd, seq);      \
> >>> +                     dsi_ctx1.accum_err = dsi_ctx0.accum_err;                \
> >>> +                     mipi_dsi_dcs_write_seq_multi(&dsi_ctx1, cmd, seq);      \
> >>> +                     dsi_ctx0.accum_err = dsi_ctx1.accum_err;                \
> >>
> >> Just thinking out loud, but can't we do :
> >>
> >> struct mipi_dsi_multi_context dsi_ctx = { .dsi = NULL };
> >>
> >> #define mipi_dsi_dual_dcs_write_seq_multi(dsi_ctx, dsi0, dsi1, cmd, seq...)      \
> >>                 do {
> >>                         dsi_ctx.dsi = dsi0;                                     \
> >>                         mipi_dsi_dcs_write_seq_multi(&dsi_ctx, cmd, seq);       \
> >>                         dsi_ctx.dsi = dsi1;                                     \
> >>                         mipi_dsi_dcs_write_seq_multi(&dsi_ctx, cmd, seq);       \
> >>
> >> ?
> >>
> >> So we have a single accum_err.
> > 
> > Even though the code you used was what I suggested in IRC, I like
> > Neil's suggestion better here. What do you think?
> 
> I like Dmitry's suggestion [1]. If we went ahead with this we'd also
> only need to equate the accum_err for the few msleep calls.

I think we will have more and more double-DSI panels. So I'd suggest
to add msleep wrapper which gets two DSI contexts.

> Since it
> does change the behavior, I'd like to hear another opinion on it before
> I go ahead with it.
> 
> [1]: https://lore.kernel.org/all/p2esqngynwfrshz5rqfnmx6qgwf4dclpkb3mphwg2vavx2jbcg@clqoy5tjh7bb/
> 
> > 
> > Other than that, it looks good to me.
> > 
> > -Doug
> 
> -- 
> Tejas Vipin

-- 
With best wishes
Dmitry

