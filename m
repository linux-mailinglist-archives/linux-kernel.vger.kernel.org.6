Return-Path: <linux-kernel+bounces-392285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D789B91EB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C215283BA7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B7A19CCFA;
	Fri,  1 Nov 2024 13:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVZ1m78h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9478381B9;
	Fri,  1 Nov 2024 13:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467352; cv=none; b=T+823IedD+hlENSuuq9jAdBJgnkoBXArEiTdbXmUSr0FfQCFAqtyXGhKQ6QPi/dVNRPlViTUADP8H8ISY5tRhLOipUCc9HsYGMPyPlJRasOvj3RmFT1C3Fz/5SvMawiSzQzosD8lUszT+mADbotdqocVL1QwyQB+0j0sdKOgw8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467352; c=relaxed/simple;
	bh=JJ8e8veNWCycOWMOQ5ARA78paLuhRw5g/xjSkFeBzQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WuX/WR4ghEne5SFtRii04+S6je4xbXy9yZbOBOAzbpnUpbl+qElEKC8eTDNrGBEZUb5IA7ZBbzeQDejT/C4u7VnmFX+nUw/1qpasG/TDWyz0aD+hpfTXLaol/yRyQLcop0qIH+fxZB7ExGyLoPMxUdN3Rlfe3nWtg3zHTrnuyA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVZ1m78h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E353C4CECD;
	Fri,  1 Nov 2024 13:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730467352;
	bh=JJ8e8veNWCycOWMOQ5ARA78paLuhRw5g/xjSkFeBzQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hVZ1m78hGN4qkmNwMyCzbJPomXUea/8naJIsTdKdGy066vQSbrQw/8/H6o64D2ZrL
	 9wGHgX8yxHzwSXjQx7S/UTgufxJ/NkrLp/NoihWJHHG5pzZnkFUI1jMmNCOd8lDFkT
	 E/Xv/1FPPf/shQrXtSiWxADviF/G6jDRyLZkDR1fr/RnpA6qATPb3SpCS1t0HV5Qrl
	 oD1oTFoRMrJmFhX5OpqnFlLWP/o1g8USDNGAP0agRfvJHJrbXJ8np7Ij4wI9rPWaqV
	 oW5nmKm7VZXXb3QHeYKI0bEmm6EHQZqHM2S+JXP7xA2uzcRgQ371hTIL8oP+kyyiAT
	 wBZWwCUhGVWvA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
Cc: "Tamir Duberstein" <tamird@gmail.com>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] rust: reorder `ForeignOwnable` items
In-Reply-To: <CANiq72nX2=yigRKhP3jN0kQ8vD0kMvUOp3rFpRQZJGAX6RrRhg@mail.gmail.com>
 (Miguel
	Ojeda's message of "Thu, 31 Oct 2024 13:40:20 +0100")
References: <20241030-borrow-mut-v1-0-8f0ceaf78eaf@gmail.com>
	<Pn1b5OU4cqz38Aiv4RL7MuzPDwDGvxLVRrLuCF7Q3_HaeLzlh4jaM0krBqB39DCFmRLWK59Do8DPaVxLNaaTNQ==@protonmail.internalid>
	<20241030-borrow-mut-v1-4-8f0ceaf78eaf@gmail.com>
	<871pzwpsm9.fsf@kernel.org>
	<CAJ-ks9m-THyqK1tYL39t979BagBqj3Z-MOSn8wPhDc82awjzug@mail.gmail.com>
	<ozMyxxwj0PTAkz1x7kMYTL5RqFlrbvJRrrc-d2UWlJxME89Dy--7ZPYLzExR73oyY3FjYyZN1Y7u8d-NCCXp7g==@protonmail.internalid>
	<CANiq72nX2=yigRKhP3jN0kQ8vD0kMvUOp3rFpRQZJGAX6RrRhg@mail.gmail.com>
Date: Fri, 01 Nov 2024 14:22:19 +0100
Message-ID: <878qu3nl6c.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com> writes:

> On Thu, Oct 31, 2024 at 1:23=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
>>
>> This change was part of the original patch. Do you prefer the code
>> movement in the same commit?
>
> If we do it, please keep it separate, that is a good idea.
>
> However, I think Andreas means to avoid the movement at all,
> regardless of which commit is used to do it.

Exactly.


Best regards,
Andreas Hindborg




