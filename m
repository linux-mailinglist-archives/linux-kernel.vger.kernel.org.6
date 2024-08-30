Return-Path: <linux-kernel+bounces-309513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC148966C1D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 00:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780BC28500D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 22:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BDC11C173D;
	Fri, 30 Aug 2024 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H2Dgv1vb"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3304B1C173A
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 22:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725055928; cv=none; b=JSeXA9cZuyjWkgmWsd0XPlRcxyvZ46tJH1e6ABKDIT8XmvoQXlQ6nSFY9fz0b2GByFW5LxtHHLYcNkkt9uYHJXpr5S0Erd8v1vS0SZdDrwfFuDQUgsBq7VaDHOKFND1CBlZD64D5jrsezF1PfPfpaMaZcblJvQ86FSIuapIrz2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725055928; c=relaxed/simple;
	bh=Rwh8M6A1//w3NduZYo3bZPoTmO8CDMDW24C3pIoKiLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4+60Q1YLB4ftLxGCbzO2+Xh3EjsIJpb6Pj324k4mfNxI5dt6/QbPzZyJgOIQtd1qQ0WzZjrPbCuAVtxIsOw0U1d+p6k0OO8WKDdXiVJbdGU+frDjSI3czhdUniVukfU4DGTds2Fnbkc1yvCFidMKmzx1mFWUzxQ8eJlqGl529c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H2Dgv1vb; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5334fdabefbso2855917e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 15:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725055924; x=1725660724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rwh8M6A1//w3NduZYo3bZPoTmO8CDMDW24C3pIoKiLU=;
        b=H2Dgv1vbz0E50G7x1JyVf+8owrVBoyf6hZ5NR3lu6mkU6QdLMz/t2w/b5PUbZbxaQU
         z8dF43kmaTBpYd67RBQotoUptMSD5isDVgmYYLJONy2UssQtAb1p68jXphCJE+3gTEap
         SN9hZCnm/2RegmtJHjoukyeld4GI5v03/+SUJGFhPafJnyIWANAu610jQpDNs5QEo4Mv
         XM0ECqsoF2TKaJHAcLHNVmNwkyVw+XEh3PEGVtgylwx+2Yupg/unFfg2MiX1p6UZl4x1
         /mdxrF/+PprovTMmRQVnl5fn/o3q6J46xXdgh3eq5ON1lG3P+8FeQROOrm4/FDC7qkkl
         gGzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725055924; x=1725660724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rwh8M6A1//w3NduZYo3bZPoTmO8CDMDW24C3pIoKiLU=;
        b=Iv0w+PybWzF7WyG0dpkUHuN9yF9Dzt9iMLLw3DgWwPtrhw/N5AWUVmTa+aXJZdqO4X
         d2o9neeK9gRK1KedkckJ3eDFHvRY5T9+0P/7muSX4wRfv+tRiBUNGL1focccPT48CrGZ
         7zChETouofTjqaqWvorVeZOHeBSZRO9e3p9M0SKQoBFhy9uJBsaFK0gfpciB8nd9E8uP
         ev3kHXiwYTllprZU8YVMfNLng+XKR3gurnU1DsJMy2haqr6tZzteE/PH3wdt8IUOEpM4
         iwTp9d5dQVYAuXoTng+2cyQ6r+lszIK1K61+34wR6u4q31op6mUHdCVoVl3W/o1x1TZP
         vw3g==
X-Forwarded-Encrypted: i=1; AJvYcCXRE+/qJZjbrFBEfMOOeRVEloIFUIhM/Jor4Wx3PDCpZQjx62dUuVNchxnOjI8DLCScWNMQpQKkpBzzFXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqQj/r8qbZ7X7+yvn+IQbtqtk04bLm7SUHkMxOWNzJuB3L7wqC
	rLQ0D2uJndAxlb7M9+5Mrfags95kbuY3t17YiXGkSjb7JOmO/UOD2Tg1Pe978FNnMoDKrW63F3f
	acxKtIL4k4GgOytt4E2k7K0u1efhJZ5IM9RYGkA==
X-Google-Smtp-Source: AGHT+IG2GimMLBi5lPm379Nq+PM2LjCqEC72eUxNPBP5FlNmfqi3CtzsuE6fdy7fqHbWAp4512GJZfLvCgLXmPidcY4=
X-Received: by 2002:a05:6512:2308:b0:534:53ce:54a8 with SMTP id
 2adb3069b0e04-5354636e9f9mr1052118e87.30.1725055923441; Fri, 30 Aug 2024
 15:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826095306.1420628-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240826095306.1420628-1-andriy.shevchenko@linux.intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 31 Aug 2024 00:11:52 +0200
Message-ID: <CACRpkdabwp611SQDDkDRDT3EG-SVirLu3Eg1P6X+BLOxLdGtyg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: stmfx: Use string_choices API instead of
 ternary operator
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	linux-gpio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 11:53=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> Use modern string_choices API instead of manually determining the
> output using ternary operator.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied!

Yours,
Linus Walleij

