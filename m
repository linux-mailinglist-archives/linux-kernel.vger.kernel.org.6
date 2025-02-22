Return-Path: <linux-kernel+bounces-526963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C24B4A405BE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 06:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE3804261DB
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 05:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EEF17C2;
	Sat, 22 Feb 2025 05:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JLWlCsno"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3EE1519A2;
	Sat, 22 Feb 2025 05:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740203798; cv=none; b=o2N0c7Trib3XdGNUbhz5ABVKBqmGu3jMPP7BsUOXX4scbHlcMm/2vUDnRRcVfUz6AoVCGrKj5Q60yhfLI1bqQYdP3GFNtW9tkOVSgmBWcceJshDGnEl5pnDYEuFe5U9sEpVe7mLBFnuNUdYiEZgSX0OlYuAptLrAqu6gCsxvpVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740203798; c=relaxed/simple;
	bh=C+stmj8U4y5ym21F+sMcdLbl+U7vfbBp14zzEbI48W4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=D/wVCqcJPc8d9a1RP4XmbdqTcTtAKm4wDThjGfmN+GXhGsDo+0mGYdZEm0Nq5CNqahOEqvlnze4VRFSCY+yd+BRxETP8xW5ERnCGmm+8HXJrB46/6Fxa5xs9jzGYQDkTi8op6zNZv/OHD/Y3rVWZ8W/mKTSgCMayRcOSUYlnPIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JLWlCsno; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22128b7d587so55469755ad.3;
        Fri, 21 Feb 2025 21:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740203796; x=1740808596; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9toe4jz2yTh5fR2DruBYvXF93WBq57gFVoRlebFiqAk=;
        b=JLWlCsno51ioaCLRqztusZ7XTS3QTCAvnVdNwX/RNxCEnkvurYxuVtdByyxDF91vJ6
         rcUK961ZqvFl8Cuoa6ZNjNC3t+d5L52d5Axp+Y3vOIB9rv/Iw1iZF6xkTneZ1AJTFhmw
         Tnty9SgDLVWruJN2U8aHx72wSVqE8azwzgjsSdZ5OafT2WebSDZuYSKsJCZdXv9AzJu0
         qB1/GvhL/UzBra7qNvAhfMk8e9X0lIWJXOPCEhW5y4EBQNNvbgdw7cweMMbL8eCcVru4
         IYqEpQu1LaLokqRtcXuvi+aE1ZkxedrGEiUNSEW1LmaOLE6iXowpg4pgOge3M30vYQpT
         Qyqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740203796; x=1740808596;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9toe4jz2yTh5fR2DruBYvXF93WBq57gFVoRlebFiqAk=;
        b=SeGkMmtUHttjTb8GTq4/vD5iYrtjNMxGSzpT43NHe2tOk71DpMqEP8LU6zzlYRTOtx
         3k/qxavQlBI1ly3kAPRj65Uieq3p19JbblxJFk7Q1iUJn3YjMZIO4+rAaDwW33SwuxcP
         EBUutcmn0VsldbEPSnnKHkMK6gHtJMCamkFshxYIq5TELJQ2ZQA5SyrBg2+OFUsxXn1Q
         0JK+yx2pIwxbY5VEZm8tpkp7qcPrFJBcavGuIoVsUIJJgpmsdhWuweTLdspkVlsHKP8h
         836eXrOwd3o4EM1JWDGFxheFIv8M4rQho0yLJyW6pLVSXfojjxib1IaJO8cLUhjIdACf
         H0ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjVm4PM1D6K/+qc+6SmW2SLOT1m1NbBMSNt5+yhaPbCtYIT7NdHtHYiDBfulM5oah/+TR4Tq/XnFXC5y0=@vger.kernel.org, AJvYcCWpqpoHjeExi93gvShbEzcrbwi8PLBq6rbVfwkHmFmHZAcBWLdliZi6jWs4GPZMUqXDVQmkbB8dQpbk4aMZ3QE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8BGarwSaSKeVb2cQWvu7W5D52G22rGnMWqQaS3NMWAZ0XQxwN
	P9/H4gTb0w68Bf4LQiLCEAJ+7kZFaymR3KtVWaOzb+cnNx9eHMBu
