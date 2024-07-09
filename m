Return-Path: <linux-kernel+bounces-245319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E603192B126
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 845D2B21E63
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4122A14388F;
	Tue,  9 Jul 2024 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QByFoawW"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6195113AA4D;
	Tue,  9 Jul 2024 07:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510421; cv=none; b=GL1I63qX2NxMNP2m0e+BFfZtKyw2cYv0bIU3cd6HcCcoaFPorAEr1oNkEYEwNT9nollhhcuTZ6SLa6kOVMrQarQ55TNfDxZQkF4jS/z8ifBz+SeKMAT8CijhI687Jk61YR2JgaBHVwN0U9naJGckkPqaVw1KlUzHWzpEvmyolPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510421; c=relaxed/simple;
	bh=klDpcD1FMiSPwckMUv/XYdW7oQQyHXH58rQmFc+F2uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dLhEwgIJqG/xDueC/Je1GGe6nsMX05O+HeokW3azkTBeH/U7PHcRDjwXmULeM9BhBykJ1FXhzOkEM61Gy8dFnvQpARRBkZBSbuYwEvDAxI3YMd56xXdZSI+A5GczHuET9dezBVEuBr48mKhoDklWkVZP8Wkuet68ddQfyKP3iJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QByFoawW; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c980b55741so2836941a91.2;
        Tue, 09 Jul 2024 00:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720510419; x=1721115219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=klDpcD1FMiSPwckMUv/XYdW7oQQyHXH58rQmFc+F2uc=;
        b=QByFoawWgOZs91Bg6aof/kaehVCt+PWZ9WWywGgwG0q8RaAonxZBc4kyp+PUmm25E8
         DMvBJJdSn8nOUC4Fa5wxP+njLpvE2TBtbuyjUqffPPs1etULBbTIsfQ/86VmK0nqZXjp
         wcKMpfnbPQy7+dj6psJi8cFrH5ZJGfN9Z7mNcykNT9BT2A5pQGOhrue3ands1J4wHf0O
         7mh3c4J4Jruf4eeien+P/WJcRily+5Pwwt774cnJO41Sn5LhMqPJbCeY31SKuXyitFv4
         7nkeujoP8eAQO3dBUY1qa+AiXWHIJytyrE5W9PEejeRhWSEMVnqDvUjvjCgp9frsBsRE
         Uh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720510419; x=1721115219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=klDpcD1FMiSPwckMUv/XYdW7oQQyHXH58rQmFc+F2uc=;
        b=MKeBfdzmnCicSc58Rd8/b16doEedoWqV0O1Xj0G019TS6T7h9b3/pVGp76u1HhD1my
         4MHudIM8SUUwskfCcn9K+cVmFvZS+1x+MRJJuL88/rLD6gDVgpUoP+ySA7ioMlaWvdkP
         iEQnbzRcuRFl2JAoCm+6VJdsynYsRZZ19KoHmdGUdh6Vwen4NCBxn2yUWXX3J9mBpiet
         9jVswOc/df8upCG/F5mlxHcjbig5HybE3guKhxW3bORpAp40P9Qw4oCf/+j1oykhW1f9
         dm5JsEwZEUl57tjuHyb5j3cyoedQH8Fwe9zMVjtyWRXBY9TRAAX73psumvfmpVsEGkMH
         A9Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUw7Rwvpp0mXhNx5oOvulHQ+kWloGOdrvr8RGuu8qhkSr60SBDvTwO/VKP1kFYVg8EXfkiiXxPm3OBubtJ0RfUAVSL3/pfpMWUiU0YlCgnszLtTYB7Fxim/9ZYK7T5ulzDn9u4jaagcCIJD1iZA3iae/1v12AyV7UWNcw81YcmcJXOMadE+FTE=
X-Gm-Message-State: AOJu0YxdeevblBgax2wljZIqRX/HV7a3KNsYnHgMrQS8fbmqWQiD0458
	zhknUBL2vmi0qzvts0m+7yzTjwwBxH4ESHWtHvUrM+vf+QKKwZqCj//C/37Q2tPxgbIUglaZvsJ
	nrjClEaUSBwMVpLG4ZyCSQnCBfDc=
X-Google-Smtp-Source: AGHT+IG6TEMVsFcPVSqBsELWwJyFpRuf/hY2SNbScRZLiS80tCn6X3wHejySkfVx75KATLP9w2HFi1CxI+Ms7haSFkU=
X-Received: by 2002:a17:90b:3ccd:b0:2c9:887e:46de with SMTP id
 98e67ed59e1d1-2ca35c310f2mr1323804a91.12.1720510419506; Tue, 09 Jul 2024
 00:33:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240517170615.377786-1-ojeda@kernel.org>
In-Reply-To: <20240517170615.377786-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Jul 2024 09:33:27 +0200
Message-ID: <CANiq72kS3f0QA+p6dpkA79G3h57tDVS_oNiO9hm9xY-aJ+9jyg@mail.gmail.com>
Subject: Re: [PATCH] docs: rust: introduce the new kernel.org LLVM+Rust toolchains
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, llvm@lists.linux.dev, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 17, 2024 at 7:06=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> From: Nathan Chancellor <nathan@kernel.org>
>
> These combined LLVM+Rust toolchains are now available, thanks to Nathan
> Chancellor (ClangBuiltLinux).
>
> Thus introduce them in the Rust Quick Start guide.
>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` -- thanks!

Cheers,
Miguel

