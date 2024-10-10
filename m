Return-Path: <linux-kernel+bounces-358732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9209982EB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8614282788
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCE91BE251;
	Thu, 10 Oct 2024 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PKOee0Fa"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9671BC9E3
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728554161; cv=none; b=uMQWs3qVa4OQ+PLmhF1P0QERGyvwOySfvuhP+3xFCRqkBksS4T+GEbx1/0CKZuDJ9cbI9D3TL7ZNgR+GNcKy9fOE0Z+xRWB/7XxCrOgu3Gb47rFsDujLxCpwypOAbTETelWZ+BmD5VU2g/iLmYu4W5+Zt3xu+67G2rkNvzwm7pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728554161; c=relaxed/simple;
	bh=XopSwLBUnKMXMFt2QF9TxC6ddo9IsvZRHm1kfbjdsR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pfp7DBRPw48RrKWQlDKncv8LFToddP+7766BBleveTEHgBs5H37I4bMqkzSUA9rxAP3OBvGaf35XTh+t9jOHa9FVDqMuDvHQ+mEl+28ur9HjItVh8/Ddmklmit7O0XYX3gT0PGcaujrd3wjlwVuvnwvF7i2kPNkDItTj1/GF+QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PKOee0Fa; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e28fe07e97dso689525276.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728554159; x=1729158959; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LOxBidp2LwpSxAPZkgwnhCDQ++zAlIni8FAvSy37V9Y=;
        b=PKOee0FanXR78U8uzaXTGICADQho+Maf6NiPaSKMo/svmaCa0hfIfTB6pafuAmns/9
         Qoz8jncV6dlVndVZWCxqI/PUSZ3+Aos3fYDHzDS+bKZqZBcpAK8Pg5FYJHKpRqY1h51v
         BJWplOrcBCVJxV+XhYYR+Dg3hYZgXV76kwNKhSb3KmLaADsjZ9xM0b8YwhZS2dLwfiZ9
         /RjTg2hfVrZa587JynC/T4ocdJRQFQnU0WSXWRwJyxS9okQdXO/KWLYjRmOvjkKixvLc
         uKjLuCMgWMQIPwZv1PL4XwwE4EjsGyLp/M17Cl/8GngV0Mh6cyLkTtVK2QEGDIPQjPBl
         F8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728554159; x=1729158959;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOxBidp2LwpSxAPZkgwnhCDQ++zAlIni8FAvSy37V9Y=;
        b=DYK7+qqsF84DbUSsa3BHtveokqOYQPsOPdptR+wnZ6i7NQQ/g7RA6QQyUIvJOUXY9k
         CaBgv2FHeVUxc6juS7fDNV+LSMKiWdEb++GFJ8dAEuA4B8yTYwOVgNLdD6T+0sqv5NL3
         QErp0b8I0h5/SzdR/nvYpExjLh7+XN1TlyAT5VJYkl4HuS14Y0Sglw5SR5hQUx7uYsDS
         yq/8+cneq57lSi2I8qBypepjs85zcDEnLo8c4ztoQ5VKh4qNFl3hAgV6ejB8ITitptho
         qq+TBAzhdZDjZQ/CWTSJFQHiXFvLILjgZuEM8mSfUEyoxiBs0Bn4xOl3GCFmhOkVZ1Hp
         Lb9w==
X-Forwarded-Encrypted: i=1; AJvYcCXPPpXaHduKQ/aIH3pLBHkt4ABByXRFsPezosA+M7FXEm79WqE4yyNT8ROfOsMbdeMGyLuztu0+VbNg/2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzI5DDb41HceEiTYKL4KBWsyzcboOacrZSd9bbrM9hbhifyx2F4
	h/HnYgMJKKrchzeVcZKb62Xl8FaAFphuDjeZUUwsFf0THyVb1yGDlWCIETCIGziz0ALVT78hgcl
	vSKxY6fIhVs0tLOZJshT7QilM6pZOuddD6daxrQ==
X-Google-Smtp-Source: AGHT+IHQZs+aj47vmsFfuBifBBcYuqtrZOQCAYpL4cJf6+m/xMJish6M+co6AowbOJStpK58DqwxzTCpkJFzob0nWP4=
X-Received: by 2002:a05:690c:7690:b0:6e3:39b6:5370 with SMTP id
 00721157ae682-6e339b65672mr605897b3.24.1728554158835; Thu, 10 Oct 2024
 02:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241010074246.15725-1-johan+linaro@kernel.org>
In-Reply-To: <20241010074246.15725-1-johan+linaro@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 10 Oct 2024 12:55:48 +0300
Message-ID: <CAA8EJpoiu2hwKWGMTeA=Kr+ZaPL=JJFq1qQOJhUnYz6-uTmHWw@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: mark pd-mapper as broken
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Chris Lew <quic_clew@quicinc.com>, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 10 Oct 2024 at 10:44, Johan Hovold <johan+linaro@kernel.org> wrote:
>
> When using the in-kernel pd-mapper on x1e80100, client drivers often
> fail to communicate with the firmware during boot, which specifically
> breaks battery and USB-C altmode notifications. This has been observed
> to happen on almost every second boot (41%) but likely depends on probe
> order:
>
>     pmic_glink_altmode.pmic_glink_altmode pmic_glink.altmode.0: failed to send altmode request: 0x10 (-125)
>     pmic_glink_altmode.pmic_glink_altmode pmic_glink.altmode.0: failed to request altmode notifications: -125
>
>     ucsi_glink.pmic_glink_ucsi pmic_glink.ucsi.0: failed to send UCSI read request: -125
>
>     qcom_battmgr.pmic_glink_power_supply pmic_glink.power-supply.0: failed to request power notifications
>
> In the same setup audio also fails to probe albeit much more rarely:
>
>     PDR: avs/audio get domain list txn wait failed: -110
>     PDR: service lookup for avs/audio failed: -110
>
> Chris Lew has provided an analysis and is working on a fix for the
> ECANCELED (125) errors, but it is not yet clear whether this will also
> address the audio regression.
>
> Even if this was first observed on x1e80100 there is currently no reason
> to believe that these issues are specific to that platform.
>
> Disable the in-kernel pd-mapper for now, and make sure to backport this
> to stable to prevent users and distros from migrating away from the
> user-space service.
>
> Fixes: 1ebcde047c54 ("soc: qcom: add pd-mapper implementation")
> Cc: stable@vger.kernel.org      # 6.11
> Link: https://lore.kernel.org/lkml/Zqet8iInnDhnxkT9@hovoldconsulting.com/
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Please don't break what is working. pd_mapper is working on all
previous platforms. I suggest reverting commit bd6db1f1486e ("soc:
qcom: pd_mapper: Add X1E80100") instead.

> ---
>
> It's now been over two months since I reported this regression, and even
> if we seem to be making some progress on at least some of these issues I
> think we need disable the pd-mapper temporarily until the fixes are in
> place (e.g. to prevent distros from dropping the user-space service).
>
> Johan
>
>
> #regzbot introduced: 1ebcde047c54
>
>
>  drivers/soc/qcom/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 74b9121240f8..35ddab9338d4 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -78,6 +78,7 @@ config QCOM_PD_MAPPER
>         select QCOM_PDR_MSG
>         select AUXILIARY_BUS
>         depends on NET && QRTR && (ARCH_QCOM || COMPILE_TEST)
> +       depends on BROKEN
>         default QCOM_RPROC_COMMON
>         help
>           The Protection Domain Mapper maps registered services to the domains
> --
> 2.45.2
>


-- 
With best wishes
Dmitry

