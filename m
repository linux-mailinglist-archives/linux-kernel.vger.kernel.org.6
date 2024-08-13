Return-Path: <linux-kernel+bounces-284609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8B5950308
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 608F1B25038
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 10:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C869F19AD6C;
	Tue, 13 Aug 2024 10:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sEdlSNcA"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A05519CD04
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546413; cv=none; b=PybosIP8EDSjfdHR9ctIwGRIw+X5/MJLMO5X9TFDS7wZp0Lwea8q/cTzBLGwx7zMEKH7EqsJ08ASnQPRgcb6s28YmfeMaxb6NGE5ocTlrTVwNoQwSBruUwEtZ4Hb5RP0plhmv0c+dS2jq1RPqBAj4sUDKufnaOcDU4Pf+pO/vkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546413; c=relaxed/simple;
	bh=q8pNAgjw9/3tHHnWRFEJHbq63k2GtWgWLWiFMw3DnYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nvksb3kydbtbD9GJMStGpPObYMtnBcFUMWNLpBnBT3KlNaXpt3A9PegqKKPZ0JK8gOcMj1kAUpgBqX9WQk83/Bs5Dd3Qup9dNE/2oYZ9KpQrV0LFYN2vfl1aCrelpJLhKQeZpbkKde7jIuWTSkPSkoolx71+JTwsznQfsmavyWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sEdlSNcA; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dfef5980a69so5324091276.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 03:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723546410; x=1724151210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/XDKrkkMHvWOyw5p4QJtIumEMqEgD/xVT5SgNZelBg=;
        b=sEdlSNcA8pSYeZNy35Z2d1R7MRMOAVlMv4/gVXeJX1wtken5bplBAjFKLj7tKdfAWC
         /koFQ1lBpwnPUFM/0ACdAQ8+qi77W+Ww1FS0PYzDigSLy53renVmyyerIu7JwgtIRgrx
         4/q2xO80uPNHstpCiSzsUh9j7IsvbYDwsnymmJ+wEGTpVJdOlYgqRZwCZNLk8ObU97v1
         Axvh0XhbtKmKhoOjaONO5bwEkV/3scoW4QOMnLm6J4OdnvtfN9ZGdn8HWTa6O3txUzDa
         iU++OLVw8k97JY6mxTEMWxT4ucEIdop3BA0kNIyD8bCFYuLZFUN0PhGp4VexqTuCtMCL
         xYXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723546410; x=1724151210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z/XDKrkkMHvWOyw5p4QJtIumEMqEgD/xVT5SgNZelBg=;
        b=LN3BMin/jtti0YSkVKyEbeA+CdneXgUSS2I1Iu/Cp8XfERhH1t7ZgJQkUd9djXARYx
         f2EyJ0ZPbfhSoMssEwmd5R4MOIVWHvbCxtB5Nw46TEV6qNRYaN4SGzshC1qw5WhxqK3k
         I/LyZrTmRTbeF4W1e4I2tAq2xfCiVo7TbGgPhKRhJGGqQxSazfmcOKmWQMMqvw9TG0sb
         JWXUVdwOP0iVMGgffPMSv3f0jBRXw0pfB7LBQoGDfdCyBHGsyDqm/bvikIuDxaOQbJhG
         oR8e2DHwJ7v1JdA/W2+HvL/aOMzgtsf5/3xPDzYUuiaMbTI2Q17iOq1hq4UtKY/KlrfC
         xqfw==
X-Forwarded-Encrypted: i=1; AJvYcCXhgzgnZSKJXbqttJLrEmFIum2U5UKWOAlf7327Jzck3eLLyo6/aPv1TzAPcfzJOwiOCNP8HXlZWsYv+t5bQnWR9pVIThRWRbkarViC
X-Gm-Message-State: AOJu0YzrOIKSIVkJ1s7wny8HAMh6BbFvmrKsyUVPlGySQceStFPt9Cq1
	uDgz+JlPXiRnmDHzkd87deppFkghww6WU9hAC5inJMfH28qMARnybSdu7KaOIiljMR3+sibAcJ0
	j2uCIneKuk3HouEj0xylIuvlrkSxMlOuY3MX9dGEqTNMOZYkuIww=
