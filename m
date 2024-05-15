Return-Path: <linux-kernel+bounces-180158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1909A8C6AD5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49DA51C20A39
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 16:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1776E22F03;
	Wed, 15 May 2024 16:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mjCct2JV"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33CBA46
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 16:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791420; cv=none; b=MpocuEeJG885M7WbYQ4jLmNLc9LnDvW9aAckGRkiI6z2tZiiaB3su+3rObkxO49HkdkpbxTJl5maXjm/QwYslASD9HKxtAFqXgqrUJxfQ0/bb1W2vNWAMMwec2dg3m4tT1+LuCG8pqUU2C0uhlZLBjkFKUlKc0V2Ut+DhpPWhqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791420; c=relaxed/simple;
	bh=jcMjC0VbA65cImgzcjHwNorDdRf5gwj1tQfrzlHFPJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vd4tJcZN9Ijjb1RnXeKxl8HBhcHEMetNvSIMe0UYZdjQbBZl1WMysFaHaCjJ6SQTerwtVEq31e2biaaCwv4QkjAb1X8/sPS+bWdedZ65D8yoL40e4XVHeuGHPX1Rfv22GwCnR3niLW7etJzWmZPxSaJkbZ9ZioCkJw59xymsQdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mjCct2JV; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f4521ad6c0so5811209b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 09:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715791418; x=1716396218; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KCJMwu966FDCcIlfPMsfyySrZYW0OH3ewcgATtZeRrI=;
        b=mjCct2JVnrB3tOkSFRtmV4vnaDC2QDpOfTsuYxF1YuhXHtgqYtI2qUGMuKKtOXYH6x
         W7xD64An7Yar1S3QNSOWUC0nONNE4UxflRx+QJ1dKxzeQWcsoaP905z/ncSoJT6Qy40g
         u/3L3n5xhcWPzq6Zi1QrUQgS+K9Gt+mRBAwxQR+wzGgcq6h+rxldagTirWQWOAPFUdn2
         FraWpWHVeQTgIt86fRZpBPVB4Gy8mz5bi//wCmp+VOp5aVBxlzIXEb9fw8otuHZCB0op
         GR/dxJ2cX6+n4W4j2odv0/lbO0fleWvw4VqVyGoaAEzNXTKsNhzg+70HZt70qrQJdiI8
         1oYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715791418; x=1716396218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KCJMwu966FDCcIlfPMsfyySrZYW0OH3ewcgATtZeRrI=;
        b=dyT3yA67zJVf3CkUw3+y36VbQZ1vF5Fxrh5PrgLUCYDgLXtqH+oNR/HcUhjVjjb3h3
         1PuZ7+NPoGDQpbJqxzuWZ4oHF+mrw7ZRWxvsf2OrA2vlyXt6tAvSci4SoqGnsuVo/J66
         q1LeFxhW7lwqk44NkGWBwgU9soiYgVn0Q2etcFW7c2Ucu2OPhG6APD+mGvMeIqLfVMAs
         XDFrxGaxtVRh/9gqTVRMy1naH9m7k389VYu7Pd8SdoC+WwxRPD7XhlgRaL3Or5tr/pHX
         2Wvz/jPU4vf3KYbnQeNnhHJOaqHA/SXYMKeWAL9q15uE2737IO5t0aZxQNEzK2KXfRbm
         +X2A==
X-Forwarded-Encrypted: i=1; AJvYcCUBGb42CcIep6dVl51sZ5drYgb0pSo7VzAiVmEczcI6RtTfrMNeNYljPb/w4E82eQ1SKkDthNQa3KNtEad0pAeFcZot7d6JICxFOncU
X-Gm-Message-State: AOJu0YzZUZQd2DnjW0Rfikv0AqGASibwv0mZcpA0UFK7h040i8W5fawp
	wrrHdVXEkxb4+qnsfom4S0zCssjJErBlPYSUjmUtlGJA9Bzy+g2ar8B3kGYbTA==
X-Google-Smtp-Source: AGHT+IEhAlkJshleRD23ciICMJOkluLgwPVW23kaO1y8I7b9VoPoLAXXUQWk16dFWtTdOpz/iYqaaw==
X-Received: by 2002:a05:6a00:21c1:b0:6eb:3d37:ce7a with SMTP id d2e1a72fcca58-6f4e0347c31mr17055835b3a.21.1715791418123;
        Wed, 15 May 2024 09:43:38 -0700 (PDT)
Received: from google.com (57.92.83.34.bc.googleusercontent.com. [34.83.92.57])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2b300d9sm11292594b3a.215.2024.05.15.09.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 09:43:36 -0700 (PDT)
Date: Wed, 15 May 2024 16:43:32 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	Tim Murray <timmurray@google.com>, John Stultz <jstultz@google.com>,
	Steven Moreland <smoreland@google.com>,
	Nick Chen <chenjia3@oppo.com>
Subject: Re: [PATCH v2] binder: use bitmap for faster descriptor lookup
Message-ID: <ZkTmNLxhlPlHdQCW@google.com>
References: <20240514160926.1309778-1-cmllamas@google.com>
 <CAH5fLgjzVHSAQBF5-C1BthK1jspAGRr1z4SQXdQepkeVL9Eq2A@mail.gmail.com>
 <ZkTlG-ZNHRYXnHLQ@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZkTlG-ZNHRYXnHLQ@google.com>

On Wed, May 15, 2024 at 04:38:51PM +0000, Carlos Llamas wrote:
> On Wed, May 15, 2024 at 05:29:29PM +0200, Alice Ryhl wrote:
> > On Tue, May 14, 2024 at 6:09 PM Carlos Llamas <cmllamas@google.com> wrote:
> > > +static inline int
> > > +dbitmap_get_first_zero_bit(struct dbitmap *dmap, unsigned long *bit)
> > > +{
> > > +       unsigned long n;
> > > +
> > > +       n = find_first_zero_bit(dmap->map, dmap->nbits);
> > > +       if (unlikely(n == dmap->nbits))
> > > +               return -ENOSPC;
> > > +
> > > +       *bit = n;
> > > +       set_bit(n, dmap->map);
> > > +
> > > +       return 0;
> > > +}
> > 
> > Could we rename this method to something that makes it more clear that
> > it's not just a getter, but that it actually also sets the bit?
> > 
> > Alice
> 
> Sure, what were you thinking? I had picked "get" and not just "find" to
> indicate this behavior. However, I'll take any better ideas. The option
> of dbitmap_find_and_set_first_zero_bit() seemed too long for me.
> 
> --
> Carlos Llamas

I like dbitmap_acquire_first_zero_bit(). Sounds better?

