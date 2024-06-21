Return-Path: <linux-kernel+bounces-224788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F078D9126E1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42209B273FD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 13:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D762BA31;
	Fri, 21 Jun 2024 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Gro7t4v8"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FC2B667
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 13:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718977376; cv=none; b=ktu0zMK7ErC4lLkxdMgA8gwc5iE/zgRhS5mp5rW0uI1moJqLfIwG2egcVAcVVkDyi39XXKqdrdjd81rOBBrcibeKNxrufiruDuWf/Co366brtMqWu2oGSw2/k1ggZshGggrna4JoziRggYK3HvS5GlemsC/XWuRVyEq8PgetYfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718977376; c=relaxed/simple;
	bh=xTDco5y5zMHfNQrIXpXx9hG93QyktZFABb4TC1wrwiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uk2eTVUJRE3fvjrLP2QpriQcjyT5ZUYJtaX4jJ0d7WWbR1QKKxzxCVvETOFig3/qCTowTyOtV2UCqqd0lzhebNvvVho5RcGtETJc0T64gJJs9wycUo0kwj74HB0QM+QnI1MDEJRX5/7sMJjp7nN9/RsYSjcOjrWqI0mz40P1v0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Gro7t4v8; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52c815e8e9eso2109858e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 06:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1718977372; x=1719582172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ok5aSN9mBgn8wrFYODhxaqdyy2yPpSIKzg8yKMrNqU=;
        b=Gro7t4v8IQ1tvOAerQff5wO4SCPfoMGUkwnreo7DcOe5UmIQFKkZBF0JYyzYgJY9Du
         O9lu9SJwbcCfqOhlS5jzNM0A81tdNrB63xQx9iyTUUfIKSS7YX0IYqrwGeIwNFtl2Ocl
         O6O26Cu1jwU286u2H1PVTWXAwLI+TdemYeGWiuP7t9HVRw+ijNd9cIx45QHE1rte6Sbq
         VAlcgq98LX1ZL4lPLdxzOo9WNzVQkVpAaC30DVdFr5vE1mPnxEL+uJElrjdy+kkHK/z6
         QFDHVoJa+I7N9cAFz7G6sszKMQbTe152cj7OfyDfTB9E9P4Qws9p32cpSCdPk9titY+W
         oJFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718977372; x=1719582172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ok5aSN9mBgn8wrFYODhxaqdyy2yPpSIKzg8yKMrNqU=;
        b=uJxN4bog9cnfMF3S5Np+otH0hNROvm5Ur9+F5iRv4bgIjacK85YZhORbEr4Ex4Q/zT
         e8/AszPizeg4N7O9zrZpd+5iiKeXbniy8lJyVrojIN21RC/Jt/Bpfh3t0F4Q3vH0Gcjt
         QANoFZ3SDoKg/v5ExHCe9+UWTra12XXR6CF4F4UiN9wSIs2rfCfMXL5cAITmcLeRDEn6
         oGPioBIgiHlzkrFilH/oLoYbndfJiC2sl5/0pn80xInPiN8gDgAQcgUstnD90mUs8N0S
         at+kZpx0EAZsmTMuWPgAFW5MvBNNbmRnK8DmwwwvbrINT9Ul5RcjCEzX7PIz2io3rVog
         lKqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt+ppElgGRSVxdykrt6xEYUwp3OenuCz9sHRDGi4jlJDFwXLzp+7wJyTfMzRedjtvTAf3WBmMbjqDOmDKFYy5YBnkPaDJzopOC8/0A
X-Gm-Message-State: AOJu0YwWz1OH2IypY41Dl2xgdg8sv3ZVuWWRMr8l51ucvES0c2vh8Lt9
	ZCw23TXgo5VHmOK6PpPFbhASuK6BKRQUJNXVxzM2ZFw9VP+Qe8Vomnytne2kuu3HZ/zi3RMnWv4
	zqSt4oz1o9UQ/WJtV+lSB7HExfB51PdKMKeHRRw==
X-Google-Smtp-Source: AGHT+IHdpPft57o1H9+QCaSg+D/jEJgjvnJh9jmVAke5h3wFi+XaALCQ+22Vt7cHkTOx5G0TXYGs34rFU5FJ7o52p94=
X-Received: by 2002:a05:6512:3582:b0:52c:dbc7:3d36 with SMTP id
 2adb3069b0e04-52cdbc73f0bmr285147e87.26.1718977372099; Fri, 21 Jun 2024
 06:42:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527-shm-bridge-v10-0-ce7afaa58d3a@linaro.org>
 <20240527-shm-bridge-v10-13-ce7afaa58d3a@linaro.org> <20240620155335645-0700.eberman@hu-eberman-lv.qualcomm.com>
In-Reply-To: <20240620155335645-0700.eberman@hu-eberman-lv.qualcomm.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 21 Jun 2024 15:42:40 +0200
Message-ID: <CAMRc=McKtc5CSJPhJ8syqukGnVC8MXuWdv0oEFY-Jaxi_GM19g@mail.gmail.com>
Subject: Re: [PATCH v10 13/15] firmware: qcom: scm: clarify the comment in qcom_scm_pas_init_image()
To: Elliot Berman <quic_eberman@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Robert Marko <robimarko@gmail.com>, Das Srinagesh <quic_gurus@quicinc.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Alex Elder <elder@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Andrew Halaney <ahalaney@redhat.com>, Deepti Jaggi <quic_djaggi@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 12:54=E2=80=AFAM Elliot Berman <quic_eberman@quicin=
c.com> wrote:
>
> On Mon, May 27, 2024 at 02:55:03PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The "memory protection" mechanism mentioned in the comment is the SHM
> > Bridge. This is also the reason why we do not convert this call to usin=
g
> > the TZ memory allocator.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-think=
pad-x13s
> > Tested-by: Deepti Jaggi <quic_djaggi@quicinc.com> #sa8775p-ride
> > Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
> > ---
> >  drivers/firmware/qcom/qcom_scm.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/q=
com_scm.c
> > index c82957727650..86e26f17ca19 100644
> > --- a/drivers/firmware/qcom/qcom_scm.c
> > +++ b/drivers/firmware/qcom/qcom_scm.c
> > @@ -583,6 +583,13 @@ int qcom_scm_pas_init_image(u32 peripheral, const =
void *metadata, size_t size,
> >        * During the scm call memory protection will be enabled for the =
meta
> >        * data blob, so make sure it's physically contiguous, 4K aligned=
 and
> >        * non-cachable to avoid XPU violations.
> > +      *
> > +      * For PIL calls the hypervisor creates SHM Bridges for the blob
> > +      * buffers on behalf of Linus so we must not do it ourselves henc=
e
>                                 Linux

Can this be fixed when applying? I don't think there's anything else
that warrants a respin.

Bart

> > +      * not using the TZMem allocator here.
> > +      *
> > +      * If we pass a buffer that is already part of an SHM Bridge to t=
his
> > +      * call, it will fail.
> >        */
> >       mdata_buf =3D dma_alloc_coherent(__scm->dev, size, &mdata_phys,
> >                                      GFP_KERNEL);
> >
> > --
> > 2.43.0
> >

