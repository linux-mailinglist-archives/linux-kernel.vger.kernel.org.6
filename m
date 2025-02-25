Return-Path: <linux-kernel+bounces-531090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F3A4A43C11
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6B13AA1A4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982FE266B43;
	Tue, 25 Feb 2025 10:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iRNiBYxq"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BD2265637
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 10:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480107; cv=none; b=oYTMJk4Ay8H7ja6ePalD/owAbFsx7K/L86hNNkZc5JhlX8zTfhmtt/HMMbn7rPz/FfMfFwG+lO2hNv01rOP8Z7jDeg3Vr1KBgTBoTy9hqaMC6DKNnzOcKlX9ebFL8E/E+dFPE3XdX0t6S/tpG5znjbpD/yoAH37oeFPOHQXpIkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480107; c=relaxed/simple;
	bh=LsxEE7M5vloDRELpk9HA5CECnOlNHUPp+HJ2/qo4MbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BzQps7WwUpmcdtdNcNHg8aUoo0TpnAeqoqEaTCKkXFC1zZNydwSZUtPzSIHkbCQWkno37fDGIoyDylNyiMRwUc+AET1JTYVqho2FbK2oxOC7VpSMQ8mHFYcoq8bzjKK835QoympEVWV5ZUQ+q2/EHmxGb6IXFM5l71JNAW4YZ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iRNiBYxq; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e5dc39ede40so4881705276.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740480104; x=1741084904; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q4y1Yfwgg1zBnhWKLOimUYxF7Yvd8NEBzFT9QXdfO8s=;
        b=iRNiBYxqXfk6Q5vhTFznlwhy4OJy75kkEEeKJ1o91jbth60I0hY4KJ39b0bUB8b131
         bjBtbjXwDFJMymtB13v0ET+15rCHltRGIBZjXLSXds1ov7EDRl1xUmMvyc3UgWxm6Ixo
         wltIJJ55zceY881q65nE9HSILrIW0iVY1QxSJB/LQKntgmqvqtdYolRk42kykIAVQnjg
         7dfv7MumQynlPzJOK1OhMbRGylkCmVuc/8NWO7WOeJ1Jc/2LRmzW4ZtJoH70ZuHuSpEC
         wgjIQrHlVdlvwxwoE6P6eCzkTsrCCxCVan55QBJZsYgRKTCpDVZIsDTgziRNx6uMjkwt
         8DzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740480104; x=1741084904;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q4y1Yfwgg1zBnhWKLOimUYxF7Yvd8NEBzFT9QXdfO8s=;
        b=NwIN2Lv6LSCugSEZtbzyVYlmWy+7ClwW0TJcpDghSVii1D4Q2j0Dvb47kG/zpNXcjK
         en+C6lv8XR5wL9j5SLz18uKhVbjbIH1aPDb03DTjIJNs1O9ermQ3MVKgmNGoEjX9+U16
         XQ9/sYoQ7mA/rqNS4OWnGG3Ln/Xjw1cFB57Nm2H/GWJVl9ONqvV2ZgLr4Nob4/kunAm0
         yAfyyhLtAxuqAMgAT2x7wvRIhNsIA3fm59nNDclAuqFNvqQ43NZRHxKIQGdE6M31VbAq
         OR2R137FWxt161EB6qjnW6RzFD0wGZ8kII+E7BQmqjqkYhR9n/ko77Mjd+ltbVI+URTu
         eTsA==
X-Forwarded-Encrypted: i=1; AJvYcCUmpoPB+bwPxV31ifF9hRVyAfVPgd/uCW4tuKRvMgH1laY51Xnr9j7gljKiRm22OVDaSVoltaLTYGvyueM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9l8B11V394bD/5ndZOSfNTR6dE6K+ze/xb3t1VM3eszWt7N+n
	74iq+rTxAbkM4qmP52RQ7FGaDs3JusfCAdHErT9/RZ4suIfpfcVIzYqwvevSUa2qKCn/qRKPW+l
	sy+Z0jLy1Qir3VJG+awmecHi6IS1eAE2rdZu1Kg==
X-Gm-Gg: ASbGnctfWtNaW5NtWTRsWMIIIT2pqssr3aD0SnG3c00TzAV8nnVUeNumyXTrBbm16Zs
	dOLRTSrQw8Qua3U5zikMa8YFDL/wyhdJVNWNSSZX009JUzHhAtEDpqVNGucaUAXops+XVQfIYHV
	7AJyIpk3wSqW1ssyAb0i06EJM909h+J1xY/PWRSLM=
