Return-Path: <linux-kernel+bounces-441297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D615A9ECC73
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 13:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DD2188AC6C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 12:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3889B22C348;
	Wed, 11 Dec 2024 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DYo1AQda"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D50229144
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733921004; cv=none; b=mVF1rCOKShBUcNsZT7/Jt95EDxiZThIJtlzJum9p8RjXLhE7IRc0LmMwp6kGSLPKIqcVdvzZMRb+J1lbHlekg2oQ3EzB7v5JPARar+65DK8Eb9DJdlvL6dbvfX+EYXUNvGrLYVjDbYILh09iQ1oWe5M5wCxJIyKuvjIs3gto+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733921004; c=relaxed/simple;
	bh=0Yn9u0INepPlrghMNGHYHOrPqJ4QCbTtXMccsKKt37A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n63X/nFpBM4g6tVrnKkStt/zDwDyaBHa5vN2LJvEzCF7qxZcnnGzceoxD8AJeTUOCZwV7osq6aAM5Q11RlBZvPjLid7ADbCU1wiALG27aMfNHiu5wMMzm8EHG87C4f9C/EPiF8Bliiom05VHicfEI81ggnIqY09PJuvCGDg9N6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DYo1AQda; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385df53e559so4546366f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 04:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733921001; x=1734525801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tLcil2f/sIEpvxG1bvJluOHhLLNVHtLVp0fHF6xoJ0=;
        b=DYo1AQdaQBAIEuOhkti49t9ni4vBDwQIbyM6wI43OMVLrIEQ1rRI9G7dg2mmtko/gf
         tQ+HXMHoMGpziFrNmICyd5C5J3/9mjWACAFIXIONsp1bX6SC+/FqmxrHSBl0/PYWW0xJ
         PNdg+w4DOyERkytwnAmK+Bk1UqRF35pPDh7KBf6O5j1CEurl1xFcn249qoX+67nf5Beq
         YtwYlKEiy2gdlyrWZzdMLwG0tFNucvl4e/4XDQe0J/KYE5E8oNFP0uDiDAFJBi2n4MTq
         gJ9SO3wk+Umg5L1i0paDEniwFGeiIIGigLCaSLlOPSmERziQI/j5BC7DIvUdAJRErXxk
         0q3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733921001; x=1734525801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tLcil2f/sIEpvxG1bvJluOHhLLNVHtLVp0fHF6xoJ0=;
        b=RCc0ah5IkIyURrjk1E/dK7aBcz0TWmICkZMFmj2Bm7Oikb32gQ2GWPUJg2jRyE8xy7
         H0F2xMd+G8+2OlayoxGCRNP9sYNGHXAvncqOLLgk67Hq/K/AL8hh6ekVNWTUyB8WLm9q
         VGF7UwnrSWILUvyk3Op0eJ//bvf3cd+9AwRtfygBVRy5RzjlC4ZKHtCvTn1itcBzNMp7
         tff+i/eeplPmOE4upz0DjLWwfG2Opng8W27YyrxObXkC7W80y6vgEqHN7DXVrAZU6lJt
         tfvoschyCR1b8ty18z+HLkyzTfVPEbvu05VkuRjBeP0kUpBrg64oVMUieO5dzwMhFmLM
         RjfQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2OGNbWYpUAMWVKlXbdUykgBkskIL3qKE83HaJRBvb7LqqjydyCuny7mMn6/VSGxfXVmPKBQ1+mK2ca/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeLy1P5Qk56PrIbNDz0IuEqbGnQhKmb/dBp7y+cUq4Yq2sBnFz
	J8Go66yKJsg0bQYDaydD/f8MPxFlgy5+twjPQHtOpVZuENCqPXxaHHDwE6hAzRkEFT7TDnpbsXI
	0fn/2BU1stmO4NNVSGMXLkHRXZ/yq4TGv+Q83
X-Gm-Gg: ASbGnct9fjiBMPt862VubSnIvoRk03EeJVi1a7vY9+NroPIM9pqc75cARgL7pgcV3qh
	1Ba1mw0ydc9yi8ZBSfYedT232SVH4pXBVIGb/mLY3MYkqP+WQu4xpeWCnDbJVx4XvIQ==
X-Google-Smtp-Source: AGHT+IEduiJ/qcw2i54PCWdeVjWutL/RI21JMHnSbZRK0TIfzJWgWT07sIelSp8i26tVpPG0uZ/D+1PECxXqbXkDGsU=
X-Received: by 2002:a05:6000:1a88:b0:386:4a0d:bb23 with SMTP id
 ffacd0b85a97d-3864ce85f47mr2585264f8f.11.1733921000608; Wed, 11 Dec 2024
 04:43:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210224947.23804-1-dakr@kernel.org> <20241210224947.23804-2-dakr@kernel.org>
 <2024121112-gala-skincare-c85e@gregkh> <2024121111-acquire-jarring-71af@gregkh>
 <2024121128-mutt-twice-acda@gregkh> <2024121131-carnival-cash-8c5f@gregkh> <CANiq72nMkzHLb9gi_i6RbQYkzP-1W5QbtGVx+z1f8nfp3y_CwQ@mail.gmail.com>
In-Reply-To: <CANiq72nMkzHLb9gi_i6RbQYkzP-1W5QbtGVx+z1f8nfp3y_CwQ@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 11 Dec 2024 13:43:08 +0100
Message-ID: <CAH5fLggzx=UinvxZ=XFZFTcfv7LxCzJWk1jtLpgNrKZZU7VK9A@mail.gmail.com>
Subject: Re: [PATCH v5 01/16] rust: pass module name to `Module::init`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, rafael@kernel.org, 
	bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, tmgross@umich.edu, a.hindborg@samsung.com, 
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net, 
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com, 
	j@jannau.net, fabien.parent@linaro.org, chrisi.schrefl@gmail.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 12:41=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Dec 11, 2024 at 12:05=E2=80=AFPM Greg KH <gregkh@linuxfoundation.=
org> wrote:
> >
> > Or does the Rust side not have KBUILD_MODNAME?
>
> We can definitely give access to it at compile-time with e.g. `env!`:
>
>     pr_info!("{}\n", env!("KBUILD_MODNAME"));

I guess the challenge is that we need that to get evaluated in the
driver, rather than inside the rust/kernel/ crate. Perhaps we could
have the module! macro emit something that attaches the name to the
module type, or something like that.

Alice

