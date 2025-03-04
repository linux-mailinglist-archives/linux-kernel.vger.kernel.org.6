Return-Path: <linux-kernel+bounces-543444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4AC5A4D5A3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D188C188E098
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D86F1F418D;
	Tue,  4 Mar 2025 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XgBS43XP"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408BE18CBF2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075412; cv=none; b=Cdud4Gtwlfe7gOnPMqjIzD/iKksLH8AGEdyeYSmV3MgxziwcmyhUakgbi3faPrbq+aqMM4C8R9V1sK/OThQNhXI7sWiISY46MDbnAvJwxf7fwrj78zuenSH6wrJYprYIJfOhkPLkZhg77DMzC8JLKf+peq+rSd84LQkiNqVgbVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075412; c=relaxed/simple;
	bh=EWe8gI4R4FHNMWsnAQjhbpx1Z/7MLSX/ubJdkM9ZdEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AeFAi5N4l50EpK49TaHlmm6Y1baJtBKCV6MrxYRdJLyoEStgmjgZTtXiw1K0FZaNZW1rGW5Wn9M/B6XavnWhpL63zhm9ogR04WlxiWMnWH2EOqFGz/gJBjr8u/aZ1yPNLayB/aZBaZWzLU4iwK6eKODjjCYszbhC/sRSFrbstFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XgBS43XP; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6f7031ea11cso53075007b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:03:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741075410; x=1741680210; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWe8gI4R4FHNMWsnAQjhbpx1Z/7MLSX/ubJdkM9ZdEo=;
        b=XgBS43XPcG2wwxRE9KV5jdzfqRfVF8+N+tpI7MQ2IFFxNq+nXrlhJ2i3/FTXxTSVEM
         v8RM3LKSEYuvXOvfVNH8Mr+xkcPsRsaGbJF+LRYJnagE/KcgiN1A1PCP05kPhs1SbnQf
         ScqXjYJDKFtUd/WLxDSQZQZeEUTKNUFaMQdfidaxn5hOYKAcYkpBUzWGjDmBHP9eBJvK
         qYdhmnGAipqPh6ERSydEsQEaa+FXg9sHlfuSoOC9hsuuzdO/BKuhKVL7rR85Go2yDS8a
         5/3pBW5F4ickxOBFfjtegB/meorebGuv/T9PKLdYyyqMYRexSJisblCR8DjQ0tC8ruuY
         nnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075410; x=1741680210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWe8gI4R4FHNMWsnAQjhbpx1Z/7MLSX/ubJdkM9ZdEo=;
        b=OHvStbiSx89vyHMqPiYS/QL2awJnYuRfP/+QCyHvrkWfz7oRpZlt6mAw1KoiVRbZlj
         WY6/aTziOfJ5tqJqSBXpyo4qs4FQgYPEBoFW7zOx+7WfTbvvt4oJX7krukrI5oo/tVAh
         DoFyX9MhOdmrjCQdbkVAhR48FLW03OlGRBceDTVjAYRT0svsCoDD752I20kwwXWt2l3Y
         nmCRtybv3/qelPgfYHTjpcA0FiF2M/fyi0Au5RO2nFkFVO4CFlwuFhoCAik2shAP+/f2
         HkAf6Wf/Qr9BkKprwIAJj287KRmDeZjNbVWpaK+RJ9mz63lq0Q61bLXp0DaA495q7pM/
         33/w==
X-Forwarded-Encrypted: i=1; AJvYcCXb6ELzGcCMISI91Ds/xbq7sHaN8529CC1AZss0lQCmNWD7Zpog4jS7LPLWO3Wsd9uojkFZFTcihfIoFNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx71wWUSH0FkocPcJqJCjWb1OXsvwXMtSUsMGlgVdKQM5DfuduB
	Mh3ywd55f3SvxW80mTppQMQbnkwBc+T9fsLFBbaCRFe4RCcbTvHCEOKLwQS/Q0sqvPZMieKov3y
	r7Sq/TKfRuCvYZ8WIfkdnfKFZGsjhPMl8mcjQDQ==
X-Gm-Gg: ASbGncvkIMO0b49zrK5XIBlhvdIEzGdBoIWiWhEApr7cjlN5J0+VAMFWvQFcdtrI9gX
	XyX1eCfO+UeD0afhkI8pqrSyma2mcn7k5OvoGkpz4vO7Zh5U0lDAHLGdnF5bm6AVcVcWLxSpesQ
	WRHgwllQLLDoxuIfAxk8ZamGCYVw==
X-Google-Smtp-Source: AGHT+IEEoxQEPmMeNx+XEx9rkwZRXQB9YKGVY6m/vP0iLmUHK18l917gZWQsMmtFgQl4b3vadQ/cMN9FK0Rq3Ekx2lk=
X-Received: by 2002:a05:690c:6303:b0:6fd:3f88:e0a9 with SMTP id
 00721157ae682-6fd49e2a409mr226555917b3.0.1741075410313; Tue, 04 Mar 2025
 00:03:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739368121.git.Jonathan.Santos@analog.com> <62cb9786b02adde118db9349617cb796585ceb02.1739368121.git.Jonathan.Santos@analog.com>
In-Reply-To: <62cb9786b02adde118db9349617cb796585ceb02.1739368121.git.Jonathan.Santos@analog.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 4 Mar 2025 09:03:17 +0100
X-Gm-Features: AQ5f1Jpa3u1-3cwOQyz0J2BUK0baxhGY_dz89fz0VCdOr7PNxW2y9ZPrMs2iGPo
Message-ID: <CACRpkdbMdpQhFq1K4AbLVa-fh=Hv5W8GnJwF_hh=h3x29h203A@mail.gmail.com>
Subject: Re: [PATCH RESEND v3 12/17] iio: adc: ad7768-1: Add GPIO controller support
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sergiu Cuciurean <sergiu.cuciurean@analog.com>, lars@metafoo.de, 
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	jonath4nns@gmail.com, marcelo.schmitt1@gmail.com, dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 7:20=E2=80=AFPM Jonathan Santos
<Jonathan.Santos@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>
> The AD7768-1 has the ability to control other local hardware (such as gai=
n
> stages),to power down other blocks in the signal chain, or read local
> status signals over the SPI interface.
>
> This change exports the AD7768-1's four gpios and makes them accessible
> at an upper layer.
>
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Jonathan Santos <Jonathan.Santos@analog.com>
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>

I'm convinced!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

