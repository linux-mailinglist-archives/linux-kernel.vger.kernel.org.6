Return-Path: <linux-kernel+bounces-225824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20A69135C2
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 21:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39C61C21089
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 19:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9A83F9ED;
	Sat, 22 Jun 2024 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="NeK3mTs1"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF54717BD9;
	Sat, 22 Jun 2024 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719082831; cv=none; b=d5RaHMI2N2tU+XYNB0PvnYFkKzf0eb0iLPI0Mp4dajBOV/IssimzOTwK+q9avdSr/aX4qC/dCXIGT6aOj6prIok1CIhaqGeHHTZwwJNPuJuwYp6N0LrutSKMRNWDUOMEEuzAed2czkh9INCkoG0pb8bECpPhTqNx8QgixKZbGJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719082831; c=relaxed/simple;
	bh=Jzv0/Wz5JQ9TZ///bIDGcWuO9vF0bg91xvMB0LraRAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BfedcXCibDnRvEpzv4brTEnEkqHDiYvF7bZHr6KoNFRNeZHL2+3v975zEEg2/mizigWBgEqAACH8lUIOJfKmHissJeF1CgOTDHCq5QiCF5MLmv0Bz4afd4hnpn9UbwS1eTWx4+NilfwpH9RctItXXR1KSlHYBCK2eH9zZYDAQlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=NeK3mTs1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f47f07acd3so25696315ad.0;
        Sat, 22 Jun 2024 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1719082829; x=1719687629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jzv0/Wz5JQ9TZ///bIDGcWuO9vF0bg91xvMB0LraRAc=;
        b=NeK3mTs1aI1uSoorvafseeb5tZ5ztU2TUWBjMw1mx5WSZsFRrsJ016CKnGSvJwxLtT
         2oNlUHzctg3WMaM93YWgJ+oT8twWCWWJhq6Sz3R/tDaKrHmwzHXz+Bgtc/XpgpY68hZ4
         /hGaGGqA+O/v775nubq3Q0VoimO6ry/eqMjadJ0jBoaYJdFpbYkalTrQA4AWftwghSP5
         aG5sYlYkyvh30EMtXTxAYf13k3EItWSDwP7SOWs275RiRRo/3bnLQRUChSeIzmDGLNvm
         0vW6uRB70+TughjTIea25cFNKNb+cTAV6XY9VtWepuBdNDrHpoHkCUWOWPpOenRoPzeC
         tQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719082829; x=1719687629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jzv0/Wz5JQ9TZ///bIDGcWuO9vF0bg91xvMB0LraRAc=;
        b=tCUg2LpZoij4ilQ1IPFRRU7DVC6bHFsiCWncNFFJHe3EDwiJkvrONy2Hl2Y9Y3eie+
         MKE8HpF5RDJzv+g2CMRXK2dwYBx/7o6OwYUQRov+DYaXReZU0S3I5Hiy3Xysq3QkgokF
         k9AX35qdJoF3d/snzNwbvf0m8isXtm52UCGg4svmwIrnTzfntNd5ltuBwSl3v4Cq7ibl
         kftq3zvRI18DM4TtmT6tF9EPAQiQCUJfQ7mzOP2Y8IIq5FJ9OwcOp/TzlIsO0nNj2u4F
         pBajdAqQec/5zWuWGxLPC/m6h/pGmRAIVRdnWmxTxS9i/Eg9ZVudKVMTfArixPCH924Y
         Mn6g==
X-Forwarded-Encrypted: i=1; AJvYcCUwmXLaOjhmUbRdBoY7A0CHETruZSbMF5vRAqkQpIqa491FFnd0pNhKHVAtP5VAi58JMjlCaFDIMJXZ7h+G+jkGAIdz8hA/kpzCw/HFg6DOz6H/gn3jWx9sOcu/rD2lZPVbP1HCA8IH
X-Gm-Message-State: AOJu0Ywh8SZVLaJ3oDlbv3LIJKgbDjK3CJCbzWHHk0eNy8v5cdVRrZWJ
	3a3H38Sg1ni7y9ddtYOge3/tpFbFz901AbJRvdroGzbL8xCfRdDw1HmwAun39DEjhm+6rGLExiM
	BucZuUMZkPE164lPG6GgaOBraVbFdFA==
X-Google-Smtp-Source: AGHT+IFuSCy9jhe6LZG/UOLv7mToAkkSDK8bSG1QPp68NQt/k8OjtuXhSEhsjcloI7rLySiidT7m5XouBTLO9thR1jE=
X-Received: by 2002:a17:903:1cf:b0:1fa:feb:c835 with SMTP id
 d9443c01a7336-1fa1d3de5c7mr14078745ad.7.1719082828933; Sat, 22 Jun 2024
 12:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507131522.3546113-1-clabbe@baylibre.com> <20240507131522.3546113-2-clabbe@baylibre.com>
 <A4B2BDF4-263F-4879-A0C3-399D8A1BF3FE@aparcar.org>
In-Reply-To: <A4B2BDF4-263F-4879-A0C3-399D8A1BF3FE@aparcar.org>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 22 Jun 2024 21:00:17 +0200
Message-ID: <CAFBinCBwCCKUS1k0Qb0GttucF3_Nn6CJUTe090RV5AD4CDM-NQ@mail.gmail.com>
Subject: Re: [PATCH 1/1 v7] usb: serial: add support for CH348
To: Paul Spooren <mail@aparcar.org>, johan@kernel.org
Cc: Corentin Labbe <clabbe@baylibre.com>, gregkh@linuxfoundation.org, 
	linux-kernel <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org, david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul, Hi Johan,

On Wed, Jun 19, 2024 at 3:35=E2=80=AFPM Paul Spooren <mail@aparcar.org> wro=
te:
> > On 7. May 2024, at 15:15, Corentin Labbe <clabbe@baylibre.com> wrote:
> >
> > The CH348 is an USB octo port serial adapter.
> > The device multiplexes all 8 ports in the same pair of Bulk endpoints.
> > Since there is no public datasheet, unfortunately it remains some magic=
 values
> >
> > Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> Tested-by: Paul Spooren <mail@aparcar.org <mailto:mail@aparcar.org>>
Thanks Paul!
Johan, is the Tested-by something that you can fix up while applying?

Speaking of applying this patch, it would be great to have it queued
for Linux 6.11.
If you have any questions or review comments then please let Corentin
and me know.


Best regards,
Martin

