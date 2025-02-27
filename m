Return-Path: <linux-kernel+bounces-537278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22767A489F2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 21:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125483B2185
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 20:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEDC225A31;
	Thu, 27 Feb 2025 20:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IDRYMa2i"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79C119DF52
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 20:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740688493; cv=none; b=Tyn8XdFHyJUbaqIoFPJVbK0972pdrrEqurc5GUa6U6YV/DyC4qmV5RmsbTkP58exzgfQSGJulXFOOvnxy/MnP5m58KbJrzFAO3Yp5fwZAkJwT/+TqwEC+I3aoCml9ovfhGNNeeC/JaNTvrACoxafW/jfzKVgvRAYZmclaHUsQSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740688493; c=relaxed/simple;
	bh=H3HVkz+A6rXVuiDniuy3LDGPxjutY3NbEPqK++G8ir8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tbPw9D6uIeg3U3Btmn93vKoGxDiGTgej1EOZ7KWfUm6oHG+EYnRv1SWJIF1iKmGdj6uVGHy1PBYlC8YjT12yiHh+vAb9czyPh/INY46A3d285r6O52s5um07Y7o99hqmHj4YcwmiVqdOH6SK84O0TAAtPmsMA21zafAHM/xye3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IDRYMa2i; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so254735966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740688489; x=1741293289; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3iaC90NRH1e1Syvsd/il6x0lQMXHnv8BIHQEgKW5Yhc=;
        b=IDRYMa2i4QMquuHZ4neZOv433QaCVfCrz1P8OxQy4wrL7LBYWMXNgJ3LwekbY/Ogdf
         dqDEOJsbPPme40H+ptRNRDEPvyYnYsOSX575XqORRS/H9QSb8Xd46zGUbnbrhHofwvA/
         nDijBMywWyz3MbYg5xywT+MzOGRbgWsQV6/No=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740688489; x=1741293289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3iaC90NRH1e1Syvsd/il6x0lQMXHnv8BIHQEgKW5Yhc=;
        b=Vt0ucZYaN/dDZRb6U69PezXBSkLh3wbpUim3krLGUIrNNyh8GqpkKalHuYoV9TCrd/
         EBuM5dpBiyBCPWcmD6Ec4htUe7dlkQdMEjHvmvLUVAr/BNwrxz3VXWepA16UVKuwGEHF
         5+SiOts/MPl4Xe6FhrdPslpv62dYWE0Yk+n2DdLCFJyS0l2rtM6WZgAto7b6Ei+vozin
         bL7TVqwgr21rcXAcvtVsvcGwrJ8BDwel8YuwXSmAvEu1ZDc88ZysrrLgBUSO02ptdaih
         VmIKOusI27h7lkoXuL1YK29UR3V3CN06TpzQNgt0G90p/vD83XtNRfI5YjsRtd4T++Jm
         cKiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcWhn6vyxUTASYj3QsxWIRVZ3xXfrkH1hB8HEbAG608LbCmNql/yGqjSMVFlePvhyd19BOA441EP4/WOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMRKi6IyoBWB6cWVXgkeHG9yf8UBL+vNxGSDLAHYRE+N3AhOTx
	VLFcWStbaywUvJiDu9S7vpgH7p0sO1CJDWXtoErsAAq1BrDyrRFo5sYazh8NSM4ZMCIYlpMy6Fv
	+8sTkaQ==
X-Gm-Gg: ASbGnculmgqzuTZUPTDqXsj+ySLvpecjT586FFwmpWiyLqACRTnIGtFAEVogS48F+Hw
	jM5AaN2OAvAfX+Q4cJhxnpB6fcTFBwE9WOwYJ3GxHOrlGiaRgryoIJtdAc2EC/ZT76+wDY495En
	JX4/rCgC5RZRsQzDzvjYWCdMO9wmSQToMw61aMwNwQdipHZeOuZNfEbQkftuHlK08fnAFyKcxRB
	m1jODn74skxVNCXDkWweWO7H8sKG82eeUCEh4V1KRjTISuqNPIRd7By5PQkGAZkfirzsG9KLxWU
	uEy3X2Vz+9DWKL35+j2T1AUh64Rhv8u5HbCKu4EP7b7KZAVvoMkQld0VtzDNJ7nRa0ZaOuR3Wwu
	L
