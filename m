Return-Path: <linux-kernel+bounces-526568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF6BA40065
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96D8C4233F0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0732C25333E;
	Fri, 21 Feb 2025 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2+qfeAq"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4C91FF7CC;
	Fri, 21 Feb 2025 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740168452; cv=none; b=sLdzZBvL+M3PWdLZBBHV6tsmXmjKV3xh3wn7XTY+7WM0ObLVe53bTzR6FY1MibdbogW4qgkbrr+GPxz/5wwoXDKv8LHlPB2bennvp/H8bNUtqdZvxiQRZNSEq5CQC8NamLcidhO5HtLXhH5Awa28CSWDM2pCGShXq4jqfM8hkYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740168452; c=relaxed/simple;
	bh=J8i3DZmAPGrWlElVvpG1UCxEbqCR2ykVCXYwjltceaQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MTqD8BDHO5n4F+vCqmd7bChCWIuKNOjC4GHwz4o7nKnL6QM7wlt15hfGgFJM7m5BWJ2PoR5yxsvwVXrN1lnSa+xcGErB+wUE+bKmqGFEfqf/YbvMrK3tPI/YMDODIB+bSDHg9bhEOhS3IZFeWUQmAJzvGiqHQCQU3KbJYE6K9os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2+qfeAq; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-220c2a87378so44837745ad.1;
        Fri, 21 Feb 2025 12:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740168450; x=1740773250; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RB1lR+aB2DFBicW90ROYujqbV0AEbnFQJOUJctGhXRI=;
        b=B2+qfeAqD1z6KOnQTUb1NgnQRJRn74wGvwDU60HUYjfNDtpUzo5r3yRKI7gYsRkMsR
         Nkilg4RjGEYhhusUBCzFrerPtwZrZZTYXzM1Rn9MjmqecBr2rlrX8rixYIoS8YmBO031
         QXKmmas6+z4okWuzU4ZxiM8D0VwAVf53s8G3wPt90t5KNnZifQB1q4N9j4maiFAaJDbY
         I/QZ1oWsqJUbb1SEupA3WHbgjarNh//9i6AXlaq5YvUIH8cWEUwlUP4z6uBrMCpUKaYa
         nqmXTY5JTaO5LD6W+n9DPlK5FPghcm4dLVAyoO2ujR7cy9b9xH8qN1Dxp0hy0ek5u0mG
         LtnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740168450; x=1740773250;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RB1lR+aB2DFBicW90ROYujqbV0AEbnFQJOUJctGhXRI=;
        b=T/d3BVWoXpRogBE1KAv0QZLvoMU7OtFWJgtJI28Lzcq4vNeDegut/mP4Nzx86Ez01X
         Ye6o3/3nP6YLvgpTpRefkl9EwWf/QY2bjmTIQn+NxkD0d/OAUcat7lWrc5nkL2yijU2H
         LVfoprEPF6gQ2Ibx/znACt0WmdxW7CrpefhFrRDZTGjiF03Eg7PyJWVni382WcC+pd+2
         xQtpDsygW5miBhZOjwh82CviGF0V4NEo1RomNm3M6uuzvOHxPNg4XilGiaHKqJR26ICh
         OCTz/SNJgdENbSd1RtEDrUHaW9ljoeCBmZk1oXdmgQ9J9dFxq8ADZa0sMWYo89anpxZr
         fZTg==
X-Forwarded-Encrypted: i=1; AJvYcCU28rMl7Gw2n/3a6yPd3LHbcQrkIzS8KR7JnHIKs/6DlsC4Jckn0VlFCQboqRF3ApdnhwX1pb6493T0jmzAS4w=@vger.kernel.org, AJvYcCU4Pi7pNy4ikotJLkuqeteHZQOWaF/gFLHvqQpTvT6e6mm9Pnf+WnL9q3yE1JIthynXFarXZ4PuFQ0saag=@vger.kernel.org
X-Gm-Message-State: AOJu0YzauGH/AmnBLaemcx/K3e+pBLlV32C6debHGdpEoNw0gUreGXxH
	TsNvJ0WSn2fTFKyY0r5gS5MEyCG6qVexBNqOOsQdlo9aNXIxeyjk
