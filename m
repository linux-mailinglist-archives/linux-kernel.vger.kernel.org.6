Return-Path: <linux-kernel+bounces-310182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84109675F0
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 12:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 151EC1C20D41
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 10:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75B51684AE;
	Sun,  1 Sep 2024 10:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b="UK7WbqZg"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5813B14F9F7
	for <linux-kernel@vger.kernel.org>; Sun,  1 Sep 2024 10:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725187789; cv=none; b=XQc8XzF6+HeOPP1+7tc84gRxciGRW/HbSE7PUudE5oIgWnAVdzMlKeTAWux8Z0jGrOx77RR5ebdvUJMrCpjUyC48pMAuv8QIQMpgBo+dnLI5JYQ1UazyAkzzuv/aBIReEKVC2RyFpFPWB0Ziz2kFcuO+a18GhKSoGHQ1xHe+Gz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725187789; c=relaxed/simple;
	bh=4nwnklqqvsAc7MlMb9SGAUN0SLGRpyLpiVNTSWhiEsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+SB+OAxcOVtpR3OqY/96fFyo1lM/RmHBQNAghZkHiX4BTOAUfn9aTo1N29SAOuSIOzhDED5LE3SL02D/Se27MJRngWskzNpPcdqFN+bJKwumYj88D64qVdSP5VQ05FTyjQRmNj0DAWCFQeUwLlFgtBeXifpHj+Xdbg5qDyRiak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org; spf=pass smtp.mailfrom=kali.org; dkim=pass (2048-bit key) header.d=kali.org header.i=@kali.org header.b=UK7WbqZg; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kali.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kali.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa69dso2987822a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 01 Sep 2024 03:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1725187786; x=1725792586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhlOtzk6ka1oIdqe+onUSXvd3zsuH7hAUMYt+5lHzME=;
        b=UK7WbqZg6gjbhMMQDiu64lCfR1lupvljoKXesMQIP9yiqm+EWGqK0sI8ByX9CeZvgS
         /yIstKVWglrOOkWGJHqVf9glVv4TKBxxxZk3JqeRtaJUWrcto5pYZXZFvGFwj/O7NZJv
         qjaVqWcDO7xfBoj180Z72xc4Wog8xhqhTkmiTrs7Ly4kFHUw5twKBria7FQg18W3m8im
         4PUooQgHpbe+a84sUgXC2m7nC8F15ZnI/pTcEsC7gwnBxqhezJhpEyDeVUMPWVpBoGk6
         Uo3/j+3h7K1Yg5ddQVjtMet+qFIkaVYxTijan/04yM9Y6BitnJdkfneF0EPRumjflnfF
         ZIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725187786; x=1725792586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhlOtzk6ka1oIdqe+onUSXvd3zsuH7hAUMYt+5lHzME=;
        b=etU9MUC2rJN+KvyUieOOjvqvGzbqoZ7IBj2Y0F5beHrLjRC4I5K9Ad5LHAI5VfT4ot
         uoFJXzfZ/lMBsOwLG9meJkINDgevEp4snG9G31cVT6Z1w10E/Q0tcl/cb+oNVKQCFcjH
         FBKVe1+ABKE/x35vgto/bBzxCFl7xVc4FKowc7PwMuTfg6L48jp9MZtzY8XFCZyfHdKk
         JJuAWN+30t9NQhQUpNVlI4xfAOR9XVZ1uK6NM3jYG7ucEGZQIKoeV3s0rcuAMvb9TEfW
         OCbdRNmnckMgeTrjVkjB0AYKvhQaxBiA/rztmKjICD57h+ishQrVH+DjfyLU3yzT3/8i
         fmtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSQ/8ripitu62/6fhGjgBc7tbKgmQkilfp2EAPSoiaD+iir42VX3NMbwpdIxmaHsFa5lgAtlz0cw4u0dM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZnVXfKpHRAGW7PBGjAIL2akMz6D2Q5YKrb9BA3OJRNg26nLUj
	N7CXeQ8RWongvinXqCJ08LnTxmv7qMIoraStVWZmpOrJq11z6gz2nzAG7EFnoGtSKegFli+nS1O
	yVW6rNoQ4IzUowmKLFRnFoQ4lGgoBN5IFQBz/7Q==
