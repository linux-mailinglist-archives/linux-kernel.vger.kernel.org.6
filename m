Return-Path: <linux-kernel+bounces-268198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F87942187
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2D1B1C23675
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AA918DF69;
	Tue, 30 Jul 2024 20:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NuyD+pJZ"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C671218CBF9;
	Tue, 30 Jul 2024 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722370976; cv=none; b=rNpEZlneRBxw8hlXCYVGQe//TIFl2p+FEm9UsXToKJniWAJO4bxlyfYGChmN0U9Zx0VA8NjQke00BM0AphKGJiHZPg7SDramsO6WEliATjnTg+YCP89rybh50xzwGWQAA4Mk51if+wXM1AVvr6DS23H+WBYVSC3gjlvbmqICiHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722370976; c=relaxed/simple;
	bh=qgIM6c6I7ActKGrTkv0LUY7kFUEtEmpH3NypCwcOYbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RiEcNDCsRc1OOnnYtCqNQrCbRxC9weJo09mLCrXyiWoPX7dPgnQcvcHXDq206V35gUAb9c6vsK7aycT2IIMIV6UpTmrlai3VIJR26xMmDet4uwbjSbN6iLrMbDZ+pArk/x+YDrgi2jrAvnbtuSVVi2FiiCkXUu/WODOsfTPuC5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NuyD+pJZ; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7a263f6439eso2828656a12.3;
        Tue, 30 Jul 2024 13:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722370974; x=1722975774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgIM6c6I7ActKGrTkv0LUY7kFUEtEmpH3NypCwcOYbI=;
        b=NuyD+pJZZiwe/nDPxhbU+06l9PD2+4u6zRl4If9ecw7njvKGbVjeviKVnIcRBaA8pP
         2p9FlTrEl3cK60lxqgQK/hDUsjdD+XkqVdT3y5R/tX+CxFi/rbIJH9qnUkkhDJusuTMo
         Vesk3cy8Rfsl3bLz7WxgiJojmXc7bzmrDPGukJ2OH/LYal9KBAgFDn4buItsW6uYRqAz
         5P69Bk3bRZ6Yd/h7m5dhOcbsON4zLUIMhm5qfyO1qXcrV/HnssbmeZ9Le/vmy6VVX9Vw
         VHSGTfqCl4SjA6BuZqqEJMnGpckiKoH6dtBj8eac6essgH1Cyi4/YsOs9Hh7SuG/gEvP
         jQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722370974; x=1722975774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgIM6c6I7ActKGrTkv0LUY7kFUEtEmpH3NypCwcOYbI=;
        b=hfw37Bc4Pxmv2ql8QPXrJ8sDDvuDteprYJiUNA2V64Hi0mK6miKfu4SttwCRmrt44f
         XGUySPIVd9JLUfyyWeYwmPWYzV+YWm2X9RUkvFoGUQT4SvW29FnsoaJxmy+9JlCznOJg
         XjRYw0cWSeP/rIO9L/DgUAzYcCGS68Z7lbmgrXWVXnw20aYT1CBw25E9j3C0n9cQRLD9
         7AXamo0/8ZZvZBEFQvfS8wfkNJmsR6S7Lh/iEIu0usriP4xBs36y5rivJr7vaxueah7q
         OlP2h0bDG5wx8FwQbrOjYCiPhJhwFseqXcqLt7iQgV7sW8Ko9NQmThKlH8o8hMmJHonq
         aj7g==
X-Forwarded-Encrypted: i=1; AJvYcCVLxA0hvSqhCpApqGa52ZChgpeJ5OoLu0tBza4Kf4Qzhc0BK4YYeTIdQ/0ECB8HmDovG2X5l4s7QZ8h7MMIh1wj9WfYKerQaYFQWV8T3/PcFLf+BkMYGDxEu494TeRZ8BJzo3lw6atJoLlBT34=
X-Gm-Message-State: AOJu0YyY4+Vk7NsAgQ5RvqUC+1BuhQ1w5HUA9dEfajYo8wZslsu3WyyZ
	EmJ4AX30Wpw1/jf29DPp/K7DHmPe9OMQ6GRNfzL53vA+XmVHdr0aQVi4CV5tQau28FXW07UoUQG
	UKwhnBPo9a1DOFBQJCPU56azPHcM=
X-Google-Smtp-Source: AGHT+IHCzS/rd7b1oz4vmEzbNtTxafJlsZS84UjHMW+33i7wxde9VAxzqRvvwyZppvHikLIMBEJEM7F0XUjrbhZBkok=
X-Received: by 2002:a17:90b:2248:b0:2c9:74f2:3b24 with SMTP id
 98e67ed59e1d1-2cf7e1eda57mr10326001a91.12.1722370973899; Tue, 30 Jul 2024
 13:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730155702.1110144-1-ojeda@kernel.org> <CAH5fLgj-0EsVjh8xdV1mXZBXPxKGnwUa8-R+Bg1eyjh0Gh_BWg@mail.gmail.com>
In-Reply-To: <CAH5fLgj-0EsVjh8xdV1mXZBXPxKGnwUa8-R+Bg1eyjh0Gh_BWg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 30 Jul 2024 22:22:41 +0200
Message-ID: <CANiq72==6_Km_UYWaxxWw4gLS0g5yK5dQYvq+2xGTQvmm4aHyA@mail.gmail.com>
Subject: Re: [PATCH] rust: error: allow `useless_conversion` for 32-bit builds
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Christian Schrefl <chrisi.schrefl@gmail.com>, Jamie Cunliffe <Jamie.Cunliffe@arm.com>, 
	Sven Van Asbroeck <thesven73@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 7:55=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> The formatting here is a bit weird. Perhaps we should swap the cfg and
> the comment?

Yeah, I don't like it either -- I reflexively did it because in the
safety series I am sending, there was a case where it would not notice
the `// SAFETY` comment if an attribute was placed afterwards.

But for blocks like this works fine, so it is not needed here, so we
can change it, even we may need to be inconsistent in a few places
about this, at least until it is fixed (assuming it is indeed a false
positive).

I created an issue in Clippy about it:
https://github.com/rust-lang/rust-clippy/issues/13189.

Thanks!

Cheers,
Miguel

