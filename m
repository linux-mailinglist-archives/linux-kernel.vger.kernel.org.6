Return-Path: <linux-kernel+bounces-387484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AE99B51DD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 19:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9301C22BDE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 18:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C622C207218;
	Tue, 29 Oct 2024 18:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMvn0w98"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898CE1FF5F0;
	Tue, 29 Oct 2024 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730226640; cv=none; b=DP8euOQz4z24TTnxQOx0AfoMt9+fp5AMXDk2kVYpchjjIy2kcl8kUTOmdGqnJRtbf/Lr02NXW4ChPUlHr/C2ZrNh800oRsP4LZymoQj75imnby5TW/ocO41ZvY/HEUolaFbOdMY5JOqX/tNNfrPRZ1g08cEhvZkMH+BxJT/km0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730226640; c=relaxed/simple;
	bh=3ZP2iVlE5Tk4Nvsy7rN1WCyPqQB0ImSPOR5G4ai3qEI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqdtxde3icQauZzCbPwHdKBFT8i91dipjVY7gUGoX6X4CgC7B7jZhXDd+Jwq0K+F1FQPz6F/AcHOe9e7yj7QEpEtj77aRM+gIIF++8D3e7Jk6NESNkSzmVj9KY3J9tSClt+JFw7OPESoMHW8BARyGp9S3O7n+O4BYhXheyCkeyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMvn0w98; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20cb8954ec9so5341485ad.3;
        Tue, 29 Oct 2024 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730226638; x=1730831438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ZP2iVlE5Tk4Nvsy7rN1WCyPqQB0ImSPOR5G4ai3qEI=;
        b=nMvn0w988fzDOJrkdxtljKZs6rxONMt+qxztGfbZWTecdYatqp5zf1rgMxmwM7M59U
         aoJaC1v3+tyZ975PdPx9mHFgFWusS9yh9SEpgHBr8IGqOtxziSesCRcVz20QY8paEm1/
         cVr41bnaLcLSmiXi37hJyPj4jEuzU4JzJ2WJPYR6zzREuTZTPluqpb5yEq+HmdDNbUYv
         g7nNW2BFqw+0eQ+Kdxn3awZzaIV20Y3Ax/+ioqmIKCape5jxWtlsm9HMk3oo05a54VFW
         +8o/q+dcKki9U63OBQJ24jux9RNGgS85U1VkzNYGurNfYHCk9LOW0qlzrMJzN/uJfkQ1
         4RYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730226638; x=1730831438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ZP2iVlE5Tk4Nvsy7rN1WCyPqQB0ImSPOR5G4ai3qEI=;
        b=Gr4bwotMUuj3xtkYZOW+bTixtITFlOsg9mL2oociyK3PhfQE+93IIByHkqlgq/dX1O
         29vkCxWrAJzqMY8K9CEzzMbCz7u+Tw+PKB1GZp6XKmQldidYkwNiqxmS0QeMtCNdzaqB
         y3ScgYJNgCKcM8u8yRp9QMYQvLsTI5nT3k6ZGY8TuGKNhTie7Abds9O4NSIl8e32mYyc
         bqmGwt4kzb9StMueer9fz440rdMF7YJ5tpaNFGCditnzpW8wlN8N6bkEgPaIb4u/VEWT
         z1APOOftLQe5f19rzT0OqvzD7cmkS+cz5mxQOuVtF3yOgdpg0f5W7W8NxKxQjtHV+ee5
         odXA==
X-Forwarded-Encrypted: i=1; AJvYcCU20VVvd4oGwa0wiSy/LewAdFA/FvYPKPIH4RH1/AW5rxpCTz8ZW5I+Bg0Ag+jCKPTnOTf4Q+ho/TLVjdlc@vger.kernel.org, AJvYcCU92n+G6O3cudHqxZhOT+M7kKJdKrZfUAzhI6NlvFDlZDlKhz61GJBF6gh9krqxA+F5qB/toogZEIKx@vger.kernel.org, AJvYcCXDdZTOd2NFtsVAOHe8t19xwcG42j0CJHi+KYXyvgABijej2BejXD6Wn8/+SuTy9aHkcHnIHLohnUFJ3zOFhvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIINeKrDvZz17Q9w4iFR5Lanz8SsqWLmvQX5vogjNlZfIFyNeL
	el7NnY1iHe7XMDktRhJKDRCgg/wSgFSFom3jcERg8Sz7c1xezif1Sn2tYG0BtEVyQZHe/QTpv9b
	B/r7SORQ40dS4rLZ6o8ZEv59yXdM=
X-Google-Smtp-Source: AGHT+IF+LYk+SNJHXdKzo6rPjy4jasC2oTIS5zxw8TzBEZC82Qq7ztbShrVy9uFmyY5DWx+QKbphQZ1EZXCQXpFI/t8=
X-Received: by 2002:a17:902:c40d:b0:20b:7ece:3226 with SMTP id
 d9443c01a7336-210c6c0f65cmr75680405ad.5.1730226637845; Tue, 29 Oct 2024
 11:30:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-rust-platform-dev-v1-0-0df8dcf7c20b@kernel.org>
 <20241025-rust-platform-dev-v1-2-0df8dcf7c20b@kernel.org> <CAH5fLgjhiLUYPgTt_Ks+L-zhWaQG5-Yjm-Y3tfh2b2+PzT=bLg@mail.gmail.com>
 <CAL_JsqJWPR-Q=vsxSvD7V9_v=+om5mRuW9yYNqfavVRUwH9JFw@mail.gmail.com> <CANiq72=db5jQhup8JGZT3_93orrVQt-5pwPvSQb3k5j-eW7rdQ@mail.gmail.com>
In-Reply-To: <CANiq72=db5jQhup8JGZT3_93orrVQt-5pwPvSQb3k5j-eW7rdQ@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 29 Oct 2024 19:30:24 +0100
Message-ID: <CANiq72mrD-TOAR3WJX=HmZV+r0X6wifmoUk+_ZCBt7Q+hz3M5w@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] rust: Add bindings for device properties
To: Rob Herring <robh@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Saravana Kannan <saravanak@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Dirk Behme <dirk.behme@gmail.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 7:29=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> trait and implement it only for those traits, e.g. see

"for those types"

Cheers,
Miguel