X-Google-Smtp-Source: AGHT+IFwKp0NUUT00gkpVQ/Lgb5F42y9K4+DR9h8gGYvnQkPv2xwPRh8qm1SYQIv+iTl5XbdqKQgRJgi5DX3dMDLWss=
X-Received: by 2002:a05:6402:1e8c:b0:5c1:6abb:423c with SMTP id
 4fb4d7f45d1cf-5c242350df7mr2935480a12.2.1725187785486; Sun, 01 Sep 2024
 03:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901093024.18841-1-johan+linaro@kernel.org>
In-Reply-To: <20240901093024.18841-1-johan+linaro@kernel.org>
From: Steev Klimaszewski <steev@kali.org>
Date: Sun, 1 Sep 2024 05:49:33 -0500
Message-ID: <CAKXuJqgZhyyAP2vpSnyygcC0k+BzXU+Gq-O5NnFRWWebfSLD5Q@mail.gmail.com>
Subject: Re: [PATCH] clk: qcom: videocc-sm8350: use HW_CTRL_TRIGGER for vcodec GDSCs
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Abel Vesa <abel.vesa@linaro.org>, Konrad Dybcio <konradybcio@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Sun, Sep 1, 2024 at 4:31=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> A recent change in the venus driver results in a stuck clock on the
> Lenovo ThinkPad X13s, for example, when streaming video in firefox:
>
>         video_cc_mvs0_clk status stuck at 'off'
>         WARNING: CPU: 6 PID: 2885 at drivers/clk/qcom/clk-branch.c:87 clk=
_branch_wait+0x144/0x15c
>         ...
>         Call trace:
>          clk_branch_wait+0x144/0x15c
>          clk_branch2_enable+0x30/0x40
>          clk_core_enable+0xd8/0x29c
>          clk_enable+0x2c/0x4c
>          vcodec_clks_enable.isra.0+0x94/0xd8 [venus_core]
>          coreid_power_v4+0x464/0x628 [venus_core]
>          vdec_start_streaming+0xc4/0x510 [venus_dec]
>          vb2_start_streaming+0x6c/0x180 [videobuf2_common]
>          vb2_core_streamon+0x120/0x1dc [videobuf2_common]
>          vb2_streamon+0x1c/0x6c [videobuf2_v4l2]
>          v4l2_m2m_ioctl_streamon+0x30/0x80 [v4l2_mem2mem]
>          v4l_streamon+0x24/0x30 [videodev]
>
> using the out-of-tree sm8350/sc8280xp venus support. [1]
>
> Update also the sm8350/sc8280xp GDSC definitions so that the hw control
> mode can be changed at runtime as the venus driver now requires.
>
> Fixes: ec9a652e5149 ("venus: pm_helpers: Use dev_pm_genpd_set_hwmode to s=
witch GDSC mode on V6")
> Link: https://lore.kernel.org/lkml/20230731-topic-8280_venus-v1-0-8c8bbe1=
983a5@linaro.org/ # [1]
> Cc: Jagadeesh Kona <quic_jkona@quicinc.com>
> Cc: Taniya Das <quic_tdas@quicinc.com>
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/clk/qcom/videocc-sm8350.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/qcom/videocc-sm8350.c b/drivers/clk/qcom/videocc=
-sm8350.c
> index 5bd6fe3e1298..874d4da95ff8 100644
> --- a/drivers/clk/qcom/videocc-sm8350.c
> +++ b/drivers/clk/qcom/videocc-sm8350.c
> @@ -452,7 +452,7 @@ static struct gdsc mvs0_gdsc =3D {
>         .pd =3D {
>                 .name =3D "mvs0_gdsc",
>         },
> -       .flags =3D HW_CTRL | RETAIN_FF_ENABLE,
> +       .flags =3D HW_CTRL_TRIGGER | RETAIN_FF_ENABLE,
>         .pwrsts =3D PWRSTS_OFF_ON,
>  };
>
> @@ -461,7 +461,7 @@ static struct gdsc mvs1_gdsc =3D {
>         .pd =3D {
>                 .name =3D "mvs1_gdsc",
>         },
> -       .flags =3D HW_CTRL | RETAIN_FF_ENABLE,
> +       .flags =3D HW_CTRL_TRIGGER | RETAIN_FF_ENABLE,
>         .pwrsts =3D PWRSTS_OFF_ON,
>  };
>
> --
> 2.44.2
>
>
Being as I saw this as well locally, I've now tested with this patch
on top of 6.11-rc6 and can confirm that I don't see the splat anymore.
Tested-by: Steev Klimaszewski <steev@kali.org>

