Return-Path: <linux-kernel+bounces-227034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48C7914775
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 12:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2623DB23262
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 10:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB75136E0F;
	Mon, 24 Jun 2024 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="bgddOlzs"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7AA13210F
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 10:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719224735; cv=none; b=qmLuUyOyi6Pm8oy+Kf8UX0ciBG2QU5AwNHyqcxqGtQOBk4k29o5yJf8rQtpfDpYC8uHYF09vyVg48FHCajLSe7GyNHi+uV+YwsD7ohXtxINqx27j1/kLIGKT02ydLJ1ap5n0ogjRiT5MfJjWDPc4Nxhl3uiUVi4tOm2KvRWnOCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719224735; c=relaxed/simple;
	bh=AYY8f5Pb+Q6uUYjPDKSFZtBE63pV9QkM1RUKkIw1K50=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I7zDRRO3++2olbhwp6s6lYC0BT+sTqlwbpMuNGZLrskHLhbYlRYvIbEj9jEmG1p2iwGxaDDODVTDCKrYQcM+OIZiHzVLfMAoGABv4RsDf9Ez/weADS9xZo9wnMLoZdsLC/Qma6mTNE5ijmMbeOpkSX2C3f+SNCq8mVeLyhuKMW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=bgddOlzs; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ebeefb9a6eso45218521fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 03:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1719224730; x=1719829530; darn=vger.kernel.org;
        h=mime-version:user-agent:organization:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AYY8f5Pb+Q6uUYjPDKSFZtBE63pV9QkM1RUKkIw1K50=;
        b=bgddOlzsmTpnsp1ugw2FVz4T7TfyMrKamY3HW8sZw/mbZl10wL4YKIKt69GNfXJLmE
         LvYTD7y9W/MGKx5ILfG+0zManQe9yQ/SIdJ8dAGoYGDlaaXBxzIDTshFsmWLQk774Rqx
         6mLR/aubAPXaY42frbQGDBDhz8kJQOxAuL1nPXdDwrVG0MluSr9qJrGOi1u5gQCE1eSr
         bTv2alxrtNtvxJZq6WnUZGAemZRi7f0R1AzwF3MKL/zEVz2SNvY0ONlbHE62XGhN/CAK
         KrbiVoQJhHv10xQ2d5cnUN6TDdsfq2OIdW70fFoTJxhXGp68tVTLtR0OecV90nUtE91A
         RR9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719224730; x=1719829530;
        h=mime-version:user-agent:organization:autocrypt:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYY8f5Pb+Q6uUYjPDKSFZtBE63pV9QkM1RUKkIw1K50=;
        b=sWnWCInE/59bCQzYDw+k+n+i92ov6Aw1fUlRODWaUrPhHa1pFiW8xwSNQWs4Ii8sB3
         DNT5kvBZI+rBsIFwSKcCP2lAhVSeJmCmn8VIHlg6zWP0fnaE/MxFukZTFefQpsa2eOTR
         RWTmzV6ky1DAbuP4erQkBIzTv67Q0aHCBZ3w36JwVT4FsALHm1R48OmSKUOQ9KVzSC30
         kOOhCon/XtGDDWgLfXjDW/+r3ch3wcrdbCB4vPMkHBzEmOVDp04yoF6pJFiyVR1yFlxG
         9nSZ/Hlrbj1gKxgOYMcgQvXNhcoLY7rPYIO2gaffTAm14lGcTDkNQx9H29bpHeD5YAWC
         s8Xg==
X-Gm-Message-State: AOJu0Ywm8EvJUoLcQkzsk8EdPDe7LDwd+3T6lKyIA4RoLGgOaNIdBJ0N
	ponAYPP9LqjtFagNPAYZvFTsty5CRHBLLBPQw3lPElyDrb8artoUcJXLnvpu76Pborua/37U5TE
	/hFY=
