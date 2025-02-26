Return-Path: <linux-kernel+bounces-535127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C46A46F4C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 00:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E703A4FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901192702C1;
	Wed, 26 Feb 2025 23:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="OL9SixFd"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A996F2702A6
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 23:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740611952; cv=none; b=M+oaLNeDjln5V1OKcTplJvyGMFfvmto16dNsCIOD6KqT5a0IALE2iTgZlAy9+NKq/QahBy70XFXyjNgJTN+Ol7/rb1MERS6pq0iH4ew3YfvfEP7ahjqz6PUIOHAql01/W+lZ2QLPNcMkDzmLZmmCh98/blwxC8JIVg1vXNAEBIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740611952; c=relaxed/simple;
	bh=foxtZDCBK0dn9bc6Jbpi3rbKPKA2AjNZ4xGSo4ZEHaI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T3RbUPzVzvxSNKapXvXQ+IIIXTxrPVGIPwVJ8tUKbr8Awg8EIGGVWA5g+Cqfx11GC9H4MUIbSP9vPt/U2VIEeR3OfgfetYif+NUIHl+sRoUIr6C+5VB7ugeE8vX24ZdiUkvOdFZi59Xy3js55DJiAr/fx0RXKRAER9raBftYEyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=OL9SixFd; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e095d47a25so446366a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740611948; x=1741216748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TraiYlbomd4QL3tOowrIKCTC40aTkxfdwA2KJAFj9MU=;
        b=OL9SixFd9Oy6aPD9G+vuE+0NfecutWcbC0OPpCab5w9fZ5fOsynpHleV6nRrb3Ga3C
         hrfof/rf6NA3RwazZYXGb96UcFuVbUxV2U7TTU8ODwdXAINXXsZcHphSPF1p77bufwAy
         coEijzz413GVgYvnNYVrtWOxt4UF9/ED6PvrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740611948; x=1741216748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TraiYlbomd4QL3tOowrIKCTC40aTkxfdwA2KJAFj9MU=;
        b=ZK8XJnajnQg8VQWzD0g0QkFoaiEuegBeTiL356xU8uDuUbFwJCapRxfHH6/CicfeOA
         HIgu4QIyGNeizkWyWuwUq9ZyBlclfgC0UK4zO9pn0kXZvY2fBQ/WoD1PfWj9Fod/NHPW
         gs0tr8DzzizkGH+Mto8LN7lENc0OV0rNEw4sbu5qVWH/c9uKocf5/LasEwrZ5keBSHs0
         kQ8YaR3Ka5ltWZ9oboeO6svyPRjWfRV7lOHPebAofU16GdSL95yGp+KsTv7W5dcYUe0l
         LumtSs7WnjyPaluUNQWG2JEYpPGOCQ3112IW+7QP7oejZHsLosSV3CBuzN4oQEclm8pE
         QB7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxTSypDpVKa9H1Gx/FfUR5WhTvLyRc8lRFJAPr68EYJhJRGV+g+o0MzP3pmBqAijYU74C0XX6XuTRPexA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpWWIXuKe/skTA0XhYNssKa3GMstgh2lUAkBnO0PZYlg8BTC32
	IG58IQkhi15x+/gEHJYsQNx9t7+kP+eAGgN+5LYHtfwTlUftbyzCXXzPG3Ndzexj3Oqbk00J/NI
	shZiVwg==
X-Gm-Gg: ASbGncsg0wOFyPwj9mv5fmQ71tYKjhtn0uswK8YtRgCFJdf/YIKl21BK8CoE7/55fk6
	W0K212GDW2Fk3isz/8UP3emve/f6uQumxC598uouslLTLu3UTMNtq3isgcTczRTitm5TceAB55y
	akA+m8m1uPZ8BkE7MFR+S0rIv2rSWugiOskxHAwjfBGCLHv4WKitj5PxnMKqpxLEqVan+G5k5FY
	/LPSG28RMIx4WNl2Ismfsy59XYEmn7w+BpRtsl2Hlrq3qdX/UttJK9yFDIfYAYUV2f414GN9l5C
	Lnq4n27LGyiPuk1OkOqUOIsdNvV5CS+S8Os4L/t+JJhOgW3ng4nj4kbK150CORDd1x7tSs4vFbo
	+
X-Google-Smtp-Source: AGHT+IGt1xZAGHFWC4bQr6zkLFjVLKTa/q6eKX3yZR0RCDFAUSisIDFZ/jpwQunY/WEnvWhxL0KiLg==
X-Received: by 2002:a05:6402:2790:b0:5dc:1173:bfa3 with SMTP id 4fb4d7f45d1cf-5e0b7247814mr25736673a12.29.1740611947704;
        Wed, 26 Feb 2025 15:19:07 -0800 (PST)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b4aadbsm174452a12.6.2025.02.26.15.19.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 15:19:06 -0800 (PST)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abb79af88afso58543366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 15:19:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCpo8F2IYI8Dd7+Gv9JoOe/u4PypiQ4WeuGhnQyMs9C9BRMojFApgtbXMJUhhYNGumcmqz9ZnmEaOJ+J0=@vger.kernel.org
X-Received: by 2002:a17:907:72d1:b0:abb:e7de:f2a6 with SMTP id
 a640c23a62f3a-abc09e35401mr2910896766b.53.1740611944724; Wed, 26 Feb 2025
 15:19:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de> <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <20250226162655.65ba4b51@gandalf.local.home> <CAHk-=wjAcA4KrZ-47WiPd3haQU7rh+i315ApH82d=oZmgBUT_A@mail.gmail.com>
 <20250226165619.64998576@gandalf.local.home> <20250226171321.714f3b75@gandalf.local.home>
 <CAHk-=wj8Btsn0zN5jT1nBsUskF8DJoZbMiK81i_wPBk82Z0MGw@mail.gmail.com> <20250226173534.44b42190@gandalf.local.home>
In-Reply-To: <20250226173534.44b42190@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Feb 2025 15:18:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=whvzK6ugXhCdrTfXnkFR+u_+sCtwz4aDODJ_h-RJ3kOKw@mail.gmail.com>
X-Gm-Features: AQ5f1JoJL1av6p0bHCUuCTiHUulziFdE8-qs-EcbEYZ32grw4GEJZn_MqtGet6I
Message-ID: <CAHk-=whvzK6ugXhCdrTfXnkFR+u_+sCtwz4aDODJ_h-RJ3kOKw@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Uecker <uecker@tugraz.at>, Ralf Jung <post@ralfj.de>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Ventura Jack <venturajack85@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, hpa@zytor.com, ksummit@lists.linux.dev, 
	linux-kernel@vger.kernel.org, miguel.ojeda.sandonis@gmail.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Feb 2025 at 14:34, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Correct, but if the variable had some other protection, like a lock held
> when this function was called, it is fine to do and the compiler may
> optimize it or not and still have the same result.

Sure.

But locking isn't always there. And shouldn't always be there. Lots of
lockless algorithms exist, and some of them are very simple indeed ("I
set a flag, you read a flag, you get one or the other value")

              Linus

