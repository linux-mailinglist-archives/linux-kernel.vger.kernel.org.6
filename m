Return-Path: <linux-kernel+bounces-420735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FCF9D82B3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2716162261
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 09:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDD2190692;
	Mon, 25 Nov 2024 09:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMUD3lDc"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54D8184551;
	Mon, 25 Nov 2024 09:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527753; cv=none; b=hrxQs0ymyoGdI1bVWyhs70kl9cfBYRPlwHVrG1dn9BSkQyZzXlECwZdhJ5+udiDbuPQ77T0kEBUwXKHfYIALdxULIdPk2Cg1W56t2sPB7PNKCMN60wEe48AMrOdxSOv2LGc6FWGdCFq5aOcaCcnGWDVV59ijJjhWS+HsGm4uAE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527753; c=relaxed/simple;
	bh=D79QQIbDICLDOLd2x4NMBzjgcwjTiPN39k+g0fUIyOI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwXZfYxdcG8WRYmNXcpVASdoQTzN0NcdtnZPZqfAyJP11brheQbv9YJ043kH4aH6pHggZAvlTkNmVRfbv9DAH+cXjrJ3Alpo4nAvxHf7S5ohGqkh9EyFpHBLFvfug0y7hIy3AwzZuPPntIdlCV3Q23e24oMvK6e3E5PHBo+awpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMUD3lDc; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ea4648eb96so775289a91.3;
        Mon, 25 Nov 2024 01:42:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732527751; x=1733132551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D79QQIbDICLDOLd2x4NMBzjgcwjTiPN39k+g0fUIyOI=;
        b=TMUD3lDcxmno9ARlifk9KSV3hiNTSmXgMRQaSfy2yhRzZvseTV2EK7lSw7X/lG4/Lm
         o2O1WklJej95cipnNENIhFOSiKvxkzo+onzVVjZySMMDzxbR+DjI5U04OBI8qHuDElfY
         gD3bhnoT6BniX0IQdc6GgdardzGw8HJxKXML7wZDi4OxUAIr6I4tDou0C21av/EKUWGn
         rTmvxbO8lxA3tKF/e7h1vs021frWsEWnGM9rrRFJ6t5umWz0A4FLCH2ybejiHAyPWwBg
         Sha/UYz9eTeBDsfAWziQl8IDtjPPb21nBUt7wVdaHQt14r/X5Q0zQLI6mom9OLG2aReH
         pePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732527751; x=1733132551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D79QQIbDICLDOLd2x4NMBzjgcwjTiPN39k+g0fUIyOI=;
        b=HWTn657ySygz/vuxhe0VnZZnEX9veDbhz0hFo49TXwDwjyEDxAScsIfW1bbiPv9AJT
         B5zCwRCrtcvh+ciIlSQfcERhqc6NK0U+tYlu9uesLD3PhsvKEFngCtHaIJV37S4AG3La
         IdO/TIYW5iDWl+xR/bzC8hzMdImo1L8btTwjwOaSbqRDGmg6hM18si+7phZeXyWTWIA6
         bVyblhxcXrFUQABkhdGWgqugzN2qayh8zvpdP591YF4EqMnms2E2F+XXbVaa5ykoCnCD
         YdNEKySACHcz4rUHFNlVGfBsFYFVyqeBP2FFyExV4DEezqGUJ3cqJuypABIi7gdf6jdP
         26Cw==
X-Forwarded-Encrypted: i=1; AJvYcCVBzUvwkyeD6dakw/cgCS0uuBtj51Or7lgz94ajOsveVrUnRlcWx8qOn4/ubmH8qlznpNbEsGb+GrhGmhY=@vger.kernel.org, AJvYcCXbRkuMx1USghxX16mYZyErPZsb5uR2vYrEt/hKKz8KJjnhAPNk6k4cdfilcg+SWydPtt6wrB6gyCxnNiddhds=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGHbwMkTYpOjTXifYrsExPMLLUfMcwEsd8Eq/GTj1OZL2wwn7x
	G8X38Qk6d9vbiwtdqtQuepO98Hf4+lPI81+cZIm3A0dLXUmh/1nzx6LEEoLETkJLxMRdrb2vcLU
	7eN4OwMpo+EjHKjRmSYmGjcqWbWo=
X-Gm-Gg: ASbGncvUxBT8H4OatHIgsjtLsPkZc+xbqazkisv0FoK7qYCyskj2XUukGRd/v+4E0HR
	oBPSuIENW3qLe1PIJ2PKSttvFnwuH8yw=
X-Google-Smtp-Source: AGHT+IEGLZ++8tt2PlctfEq4UgYYL3skiDg2q+3/WmcEXus7ZhGZuBmsYxzhmr1PBfKiM65aW3eB0dSGItRD95f+BVM=
X-Received: by 2002:a17:90b:38d0:b0:2ea:b2d7:4a24 with SMTP id
 98e67ed59e1d1-2eb0e8906a4mr6483669a91.8.1732527751250; Mon, 25 Nov 2024
 01:42:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123180323.255997-1-ojeda@kernel.org> <CAH5fLggg5f0KpaObVtZc7WaxHjUqbhCDsn5CwnA5-3df2HEjnw@mail.gmail.com>
In-Reply-To: <CAH5fLggg5f0KpaObVtZc7WaxHjUqbhCDsn5CwnA5-3df2HEjnw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 25 Nov 2024 10:42:19 +0100
Message-ID: <CANiq72moPEL5s0T3ELEDvWiE6Lz5oZv2hZnziV5A60EP65bkkQ@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: set `bindgen`'s Rust target version
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Christian Poveda <git@pvdrz.com>, =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <emilio@crisal.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 10:08=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> Just to double-check, the problem is that bindgen currently doesn't
> get any information about the rustc we're using, so it may generate
> code invalid on the rustc we are actually using?

Exactly: it doesn't at the moment, but eventually a future release could.

Of course, people using the latest stable `rustc` would likely never
see an issue. But there may be people e.g. building `bindgen` on their
own, and thus likely picking the latest version, while using an older
Rust toolchain from their distribution instead of, say, `rustup`.

Cheers,
Miguel