X-Google-Smtp-Source: AGHT+IHz3sL+t9y18znVnfAvijOczV+APZPZaEchPymb/h7YF6hCVWhWj9bjUBXFAraswPjslIh8lw==
X-Received: by 2002:a17:907:988:b0:abe:f613:bd0b with SMTP id a640c23a62f3a-abf261d3bcamr93333966b.32.1740688488780;
        Thu, 27 Feb 2025 12:34:48 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6ee491sm176639666b.103.2025.02.27.12.34.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 12:34:48 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dec996069aso2220763a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 12:34:48 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXFggjdmnbk+RMRmsT1VcJ8LKKEqKJlJAV6MxjqK9wXcjrYspdvjVX5psRc3UEapn318Rd8+Og4hT8KAM=@vger.kernel.org
X-Received: by 2002:a17:907:c50a:b0:abe:ea93:2ca3 with SMTP id
 a640c23a62f3a-abf261d3cd5mr91983066b.29.1740688108692; Thu, 27 Feb 2025
 12:28:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH5fLgh7Be0Eg=7UipL7PXqeV1Jq-1rpMJRa_sBkeiOgA7W9Cg@mail.gmail.com>
 <CAHk-=wgJQAPaYubnD3YNu8TYCLmmqs89ET4xE8LAe2AVFc_q9A@mail.gmail.com>
 <5d7363b0-785c-4101-8047-27cb7afb0364@ralfj.de> <CAHk-=wh=8sqvB-_TkwRnvL7jVA_xKbzsy9VH-GR93brSxTp60w@mail.gmail.com>
 <ed7ef66dbde453035117c3f2acb1daefa5bd19eb.camel@tugraz.at>
 <CAHk-=whLSWX=-5-z4Q8x1f_NLrHd0e3afbEwYPkkVSXj=xT-JQ@mail.gmail.com>
 <m4cbniqfsr5xpb2m7k53e7plc6he5ioyl2efiiftdmzod56usd@htwdppje6re5>
 <CAHk-=whEkEsGHWBMZ17v5=sq1uRe6g-BRHy5xNZK-2JBKRs=_A@mail.gmail.com>
 <0f3bc0e8-5111-4e2f-83b5-36b3aec0cbbd@ralfj.de> <CAHk-=wj37zT4Fy+mBFVRKPy=NMKcB6xBzqOuFrW0jOTv8LKozg@mail.gmail.com>
 <jei2vzllt5z6hufn3orqqupq3ufajcxv4zx3yfpkd2j54yr72e@vmhu4r3klvvh>
In-Reply-To: <jei2vzllt5z6hufn3orqqupq3ufajcxv4zx3yfpkd2j54yr72e@vmhu4r3klvvh>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Feb 2025 12:28:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgYCS6=TFfRHz_aG1HNFBDyLMnHgkvi_=B03-tX-OBtOg@mail.gmail.com>
X-Gm-Features: AQ5f1Jr2HELUmBJIPyKcHVA4YKc0nNSI_EcgaYvP2EtpcHUej5s4s67UyCptmgE
Message-ID: <CAHk-=wgYCS6=TFfRHz_aG1HNFBDyLMnHgkvi_=B03-tX-OBtOg@mail.gmail.com>
Subject: Re: C aggregate passing (Rust kernel policy)
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Ralf Jung <post@ralfj.de>, Martin Uecker <uecker@tugraz.at>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Ventura Jack <venturajack85@gmail.com>, Gary Guo <gary@garyguo.net>, airlied@gmail.com, 
	boqun.feng@gmail.com, david.laight.linux@gmail.com, ej@inai.de, 
	gregkh@linuxfoundation.org, hch@infradead.org, hpa@zytor.com, 
	ksummit@lists.linux.dev, linux-kernel@vger.kernel.org, 
	miguel.ojeda.sandonis@gmail.com, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Feb 2025 at 11:55, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> It's more explicit, and that's probably not a bad thing - compare it to
> our smp_mb__after_atomic(), it's not uncommon to find code where the
> barriers are missing because the person who wrote the code was assuming
> x86.

Sadly, judging by the memory ordering discussions I saw, I will almost
guarantee you that the compiler support for memory ordering will be
buggy.

When we miss details in our wrappers or our users, we can fix them.

And when the compilers mess up, we'll use the wrappers anyway.

              Linus