X-Google-Smtp-Source: AGHT+IFbRxxziGj2BzihiiIefEKFP4pKXzoO+Cko44mojAOneSA8QBwjLVS1Ez08euV3nw7DvxPdvtN7Zs6HHuF3qYM=
X-Received: by 2002:a05:6902:1b84:b0:e58:183e:90dc with SMTP id
 3f1490d57ef6-e5e245b50bemr12541057276.9.1740480104272; Tue, 25 Feb 2025
 02:41:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225-topic-sm8x50-iris-v10-v1-0-128ef05d9665@linaro.org>
 <20250225-topic-sm8x50-iris-v10-v1-2-128ef05d9665@linaro.org>
 <ityd34gfiyt6fvyuopnh3bi3edc5t2ubop4i72d54xyhhz3ixf@n6rnt5mwgw4b> <48f339f5-09f8-4498-83f2-4e2d773c3e23@linaro.org>
In-Reply-To: <48f339f5-09f8-4498-83f2-4e2d773c3e23@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 25 Feb 2025 12:41:33 +0200
X-Gm-Features: AQ5f1Jriekv6M1hA_Dp90ykj4fW8Drko1aw5vHpw5Zq0PDRQZa3NMmowkqpMd4U
Message-ID: <CAA8EJppFCF9Mf_LXr4EMV94rVw9qHJQFKtfXwuqTmtHQA=2gnA@mail.gmail.com>
Subject: Re: [PATCH 2/4] media: platform: qcom/iris: add reset_controller &
 power_off_controller to vpu_ops
