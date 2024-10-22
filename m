Return-Path: <linux-kernel+bounces-375805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C16F89A9B09
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08AE1C20615
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 07:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9441513B79F;
	Tue, 22 Oct 2024 07:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tbehmfhi"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4698F5C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 07:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729582231; cv=none; b=qyOTxe3ckhvc4MTMUCFVmUAruU2DcPbiatIKXIis4F7v3vTO1a/WeXPXPcLb7+mhUyMoiotrHWTIu7wIk97sB1C1XTAnob2attBw/chSA1/Rcp5noBdYX33O/UtYrPE6Jy/dvgcEHXOkstGnc2ii+A+d3K4nLXw+3Dv7W/UCRes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729582231; c=relaxed/simple;
	bh=s9AlGR3aC/jkfp5wIIAiFqq80453+YrFszZA4EOS9fY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L5soGW1pmQ0rZMB/NMmsYwABMxRLJdFcIxoyfBHtuNWch/ukpkCOV94qGhcodpS7eQvA9GnwnL9KlbAgdvy+AFZWCsjAMkCw12KUXWd3HyV+orEojgIu9bOmvgXVsTUTereWSJ2sxziOIKGUAvNLAols7hRB5G3C3dr21oSaFVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tbehmfhi; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f8490856so5632433e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 00:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729582228; x=1730187028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9AlGR3aC/jkfp5wIIAiFqq80453+YrFszZA4EOS9fY=;
        b=tbehmfhiq8xGkwApxzC2ZCqTdI5cdhsh4MgyS0QGSJcVffr2ou6Y+NuEbEuw0NLQBz
         P+BkmVP/kdMoHjAbavcOWCcitX22Gsq5rYTBlYCq5ArR2LHHgbOX9HdUaYiuPbWgYwyY
         HX5zCs5/W1j8IWjI3Fu2eyMhK1couCOcGp3hAvFzSHCvjH+wUkbp3QbPCNz4gcIDeg+M
         JtrkmzpQZizHmzIHn59VycoeskpI+lCQSrFNW5giWOHF4DyjnP436wecb6IWEtiDR1bY
         09yjq9F0sgl54dWsQlXHqMUpObD6sN0S7rtkwdGhl3Bcwa8VF9S9QPeeCdkSEFOksou4
         DGFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729582228; x=1730187028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9AlGR3aC/jkfp5wIIAiFqq80453+YrFszZA4EOS9fY=;
        b=Y3ar0Mgc661RbQ/WsVhH64SdixX+Al0/PuHv4mpQNMuu6RPaUm3J2KDHngiJ7fZ9rq
         le2xxb9k26c5taHT0DMDmWM2IdM6Vlu/RxwIlaeCybLsT55V88aD9J13RUlfLmlblh/h
         evA6bdSgQbttzVEMiqrsCLnLgJdTYETCvy+JyWo/UQRFpEQrn4k5AnG5GgbCq5dMnAtr
         jQz2afLBcM1TTA5qaogytYV1SVqDRecqKsk32wZYZ4qfiqpL1C2GvBoprCF8j0J/uD1w
         HnLxJeahgC8UJVsa4pXULC7KMVjuapjPzORJ6CnXfdEPorBdMX/ZKSm3w6Aq7SmhSDcQ
         rBOw==
X-Forwarded-Encrypted: i=1; AJvYcCUUHOCMd9f5Zuy+3XbmFW6/0IBU6m8wGZjERjVJvsbl9qjXtjPgU5jTnaS3zmZt/Zh1Ez38lKklUy/dxWU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0MtJbnKKtfOnuzbhUgExpxAkOiP8ih7k22KbL0lsDu5vAhS3R
	TbGn5qG00K4ayP74ilQyw3fgzpcO4FnkCfK6VwelP4dAiB9RjPB9WBdUE5CQ7iJQOM+Lj1tFK8a
	5Akq6+fv23i6pgByc3V08VCXI4MFgeKWPybaehA==
X-Google-Smtp-Source: AGHT+IF49dZCMKViDbxpV2eKhiIHV1RDGA68wUouph+dlIMJN4RYm70o7grRVK5xXCDp2yY2Ikg40KfZMweGVngtB7k=
X-Received: by 2002:a05:6512:682:b0:539:89f7:3187 with SMTP id
 2adb3069b0e04-53b13a23dbcmr717950e87.47.1729582227670; Tue, 22 Oct 2024
 00:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021100421.41734-1-brgl@bgdev.pl> <bb705eb7-c61c-4da9-816e-cbb46c0c16e4@kernel.org>
In-Reply-To: <bb705eb7-c61c-4da9-816e-cbb46c0c16e4@kernel.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 22 Oct 2024 09:30:16 +0200
Message-ID: <CAMRc=Mcp4LBj0ZZx=hUg9KBk04XXcAtiNv+QjQesN1iCpDC+KA@mail.gmail.com>
Subject: Re: [PATCH] lib: string_helpers: fix potential snprintf() output truncation
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Greg KH <gregkh@linuxfoundation.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 9:15=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 21. 10. 24, 12:04, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The output of ".%03u" with the unsigned int in range [0, 4294966295] ma=
y
> > get truncated if the target buffer is not 12 bytes.
>
> Perhaps, if you elaborate on how 'remainder' can become > 999?
>

Yeah, I guess it can't. Not sure what we do about such false
positives, do we have some common way to suppress them?

Bart

