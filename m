Return-Path: <linux-kernel+bounces-536881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCBDA48594
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDC69175BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB2061B4139;
	Thu, 27 Feb 2025 16:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ii0QKOv/"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DD04EB38;
	Thu, 27 Feb 2025 16:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674098; cv=none; b=iZqj11WrwreT0EwcA1VWgE2NVwRgxQwWARSXElRJu7USXE+65x/H1TYmwNQ4YG77G65viFDwSXJzIbE6Er8MVhPE1cagiKs6PQgrxq7Bi2UxF5mwJGvM2xuSXJlb8OMF3rPTZbjx0cRgqDh/9jBwX8ov78qMon5rogv95hw2b30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674098; c=relaxed/simple;
	bh=tXLnuA4NH9ClxgKdQuc0k4BxZf6FIWfYIuSq0N+wzdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etUh0tOgN2ae6jzxACHUqKBWwnR+WdQaw5+PGI6t/Y23W1raKC1Ao4ABCiFuo8lEdY9SUUgFu05ump4frKWrZJp32wB8SIumZffvE4T4aYMbA9KnBBmh3bcbOm+8I2kSlY9g4KuiWKnQwRhmVYg3vEXskRlqCkwmFEGc9MfHDco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ii0QKOv/; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2f9b8ef4261so310248a91.1;
        Thu, 27 Feb 2025 08:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740674096; x=1741278896; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXLnuA4NH9ClxgKdQuc0k4BxZf6FIWfYIuSq0N+wzdM=;
        b=ii0QKOv/gs6iyW4awixTKOXs7cTTrxBJ410y9Lk/aSIymfZV2jkHkXd+jA2NocRE6R
         jhRSiQgZcLLfpxeFmDiu2HlYmpDKbWiwrilVFuSi/lS10J+gjSlltGNPTHfloqY+o7Zr
         V3OPtMaAxR+L8jDCPsXP2DdvwrSDITuEwLCzO0kPKyoSZ38k4wPW9kESGxGCiUUpLkjF
         23e6pAyOCQkqrOTCzU3dNlpVkfFpfKkd7Q5dYVjsIlzPVJIq6L0wO190GxhrC8nmYMIx
         TVkTxqWaE/VtQXRctYES5G8m2gGPCJxJibHj9QBXU4DsI61izsufOc62sypZpfckeQvq
         tYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674096; x=1741278896;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXLnuA4NH9ClxgKdQuc0k4BxZf6FIWfYIuSq0N+wzdM=;
        b=nOGBSHUI1s6KsKhXNsCyPdAs6Uv3702omglqnNDkngJ4xjWiS5Um9Eu86M7oBQwCYO
         3Wl4sL8rW/beN4ESraoiTkUZ2kvDDrBRdgQh3sI6sAujkmt5RUn3MQoNzu6J0lsakDOe
         oKsuvMVQrMSIqVhZIycHw6pXn4spKgj6pOjhsXB2eyJ6g5QEupwSTCBnHyfFAlbTuv9P
         Bs7FhmG6GYr/cpZdCZAoJECHGXY8Kg/zGwe/SxQQdxN0tM7Pc8U3zflPRf19Gby2agxw
         nP7G4cXr3hrIkTA/QnUn6G2IA78hXwS+EYPhcnttw6ETqhmbU39KmxOgHyxMA14AyEPm
         3uDg==
X-Forwarded-Encrypted: i=1; AJvYcCUaFyb416wayTbMUASFhPGomjnOw3jyKESAcvRLacf8GAIga0KHo3OOgVRe7CNAxboCNp45Wj/ExS6TFMY=@vger.kernel.org, AJvYcCWNs3UScEJE3vLwnGuMAE6sRsat37j7rYm1oRbT4n+ZtUyW44C3mFLM7rvtDPRdukjuscm4Z6aHfpHfapIEcwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwKszmOJo+l74QTtS3TFC0x0oFpuEwdcSoTzD5nChcgmB6q2cb
	cIjvI6P+VwjQcMpHeEfvhIq+2TGpp4QPHahCDD1j9biIWER0rZUiXLRZcV3rQzd6aV9kw+Zlj5p
	5OQTztRoNrFgwyzf0Q/FAxgoULUg=
X-Gm-Gg: ASbGncvT9XcNu/gKaE5QIVFwQanMgTunt4L9pEO66LeZ3U/Ld5bV5yzLyRVLnt6ORjb
	BA0Ewvc8daW5UZx5wbgZU1CvPgRC1B5fwfowFE+amz0rZW2PfXZks1sE+KLC6P4vdHx675dYBgL
	48aBvPSzA=
X-Google-Smtp-Source: AGHT+IHeVMr2jKMS/AOCwQKlqTbHifQnsjyem66wBUHg5XMJevbmQm8CdvXcGZyG8U1QasnMyS67SIClHmi3RMUW11Y=
X-Received: by 2002:a17:90b:1d84:b0:2fc:3262:9465 with SMTP id
 98e67ed59e1d1-2fce7b4f5dcmr17212788a91.5.1740674096089; Thu, 27 Feb 2025
 08:34:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250227-configfs-v5-0-c40e8dc3b9cd@kernel.org>
 <20250227-configfs-v5-1-c40e8dc3b9cd@kernel.org> <CAJ-ks9=B=ceCN0VO3JH37LJbuVbQ5Y2sqfOgFCyJ0BfFGSEmkA@mail.gmail.com>
In-Reply-To: <CAJ-ks9=B=ceCN0VO3JH37LJbuVbQ5Y2sqfOgFCyJ0BfFGSEmkA@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 27 Feb 2025 17:34:43 +0100
X-Gm-Features: AQ5f1JpGoyo6QBh_ami0SW8M8Tn2Y7-wlS1qNQn8MPx8EralqnPR51aX16lLvt0
Message-ID: <CANiq72=4U0Jpo=gkHVA9vQBCzSxde8Pq8-VZ-VEt4ba_HLAKhw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] rust: sync: change `<Arc<T> as ForeignOwnable>::PointedTo`
 to `T`
To: Tamir Duberstein <tamird@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Joel Becker <jlbec@evilplan.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Waiman Long <longman@redhat.com>, Fiona Behrens <me@kloenk.dev>, 
	Charalampos Mitrodimas <charmitro@posteo.net>, Daniel Almeida <daniel.almeida@collabora.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 2:49=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> Isn't the unsafe bit `*this`, which is what this comment should
> justify? In Rust 1.82+ `addr_of_mut!` isn't unsafe I believe. Also `x`
> is likely meant to be `this`.

`addr_of_mut!` could also be called safely in many cases even before
1.82, i.e. it depends on the expression (and that is still true in
1.82+). The change in that version was about referring to static muts
and extern statics.

Cheers,
Miguel

