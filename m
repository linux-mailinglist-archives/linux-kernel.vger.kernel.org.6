Return-Path: <linux-kernel+bounces-535210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC7FA47030
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 01:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78254188C740
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 541AA4C70;
	Thu, 27 Feb 2025 00:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3vhdVbK"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6088CEED8;
	Thu, 27 Feb 2025 00:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740615976; cv=none; b=TReTmbiBsO3F9fCrkm8b7/EzhPHqrq/V0J8J+4qaiB0mJNifzl5hF/wWjrplBDm6SHj/RD9Z5pBRsivn52uuIuEXk3LJiBGrZLR6oPnAZKyxyOFWc13QzgeGo3a+VGrw0MDKdqnoZ7y4DjdtF9vo4WHrLNPjiQkzsNNLvhjxbv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740615976; c=relaxed/simple;
	bh=bYSdQFw1ifj/PHNEy9onf1+iaxoTCsepzzcH95uH2Os=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SzuBblsiicB7YSy9Df3pypQaxv+HsgKqB7BVmOl0LJ+nb004atoPfrjjtJFUgMbgCPGRQOMnBPtgbiwoEEF40ZXjiuOFFLVlg0/y02uDTEtdM66pBzZ9pDEAetL4KK3ISG1OCL9pP3kNQpkuWL4u2/Su9jv5rUidJze4mbGGuAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3vhdVbK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2211cd4463cso5374975ad.2;
        Wed, 26 Feb 2025 16:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740615975; x=1741220775; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YjzP/rJRMjLSGPUq68ittLipJnIhlpcB171jTse6kDE=;
        b=j3vhdVbKYrjsMh7WSVSzyoA4Fm4fwUlce2S9eCELF8aShtZnuUoHh0+2gnr6NQABMB
         uxwnhFwa713HQR5EmekrzbRImJN1HtVSuRtxWBfWmTMajgFclF/SvkouIEhcJi+D7MT2
         vajuVXFPynweCuiyKKP1G3+f3DwmTE5T3ZNkBolhlrSWqOgmqBeTq1jWdLWtykrQGscB
         TA4s6gT8ddte5fkV1mjEggIj0nMjlI92ZIL0qKaTH9p9LhN3sTemJOL18xdRe+hvtWrN
         ijD9/z2vRvyKTxNtfP14pEt6rob1deI+f2pFEaNBRwYQf3JCxGc27u1ZkjW1K1FQ19ub
         pN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740615975; x=1741220775;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YjzP/rJRMjLSGPUq68ittLipJnIhlpcB171jTse6kDE=;
        b=a71aGBS8lkfNzeLE0rH7pVZ+UUEJASmVnIPNyNHkH5neuVvodEMKDTqNNNcUcMxczI
         Kbrd3Rlid+Xv6Jhb/I/g9a29Axbb6vwOnVrt7Lf9EJrFmn5ia+St1MhUXj/7mXPUF0Tb
         pBZ4b+8koSqME2mHRd1vaNhbRY1hqg6eWoHAmhlk7/kWUlxIDtbCRcCrFuDYKgtL24J6
         ti1iUHgKoKoykOU1l1nCVUJw5qmaqfvCVtKo+nm9LYVu4hsMJ0vWre+bPTWbknMQvtTS
         YH6icBFwTT0HeX/mIp18KsDbuHWlxOR6doWyCuOjzqCsp2CNZFs/hieeHfcowUkj0L7B
         KKNA==
X-Forwarded-Encrypted: i=1; AJvYcCU/wrn78dJATpZeuGYk+oeDRfH7Jnaqc6TfYgyjvpvyAaYZW/OrsUMzZdYZef1HPRUvoaU6CKT78C7sBrI=@vger.kernel.org, AJvYcCUKOldUqiUoXP6v50Tl5rpJ8bk7uV/Hj8wcQAHYyeiO8o1jPsws0DPK0AHOnxfFuI1iy/10KzXXc2eaDXNvkJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdezclPI6qBiDq0gjrchG8Z2XPb8nyzBn/7hU4YcqOLHSoiZGF
	u5DKuaSTjtTyDKOLjtTXGWk2s7SEKf1RQgjGHL/R6svxo2I7PlT7
