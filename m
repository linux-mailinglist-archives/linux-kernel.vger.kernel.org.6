Return-Path: <linux-kernel+bounces-527417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BECBBA40B0A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 19:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DCE3189EDCC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 18:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADDE20E6FC;
	Sat, 22 Feb 2025 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BE89uNm2"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22261AA782
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 18:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740249902; cv=none; b=b836fSnO3xvymXopcIXzFa+kOoVjg376nzIsBT768yxGIA8LXFpEZ+mkWs19uF78WYuZbjkPIixIJYb4qKKCTbsC82qEaEbUa5tu5nEb6MFktrcHLKvTMtEgy4HeigNr4beOhOr4wAYk4IgJ/QvC1ovx+K08+woE7fwTR55u6do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740249902; c=relaxed/simple;
	bh=OWQ/8rNUcjck7tkRuYyqikXWKplXwhxhtLF2xDKFeXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DT85tlGxm8NBlota93IYzqMaQ8UDGJhoF9IfFFTl/QvfWlhEcCtHPf+K3hGDeyBEnnR7PsiGWMw6fwOtEAGUNDQPG2BRSKLMw2VLc8ajvXFBEi71983TZKf4ixguacTVoaQ0uV4ybgx632XlheoCggDuznh5zHmK3Mc58JGTbZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BE89uNm2; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5deb1266031so5773915a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 10:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740249899; x=1740854699; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2GmfLwYqjSfqdj0NeOV5aIVpVPfwUhlh0DRZJ2UKXos=;
        b=BE89uNm2KWCdU6+FpJCDgQi6DTG2sz8aEr+UxO/lOdL+9fLWlqBxM7W2oeTwZc7tkT
         js3nK1DSTiqIOtzYfmDSv9NUMTHuat09yzRyi3YBmZWULsSN0CBoXi5iGnJxXCJgjaXI
         3mGj/rnzb/+UaWx+hj+vggUhaq5FF3BRuf9hs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740249899; x=1740854699;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GmfLwYqjSfqdj0NeOV5aIVpVPfwUhlh0DRZJ2UKXos=;
        b=WaxGwOaM93vTg7dqeYjiDfofFMdlWW1GooG0Lb/6aN2FTsDErspccNzuOQWO5PnBoh
         m0uQz/sHkOwJeJvqiIMGHux+Rq0V2eefs6o7+CpBkvXRHc5DIi3b5O/DBHnSVf15XNIs
         4mPfNF3IGLMgoHtA4W1TPXKeJixdM3zb1aZ/MvA9BHdtjxmHGdDfSFIxV7dh22ZBia0m
         rEAnREni4eQuaxqOlYMp9DIDYiFnQgPo2Ys5bgb5T5U+jqH3Izn7V/0jBEHlLynG3wbl
         yIUS/x7ZZt2Gvxirifr+64QTEczStrx7RAiNZbjTWXAOVSkfhsuSfaWyw4Sw4jtVFHk9
         SToQ==
X-Forwarded-Encrypted: i=1; AJvYcCXv/MrJSl6RVATUSWD7ctoaNB0/Te+zn3PR2dW7rkNtoM9YDDxWfNNT0grP1lFHmVnSZwC3YraDn7GKIKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjPmk6nwLFdLQZ6aQIUxHdp9KWiYkhqyUKCgio3h5lVCA6d527
	LPBcpnDAPzvoT9Tqyx6pf3ilrvh7hrtJ+rdmG0iHTkrx6HzstMv9E6sahDVO/ycZFq19MZM6aPV
	DBrg=
X-Gm-Gg: ASbGncuGO5JlIErSPD8c+AxCwthrca4UX5O+XsdDliWqsIGfJX4udluL9DhTdGCvNne
	L8edAFEslDkPHR+KHpF7cIPvwZUOTnR0hWCQCV4c4wUI8ew8ZJt5p5c4V2g3Y/uw97egMqE8dld
	G4d2O+efgSAfs6IHnU5PEYJ0lkVvI6FO/PzLiY6I2M1VZxECcrqKuea6h8bXZ+gE1kMc4cjDsEl
	VU+aImxQ49/be/oGRrsLYUF3BoLLiB37myQfPznTsDTaLCW5KWWuHF+lyVB6oQCSya1yF5067FG
	RM0OY44vN0azhyHz5dZXpDSKbWi0RvMpDvGPv4in/9pGNVGnJxWWE1b06NlNWfubSY+fjMXNbof
	v