X-Google-Smtp-Source: AGHT+IH/qVjuIY/I4Jjm3f1qaBXCttVWScuoLYnIdrVm4yXTYgFIFpXnYnst+QVw7mRx3Ippdp5UsA==
X-Received: by 2002:a05:6512:31c9:b0:52c:99c9:bef6 with SMTP id 2adb3069b0e04-52ce063e3bdmr3359793e87.7.1719224730056;
        Mon, 24 Jun 2024 03:25:30 -0700 (PDT)
Received: from [10.138.75.45] ([185.254.75.41])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42481910fc9sm128609395e9.33.2024.06.24.03.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 03:25:29 -0700 (PDT)
Message-ID: <0eee9b08bf1f1889b3455099a68f9eed7f71c50e.camel@9elements.com>
Subject: Needed help: dummy_hcd: Fix stalls/inconsistent_lock_state due to
 hrtimer migration
From: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, x86@kernel.org,
  syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com, 
 syzbot+5127feb52165f8ab165b@syzkaller.appspotmail.com,
 oe-lkp@lists.linux.dev,  bp@alien8.de, dave.hansen@linux.intel.com,
 syzkaller-bugs@googlegroups.com
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Uwe
 Kleine-Koenig <u.kleine-koenig@pengutronix.de>, gregkh@linuxfoundation.org,
 hpa@zytor.com,  mingo@redhat.com, stern@rowland.harvard.edu, Alan Stern
 <stern@rowland.harvard.edu>,  Matthias Stoeckl
 <matthias.stoeckl@secunet.com>
Date: Mon, 24 Jun 2024 12:25:27 +0200
In-Reply-To: <46cbe0a914065917ea1024636e864a1e2c982145.camel@9elements.com>
References: <000000000000f8112e0618995e6e@google.com>
	 <46cbe0a914065917ea1024636e864a1e2c982145.camel@9elements.com>
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
	protocol="application/pgp-signature"; boundary="=-VCflRuCyT7xBT33tKPGO"
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-VCflRuCyT7xBT33tKPGO
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,=20

I need some help evaluating and fixing a regression due to migration to
hztimer scheduler in dummy_hcd.

About two months ago I was investigating poor performance for the mass
storage gadget (g_mass_storage) due to slow timings in the loopback hcd
driver (dummy_hcd). One of the reasons was that dummy_hcd used the old
timer API, where the interval is tied to the internal kernel timer
frequency. So I submitted the patch to migrate to the hrtimer API[^1],
which was quickly approved.

Since then, syzbot[^2][^3] and intel's kernel test bot[^4] are
detecting rcu stalls/inconsistent_lock_state due to my patch, and I'm
trying to figure out how to fix it.

Both bots indicate that the problem is around the usb_hcd_giveback_urb
function call and it's locking mechanism.=20

My patch just replaces the timer API calls without changing anything
else in the code, so I'm not sure if my patch is actually the root
cause here. And following the instructions to reproduce syzbot
regressions[^5] even with the provided assets (bzImage, disk image,
repro.c) it is quite inconsistent to cause this stall. I have also
tried to follow Alex Stern's advice, but have not been able to cause a
stall manually.

So I don't know what to do next. Can someone with more expertise in
timers look into this?
Any hints or help in investigating or fixing this regression would be
greatly appreciated.

Thanks
Marcello

[1]:
https://lore.kernel.org/all/57a1c2180ff74661600e010c234d1dbaba1d0d46.171284=
3963.git.sylv@sylv.io/
[2]:
https://syzkaller.appspot.com/bug?id=3De2befc3f5c24e08345751880365468ef18fd=
8dc5
[3]: https://syzkaller.appspot.com/bug?extid=3D5127feb52165f8ab165b
[4]:
https://lore.kernel.org/oe-lkp/202406141323.413a90d2-lkp@intel.com/
[5]:
https://github.com/google/syzkaller/blob/master/docs/syzbot_assets.md

