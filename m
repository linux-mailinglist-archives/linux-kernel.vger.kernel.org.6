Return-Path: <linux-kernel+bounces-215216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1405D908FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 18:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5A51C22A0D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 16:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EA216DEB7;
	Fri, 14 Jun 2024 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bW/jLJBe"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F632232A
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 16:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381804; cv=none; b=rBSbJPLyyQDjEe2tuiCAJcesqSxOL6t0AKwB6uPkMdlJN+gVZOpZ7WUjjX3uBpI6kw73bKznMgNE+JsIPDN7rViQtoj3ZHbVtxrOD8RrhWsHz7lgMbGjLoTnIPZR6u8AOV2cl3tiDeFQkGwTlDsX5ptyfwBhnNip9E+PFj1bfns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381804; c=relaxed/simple;
	bh=nH13FN57tL3/xFKheVG9Aj1grx4NNK9IzAO/H+c5U88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLz5w7rZS91NERUhDR2ThddtPZ1tSHut9Qckx2oL3dFFDEwhT1eFrIOjoCi1HevT62e3ilPzcYx90TMwnMfz6uIVSvzj7yJAO8KNyzE4iZ3bTc7a+Z6SmlUkLTxZOMU8sDp/4POybw6vwCkTICqW3NA4TE2UdhzAtj+QnhvRX2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bW/jLJBe; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52bc0a9cea4so2100660e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718381801; x=1718986601; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DxfXutc6OWPI+LqABeJ5/om1fvUK/kk9/lRBZity8Nk=;
        b=bW/jLJBepBMcJ4rwy2YCHctk2XOM6E8UzlsUff2RvVMggc+DXcjfAqEL4zS2lrfZ/a
         QcIcIjqUvNQTpKccvnhRCZAoRbSuT+lIxm8RLqXp1gwIp/EemAzczyzmFf/hMTTkHI4E
         M8E+iKES6QICx7gnA4WqginO9wyRhMl6OKzkq7O6d8Wqn3SUitInAp43y2IbZuQVw3p0
         brc0EQXGW709usxKfxCyi3mT62oDndJSJdjP0H2+3EjToqRZZ5IR66VX/ysYPHP066ji
         TYr3oGGEvFvUuVv/Ic1Ik/537dJliGxlP5oOJJwsoEn1+6fdAtLOThV1HvLuJaYaKv0T
         JmYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718381801; x=1718986601;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxfXutc6OWPI+LqABeJ5/om1fvUK/kk9/lRBZity8Nk=;
        b=ghX3XBEKBWFk+Icyahm1AjuWO30oVFBqkUsckG/VzhT+j74ojlX6CbUoGnJb3PkEw5
         9rhGeMkYZFAeQPv0cHb1cPyDUYndqVRsuQvmjSshVLeSYjR/VsssSdN6uDaVrDGLKz0C
         +hQcuqJycnHIj/RHrlI7SwbSJn1XHmwqnhUoIS58sC9fTuvBdHuKH/rXYSo4fSfHVi57
         9rsuarOEAnJOK84FEjVYfEuHdKR7KmJlorc4Bl6JZf3L6fDT85dqk3kXY6pdBSzhEwwu
         naiMS5WiBmCIAxfVMb1CwId3Y4jTlRA5iFbuGutFWgO7QdVcDkG9yeiG6j+oVzQA+Rn0
         KhCA==
X-Forwarded-Encrypted: i=1; AJvYcCVV3CjVKa/AG/YFWB0MK9OsagesuUA4mnt8Kyj4QwCFYXv28Ut+FF0ck3zeEOvY1GA6VAfaDFtlIR9758PlnhiOgz+MKoN71Ku27sth
X-Gm-Message-State: AOJu0YwdHGw9oCf8vxILbrlqTJI1Py1RqaYnqe4j35Sdu3VTdM7BOaJV
	OJ8eacdM0ExPejdr6AisM3wohiy9QcYekh/ciCmKxk5Qnw/7joMX3S5SR5Na9qA=
