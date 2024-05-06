Return-Path: <linux-kernel+bounces-169403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DED8BC83D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 09:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3192A281C3C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 07:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E547D3F6;
	Mon,  6 May 2024 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ayoeRg8p"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97894D9E2
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 07:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714979952; cv=none; b=lr51azGeASGxOLdxyADv1U1NTFmdXycqrrly/Urx9ktgQlpZLZ4fm8RePVICPVDdWuEb05qxxDq7I3hNwyAXSzFofKjPqLpC2YXOV0Qjn4Tn2QXv9Yz6EYlGBRkBP4z0CzNMkpOQfX16l6vCt47nLZ9HhtjUiQ7calGICj3H7Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714979952; c=relaxed/simple;
	bh=BcjeHuKCFNt3g0xtf3X7hwL26jrEaUX08KPgkWV/Fm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e11T7PHZhytsCCkcxHKHsyJPj9WOaFli6leW2hxKlggo3e8x9kmoF1wb+ouyPavvEZBM6nNF8RuSZGK1TjinV57c7Czy/s7JhyoaQDkGQPM8CwE9+l6Ju1lgHlQisL1oJL/gL7G90oD5/1wWB0FlBV66vusIv4XOrGRsgF5VzNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ayoeRg8p; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-de45dba157cso1113666276.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 00:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714979949; x=1715584749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BcjeHuKCFNt3g0xtf3X7hwL26jrEaUX08KPgkWV/Fm0=;
        b=ayoeRg8plY6k2zAO0hGLqfqQUHiFqYC3XSbQ5n6VYswp/HLe03594rVXUY38ANM1F9
         XLdnIRilVQ8ketGFiwMW+s5U4NkVyD4WVZjf+TLSmNZAMCd5+Zv9X0X+AdpqhxIjhED9
         ijtHQ57Ehck/6W36SvkagRR9tu5PPUw5oYgp0pss+Rasv9CxoQHaD+CskIBG/I2tN7TY
         m7AH6p7DnKTvxGWY0dXBvkCDEBFdwnFszxfahUgCLLIHz6JNltfNz6c3jf0B3g2My8g7
         rw6fbV+Sfos0PXu3OQSvl2RJ+5om/PrCcioTBQ3TttjYSK+wGUyC+m2OqVzEju4EiTCS
         Qr+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714979949; x=1715584749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BcjeHuKCFNt3g0xtf3X7hwL26jrEaUX08KPgkWV/Fm0=;
        b=etY9vNJNsBf5nDegiW9AHba3w08PJnWpel50o5K67KeM8HxJRQX7lx5yi8iEJTuFjt
         P+B1py8HYvwA6+DiTosoKnGA5ASn6tfBV0Lqv8XmYtqp4RCjK/N0os5bXfxbFkit3SMs
         YDzC8Sky0j5hWtYWbQt4zQjYAWED4gC7mrNINNhxWipQlrMw5iu8UsZ8n08AkftfTdu8
         WPxkTKAedQhyJmEGp49YOtdJK5J3VcTHZ4aLs/SRmNjk+wXdOKXSCE8Apn9uGbVypRaO
         Z5G9iqhW7b3Gts9hVrmPER8V8CnUQqQeqaqnHX4vwqMBudEXkBZYsWD0Lywd8D0rHXdD
         Viaw==
X-Forwarded-Encrypted: i=1; AJvYcCUg3A+f/AqXffzYSU2DNKYA9xSS8qrCRiydlG8mZw/O0SPZrN8uYGBQhRUlO62zWHwDOVAIRGX+v5qGLND8MbZFgT8eyhvzn2dj2x8/
X-Gm-Message-State: AOJu0YxN2nEqK9eibsGWdAYWjQhx3UmQ6zRTnmK42lDfeENaIiuK8MNF
	YwXHuehGsgClXyK4JChWOoGXZ5gim1P/2L8P256ktjDhTX70CB3/RQrVTzxvMmflxhvsFZ7VsqF
	ax/y9aEHRATrfl2tNxLmA/J18832XgcbOioV5Cw==
X-Google-Smtp-Source: AGHT+IGoDixNoUaDnMBz7LuuCzUKda16Cqz3qmrnX+jMYQez9FjCtQ5nkqPx8YFJMFywsbQfbLrvit76T/JAbCJBsNA=
X-Received: by 2002:a5b:e92:0:b0:de6:13a2:651a with SMTP id
 z18-20020a5b0e92000000b00de613a2651amr3365815ybr.39.1714979948907; Mon, 06
 May 2024 00:19:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240505141420.627398-1-andy.shevchenko@gmail.com>
In-Reply-To: <20240505141420.627398-1-andy.shevchenko@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 6 May 2024 09:18:57 +0200
Message-ID: <CACRpkdap=KXuyoCjWt_v53ArRPynDQndAjjHfvapLUM7VWbbdA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Discourage to use formatting strings in
 line names
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>, 
	=?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 5, 2024 at 4:14=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:

> Currently the documentation for line names allows to use %u inside
> the alternative name. This is broken in character device approach
> from day 1 and being in use solely in sysfs.
>
> Character device interface has a line number as a part of its address,
> so the users better rely on it. Hence remove the misleading documentation=
.
>
> On top of that, there are no in-kernel users (out of 6, if I'm correct)
> for such names and moreover if one exists it won't help in distinguishing
> lines with the same naming as '%u' will also be in them and we will get
> a warning in gpiochip_set_desc_names() for such cases.
>
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

