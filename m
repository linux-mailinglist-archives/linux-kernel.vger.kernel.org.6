Return-Path: <linux-kernel+bounces-377500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B88F9ABFA3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 09:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0261C2133E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 07:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D0001448C1;
	Wed, 23 Oct 2024 07:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="drjx/xV5"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E01453E23
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 07:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666981; cv=none; b=hvflwALCf/cVVgOGNJQl5S9AQ3Czf3xcu+GwoVkCPFIEKaSkLvmiTTCaLJjquoZEBbuxk/lZGlS+wmLjQR4gdO3k8o4KAgkW+X833OL0sOSsvHUxfD+JNX4ql5l7LNfBwOIoMu0UIoDqpNZ2sAiE9fLpYyVVFHc5LftEi1gSg3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666981; c=relaxed/simple;
	bh=90k4mUxa4TToi5H0ZYiSnEuecPVeb96YK0+jz3W8+B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JT0m40AOd88V1DQNya1j40hbsteQRR25MFOKB8TEy7hMFPWEpXX4TvEaD9D3geqLueeGp70lCCnVymF/8b7DWVtTpF62v5gto3UIr+hs8G0GqSka6s2LERfkb915VEXSrclZT24hG0g9dStPHDYTLv+elN8TugoUgqmDMnupM34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=drjx/xV5; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7ed9f1bcb6bso268310a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 00:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729666980; x=1730271780; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jdSwWgJ1k0ZtaVkiK93SKIJMNYM2PubLs1+cCBiZLJk=;
        b=drjx/xV52/HHcNfVfACmlETH8a3QLhvxq0yOQSdMQZJzbJfSdDVKMab+BEF9yZs7ag
         yZzEF5a/bTH7NbBNAn7jqADM/JFj8BpisxcGBWE6kaJ1Fm6h8TdZb6DWeW4ZJnh06rdY
         pXQ1YJM7Im1xH3KLaC6JS2HSrzX99WmNPksKsEH3HcXr5aHdjUiWpqrroCOWCZ0vPSSE
         Fmuk2LRKlIYT1eAHJRjZxiqt9LzVU9USn+DJLWp5NsGgbYNWXNx8edRmCZLifHXg1vCB
         XhOSjO12+ViIYsMYVd9FAZnrqqfGKrdRpNvJ6RCMiVSbwRBjERVHOb3e/V98k1Dk6bX/
         jFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729666980; x=1730271780;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdSwWgJ1k0ZtaVkiK93SKIJMNYM2PubLs1+cCBiZLJk=;
        b=vGRAZbKWLpnnHLKgLkgDvZElCLV4ZF1igxBR3S/8iT0GGHB28NRSkwPDvUck2pDcrJ
         wCO+Ldhk7/HxOBTkKFDmx+I0JZtvsMEDYPo6g5x2UHAA9UuJfEA9tUm1qZwL33PWnldH
         3m4peUKn8ZP0T2XB469QH+tG1GuG6pk6p7r89vT/LOahjJajJI5ebfSJhuovHyC2ApNf
         jgFSnwnp4xlPck6h6HRPqAxj9Chbc12x4dmG6PZBX/b+gpLbo7y+9eQlE7uLDTVFA7Wo
         6ZAAogpUQAMbdvUkII7rtjA2aaB/v1JCw4tJeCG70g7jbdn8uC/0L+zcETGxisIbUC4p
         YJLg==
X-Forwarded-Encrypted: i=1; AJvYcCWrrRRLL9Ru8bfHGF8QR2+qRgroTWqIxEblR03s8OoWaDt89O04Hu+4yn0qKlQBt/6pfr0Gcf0hXuVPdo8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVX+eP77wa+k84psC2818kSh1vL2dX6waMvyr1Ho/GpIuGasmK
	FeGVPyqH4DxD+3+AJq+4T9n3TgPxXk12wJnIIH5bif08Iogp+7fTamupkrzrux4aqRP6JsEUa27
	3r/uiZ/K+DRl7eZ0p1GJ7zcOr1Tqej7Jk6ZD4
X-Google-Smtp-Source: AGHT+IEISTQeXabs4ioQ5AeCbLgv9CXugVq3MQgadQe1dl/7sZYwRFgzmfdnX1oUJbl2vVmKVPJnaxd/NX1zkrDG8Kc=
X-Received: by 2002:a05:6a21:60c4:b0:1d9:a90:8879 with SMTP id
 adf61e73a8af0-1d978b2d7b6mr1813000637.21.1729666979390; Wed, 23 Oct 2024
 00:02:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018151112.3533820-1-arnd@kernel.org> <ZxidW3lvA5Pqu71m@infradead.org>
 <CANpmjNNK_viqTuPxywfvZSZSdWGRsb5-u1-oR=RZYTh7YKk8cQ@mail.gmail.com> <Zxiev9UaoUlI1xs9@infradead.org>
In-Reply-To: <Zxiev9UaoUlI1xs9@infradead.org>
From: Marco Elver <elver@google.com>
Date: Wed, 23 Oct 2024 09:02:23 +0200
Message-ID: <CANpmjNPvBnov-EFk1PNO4GEOF7XLG7S1bYYjg9i4Ej=ZzaA6ag@mail.gmail.com>
Subject: Re: [PATCH] mm: export copy_to_kernel_nofault
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 08:59, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Oct 23, 2024 at 08:57:02AM +0200, Marco Elver wrote:
> > On Wed, 23 Oct 2024 at 08:53, Christoph Hellwig <hch@infradead.org> wrote:
> > >
> > > On Fri, Oct 18, 2024 at 03:11:09PM +0000, Arnd Bergmann wrote:
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > This symbol is now used on the kasan test module, so it needs to be
> > > > exported.
> > > >
> > > > ERROR: modpost: "copy_to_kernel_nofault" [mm/kasan/kasan_test.ko] undefined!
> > >
> > > Meh, it would be great not to export internal helpers just because
> > > someone wants to test them.  Please just mark that test built-in only
> > > instead.
> >
> > We have EXPORT_SYMBOL_IF_KUNIT. See include/kunit/visibility.h -
> > that's more appropriate, and also adjust kasan_test.c to do
> > MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING).
>
> Thats a little better, but at least in this case I still think it is
> a very bad idea.  copy_to_kernel_nofault is a perfect vector for
> exploit code to probe writing to kernel address without causing faults
> so it really should never ever be exported.

Another alternative is to just #ifndef MODULE the offending test case,
so it's only available if built-in. No need to just make the whole
test built-in only. I know there are users of this particular test
that rely on it being a module.

