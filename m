Return-Path: <linux-kernel+bounces-445228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0129F130B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E461C284687
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E2D1E3DEC;
	Fri, 13 Dec 2024 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D7U/RxCy"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED731684AE;
	Fri, 13 Dec 2024 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108977; cv=none; b=mrJ24GYFmstTi18CYCfbacqjNGCKoVm0Y5tqRpep2OWDTv0DJFyDTeDdnRDe3Q2kEh9gWCj95rkY1wtipnSqzEZAoERfn0wnxxYfqEBS7+77B7f3KYKL2wSABrPW6A7tPbr+48NeVwgTyywOWomeEGrAA1n86ACub8fzgoGIEHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108977; c=relaxed/simple;
	bh=QDu92WMRvCNzYowrSM2zgW9TeimKB2kSvwDc/TXJfuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAdx86BR4BHUZZKpHlRS/riHZtyuQ+cR2kPmdVbsq9elB/xXcXHiGmrEilY0M9JlKQ+bGWfBqpXumAJ+ev2Pwjz4cirrRw2/emFbyzOgTQdUcy2Zl6NtufS61mqm6qYAts59ONbfbWFanI1WNTC1nYPQmVa2D2kbgvqTPRidsKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D7U/RxCy; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffd6b7d77aso22071861fa.0;
        Fri, 13 Dec 2024 08:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734108974; x=1734713774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDu92WMRvCNzYowrSM2zgW9TeimKB2kSvwDc/TXJfuU=;
        b=D7U/RxCyW7ehvDndWaoyuZSdiCDCppmGVYbzwWgIrAbOR0t21g2gdnj3spliKj4phu
         bhKClgn7gcbsrruDidaDhWT2H3uUC4PX+U3r2zx+j4dTfm+CzOw3EdkRp+HBQqSZ2UHR
         LmIxK9t2hmC5OXYQloVJkiYX8KPFOuUDb24bauHyaVcn37zGtAP7DPlZXODC0PVmeGTL
         n5iUorNuMsBAWPKQGS6R2dMwiZ/k9KrK8ZKMdDsPLJV9PDBY9MXaK3kRRtvH8f+1aHF3
         i2VTNcRnKgSKzkDzcxPjP1Xrx/JH+styq6OUfuC3i4BoL8wLQZ1lG0Q/7mLJGTqGgJEk
         gcfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734108974; x=1734713774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QDu92WMRvCNzYowrSM2zgW9TeimKB2kSvwDc/TXJfuU=;
        b=VnXeqA63DqCqrCTWa4J6oX0SNsY8C4qdm51hR0QKIo7OAySBqtWhOeWl06115KsoG2
         V8fLv6SEV8b62tP7tAXAtnwbS29Lk+qt/jKxZ4P8U99/cnvT3+kgKspMi83b+3ERrpsm
         sIpkROhIPltWSzna1kRieXs/tdvT1jTjTeUOjPKQLIvSQcosnTDFG/VlSTrg6oMj699y
         hmZvPaU3FPb757n84h+HneR+5Q6C75OieVhwOq3CC7XV4s8gEfmejt6vI5LLEQeVDQOm
         VUbzJmcYw7lzwe8zY/S31vNlmY7l+w+VYrwpsK29rw/BtD2hPFLKPnfdV8J7r6y6zVz2
         W8uA==
X-Forwarded-Encrypted: i=1; AJvYcCUaNkRTmDXZD46kkcp5d6akXVvAYGENDfji7nB8iwDjZJLnU8QOrLaFKBmtMY9jXFI7IfzJwa1Y3WbypMlCgtw=@vger.kernel.org, AJvYcCW8e/MDZh55sR2MtUH0Wva3+lYYJWlpQ/xIYZTe9526lqNVT3nDsiORgtFKo5LoAs8WjaYrtCFPxohrVn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDe9QXck5xP6EyzNGLuHgb0dAOmnZ4wWmRcDiqB2NusLRzTUlX
	TZ3osc9ewY+mF/AIMXZjAYGudE8dn1jmnIG+64LUQllFYfoDbgeCpsEb5FaIR9/phlCExibbZr6
	rr8MmsC7i2iT1LYbApnZue00J4Yk=
X-Gm-Gg: ASbGncvI3XGkwRE5LfElntIomBRn56BCuDXUeYq+GGh8Zy5zy4eIWZ4fSk948qNiJr1
	4uhYJmpOZEv+WRpYO5f2R7ORrBYVrj1OLeLyfvi27vpAIpZ1WFHI6
X-Google-Smtp-Source: AGHT+IEHmJc/LcMgwBVMSGVt9nxNDthWvphEJeIY5rd9j70w7ZM/3ixy5jYbC9YcXY1vwynX2vPejCVNCS0i9k+g2Rk=
X-Received: by 2002:a05:651c:b27:b0:302:3e14:34c5 with SMTP id
 38308e7fff4ca-30254611194mr13627461fa.28.1734108973901; Fri, 13 Dec 2024
 08:56:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212-rust-xarray-bindings-v12-0-59ab9b1f4d2e@gmail.com>
In-Reply-To: <20241212-rust-xarray-bindings-v12-0-59ab9b1f4d2e@gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 13 Dec 2024 11:55:37 -0500
Message-ID: <CAJ-ks9=GSJYSqTvbzwq9MPUPohFM+b_96pVOw4jRC6b=NTxYcA@mail.gmail.com>
Subject: Re: [PATCH v12 0/2] rust: xarray: Add a minimal abstraction for XArray
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Cc: =?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 3:31=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> teststs

Oops, please ignore this fragment. Having a bit of trouble with b4.