To: neil.armstrong@linaro.org
Cc: Vikash Garodia <quic_vgarodia@quicinc.com>, Dikshita Agarwal <quic_dikshita@quicinc.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Feb 2025 at 12:04, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 25/02/2025 11:02, Dmitry Baryshkov wrote:
> > On Tue, Feb 25, 2025 at 10:05:10AM +0100, Neil Armstrong wrote:
> >> In order to support the SM8650 iris33 hardware, we need to provide specific
> >> reset and constoller power off sequences via the vpu_ops callbacks.
> >>
> >> Add those callbacks, and use the current helpers for currently supported
> >> platforms.
> >>
> >> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >> ---
> >>   drivers/media/platform/qcom/iris/iris_vpu2.c       |  2 ++
> >>   drivers/media/platform/qcom/iris/iris_vpu3.c       |  2 ++
> >>   drivers/media/platform/qcom/iris/iris_vpu_common.c | 14 ++++++++++----
> >>   drivers/media/platform/qcom/iris/iris_vpu_common.h |  4 ++++
> >>   4 files changed, 18 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/media/platform/qcom/iris/iris_vpu2.c b/drivers/media/platform/qcom/iris/iris_vpu2.c
> >> index 8f502aed43ce2fa6a272a2ce14ff1ca54d3e63a2..093e2068ec35e902f6c7bb3a487a679f9eada39a 100644
> >> --- a/drivers/media/platform/qcom/iris/iris_vpu2.c
> >> +++ b/drivers/media/platform/qcom/iris/iris_vpu2.c
> >> @@ -33,6 +33,8 @@ static u64 iris_vpu2_calc_freq(struct iris_inst *inst, size_t data_size)
> >>   }
> >>
> >>   const struct vpu_ops iris_vpu2_ops = {
> >> +    .reset_controller = iris_vpu_reset_controller,
> >>      .power_off_hw = iris_vpu_power_off_hw,
> >> +    .power_off_controller = iris_vpu_power_off_controller,
> >>      .calc_freq = iris_vpu2_calc_freq,
> >>   };
> >> diff --git a/drivers/media/platform/qcom/iris/iris_vpu3.c b/drivers/media/platform/qcom/iris/iris_vpu3.c
> >> index b484638e6105a69319232f667ee7ae95e3853698..95f362633c95b101ecfda6480c4c0b73416bd00c 100644
> >> --- a/drivers/media/platform/qcom/iris/iris_vpu3.c
> >> +++ b/drivers/media/platform/qcom/iris/iris_vpu3.c
> >> @@ -117,6 +117,8 @@ static u64 iris_vpu3_calculate_frequency(struct iris_inst *inst, size_t data_siz
> >>   }
> >>
> >>   const struct vpu_ops iris_vpu3_ops = {
> >> +    .reset_controller = iris_vpu_reset_controller,
> >>      .power_off_hw = iris_vpu3_power_off_hardware,
> >> +    .power_off_controller = iris_vpu_power_off_controller,
> >>      .calc_freq = iris_vpu3_calculate_frequency,
> >>   };
> >> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> >> index fe9896d66848cdcd8c67bd45bbf3b6ce4a01ab10..ec8b10d836d0993bcd722a2bafbb577b85f41fc9 100644
> >> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
> >> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
> >> @@ -211,7 +211,7 @@ int iris_vpu_prepare_pc(struct iris_core *core)
> >>      return -EAGAIN;
> >>   }
> >>
> >> -static int iris_vpu_power_off_controller(struct iris_core *core)
> >> +int iris_vpu_power_off_controller(struct iris_core *core)
> >>   {
> >>      u32 val = 0;
> >>      int ret;
> >> @@ -264,23 +264,29 @@ void iris_vpu_power_off(struct iris_core *core)
> >>   {
> >>      dev_pm_opp_set_rate(core->dev, 0);
> >>      core->iris_platform_data->vpu_ops->power_off_hw(core);
> >> -    iris_vpu_power_off_controller(core);
> >> +    core->iris_platform_data->vpu_ops->power_off_controller(core);
> >>      iris_unset_icc_bw(core);
> >>
> >>      if (!iris_vpu_watchdog(core, core->intr_status))
> >>              disable_irq_nosync(core->irq);
> >>   }
> >>
> >> -static int iris_vpu_power_on_controller(struct iris_core *core)
> >> +int iris_vpu_reset_controller(struct iris_core *core)
> >
> > If these functions are platform-specific, please rename them
> > accordingly, like iris_vpu2_3_foo() or just iris_vpu2_foo().
>
> They are not, this is the whole point.

I think they are, you are adding them to the platform-specific ops. In
the end, they are not applicable to 3.3.

>
> Neil
>
> >
> >>   {
> >>      u32 rst_tbl_size = core->iris_platform_data->clk_rst_tbl_size;
> >> +
> >> +    return reset_control_bulk_reset(rst_tbl_size, core->resets);
> >> +}
> >> +
> >> +static int iris_vpu_power_on_controller(struct iris_core *core)
> >> +{
> >>      int ret;
> >>
> >>      ret = iris_enable_power_domains(core, core->pmdomain_tbl->pd_devs[IRIS_CTRL_POWER_DOMAIN]);
> >>      if (ret)
> >>              return ret;
> >>
> >> -    ret = reset_control_bulk_reset(rst_tbl_size, core->resets);
> >> +    ret = core->iris_platform_data->vpu_ops->reset_controller(core);
> >>      if (ret)
> >>              goto err_disable_power;
> >>
> >> diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.h b/drivers/media/platform/qcom/iris/iris_vpu_common.h
> >> index 63fa1fa5a4989e48aebdb6c7619c140000c0b44c..c948d8b5aee87ccf1fd53c5518a27294232d8fb8 100644
> >> --- a/drivers/media/platform/qcom/iris/iris_vpu_common.h
> >> +++ b/drivers/media/platform/qcom/iris/iris_vpu_common.h
> >> @@ -12,7 +12,9 @@ extern const struct vpu_ops iris_vpu2_ops;
> >>   extern const struct vpu_ops iris_vpu3_ops;
> >>
> >>   struct vpu_ops {
> >> +    int (*reset_controller)(struct iris_core *core);
> >>      void (*power_off_hw)(struct iris_core *core);
> >> +    int (*power_off_controller)(struct iris_core *core);
> >>      u64 (*calc_freq)(struct iris_inst *inst, size_t data_size);
> >>   };
> >>
> >> @@ -21,7 +23,9 @@ void iris_vpu_raise_interrupt(struct iris_core *core);
> >>   void iris_vpu_clear_interrupt(struct iris_core *core);
> >>   int iris_vpu_watchdog(struct iris_core *core, u32 intr_status);
> >>   int iris_vpu_prepare_pc(struct iris_core *core);
> >> +int iris_vpu_reset_controller(struct iris_core *core);
> >>   int iris_vpu_power_on(struct iris_core *core);
> >> +int iris_vpu_power_off_controller(struct iris_core *core);
> >>   void iris_vpu_power_off_hw(struct iris_core *core);
> >>   void iris_vpu_power_off(struct iris_core *core);
> >>
> >>
> >> --
> >> 2.34.1
> >>
> >
>


-- 
With best wishes
Dmitry

