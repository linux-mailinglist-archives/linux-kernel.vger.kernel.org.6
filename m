Return-Path: <linux-kernel+bounces-266734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9F7940609
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 05:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E15BB21B2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 03:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9235B14F9FF;
	Tue, 30 Jul 2024 03:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWcOfx6z"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE781487D8;
	Tue, 30 Jul 2024 03:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722311039; cv=none; b=q+IngZ/gv/RWNfLsu4FjQQYaM4DXmRl0r9kEcVnQ6Jrs3GCuRqj6xnpe0ARVc9hbpXEgMjbhuGissNoaKCnr/GtnOZM/tothWWwqUV5XA3yn7iTEU7ajAcwlVGLya118je1yRl7s32FPrVQGWj+5IVo3T+0b/cbZ+QtefjVpkng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722311039; c=relaxed/simple;
	bh=47oS6MdN1hRTkoPWB3nS98Zx5hlaXi7nZdTSHAgoyGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZV9py5AS1biKA2jt6GaxKOytk/Iw5GMp5VoF09XxUu5+oOaHZiqFAutFNtcUXUth+d412h6bn1z/Jc1wC2foZKgfmPCPH0DKYjYPXIhZ4mTmulkep+p4UELCCzm4r0p2MVIULM39bU8ScueMhvtF2d8bJSgPY8mcv2ReqMkSl4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWcOfx6z; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5c661e75ff6so2910880eaf.2;
        Mon, 29 Jul 2024 20:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722311037; x=1722915837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFVzFJaWTT6rGSUz8cSHkWG338V0aMzObcR7mTsL7Jw=;
        b=YWcOfx6zVQb9ZV2aWrXTh6mQbgO/ytKbjhqO3m9yXl+bQ0fqTuzv6xSvVt8GVMYzXV
         Z2whuh5mV+7TRawg67oo2X2R/HVTVytlf1qBicpmzD8KQio/eYMxKftPMEWdmaSZbYkp
         9Px7bp+YFjIKscLq9oBr0nSpV/a98A5tqeoLxsZ9gAJWTrh7qrqlpGKOcioU/PBsi58U
         qmTmbPsKR2fwG/PL50P6+pjIXbi0drGvqJjXi0/PIzUscg6FLYo3rQc42EYU61yjP6ZM
         YRo5gQpqY/nN+UrPJ+qbdefz12UqRR9hOlsp3I6AdQx3oJKpQy/CqMMnBY/bkQrJow1K
         5f1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722311037; x=1722915837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFVzFJaWTT6rGSUz8cSHkWG338V0aMzObcR7mTsL7Jw=;
        b=nuoECpLU0NlqFPSdITDC0/pWBswnrVXgWNh2++z2j7htaFgKP8why6VjuIbShUS3G+
         msZY2HqBr5nD06CQe3HKchJzJWDTn1NqGhMAkjXuRrxejq5M6TuTzQMO74MPMGqH6Xnn
         zYd+PaCRxolZku5ZxduJQvuhT3HacRTfYrVAb3uxIZJDH3yJLpDL5ifJTTZtg7OvAQxB
         kV7Ozj0WCPbFRBIFlR5JVvzM/knK1WIDcJzXj/pFC3zJ6GqP64HuKbIpYFMcrIbYXW1X
         t0zhbhYEjse3K3qkgiHL+75oAfIf6upnarTc5vbjE/YTGM+Iy2pxQcq1+9PpYe1bYrSF
         cMhg==
X-Forwarded-Encrypted: i=1; AJvYcCVRBL55YtxnT8x+UpEG+8+XoybaXeaB/ZoaJ9INcawkaHzEeFAXR4AEkrhGWhK6Y9Ryw+EhoQzMzqIZdtvf8DR3yV/bxPnYSoUWQSd9jEcV46FFUQRVa2WoDCuIqHS1iIfS2YLQ/EHY
X-Gm-Message-State: AOJu0Yy3z38wj4FQbk8ACUy0++4LPJoTLXhZiA7B0YV81QEubvFvdpaP
	vFTpz8enUrfEo2r4za2s3aslOKYQDFSeEtIaYrQm1Giw6zi3r+dA3DdzqIctl7QXGO6gkJlR7vO
	qmgjbwRgzVzJ1fRfSnZv9DhL8uOg=
X-Google-Smtp-Source: AGHT+IHedkgYLg5L4/4Stt/4dTaPBSD8/b1plQKQGdpMSt9apgVXe1n2CWtfq6pwfo7wyZ0Wwv+6VNTURv7vtSyeT8g=
X-Received: by 2002:a05:6820:2292:b0:5c4:27f0:ae with SMTP id
 006d021491bc7-5d5d0d9ad9fmr11055250eaf.1.1722311037620; Mon, 29 Jul 2024
 20:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240719041400.3909775-1-dzm91@hust.edu.cn> <20240719041400.3909775-3-dzm91@hust.edu.cn>
 <87o76f98lr.fsf@trenco.lwn.net>
In-Reply-To: <87o76f98lr.fsf@trenco.lwn.net>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Tue, 30 Jul 2024 11:43:31 +0800
Message-ID: <CAD-N9QUi58tO61usRakxJUY063+=51FPSeXPvTaRXgMnOUR_2Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] doc-guide: add help documentation checktransupdate.rst
To: Jonathan Corbet <corbet@lwn.net>
Cc: Dongliang Mu <dzm91@hust.edu.cn>, chengziqiu@hust.edu.cn, Alex Shi <alexs@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 5:44=E2=80=AFAM Jonathan Corbet <corbet@lwn.net> wr=
ote:
>
> For future reference, a sequence like this:
>
> > +Then the output is something like:
> > +
> > +::
> > +
> > +    Documentation/dev-tools/kfence.rst
>
> Can be more concisely and legibly expressed as:
>
> > Then the output is something like::
> >
> >    (literal text here)
>
> More importantly, though, this file:
>
> > diff --git a/Documentation/doc-guide/checktransupdate.rst b/Documentati=
on/doc-guide/checktransupdate.rst
> > new file mode 100644
> > index 000000000000..dabbf9ecd187
> > --- /dev/null
> > +++ b/Documentation/doc-guide/checktransupdate.rst
> > @@ -0,0 +1,53 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Check translation update
> > +
> > +This script helps track the translation status of the documentation in
> > +different locales, i.e., whether the documentation is up-to-date with
> > +the English counterpart.
>
> ...lacks a title, so it renders strangely and inserts inscrutable stuff
> into the doc-guide index.  I have fixed this, but I am not entirely
> happy about that; this is a problem you should have seen immediately by
> looking at the rendered version of your new document.  *Please* be a bit
> more careful in the future.

Hi jon,

If I understand correctly, you mean there should be "=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D" under
the sentence "Check translate update". This would generate a title,
right?

Unfortunately, the "=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D" is asked to be deleted =
in the v2
patch. I doubted it, but did not make it back.

BTW, the merged commit version has the title - "How it works", other
than "Check translate update".

Please correct me if I make any misunderstanding.




>
> Both patches applied, anyway.
>
> jon
>