X-Google-Smtp-Source: AGHT+IFItO0D7OclX/S5B/e5ClqeA9JU/P3uqhBqfY7zfqkekKMs8wX80GxMDY1wDSzUbaTJC9QhhNMbySj25mpFIPs=
X-Received: by 2002:a05:6902:13cf:b0:e0e:cd17:6130 with SMTP id
 3f1490d57ef6-e113d07894cmr3177420276.37.1723546409963; Tue, 13 Aug 2024
 03:53:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1723014947-15571-1-git-send-email-quic_dikshita@quicinc.com> <1723014947-15571-2-git-send-email-quic_dikshita@quicinc.com>
In-Reply-To: <1723014947-15571-2-git-send-email-quic_dikshita@quicinc.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 13 Aug 2024 12:52:53 +0200
Message-ID: <CAPDyKFpUMmveKQ2Pi33VwcvG9tsMQHEcAg88icf7v9mzzm+k4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PM: domains: add device managed version of dev_pm_domain_attach|detach_list()
To: Dikshita Agarwal <quic_dikshita@quicinc.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Aug 2024 at 09:16, Dikshita Agarwal <quic_dikshita@quicinc.com> wrote:
>
> Add the devres-enabled version of dev_pm_domain_attach|detach_list.
> If client drivers use devm_pm_domain_attach_list() to attach the
> PM domains, devm_pm_domain_detach_list() will be invoked implicitly
> during remove phase.
>
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>  drivers/base/power/common.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pm_domain.h   | 13 +++++++++++++
>  2 files changed, 57 insertions(+)
>
> diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
> index 327d168..729d6c2 100644
> --- a/drivers/base/power/common.c
> +++ b/drivers/base/power/common.c
> @@ -277,6 +277,50 @@ int dev_pm_domain_attach_list(struct device *dev,
>  EXPORT_SYMBOL_GPL(dev_pm_domain_attach_list);
>
>  /**
> + * devm_pm_domain_detach_list - devres-enabled version of dev_pm_domain_detach_list.
> + * @_list: The list of PM domains to detach.
> + *
> + * This function reverse the actions from devm_pm_domain_attach_list().
> + * it will be invoked during the remove phase from drivers implicitly if driver
> + * uses devm_pm_domain_attach_list() to attach the PM domains.
> + */
> +void devm_pm_domain_detach_list(void *_list)
> +{
> +       struct dev_pm_domain_list *list = _list;
> +
> +       dev_pm_domain_detach_list(list);
> +}
> +EXPORT_SYMBOL_GPL(devm_pm_domain_detach_list);

I think this function should be internal and hence made static -
unless there is a good reason to export it?

> +
> +/**
> + * devm_pm_domain_attach_list - devres-enabled version of dev_pm_domain_attach_list
> + * @dev: The device used to lookup the PM domains for.
> + * @data: The data used for attaching to the PM domains.
> + * @list: An out-parameter with an allocated list of attached PM domains.
> + *
> + * NOTE: this will also handle calling devm_pm_domain_detach_list() for
> + * you during remove phase.
> + *
> + * Returns the number of attached PM domains or a negative error code in case of
> + * a failure.
> + */
> +int devm_pm_domain_attach_list(struct device *dev,
> +                              const struct dev_pm_domain_attach_data *data,
> +                              struct dev_pm_domain_list **list)
> +{
> +       int ret, num_pds = 0;

There is no need to initialize num_pds to 0 here, as the below calls
take care of it.

> +
> +       num_pds = dev_pm_domain_attach_list(dev, data, list);
> +

We should add a check if num_pds is zero here, as in that case there
is no reason to add a devres callback for it.

> +       ret = devm_add_action_or_reset(dev, devm_pm_domain_detach_list, *list);
> +       if (ret)
> +               return ret;
> +
> +       return num_pds;
> +}
> +EXPORT_SYMBOL_GPL(devm_pm_domain_attach_list);

[...]

Kind regards
Uffe

