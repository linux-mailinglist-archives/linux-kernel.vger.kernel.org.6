Return-Path: <linux-kernel+bounces-390610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 612659B7C30
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92EE81C21360
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A01519F127;
	Thu, 31 Oct 2024 13:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InTO28PS"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A2619E819
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730382759; cv=none; b=mR2VdckkRq7gdU7/FYgxLWSs4rYlD5K4bvyt7XKt/FnXXTThDW5eJ8Nco1l/GZD0hWyOc/44StDx01TD0ZW9WgMIUyHvLaiBt7gzem9fS6yoMg8j0WCTeWK+x9rtwzjGOz2uE3tGl2nsV3tX+zZiil5RgLgjTd4g9DXhee9qVm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730382759; c=relaxed/simple;
	bh=XqAYvEbg0ScEuxlOsbIADwPF2P2ep2WjvKN4N6o86Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fxd6XQGKr/rbSIDCJSkdb911+sW83BGtSfvDoGe26c3DhIOWFtUcZdrIn9BtBuwU6TF4GNlSV00XMci8Rqd+NqT24Cr2I2hYHl/QMGsXxoczNi79jhgLlYHITtpgRvgxXmEyh1OXkbHwrhl8HtC+7R3KdNd86YGG4Pfggyh05T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InTO28PS; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2da8529e1so113199a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 06:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730382756; x=1730987556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqAYvEbg0ScEuxlOsbIADwPF2P2ep2WjvKN4N6o86Qk=;
        b=InTO28PSjU5LoA/LMVLFjnpqiUSAkhuRkT2jD7A0mm7xGd8R712KetXycbReO+tMe3
         PmJhstRVkaR+Fn4iygqTT/YMy9DYRUPmRenOJbZ7qL6OUm+onSGFInvWFOn0Up6oy/nu
         ZYRaYqCZPhp0BYt5zGf56+pXqO4lPsz2K1g+qlMoxYFWE89tTg4yT5zHJ6tuMIxQooaq
         KYlUVheJUi/4Iky2PuX98O1MsMNaarLOvUu8HtY8wAGl/YQQXNebtkCHJi36oljh4+l+
         LxYAaWxpiu93SsrJCioDkncUnblj4ZDhFiy3W2EGJqwZn68sZAxI0w6XF4iNmFX/bUKH
         upZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730382756; x=1730987556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqAYvEbg0ScEuxlOsbIADwPF2P2ep2WjvKN4N6o86Qk=;
        b=vHp9ITspoBLhLpWzhl3WZ1JeX3KqxXLWsk9lPzR/76XnS4EYU2sfC0Q0S1MnqF+xQb
         KlhxSv6stKZWHW+m6iUmXhwjx2sO41RjNSiRNm7uJRc8sQGGcHNkv7+DWN818PaXcn8j
         hGBB6i6y+3wTz7WwqfTRQQYQKChwKAJKmirlGu3repg3FgjfA6F5u+eQdbuqTOM+gnlF
         1UUejIizgHPTMHZt7Y72BytuiUXZsH7PjVx9yecBcN68q/CwXZ4AiW9RB0dZ/UWx/Rmt
         2olt0mtCIj6yxRf5xEXEypEM6KzMf+Gs4oZx/661ucY7y1ByAAyZZcYkYJ5mV8DyAzmV
         3lhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkADXKqIR4nwDXTTCQ6XpSa9EQo0wf4gSmCH+R60Ze07ISq0Fxel2u89Xgg/3Ld7dFzukAKzTKpX2AOck=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfkANlx/ykWvGdX8ZIcmmAzpf7AyCGPIs0gc/Xr3FjjcPSyCxZ
	ZXa17Cv/e+yFp2IpbCmkCQIRfkR4eaIhRF6c5KKA92iQXGWHdx0PCpxX2cHTTmf+DqOm+kvry0h
	ArZcYMoUNtgE/ad/eaew8XTEpkJ8LXgU8
X-Google-Smtp-Source: AGHT+IH3lP7KAoykN0To282xGvVNtEHqvg8PeudVm1toAFmsf9360PIFXj0/anZ8PL8vlMuYpo2rcIIlD2Dz/rt01Dk=
X-Received: by 2002:a17:90a:780b:b0:2e2:b20b:59de with SMTP id
 98e67ed59e1d1-2e8f1068be8mr9423408a91.3.1730382755534; Thu, 31 Oct 2024
 06:52:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030180500.GA2334578@thelio-3990X>
In-Reply-To: <20241030180500.GA2334578@thelio-3990X>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 31 Oct 2024 14:52:23 +0100
Message-ID: <CANiq72mOVRNmCNTLv9yBegAVvx5mSLqayoEa=FU+0NdWtyiDfA@mail.gmail.com>
Subject: Re: Prebuilt LLVM 19.1.3 uploaded
To: Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org, conor@kernel.org, 
	ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 7:05=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> I have built and uploaded LLVM 19.1.3 to
> https://mirrors.edge.kernel.org/pub/tools/llvm/.
>
> If there are any issues found, please let us know via email or
> https://github.com/ClangBuiltLinux/linux/issues/new, so that we have an
> opportunity to get them fixed in main and backported before the 19.x
> series is no longer supported.

Works for Rust -- boot-tested under QEMU x86_64 a kernel with it:

Tested-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

