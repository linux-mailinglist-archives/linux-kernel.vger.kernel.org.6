Return-Path: <linux-kernel+bounces-360160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1837999549
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 00:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8488B2849F8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 22:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30BF1E7C0A;
	Thu, 10 Oct 2024 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FsKFA8us"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E93B1E4938
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 22:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728599813; cv=none; b=kYaJEUjykVoA+bJzNPLiQ3yb93eCTZNi+T6CLvs3A3mQHBJW3zjK5ebab7FxU5tSxp627Ij60OPkNF+RFXUze5/id9aVzJsS07i0Nt8zvu51bIO2YAsHoGlJ3Q2Fi+GLVyrf7yInAHx3NlX+STxc3nNq7xL9CkfW8cuIrY5WpOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728599813; c=relaxed/simple;
	bh=S8MzrVyVXYrrKDN3sreSlr2FvATE3GpWfAgeOexSlnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCLE1GRdWp2qBn2NeT9aqZiv+pZuQN67nDQXcdrxKOdemjkdmAJgqmYNOPAptekU5HWum2bH7xVfjUNRJ82j+BybdwHEzPd5YXfQ+bDrTqlNV/ALSu7IEaQ8OgVSKN/TANF6R5qnFQyXIej81zFm1aMp/VEa9I+sJe8Un9rVM5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FsKFA8us; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53993564cb1so1793523e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728599808; x=1729204608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWMUsztqHY1RJBiR4O9/uVA8A37ER1fCtc2N/7pUsd0=;
        b=FsKFA8usXRJX97+bdZbl6ozfWfzewEPBAlxnb52EG3I9UHvlGeUj6DyrSUfmcKVzX0
         xKXM/qK+hxStXMtt3j6viWeHQ2j4RMnhKFJ/F+nYrVwNslaYW86cdqgAhFt5IPkTULvf
         vca2/f3JgNNzauQtYeC1M5tJ9iXmKZPV7qGmQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728599808; x=1729204608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWMUsztqHY1RJBiR4O9/uVA8A37ER1fCtc2N/7pUsd0=;
        b=Z6mgE3xLzSm12l0zATHIWI2NdZLjD6wEpHrmTIoAoqemAyxsZrouXDUvC8YsXy35g/
         bh3uUYzIPqw8D3g0MgDSu0b4r38mpp8mvfKrPQmHBTCBfmD0p3+sw7H58OXkV4w609T6
         VBfmZNU+IUICNWrwUsfbchvUhBifb46/KlqSy13KBGWM36opqyxiQCYuEtOIYIU/IbUs
         j9z4UZoN7T4thA2xZ4TiS92FmHbiLQnpI9ex07IliWXewKTQS1GBOPPOh90EMP6CB2O7
         /1PMbwRe5jQzX0QNX+vNkvadzwZFMD1msydBkVGV97npqR+diKE529op4FgMihimSX7s
         kuKA==
X-Forwarded-Encrypted: i=1; AJvYcCWRWMTMOF0eWqG07ZTVZRkz+uFkUP0Ti1z8yi8Ux0ndei1k3hY9R8bSiMbVzCIf407UoJPoxEa2Ud65n8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQk6wGdjJOttYhx52b9XYf14wUaASKxX3MGXeYdMF3tHZN1wzj
	KjLMf9SUIK2FIGaRrITo87qZtgTz5Eb0UhsvMbSBSFtgSDe8k8oN0jzE5wjgJA1H8jhpq4sS4PJ
	GCNN4
X-Google-Smtp-Source: AGHT+IEjutcZgDnyPia0rT5b8g4yriwNGxsv5LQ0wm3xho1K/sTCeW2HKLCxsGSOu0nSIAfGVXSu9w==
X-Received: by 2002:a05:6512:1054:b0:536:55b3:470e with SMTP id 2adb3069b0e04-539da3c67damr190471e87.19.1728599808495;
        Thu, 10 Oct 2024 15:36:48 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539d4712c5csm114141e87.41.2024.10.10.15.36.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 15:36:47 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5398cc2fcb7so1819355e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 15:36:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4C4H4RgBVy7CGnCOyyGBXoqAGoaLVwLFVfp00+rvLKsMk6Fx2ApNDauaMgdCAZOpGm+ndwDliT2izi3c=@vger.kernel.org
X-Received: by 2002:a05:6512:3091:b0:52e:9f6b:64 with SMTP id
 2adb3069b0e04-539da4e09a3mr158626e87.34.1728599806982; Thu, 10 Oct 2024
 15:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009145110.16847-1-johan+linaro@kernel.org> <20241009145110.16847-4-johan+linaro@kernel.org>
In-Reply-To: <20241009145110.16847-4-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 10 Oct 2024 15:36:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WdxCbQm36sq4RtPMGyi+ZefPYoOQortAN+SDYTAY_m9g@mail.gmail.com>
Message-ID: <CAD=FV=WdxCbQm36sq4RtPMGyi+ZefPYoOQortAN+SDYTAY_m9g@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] serial: qcom-geni: fix shutdown race
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	stable@vger.kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 9, 2024 at 7:51=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> A commit adding back the stopping of tx on port shutdown failed to add
> back the locking which had also been removed by commit e83766334f96
> ("tty: serial: qcom_geni_serial: No need to stop tx/rx on UART
> shutdown").
>
> Holding the port lock is needed to serialise against the console code,
> which may update the interrupt enable register and access the port
> state.
>
> Fixes: d8aca2f96813 ("tty: serial: qcom-geni-serial: stop operations in p=
rogress at shutdown")
> Fixes: 947cc4ecc06c ("serial: qcom-geni: fix soft lockup on sw flow contr=
ol and suspend")
> Cc: stable@vger.kernel.org      # 6.3
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 2 ++
>  1 file changed, 2 insertions(+)

Though this doesn't fix the preexisting bug I talked about [1] that
we'll need to touch the same code to fix:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

[1] https://lore.kernel.org/r/CAD=3DFV=3DUZtZ1-0SkN2sOMp6YdU02em_RnK85Heg5z=
0jkH4U30eQ@mail.gmail.com

