Return-Path: <linux-kernel+bounces-554590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 723A5A59A3A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF15916C9DD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8E122DFAE;
	Mon, 10 Mar 2025 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkyjCcZz"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBD722D799;
	Mon, 10 Mar 2025 15:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621360; cv=none; b=S4sURLdC3wMteXQWMYPklbHxYykJ4UcsdK67hAsfJZzp5QR+YmPrySHRYZBIjVlHcd1opkAiW2h2K5Y4ErMdB23IYkZbGD4iWuB/K2pS5m7m98Xw8qp3d3L3syt9XuqESFmlKkpFCLvDFAocDPeuezMrihSbNicphKqpCAm1IxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621360; c=relaxed/simple;
	bh=qdA0drcwFLwwSV3mNb/W7MGu278YIA5YhwwxXwbO+Fo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WN/FSjf8JT87UsxuzdqK+NISwAZfuRXDv9igBhBApyI1dDCk0Oit9Uwj+inKEPKu9zZhLA474zGtkG0ej2MHWSs1nbpSbBoUVLCyPs+zmZyLEjoKAP5vrIFI2XqEOQBbBJ+EA4s/HiJwoipW+huiTP6B40OM4toJRdwfEnnSNRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkyjCcZz; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff5f2c5924so1260538a91.2;
        Mon, 10 Mar 2025 08:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741621358; x=1742226158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdA0drcwFLwwSV3mNb/W7MGu278YIA5YhwwxXwbO+Fo=;
        b=LkyjCcZzKBdS6tliS07/Ekog9V6sAbgNthtID4ltzjqPd07pRR8xCgHyY8J3/PUPmM
         SiawF84w8tmpGMBgmU5ADb52QFSBLlVG7AgNIQBcNz92YNwTWIzdn0dGcrQvDhVx3+ir
         Ui0VrTumKAwshtmkjoTyMj/LHaEGcQcaBCEN9IKD45xzZCu3yTu+T+rY8rMrGgKgzfob
         RguSO6txXSc3elr2OIY9NiZ45CeiJyPd2u2O30Q6TZVxzoUG2/bD6ikc4i0XDPecBJzB
         /ohFr9nlyff8LyP7d4fGrnch7GmMAx7VPl9BsKXFNbZBJ5mybrZ01jc7xdlfCDsJRyzU
         w/dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741621358; x=1742226158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdA0drcwFLwwSV3mNb/W7MGu278YIA5YhwwxXwbO+Fo=;
        b=X60kU320aQt8BUBkdkcn8f2JzA3AICJiSOD/A7fcj6K5ztplGmIyT7o21CjTTwRPWo
         xkVbGx3pSfjo2C6mtbWLIYZILke5TRj9kYLrltyMXdlr6HmnwyRL+A6O7YyLwWT8fhEC
         zfwcynXwzTsTFenF9wqFGNIph/esPOmDdWBfTqIN0bM7w6F3lNhyJHjv8TvK6UqAx7Sg
         Om2N6NBE/m7UVzhjYZYyS0fzv1rEzofdTNxPB1M/RDHZYcQql6k9KkqgIdwkYw9TK3iY
         JNfmKtk/e4i+GVHVaWW4F0lDOXbgyRtM/L+KRcW4zZe4Nf1qi6oXOylq49TSYNzjbjQO
         BKxA==
X-Forwarded-Encrypted: i=1; AJvYcCUQemqxGse+93IB23KLGx2H3CHDmuAgSigxrNevbYy8heI5QAcQPEkwQusTLzC8XuiEOwdn+FNayT8qfsN7f1Q=@vger.kernel.org, AJvYcCVkVwrl1Q7Th5bk1Qq2+MprRG7KUx8bh+bJ+3Q3mTo2IRJ/MTMuCaec7KehpHeLvJxmaq8ibTNRg5WfCso=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9Tc500kqinNZOvkvBBBemB7cTcWJ0Mc4qeyC9fix5CJLoPqc1
	Zead/wPz9H2461kRyX42k2PeJ896RvPGrPx+s78AA3yXCdCNWS5H7zRSgO7qzjp9jt3G+Ar4jEc
	B4AtawbQNUSjN/CdDW9YHe3NLr48=
X-Gm-Gg: ASbGnct/f4e6VUagwHz44WEWaS0MmuQRobvAdhrZLzVW5b3H7lI1B56eQePEp9gfBSd
	bN2dUpNIN8TPheBxmMM+03+buSZOeEbNkcfi8aFm1BTkGDpOFOopagXNPegqG8RWuagCR6R45Ho
	l/rCKeVK/No81xjGbvVcQGgqrU5oAKpZec9SwP
X-Google-Smtp-Source: AGHT+IHgyI6LM60Sviubb6OsgzHCEo3BYwGjZZODYsxr6JAyhyetUsXoIJlTwKyjQknCrc1H+CjHowhxk7Dr0MB4jI8=
X-Received: by 2002:a17:90b:4d0b:b0:2fe:8fa0:e7a1 with SMTP id
 98e67ed59e1d1-300ff720794mr137208a91.2.1741621357869; Mon, 10 Mar 2025
 08:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310-unique-ref-v7-0-4caddb78aa05@pm.me>
In-Reply-To: <20250310-unique-ref-v7-0-4caddb78aa05@pm.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 10 Mar 2025 16:42:25 +0100
X-Gm-Features: AQ5f1Jofu__TASjGaa7wmERfTha01g1CwoeE70h5sDKLhFKXkEtlsWn5Ev9A_EA
Message-ID: <CANiq72mR66wn5T7WYCzyyan5dEQDQAyBvtzC381jfWgC6R8K9Q@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] New trait OwnableRefCounted for ARef<->Owned conversion.
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 11:57=E2=80=AFAM Oliver Mangold <oliver.mangold@pm.=
me> wrote:
>
> - Squash patch to make Owned::from_raw/into_raw public into parent

In this case, given the changes are minimal (and assuming you didn't
discuss it with Lina), I would have personally used the [ ] notation
to explain the change from the original patch, and that's it, rather
than a Co-developed-by tag -- but do not worry about it :)

Also, in general, please wait at least a couple of days or ideally a
week between versions (unless it is urgent etc.). Otherwise, it can
get confusing for reviewers and so on.

Thanks!

Cheers,
Miguel

