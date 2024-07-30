Return-Path: <linux-kernel+bounces-267316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CE2941007
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D97E1F241BF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AD7195F1A;
	Tue, 30 Jul 2024 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nAgSbXv1"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0BB1DA32
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722336934; cv=none; b=fbD3ZWguh+vpgu5yzOb1CI436MJM7Sua965MQwdNnR5vT/vIu01YAlVieLjdas2wTWQKK7sBllOx9M/OOaGdPAXFvxAYfjspDn0CiBUq4ToO+a/92zNyNk81pWOxPqbyANsIyelIV9GKam38J1SMvDogcAuJoEe+6eiIlRYerZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722336934; c=relaxed/simple;
	bh=v0tgyls8FUGT1sQokYSCsuUAU+aj8WL3aZ1cfqKSBQY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OTR0vFI4K1i40EDgDr437ctD1mx+hJdql5VDqwpsgUWd3egCla7ZNm9QuVO+8cYpBaUzD9kfRzdmzjBq0HHUpB5A6hdLqil+hBj0Tb4WUjQl0Oday+23m+vqRVsVvAjiflhEnAvZXXuYyrm51fbf0WsMx5QxPUpnltTFi4vJWyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nAgSbXv1; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5a18a5dbb23so9281a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 03:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722336932; x=1722941732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xr+voav8MzKq7kTcrDPxGaN0prieHV85Xow3mdChfiA=;
        b=nAgSbXv1FdNS7uIOv7twHCMapPollv43xaUhjz5MrRML7GoFcHmfGNbW/zGgh34li7
         7JXEvKtM0zujTrS5yMcwcMxO4K8uzFUzMUM6O2r2scb2cR8gLHEtHcw03MylAv27gGpK
         1aJ24RaPi/kLK8xcQy4XWn9HlGP3QGVnkZn54JmcdON7Z3uUu3F9jIk8rEjALi1bxBA/
         TKxfUYRWKHXj9tmkCWSwfHjMYM/C3uhosN+xdaG+U3Ufgrc9o4IZCNVA+W78h7aytkdd
         ahADUm/A3cEd3JLIYPyKFcCBChD9RiVBqgF9QJorxhjJqcF+Y7eRA1gUMEPx7zrgAW79
         pJgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722336932; x=1722941732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xr+voav8MzKq7kTcrDPxGaN0prieHV85Xow3mdChfiA=;
        b=ZcKv8N8YgVkLlhXthDcPBUmAIUFCpAEtnZBVg3EuF1EVis3DK2QvwBPylfK3JNGdkW
         9OvKiMY4gt9UqxDSKWHt095HqIdBoLs+Ucdl0CjpvgxigGiIyEw4/8evzwhXwCX8dCDy
         sY5Tk9Sm5AJWXxYQRnKUvGuffch2EohNJslQ7LFEAMVyb3u1t2K+1XA/or9g2tHd5kfJ
         nvW270Y/CmBTDd1nIBwgysZjtV03OJP4GTB4Q1jFdT3YPFnoD5X6j/IIQKRbwJg5ME/w
         EV5V2uQ5SMVd8pMyc7QgcGyAkAPBb5ngsronwG5bSAAUnCM1BKWSnDsqg/ptoiQPzCb0
         hOpg==
X-Forwarded-Encrypted: i=1; AJvYcCVT+EIOze7vapizG7p947sV6hCGAkNfUpnWkxlj8Xk5uL/ATAOkdVn0Q5oo+N13fVYQI8L9Bq3U/A/S9klwD3YDCV61yRqUG1X5h/Y/
X-Gm-Message-State: AOJu0YytiV5bOODeb+h0ZxwvGTADdYH264X0tM4yNQPkT0lAycWSRnRg
	7Jbr6vjQWtlZm1Nfaf5keMoG79E+xA9Y83DBdhPTFpoqMP2ETcPFxeeYoqHwNypdFlZscwXJlCn
	/jFikCWxP5dlcMQ5NcP7JwyJbKvtan67Vd7B8kEI77AGRRpEgZTQ9
X-Google-Smtp-Source: AGHT+IFwYxS7auFszuugbSbIB4CcRIE3idrY672qfSQWgDOy/uYcOQpSYqTSP+brkdQ5/14tFQ9yTa1KNQ31s5+dWZY=
X-Received: by 2002:a05:6402:2347:b0:57d:32ff:73ef with SMTP id
 4fb4d7f45d1cf-5b461564c15mr118681a12.6.1722336931423; Tue, 30 Jul 2024
 03:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725175714.1769080-1-patrykd@google.com> <ZqcQ3rjY6Wu4lU6t@google.com>
 <CAMxeMi3864MhJvaH16mw5hHKzYnoRWpZWnxJJuWm9bSKiTojWQ@mail.gmail.com>
 <ZqiCV_EXnJONOdyV@google.com> <CAMxeMi3VFN91FpGb3dgobz9aXt+Ok8rEqGkidwrGxNNk43O=6g@mail.gmail.com>
 <Zqi8_JeZJU0rGfEE@google.com>
In-Reply-To: <Zqi8_JeZJU0rGfEE@google.com>
From: Patryk Duda <patrykd@google.com>
Date: Tue, 30 Jul 2024 12:55:19 +0200
Message-ID: <CAMxeMi3AQJwpEkHaE9U+=dRjbaTfX+TRe1w8myEgSR3Z8GfnuQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Lock device when updating
 MKBP version
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Guenter Roeck <groeck@chromium.org>, Benson Leung <bleung@chromium.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 12:14=E2=80=AFPM Tzung-Bi Shih <tzungbi@kernel.org>=
 wrote:
>
> On Tue, Jul 30, 2024 at 10:05:16AM +0200, Patryk Duda wrote:
> > On Tue, Jul 30, 2024 at 8:04=E2=80=AFAM Tzung-Bi Shih <tzungbi@kernel.o=
rg> wrote:
> > > On Mon, Jul 29, 2024 at 01:57:09PM +0200, Patryk Duda wrote:
> > > > On Mon, Jul 29, 2024 at 5:47=E2=80=AFAM Tzung-Bi Shih <tzungbi@kern=
el.org> wrote:
> > > > > Also, the patch also needs an unlock at [1].
> > > > >
> > > > > [1]: https://elixir.bootlin.com/linux/v6.10/source/drivers/platfo=
rm/chrome/cros_ec_proto.c#L819
> > > >
> > > > Yeah. I'll fix it in v2
> > >
> > > I'm wondering if it's simpler to just lock and unlock around calling
> > > cros_ec_get_host_command_version_mask().  What do you think?
> > >
> > Initially, I thought it would be good to keep ec_dev->mkbp_event_suppor=
ted
> > update under the mutex (similar to cros_ec_query_all() which is called =
with
> > locked mutex), but mkbp_event_supported is also used without locked mut=
ex.
> >
> > I don't see any obvious risks with updating the MKBP version outside mu=
tex.
> > Do you want me to change it?
>
> Yes.
Fixed in v3: https://lore.kernel.org/lkml/20240730104425.607083-1-patrykd@g=
oogle.com

