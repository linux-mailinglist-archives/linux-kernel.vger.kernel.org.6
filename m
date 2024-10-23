Return-Path: <linux-kernel+bounces-377478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA97F9ABF70
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896AB281CCE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB4022318;
	Wed, 23 Oct 2024 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ygv/In91"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D28114B06A
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729666663; cv=none; b=smWBiFWkARvsHZ9oomPQ/89NgvTIM4Sq4S4mgX/EjmAnijBPkfhCxOpt0gbYI43ZFGMkvi54k6Juz2FFq0OYEPfwIgDRMLmKGcxZuGAz0GfhHfRoST6mrJerphcReDieLyvhvoJ6LfdELf7Ut64I3tauMcoZii6WnKEG4HFDGZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729666663; c=relaxed/simple;
	bh=+DJNWIZbVNn82qsQuzqolTkm6OylX+6kptnUPPo2n3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QfAQpnLBX/c7Yc0o1mDeVo/sIkEiV5ycPshOVNuWdDK1Q/t1XxwBHIIcZNq/0DfO4GvCkVYSzm4I9uhLUQCCM/0ScE0boMY7b9mDUBG7NsOmEGdQMFnTSV0RLKmDbnqemZMP4s3L5/lEHrBrkCa8bR18ta7cLznQalZHkgMq7U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ygv/In91; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2d1858cdfso4309569a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 23:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729666662; x=1730271462; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aGURbA/qHkuvhmvaDTB3AAE8n+iTpH3OvqTtBmFgU3k=;
        b=Ygv/In91UoNs/xZGt0vYQrcN9zI43rqwCgd3+HxV+cOwIVSBA1CXxW1xl6A9BTT9ut
         olxiHr9EZMTSDpBaPTlJ63LjnEm6NHGyWBb8JsygeTkhToaPAzB53VC3IzzR7vgUmdU1
         9vgyTzaT1Wq5ExRtjpXG9QyJvu6Xdi0+Ta8HGdrTCVBPcf5p4hkBrpwMRHfKP3IC2vFF
         zHc5en6q1qYPinU5pIjdLmfLpsWZNlkv/ZHff2DsKS+io6o7cGLy8CjLZKFKXja8jBUQ
         jeKVqkY7yMBnehTeDt2X1UBRcEYGT4rFH2bSC4hDUjUB+NCkPiAvGZWL7JPveDmGuLpF
         O7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729666662; x=1730271462;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aGURbA/qHkuvhmvaDTB3AAE8n+iTpH3OvqTtBmFgU3k=;
        b=Lpf06+758spLC8w/1NDEeesiTsfhnIZxKzRe66HGFSmGSZfPKnHpIB3dzGiOR10eYj
         gLSmB9ASjwgt+LpYIr7fzCzg3zFmacTMLC5+tQB8HkC+aoy2L9hoUX6JRxu9TmcdcKey
         HKKxx8JvVeCovrxEHAozXyfOaAtKIMI9uW5cAzjAGn3SR/1MotnZq3sGJ+GDBKOzDl15
         K6sHE92IgLMvRZyL/2hr3nA8dmWYZCPWIWi70byOYe89Mo0PUtX79CITwH0qIps/PmEv
         Q4saByP1aQYfcfNva41lvIeFoqW6NAvX93vjYXRrlsXUCXRgQBruuhqK09oeZ8+QG3ax
         2i5g==
X-Forwarded-Encrypted: i=1; AJvYcCUvXactNlGat//mxnq9PK8icKMLl/n++Pbw59ns1b112Ig4mbpXqiaZPMrn7yZkEvF35Vxxm1aqaAz24v0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3jAfe0+Nh8wiq7OOoEOAInsELDYahNQPbEvY0a5ZmajOkGb9a
	GU2wMcKeklOu5gq845x47kSh3HPkLvSNdqhE1vv9s6aBFTSBE5/kw3pJ0NChnqWyOcULi4Esuc2
	mVdk9yiSj+uxWBW8hM76VnYrAcxpQRPe7nF35
X-Google-Smtp-Source: AGHT+IEzIW4l3r51CWrL2LlpC9+Sdi5XdftU6GzooFfvIKhQDmOMb9aLs1JszBM7B3/dz4fbLSbHNrQjjSmV7B/tDBw=
X-Received: by 2002:a17:90a:1149:b0:2e2:c406:ec8d with SMTP id
 98e67ed59e1d1-2e76b6f1543mr1537207a91.31.1729666661435; Tue, 22 Oct 2024
 23:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018151112.3533820-1-arnd@kernel.org> <ZxidW3lvA5Pqu71m@infradead.org>
In-Reply-To: <ZxidW3lvA5Pqu71m@infradead.org>
From: Marco Elver <elver@google.com>
Date: Wed, 23 Oct 2024 08:57:02 +0200
Message-ID: <CANpmjNNK_viqTuPxywfvZSZSdWGRsb5-u1-oR=RZYTh7YKk8cQ@mail.gmail.com>
Subject: Re: [PATCH] mm: export copy_to_kernel_nofault
To: Christoph Hellwig <hch@infradead.org>
Cc: Arnd Bergmann <arnd@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 08:53, Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Oct 18, 2024 at 03:11:09PM +0000, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > This symbol is now used on the kasan test module, so it needs to be
> > exported.
> >
> > ERROR: modpost: "copy_to_kernel_nofault" [mm/kasan/kasan_test.ko] undefined!
>
> Meh, it would be great not to export internal helpers just because
> someone wants to test them.  Please just mark that test built-in only
> instead.

We have EXPORT_SYMBOL_IF_KUNIT. See include/kunit/visibility.h -
that's more appropriate, and also adjust kasan_test.c to do
MODULE_IMPORT_NS(EXPORTED_FOR_KUNIT_TESTING).

