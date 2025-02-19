Return-Path: <linux-kernel+bounces-521815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7A4A3C2A5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 15:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 094483A7B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 14:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B539A1F3BAB;
	Wed, 19 Feb 2025 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eIGjm9SQ"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E27B1EEA54
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 14:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739976686; cv=none; b=Yos+ymfi6/26jS5jM3+f/C4cgfKYgMIGWJsXQSWTk/bWq7dIDrUTNQ4qyi9AD2zPzhwUfXb0v3SdL+F5KkEAd1EG3wpWNOiYxZ+hKGCYQknYtVwXjIqoBeDLgxTH+jJOuqeVi9FClB7PEMQLGd7ashia9CgbbZ5XeIP+ac53Cbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739976686; c=relaxed/simple;
	bh=oS+yu/QgRYhKSZl4yDfF0LhoNp/PyaQ+d1uaBefYcqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEHjTaOKw8K+OdfK8/udeOh/aOYap6yiJc3XX99jqJLfbwpD53ZZXZRtDtYyETb9m1VSRTsqBstZhigmenflSeak6B5NnsH0EeqV2/7ZLm3wpUyTp8uEa8mUlarVCPMweIlCr4Ldu11+8Ip1sif1v17uQ5eziEkTvpIiy8vjBTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eIGjm9SQ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e5ddd781316so2901369276.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 06:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739976683; x=1740581483; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MYcZPixSU09FvTt2cU2XznLhSpH8HftilN3r6wgw4wk=;
        b=eIGjm9SQrXb3EK2iPgzFO4H3nP8A72EgHHHlelCBOgpb2dhHH8kUwtTgbaJkgGIAk9
         /EBvJjdLcKRjtHi9IMGVsOtpsLTzYPoB6xMFB1h1P+XoDDUNCWlHGJ/gfEN3fVZfTx70
         KczebrUNci9hXP+XKnIfIqgQKOI0D5MHfE/EJGcuSHt+6ym5GGMHzfLvNambUB8UVh+v
         W322XedVnIxSJ42R6Ryu8yeBiItc2zfkWFaK5x793lnkvsDvmM0SyzQ+3nqp5QcXW0RI
         7PrrQefj+XMfyz2rNiN9hmPiJkW8fGDTV25ct9w9/uUNyJYv1xdTu0xtd/eYLGRtvnmX
         I+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739976683; x=1740581483;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MYcZPixSU09FvTt2cU2XznLhSpH8HftilN3r6wgw4wk=;
        b=IzVANqbiA4fH7hIvd3re0ABU4gqzB3Pf99YvpONxtJNgarfjDS+Cr3A5ivh5bjMDxc
         x1hOKZ2mQ7aU7RvWquq87v9bjG3pZ+8JIPQYXfW6AI1QuZij6ZyE8yxW/oyqF0fg8qli
         hn2DSvydgTy5YrBd493F//LjkqMbZu3Mj2kqi7DY51t6gliGB89YYeWE780YQFRY5JsD
         QSoNypVC1+SK7+DBs0QYXfhii+8oglLnjd6lqFxiZKgrPgVndxmKHObGC2SF9MAPpVEp
         /uM9yaooRDV2YLFGir0TnNEzIa/lKlbHQ4m+Hbk9HIXSdBByq4smLkltZTwWrlYNGiqM
         a57A==
X-Forwarded-Encrypted: i=1; AJvYcCWd+j0XEXUDdtDbQerWLY94K6rBGVCEs2qglMoxBlo+QX0X5AnTKOo2ueeIepfyNJGti7uPED+D9ZEfugk=@vger.kernel.org
X-Gm-Message-State: AOJu0YywkJjBqeKdI+SkZ/x8juxnjmJ8ghlQP/YdT3/ei1fpXCWI29OT
	4RL/Q2d+VwswUH8Td0KRv5uddcXWWSWk3QvIN7Jx4CqyICFR97yVZ86nJvtPma96T0qLV8FVsiB
	3Krw8LvfdcWqWumy4eXo060rw5nKlK+9YViU6YQ==
X-Gm-Gg: ASbGncutJfgzvlwdxRkbTTGngeJ/ChgRtkSO0iJs2DHyY8ON8e8jAo55BrftIUg8AaS
	ipx9kWZgSjP0MeJvqVuV6ihsDmX5ltGeJpPZRyjFkz7L4qbprn0BwKs3gfDVqVQQdvYfv/FARqL
	ZQFodc2qEbo5xhJtYsVHxkY+NRhQA=
X-Google-Smtp-Source: AGHT+IFDRnRjjoBS/EtzzR/rm4w30wJi1RY0H6xdR4FvTj6621K9TBsfPk05+xPr/Ay6d44n/69mJWQak4reieBYPok=
X-Received: by 2002:a05:6902:dc7:b0:e5d:cdc6:7ad2 with SMTP id
 3f1490d57ef6-e5dcdc68210mr9659126276.46.1739976683113; Wed, 19 Feb 2025
 06:51:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org> <b7a3958e-7a0a-482e-823a-9d6efcb4b577@stanley.mountain>
 <2bcf7cb500403cb26ad04934e664f34b0beafd18.camel@HansenPartnership.com> <yq1mseim24a.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1mseim24a.fsf@ca-mkp.ca.oracle.com>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Wed, 19 Feb 2025 15:51:12 +0100
X-Gm-Features: AWEUYZmLPvlXBp47lLPgCcdKQupT0djJypa3PTSZUXuiz24ub3UWxBzENa0nPX8
Message-ID: <CACMJSevfxqdwOTAhV9CLautgoEur9G+9HWmQY18h38vNE4Vv3w@mail.gmail.com>
Subject: Re: Rust kernel policy
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Christoph Hellwig <hch@infradead.org>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Greg KH <gregkh@linuxfoundation.org>, 
	David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 15:47, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> James,
>
> > Could we possibly fix a lot of this by adopting the _cleanup_
> > annotations[1]? I've been working in systemd code recently and they
> > seem to make great use of this for error leg simplification.
>
> We already have this:
>
>   include/linux/cleanup.h
>
> I like using cleanup attributes for some error handling. However, I'm
> finding that in many cases I want to do a bit more than a simple
> kfree(). And at that point things get syntactically messy in the
> variable declarations and harder to read than just doing a classic goto
> style unwind.
>

The same header also introduced infrastructure for creating "classes"
which are useful if your "destructor" (or "constructor" and structure
definition for that matter) is more complex.

I find the lock guards from the same include very helpful in
simplifying error paths in critical sections.

Bartosz

