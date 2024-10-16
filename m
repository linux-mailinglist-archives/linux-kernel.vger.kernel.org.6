Return-Path: <linux-kernel+bounces-367582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 481379A0419
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 10:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F408E2815E8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 08:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA221D1747;
	Wed, 16 Oct 2024 08:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gA6Io4dD"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE77F187850
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066941; cv=none; b=OxgnxeMRemITs/XmWJQTehTUmvke3DdVl6jllfY9JoApyiGpOe/QVLyjNU9Cgvk8pCevzDEABY+hkStscGC2jMJLRYJjTx9qyTrA2jMo5wy9+Q5mQuk3tbDsQKcwYY02EadIbBWvXlnvKarHLBxAU8Cnk2U+kGuAys7btoSYAgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066941; c=relaxed/simple;
	bh=K0d18THzbfUB6LwAU1/WojMFGE73LSJivrI3N2f3R8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j12IDov5NoUmnqfzkYuK6MpaVmxSoWViUPuBGlnU/P5UB27cpVg4sCCxQcCZUlhMEx45fHyC17fcml43965r4syyPJZ8SKGmsgYE/mstHTnef7brhD7szJGtpM3mDT/TOocZ8vSjd+6frQcEIHB6JFxoaM90ITUHeGemo1y/qAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gA6Io4dD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d461162b8so4180944f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 01:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729066938; x=1729671738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K0d18THzbfUB6LwAU1/WojMFGE73LSJivrI3N2f3R8Y=;
        b=gA6Io4dDXIGUWESIL+pPZJM9oFaXSBXdm8/QhkTbkaCwt5+xc9zsPcEx8Lifk3+B2g
         SFomvBdmlvN6O/3KCKiH3W/lhWnKlaQyZd0optgGWenOXDPDPWrMab8322yYoHac/2+J
         xsdM3vZQfliWGnW8V3WI3zE3gQq9hT2dxPtbDDDgDcoWJ971Hb+97vND+v1ULIlF0fJt
         8AzDfUG0OP7zv8OhQVZVKoA28Ji3rBCdTETYhShkcTna6vA9TrBEgcJtOQ54ZbCeW5KS
         s7HjJe3Ofxyw896YqbkJVrIeKQR7/kT+YLSY+O1aouJDVnSpnKSre7JnhtjIXQsMqasV
         tZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066938; x=1729671738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K0d18THzbfUB6LwAU1/WojMFGE73LSJivrI3N2f3R8Y=;
        b=le17Ku0LBuwipKQjfPNI54v1QJT30WwWSLHPLOdMj4pjWxyB7W596Ol7OZEIRGG3Wa
         bWOCBObac6PWlk/rvOgMRDhSL9u9I36T8MiJlNgoINC42pRzZKKb56JJ9oXPas9ldM4p
         TW+O/O1TerQyf7E1K4LzPwBhhuNhYK/PpublRPUuG7Z5+plbm+kelJAk2vaGj0J3nSIb
         BwqqNxfdhA6uWXGGGjjhmO+BA8qXqWDyeWhQd5KtxpjcO9YcL7W3G2QozFo+72MKyP4h
         W3BZ3lUGQTkpK1fFd+4R6OKRkchJAKsFypQHveHPwW81Uw23FiUZrAdhJYo7h8fKm9WF
         8zyA==
X-Forwarded-Encrypted: i=1; AJvYcCXu8kmeFiVRiW79vDq64tosFHM/oIrFzkMCvxxznqrB3NxVdIPamyDUyRXd7XyYlIZqpD53eUZUyvTb+8k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEztwfWn8smtqR84r0ufiskBpquAvk47pwOB1HFm7PryVpY3/3
	rIrHAKO+YF9QrgJlge5zGGTS9CbwH7W1Rg5Vdj8C2OqiIaMYTwA5T7LT1wwF/t/oGG4vAvqT0GS
	Y0ttt3xk65uIu/nRLBzlNMI1aKdVDmU1/M7ie
X-Google-Smtp-Source: AGHT+IE7/jkWnCvaXDH4bpwieZj+PapXKebg3i0C/PdKAq14Yf4znUUh+mfI0Es0gbzWdaKd9zJxMPPQltY4iL4gTLY=
X-Received: by 2002:adf:e64b:0:b0:37d:5274:7878 with SMTP id
 ffacd0b85a97d-37d5ff6ce4amr9292585f8f.38.1729066937877; Wed, 16 Oct 2024
 01:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241016035214.2229-1-fujita.tomonori@gmail.com> <20241016035214.2229-2-fujita.tomonori@gmail.com>
In-Reply-To: <20241016035214.2229-2-fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 16 Oct 2024 10:22:06 +0200
Message-ID: <CAH5fLgiz51z-9oqSM9vOAKUDTireJnRsvQkqh=1hOuBi4M9wxA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/8] rust: time: Add PartialEq/Eq/PartialOrd/Ord
 trait to Ktime
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, jstultz@google.com, 
	sboyd@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 16, 2024 at 5:53=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> Add PartialEq/Eq/PartialOrd/Ord trait to Ktime so two Ktime instances
> can be compared to determine whether a timeout is met or not.
>
> Use the derive implements; we directly touch C's ktime_t rather than
> using the C's accessors because more efficient and we already do in
> the existing code (Ktime::sub).
>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