X-Gm-Gg: ASbGncuGhDuIeP4+wZOHmGmzESNjNzko3xskubcvn0e2C1hgEDITf1k64LtRuYT4war
	LnllMpJ32VlVsvcJJLyEVIfVFX6E/UeIaUAMY6oMuDXOMb7ZdfYgLkXWIuKyTphmpCLsjgYqtR/
	RFZjiU+ps9+Z6HsaXCisiB/5dVBtsvrqbR2W7O/03fPSoNteRaajU4cOLk0xjDimY9OqYcf6z7A
	wdfibPNpX3h89/Bay/dm00oT01ODxcYjyWIuUKo8ohV1XSvf8Bthjk6b4tDNGMWxkF4jc7rDGzE
	KBq8ks7c2PGhDrZz11IJJRy4k+Cv/Z2KFH0hmsx+mnQT96B6
X-Google-Smtp-Source: AGHT+IEV/9ceYaqgCzY1ZQH1uaVVHner+kvO/+TD3nG4jkQEysozy99K0MOUnJ7/OVsYVjRbB6Us6Q==
X-Received: by 2002:a17:903:2309:b0:220:eaaf:f6ec with SMTP id d9443c01a7336-221a0ec9501mr72162795ad.5.1740168450001;
        Fri, 21 Feb 2025 12:07:30 -0800 (PST)
Received: from smtpclient.apple ([2601:645:4300:5ca0:35f7:b1dc:26f7:f292])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ae624a00dc8sm4660203a12.34.2025.02.21.12.07.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2025 12:07:29 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: C aggregate passing (Rust kernel policy)
From: comex <comexk@gmail.com>
In-Reply-To: <CAHk-=wjF0wjD4ko7MgrZ1wBZ9QOrQd_AnyhDDUJQ1L5+i-o22A@mail.gmail.com>
Date: Fri, 21 Feb 2025 12:07:17 -0800
Cc: David Laight <david.laight.linux@gmail.com>,
 Jan Engelhardt <ej@inai.de>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Christoph Hellwig <hch@infradead.org>,
 rust-for-linux <rust-for-linux@vger.kernel.org>,
 David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <ACFAF4FA-755C-4AD8-9826-168E4A7337B9@gmail.com>
References: <CANiq72m-R0tOakf=j7BZ78jDHdy=9-fvZbAT8j91Je2Bxy0sFg@mail.gmail.com>
 <Z7SwcnUzjZYfuJ4-@infradead.org>
 <CANiq72myjaA3Yyw_yyJ+uvUrZQcSLY_jNp65iKH8Y5xGY5tXPQ@mail.gmail.com>
 <326CC09B-8565-4443-ACC5-045092260677@zytor.com>
 <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com> <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh>
 <2nn05osp-9538-11n6-5650-p87s31pnnqn0@vanv.qr>
 <2025022052-ferment-vice-a30b@gregkh>
 <9B01858A-7EBD-4570-AC51-3F66B2B1E868@zytor.com>
 <n05p910s-r5o3-0n36-5s44-qr769prp69r5@vanv.qr>
 <20250221183437.1e2b5b94@pumpkin>
 <CAHk-=wjF0wjD4ko7MgrZ1wBZ9QOrQd_AnyhDDUJQ1L5+i-o22A@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> On Feb 21, 2025, at 11:12=E2=80=AFAM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> On Fri, 21 Feb 2025 at 10:34, David Laight =
<david.laight.linux@gmail.com> wrote:
>>=20
>> As Linus said, most modern ABI pass short structures in one or two =
registers
>> (or stack slots).
>> But aggregate returns are always done by passing a hidden pointer =
argument.
>>=20
>> It is annoying that double-sized integers (u64 on 32bit and u128 on =
64bit)
>> are returned in a register pair - but similar sized structures have =
to be
>> returned by value.
>=20
> No, they really don't. At least not on x86 and arm64 with our ABI.
> Two-register structures get returned in registers too.

This does happen on older ABIs though.

With default compiler flags, two-register structures get returned on the =
stack on 32-bit x86, 32-bit ARM, 32-bit MIPS, both 32- and 64-bit POWER =
(but not power64le), and 32-bit SPARC.  On most of those, =
double-register-sized integers still get returned in registers.

I tested this with GCC and Clang on Compiler Explorer:
https://godbolt.org/z/xe43Wdo5h

Again, that=E2=80=99s with default compiler flags.  On 32-bit x86, Linux =
passes -freg-struct-return which avoids this problem.  But I don=E2=80=99t=
 know whether or not there=E2=80=99s anything similar on other =
architectures.  This could be easily answered by checking actual kernel =
binaries, but I didn=E2=80=99t :)=