X-Google-Smtp-Source: AGHT+IFWh49tFkOdBloSDX4IJrQng477dOMe80RX0kExz3XThklhLq1u8q6ZcYalsgMEcQ+B5wozZg==
X-Received: by 2002:ac2:5b10:0:b0:52c:8355:422a with SMTP id 2adb3069b0e04-52ca0227784mr2017409e87.9.1718381800964;
        Fri, 14 Jun 2024 09:16:40 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282dd55sm552715e87.65.2024.06.14.09.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 09:16:40 -0700 (PDT)
Date: Fri, 14 Jun 2024 19:16:39 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, dianders@google.com, hsinyi@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] drm/panel: jd9365da: Modify the method of sending
 commands
Message-ID: <5nsbxkuoka7gnnvbvmvjxqpec47glfusz4hrvk4qqdofbgcppy@3u32y2xsh33m>
References: <20240614145510.22965-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240614145510.22965-2-lvzhaoxiong@huaqin.corp-partner.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614145510.22965-2-lvzhaoxiong@huaqin.corp-partner.google.com>

On Fri, Jun 14, 2024 at 10:55:07PM GMT, Zhaoxiong Lv wrote:
> Currently, the init_code of the jd9365da driver is placed
> in the enable() function and sent, but this seems to take
> a long time. It takes 17ms to send each instruction (an init
> code consists of about 200 instructions), so it takes
> about 3.5s to send the init_code. So we moved the sending
> of the inti_code to the prepare() function, and each
> instruction seemed to take only 25μs.

Additional details about the DSI host would be appreciated. I guess that
the difference in time used to send the command is due to the DSI host
interleaving commands between video frames, but it would be nice to have
that spelled in the commit message.

> 
> Signed-off-by: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
> ---
>  .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 781 +++++++++---------
>  1 file changed, 393 insertions(+), 388 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> index 4879835fe101..b39f01d7002e 100644
> --- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> +++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
> @@ -19,17 +19,13 @@
>  #include <linux/of.h>
>  #include <linux/regulator/consumer.h>
>  
> -#define JD9365DA_INIT_CMD_LEN		2
> -
> -struct jadard_init_cmd {
> -	u8 data[JD9365DA_INIT_CMD_LEN];
> -};
> +struct jadard;
>  
>  struct jadard_panel_desc {
>  	const struct drm_display_mode mode;
>  	unsigned int lanes;
>  	enum mipi_dsi_pixel_format format;
> -	const struct jadard_init_cmd *init_cmds;
> +	int (*init)(struct jadard *jadard);
>  	u32 num_init_cmds;
>  };
>  
> @@ -52,21 +48,9 @@ static int jadard_enable(struct drm_panel *panel)
>  {
>  	struct device *dev = panel->dev;
>  	struct jadard *jadard = panel_to_jadard(panel);
> -	const struct jadard_panel_desc *desc = jadard->desc;
>  	struct mipi_dsi_device *dsi = jadard->dsi;
> -	unsigned int i;
>  	int err;
>  
> -	msleep(10);
> -
> -	for (i = 0; i < desc->num_init_cmds; i++) {
> -		const struct jadard_init_cmd *cmd = &desc->init_cmds[i];
> -
> -		err = mipi_dsi_dcs_write_buffer(dsi, cmd->data, JD9365DA_INIT_CMD_LEN);
> -		if (err < 0)
> -			return err;
> -	}
> -
>  	msleep(120);
>  
>  	err = mipi_dsi_dcs_exit_sleep_mode(dsi);
> @@ -117,9 +101,21 @@ static int jadard_prepare(struct drm_panel *panel)
>  	msleep(10);
>  
>  	gpiod_set_value(jadard->reset, 1);
> -	msleep(120);
> +	msleep(130);
> +
> +	ret = jadard->desc->init(jadard);
> +	if (ret < 0)
> +		goto poweroff;

Plese don't mix refactoring with functional changes. Please split this
into two patches, one for using _multi and another one for moving init
to prepare()

>  
>  	return 0;
> +
> +poweroff:
> +	gpiod_set_value(jadard->reset, 0);
> +		/* T6: 2ms */
> +	usleep_range(1000, 2000);
> +	regulator_disable(jadard->vccio);
> +
> +	return ret;
>  }
>  


-- 
With best wishes
Dmitry

