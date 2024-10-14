Return-Path: <linux-kernel+bounces-364478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B5F99D51B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 19:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE0B1F243E8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 17:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E80F1C2DA1;
	Mon, 14 Oct 2024 17:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDlRgbOo"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8370D1C2327;
	Mon, 14 Oct 2024 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925208; cv=none; b=hVGJRfTtbM2ea5OFl6/zs9Mo+aKOU79pW7nx1GTCGMRYcUqu8RnkYUvNk2AqCCmEe9CHZMzlzQgnmUNf9BeMmsWMG6Bdg9mu4H1WdsFMOveCBHGTM17S40BkX57IhTzw5Jyi1I9SSPfEUuY5GEuuzYKZypOWySteAAIgnE/X9P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925208; c=relaxed/simple;
	bh=l+IkmYOY1emvpWEhAH8hN1Dn1l4FLfVFJ+8YBVygnlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E63EIYhXOl5g/8D7W31oVwzY0+23nmLFPHvj1yfFCfsNCtgqgQVUHNEB4D6VcvtS2NlxuLgeb5IIfQNgKf6gfhQqek0PuEWQ0DzO9e3ACsE+dyXbM6eClLkgwTz05L22CD1cOEQ5CTy+pNSzz2a8akZqxd2/u+bKfzlfJmUDie4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WDlRgbOo; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20c53efc14fso1910355ad.0;
        Mon, 14 Oct 2024 10:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728925207; x=1729530007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+IkmYOY1emvpWEhAH8hN1Dn1l4FLfVFJ+8YBVygnlo=;
        b=WDlRgbOoMXjgLskV3Cghhl8U0zEz2p+yTuIQSwf26WPAiYNXJ0Ej1+X9AiKNdgiOZq
         9vLUBSw7uF0BRklVcsWj12tr/bnSx+p+S3sOwQhyeZjbvVst/3f5+Kt6wqMMOgtshGZO
         hveL712QZnecgBFN0xj4rCn0SJCVeZEvknrZPuvJnMGfI68FUWnSu37M2HlybQSWosAh
         hjJy2hb6gu2Y2FObFqg1cavd6UPtcj4jj8q457DkedwyhRgjplm81tEQopxaRqoZXPIn
         rsLaWgCwY/KopoYTJvG9tR0PNv6BRn+7LSQQbyjnx7L8rTFFMe0LXQHcSuuoCtI4IZrW
         /9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728925207; x=1729530007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l+IkmYOY1emvpWEhAH8hN1Dn1l4FLfVFJ+8YBVygnlo=;
        b=QHpO2+wWdADYOTRRD+OmE/aUrgtl9zBi2Vso31AM6DddwJO/dOT3XaXt5YlXi3bx14
         pwGxvELtQbogYGl/2/trwOcJz81X+OLxtu7BXQZ18W6twnVVFaiiSOej6WY9H84BBE1x
         Ab2z1wAZrEFVso8aMVDV7/lrBwW2RSaU53yEJJEQuKUEXwmRqsow07huX1iQZUiC+dnP
         er0/t+UQyJh9in05516MOxmp5RsVA6WH+oEwhaLdkl8mdnnjNJDOxtuI61LOnMnL4ohB
         wAbzRpBvYkSAZuRCnYXfqQk6eRcF2jZZX43YSqNjqjVtlS8IausROl1IGEUTKilW+Etq
         ZxuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV53wzVRR72ZoRKanLb/bs4nFBBx+y5G2FwTWJS6AhrqJ+PyY+5tarcsK01I5EL7zl88PtgFLQrlJWB/Jw=@vger.kernel.org, AJvYcCVENhN4h5X9BcZwzuc2Ggnm10bX86r3i4J5g3aM6JCcXn1whzufmjr7sCl2169zKiVLzcwsAVadnyd/40F/dAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo25xgf8xVYHR+HGdPlRsYK800/gO0yVepI00EbAMDBl6b1AFo
	mSv2s41W3OrmNpD3JUCEuYEnHi1tKHDAr+6QoOcYkFCCZ3y+YIrBELCtvG/QWcJm/5WjRtY9EEU
	c8OczkQ9lg3BoVaBiaY70cvisBKE=
X-Google-Smtp-Source: AGHT+IHK7lgNU2cqHnJklHE865k53HsTuHdHwY3kT9CtZVScB0WjQJlMOR5ix+y9Y3xweVzDqJV2SHjwy23kRy1Rx0o=
X-Received: by 2002:a17:902:e845:b0:20c:92ce:35b3 with SMTP id
 d9443c01a7336-20ca1429fdbmr66874725ad.2.1728925206043; Mon, 14 Oct 2024
 10:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241012075312.16342-1-witcher@wiredspace.de> <20241012075312.16342-6-witcher@wiredspace.de>
 <13f6f904-bd2c-4b0a-914e-0715d22a7ff5@redhat.com>
In-Reply-To: <13f6f904-bd2c-4b0a-914e-0715d22a7ff5@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 14 Oct 2024 18:59:54 +0200
Message-ID: <CANiq72kE0QtiC6OjyV32r_0V2KxhtPk+-8mQGkCvtexif+04vg@mail.gmail.com>
Subject: Re: [PATCH 6/7] drm/panic: allow verbose boolean for clarity
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: =?UTF-8?Q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 10:54=E2=80=AFAM Jocelyn Falempe <jfalempe@redhat.c=
om> wrote:
>
> With the suggestions from Alice Ryhl to not introduce a return, and use
> expect:

+1 to both.

`expect` (here and the other ones I suggested) require `rust-next`, so
if this goes through DRM, then we can clean this up later. Otherwise,
if you prefer `rust-next`, we can change them to `expect` already.

Thanks!

Cheers,
Miguel

