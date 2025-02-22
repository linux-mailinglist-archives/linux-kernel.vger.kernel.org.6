Return-Path: <linux-kernel+bounces-527481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB2DA40BAE
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 22:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 055177ABC19
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 21:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CED2045BC;
	Sat, 22 Feb 2025 21:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aQ4Sv8uJ"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917972045BA
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740259377; cv=none; b=nFmmThTagiOlZJC4+gJvVQDwR5iS1Cq/LnBB34guuvvUBTqkrmn8OVlsv4MlD/KpXT+Lk9DUs22Cns3HAnJhpV3qKUgsokv5PhjWby6suzuPw6WmJCnTzElQS2noOP9aTqL+tFqCQ65xG6aSYzHR5qwV8M1zQpTFc5m3uq4AWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740259377; c=relaxed/simple;
	bh=wksg7Ssp0B5fCpUThY7XyozB7dKQo0DeSRiYBXMj6os=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C+rD2R51k2Pl2dfUaiS6JtTX6JENoAWAwnrrawrQ26FtsDtFSPH19DxtD0ntwpEJ/ygjYJp2Xu2NMQoJwAf4Mbg2yWze0xLQmGElJVYH3VgVC9LqtnZ15y1vuTRa6msV6jWU2c0S6lghfeCO2CkI5Wt/280Nqxvc/0b5Qlf7hys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aQ4Sv8uJ; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso493943966b.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 13:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740259373; x=1740864173; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4iEhhaz8KH8wSaw5vdKbNXgznw8OSlCEKiD6GpJBrEE=;
        b=aQ4Sv8uJWBd7MpGLnEdKaBKu7nMp+qP3I2ypQckoBOmANSJEUBGi3CbnaZGeKhtOuP
         /45iZ+PvW665b1Ko9Y1kGcqq7HRxoZgmyYxq+aKtKnXmyHx0fLH1Pu2WS6KS8elbKnQA
         dccA6IWPjZ8+RDCfyx9r5u16GM4Jie/aB40zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740259373; x=1740864173;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iEhhaz8KH8wSaw5vdKbNXgznw8OSlCEKiD6GpJBrEE=;
        b=A0NKCQaxhL2o5X5BaUeMlB0fJql3xL8kuluQN2TBkqnD7E0j+2PytWajP9ochwI3/S
         1r6CvB/9nZOBgQL0/PqSmr8bC2ZWlHAEqmFrwEoYsTqamp9YQT+nz4BhBVxY4TeOt01C
         joRzBZkquT9eCvaCeZbNzIYmdnIqdccvZghJF8cGUCIUFrdh6Bu0oMuKxlBRaVwmuEB8
         Hz/09PeA9oSPsvZry1/Lp1iXPWh7SYP/hXtR9ktVF6n5xJ4E2gwGLjKJtKTB+Ik56zwE
         oLeiQYIBtuAHjLW5USCghXK7XwhFIclyXTcZxlbtgcz8olFs5tinTCV8idZPgj3vumEA
         KzYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU+3b2XpW53T98Wy+D1AoVY4SdGFli9k4l/PdsKEEGiZdHGHk9Ios4hGoz/cS+iQ3i/pQhbrvgLIVI1Qek=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcENC3RwtjtQXXxElO2uIQM4P9qSKj062e9mfB572z/drcpjwE
	v3YZIunR6qYmsqeJdwexYh78FexPErka8/eHG1aHKFA2j4WDVXnl5xSw0Fw7DruhV5FFwBEPTcC
	8HB4=
X-Gm-Gg: ASbGncuWtDzVGgSthq0aJ59A9vPxc46YEAGDqYTl4IcoJVSE05Y4O47e5dd+Crt5ZAW
	xqoQqm8muNUY0aCH1aOfdwQyFK2FiOmRh4ilWyg6hDDsWpV3RuYvPNLcEhhncHz8MnO5OuxJLQI
	K3WXKEktRDK/wC3b/w4+EdK4+lCFaKkfX2+Kvy0u4gadxqoeJmWaQgrCaVejlfdNAYMfrbAnDf8
	ewZEI0gA+7uiuukxhkFtLJDQZ5gSFnfbUB9VoaS153cOa2ijOB2sTUUkiSk8Tv53C962CYIofJO
	wMAqorJxsKoB1LRgOgj9tEpcV4Z3ObbIBAvDEpTqoBch8b7IabYLrKlTbobRsvg77hOE7CjMDCd
	0
