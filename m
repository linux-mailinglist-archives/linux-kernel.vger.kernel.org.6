Return-Path: <linux-kernel+bounces-420665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C109D814F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 494C716302D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E3718FDBE;
	Mon, 25 Nov 2024 09:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="14odxsV1"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A084218F2D8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 09:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732525754; cv=none; b=A96fgBw0hdCQNDwq7HJLBI8Ij5Xmsg02ndmzru9CACcA2k5+rZ2v0DxI+fduuVNfx70THcrnXlNIyAH3kkUs2JgkhdNfIFVlv/QvcLkFMvg+43d4VirAbP+ApVrcZ5xFVO4g5FKkTC+99ZAK94v7k7RiLrjjdLn+FkFk+SEQwDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732525754; c=relaxed/simple;
	bh=PZjr1Yu0Ay9y016nTeQBXSJo1HOEMk7mulrM8bVslrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uu2XQg6qL3egefcdSg9X93bXkOmWEQ6/V2t+dM+AZxQ4TNhF4ldPq3ik9TCe+Qpo+n7sGfFXno4NmpF7ynDH0RS+2acaAiypLBEPPWvAPKxjpdBSKnsHqOH428NpNPSs9bOV8JUC705TpRp/Ea9DCrs1b9AgO9Rzo/cEvzTVUwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=14odxsV1; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so38706795e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 01:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732525750; x=1733130550; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PZjr1Yu0Ay9y016nTeQBXSJo1HOEMk7mulrM8bVslrk=;
        b=14odxsV12Kd1R4272NNhsYLdRMyUVb+AZbTQGXjm2xFdeozOl/rlDvFKpgUviGsR+E
         tFe5xQj1BVvIqIQH1UPFeihUSdj/+X6dzmNLWhfmSRY4qeoL/C5gaDYsfSCLiCBqHbLZ
         TIMo4h+3+V3o66AEOlVuT+e97ozmp8gOouCPJ+WQLjpvupF25OpnWM2zVDZu0G4f0IhK
         KM23HsFLgg53i3XqM31uSG9Hvhb1h/eHEdaHozZmMJdIrS4OjPr9PxJ1rLeyP3AMJyKr
         zdwxmd7ApaQ5xH7bgROPFD95q0wOONlZ+1mHwxCHQtm20l7jjy1snyyPvr9qYZ004U3W
         l8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732525750; x=1733130550;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PZjr1Yu0Ay9y016nTeQBXSJo1HOEMk7mulrM8bVslrk=;
        b=kvFvofWihNBnQMvWh3EWRiEVFwgiQXhVzG7ooc9NcPjvmyRGl3wSjsI5w+qlt63Ihs
         4HbHeCGoLaOH75yccO4W8+6a4GjOui+OZBTzs2VJHsfS1NddjsbVwe4sfU5i+NU2uqKT
         81qHmGRgErIikPI0lTy6juYnIbMtS3Pc3m+gYu8/S4kr6OVEVLQdHHi+LMDydMiEoEWl
         S8vLsqU/ptIMxCvRXSDe+1pJE+p+r8KMlD5vtEcyl7E/nxmDOh9GR15TNEeqDIgHYc/N
         Uacbv6I0YkUe2cwXWH8h70sA+P23Rm38+36Rh+C73MsDOvwPVx2puKKSXOTSeQnU9F6Y
         ObEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX67s/OTa0iS+Mj6Bp2KS1KDkl84EUJAfQhtINSje8Vg97M88ynOj8t+6BKaGgPQM5WreKzwM310IYHSdw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnbGe9b95ljPsJaHG2QuISdvfxW9JnzOo1g2RZWQEQm+KGjWMS
	6ThsLYm6OfyZMNK2l+WDgDH0UBaKHzRhNXSqOog1ycV4XZIksxHhxbQFUcnnQoeHfKD7HsBrVzU
	//dTjxoh7S9UbqM1ShpXjJVcbbSR+w+ymuH4H
X-Gm-Gg: ASbGnctqB1XQKy7ty/h1gPSJRgEKPHSm10bmAK6X3NtOdpuvYDMN7QJCSepmADc6VoO
	/xgwCQP2cafu7w6LV4lwP3S7qkXV3ig+xcb1cTD95wMcL1KTQQOsV5boQUnc4ig==
X-Google-Smtp-Source: AGHT+IE7Fba0mueXQruBT2O1+P0k/ZOupdomBzRzh1mSpCPpLePxV1BgowFf14yqcxgVhzpT4h9Z8LLvXCth5luslj0=
X-Received: by 2002:a05:600c:3aca:b0:431:52f5:f497 with SMTP id
 5b1f17b1804b1-433ce4253d2mr111486625e9.9.1732525750068; Mon, 25 Nov 2024
 01:09:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123180639.260191-1-ojeda@kernel.org>
In-Reply-To: <20241123180639.260191-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 25 Nov 2024 10:08:58 +0100
Message-ID: <CAH5fLgjdbyFADFZQqjFP0o2eohKjtrbVq_-_d341-TU7aPtw2w@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: run Clippy for `rusttest` code
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 7:07=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Running Clippy for `rusttest` code is useful to catch issues there too,
> even if the code is not as critical. In the future, this code may also
> run in kernelspace and could be copy-pasted. Thus it is useful to keep
> it under the same standards. For instance, it will now make us add
> `// SAFETY` comments.
>
> It also makes everything more consistent.
>
> Thus clean the few issues spotted by Clippy and start running it.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

