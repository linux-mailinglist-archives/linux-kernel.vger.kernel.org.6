Return-Path: <linux-kernel+bounces-574251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A1FA6E29D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2FB016FEA0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A108264F8E;
	Mon, 24 Mar 2025 18:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTuqEDAo"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EE2261568;
	Mon, 24 Mar 2025 18:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742841837; cv=none; b=id/HvaAxwlzpbJfzqB1FAl4qfgKuwImrwxizAE4fwD+q8Bo4P6XWUpwF84MdZ0jOQNm3HkLii896Zf2HYCrDhQiK9PlBNJSCkpM97dGBX1A5DU323lwQ/lq7zA3x4RNkAUlSytOwq+k1O7n+f8B9lvIaAtxfLXG+FDnrpAl6BeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742841837; c=relaxed/simple;
	bh=iMov1ZOhncFsgdM286Ci8CuleD6X2zoM/gNTP2+28hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObNCIxku1vD2qz9gBC+L6eiYmESGrA6z8OFyda0xL/ubZdtm/lPxvZVUI/kkLT3zATGC2spCWJ3brmDKCNL4UNQ8c7fyQVXPIRv93DTFx3PU4ivZMzXJX0564PBBNNiLn9KqgQs/Bo80KZFzdfKMCopYW2Lm3Rk3MhROiXiQYio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTuqEDAo; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff6ce72844so1269240a91.2;
        Mon, 24 Mar 2025 11:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742841835; x=1743446635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDhZCTYQpfVjqWAeaYWpsSp1wpfRNQxkv4etm8lhI/M=;
        b=RTuqEDAoCGwcXWC2kMP6m0iyBsL3rsk0tOZncb21bOpSgRR86gjtJAN3NHL+IPutfV
         +MT/Y3mq19TN/ojTPZPNP0NQW9tavJSI4211Q1GDPTri2/0wEmrI+f61h1ehc7sYwQiR
         Y3yDCLq2cozvKdQWsnyTj/VPhDHbyTc9c6V5Zk9JcpOu31y4JW0sPpF0Dap/Dc9blHJi
         liTbPdUGWTnMZ9M1qzOz8r1wsrPMjBZ9rgIwTamN1kvsGYUthikS/uSOxeU0d+6xvl/d
         qV306XoNlIqXUQ0aTC3Psi2yiqmHBXmclk4GnNWvHTF2Aobk23afLVnoAP98LCf2uUdL
         AZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742841835; x=1743446635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDhZCTYQpfVjqWAeaYWpsSp1wpfRNQxkv4etm8lhI/M=;
        b=AR6URtHs+SZmJHH/sAn5JzRpWdcbxi1PDs4ds6gu8qkBJ+5FSVrBQTDLKRch15zbfm
         j2LM3M/loh+PV2R0OGzAmSvBPrYaFvCRlH/QLafPu4fVX3oy3FFPOQaXJG2VfgJhptDI
         c7u6B61rXKqwVkLGxYvBw8v32M7mMLkmRPtPEvYg1yROBCY37ky4mo9b5xhNQ2l5YXo4
         NS/bU68a2qS/wHiBf894D5f8e//3fgdRpqBlV8JOGUWdrImJQlclvWUp4zLJFQguuEl9
         /5HULp6Q4isxbzJt6NMiHYRWG8b9yysr7VcX6I5t8+pmEo4yFUaZA5WNEu+5zCrmgyib
         5k6A==
X-Forwarded-Encrypted: i=1; AJvYcCVt0YnSjmvUnGMPmKUqapLDIf53vy9Og7sQLaF/icLp3jMxgn+5VTkflL+hArCV3/nnQgYp9n2ET1qNnieloME=@vger.kernel.org, AJvYcCXxKP5WyWFj0ovurBj+HN26v1XDpw/XINdZdORTZLtebUhvcdt2l5XMo5qZiPX0GshrZxmkKzAULB2KCj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0yR5dIcpwKaZeDvUkf4MbJc5VByQ16B58uQsjA8/XJ+6EfFb0
	V+er3NtoDmmuLstODbB3LHWYw25oVeD3xgZrF94vRbxF5E/mm/1bFzmjIK/F2wHMtwJ7xzAFRzL
	QhufwF9JM9QRSYuQ6zGcoSD7UVzM=
X-Gm-Gg: ASbGnctzEn/fQkd+QkTsnbik4H+FtLOR7Ha7n9q/I+rodr2U3nhQNljWHmQ8vv1nnrT
	OId1M9MHkGuqjOo7v9QGmeceRsT38dL+ZYO11Q7Ff0tYWlZ8gldTxgmuc7WxElPbYy5hqXn1N4f
	DjhNEZGXyGakK7iPeiSrfNauLPg5PYbO6ckKGT
X-Google-Smtp-Source: AGHT+IGyNAuquWNXQ8BnCGJq15TIHzIgTVg6j416k3z+H33/HqAmOnr+27+fP2eK6DCAaVfDoLUn/2gDZU94hXSuIYU=
X-Received: by 2002:a17:90b:380d:b0:2ff:6bcf:540a with SMTP id
 98e67ed59e1d1-3036b4b348amr9879a91.6.1742841835419; Mon, 24 Mar 2025 11:43:55
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-gpuvm-v1-0-7f8213eebb56@collabora.com> <20250324-gpuvm-v1-1-7f8213eebb56@collabora.com>
In-Reply-To: <20250324-gpuvm-v1-1-7f8213eebb56@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Mar 2025 19:43:42 +0100
X-Gm-Features: AQ5f1Jo5s1OdGZqVubb6Tq-h2U2YrkskT9NsblmlA-2DdQThwVXaEW7IQM4bz4E
Message-ID: <CANiq72nLRe1TXqj5fjgknatwgR=RqUA9WmmwY9fs44fYS9yu5w@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: helpers: Add bindings/wrappers for dma_resv
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Asahi Lina <lina@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 4:14=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> -const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL =3D BLK_FEAT_=
ROTATIONAL;
> +const blk_features_t RUST_CONST_HELPER_BLK_FEAT_ROTATIONAL =3D
> +       BLK_FEAT_ROTATIONAL;

Spurious change?

Ah, this is probably the result of applying `clang-format`, which is
something that perhaps we should consider, but separately... :)

Cheers,
Miguel

