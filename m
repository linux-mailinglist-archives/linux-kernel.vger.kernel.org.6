Return-Path: <linux-kernel+bounces-553396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 294FFA588AA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 22:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1F3169DC8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 21:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDB221D5B2;
	Sun,  9 Mar 2025 21:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8sSJttE"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C8A1EF368;
	Sun,  9 Mar 2025 21:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741557349; cv=none; b=p7enB36y9GCdqjpmS0laPx2Y3mu/5GdHPhnBtESzUG2bNuz2JX8MKfBbMa8x0V0nYCiSrOhjG8w5Be3pbDW8AUxTls5eZLi5lpF+92rb1mVCUE1LnTZpSAEYx19/b+t++EmQfNKeGhxp9WVJd67ZAP/cmhIctvcDwVCtpsr0ynI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741557349; c=relaxed/simple;
	bh=GTq6UEu3Li4X7ErToPMFMwx2eg5l8CAxQ+gMdiZqzhs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLAdfkGdwnSEnEuvKZQnzK0nlUF3ToEsoTSuhWjQvZMODimoO+rp+d5FtjfKrPqwTERszA1l7nsm4MBNiAB+x4EN3kk69PaCGtQQuh5JuU6kwCoFqHpoyAVf7qvM8kg0HTL/RZ+DtmljyRxNpbhxriyzWgdDMrEph7quq4ktW54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N8sSJttE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff7255b8c6so909853a91.0;
        Sun, 09 Mar 2025 14:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741557346; x=1742162146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GTq6UEu3Li4X7ErToPMFMwx2eg5l8CAxQ+gMdiZqzhs=;
        b=N8sSJttEWmVStN+dnBiVjmQC5kOJ7zL+TGxUNJdgcqVxv6QBlyfwpsGjyT0re2h29q
         I/22JkMxd7U9dX9tLAdyBORWXx9ZsMHdvJDYZkKZMu9Rity88lbBQK3uxLOuNup15bvW
         dhA8FLJky7IRQ5s25nTShKn3GYcYVKjAWNSauk7M21XKmE9Nla5jD0YSDzSzcf4QNzaN
         2URnXvNHIcfhlCesVFFVSp/JCflcUgwi50AJDHBcdw3PC+zRAdFvZQ6tMw9QyievtVTe
         yijoami0/LqoVivcTQl2AAqoTIFVCWow7FHWtQsxpEYfZ/bSJy/jOrN8WyNHXAY8C8p7
         XU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741557346; x=1742162146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GTq6UEu3Li4X7ErToPMFMwx2eg5l8CAxQ+gMdiZqzhs=;
        b=OBKdy8zXOdHXM21Tqw37lHt+mkUu8Q6ikl5cesZJyvXUV8nqcPWLUbNhjfsfo7EWpE
         5riAI+EM2thW4Qlr0ti+NPllYd94lLLk5eTrC7lWNkweQ+IYVbtji/X3MjmqZs3oavOl
         C6qMtIGWPngmDDn7H6uJvrpgpSr1tKHeiFoJMO7M8OPd+KOTdKHLBk8NxFVtMSvM/tfx
         0rHUXRc2QtRyULu2lnUdRom92UPnPnNM1i++BMXxGaWluKKlHUcpK48fopcWV11a1paf
         qiEHwrr9RDqKvrlfPjStbxiz3J5TnJYvMoHYK4HWkoasmnzPkGOIRe9pg1uO+3TLACnP
         muqA==
X-Forwarded-Encrypted: i=1; AJvYcCU20kp6m+v0s2nlfaGJOlZtGb9TNDs0yoxAACiwKb3s+xqJYjdSmSV+Rkb+t7M3aCjzH1hzw38y1Gcsu2E=@vger.kernel.org, AJvYcCUn+sMgSKgPfekQgoQG0lgPKw8pS/7Ajws/EafWraG30nOyKE44bpELapkugfcmsoCOo7mBzL8VjgI5xxXJsHE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5b/vMxCBgGy3RIz+VB+ngJFYeKwsQUda036fYHivvHDMeUS3V
	/crtdVYK56tEeJPzFuqE0Ep2YzWTwSuPc4RuwQQ9NZWs8MhiLRs0qxbs4dQHt/nE6MEUjjgMz6u
	CiHp737+FjtL6aNtveK1tuzGJevc=
X-Gm-Gg: ASbGnctyDV4bIg1li/G7TuMwOehh6fziJTNZwHGDNZkvq9JA29dNdw4VMz/P8YSjPUg
	zKLcOsZXoEDRCZCI7KXBNbIZGHsRe3OeuFMgNuB4dsNKcERGHEE1ZPa182uc/cEUoa9nYq8pkqQ
	tIRPtNZGRh1VS00W+taqNgBCTs3w==
X-Google-Smtp-Source: AGHT+IHXlAJPVtOg05iMzwq+BMigf1lmxizD3DaJUYSB9U80GIORpHkKG2bK6XK7N00HhDagNjnQiESufq7xg5WfLB4=
X-Received: by 2002:a17:90b:38c1:b0:2ff:6ac2:c5ae with SMTP id
 98e67ed59e1d1-300a2b6b6f4mr4206702a91.1.1741557345730; Sun, 09 Mar 2025
 14:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z8sXqXgfhHbNpG6B@google.com> <20250309214857.1559606-1-ojeda@kernel.org>
In-Reply-To: <20250309214857.1559606-1-ojeda@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 9 Mar 2025 22:55:33 +0100
X-Gm-Features: AQ5f1JplJ2sdLw88CGdK_039ODMPr-eVmC66w8cRjSL3sCK1VExgIqPYi5hdaQg
Message-ID: <CANiq72nfdTDdk2TFJXMtdM5fpRQPkn38FEqQkNH1+xB45L99QA@mail.gmail.com>
Subject: Re: [PATCH] rust: kbuild: provide `RUSTC_HAS_DO_NOT_RECOMMEND` symbol
To: Miguel Ojeda <ojeda@kernel.org>
Cc: aliceryhl@google.com, a.hindborg@kernel.org, alex.gaynor@gmail.com, 
	benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, lina@asahilina.net, linux-kernel@vger.kernel.org, 
	oliver.mangold@pm.me, rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 10:49=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

s/kbuild: // in the title, sorry.

Cheers,
Miguel