X-Google-Smtp-Source: AGHT+IENrrwGYKsu4l9j8ObOS/RgIqfUPo6lEuuZnNGdh6gIWHEEFY4hxSeKLrJq7bf2bg5SR//SAg==
X-Received: by 2002:a17:907:8688:b0:ab2:faed:f180 with SMTP id a640c23a62f3a-abc0da33a30mr919225366b.33.1740259372691;
        Sat, 22 Feb 2025 13:22:52 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba5337634bsm1937472366b.91.2025.02.22.13.22.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 13:22:51 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e0573a84fcso4490449a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 13:22:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWd1USocusCQVmKv5uWvFofOpnw3qFUy2av8TgUtyYZoWSazEFoIUqjyewTpTnAOu2A3k3SiAX6wU0zadc=@vger.kernel.org
X-Received: by 2002:a17:906:6a02:b0:ab7:b9b5:60e7 with SMTP id
 a640c23a62f3a-abc0de0dfbfmr702171766b.40.1740259371241; Sat, 22 Feb 2025
 13:22:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFJgqgRygssuSya_HCdswguuj3nDf_sP9y2zq4GGrN1-d7RMRw@mail.gmail.com>
 <20250222141521.1fe24871@eugeo> <CAFJgqgSG4iZE12Yg6deX3_VYSOLxkm5yr5yu25HxN+y4wPD5bg@mail.gmail.com>
 <6pwjvkejyw2wjxobu6ffeyolkk2fppuuvyrzqpigchqzhclnhm@v5zhfpmirk2c>
 <CAHk-=wgq1DvgNVoodk7JKc6BuU1m9UnoN+k=TLtxCAL7xTP=Dg@mail.gmail.com>
 <yuwkqfbunlymofpd4kpqmzpiwbxxxupyj57tl5hblf7vsvebhm@ljz6u26eg5ft> <6EFFB41B-9145-496E-8217-07AF404BE695@zytor.com>
In-Reply-To: <6EFFB41B-9145-496E-8217-07AF404BE695@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 22 Feb 2025 13:22:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjS8hzLyOEAxhHR3miajBHdXXSpyhq54iCb6dKuJxP4Yw@mail.gmail.com>
X-Gm-Features: AWEUYZn2q7vlrnil44LrRbnQ_gYsOI4ICZfisQzq90rI5rzF1ykDwwh3NLl2oAo
Message-ID: <CAHk-=wjS8hzLyOEAxhHR3miajBHdXXSpyhq54iCb6dKuJxP4Yw@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>, Ventura Jack <venturajack85@gmail.com>, 
	Gary Guo <gary@garyguo.net>, airlied@gmail.com, boqun.feng@gmail.com, 
	david.laight.linux@gmail.com, ej@inai.de, gregkh@linuxfoundation.org, 
	hch@infradead.org, ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 22 Feb 2025 at 12:54, H. Peter Anvin <hpa@zytor.com> wrote:
>
> VLIW and OoO might seem orthogonal, but they aren't =E2=80=93 because the=
y are
> trying to solve the same problem, combining them either means the OoO
> engine can't do a very good job because of false dependencies (if you
> are scheduling molecules) or you have to break them instructions down
> into atoms, at which point it is just a (often quite inefficient) RISC
> encoding.

Exactly. Either you end up tracking things at bundle boundaries - and
screwing up your OoO - or you end up tracking things as individual
ops, and then all the VLIW advantages go away (but the disadvantages
remain).

The only reason to combine OoO and VLIW is because you started out
with a bad VLIW design (*cough*itanium*cough*) and it turned into a
huge commercial success (oh, not itanium after all, lol), and now you
need to improve performance while keeping backwards compatibility.

So at that point you make it OoO to make it viable, and the VLIW side
remains as a bad historical encoding / semantic footnote.

> In short, VLIW *might* make sense when you are statically
> scheduling a known pipeline, but it is basically a dead end for
> evolution =E2=80=93 so unless you can JIT your code for each new chip
> generation...

.. which is how GPUs do it, of course. So in specialized environments,
VLIW works fine.

          Linus

