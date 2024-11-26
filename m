Return-Path: <linux-kernel+bounces-422620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 369A79D9BF7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:00:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 515811643DD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1B01DA0ED;
	Tue, 26 Nov 2024 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2ZfD/a+"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0604C11187;
	Tue, 26 Nov 2024 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732640401; cv=none; b=GxBy2mUAW0nvOjCKln9gameFRkKIsE5qixuTGFX+J4EBLNR7PdfmzYLuyglLNYcD6OAMTb6i25GVipcl1FnA2Cp8GbPOXIAM4un8JxommoxFB7hnw/QLJ1ck2cFmbyzSCAZe376ZsL7BQECBMMb/hBX11ZNKqHyjdSrka69XTG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732640401; c=relaxed/simple;
	bh=MtRv4oOaXfK8SLIiralC2PpKvgtDrqnVngZfjWifN7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LqLy5hmc76fe/cDmm1GDxBMtTYRqhhKvzJ3hLOPjgmACAJHiywnfEferb53vpr7WZ2asfri9mPQlbaviIkKyci+3IYOhlT52XBNFXyvF7g3eRRVrv5P27M10COPryHceLx3renyp9LdjrC9HUS2GMio2Wo/ud11PlwtkYqKs1Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I2ZfD/a+; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ea501acd25so974899a91.2;
        Tue, 26 Nov 2024 08:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732640399; x=1733245199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MtRv4oOaXfK8SLIiralC2PpKvgtDrqnVngZfjWifN7k=;
        b=I2ZfD/a+FYE7UQR8DHpg10LEcumh4TDjteSfUHyZPLkP8V0+iF48nufS8rKDn8fzPu
         bB6ha247M5B8dP0Iso/4LegIiC/eqQ/KzscIJDh/gor6zSDZ9qXwMpyQXE10aiFtTyzP
         X4avYwp5/jSV1f/r3LydDZh5IcitGVHGS28nhprTu1S1j/IMkM8dRJRpJj2sRsAKC4rS
         C5NJEtPythShbKgRwIfFGMaiGr8b7iEFiz3Y1T2aRJsqtwmvbgExn2fs0qrCkPhrLsF9
         Gl3IP4F2RroaZLrGRq5NscU3mT2fRQqVvnI14szCF270RArWvXHit/tzKMrwR3KmNuM2
         wiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732640399; x=1733245199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MtRv4oOaXfK8SLIiralC2PpKvgtDrqnVngZfjWifN7k=;
        b=h/uCvSpqxZPz+wp+hExnEyHjegalHEYXGlZai7fV9D8sGKV39OEyclAFNL1vcZm7Al
         Iyfp2hdPi0b0fvoV8eIKobcNZHEBGbRAX3dv1vS1Ys1jsSdB1oHNPKyCWJCFpGc1ZK3t
         QuQtLBnEBeyQdYcUzzOwbzU5Mi54Nwro3bC40O/qQIzHJJwdhWuEOCaCb8dDkUI6zcjr
         h0tKLWoJJcyyk7xZPKCphuZAI4BKPK43qs8GJSyAdzp8xGKXOuV1IdNJj+pl+uMU9y4R
         Ap6WhtNmmFw2jONU1WpfUg3Xyc2nUDdjhBrkaqJuzhxOj5xuP4QHzi7MQv3pTcz00lUv
         qyug==
X-Forwarded-Encrypted: i=1; AJvYcCVah0f9f+DLhLmmvpn6MRj7SZ+yMguQQSRT8j5U2Aoo/tgyVA62aqHyorHVH4pgvwB1GbQv0yHztYC2d3mtxfM=@vger.kernel.org, AJvYcCXNZYMRciBpnPjyGqIcTCU52L8o7BxI171LEs+OgxpGU5GnaKdJRvcCZBHET3HNAcVPqzjuc1Yt9i0NJKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvHPQi0QTcyCvT+qEHxVW4+JAYeZCwkDDSHqkRd/X6sw7L005z
	apbhe/c0UVd1Z7a6w0ZdCAQ8TCsOulCIuYzb/ceGJH5HyNX5AQdhtTgb+5Djj6mZvDR0/lcDtez
	8it6AwzpokaiPRpcBgEFTml8AOxP87ns4
X-Gm-Gg: ASbGncukTdReQQpPlpC5Gn2N99lI7C5StWo2vYL2wWXBrhWiQKKr4nRMphFc9hg8H9Y
	bDKTJRKSwEcXchrLAK8kjh6vCTZiu2WA=
X-Google-Smtp-Source: AGHT+IEI+qtdaIzBJqZlcFjlRD4+3ro4LBUFICzngU+d2ahdoLPo6qN9okcbJjaWdGONAYbUKMV83McdQFypPctu1gA=
X-Received: by 2002:a17:90b:1e0c:b0:2ea:9850:b2a with SMTP id
 98e67ed59e1d1-2ee08e9e84emr2322a91.2.1732640399273; Tue, 26 Nov 2024 08:59:59
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io>
In-Reply-To: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 26 Nov 2024 17:59:46 +0100
Message-ID: <CANiq72n2Js7gftu+56FYF-eGFmX+VxVW5tEpxF3v9RiBHxM2Vg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] rust: Add pr_*_once macros
To: jens.korinth@tuta.io
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Dirk Behme <dirk.behme@gmail.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 5:41=E2=80=AFPM Jens Korinth via B4 Relay
<devnull+jens.korinth.tuta.io@kernel.org> wrote:
>
> Co-developed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Jens Korinth <jens.korinth@tuta.io>

I guess these tags are meant to be informative, but just in case, I
thought I would ask if they are here for some other reason, i.e. if
you somehow want them to end in the kernel log.

(It may be less confusing to simply mention in the letter who worked on wha=
t.)

Cheers,
Miguel

