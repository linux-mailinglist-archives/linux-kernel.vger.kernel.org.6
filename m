Return-Path: <linux-kernel+bounces-534315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8982A46578
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948AB17C75E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8597322759D;
	Wed, 26 Feb 2025 15:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoAs2gR5"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C8E21D5A1;
	Wed, 26 Feb 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584464; cv=none; b=QkGckQfZgyZiFaqv13joxLKhl2Wk4cI6xK7S59mn9CPxrck8cyt5kCHlYwCZcQx8mb1kqw5VXpI+jW+bpQy5px24UnMazO//wy/l9gfXWudGURRR90ZNFzfBCnJlYwCQTQePnrpMw0gqHCh57ipxsTUlqekv+ktjxJEtEy53Llk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584464; c=relaxed/simple;
	bh=uwWzBgOkEu6tAt9RlvyuB/XrCzVCtBuoCGy7bItgOXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5ivY3AjUHTiHAITxbVfvyrvENWFfNMwOlGFL48aRV5nAjYKi8tN9nGpI5Vny5ri5TMUbbvpN0jROVYkrYEYWrgvvpTLjvvjRTTMLtbIw2VxP+ZKSLRUdqxc4OsdQvox8lot69HiexyyU/fK3ofVmiSHWX+9ObfEMqC0zV/3/TU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UoAs2gR5; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5452efeb87aso6967007e87.3;
        Wed, 26 Feb 2025 07:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740584461; x=1741189261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uwWzBgOkEu6tAt9RlvyuB/XrCzVCtBuoCGy7bItgOXc=;
        b=UoAs2gR5DnjI8bLX/DeYzBVZFcHLf5L/aGD59YYFEyRMvQ5ODB+UYqC3euIsOXYXT+
         LgEuhTWIbeC/HJuXWDSPSUaFcOZvIBPpMoccswO6igVZiCeZx8Vm9ywNU+ZzOEBIGajM
         QoTQm8Nv6KNHMUQDKHjqm2BeHn3ESIO02DWZJAT8KJzGdq/4tSlOu5j6YaNbIbCIU0mb
         dkKOxXULUxk6sOgu0JhtvRzQ2MXYHnpGMe36Y8JoCKt5TWb4fO8fdt1/C6q5k7i6hhTB
         8SNC1uY7pVSIVs9rm+L9jJunzqLT+Ar7WICfcho+SoKffnSscu8wycIgfWX2HYQa8aM+
         24EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740584461; x=1741189261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwWzBgOkEu6tAt9RlvyuB/XrCzVCtBuoCGy7bItgOXc=;
        b=n4zoNme4UEojoLgrPJvmG9YbXAxnBRtEFIy1IodbcY9axW48ufAVDNpf+NZ+beoWEO
         /5Nv+zbuyGIU9QfJth62xrTHl7rHtFLAoeosdZMFaPeP5kt9dLSL7p4Cdf34caIJ7Uty
         7LG5FDLwTKG7rzcT3ovsT1QuWzx1VeW+nW7DcRMaotAQjwj7jzQb0jz8Bsinyas2SI08
         g5NVjC0064YQe6Y9XP9wK+GMtqtmHvkMEvOUUvWQDDMdr+tRs9MhsZ7ybe/UFEODfAe8
         iP4tniBWUc91R1f/q6a4KWwQMHVVNTq6JKpObOja6ZroSOfiSIVhLnl4vcI0jauk6eu9
         KVzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsyzECEvPSjeP0Y7xZUkUup2FKIVU3DoMo+7rLykqcdJjpdyN/me5SbooJNNTFfBiEJNB6sDDEUQqgVPA+eq0=@vger.kernel.org, AJvYcCXIi3CwmIwxAiceK8WEBbAwe7R/wNGT2s8Cr6bpH10DjroFCw3XZvxMJgLfRtkDzdRjR+JhZvsQUkqjRRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhgzctU5Zcfg0L3JqyrLUhLPGvpz4wVYB/ZnE5mdwfE6KRRMuZ
	KL6M4HbDjs3CAvIigAd3xUPYqHDNAJRrWfJF68lo9I1N/S5Jhjjr4Y3up+GpcCO2nN7lHspRr5N
	rgVML0t9/XVYagtKAXivyVDfDexk=
X-Gm-Gg: ASbGncvx1/YOXtV5296Dht7UzHetTOh7CLtYySnALdoqxBaMKtI/SurX1dj6Xcsm0TQ
	Yjx1rFuajafiPPIqAOhaGHwSW8FxmI3Q59eTkAKQlJKOgQXDWOhobKrSGwJruQfpv1xx36d0F2T
	WjI8Mus1nB
X-Google-Smtp-Source: AGHT+IGWvtVF8xWWD8RBTOvu+8xeco4voQOBMX41WoZV9Ovk1e8nbIdwzOdsmKqOtELpZ+dTqQfiZ1hmxeZZjvkc79Q=
X-Received: by 2002:a05:6512:281b:b0:545:a2f:22b4 with SMTP id
 2adb3069b0e04-5493c5c0efemr2758222e87.40.1740584460979; Wed, 26 Feb 2025
 07:41:00 -0800 (PST)
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
 <CAFJgqgSqMO724SQxinNqVGCGc7=ibUvVq-f7Qk1=S3A47Mr-ZQ@mail.gmail.com>
 <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAFJgqgREAj-eP-d244WpqO-9H48ajZh83AxE31GqoONZ=DJe-g@mail.gmail.com>
 <CAH5fLghEMtT663SNogAGad-qk7umefGeBKbm+QjKKzoskjOubw@mail.gmail.com>
 <CAFJgqgRxfTVxrWja=ZW=mTj1ShPE5s-atAqxzMOq5poajMh=4A@mail.gmail.com> <91dbba64-ade3-4e46-854e-87cd9ecaa689@ralfj.de>
In-Reply-To: <91dbba64-ade3-4e46-854e-87cd9ecaa689@ralfj.de>
From: Ventura Jack <venturajack85@gmail.com>
Date: Wed, 26 Feb 2025 08:40:44 -0700
X-Gm-Features: AQ5f1JoXyOl8V4-EvSRgg4-KWz-YXXimRSHqSWOPiONotHcWRZZoZ5sJPppo77c
Message-ID: <CAFJgqgTTgy=yae68AE29oJQc7Bi+NvkgsrBtOkVUvRt1O0GzSQ@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Ralf Jung <post@ralfj.de>
Cc: Alice Ryhl <aliceryhl@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Kent Overstreet <kent.overstreet@linux.dev>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 7:14=E2=80=AFAM Ralf Jung <post@ralfj.de> wrote:
>
> Hi all,
>
> > [Omitted]
> >
> > Are you sure that both stacked borrows and tree borrows are
> > meant to be full models with no false positives and false negatives,
> > and no uncertainty, if I understand you correctly?
>
> Speaking as an author of both models: yes. These models are candidates fo=
r the
> *definition* of which programs are correct and which are not. In that sen=
se,
> once adopted, the model *becomes* the baseline, and by definition has no =
false
> negative or false positives.

Thank you for the answer, that clarifies matters for me.

> [Omitted] (However, verification tools are
> in the works as well, and thanks to Miri we have a very good idea of what
> exactly it is that these tools have to check for.) [Omitted]

Verification as in static verification? That is some interesting and
exciting stuff if so.

Best, VJ.

