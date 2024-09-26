Return-Path: <linux-kernel+bounces-341061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F73987ADD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E948C1F2332F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D0A188CC3;
	Thu, 26 Sep 2024 21:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCU3CTUA"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A841188CB2;
	Thu, 26 Sep 2024 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727387845; cv=none; b=c3a0giP7CrTPCE/WHOTzbZJon7psvCe7Ma8l0Ur2MpRLB0jdQsLjM41KygToLobV0Phbmr0HgTg/rjKWAKsfMFicAVLbb145n0/7l08BxdtXqlWpaZsKGFpyEOdGqF2eZ+fZab/Mwp6uyi8REFBqyAQE0046A1mVSsntu/a+o34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727387845; c=relaxed/simple;
	bh=eEN/xSFzcED2rz79aaTmMseX/MDz8XwqNLr76/6nOiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=orB+14K31Gx5vRaMlcCuDoUjI2XrhU6+qlB96JAFtADZL+Cw97laBXb9DN9tyMAg03+9L08jgWX8xibbefgWlTnE0V1Nf3A9TtNahsNJCTiBxBjI7sMJ+X8swshmroJQ2JRj7Ze5VNOD1VtKSDfs3QZDpihE/SOB2MMtG5f6kxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCU3CTUA; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e0b02ed295so113904a91.2;
        Thu, 26 Sep 2024 14:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727387843; x=1727992643; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eEN/xSFzcED2rz79aaTmMseX/MDz8XwqNLr76/6nOiM=;
        b=YCU3CTUAoSLAGuSojA+yEoAfuX/Mb+h1aPlE7Cm2hzyOR9Eo3rQ1ugC080I/Qr0zZp
         0T7PAV3AsgT2hx9movuKpjX5bFJ1eoqWA50q69sq6DqcgEVhzbbE+oPfROQv95ntltX7
         mEVgdTC1uIV/Y15GBz3l3xSligVjePk8nQWbaPiINv/iOjXdOP2X1bww92IK6oRzdXUn
         3xs2yQTTa0oOl5ttPisz3SlBLsC0bflATR+/bKFu1m7Y1fz5GvggG7+rmTAK05u2ZUGM
         Bjq2lzs1VSEhUk4gPhym8L5ULtRCip3rI9JMapnGJhIUuvDYV9lJF6275/2XboPHn/zZ
         sG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727387843; x=1727992643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEN/xSFzcED2rz79aaTmMseX/MDz8XwqNLr76/6nOiM=;
        b=OQhoVLqk4Arv5sTyLe4QU8JL3Dtkq2l87spx2+8NS3HJI4coqQYCWtEDB944/RXc9x
         NCzaGRVjYPWfqrbPjm/g3OmKVrm3iLgO307rWiLr9m8RciWzq+q3mdthvQpcZf9kCJqf
         lTypduWcd8QAHosK77OHBnxwdMEygbEQM88CmfKtGWRi5mi8r1kLpuiTnPwdNwIJZmAv
         uN5/eu8Pa8x+t9ULVZQ/uW4F5ekUSsW/dmC/0JC3rgR9z0tWNZWsU7k7b0jWmwe9aRrN
         F/EdDWnHgnnWF5ur8l1TJh9iXTmaTzicEUl5db84ianzbGvzszEERnSwM1HFdc+blUtx
         iSqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT8+jpfkxdBgTTaSOa0n7OSOwUBdu4J0u36jetCUFgOE52x2LsnbbtctuBBqgERXRw0ojd3ONpjCHolV+dTJA=@vger.kernel.org, AJvYcCVV6TzH4jeBfX1sPp4JO9E3q0wOo/Z+JcQVsrqleRBpfSqb1JP4SSMNNTYfN8mL/hSgNL/d1eL4k09xbQI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6PsXhQF/iugttUMfXTAAdFODuyw3IEA37hhML/0M4GpOP1Ecy
	Sa1GaEz2JkWU+kounveiePPy6W0tGrk8I5BqwEGOqabxSL13LukYyVmS1oEaqmqD4S1qx2rNP82
	l/LcBqpwINHmyMpCjjJZQ4X7fRks=
X-Google-Smtp-Source: AGHT+IHpO/1BWz17vURNySF2gUTZTjYnPxNW7MaMKBqIsMmLma82UqLz0MNk8I1C0jgMwINzCj+JsQLX5zpaS0kqHpU=
X-Received: by 2002:a17:90a:ba97:b0:2e0:7adb:6380 with SMTP id
 98e67ed59e1d1-2e0b8ee512bmr536169a91.9.1727387843256; Thu, 26 Sep 2024
 14:57:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240925205244.873020-2-benno.lossin@proton.me>
 <202409270303.kUIAmOmY-lkp@intel.com> <42d17306-1ac6-4fc7-ab1b-69ef045039ac@proton.me>
In-Reply-To: <42d17306-1ac6-4fc7-ab1b-69ef045039ac@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 26 Sep 2024 23:57:11 +0200
Message-ID: <CANiq72kh7UdXjVNyxmsmSy58=W7=9Pqqys2zqHxfnLNKJXJHEA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] rust: add untrusted data abstraction
To: Benno Lossin <benno.lossin@proton.me>
Cc: kernel test robot <lkp@intel.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	Greg KH <greg@kroah.com>, Simona Vetter <simona.vetter@ffwll.ch>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 11:40=E2=80=AFPM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> I can reproduce this error locally in a Rust project, but am unable to
> do so on play.rust-lang.org. That seems very strange to me, anyone else
> on 1.83 or 1.82 can confirm? AFAIK, it was stabilized in 1.82, see [1].

Can you try in Compiler Explorer? That allows you to select more versions e=
tc.

Cheers,
Miguel

