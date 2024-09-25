Return-Path: <linux-kernel+bounces-338336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B33985695
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 11:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F4A81F250BA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216C68120C;
	Wed, 25 Sep 2024 09:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Mc9toR6d"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12D128F3
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 09:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727257564; cv=none; b=rh73ZWEEgVFLY1wVHPIlY85R/xBD6O8/+8UW0+1r8nCEi9276z3Kk0gfAr/U+MLWkWZ7yBl1BlZSngrPklCEVDCsgP4Bs3PCTGxtYQpC1Mtaod1CTKSfPzaapw564NgLTpgMflb5mQEuZtjfYQTe+r3NUPqW5JnQK3wHnL8NkBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727257564; c=relaxed/simple;
	bh=NgD5S9pyeEL0whX5CofWYtse3Eype5qITL1jwQePx/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n+AIXD8F9nX0csDQdDPoX3tUI4mxfySZOtJy4g14KNKvYee6TsQy5fVYl6F4Ez4FpnmtVRteizQyRk+v/FzSjM0d33s3Ms14X4cgsS739h8m/8HQykg1NkZGhkA0boaY+M3f6rLaSyaFljJA4WJagldEFxGmz/lEc/2GPec/yzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Mc9toR6d; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5356ab89665so7788325e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 02:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727257561; x=1727862361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgD5S9pyeEL0whX5CofWYtse3Eype5qITL1jwQePx/4=;
        b=Mc9toR6d9TvkDamEcm9C96rX+OHNcOGvpzds1b9zuGCLm6fE5XlbibhWn1uJa9/50V
         7z2ekHBEp/LfStDvuhZI5qdWXoJvt8Mw0aLbIyJxnCOKwTj/3/DsevmbeOlAnPdMBoQx
         44NXzw7MdNjqkLI7KtPjCEWrNjeTHYXbJfaAzmNhmn9YegmpclOfnjqIwrupyU5WXf6P
         oF9891vqvKACvbQkLf9Ma4olgjqIaTeqlhxJV7BmPcjSb/Z6aEkHZlbF3RtJl0qPEhdS
         Z7hPpL4yK6FpWT0gow6ndKzETfgQSo0EZGJtdV0ysCHfZyuVb5a1lyXkJxkXkD3YYF8h
         llJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727257561; x=1727862361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgD5S9pyeEL0whX5CofWYtse3Eype5qITL1jwQePx/4=;
        b=qN0svtCoZZPK8TYqjT8MoomDes4+A63UknFMrNuUWY8mPHtvjWG1w3lVkzvtpRb77S
         Jrb9Hno6VfMsSb16zkERRmwEccM1a3nENo/0wgcLbptSh94+wf6BQ8UU+WNsAhNbZZwx
         YSQv9XxfILw/9REGA9RTHokde4b2PEPPcTRwt0WpoJPj7UtH4Yq5j9VUAt6vvGXWyEX0
         sqhBL9uKTKIIlFId2FAF0KPA6AgAjeeZ2Rm2nx17l8mCAKxK/TDCLwlwofTcjQb4eQUh
         gyvxAlDAdifuYbpbo2hBBuj897Mc8NHOodY4d6hpRSsCfsbNsUEKXQh1JexzAKOQd59L
         vuZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV77ecpNevJcKgzfEHaS+n7LkpNpxR6MaF/VTrQ4dNl93s7cnPFK8pDE25y3IjVIqFFgVVjZnmqbex+XJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgVVbWkxVVQXd58Z0X3MYdrVdI/prTfwoiFSm5YpEBqm3+Torl
	aRmc1kFl9+p5JQ8v3DYOfjguP0AkwYd8xguXApgCLD8Xnw3Vs1xPCZHmOe6pLKu9rYYqL7pEfAT
	+9bXXeL9wS7c69PWBl3id6W+9/U4ml5Wqqb0v6g==
X-Google-Smtp-Source: AGHT+IGpIsWwcArxaXl2nN/jmHZ9mZk4PS6iOVoWxDnyGMawf9jGJkP8UCfY9YHJq1XUYoIoHK/PxmvoTaQAXkJyg9w=
X-Received: by 2002:a05:6512:1384:b0:535:3c94:70c2 with SMTP id
 2adb3069b0e04-538704979e7mr1306012e87.19.1727257560704; Wed, 25 Sep 2024
 02:46:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-tzmem-null-ptr-v2-0-7c61b1a1b463@linaro.org> <e1089f44-5415-4a46-a8fb-9711f122a6bd@leemhuis.info>
In-Reply-To: <e1089f44-5415-4a46-a8fb-9711f122a6bd@leemhuis.info>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 25 Sep 2024 11:45:49 +0200
Message-ID: <CAMRc=MdmZ7_oHv_7Ja9E0pfuoF5wWeGz_1=Yq=G-gE_cpsBGSA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] firmware: qcom: scm: fix SMC calls on ARM32
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Andrew Halaney <ahalaney@redhat.com>, Elliot Berman <quic_eberman@quicinc.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Rudraksha Gupta <guptarud@gmail.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 11:35=E2=80=AFAM Linux regression tracking (Thorste=
n
Leemhuis) <regressions@leemhuis.info> wrote:
>
> On 11.09.24 11:07, Bartosz Golaszewski wrote:
> > The new TZ Mem allocator assumes the SCM driver is always probed which
> > apparently isn't the case on older platforms. Add a proper workaround.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > ---
> > Changes in v2:
> > - use likely() for the more likely branch in smc_args_free()
> > - Link to v1: https://lore.kernel.org/r/20240909-tzmem-null-ptr-v1-0-96=
526c421bac@linaro.org
>
> Thx for working on this. This afaics is fixing a regression from the
> 6.11 cycle; we already missed fixing this for 6.11[1], but please allow
> me to ask: is that something that bothers many people and thus should
> maybe be fixed rather sooner than later? No pressure, just wondering, as
> it seems the review is making slow progress.
>
> Ciao, Thorsten
>

Bjorn should pick up patch 1/2 from this series into the QCom branch.
If it doesn't happen by the end of the merge window, I'll resend it
separately on Monday.

Bart

