Return-Path: <linux-kernel+bounces-264200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDF493E020
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 18:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9201C20BFC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 16:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EB01862B9;
	Sat, 27 Jul 2024 16:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gvj006CL"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF00D1D52B
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 16:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722097627; cv=none; b=tM2qdqejff2ReM00p0yEeOw35LMItn0AKY3N/63fW+if7RcNV4U21t4+p4z2MyQZ5DAoy79nCytgE7QX5dcO1pwjzaCihSwYKUJQmN8+qRuXUAP1EU0j8TTzuMgxTvowl6En+oLyQLcjpJEZzoGosLw4sqMyWiwdkGLIInp0HqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722097627; c=relaxed/simple;
	bh=diXfqiCnCAfhXQocQa2/R2YkFW5MXX/JQJ1vfWqciTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lrRIeyarTcXKxdo8H9LxOtbLUiKbyFTPA+Ez62AQpb38MX7p7UWuxYO3KbIigBt0DWU/EtVMpm39D3VMJEYPwOSMqNoOsj58S7GpVMxOA+PTNMHlxInf4UTk8bt4LhtmHcmmTbpUm27dmQZGdPryVokc1uwM/adfjFYsFxJIQrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gvj006CL; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f025b94e07so27926161fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722097622; x=1722702422; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5XbfB27Ib3T/DNbvi3aTzDyG5nLhpOW9JULvBjkbrW4=;
        b=Gvj006CLBeF5lll7Z26kh4k4GT+gavxbzrYPT5ckCrU+QfybX9zztXaLbfxr8jy4i4
         coK15qlhTuc6YxOUXiLbdwIRoquGfjcrAMKi5FU0v3dNuTnn/AsAxDnuFoDIKVl/6isn
         lqH4lL1S9g9RNDtqGfVJ0r0CMpDWGsexVBYRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722097622; x=1722702422;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XbfB27Ib3T/DNbvi3aTzDyG5nLhpOW9JULvBjkbrW4=;
        b=cUF2u1JMobq6jKpSxrCF5q4gIkslCFA/sryq6F/m82KFM8x64Mjlvu8iA1qEBLTVVA
         s2fOI2CJ80qyjZBdTrMBbe3VE8fvvHE06L0YWT8wwstFjcNUE2ZeNjj1EHiL7xljMTOW
         jHLT9jrBHKu3VXj3U3HGQR/JlOBNE2mFqEv1cdKF3xKymgvaoqTz9zIJz96N2Ikjd5CJ
         oYLwEveLIFUAgANiPPVPto9BNNLD4MOXo6SFtVQd2MIoG15KRXcTauRrz6LhEt0JXRFE
         bTsIZIMZkuwzbg5eaVrtv0vQu5zer5ep3ANKmBSezqRJi5fGTNJGmqzJD0gs0o8qtqgK
         8VYg==
X-Forwarded-Encrypted: i=1; AJvYcCVEnXyKVicO1Y50IrANiAEi5r+/QKCbefEHEr138ZrMeeJKbiID7q+PAfj3f5DbXnbDfBqgX7lD1peIxw3PBcaQp4DccesTanoQtoHx
X-Gm-Message-State: AOJu0YxBAXCgL9vW9L67ecJ9ySWpQhJx428KL3Blvsyq//TXX2/DkxKy
	dbT9rkDcn+j3vTAGNkwYf2bl9ezQGHzX0Ol2ZEQEUajdr5ij0ovSQugCB6VRZDOXXXYaOorqR2G
	h94tJ/g==
X-Google-Smtp-Source: AGHT+IErcA0ppHXcdvlXMQ8Oc7PHQqKkZxS5ByKVJWVdNwYH3mLttGBKfcaX3il8FdkK2A+lKpA7xw==
X-Received: by 2002:ac2:46d9:0:b0:52e:7f18:176b with SMTP id 2adb3069b0e04-5309b269b7cmr2232116e87.11.1722097622408;
        Sat, 27 Jul 2024 09:27:02 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52fd5c2cc36sm795687e87.270.2024.07.27.09.27.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jul 2024 09:27:01 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ef2c56d9dcso27334781fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 09:27:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWztUQgX9apermjX8KyMZkHkpeXvWV5JqTFrZGm/GCKSGZdyeAPNIzlFqTI7EsQRfnwVh1Ro4MZs0aDw0C5gk+3Fb7mUsNioQFEo1Lj
X-Received: by 2002:a2e:90d9:0:b0:2ee:8d19:85af with SMTP id
 38308e7fff4ca-2f12ee24392mr18800621fa.36.1722097620647; Sat, 27 Jul 2024
 09:27:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com>
 <902a9bf3-9404-44e8-9063-03da3168146a@lucifer.local> <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local> <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local> <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
 <2f1be7ee-2d70-4dd3-bfa2-1b94a4fc5a66@lucifer.local>
In-Reply-To: <2f1be7ee-2d70-4dd3-bfa2-1b94a4fc5a66@lucifer.local>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Sat, 27 Jul 2024 09:26:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj9GLHpMo=ikVYzXtnNBpFwG3YeCZHfWndj5_xm=19szg@mail.gmail.com>
Message-ID: <CAHk-=wj9GLHpMo=ikVYzXtnNBpFwG3YeCZHfWndj5_xm=19szg@mail.gmail.com>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Laight <David.Laight@aculab.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@kernel.org>, 
	"Jason@zx2c4.com" <Jason@zx2c4.com>, "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 27 Jul 2024 at 01:08, Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> 62603617./drivers/staging/media/atomisp/pci/isp/kernels/ynr/ynr_1.0/ia_css_ynr.host.o.pre

Heh.

  Longest line is drivers/.../ia_css_ynr.host.c:71 (27785kB)

yeah, that's a single line that expands to 27MB in size.

And yes, that line is one single min(...) expression with arguments
that are then in turn macros with other nested min/max arguments.

See also drivers/staging/media/atomisp/pci/sh_css_frac.h.

On my fairly beefy (admittedly more cores than single-thread) machine,
just generating the preprocessor file takes just under 20s.

Building the object file is actually faster at "only" 8.5s for that
one file, because it uses the built-in preprocessor and never writes
it out, and most of the actual preprocessing result is trivial stuff
that gets thrown away immediately.

              Linus

