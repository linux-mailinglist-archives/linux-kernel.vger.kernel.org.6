Return-Path: <linux-kernel+bounces-234445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 274A591C6BD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 21:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56E1A1C2110C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 19:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA42C76410;
	Fri, 28 Jun 2024 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UnSPCGS+"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6E674077;
	Fri, 28 Jun 2024 19:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719603458; cv=none; b=BGhQQzGMKFSmT4qZf3x71+dqes3dg+pnY8H/ZH89gFDDcWLiYgsWArMkvLYtQB1bv0eJfTPGrKewdhVR48iMrYbhaUYXJpcmKlChMsTGIQD5tmTXpn+02eG7YkkJ60sGDvycMIrgWNfM+Zuc52ecvAfsLNcRarL5RVBxeXaU3TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719603458; c=relaxed/simple;
	bh=AGpCS8hQZ138VVZpeiyGcB/4CY4Qk1mQJKl2GkSTaHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ffxLStKzE9046W+uKxJTb6vRQCm3xiiIo98smvDQ9GKZuQAkbKh8sT2BU27ZtV6+6ZsqHFl9uJccNjRed8bgzJ+3l9D3BnQXv2kRJyD35pW5dRtGl0QhTJcVnXJRIpAjgduAK/xe1+w2bIzOH1AqYFS5TB9E04U4Ds39fARO5kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UnSPCGS+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1f4a5344ec7so7775715ad.1;
        Fri, 28 Jun 2024 12:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1719603456; x=1720208256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AGpCS8hQZ138VVZpeiyGcB/4CY4Qk1mQJKl2GkSTaHs=;
        b=UnSPCGS+zYIT4QjM+Ph1l1cmigJzLQ7cuIaWFC+6KZNydVjyiA1M6QAlfRJRF20Sef
         XBXcEsn1XdYyb6DQ8lgoClvZKlXwNBLrTwemexUFcTsjIhtHtPBezfwhaiGRHZPz07C+
         jRnxzdEYl3dGG4HpUT1p4oCpjlW+7P3Uo6CtjnAJ8q1i/fNyqlwm68pcvNKmtxmAxhHM
         x+KfP+aK+ZhfDwn1zTx3TxAcxa5PN7fmQC1RmaIVKHPSIntnEz3GOQmIBya618hv+AHk
         Y09octkUjZFye9jJANeeY7C1cFzD8VMu8H+v6FbQvIOUL3BgSUHXy9CXg7ST1YcsdN+f
         T17Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719603456; x=1720208256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AGpCS8hQZ138VVZpeiyGcB/4CY4Qk1mQJKl2GkSTaHs=;
        b=JB0/tZGO2q6t7b/5R+SY/oNzS6FEVqPmzEjccVlWDpZvnaF6rrFFDM1Vgwuwo6aj54
         piDRCYQ00qN1DnydEGC4Sgdmn9i/6KMJM0QrM+HEMbxehgNoakR4To9nZjyxGekLQP44
         V3AEQm/KKl5vqNkgG0CMxGpSSb0FkEK5OBZ7QDug9oOTSIdTlpOKQKtmxyKq4U4+jTTg
         nAL4NhRjvLGBa4TnQyhEjW/tfKJgq7TUQpVt6Yut1ucnm0o7iqh4zZiszZEtC8mw4ENf
         b7ruCx92+H5OEAmMsJnvnUV1XpCEWBoVAhCs9qWhLTrAMRrYF3+tyrUP+R+ltU+EdZQd
         61YQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWdOzqd+ybowVnTplW2kWdFHuZH9KKYA9/ndgNh3HWKZ/hym/XhQJXS2Puctjmey4UyVCJjTEsGuJYXFlzp0QqlOJ9FKdRdknuW+tUYlcEnH9n1QLf8os7ZBXOf9FSoP2AKlgzMek3
X-Gm-Message-State: AOJu0YwpdA7L+oqglw+xdOo+yA0yNuWTSgL1bm8mkS4/DTbmgfNUtZom
	o48CTXJZBtw+JIinfAMjatWWVJ1fg8TB1rghVWhQeR7UzwEugq7MFuVg2hJ63FcE6Ar/kCRfQRe
	0ld6QwxkjVl7ulMHBuTzFlMPv1jQ=
X-Google-Smtp-Source: AGHT+IHHfMbbbqoHw7krBAVZH5xIrK1wStJic0o14Qv3VVkQCXlhqzmOi6B3o/2GgWrCH6yfMZoswawJg5W20oOAKY8=
X-Received: by 2002:a17:902:c94a:b0:1fa:2b11:657d with SMTP id
 d9443c01a7336-1fac7ea493cmr32184185ad.10.1719603455826; Fri, 28 Jun 2024
 12:37:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507131522.3546113-1-clabbe@baylibre.com> <20240507131522.3546113-2-clabbe@baylibre.com>
 <A4B2BDF4-263F-4879-A0C3-399D8A1BF3FE@aparcar.org> <CAFBinCBwCCKUS1k0Qb0GttucF3_Nn6CJUTe090RV5AD4CDM-NQ@mail.gmail.com>
 <Zn0RaATKGAn2Ja3b@hovoldconsulting.com>
In-Reply-To: <Zn0RaATKGAn2Ja3b@hovoldconsulting.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Fri, 28 Jun 2024 21:37:24 +0200
Message-ID: <CAFBinCCgBtMi6CaRUT41y5MO-EHNM12R1UOGizkB-Ka99O3AaQ@mail.gmail.com>
Subject: Re: [PATCH 1/1 v7] usb: serial: add support for CH348
To: Johan Hovold <johan@kernel.org>
Cc: Paul Spooren <mail@aparcar.org>, Corentin Labbe <clabbe@baylibre.com>, gregkh@linuxfoundation.org, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org, david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 9:14=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Sat, Jun 22, 2024 at 09:00:17PM +0200, Martin Blumenstingl wrote:
> > On Wed, Jun 19, 2024 at 3:35=E2=80=AFPM Paul Spooren <mail@aparcar.org>=
 wrote:
> > > > On 7. May 2024, at 15:15, Corentin Labbe <clabbe@baylibre.com> wrot=
e:
> > > >
> > > > The CH348 is an USB octo port serial adapter.
> > > > The device multiplexes all 8 ports in the same pair of Bulk endpoin=
ts.
> > > > Since there is no public datasheet, unfortunately it remains some m=
agic values
> > > >
> > > > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> > > Tested-by: Paul Spooren <mail@aparcar.org <mailto:mail@aparcar.org>>
>
> > Thanks Paul!
> > Johan, is the Tested-by something that you can fix up while applying?
>
> Sure.
Great, thank you!

> > Speaking of applying this patch, it would be great to have it queued
> > for Linux 6.11.
> > If you have any questions or review comments then please let Corentin
> > and me know.
>
> If you think the outstanding issues have been addressed now then I'll
> find some time to review it again.
The issue reported originally by Nicolas and then confirmed by
Corentin in [0] is indeed fixed with this v7.
I am not aware of any other functional issues.

There's additional features that the hardware supports which the
driver doesn't yet - for example modem control.
Those features can be implemented later - as necessary.


Best regards,
Martin


[0] https://lore.kernel.org/lkml/ZVtRNZmCMImCT9sN@Red/

