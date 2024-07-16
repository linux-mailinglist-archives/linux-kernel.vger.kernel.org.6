Return-Path: <linux-kernel+bounces-254526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FD5933453
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB45282E51
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0009013F42D;
	Tue, 16 Jul 2024 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHBHWdMH"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE74D143725
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721169879; cv=none; b=VXbH41XY5NNabJVAUr9VRRgdSmY8a+TU+HHn2pATiYXwNbH18XsTntIhaHNEOJOOJK1F2Aqy2CFA1nZX0NSviYi1EOuLQ4t6B9+ChHQR7QOnB2WUey5mnBFWRIjarGt5OjKGtI1KA0YLAnj4YYj9Py2KSNmxS54+LtrqTWsoFfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721169879; c=relaxed/simple;
	bh=MmVnuVb910lD3jj5LjnNp4ene7zVBDRFh1LVckTu67o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wr9h5+pVNtDF97CjOxnYRzXwBdXPu9taPjNGXl4cRT0YkalggD6AZm0+OJBeHdKob331XDyPoNU77cVET6Oyx7ennlMXn0Q8BPH6FPFe08zmn1h85P7njSBjOIDQWxuvbah8rR0rL9TZvODwS4/9AAbHY4LPgKvw0iaQAjaCdCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rHBHWdMH; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70aec66c936so4472191b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 15:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721169877; x=1721774677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OhEmjNTWJbjpBD7LOFVNAJIc+FoMwXOCU7uvyxMdFlc=;
        b=rHBHWdMHWYX9575To20QUbwmZCDPYw8VY9tbFKdh+kuBZru+AWYIjwavQJzJzJixdG
         6mYTbOtRjLlTDn5tD6Dq/9O2VAxGpBtAhF6d/8ON4oZW2V6h41QwrPWSzMKULk4zc4qm
         px7EinoZRGAUPzCzHrK9kYBlJvOHfR+odjuK45roKueqYssQpT0oXa7VeewW7JvxYbi5
         dhO3ts7hwE0lsrkFxhwxq2GLMtPoSQuCEHcFeacyYcpnumaGihfFai3n+/HKA5anOM6d
         noU1aPqt5e4W3wR4V6wAut+WHUyD61gLzqLUg0b8neZWHQyg/GfA3BEQ8ABhfAD8xLue
         C2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721169877; x=1721774677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhEmjNTWJbjpBD7LOFVNAJIc+FoMwXOCU7uvyxMdFlc=;
        b=oOSAd3ZCwy+qE2W8PIBhOhVs6mbol6A0LpzXcEA5H7KIu7LVe8TBWkAWyJY/ObMyrd
         zzoGRpJIrr2KUS4gDJHAKjuRyN7NEJhkFdUcgpqzKmpnSzyrfbxWOiBgGkkmmpr8SW7y
         N/WqoYM9CH08g2crjLcYYflj0OtvqS+6JyiT9wHCn23S918bHiBz2BVT0LgIMRepe2TF
         MCjt7rYXbl73i9zWQzxGM34Qm/RzXvXcTvqf62xlxzko7Ldc+wgXQnO6Ht1IrSDDTo4f
         Bsdm31cdYhyBQtLUpbZhnCUpgGttmq6lQAXPN8wSM84ipDkjq+hVSEd1nRMEK1EKY+JY
         H4Rg==
X-Forwarded-Encrypted: i=1; AJvYcCVIiCH6i/JM42ECEY6bKzDjlCuGnvpsX0Mk9b+LpLk7n+cSBLYdrixkTLydei+QpPV/jznhSklydsbHT+/h35qcEyRGBgBH9oQ1B5Z0
X-Gm-Message-State: AOJu0YyT6tTUQ9z7h5wsbw+AbX1P52VCWiusnr1LSSybq+5BYG89NVZY
	0i8aVBAwesqZYB6mTnZh/QiW+fMd2BFLdw6iRmqQJd1qiWBRapTjBO0ebwNR9w==
X-Google-Smtp-Source: AGHT+IGeXdlooxgyIZ/d7NIMEs+cqBwxDU534pog/am7F4mqYv3kw71PZio/bOJTHyV0k+55TzOxRQ==
X-Received: by 2002:a05:6a20:2452:b0:1c0:f5be:a3ca with SMTP id adf61e73a8af0-1c3fdccb2c1mr17208637.30.1721169876747;
        Tue, 16 Jul 2024 15:44:36 -0700 (PDT)
Received: from google.com (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bb6fed1sm63282995ad.36.2024.07.16.15.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 15:44:36 -0700 (PDT)
Date: Tue, 16 Jul 2024 22:44:32 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Joe Perches <joe@perches.com>, Nam Cao <namcao@linutronix.de>,
	apw@canonical.com, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2] checkpatch: add "Reported-and-tested-by:" tag
Message-ID: <Zpb30HMt6jXtonhr@google.com>
References: <20240419222818.50719-1-namcao@linutronix.de>
 <22344b13affea741ee41b0acb3c62884aac3e1bb.camel@perches.com>
 <ZpYD9dDKYYK0BIA7@google.com>
 <CACT4Y+b0D-RmYznZ_+M98hDWiAZ-FG=eusagoeLGGQN4ZOB22w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b0D-RmYznZ_+M98hDWiAZ-FG=eusagoeLGGQN4ZOB22w@mail.gmail.com>

On Tue, Jul 16, 2024 at 09:11:08AM +0200, Dmitry Vyukov wrote:
> On Tue, 16 Jul 2024 at 07:24, Carlos Llamas <cmllamas@google.com> wrote:
> >
> > If combined tags are discouraged then syzbot should perhaps stop
> > suggesting the `Reported-and-tested-by:` tag? I would imagine this not
> > only applies to the tip tree and that other maintainers agree with not
> > using combined tags.
> >
> > FWIW, this tag in particular though is quite popular:
> > $ git log --grep '^Reported-and-tested-by: ' origin/master |wc -l
> > 82056

The number of patches with this tag is actually 2689. Sorry, I forgot to
add the --oneline option to my initial query.

> 
> +syzkaller mailing list
> 
> We can add whatever text you will say. What is the official position?

I don't know if there is an official position but IMO individual tags
are the safest option. This would even allow tools such as b4 to collect
the tags automatically. So splitting out 'Reported-and-tested-by:' seems
trivial enough?

  Reported-by: syzbot+<context>
  Tested-by: syzbot+<context>

