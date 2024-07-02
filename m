Return-Path: <linux-kernel+bounces-237689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60599923CAD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7214289201
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB4B15B14B;
	Tue,  2 Jul 2024 11:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nA6Ci9oe"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE3715B130
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 11:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920555; cv=none; b=fzK0U8qE2K8jHhgN4dvK1HMPFjMYNg/YWQbQeM2SLOlyGfPo/xU/4aar00o5oKMbZgOpbyhpOZXP17TsXGn04S+MZUFggmwjpuft7H2ct97PfY2x79HJGKjmYQOr9r4ONPzecZkrMqQYKALeLGpekF93cp7pJrGoXLw05EL1edQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920555; c=relaxed/simple;
	bh=stJcbtxT7yyrwVYdqwgWogSdm6qD1il/DBw/nn6ktzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TYL7fHkSYVF02gvxavuY5biozYZaqtI/KzyOSY/0SA911zfVsFsJ05z1Qg6lsqYYkgbNkbMb5eRo3BYOFqYBzXRuAmmh41Q3QLC/zWcs0am1/7AXgaQRB4MiyEg9V9wFOBaMCws6rPqQ3EMTZV49QAOXLrMdZPDWSVn6UtkzPpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nA6Ci9oe; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dfef5980a69so4521590276.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 04:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719920553; x=1720525353; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pX0GvMcRUI3OW9Z559DCkuHQ4F+ae0/fRdHiHFHzZb0=;
        b=nA6Ci9oeQ67B1kDjqeGe+j1nHmeVOTBj1kCRBBjrPwsUvhrAJxzXy0YhN9M0oIjdp4
         en0EVsWoDltKwY/hQJ0KqsulmMQmfmpRv7Z2XX+cT6VRMZuc/N72L4WUIFzV7abnn2Br
         j/pQRKqRYe9AoW3LHEwqg+wQADauAVWQ462vNiRa/D53tlWaVhG9vYl3FcxCKWfGcxdo
         MjnjssYuCWjyX7oFn1ahYnnOe2nWWOUIqgTr5ZnzJSNgkHud6PKmYpDbBkg1ncNkzeJc
         cE6yGF9eFdM3JyfDJwTW16MMCHgw9KT+6ByXCisNZDmJUqGzL1IqEhRUisIqjxA0zcOp
         +9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719920553; x=1720525353;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pX0GvMcRUI3OW9Z559DCkuHQ4F+ae0/fRdHiHFHzZb0=;
        b=km+OGh4DikWJ1km94/AJO+RLoSjb58YxQVMJHFzLW7aIob4e250B6JJivsANaiu5TN
         yJb6ut8N/ywVDLhHgl6Ow8g/boevltNJmr8olSnFA3G5Tqx8/jEijS0QyhqdVeI7EFim
         O1prFgEWAafU8+p5pYZXY+KDTNeS/L1795Fd0gT1WfUo872tjtoGLSiIxHJz95n+fftw
         S6bvi2tMioH+z2J1Dz8TALo7DFGMEVyPY5nCbQYedKhfv3DybkfBA+Pc/pAQiX/b+Uo7
         FZTN4Sg97iXmifcLZ/JZXt2saPXsT6owyNUwwhbMss9KDnvVIvwBw8OJ/VSD5ubM4JC6
         7jeA==
X-Forwarded-Encrypted: i=1; AJvYcCUv5jZl0WZej1UWDjWChgBYWAZMyUPm4J/md/B5X/gqnovfvQoYmMII+Gyg29jb44dznwAy4cUg6ul8Si7xhzo+Z+ht9j8UnAZitqZx
X-Gm-Message-State: AOJu0Yw6gpadscsJkQdji1FzdazRqotUpQ7q56YtLeXVcsJlO4EWG2V/
	9p38Y2goVABraS+ouxHHaeWsDZgB8VE4M5cH4X6KXE5UE+JD55g9TpEMCu6uT32sB4H5IqemE+V
	WfpDxvlwUNnVUTgY7MW6wEU266eXfGGzer2O/5w==
X-Google-Smtp-Source: AGHT+IGKIwMQNOouPbZn2q3IqAFIf/rtg0qaLro0RVo1YXr4lVNA2E3TE7V9cXqXjNJ2o4Kc815R+yVyKfuYAR/XlYU=
X-Received: by 2002:a81:a50a:0:b0:643:fd49:2db6 with SMTP id
 00721157ae682-64c7123b008mr91387297b3.1.1719920553049; Tue, 02 Jul 2024
 04:42:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702114103.16068-1-brgl@bgdev.pl>
In-Reply-To: <20240702114103.16068-1-brgl@bgdev.pl>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 2 Jul 2024 14:42:21 +0300
Message-ID: <CAA8EJppo4X1KmeeTRz9n7+9S0fGWE4AD1O1cCc_aPHTWPUGVvw@mail.gmail.com>
Subject: Re: [PATCH] power: sequencing: qcom-wcn: don't request BT enable
 GPIOs for wcn7850
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Amit Pundir <amit.pundir@linaro.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jul 2024 at 14:41, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Due to having many existing users of wcn7850 in the kernel, conversion
> of the hci_qca driver to using pwrseq exclusively must be done
> carefully. Right now, the Bluetooth driver requests and controls the BT
> enable GPIO and so the PMU pwrseq driver must not do it or we will run
> into problems depending on the probe ordering.
>
> Add a flag that tells the driver not to request the BT-enable GPIO. We
> will remove it once the conversion of the Bluetooth driver is complete.

This will not prevent the pinctrl conflict if both PMU and BT devices
declare pinctrl for the BT_EN pin.

>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>  drivers/power/sequencing/pwrseq-qcom-wcn.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>



-- 
With best wishes
Dmitry

