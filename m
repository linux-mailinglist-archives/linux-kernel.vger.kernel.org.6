Return-Path: <linux-kernel+bounces-381000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE319AF8E6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 06:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23DC2825D0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 04:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1FD18C357;
	Fri, 25 Oct 2024 04:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="CMmcVlZP"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1561107A0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 04:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729830556; cv=none; b=DoznIyZZ5EqzkXbqxth6t6nKJOLtHZBQKZ3B4PPUA19seHsrc4q1L4lg9GbSHyzdq7hKcRAMXfSl8xZv1Q8mfDKBioXxHcrZGwCZluaem7HDhfmEKEhjGfuWxD7oBOiiz0ulBpA8Vf/yR1it4c0unxcpbQvxsozjsHL4afnbk1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729830556; c=relaxed/simple;
	bh=EWCK8syvlG430LCfer51vMNGSWA+i5Z13fpF3yXP7Hg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVwYl9p/xNyQ/T7DoQpl4Q0luJavddY/EUvhTo6XBxwX5c0U3e6sJl1XnPwCN8WtT0Q28NuLQO67SYoZHgOpf/IWFgvzNBd+hNxInei9U/CWYbk1fAsVB2/g8WtUR/FMk+m8FPD4/9/qWN2EHQwuYNe8qC8+MCk8useytZyMzAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=CMmcVlZP; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e5a15845easo15789057b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 21:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1729830553; x=1730435353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWCK8syvlG430LCfer51vMNGSWA+i5Z13fpF3yXP7Hg=;
        b=CMmcVlZPoAWmezduIuZGWyt/a7o9ZFPeE3mLACnXT9yfNlBUqSU143ypr3OXRO8Nco
         o5egG9DX8uVvqpdie+Sa53oN/VRC5ezxAx66u4LI5kHlz6BN2rfwYRXDV6ZCv5LvqtaI
         GxRw7OYVSu+BaiKqaXu3026KcGHmxqg/uZBaD36YFaqzUM5pyyOLEVuoJTFqzChMEwTy
         C6g9AOTkeZ+xzo8SMTJ1oxmXbUOIiZWC1rQw+A6FfUwAyyLl8Gk7lFQ5L6NvS4uN9fLJ
         m96y/CN/Br6ezL7/T+5KmcpgXAABNWVpbdUqczgoQX2nmgd3zXgmJklqq5il/bS6PVd0
         SkzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729830553; x=1730435353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWCK8syvlG430LCfer51vMNGSWA+i5Z13fpF3yXP7Hg=;
        b=MyoMsusxV1fPXn9gTfMGxkRQvTAg0CeGzImPvpceQ5r3wcs6nfUlLESI4y6hUwxju9
         um01XuFp6cnusgfxYh5DRLRicxzCclRRavbKWMTdcGI0f96RM8I8KqIpn24PzJZwH7DS
         tzpxudKUSbIHgWXFMFHurMOZ67R9o87i+g36gf8HapYwN9WrlPDlLJSXHuA5K89qNuk7
         oo+wNB6dPZu1BzXHJ0mHWmsRRwUmNe0IUEuZvr0WrCqSqYNCGHP3fFwAFSH5TVKYtPMG
         UHcNxrad5uUcA9+8tR2GXjr9Jy+pm/E8PjjGvOhOyiopVah4kONeVM66kci4HBYcMNi5
         jd1w==
X-Forwarded-Encrypted: i=1; AJvYcCWAnpnRAFFR+k9MxM6fEIEhHySk4FgOoKvdUvalXDCZHSBFfLOpW+nXkZoeJJ6KiAqFQ7oL2c/Xwqqf6Fo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz06YC7cGEPQhL3ssqivsjVIf7WX8CwhCSJ0xqC92RSQSJh+m5E
	u/9gsTL5wyWwlc1uQSfFZtrEe4yL+NP8GgHMl8K1ClcjggEux1qF/QQFGtMv6eRpZ9M1sRAuy87
	ML27luFkU9TTrhCKJg3H09XCcfQO2ypbartz5OQ==
X-Google-Smtp-Source: AGHT+IFxXvvTdE3yugP3KWorwEDSHTOOfHgNN/Z+duUWd0Akjtp00/GgCjbXkozJntXhXwb5dgIWMV2hMm2N1FcFclI=
X-Received: by 2002:a05:690c:6687:b0:6b1:1476:d3c5 with SMTP id
 00721157ae682-6e7f0e04bbcmr104496997b3.12.1729830552972; Thu, 24 Oct 2024
 21:29:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025033118.44452-1-fujita.tomonori@gmail.com> <20241025033118.44452-2-fujita.tomonori@gmail.com>
In-Reply-To: <20241025033118.44452-2-fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Thu, 24 Oct 2024 23:29:02 -0500
Message-ID: <CALNs47typNN-Zp=Lf44DUkS8vUQme08zt_qPtxO3mngmfrnnFA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] rust: time: Add PartialEq/Eq/PartialOrd/Ord trait
 to Ktime
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: anna-maria@linutronix.de, frederic@kernel.org, tglx@linutronix.de, 
	jstultz@google.com, sboyd@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@samsung.com, aliceryhl@google.com, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 10:34=E2=80=AFPM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add PartialEq/Eq/PartialOrd/Ord trait to Ktime so two Ktime instances
> can be compared to determine whether a timeout is met or not.
>
> Use the derive implements; we directly touch C's ktime_t rather than
> using the C's accessors because more efficient and we already do in

"because more efficient" -> "because it is more efficient"

> the existing code (Ktime::sub).
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

