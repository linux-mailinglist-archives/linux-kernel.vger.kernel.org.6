Return-Path: <linux-kernel+bounces-280963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718F894D16F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00DB9B221F2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D7319580A;
	Fri,  9 Aug 2024 13:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D3ew+NPR"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B2A192B9F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723210732; cv=none; b=ZEKh7Hbt/zpkAcch/Y9zwZArcZR8dIf9ZlCE1bAxI0EAlFvbSBqjme7sgHGx6ByP2QgShtC/Wi/qihHnj498CgRzvBXKJC24tux+Dd/OLIP0OkEnNrN2khzDISnckPh1mVU2tCQvLmiCs1ErXAhZ3hLXSYfiEysj32kXf1T/HT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723210732; c=relaxed/simple;
	bh=U9PgHMmXwArkaS49p8aX1dEbXHZP/CRcN0LvOlL7M5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4r5+OaDjWRLPRVCVx+X4aL9D0iiSvjEip4R6yAKl7IRZcCHTWMeSpgKRzJ2ZW61ZT1+dpBf9xaA4u232Miz/Ba+x/OnGP6bSRG6V70i2EvDCvkzknS0p6NZrl/TOs7ptlqURULvF/nGwzo5VVrWdtSKYIkPM4M+sQPGy4b+YXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D3ew+NPR; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3684e8220f9so1176351f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 06:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723210729; x=1723815529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+NGAfmPnXsWwgUAptnJ+cd0Pt188Yd+YvqSzH2iizw=;
        b=D3ew+NPRUjJG7Xvl1GaRZYqEYe1sm7k6CyHsqKMyzebfFha+gvyPm0PSFUx4Rk5j7A
         m//CgC/GRFGESBz1zWNxVt9MPepsJSW72NljtWbjwyjW7a0W5q3w5HEbvG/XHsBq7RCG
         mMID2K35NBJmjIyRZu1Q3OflyDoihE3jaY/dDIzvSDkNrWZL8PDMjL9ZalJp2QV3b4XJ
         GETyyvPDcI61PSAoO8lsKJeSJELXidMmxHbKUm7inVbjJR0VGOoERWBe3ljcmy6lAngl
         WZqMzdcLwcRmnsb+tuK2ml+GR9XlAo/PZVD/HkYeAmE4w241JnLe5TFOznj2QGyE65nF
         9q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723210729; x=1723815529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+NGAfmPnXsWwgUAptnJ+cd0Pt188Yd+YvqSzH2iizw=;
        b=G+l7XAs9tMLpwk1re1kQzHo1NtBeIsXpaA5xQ37KiltvZ89PLGqaP++PWsJlGfCbHA
         kxp59J0HWIM2eGsudQDo1acSmItjqEW8dZ+RkCWDey4XKf8u6F5qUmjqDwW+yjaKxRpg
         YxbeWOJD2gF0U29V8EeQjtUW5/Sy38Yl/jRVlF3yOx0l+pFDrdmOBf/sElYa+UaBY3OC
         A2+B6oyd1hpgYRJLt1/5LuOm3bAtrmv0TdcGhaVhAnEObvYAZ3ftQenlmr5Oew784cfA
         jM/pY2IuQ6bwHrtZPnpNNgSv/3r/5B8Jg2HnMkTm5JEg5PTDPRAsq6k7D2qksaxjrDSi
         t9vg==
X-Forwarded-Encrypted: i=1; AJvYcCXlvzh1EuSVpWHcpuH9wr6sfCofIds3ytMvOHmK3l/Bu2EZewMz/XcpXlrjvdgfW7noZ5Y0FbwVAQojFZTuan3W+PJHciTBBLYKRdIV
X-Gm-Message-State: AOJu0Yw6kqOxVZRw1m1V5VEuLI8jgWVpHj+mSQdX4I/5rns/jAdcdk8x
	W9Ujx/uAAcCjemx+1p6PONlI321/QYfaysiAbMUE1cw5Z5Ng3wEaWblCEWs4GD8UR0L9u/HxOyE
	1Dt9G5Dtuv1v5A/+4MGaQtlDf//kPpzL6qRVH
X-Google-Smtp-Source: AGHT+IGLCN0hdBaFSgURlEBmYzXSiLipHSTPGxPeeVAfZBF3FCClOKXB0C2KWuYJCS7FyPZ+RAPHoq/m3t48/wKHerI=
X-Received: by 2002:adf:f208:0:b0:360:8c88:ab82 with SMTP id
 ffacd0b85a97d-36d6a75842cmr1629625f8f.30.1723210728768; Fri, 09 Aug 2024
 06:38:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809064222.3527881-1-aliceryhl@google.com> <CANiq72nP+pL7fEvaB7HA-mHJFs1j9SKMoSMSCif61YCy4QDFoA@mail.gmail.com>
In-Reply-To: <CANiq72nP+pL7fEvaB7HA-mHJFs1j9SKMoSMSCif61YCy4QDFoA@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 9 Aug 2024 15:38:37 +0200
Message-ID: <CAH5fLghQ9dRqGdvRxGfiby9-xG4kY3QN8adyH2gVA5urZXpq=Q@mail.gmail.com>
Subject: Re: [PATCH] rust: sort includes in bindings_helper.h
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, 
	Andreas Hindborg <a.hindborg@samsung.com>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 2:58=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Aug 9, 2024 at 8:42=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
> >
> > Dash has ascii value 45 and underscore has ascii value 95, so to
> > correctly sort the includes, the underscore should be last.
> >
> > Fixes: 3253aba3408a ("rust: block: introduce `kernel::block::mq` module=
")
>
> Looks good to me (`LC_ALL=3DC`), thanks!
>
> I can take it; otherwise:
>
>     Acked-by: Miguel Ojeda <ojeda@kernel.org>
>
> I am not sure if this should count as a bug/fix (there is an
> recent/ongoing debate about the Fixes tag).

I fix merge conflicts in this file almost daily, so I think there's a
case to be made for taking it as a fix. I should have clarified this
in my commit message. I sent a v2 with more info:
https://lore.kernel.org/r/20240809132835.274603-1-aliceryhl@google.com

> (This kind of issues can be also opened as "good first issues", by the
> way, i.e. as a way to get contributors to set their email workflow.)

I didn't think of that, but if I had I would probably still have
submitted it myself for the above reason.

Alice

