Return-Path: <linux-kernel+bounces-544182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1EAA4DE52
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100BD1896EBC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C392045A2;
	Tue,  4 Mar 2025 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="PdVyzvsN"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51AA2905
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741092570; cv=none; b=c4GmPcr+UJgYQcqLtR+65rvvZEgQyeovKh3pHtdS0yaFjL4aKsqjy2Ui9RmaHnkH1VK5NncAIIqsAnwOVmJIjYf26adhpBoXcWFGAfeusp8gM60Tefi3THe2VKWF1lEIEaRlTQNhiiYneDtnpt06cMEqxRUc5Gnup+vSKiBfd3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741092570; c=relaxed/simple;
	bh=y1JiEvA5YJeVuAAardTiN2YK3GwAoCPLxP/Lzpc6+u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBkPRdiddxGJZYLwREntOMNbZHpPf5psI052Wo0T+zC0CaSb2AWStf/A73c87izF6tEfoCMc2P/MKKqHEIAoc/jr8hVewdeE2rbRFAhoH3HNdegHZm7dPp/vOUCWKX60ps0yjdb3Qguo7PIDaqliLyS91m3VIsyRHJ5ShXTfgjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=PdVyzvsN; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5494bc8a526so4911773e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 04:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1741092565; x=1741697365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18RAz/nr30KjjR+59TLwJIYBS7O4SDXvbDkuRrF+ZWc=;
        b=PdVyzvsNne6Fu+fAah6+GSe3+wAPiy48+ld1fyvR5kZfPwbxbgTG+fkph0fHDWWt6C
         8EV/F53JAzsb0BD7AsgHvV1CrC2doa/jGLR7ozzuaQ4P2Bc8w2S5MAeXaNkcD8MpM8Sw
         kQBcR/tS8szeqDAuzgdu2YLPISncfDziZz7Lywaod6UbgzErvqD9KLV7BqOoHrCkd/ux
         OBFXMLBgqRLELkISxPcC66E4wmDvc9ipAefNqvZAD9MXkTdfCO7fhlVnrWjqnTGcYTdr
         VQnQHVlVZfzAVf8rz9NzuXBkq2TUmEAKEJ/BxpBHhIYCyjZEYf2mTCbe6wPXL/JGpFNo
         S7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741092565; x=1741697365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=18RAz/nr30KjjR+59TLwJIYBS7O4SDXvbDkuRrF+ZWc=;
        b=Qb+N1H1ctefY60Hrt+XvEt56/dLlEDXHXc3NFY1C4JcmDFZhmEos0MEDwlcv9/d54/
         EC+DrhcilYnl06+QpZaNXL2ceOsnjkEooUrhfHa4Pwvu+5RzMAQGI0belOIgiFa2DQPU
         Rc5RXe/TatWo34l5eL3lkoJo+DGroZ1nEZ01uFKptrMHcHpFAoQjiW7obpfTQsyl8gH9
         3ki1R0JtBxbQCz0jjWAbTsEAOFjCqygvqkfTCmTFfzTShyidGMsBpKcUKEpRR6IPnHDN
         efTq6f/EUrxoM47vJuyLlE9TD0kJccdhl/MHGjB6fnRH+lyK4LDrIEl/T7I0E4JwH/1y
         z59Q==
X-Forwarded-Encrypted: i=1; AJvYcCWd8SEbvVM95YreSPt03soJesmM+uQHxlm8XmBJ3XUiDQVvGXVP6EfN/nOXdJ5cnBtrWtBcu5jiniPpgAc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8+9jO9N6frftClHQTeEAEWRghTzlUbU08SXq670MnwqLOgWWK
	EAeliwLFtZ/wJDAvuAV3nIpLJUr2jbLZutDBdClxjW87Xx5CxiSrkIYNOUWXRFSG2buCHyeBY5C
	tJieEiJNwoA6qh6CPFQ/Uh+0DudDNrE8LimQN7CEWgZY63CnP2bU=
X-Gm-Gg: ASbGncsIxmYUg+MQx53YxDsP1Z27gQfTA6svn/70af8M3Ua9A9dbJkBz/2h97NdGChL
	klptFu/wsMSNpDcAd4jLmphxz4n9n3J+VBAEngX7TA18SGuAUL+kWqjDUG7BJTQVUz8ECLOfoax
	UXGYwVXXXcu/n+4Ex60IYP6iHsnyU9xqm91wItcoil8gvWniGBfvMcdKHwQg==
