Return-Path: <linux-kernel+bounces-361785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0296299ACFC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 21:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3B4928ABBE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 19:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0501D0DDC;
	Fri, 11 Oct 2024 19:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GoX0Lv4W"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BEA1D0BB9
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 19:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675828; cv=none; b=k2HQcUR9GDDp40kdy1FBQEVWimVZDFLjc5iXPNJUJZMjQOig77I2EOJ5/XX1Mna/pPK9BOj08T0KUeFl9/qa2L5/dTkqShiQkN8+fmfATfLgQvhxv7xeluU1aClViv2UmMBQDvRy0UU3x01tE1QD6dbpbhU3mnKDKMpxl8rDLmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675828; c=relaxed/simple;
	bh=zWOx92++/7bfOB6x6NXdvsuBhuAhVm/tjlM2nESJgmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r6YJdEOQJD8wazNN26cPDBgJbFVGnxzjQqId1yoaDJdN1l0TQ4h0u9d6kfTstS+SH1xuGG1dH8B6CqgfWfk6+tw50bwRlJjAvNjc9OR3B02ROUHCtq7LZNWpUhp0BiZA/WkaAP4dk0921s+m5Rk3+l+cUPc51FMuvJe4wsgKYVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GoX0Lv4W; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e2f4c1f79bso22672707b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 12:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728675825; x=1729280625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWOx92++/7bfOB6x6NXdvsuBhuAhVm/tjlM2nESJgmg=;
        b=GoX0Lv4Worncm2a1tM5JvLy+XWtB3HyQbjJhpTz8zNc8RhJABQjwHNVd5i+0SE+qJq
         MWLVAiO5UfhpyZEYSXG3Yy6XgSMWI3XEIJXW44a+VNwAuqJE0IklDDcBojJjXuERqCMu
         BmyWsQgJRby8c1v9Id+fcv85lxiX5uPUZ9E4zrW1UBYqYnDI1gRaErNBSqextCFp/D4b
         yfaTWXAcN4dhxPHiBjJwoLJFolOssc2R2L7WVK1hlsMZf/AH0EHB3Ig7bBs0YXYQORoH
         IONW6iRHinI+aZtzPc6WTHs1+48PBLRFIKIaKfyffo2M4NvRMCSu/oGWyibnxPGcF08p
         16cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675825; x=1729280625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWOx92++/7bfOB6x6NXdvsuBhuAhVm/tjlM2nESJgmg=;
        b=RNJQKVmbUtPnypPX2KfamLJVo7WWdmns4amDso53iG85JxxUghIzwbydRyVhxAiLk8
         YkG/oirBZ5uzgGsjqs4eyEBkNZUs3EnlAVn9MmP40nJRpDyLUA3LI+tGNPGhfi6AGTp+
         lCYYjsTDjodCFjC3IXkh2gtlvXtSFEqdzjKBpTYqk1w+YBSBNtUeTV+mLZAf/rh76eDb
         QsV1SsNCHQmHB/ZTbXFEypDomjtFFqHweLwO5IbTTAwWU5rTy4zQXjV9FFGSwZo+fawW
         P0dSRm7xAAVrwcdbwCbrBQSXIifhefsuRwkbKlsRw2odxn3EP4ju7YZWIFZp6/G/fnsg
         /UvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNtfQ/wChU1lPr7PvMD98bUmo2pvvi+MQH8OtBkIoYQG4/FjTfm7VqGiRThfiCPqQnyrXh17l2P8AcpJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8CnaXa9IWdRvs58lVlPVU1yVv+7WA1k7pF8xq0ftHnl0PTChi
	Piz7RkhNS+BJv1WotiQ+4np4atMnLFNdaX41XcDwONIECE+ftOM1HK0J3lxaUG6+eF64r/q1G8h
	/CUH7lFZpWzNl8VFnU6jfilvBQojFRd/XPOHgCw==
X-Google-Smtp-Source: AGHT+IHYsc9YoslA4IuZ9ez7etb2ZcXLeoXZg0qc0jkLAIKQ2R3IBViSJnK8GUmsMFqJ+6zsd9Etb395QYWFVm1KNLU=
X-Received: by 2002:a05:690c:6783:b0:6e3:2be1:a2dc with SMTP id
 00721157ae682-6e3479b94c4mr35124167b3.11.1728675825704; Fri, 11 Oct 2024
 12:43:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007103440.38416-1-brgl@bgdev.pl>
In-Reply-To: <20241007103440.38416-1-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 11 Oct 2024 21:43:13 +0200
Message-ID: <CACRpkdZYtJo1fshOPvX=3USxbs1CdTBbbkgMBfFpZVsNyozTdw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: davinci: allow building the module with COMPILE_TEST=y
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 12:34=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Make it possible to build the module when COMPILE_TEST is enabled for
> better build coverage. Stop using of_match_ptr() to avoid build warnings.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

