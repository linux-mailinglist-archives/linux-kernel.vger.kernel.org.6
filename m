Return-Path: <linux-kernel+bounces-200565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA0B8FB1C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 14:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925421C21D45
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 12:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A259F145FEF;
	Tue,  4 Jun 2024 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="XHYImMbj"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D78F145B37
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717502719; cv=none; b=jzJ6h0wr4b4aZxgD28X6ltsoVyfKMMGpdlXIj8ERZDnHG/tOA6keg9qAtpEFRul4X1W5a7+OIqkMsQ3JV40I0fgwtfXzNZWNw2tsk/Yt0XTR4rkhjvgpfra0qcMWD7MdvjCX4dK47Z00dvkt26TOkdemHZ9uY3oQHMp04jvKsbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717502719; c=relaxed/simple;
	bh=MOyQAL00DQbewIwP6Y+mCobyLlekb9+Spe1Ge7zuYzk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KZ97BwbTiC+UP7p585vcTJmS3ep6mu2eCqLZazmK3bqhtWWpNjzP2EXZ5XtG4f/8dlbMBIn1+w3zX/I8N0r+Vs9W4TZv4VV7eyLOw5voY1AbkWHOOce4i7nwYDNlmsbqPFqxSHJOp+nCD/l0to/NtpuNIdV+AY0Xnbo26aGnHQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=XHYImMbj; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-52b8b638437so1035219e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 05:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1717502716; x=1718107516; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MOyQAL00DQbewIwP6Y+mCobyLlekb9+Spe1Ge7zuYzk=;
        b=XHYImMbj4ouv7V5vvec3EXVFkttWXzBlbS/atNzKu02SCJrRrm4q9+xdH7DXJ1aQc8
         zEq11sxVRRq5bLhtBzKL6JFb6HDu4GtomlvhTWuvBN7u7At6vq+pIiikXcfB3fSqEUiC
         niSFxTMF4lBDorBPu70UYsVAmdjdeivk7RWL9kl4byEQaqJf5pemW9dyvAK5XIKgkTu+
         B4TWXDsaVkZ45WjpGve8UpHIq5HA3ZIO60IY952NF3YsvDhaK/JYugPQlgKvyuiLVCq+
         9TsNg/SJ+VX6aPhZO5cNu75qaQRYyr9EAA32Udx3CIu83Mkkfe+CYeDPQ+TWfASY7qMz
         X+Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717502716; x=1718107516;
        h=mime-version:user-agent:organization:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MOyQAL00DQbewIwP6Y+mCobyLlekb9+Spe1Ge7zuYzk=;
        b=lvg4AruJHp+QU6bdqHF9eCO2qQAVcqCAWO4JdZafUl0ke98cVOUT2iaU4P3pr/sl5o
         JLHKJrngM3oYf1H95fOXNtOBli1EWgz0Q5nmlixIhpl0Mb95Mbamtaj1pi4AhFC8riO7
         ZdEojrtKLTu9rEXqwlaomsw8Q8pfc0RqCn/ms1YeQbGr8Q8LPDwt1gwz38H5mc9jfHT0
         Blkd9HoGsMsSHMd6LU+kyIn/mhrKfSaIycdaWd9nU2OeJqYieHCsFkr3nxzzjXsQlJ3R
         GF4H3Q4DpTRMTbZxonGgq1kPrsKOA/iLkpxHKa534ZS3ddl7K+bYacXLglWoU4IKWDdt
         5zsw==
X-Forwarded-Encrypted: i=1; AJvYcCVvvDwmIEMhzvEsjBfsYgpaEVn0qliPoG/O1afgER0FIS9JeA+RlCm5vWm4jOoArnSrfECp1PoQnEImlQV5/RviGGe/jMOhvD1TbKjH
X-Gm-Message-State: AOJu0YyZTgksNFqVg+0FoPJTzVuL3XjDLQMmOi28bJ1IRasb7ojAqZZq
	YnEIQifr0MeVr1/yL/Q4maGfjPNcAGfys7jV1rltf//nyuBxosyZTLIyRaMaZ03kiTHOX/km0qu
	zK7ypcw==
X-Google-Smtp-Source: AGHT+IE15Da8bWxDfM9GIxKyHSgMSf5ainF3VIf4DVl0MrNW0ahXVkCer1e/PIjLzQ/hjiOMYFz4Mw==
X-Received: by 2002:a05:6512:511:b0:52b:8f70:fdc with SMTP id 2adb3069b0e04-52b8f7010f1mr5628805e87.57.1717502715881;
        Tue, 04 Jun 2024 05:05:15 -0700 (PDT)