X-Gm-Gg: ASbGncufeuEuZkXQT/t5jR/sSfv/iPQU8PCIjolwKzilpY9o4RGKelwOkCz8BxKTzg+
	xFarViMHY/fEhPxMxHAWY8h5d01HIRS/R+qfrH2q4h11mSgNZqjkjiy6g8FE6afwJSgi5+9j31d
	AbH/vAamdSRuGNcgK+QTEPq0R1nM/omXKP1ctn8K29qrU5DscQDpPdhSu9GhwwlrYGNX92NSvIN
	yBIfTWTjw5gxr+O/m+tHIrtoYNDlu6rTXmCIWDb4avx1GRSwRLovB5nPjMcJYNFCKe+NIlU/4Ky
	tSU7YwG9IwsO/NKOQczffD+wMXeCj3XnHdPNMwaK45guOzNR
X-Google-Smtp-Source: AGHT+IE4NzvtvNaLq+BC50x7+IEs35DdLd3D1KdoFJPlnLEPZKxkTfB0OERGN6Dm5auQQeaXxUuQrQ==
X-Received: by 2002:a17:902:d4cf:b0:21d:cd54:c7ef with SMTP id d9443c01a7336-2219ff31902mr88562285ad.9.1740203796361;
        Fri, 21 Feb 2025 21:56:36 -0800 (PST)
Received: from smtpclient.apple ([2601:645:4300:5ca0:35f7:b1dc:26f7:f292])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d536439bsm145851455ad.81.2025.02.21.21.56.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Feb 2025 21:56:35 -0800 (PST)
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
In-Reply-To: <917f49a5-dae4-4810-8116-9bc93ddcd9f5@acm.org>
Date: Fri, 21 Feb 2025 21:56:24 -0800
Cc: David Laight <david.laight.linux@gmail.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Jan Engelhardt <ej@inai.de>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Christoph Hellwig <hch@infradead.org>,
 rust-for-linux <rust-for-linux@vger.kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 David Airlie <airlied@gmail.com>,
 linux-kernel@vger.kernel.org,
 ksummit@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <57A4AE10-546F-402D-A04E-3EC323A86AC5@gmail.com>
References: <CANiq72m+r1BZVdVHn2k8XeU37ZeY6VT2S9KswMuFA=ZO3e4uvQ@mail.gmail.com>
 <a7c5973a-497c-4f31-a7be-b3123bddb6dd@zytor.com> <Z7VKW3eul-kGaIT2@Mac.home>
 <2025021954-flaccid-pucker-f7d9@gregkh>
 <2nn05osp-9538-11n6-5650-p87s31pnnqn0@vanv.qr>
 <2025022052-ferment-vice-a30b@gregkh>
 <9B01858A-7EBD-4570-AC51-3F66B2B1E868@zytor.com>
 <n05p910s-r5o3-0n36-5s44-qr769prp69r5@vanv.qr>
 <20250221183437.1e2b5b94@pumpkin>
 <p7946077-rn30-n3p3-ppp0-80o9n9p07718@vanv.qr>
 <20250221202332.GA6576@pendragon.ideasonboard.com>
 <20250221220201.7068dfa3@pumpkin>
 <917f49a5-dae4-4810-8116-9bc93ddcd9f5@acm.org>
To: Bart Van Assche <bvanassche@acm.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> On Feb 21, 2025, at 2:13=E2=80=AFPM, Bart Van Assche =
<bvanassche@acm.org> wrote:
>=20
> Initially, early implementations of std::string may have used CoW or =
reference counting techniques.

More accurately, you can=E2=80=99t have one without the other.  =
std::string is mutable, so reference counting requires copy-on-write =
(and of course copy-on-write wouldn=E2=80=99t make sense without =
multiple references).

> Notably, the C++11 standard explicitly banned CoW for std::string in =
order to avoid its pitfalls.
> [ ... ]

The C++11 spec doesn=E2=80=99t explicitly say =E2=80=98thou shalt not =
copy-on-write=E2=80=99, but it requires std::string's operator[] to be =
O(1), which effectively bans it because copying is O(n).

Which forced libstdc++ to break their ABI, since they were using =
copy-on-write before.=

