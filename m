Return-Path: <linux-kernel+bounces-178798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D468C57D1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 16:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 320961C21AA9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 May 2024 14:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A954144D3A;
	Tue, 14 May 2024 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gkndv8e7"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E456139589;
	Tue, 14 May 2024 14:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715696609; cv=none; b=S9cGNXZCqnLk0OLOBlrI6XARr6NuXOZVW5N9bo9C+mhS8uDrQsL1/xK1763vLTznlB2ofFO5XEmDpWFfsCJiFgN55g0RRMf/8OxsZ2VKb6flP8Kqm3X9nRGDVBRx+RrzPmqAMC+qJ43FV5APVBIAXK3CUMTMEQ7/ur5Z7DXrjmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715696609; c=relaxed/simple;
	bh=BjB/g1fsGgJ3ndb7UWh4o1aNB2C9AwXmQNr5OwDHHdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qf7PNQMmrUOGs759qrwGDdC8O2LQZetacF5+Kzyh5DwBpGb+czq1R4vsqDlQ+xSRPzWdiZrWT0G4qRzKDHHpQDJAZsAN5CTHqqzt2Nd4bfjEh7iQ1jKSlHM7kRM1vR3bA3+JM0DPgIUI+H4Br4q16eD0NoGIHBBuMoM7Bgnk4eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkndv8e7; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2b38f2e95aeso4605357a91.0;
        Tue, 14 May 2024 07:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715696607; x=1716301407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjB/g1fsGgJ3ndb7UWh4o1aNB2C9AwXmQNr5OwDHHdk=;
        b=gkndv8e75DDRsNJSBOPpRxLTsZTXKqIfCmR8tVoxa+cIyBxiKtiwKNpit1K8KAsDeZ
         gJ/XcZ5ZTLDzNr23sIGmHfhIs9JNvbcPrx1mYjbtui8rMIPGKyJVtGlvBaxb6/lsyFif
         TzyB6/LNLGjfSnAWZ+UZHhwW3YMfUG7050tEngG6ydQt5Jd77PTxYu4LD5inT+Ma054x
         LiEmNyPcg4peJ2JfXPD4WMwkgFyGqLuymYnlFMNGSSoMRPCC3LMGgCYxU33rwUUX9xyH
         KcR94uREX6oAf2KzaXzCkAF8z8lknG4AJAAe07vgzZ/YR43Ex/Uiuv1X3QRQGgxJgQTv
         sm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715696607; x=1716301407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjB/g1fsGgJ3ndb7UWh4o1aNB2C9AwXmQNr5OwDHHdk=;
        b=sguttgkb7PFXaO980FlgtWRbymxrgnkebVxTj4F1TA3bSGVRCxqiEv+GDHJUMzccuV
         2pEzFs6LCDH3DETAFDDJD7MWaq1qU4ZvoHBaovAnUNaZJbtMDxwdf+X7YKVIYhrrCl+v
         zsMkqdn1BQVpkx2NMp85QZMsDn3mgUNe497Nc4s3wOMQTjiWqotBeS/0qWo+3+08a1zp
         mYlHgbZYP1I+NvfmXsBN+574t1TxPj3n9vLixnp0JiqjS/9XfALalBELUivg0qA+15IB
         gi9dezJihc/oAid++MMDPdxfieA7NAFUKWysAKjU1VnYHgERFYrEWo7VVbNCN6dnpglL
         JyBw==
X-Forwarded-Encrypted: i=1; AJvYcCXhVhwCcZ0NIczPKH+qEJ1g86lfeYGlUWq3Ma94a1OVoo+BxnwTrMGOFrlQmCPJCRDHCNUTNRTgIYXUO9haJB5TpI+swyq6NSo3gqc9HZhVmqjtHlvdlVQcGhyw3VJSRilD/VmowpbNASsWtvY=
X-Gm-Message-State: AOJu0YxDYASDWHMsYg7fP0MCC7R7DDmiuGJbhqYGRcMYLWMkxsDvcb9/
	pUEI9O1Y6tDoyRlkQ2eN/0X39oYUd5QfNnf8cf8Y1Jz0PT7HLJJ2F8y3Om/6RO6JZeYMY4V1Xk3
	rshR45zTKOXzLZ/lxV1cWfurZ9ug=
X-Google-Smtp-Source: AGHT+IGrpfIPpPXYQ37E8KEWcdmA/jU0l6Zx861SPQ+wHapaO83/5L5t4CbX2hTvpmRfK+jQ/s2HT7ASMDaSvm0oUAY=
X-Received: by 2002:a17:90a:7309:b0:2b5:9534:56d6 with SMTP id
 98e67ed59e1d1-2b66001a464mr21043668a91.24.1715696607584; Tue, 14 May 2024
 07:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zigj-lY5lnBSKuib@boqun-archlinux> <87cypvnpwn.ffs@tglx>
 <CANiq72nGHhgRjfMOhz=ss51q2egHYexPMVvWTr0RES9WAmMF=A@mail.gmail.com> <ZkNjVbqR6gYqg4YZ@boqun-archlinux>
In-Reply-To: <ZkNjVbqR6gYqg4YZ@boqun-archlinux>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 14 May 2024 16:21:50 +0200
Message-ID: <CANiq72nqkHazs-GRay_4LZViV43tDbCkPqWzqa28CSRE9DV7cw@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: time: Use wrapping_sub() for Ktime::sub()
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Miguel Ojeda <ojeda@kernel.org>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	bjorn3_gh@protonmail.com, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <keescook@chromium.org>, Mara Bos <m-ou.se@m-ou.se>, 
	"Amanieu d'Antras" <amanieu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 3:13=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> However, I must point out that it needs more than a customized panic
> handler to work: we also need to change the code generation (or adding
> a different flag similar to -Coverflow-checks), because the current code
> generation is Rust panic when overflow happens, which means the
> subsequent code is unreachable.

Yeah, definitely. That first step RFC is a bit ambiguous ("custom
implementations of `panic_*`"), but what we discussed was the ability
to customize the report and continue, rather than providing a
different panic handler. So the customization point function should
not return `!` for our use case, at least in the integer arithmetic
overflow case.

Cheers,
Miguel

