Return-Path: <linux-kernel+bounces-268782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F19B2942936
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A68DB21246
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81201A7F93;
	Wed, 31 Jul 2024 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PWpV01Ls"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0BF1798C;
	Wed, 31 Jul 2024 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722414733; cv=none; b=ngJ3aMNJFIYltoF92D1karCppXPGrZ2YdhYG3iKfKs6+Na8vfHB695tAxWkcJeaSe1wWlCtCttxH1+sHDoQLG2j8d1dpcE1o81KOlb6NzsjCzC8i/NyEw8BMOWSH+XGF8GSlX4tPcyPdDPYEsv3QD6ST3/K3k8BM4is11B6ANkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722414733; c=relaxed/simple;
	bh=zwBc+7j1gOA4RZxN95Rhd67uNlCz6saAi/ghZlnCYt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajLOCrlMycpl7v1L677zxX/xTtjWr5x27brm62DN0FEEImDBIYCyTxRqiCWKjIYSuhDX1ySpRXrE/0uF34nPM7qMZ1GCMqXMFboTnFZJFF0UW3X2XyiKN1tzqvTv/pVaczqWcXmkjts+XYdVxteWssPbXA1oodCh6E3nhz36+dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PWpV01Ls; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7afd1aeac83so611035a12.0;
        Wed, 31 Jul 2024 01:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722414731; x=1723019531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iL+G1y8BebAmWAL7Z1uTpjezb81fXhMCih8TdXof3zU=;
        b=PWpV01LsDjqTHhYDx+v0eiSQM44CdQzwi25gQgUruln3biLvbx6D+tTyPXv1iEUj8q
         bIKR69/ujbqReyubeDfO10EZPQkDU2zum3y8KqspD7PkLWGI0f5Uj0SQaDF/IInX6+PT
         pre08CNevkvYEk4FONLsZxhQB9lwdEIcC+gI3X4vnSm6lXTuV7kSazGdaWYaP5eqkGoN
         ncQMGxGALiS2gt70cRchhN8V0PrI0UAs6AYkur4xsYXX8MbbJ3hePhLpfL+Dry18N3J3
         YO6HzJtbqWvpGPP9UhuNEIXB5Bz79sV4pS5RBOOh1shlTPo1/3IA7bxIPll6TNp6put9
         NcNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722414731; x=1723019531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iL+G1y8BebAmWAL7Z1uTpjezb81fXhMCih8TdXof3zU=;
        b=lSPr9n8qqKuvtAOkoEDFG0eu7cY5TCO6dQ1P8aSFtK0SRkpYZOeNgh79a97KpFI0lD
         WxQo3/fIurezO5rIREYb0eOnGeke6SuUPIotbvHTAaXbYyHXDaqGwa4kzocCBYY87daj
         URShi3W8GO3T1ekOTMSIuKZsT7V8Xz5dfMcfUkDVXcSasGeRFVaOvzDlUO6kmbilt3nJ
         lQs1xUFCBlOmAOjbrUsAge/s9s6V4f4ExzS6s2d7HePFZKQnOn7LAseDgBOA3aQLdp2C
         UmPehG6SAnm/92tJCyYN9e5tvs7FAe/UDf4kTq4a3zEvp30Om1ol/m8ZocCcRkod6jFr
         bZmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUva36hjxiJ0O7z/Okfss3cJs8hnxjaNTOp/K30gYuYjTW49ViW5fqD4Y1uXMRd/XSZrd3fbnpVNpRMyHi9oY2G5wyKZ0w0qxlhsWPF
X-Gm-Message-State: AOJu0YygdfdyqXULZmilzx6hz1nXeMqkxu6ZP1EZ//SpLNVff2xzE9s0
	OwxnpCVn2Auc6bMFpiYTTJvh7M2gciIhfJ+N8EkJLyTYtujDBV046uGG/Kikt7GiA7Hb83R8gak
	snSO28v1rhp73+pdWJ0rbKs2IKqbDvclUj1Q=
X-Google-Smtp-Source: AGHT+IFLifyxPwPs2V/mWl8Q/lMkHvc/4jKMKDeqHYBr/em7bPkFfz3c/JwkPmtAwbt0Mx9a1loSf9CNfX1otqlHP/8=
X-Received: by 2002:a17:90b:78b:b0:2cb:4c30:51bd with SMTP id
 98e67ed59e1d1-2cfcab35c67mr7433852a91.19.1722414730959; Wed, 31 Jul 2024
 01:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731032030.2847151-1-neal@gompa.dev>
In-Reply-To: <20240731032030.2847151-1-neal@gompa.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 31 Jul 2024 10:31:58 +0200
Message-ID: <CANiq72nXN-pkHAG6A19JrjiL-uKpem_-8GN8RhiVgc+sKJN6wA@mail.gmail.com>
Subject: Re: [PATCH] init/Kconfig: Only block on RANDSTRUCT for RUST
To: Neal Gompa <neal@gompa.dev>
Cc: rust-for-linux@vger.kernel.org, asahi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Hector Martin <marcan@marcan.st>, Janne Grunau <j@jannau.net>, Asahi Lina <lina@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 5:21=E2=80=AFAM Neal Gompa <neal@gompa.dev> wrote:
>
> When enabling Rust in the kernel, we only need to block on the
> RANDSTRUCT feature and GCC plugin. The rest of the GCC plugins
> are reasonably safe to enable.

Yeah, only that one is what we had initially years ago, and then we
went the easy route since anyway the mixed builds are best effort at
the moment and GCC plugins could possibly be going away anyway.

Did you test it with the other GCC plugins enabled etc.?

> +       depends on RANDSTRUCT_NONE

Also, why is this changed?

Thanks!

Cheers,
Miguel

