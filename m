Return-Path: <linux-kernel+bounces-540318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92040A4AFEC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 08:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED1B18960BD
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 07:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B691E0DEA;
	Sun,  2 Mar 2025 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z0/JDpFx"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5221DFD86;
	Sun,  2 Mar 2025 06:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740898486; cv=none; b=uuhEPM8UOnQEMUYG3jU49cS3BbgaA6GQpPjVqp+1HrYTVA3494hltlSCfXpAHt4lIZqLn52oVGxDOerxwmsTkNX/JRELF3Jw+yE834iap4fPxP8gkXW7i8cnhHgz/QsL0ICu8/8WpQyHeUeTZH4g6zYPtOhBSsSXtwJCurOdvzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740898486; c=relaxed/simple;
	bh=x1sl17MlhyGn7a4DsGY06N7SkedY6GXf5M+vFSktdXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XjUdg4a+Tb/Z+rsq0KAgjTWVcDQ2qax1DwTilGlj78ABDPcnYN+z3MCTkbhPVOPEbdvGQ4kSbl3z5YCX5NMliaK8xO+8OfF8kaDKqy/XsfCW/uENBLxbhFl2Xj8yt9O3vjRKTImjC1iRLhQWo/mlyk0TYOjoHL0c2wBQBSpkgkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z0/JDpFx; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2fe9fd5e7f8so1003030a91.3;
        Sat, 01 Mar 2025 22:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740898484; x=1741503284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RH50xcsm3w9EAvFEKvX4IOD4cvYkCw20gTdnoq0oYts=;
        b=Z0/JDpFxuvesNnazGVGYzs8GXV/lNZTrT0IamI7eJdasXQHp2l5QKhMvfOsH/VPLN7
         bhvw54f5SfDO6GVH7p+kh5B6GuEb+KbJnkDHAmTXa8tllKNm32qZ3Gi7DOjsEQJg+Qxb
         INle8gCn1RUO0G1xUG5eejJmwHvpNAbEpgzfU5Mc8Pml7yxJ/B+MjxG7vxzUmO1+nfrd
         bfNBUIULat9qgOuKWGaEqreqHZgewM0RzC+/ryhmihtpKRwq5S1bUNuQ+wXzUBjx+MIE
         wztpwax62+dygbChXI7FYAjy1qN+A8LULemrABXFAD4mlvzVmUXQLW0IuKRVZrWOLCZM
         v5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740898484; x=1741503284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RH50xcsm3w9EAvFEKvX4IOD4cvYkCw20gTdnoq0oYts=;
        b=NVVJf+l0pj0d+GDZRV4uTcAlfx1nIM6gXGXZvUlXbz+L8YhPsVQ4NwNCnpUvF3uCa5
         sHPBByzL53SQyhkVuOeeqRdZxpLqKe3sBwIFuSQtMWmTeTHdbZIIGd2qnMgwYfgjZtTT
         XM9F30XMY16hgBxFFO7AVV5p4EWHk9r7/iyeANQH6tletpkJK2Ji0L7Dxng3SxXJrbpi
         vJ6NPCdUI2dFFHCwLdGh6cpWyGgzfnTziu5H3eQwgfvgTbUXyhkbpbTXDP4L1wDipZcj
         XmhwStEfGLdRM9mWxUOJSYkAnV++nGLtw9uIVPOr9oBkmp7tV0A1bkCTQWYLkJYRXkMV
         ug6w==
X-Forwarded-Encrypted: i=1; AJvYcCU8yAhUGpQihPI6LrQdNyQQ41X5WYnuzVIzphUkUTZ8aXJq3WA2CzgX1WNPziwQrxpV5vmclttP71g9XQA=@vger.kernel.org, AJvYcCXibmgFSktHYkdmLdZQyfWx1KskSFdHp4AU4DrMg8O0o7zHBNWRbtqxwGhYKci0uRRXaEoPXBq+Eyhftel0QRg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8UWXddf06ZLQS4Bvk7ylYET74ONWsjeQelmropmU74cX1jGNu
	LPYAl08CnxW4wpqCfJbMOWVc2cOBkt+8VnLNncr0F/B9iTIxf2zLW12HGOpYYi+Ta1va4c2Pp0j
	K6KC51Suhf1bmQIKszqMvL+ehLfM=
X-Gm-Gg: ASbGncu5SPLwFJRFrHeS27NNj0+rvimJyxNDpc68kgI3ug4wb4b8HUsCweTC/NgIT4V
	pSRgl8fcXBcRJ6yYzEPjHxwZrEOqBxaa5s/rFihkAzNMTkNiEyCyBp8K1NxKiMghlNEaIGVNFeG
	5mtlfHqo2GevCWYSSGgV2TYNuxxA==
X-Google-Smtp-Source: AGHT+IH/HpdC5c2ntwoUexbl3FGQdhO1VQIGXrZoFJRa7qJpy5glII83KoHTFhfyZpEgHHy3fYGiMf0NHxFD6DEEMQo=
X-Received: by 2002:a17:90b:1d8a:b0:2ee:6db1:21dc with SMTP id
 98e67ed59e1d1-2febab2bdf7mr5608814a91.1.1740898482556; Sat, 01 Mar 2025
 22:54:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301231602.917580-1-ojeda@kernel.org> <20250301231602.917580-2-ojeda@kernel.org>
In-Reply-To: <20250301231602.917580-2-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 2 Mar 2025 07:54:00 +0100
X-Gm-Features: AQ5f1JqlzIC1SFXpGOf9WwRIHGTxmhHtxxGET_lxoSbzWK3HdSahnru-4p4t798
Message-ID: <CANiq72=69XAOapYBurbwsQOEaw2uamZ6ta=DT6cC-om9XK3dvA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panic: fix overindented list items in documentation
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Jocelyn Falempe <jfalempe@redhat.com>, =?UTF-8?Q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Gaynor <alex.gaynor@gmail.com>, dri-devel@lists.freedesktop.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 12:17=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Starting with the upcoming Rust 1.86.0 (to be released 2025-04-03),
> Clippy warns:
>
>     error: doc list item overindented
>        --> drivers/gpu/drm/drm_panic_qr.rs:914:5
>         |
>     914 | ///    will be encoded as binary segment, otherwise it will be =
encoded
>         |     ^^^ help: try using `  ` (2 spaces)
>         |
>         =3D help: for further information visit https://rust-lang.github.=
io/rust-clippy/master/index.html#doc_overindented_list_items
>
> The overindentation is slightly hard to notice, since all the items
> start with a backquote that makes it look OK, but it is there.
>
> Thus fix it.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Fixes: cb5164ac43d0 ("drm/panic: Add a QR code panic screen")
Cc: stable@vger.kernel.org # Needed in 6.12.y and 6.13.y only (Rust is
pinned in older LTSs).

Cheers,
Miguel

