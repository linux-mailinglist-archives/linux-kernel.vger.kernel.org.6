Return-Path: <linux-kernel+bounces-329475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1B19791CC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 17:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381D6B223C0
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5561CFED5;
	Sat, 14 Sep 2024 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMENggR0"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE1E4C83;
	Sat, 14 Sep 2024 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726327922; cv=none; b=V9KFlaTZECXJerMPzIyQp1z24dTUt5f1+Z2ySROZzMTqEB36thtJhCMZGb801DCTaJtVGrmPjPTwG6d86l6QpudtPqWivGATexQoOjC7qnyEmN58keMexUrxut2FmF91vNKb9vNMO1RSE1f/igLIguxlXbIezsNdaRdToGLpXVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726327922; c=relaxed/simple;
	bh=xwXg6Ys6/2ECwTpHoFrvuf43Rhh02T9TOPa9TOMdX2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cY7Vihf2ZREC0xAYCQ9Mm4kdaQhs6sXBk5nu7+Btn6LwYsTBkSLwUcgFaCfwS/3akQcyHGG7sTPt2fnql12aywC7oWds6qyN4E4vM/DLTNWjl0zxX9aT6tyjBpimKKJ+dzYH+37ElMgDMgd3dP4fbVH5Bx9FrlZn0KDKUhXwrzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMENggR0; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-718d8d6af8fso2181564b3a.3;
        Sat, 14 Sep 2024 08:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726327920; x=1726932720; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xwXg6Ys6/2ECwTpHoFrvuf43Rhh02T9TOPa9TOMdX2k=;
        b=SMENggR0Z1T+Oyhdi2yFnc3nU2TBPPCnc6oezSlB6GDKzH5TG00BKE3e4N2v36EHRJ
         5nrT96cD0EZiQjgBlYg21QGKyYWlhfNa54Cip2tECeX6As25wABxRUEfu1ezSo8TpdAU
         YVPj10RMjLrBl5hK4E368R3+KP/uJgCL5wiS7co6BTeUoQBiPkGw94lr3onzIZQdn4tZ
         A+5OUy5OQbqUYBHMNmXSz2C2a4ZI/2vt9vbmFq5aoDArl90VjF6gsbE+oM+cOPujP7Gs
         H0aB2qTgJYIC8w9aJhazjmggspuF5QKYGWAzRvYJTDtfcNlWY9Mh/2YyUDy/HolEPCUK
         O1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726327920; x=1726932720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwXg6Ys6/2ECwTpHoFrvuf43Rhh02T9TOPa9TOMdX2k=;
        b=UVguCuI/U8U3u9idb3aTuMe+I3uGJPuVL/6SyB2pHg65u+Ir2KVArGpkoJyHHy9n5y
         vfp/anE1ypX52DSqCfCNJy7dQwcHpzOfC6dd/5MD5WRlsm2Fd4fC2NBAjXAOhIqiNV6K
         G47oZ8vR1J931Kh6RD5VUsIFfqa/QztH4AWTBiZlccP6ywGXLwVNpfP2B7gze8hsHH7+
         slSTnr+UdhCaFIyHgNn7hqs1c8t3E4wL7HecX/EaAGHI0gceeo76ssRjqupYsHesID+S
         YLH2SGDMs6znVqCBW9Lo8Lbhu7qXRM+2/rSqZYd9X2EnAs/AnGDPPxHuyLpHzFJo/sCh
         pVtA==
X-Forwarded-Encrypted: i=1; AJvYcCW1ThOhwvg0BEsB/oUnue3uMao8O3cCaVAGTz5AzH6crCvIVjVXQscllQwynMdxc7d/HwQMSCQbjrLx6WDJqg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3KDm4X8uqfusj065neCNrFR4imLhng46ZuaWOsu57LVSscJmy
	bARtuqBIv3EWU3hCgsYuFoi0+E4E32VCparj+Kr8ODAhUL6WP3hkVslZNtEsBrqCovtjmysQOaN
	w/AZjbupzLPKPNqEb93dIUKusRswUMpcCeug=
X-Google-Smtp-Source: AGHT+IEAkgllSH5WDPc6Z6yh1+JgfYn+fVElIkXkZkDwPkF25CtuKBO37LP7xSyx/kVqZdyvomwC4EF5YjssOo+MWeQ=
X-Received: by 2002:a05:6a21:4a41:b0:1cf:4e27:72f2 with SMTP id
 adf61e73a8af0-1cf7624b3d5mr12624800637.48.1726327920282; Sat, 14 Sep 2024
 08:32:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa1b4059dfac001945745db02b6f6d9db2e5d1cb.1726072795.git.hridesh699@gmail.com>
 <7877d23adba22e2f89a61efc129ecf1b0627510b.1726072795.git.hridesh699@gmail.com>
In-Reply-To: <7877d23adba22e2f89a61efc129ecf1b0627510b.1726072795.git.hridesh699@gmail.com>
From: Hridesh MG <hridesh699@gmail.com>
Date: Sat, 14 Sep 2024 21:01:24 +0530
Message-ID: <CALiyAo=Z7SCwCRD_2rBnQrkF71q4MRyMjqJZy8iWGAuFqOmWUw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] checkpatch: warn on empty rust doc comments
To: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Cc: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
	Dwaipayan Ray <dwaipayanray1@gmail.com>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

Ah, sorry. I did not intend to post this version as a reply to the
previous thread, I wrongly assumed that editing the patch manually
wouldn't have side effects. Should I post it again or is this fine?

