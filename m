Return-Path: <linux-kernel+bounces-186190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CBF8CC0DC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11179B225D0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C634413D53D;
	Wed, 22 May 2024 12:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bV5BEHyS"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956A22E419
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 12:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716379618; cv=none; b=PKSnFiiB0Hq8ErpR+iZSCMBS/MQv+qoXkex6yLSLkhVs7paW41XN1smMOy3cN8FrtCVFORNibhA1t78uHqjMoYtEqF5rZ7wDau7QeY+x4xhGG82p8rb6Vuv3LVYLG/x+laNyyS7dWdhutL670D0ncNOg/MrQvQs5Al+XUntSWJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716379618; c=relaxed/simple;
	bh=l8mGvknHTzWtFbj5RUpRFzn09JwVZLzdQmHbClmO2uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e/qjmv9DBqgW5fptd2AmSbBgg0Qbxw+NLt4PA3hP8Ja6370ZdUrzmTpDM/oeAa4vEvJoUOhJM+qjcrwKTRYX55FY1zp4klWyWvQ48oniLvYB1KUX79NINoWZPNKmYh5mu/Guu0w2VDO7D75ghPJZPo7sH1nVUeghHDWh6nHelQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bV5BEHyS; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-db4364ecd6aso4591724276.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 05:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716379615; x=1716984415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lc8MH/ERVz0/zNRsbw+EsJ3jxruPmzSxi4vyb2sdC0U=;
        b=bV5BEHySJmtr4V554q2h2MUNKLO8j98dC6bIG7O6vpae4kMu9e9KxOhGsjKDymemW2
         xMyaQXnWamDEXSWn1T01Z3Mx5UJPVOUvuvUw0Gj8iXHNfwDPC76MITpvCYLL5Un91sDz
         xA7Q34GDv3KmucrX/MihcPW7LaXLS7xxm3eMT80vgC46aAkK9wE+YMEKNTHWptYQPgVE
         Y6Jv5kPvctqdVu2tzbGpWrblpInBf0OivKVOPC6GWREZg783H1Hp41sE30LUHBqctPDn
         CMe37xTh+N23z2OeGiUFsiETuvagAWbLBx355Z6m2pWCqjCYcDlmjau/5mm0GP/u8Xd7
         AA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716379615; x=1716984415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lc8MH/ERVz0/zNRsbw+EsJ3jxruPmzSxi4vyb2sdC0U=;
        b=qeheYYxiV2OxxKa9AiHUGnEA9Dz5k9MEJjChLOzRnrH7Y2a1W09W1h7rlJaQzPGiuZ
         85U6B6tox3+YdEZaXf4oyzB2fbyd665JWkOHTjivesZtHKDi/7NNkJRUAG/84iU8KH8m
         yVM9jvauzx7KClo+zkjB7L5N1soWzJyLy/08rHPfh+VcBUgdts6rdCBjw1vPM1VjI63g
         I03JEIFUk6hZ2pKYDumVc37CYBuxv4z+c4l9DVmtZHiGXxM9HUb9U7d0LrSC5N3Xt2SD
         2U+vGxKHHU4unT1Lb/r+UqfeVhSVAW3wZaSZBYEJxMRqqxRFCcRoENM5tk7GN5nSPonc
         Qx7A==
X-Forwarded-Encrypted: i=1; AJvYcCV0XuyCSdJnRVVlLaowNMY8l4Aff9MCeEPY22gz+f2Kuw4u25VUa2Vat8BhAw2aGYhv1k1/5uF6DatZei7F1/CR46wKriQiuvEJrRZh
X-Gm-Message-State: AOJu0YxJY/6ABaSK4pbPxCD/nuCe5TZfy+UJuib71vK5hiZiD/65pnyy
	tPy3/TEawcYjQ+RIf9AFMs/moygI4NjI/ER2kXYHbWCpjSpKWvRO3N3XmGb+zKIBkl5VLy2SdRq
	mop84LVe9gRaM67+N2QC2hwcQw/OiDcBLwExxmQ==
X-Google-Smtp-Source: AGHT+IHpHyUKG/GmLqQoeg1vLPIB9eeB0AaJTW12HFTA+hrVpt0r/xZ6/4Tabaj9XPGjQKIDdgxhVHeK1BqnFdQpUFA=
X-Received: by 2002:a25:e08b:0:b0:df4:80fa:c0c4 with SMTP id
 3f1490d57ef6-df4e0c0153dmr1704301276.34.1716379615443; Wed, 22 May 2024
 05:06:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522-topic-spmi_multi_master_irqfix-v1-1-f7098b9c8804@linaro.org>
In-Reply-To: <20240522-topic-spmi_multi_master_irqfix-v1-1-f7098b9c8804@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 22 May 2024 15:06:44 +0300
Message-ID: <CAA8EJprgXSF=x834=PRXrHhh7VRyynbApnO-iFoE=cLYFzM6iQ@mail.gmail.com>
Subject: Re: [PATCH] spmi: pmic-arb: Pass the correct of_node to irq_domain_add_tree
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Abel Vesa <abel.vesa@linaro.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 May 2024 at 14:38, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> Currently, irqchips for all of the subnodes (which represent a given
> bus master) point to the parent wrapper node. This is no bueno, as
> no interrupts arrive, ever (because nothing references that node).
>
> Fix that by passing a reference to the respective master's of_node.
>
> Worth noting, this is a NOP for devices with only a single master
> described.
>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/spmi/spmi-pmic-arb.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> index 791cdc160c51..46ea93f78dcd 100644
> --- a/drivers/spmi/spmi-pmic-arb.c
> +++ b/drivers/spmi/spmi-pmic-arb.c
> @@ -1737,8 +1737,7 @@ static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
>
>         dev_dbg(&pdev->dev, "adding irq domain for bus %d\n", bus_index);
>
> -       bus->domain = irq_domain_add_tree(dev->of_node,
> -                                         &pmic_arb_irq_domain_ops, bus);
> +       bus->domain = irq_domain_add_tree(node, pmic_arb_irq_domain_ops, bus);

Shouldn't it be &pmic_arb_irq_domain_ops ?

>         if (!bus->domain) {
>                 dev_err(&pdev->dev, "unable to create irq_domain\n");
>                 return -ENOMEM;
>
> ---
> base-commit: 8314289a8d50a4e05d8ece1ae0445a3b57bb4d3b
> change-id: 20240522-topic-spmi_multi_master_irqfix-f63ebf47b02c
>
> Best regards,
> --
> Konrad Dybcio <konrad.dybcio@linaro.org>
>


-- 
With best wishes
Dmitry