X-Gm-Gg: ASbGncuY3nVtUu9lYi/LDphuzCQUvUQVCAsK7F4j5qBn2OYmTqJiBsbZe5K7tmnVqSS
	+/4AsRJuStBiAPmDsA0bd11ngDnphX/XN7KTO5092Ou7YxFxwDD4/4KDMUSNYnzt2GBqMhCeN1U
	VFZP1HEuzf/X84cYm960ry9x5R2NfhgXDWDWof3Fcs3HQBcpixJ6aN/HxjiK4yfCnchYPoyyoq2
	PHZte0msm41LaLNEKnYYNBMcc5tbRhVP9acxp/wYxFEk8ZsChWGXxsLD1UKFpRED4tiZxwM6/b/
	H/B9F0T7paJGTFoQxqB5TzuXeihfVARD/9r4MHcdREeciuY=
X-Google-Smtp-Source: AGHT+IGIR7ac5DaXTj+aXnGj6+y5CDcGjRUX9/M/CBvX/ZzTO/lWPWQNq8Mw+fbL/n0dYUk9infhqA==
X-Received: by 2002:a05:6a00:240c:b0:730:8386:6078 with SMTP id d2e1a72fcca58-73478ed55ccmr14531012b3a.0.1740615974654;
        Wed, 26 Feb 2025 16:26:14 -0800 (PST)
Received: from smtpclient.apple ([2601:645:4300:5ca0:8007:c7a6:4742:3f8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a005f77asm188260b3a.173.2025.02.26.16.26.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2025 16:26:14 -0800 (PST)
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
In-Reply-To: <CAHk-=whEkEsGHWBMZ17v5=sq1uRe6g-BRHy5xNZK-2JBKRs=_A@mail.gmail.com>
Date: Wed, 26 Feb 2025 16:26:02 -0800
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 Martin Uecker <uecker@tugraz.at>,
 Ralf Jung <post@ralfj.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Ventura Jack <venturajack85@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 airlied@gmail.com,
 boqun.feng@gmail.com,
 david.laight.linux@gmail.com,
 ej@inai.de,
 gregkh@linuxfoundation.org,
 hch@infradead.org,
 hpa@zytor.com,
 ksummit@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 miguel.ojeda.sandonis@gmail.com,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <33A13F26-546B-4CB9-9A4A-367973397CCA@gmail.com>
References: <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de>
 <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <m4cbniqfsr5xpb2m7k53e7plc6he5ioyl2efiiftdmzod56usd@htwdppje6re5>
 <CAHk-=whEkEsGHWBMZ17v5=sq1uRe6g-BRHy5xNZK-2JBKRs=_A@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3826.400.131.1.6)



> On Feb 26, 2025, at 3:16=E2=80=AFPM, Linus Torvalds =
<torvalds@linux-foundation.org> wrote:
>=20
> On Wed, 26 Feb 2025 at 14:27, Kent Overstreet =
<kent.overstreet@linux.dev> wrote:
>>=20
>> This is another one that's entirely eliminated due to W^X references.
>=20
> Are you saying rust cannot have global flags?

Believe it or not, no, it cannot.

All global variables must be either immutable, atomic, or protected with =
some sort of lock.=20

You can bypass this with unsafe code (UnsafeCell), but then you need to =
ensure no concurrent mutations for yourself, or else you get UB.

For a simple flag, you would probably use an atomic type with relaxed =
loads/stores.  So you get the same load/store instructions as non-atomic =
accesses, but zero optimizations.  And uglier syntax.

Personally I wish Rust had a weaker atomic ordering that did allow some =
optimizations, along with more syntax sugar for atomics.  But in =
practice it=E2=80=99s really not a big deal, since use of mutable =
globals is discouraged in the first place.=

