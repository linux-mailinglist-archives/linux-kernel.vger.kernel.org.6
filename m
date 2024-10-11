Return-Path: <linux-kernel+bounces-361793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BA099AD18
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE21283BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EC71D0E2B;
	Fri, 11 Oct 2024 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eB3Hpi8e"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AC71CF295
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728676207; cv=none; b=R58JA0ozpRwI6R0o0N2MsrcYqHdJiukekR/TDMjKgHWCCP1gSFFScmB5YdrHnIyoVizSwn1JdPdP/fdCCaaH9BU9US2fR44xUKTFvVGcjEIHFuipOXrMPE0rtF7sOgpVwKS5htextt3LftK44zNkXJQOdFr/mJcKW1+Fsx4DKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728676207; c=relaxed/simple;
	bh=6TLUf/ATlE7e2pQqOZRINjCiXODcXN1p7a0d6zE5co4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWNJ5LAn/aTdUfmEzG2x6G6wBp0mhgYo0hAzs8yyPn7RcD8qPrV29w3OG9dYjEP/1oulv9c+wp7Og/fQL6b4Sy9CMXrpSzz1rmsuWYce7I78t644xr3XmlJvC9pTRw6BhbA8MOHAEZ+l8PWN0WXgXIVqwwqawylOpTmDmSsyBkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eB3Hpi8e; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e2fef23839so20361407b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728676204; x=1729281004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TLUf/ATlE7e2pQqOZRINjCiXODcXN1p7a0d6zE5co4=;
        b=eB3Hpi8eaoBRs4yvK8IwdNV2/2h9+3/chq3wrR2HybSUP+yD3rVomZsqcw7/QCP5Ht
         7mfVvEVezuUgx9rgexX1vNXaRRlSVDDnkZ+O8Xd4sA7TciUEez8W4FL/5QYxzIEVXdcL
         zhczK1c0t1pwPXSn814P8jnhxvuxT4JA8C/wfObMnZuKC8Xxl5UculmSygePn3N/JC2X
         5kQsIkKO2Vgy26MFVW1G6AHQOq4lZMip/i9uJHThtkfT/TLeVYk7sYxRf++A2P8vc2a9
         9HnoOENeJYX5yBFXmuK2DR1yO7RKCXmMG8UuRXL3x6r8uLAXOX/kJh/GPi9QJl/0uz+9
         kpXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728676204; x=1729281004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TLUf/ATlE7e2pQqOZRINjCiXODcXN1p7a0d6zE5co4=;
        b=dCO3DCyc4wCtQFN0dodI2lOvWiPCELdVCwFgEjozIME86IRje++/j5b2B3fI5w5isq
         OqlSKuFLPX9+yry9/SCFFNNwI+yXmsQkaSGra/CTSF1ISxUd/zYGHKwswYipML0987nN
         fq+AW5+YtN9IPLBZ2GpvwExvN8Tb2kWDvj712ZcxB+LxQrGhe1PwdjOtk0M1p05rQLKj
         GZSLmYSk5JH0JDdgPliVAWHazut9MsiwRgGfqg2pGs12XBGypttVu3cmdDXOcaZpGEnO
         OwwZeewasfh+GQHa4mECEJNrWOiTnqa1IfB8wK19BKijzyPs1NH150dwsSr4X9iltZOk
         KOmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTr7e5v19LwForUiLJUT6jmOzEwGFz+kznKtUB97vvdXonEBas0E/YRE0prrUUiAc80DOg5l10CPctooI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzW8NSVIdfNYb1DBDrW4DQ8DnJdVNwKITxeAO6rXy1dWGAXcmN
	g2zIssdt+aRD+CTwPMXqFeaoDzeSQqeZfzmOGfC1wtOChuF/8HgbNN+pFimtv5Wll8NtZkHzWbP
	9pj/yDfSs0BYvx9FNgoIE/Y6+IBRixTsQjn++sQ==
X-Google-Smtp-Source: AGHT+IGMYZYv3QH1p8fiIFwb3ncvr4IbqJEH0UgaRTuTB2gROCOdl+vHLGHIzDLgiZ/cun0EKg3aLWmT7ACTJR78Auw=
X-Received: by 2002:a05:690c:89:b0:672:8ad4:9461 with SMTP id
 00721157ae682-6e3644d3f59mr6143997b3.41.1728676204525; Fri, 11 Oct 2024
 12:50:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008162416.85111-1-brgl@bgdev.pl>
In-Reply-To: <20241008162416.85111-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 21:49:52 +0200
Message-ID: <CACRpkdYrLBk4yz+s_xR+7oGKPS=+BPA2qCCfDBZTAw+FprCHtQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: ljca: use devm_mutex_init() to simplify the error
 path and remove()
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 6:24=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl> =
wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Destroying the mutexes is done at the end of remove() so switching to
> devres does not constitute a functional change. Use devm_mutex_init()
> and remove repetitions of mutex_destroy().
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