Received: from [10.145.160.231] ([185.254.75.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c111esm11409577f8f.20.2024.06.04.05.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 05:05:15 -0700 (PDT)
Message-ID: <46cbe0a914065917ea1024636e864a1e2c982145.camel@9elements.com>
Subject: Re: [syzbot] [usb?] INFO: rcu detected stall in schedule_timeout (6)
From: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
To: syzbot <syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com>, 
 bp@alien8.de, dave.hansen@linux.intel.com, gregkh@linuxfoundation.org, 
 hpa@zytor.com, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 mingo@redhat.com, stern@rowland.harvard.edu,
 syzkaller-bugs@googlegroups.com,  tglx@linutronix.de, x86@kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcello Sylvester
 Bauer <marcello.bauer@9elements.com>, Matthias Stoeckl
 <matthias.stoeckl@secunet.com>,  Uwe Kleine-Koenig
 <u.kleine-koenig@pengutronix.de>
Date: Tue, 04 Jun 2024 14:05:12 +0200
In-Reply-To: <000000000000f8112e0618995e6e@google.com>
References: <000000000000f8112e0618995e6e@google.com>
Autocrypt: addr=marcello.bauer@9elements.com; prefer-encrypt=mutual;
 keydata=mQINBGK7F80BEADSHaaAN0rjEV14KhMbMkvdiL2CcDhSYTnoupp0ena53nqP/kbsIUsbJ
 fBDHGl9x6oMagomx5rFAfUmuN3ruBam1qRXA7e3Ej1raPN2lIJxnXrlniMUiurEUkKJO5PGV3g6mN
 D4VoPsIuiv/QNUu42DA/JG4BVJ8OPB5oo6xR5NB9/h6DC3wyEUHWaMnAHBxknsrDmNKuhjcotUA9T
 VHHoZbe4//LATLOFLYe1YCV56zQTEsxq6jYdTA6Mah02e61BSODDL3iliIRzP9QngBFyy+kcQJSx1
 aBflX79COBJoQY7OGtzNwuSzHyiUPakQaAiHZXbKNFcPpVtZpGCcHA4JzcjDVVCzwRy+F6uwGaq/t
 ZpZJPGFgZpiv+yL29jkCev1HhcLf+O5dCH+WP/4oibuVPxegLUrDVvvdKD8W0NzzvV7PPd+5sdL//
 g8BvbE5WV89+brQejANQNhJCg1dH97M8xhsNF3RptObcYNKW7QRB2uNtkKKrnpUOGwd5qdej//AE4
 sSDzM0uOlkwMaIjZX9LlUyws3JpwRZf+0K0cFb0EmxH2buozgzf1U0aTAVC2befD6keeUjPIsI2g5
 48FLnjjktW+qfWnA+T5Vyc55mmLUm8hTsPEVbG24c6nictPtSJAs7FXmYCEnWtBycIGuJBqTzVlEN
 amFZhbV2LK8kwARAQABtDdNYXJjZWxsbyBTeWx2ZXN0ZXIgQmF1ZXIgPG1hcmNlbGxvLmJhdWVyQD
 llbGVtZW50cy5jb20+iQJMBBMBCgA2FiEENLJ+A4AXWnw+hZ4h5UtmIqXtv2EFAmK7F80CGwEECwk
 IBwQVCgkIBRYCAwEAAh4BAheAAAoJEOVLZiKl7b9hgsIQAKa0kfiJGnwusB86WSnd/sHrq1ctlcYf
 kmPZglEFLpEjwWD5gle0vpEn6tI6UuZN8T7Z1Td0T4zsg3TUR4QQXUHMh7tn2T1/5NvlmgaEiW3WV
 Yqruwhxao5uQsFRzVWFuqi3EUd2C1bOCP3rgj3Akds0CnWa5XZV4KYumXqPfd14rowjxZVVnL5KgL
 6is74TyVqYls6u0XhgdGfsNuPkJGMaV20Mr+0HjZAaZ26qnYP/u/5FkSLkO9UYEss4pxLUL1YawjN
 ZDqLU8gtBrsXq6yboPkKUQhAV9HxcDJeULkpduA5NRUFWUDAHyjtSBnM1GWAC71ThNXytEA3yRl7D
 grr+tvuBsvjE/8sv5cAE9lfrBUFIDBJG+5bTqdoiXd4NdgWilZFxo8jlI8MX4SBSKBlrCt8e5qMcq
 mhwRSCvhxvYOG3n+GkebAwoer9XounfyH+D4bg3iSn3qeIJeoO6ztMOjAOERuVmMmvFyuJvRbVYkf
 +5gs+0nrNubgnZwUgh+zUyVdAnOvHl59DV+PgKYsZGeZ7CZYeC/p2QRRiOnnNcOsI3TrZ0271xGZX
 CMl+HOTJQntnBSGA0GB37JFEAD2I5GEbDoD8+YB9TuLkljo+lSc/akyEtBehnQlb0NI5k43EewHct
 fCK+pxTJOzKllE/DAKY8WerzK+e+uF2jy4uK
Organization: 9elements GmbH
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-pocnCbCCxbuvFQrhJfCH"
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-pocnCbCCxbuvFQrhJfCH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Greetings,

I'm currently investigating this regression to properly fix it. My
patch only replaces the corresponding timer API calls without actually
changing the code. I'm trying to get it to work properly with the
hrtimer API.

Any hints on how to accomplish this are welcome.

Thanks
Marcello

On Thu, 2024-05-16 at 15:01 -0700, syzbot wrote:
> syzbot has bisected this issue to:
>=20
> commit a7f3813e589fd8e2834720829a47b5eb914a9afe
> Author: Marcello Sylvester Bauer <sylv@sylv.io>
> Date:=C2=A0=C2=A0 Thu Apr 11 14:51:28 2024 +0000
>=20
> =C2=A0=C2=A0=C2=A0 usb: gadget: dummy_hcd: Switch to hrtimer transfer sch=
eduler
>=20
> bisection log:=C2=A0
> https://syzkaller.appspot.com/x/bisect.txt?x=3D119318d0980000
> start commit:=C2=A0=C2=A0 75fa778d74b7 Add linux-next specific files for
> 20240510
> git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-next
> final oops:=C2=A0=C2=A0=C2=A0=C2=A0
> https://syzkaller.appspot.com/x/report.txt?x=3D139318d0980000
> console output:
> https://syzkaller.appspot.com/x/log.txt?x=3D159318d0980000
> kernel config:=C2=A0
> https://syzkaller.appspot.com/x/.config?x=3Dccdd3ebd6715749a
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3Dc793a7eca38803212c61
> syz repro:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> https://syzkaller.appspot.com/x/repro.syz?x=3D16dcd598980000
> C reproducer:=C2=A0=C2=A0
> https://syzkaller.appspot.com/x/repro.c?x=3D151d9c78980000
>=20
> Reported-by: syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com
> Fixes: a7f3813e589f ("usb: gadget: dummy_hcd: Switch to hrtimer
> transfer scheduler")
>=20
> For information about bisection process see:
> https://goo.gl/tpsmEJ#bisection


--=-pocnCbCCxbuvFQrhJfCH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJRBAABCAA7FiEEB0muAN3elg6p6gWSpVqlh6ibFBIFAmZfAvgdHG1hcmNlbGxv
LmJhdWVyQDllbGVtZW50cy5jb20ACgkQpVqlh6ibFBLg+w/+PL3EXBwABpCCHRzk
PPxX0B6cNcomoUVG4qy7t36A+BDOGjQ/4gpxE9r1UAhQdbD0DbCle5cnsCseJASl
3EckgDIFzc3Bw77J9Lqk2HOMTfYDGl6HSVHmJ5u2uPxv/5vJ5mm8o+m7y/EFAl6s
BnVQrK0IsjGXpY8Ez0hoVOEJACtuNw6g6rg0KH3BlbUm3yj6dViruA7Jbmiimg2A
st+n0KND5Z6jYhHsF+XSWXQnUjh8w7WCCwxMKWNgMFsxXNbUqWVkjqiPdBEqc5Un
3/7Ys4MDoZZX+YTzMdh8aHqEfR/RdPHie3v/5L25rvaJGl5m9XsIjP0BUPerFblB
qWHDPK+rfFmPDiVjr8iORhTE2cjLqXQl+V16F2piVnSwT6uwM7abJ91VUK8Yt6sM
SIBq4XkFaJvSnmRqZSv22FRuBg0iDvTMBvlxeq5QKV7RM3GH1UleqmIJOZBmX6Pb
F4n8VY+KgRBhnaELDpqroJYD+kZ/dmZbaNxhxMCv0J9GomL421OufH7U4w3rR8To
2j1Az2r1Ebe53UjZcE8EZloBkFtDbAZapkrFHP9QS0QdZmft+71iMIK8C8Cyd0Bp
exsTiuSnUSLwGq9tTPumUog+73UOmujnoqEWuMxa17m/5UFaVFhDIs0ONKSayBLI
8s9XzpTN4Ub2UkK2WmJGXi8YMm4=
=NxWp
-----END PGP SIGNATURE-----

--=-pocnCbCCxbuvFQrhJfCH--