X-Google-Smtp-Source: AGHT+IFPYnPszG+JGbUIdQBxNwn+WgAZt7AWLuKPTHhrwo2T0MLplVTmRvwk7c97zqZJH/9jMUbrqEzKp2KIhvayvMs=
X-Received: by 2002:a05:6512:124a:b0:545:16d5:8e89 with SMTP id
 2adb3069b0e04-5494c31cb4amr5797281e87.30.1741092564026; Tue, 04 Mar 2025
 04:49:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227-multi_waitq_scm-v5-0-16984ea97edf@oss.qualcomm.com> <20250227-multi_waitq_scm-v5-2-16984ea97edf@oss.qualcomm.com>
In-Reply-To: <20250227-multi_waitq_scm-v5-2-16984ea97edf@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 4 Mar 2025 13:49:12 +0100
X-Gm-Features: AQ5f1JqD8A8NMewR1JrGuYXTuDfX-mAMgbFhbREvfy4komj1B1raSorn5S0eXxE
Message-ID: <CAMRc=MeDcMbH=xFZnr=_NZPQ2X9eOfRoRHnS1LJ6M54KwHMVRQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] firmware: qcom_scm: Support multiple waitq contexts
To: Unnathi Chalicheemala <unnathi.chalicheemala@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@oss.qualcomm.com, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Prasad Sodagudi <prasad.sodagudi@oss.qualcomm.com>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, Trilok Soni <quic_tsoni@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 6:40=E2=80=AFAM Unnathi Chalicheemala
<unnathi.chalicheemala@oss.qualcomm.com> wrote:
>
> Currently, only a single waitqueue context exists, with waitqueue id zero=
.
> Multi-waitqueue mechanism is added in firmware to support the case when
> multiple VMs make SMC calls or single VM making multiple calls on same CP=
U.
>
> When VMs make SMC call, firmware will allocate waitqueue context assuming
> the SMC call to be a blocking call. SMC calls that cannot acquire resourc=
es
> are returned to sleep in the calling VM. When resource is available, VM
> will be notified to wake sleeping thread and resume SMC call.
> SM8650 firmware can allocate two such waitq contexts so create these two
> waitqueue contexts.
>
> Unique waitqueue contexts are supported by a dynamically sized array wher=
e
> each unique wq_ctx is associated with a struct completion variable for ea=
sy
> lookup. To get the number of waitqueue contexts directly from firmware,
> qcom_scm_query_waitq_cnt() is introduced. On older targets which support

Seems like it's actually called qcom_scm_query_waitq_count