On Tue, 2024-06-04 at 14:05 +0200, Marcello Sylvester Bauer wrote:
> Greetings,
>=20
> I'm currently investigating this regression to properly fix it. My
> patch only replaces the corresponding timer API calls without
> actually
> changing the code. I'm trying to get it to work properly with the
> hrtimer API.
>=20
> Any hints on how to accomplish this are welcome.
>=20
> Thanks
> Marcello
>=20
> On Thu, 2024-05-16 at 15:01 -0700, syzbot wrote:
> > syzbot has bisected this issue to:
> >=20
> > commit a7f3813e589fd8e2834720829a47b5eb914a9afe
> > Author: Marcello Sylvester Bauer <sylv@sylv.io>
> > Date:=C2=A0=C2=A0 Thu Apr 11 14:51:28 2024 +0000
> >=20
> > =C2=A0=C2=A0=C2=A0 usb: gadget: dummy_hcd: Switch to hrtimer transfer s=
cheduler
> >=20
> > bisection log:=C2=A0
> > https://syzkaller.appspot.com/x/bisect.txt?x=3D119318d0980000
> > start commit:=C2=A0=C2=A0 75fa778d74b7 Add linux-next specific files fo=
r
> > 20240510
> > git tree:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 linux-next
> > final oops:=C2=A0=C2=A0=C2=A0=C2=A0
> > https://syzkaller.appspot.com/x/report.txt?x=3D139318d0980000
> > console output:
> > https://syzkaller.appspot.com/x/log.txt?x=3D159318d0980000
> > kernel config:=C2=A0
> > https://syzkaller.appspot.com/x/.config?x=3Dccdd3ebd6715749a
> > dashboard link:
> > https://syzkaller.appspot.com/bug?extid=3Dc793a7eca38803212c61
> > syz repro:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > https://syzkaller.appspot.com/x/repro.syz?x=3D16dcd598980000
> > C reproducer:=C2=A0=C2=A0
> > https://syzkaller.appspot.com/x/repro.c?x=3D151d9c78980000
> >=20
> > Reported-by: syzbot+c793a7eca38803212c61@syzkaller.appspotmail.com
> > Fixes: a7f3813e589f ("usb: gadget: dummy_hcd: Switch to hrtimer
> > transfer scheduler")
> >=20
> > For information about bisection process see:
> > https://goo.gl/tpsmEJ#bisection
>=20


--=-VCflRuCyT7xBT33tKPGO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQJRBAABCAA7FiEEB0muAN3elg6p6gWSpVqlh6ibFBIFAmZ5SZcdHG1hcmNlbGxv
LmJhdWVyQDllbGVtZW50cy5jb20ACgkQpVqlh6ibFBLf8g//Tmi/GCF7eqQyrzal
hzPFcn7r+LUVoSCWZaAH2+TCx80b7DgZGedkDNM65KdVFVkHq7LYNORMKKJeVC9z
saQTKLFs5l21sYMihla2ugjis/grUgPa5ep6CXxSEqHqBOjoBYBXdmoJ5jflyUlG
o/GxfHoeaTQo16tOGTCkyALIL1nhh0QaQWZCtAO4Peb1fFkUxesUifiCJrRRB79T
Zq4kdaMIIpRp8vdlaLNp1hN1/giHVtZGtKXsmMZTWQsiu0hBg/0H+xnN534zOq9x
DABuxgqq9y2PB+0LpB1jITbpCRBsKmrPqOycKlDgCx+XXFLHi7bm9/hVQHD8rsRn
53WXF8AXMMbG/0Ea+zCCKDV48FjL2/OIgH5mq5Xh2PHlrHuqNbgUAsfXCoe1PNvX
Leaq/oY2E6FgWOHwMe1TAmJFYFOeR/i8MnB39OZBcJ+2jTGydwYK7mrY57PJAtxr
qHl3bV12LEHAZn1qyJnQtCYU5Npj3uXoxYI32sAAZ6uaKj+UUFsOPUtGXOOBouBQ
xVaOD15+KMzOwXQWZn9fWfPOJZ+JIou98Vkosd2nQKaBWoRub+HxTLVCZKKOQjjL
WWMR05lrGxgcoLuTZU9B4KG8DugTFv0lpHoEbVuL3pHpFkm8zZIszcFJzwqFYd7s
QdrPrNr5b3SdRKaV2O6wj/VY0ao=
=rdQr
-----END PGP SIGNATURE-----

--=-VCflRuCyT7xBT33tKPGO--

