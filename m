Return-Path: <linux-kernel+bounces-239066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6997A9255B1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 10:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211AE1F2355D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 08:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD687D3E8;
	Wed,  3 Jul 2024 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="0Wx03H80"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6C328684
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719996329; cv=none; b=F0q2ipjVXBMikOAkyvZ/qDnSquU5lStjDAdLTuVDRsVfm/UcdPt5wt9NOPFQW4uOk1UfnZl0sE53sInBHrdgBg8HYdVFI1vo+g/se9xwryTEuvWXyF/0lXKJ8/noLeCBHOSHsHn5GkWSz35QBesIQaln3B6iRDAmUJtxBDLC7ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719996329; c=relaxed/simple;
	bh=1/78X+s0pwLYqNvet2Tcy5BBn4d0W8hkbGlv0yYIueY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pUMz+ysDE0VAshyIWkHD7WUdPBkP1TdjNwXLV8xKZ+Th7eoICChgset64RUeyRbEi51SwEjB2iU8G0wsDuzBtzLXOMw6Md2aLjn5+PubbzcaKTXSafjrl5gZkq+6KWMV1jE0oS2fhp/RtO5GmxBCArgdkOXTHyWWEWGWchjcL3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=0Wx03H80; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2ebeefb9a7fso57140361fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 01:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1719996325; x=1720601125; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnVZx57sQWGSbnJ3zKpnLdMuefpCU4Ga5SRMPYlDzsY=;
        b=0Wx03H80EQc74/PdjBeqLLJWkyt2wzJBTncu1h3lBfdmdC1cJeEGjY9BD/qDIvg2l0
         uilVxTPYaNEByY9uKABiFi3sTDD0ymcf6yMySxgmIUH1oBHm2osgh0mR6TS0bf0sbamJ
         aVxPvpuZscq9t3UdFiulRCGro2KO66xOe1DHQgD1byqYAeFu11vxCNHqtgF2MxAIW3Ha
         rqMh0XdN3+48/Exj9zmqJIMC7tRr/nqZO9amK52tc+pjVGb72JV/mN/qQ1POmLJIBZcP
         acShnn3JcKiEm+6D9rp9b/I1FDDhqCe4YuiekmNXY8+TLhib9gzG56011m+24+dFnmzp
         QWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719996325; x=1720601125;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnVZx57sQWGSbnJ3zKpnLdMuefpCU4Ga5SRMPYlDzsY=;
        b=byVODJISZ4HMoFqDrGMSkmvzF9/oETsV1j3iWafW/pD5wfDKraH5+DtJHDFGV18nQh
         X5csll/0gkg+ePL5mqz7uFuYuMa7rDw2gzXcPguZk9qT1w0c+TMmTWtAI+U5DB1HY6Dj
         5ZNlvkA7f6wvoo1FCzy3DxiOeVhx+yoWT3rVafSxlXc0B884R023H/QQsU2XCxHpriNM
         OcY1Y0vg2XrcarkKy8OtuK4GOgP5Cm5A3ZzS4VubdZrwwJIdHfoL2kbq64lhoVj/TAzQ
         IEwdYQPqb/zQ36W2rmAvw7b4fK7KIAjt8ot9hKLCf9esnKgdGb2qZdIFRmi8Cq3s8w15
         J0Lw==
X-Forwarded-Encrypted: i=1; AJvYcCWyL10MBmq72Bl3yoryJzjxfhhBWIEzaDF/7eCuC3aXU8tKr0bCWX/mNJhZs7T+Rp+VoOloh46WG8FRVynVXJRTFVuMlZh2nz1Ik2JD
X-Gm-Message-State: AOJu0YwW+T4vp0GgIWzqx49zqH/OiHXoO7hkxPpjrfD4wnyiGO0kBs2r
	Oj2S5zhnukMeV/MU/OqBfR23y6tM/dQNheZuaEIEEMa5pbjPxldx2LhOks+rt2iLJcApbw2wLBM
	KdnaXxcqS3jGOdZpOScd/1Kjlts20QYcJGN1OOw==
X-Google-Smtp-Source: AGHT+IFDOft8KfHB385vJiuHxLREIXeKetDDnVDU4joFIwEfhZmdo3TLOETTixZXyQ8sBTgvse4OPp+ty0rpbAhQjKU=
X-Received: by 2002:a2e:be13:0:b0:2ee:4ec2:8232 with SMTP id
 38308e7fff4ca-2ee5e3c35e6mr75111591fa.25.1719996325489; Wed, 03 Jul 2024
 01:45:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703083046.95811-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240703083046.95811-1-krzysztof.kozlowski@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 3 Jul 2024 10:45:14 +0200
Message-ID: <CAMRc=MeW2ztyYkftJBy_ac30H+w0LinR9BFAmHMdsfQXa1EgFA@mail.gmail.com>
Subject: Re: [PATCH] firmware: qcom: tzmem: simplify returning pointer without cleanup
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 10:31=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Use 'return_ptr' helper for returning a pointer without cleanup for
> shorter code.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/firmware/qcom/qcom_tzmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/qcom/qcom_tzmem.c b/drivers/firmware/qcom/q=
com_tzmem.c
> index 5d526753183d..ab156ab3a6b4 100644
> --- a/drivers/firmware/qcom/qcom_tzmem.c
> +++ b/drivers/firmware/qcom/qcom_tzmem.c
> @@ -242,7 +242,7 @@ qcom_tzmem_pool_new(const struct qcom_tzmem_pool_conf=
ig *config)
>                 }
>         }
>
> -       return no_free_ptr(pool);
> +       return_ptr(pool);
>  }
>  EXPORT_SYMBOL_GPL(qcom_tzmem_pool_new);
>
> --
> 2.43.0
>
>

I'm not a big fan of this one. Same with any macro affecting flow
control statements.

But since it's there and the patch is not wrong:

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