X-Google-Smtp-Source: AGHT+IHGClVJzd3Ajuk5FnITT81p7p+kgFLcj10+m8TzvFOB6EThsmcZ63gyNtUdmweu3iT8J++b1g==
X-Received: by 2002:a05:6402:360d:b0:5de:5025:2bd9 with SMTP id 4fb4d7f45d1cf-5e0b70e95demr7084768a12.11.1740249898874;
        Sat, 22 Feb 2025 10:44:58 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece2866e7sm15569206a12.65.2025.02.22.10.44.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 10:44:57 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ab7430e27b2so512499766b.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 10:44:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUaL11meecMi4Q68jui5UAV5GIVfCMHGpdZj1ISUwqj31yKnkEshAUUw+INDyMoHOSw+okdFz1Sy/f7Vdw=@vger.kernel.org
X-Received: by 2002:a17:907:724f:b0:ab7:9a7a:d37a with SMTP id
 a640c23a62f3a-abc0de1954emr621935366b.43.1740249895227; Sat, 22 Feb 2025
 10:44:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2025022042-jot-favored-e755@gregkh> <b9a5de64fe1ded2ad3111763f35af9901bd81cc4.camel@tugraz.at>
 <caea3e79-78e6-4d98-9f3b-f8e7f6f00196@stanley.mountain> <61a7e7db786d9549cbe201b153647689cbe12d75.camel@tugraz.at>
 <20250221124304.5dec31b2@gandalf.local.home> <CAHk-=wgg2A_iHNwf_JDjYJF=XHnKVGOjGp50FzVWniA2Z010bw@mail.gmail.com>
 <6b3e4d3bdc9b6efd69068e5b22cfd05d370aed19.camel@tugraz.at>
 <CAHk-=wg=pZvE9cHJUPKGCajRUCtDoW73xwY5UfJApCWms_FgYw@mail.gmail.com>
 <20250221172415.5b632ae6@gandalf.local.home> <CAHk-=wjQ94GipftbNo0PbfuUxFMXFyp2bWGJJPNUngyf17Ai8A@mail.gmail.com>
 <y75v63zqmgd3n42bprrbs2ppg32vhk2isppi6wxn7lfsdwd5sn@jm74cuwhadbj>
In-Reply-To: <y75v63zqmgd3n42bprrbs2ppg32vhk2isppi6wxn7lfsdwd5sn@jm74cuwhadbj>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 22 Feb 2025 10:44:38 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjEQ7wd=iRN1Du-_fAqXgqEfCZH27PisDNPCpusv3Swxg@mail.gmail.com>
X-Gm-Features: AWEUYZkGmBfM4yXjsFNaaBKIjcw5m0UrJ9-jgNYDnIvr-gmrGabmAZy5fq4X8l8
Message-ID: <CAHk-=wjEQ7wd=iRN1Du-_fAqXgqEfCZH27PisDNPCpusv3Swxg@mail.gmail.com>
Subject: Re: Rust kernel policy
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Martin Uecker <uecker@tugraz.at>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Greg KH <gregkh@linuxfoundation.org>, 
	Boqun Feng <boqun.feng@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	rust-for-linux <rust-for-linux@vger.kernel.org>, David Airlie <airlied@gmail.com>, 
	linux-kernel@vger.kernel.org, ksummit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sat, 22 Feb 2025 at 09:53, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> Because it sounds like coming up with a different way to write range
> checks is going to be easier than coming up with pattern matching magic.

Sure. But honestly, forcing humans to write non-obvious code is almost
always the exact wrong answer.

When the basic pattern is an obvious and legible one:

        if (a < X || a > Y)

saying " use a different helper pattern for this" is the WRONG
SOLUTION. You're making the source code worse.

Make the tools better. Don't make humans jump through hoops because
the tools are spouting garbage.

               Linus