> only a single waitqueue, wq_cnt is set to 1 as SCM call for
> query_waitq_cnt() is not implemented for single waitqueue case.
>
> Signed-off-by: Unnathi Chalicheemala <unnathi.chalicheemala@oss.qualcomm.=
com>
> ---
>  drivers/firmware/qcom/qcom_scm.c | 75 ++++++++++++++++++++++++++++------=
------
>  1 file changed, 53 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qco=
m_scm.c
> index 1aa42685640da8a14191557896fbb49423697a10..ec139380ce5ba6d11f1023258=
e1d36edcf3d9d45 100644
> --- a/drivers/firmware/qcom/qcom_scm.c
> +++ b/drivers/firmware/qcom/qcom_scm.c
> @@ -47,7 +47,7 @@ struct qcom_scm {
>         struct clk *iface_clk;
>         struct clk *bus_clk;
>         struct icc_path *path;
> -       struct completion waitq_comp;
> +       struct completion *waitq;
>         struct reset_controller_dev reset;
>
>         /* control access to the interconnect path */
> @@ -57,6 +57,7 @@ struct qcom_scm {
>         u64 dload_mode_addr;
>
>         struct qcom_tzmem_pool *mempool;
> +       unsigned int wq_cnt;
>  };
>
>  struct qcom_scm_current_perm_info {
> @@ -2118,6 +2119,25 @@ static int qcom_scm_fill_irq_fwspec_params(struct =
irq_fwspec *fwspec, u32 virq)
>         return 0;
>  }
>
> +static int qcom_scm_query_waitq_count(struct qcom_scm *scm)
> +{
> +       int ret;
> +       struct qcom_scm_desc desc =3D {
> +               .svc =3D QCOM_SCM_SVC_WAITQ,
> +               .cmd =3D QCOM_SCM_WAITQ_GET_INFO,
> +               .owner =3D ARM_SMCCC_OWNER_SIP
> +       };
> +       struct qcom_scm_res res;
> +
> +       ret =3D qcom_scm_call_atomic(scm->dev, &desc, &res);

This can fail for a multitude of reasons - some of which we may want
to propagate to the caller, how about being more fine-grained and
using __qcom_scm_is_call_available() to check if
QCOM_SCM_WAITQ_GET_INFO is available first?

> +       if (ret) {
> +               dev_err(scm->dev, "Multi-waitqueue support unavailable\n"=
);

Is this an error though? From the commit message it seems it's normal
operation on older platforms?

Bartosz


> +               return 1;
> +       }
> +
> +       return res.result[0] & GENMASK(7, 0);
> +}
> +
>  static int qcom_scm_get_waitq_irq(void)
>  {
>         int ret;
> @@ -2149,42 +2169,40 @@ static int qcom_scm_get_waitq_irq(void)
>         return ret;
>  }
>
> -static int qcom_scm_assert_valid_wq_ctx(u32 wq_ctx)
> +static struct completion *qcom_scm_get_completion(u32 wq_ctx)
>  {
> -       /* FW currently only supports a single wq_ctx (zero).
> -        * TODO: Update this logic to include dynamic allocation and look=
up of
> -        * completion structs when FW supports more wq_ctx values.
> -        */
> -       if (wq_ctx !=3D 0) {
> -               dev_err(__scm->dev, "Firmware unexpectedly passed non-zer=
o wq_ctx\n");
> -               return -EINVAL;
> -       }
> +       struct completion *wq;
>
> -       return 0;
> +       if (WARN_ON_ONCE(wq_ctx >=3D __scm->wq_cnt))
> +               return ERR_PTR(-EINVAL);
> +
> +       wq =3D &__scm->waitq[wq_ctx];
> +
> +       return wq;
>  }
>
>  int qcom_scm_wait_for_wq_completion(u32 wq_ctx)
>  {
> -       int ret;
> +       struct completion *wq;
>
> -       ret =3D qcom_scm_assert_valid_wq_ctx(wq_ctx);
> -       if (ret)
> -               return ret;
> +       wq =3D qcom_scm_get_completion(wq_ctx);
> +       if (IS_ERR(wq))
> +               return PTR_ERR(wq);
>
> -       wait_for_completion(&__scm->waitq_comp);
> +       wait_for_completion(wq);
>
>         return 0;
>  }
>
>  static int qcom_scm_waitq_wakeup(unsigned int wq_ctx)
>  {
> -       int ret;
> +       struct completion *wq;
>
> -       ret =3D qcom_scm_assert_valid_wq_ctx(wq_ctx);
> -       if (ret)
> -               return ret;
> +       wq =3D qcom_scm_get_completion(wq_ctx);
> +       if (IS_ERR(wq))
> +               return PTR_ERR(wq);
>
> -       complete(&__scm->waitq_comp);
> +       complete(wq);
>
>         return 0;
>  }
> @@ -2260,6 +2278,7 @@ static int qcom_scm_probe(struct platform_device *p=
dev)
>         struct qcom_tzmem_pool_config pool_config;
>         struct qcom_scm *scm;
>         int irq, ret;
> +       int i;
>
>         scm =3D devm_kzalloc(&pdev->dev, sizeof(*scm), GFP_KERNEL);
>         if (!scm)
> @@ -2270,7 +2289,19 @@ static int qcom_scm_probe(struct platform_device *=
pdev)
>         if (ret < 0)
>                 return ret;
>
> -       init_completion(&scm->waitq_comp);
> +       ret =3D qcom_scm_query_waitq_count(scm);
> +       if (ret < 0)
> +               return ret;
> +
> +       scm->wq_cnt =3D ret;
> +
> +       scm->waitq =3D devm_kcalloc(&pdev->dev, scm->wq_cnt, sizeof(*scm-=
>waitq), GFP_KERNEL);
> +       if (!scm->waitq)
> +               return -ENOMEM;
> +
> +       for (i =3D 0; i < scm->wq_cnt; i++)
> +               init_completion(&scm->waitq[i]);
> +
>         mutex_init(&scm->scm_bw_lock);
>
>         scm->path =3D devm_of_icc_get(&pdev->dev, NULL);
>
> --
> 2.34.1
>
>

