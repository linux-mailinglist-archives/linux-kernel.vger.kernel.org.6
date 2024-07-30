Return-Path: <linux-kernel+bounces-268349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 582BA942380
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 01:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F4C286515
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 23:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BEC194C73;
	Tue, 30 Jul 2024 23:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRzA9AVe"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B2618DF62;
	Tue, 30 Jul 2024 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722382814; cv=none; b=GwBrs64SWL8G+/DsKCOwAIhnsTjgdJ2pkhfzJPnwBrzXE8xxHwg8E3d9e9VdnuffTPPx4h1tYj9q8pfD2XtAqJfX3mT3dinFYfrz5DwVvdedDV/u0MqWVjNwyWId1lt/FnDlMmlYBSmb4f9vRW6phP3QFVn6DgsJsjJF07mevKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722382814; c=relaxed/simple;
	bh=KqCc1f1yF7Vn1+bUa5Vck1eK+kPtRz1y304EWghu0KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ag53+CcoMOrnnRH9dBhHbNWLYFADMtahRysUbd0uBqiG/HVLJUsXxsr93G0G8DDnYyW+PZrGPzVofce4iFwz8PsXmP5iLgxbWOwpSLjcOGnMbxW2RehI7AuGM1AulQjF1M0OpGlXfIeB6kEQNOyxjocB+81V8NKbls9NcZzD+lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRzA9AVe; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7a103ac7be3so3069450a12.3;
        Tue, 30 Jul 2024 16:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722382812; x=1722987612; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqCc1f1yF7Vn1+bUa5Vck1eK+kPtRz1y304EWghu0KI=;
        b=QRzA9AVesF/Orz2V68zWXXCc7ixfE14OavSdPuQB7jUovvOpYzS1AtT+Hv0xNm0Zif
         PYh40df7bvpqXyxTioORT6Hkv5hHJzMzOwhqcm6EjFA18vN+zGmAm+G6SY/Y4f2e9bxB
         dd2kda55r89YXVkd+oaXNM5x/AQQV++VHFPoyNNenrN0rN/xqWY8S/pkxszIbDTqRqSJ
         fEQtuMkXVw+JuQIx2qLjbO3UgoraarI/Dm9WxsGwKPa8JCOBav7GCwLd5nalg1h5IPX+
         wGGXoSXPKK4ipkLNnDQs8gpHniBbAdzKk8uKzOZjZvf83vcT7QuiFV0RLMRKYOggkHIY
         5k2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722382812; x=1722987612;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqCc1f1yF7Vn1+bUa5Vck1eK+kPtRz1y304EWghu0KI=;
        b=NHSZi1bsDsmQSaM1yAfQ+Xg+HTjO/97CybueSaQKX3tK36T5QiVNyq8loBjsxP6v9Y
         NriP8OHBT/xXIG+d/HAdhcEG3hWX77oEhV9s/IyubtLJqWkurqvIljDzHV1QQAyagWIV
         8YRgNmsZtFIbUvcTFlIjdTOYZAwE/Em9aHi5i9ZFx+i4vYfj4Kn8pJc/f9t0+NFo6oQB
         Wc4DHLkLWjbW9iDwlpCYtaMCVKLP1F5ceVD3O9PH/1VguFn0dddWRWkb1tyUYeLhltiJ
         LowFQOHagRswSrwiByT1OoWDJOsf4cBXBxhqHuVe9ixInhTyZPUSRLkAwsqey7KUISSQ
         jo2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUnRVgNSYQxbLkDrk5VHY1DT9qXG2Z5BuBOfbKlqN8smPpH8R3AJDJWfPiTIQ7gLXfeL5Ze7CKkRDaFB1NpdijPMhx+vYsBBTeF23e5+2xsYY0nD3EGbUmfHak1XGXvLkYov+kSfqdsAAZTZ74=
X-Gm-Message-State: AOJu0YyScWELprM5bpAbhMAJQ49BIMHR6pGNWfzlTj9Gd3HLVT8NtXB2
	+6v7/rr/6jXtaPC6q4I8P9uHAXCibthPnPhXATtkZ77EIDz+ynpNDuw9oU6F1+YOlktSE8KZ1tb
	aKFahnyVmLGQ2GCX4D3GAkWsCDhc=
X-Google-Smtp-Source: AGHT+IGi9fW7M2ousMXi8rxvsyiJ/S6ohfSLIMZlr6s39Cl+CCCiGJSVnc8kUYa1Yivgt4vrvxrmWLnQRUZUEOyPEPo=
X-Received: by 2002:a17:90b:790:b0:2c9:8189:7b4f with SMTP id
 98e67ed59e1d1-2cf7e5c143dmr10927061a91.32.1722382811681; Tue, 30 Jul 2024
 16:40:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730222053.37066-1-zehuixu@whu.edu.cn>
In-Reply-To: <20240730222053.37066-1-zehuixu@whu.edu.cn>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 31 Jul 2024 01:39:59 +0200
Message-ID: <CANiq72mvdR7QKTarCS8AabyEr0wiZ9AJgXD=toHkRDmLLnu=BA@mail.gmail.com>
Subject: Re: [PATCH] rust: Kbuild: Skip -fmin-function-alignment in bindgen flags
To: Zehui Xu <zehuixu@whu.edu.cn>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 12:21=E2=80=AFAM Zehui Xu <zehuixu@whu.edu.cn> wrot=
e:
>
> GCC recently added the -fmin-function-alignment option, which will appear=
 in GCC 14. However, this flag can cause issues when passed to the Rust Mak=
efile and affect the bindgen process. Bindgen relies on libclang to parse C=
 code, and currently does not support the -fmin-function-alignment flag, le=
ading to compilation failures when GCC 14 is used.
>
> This patch addresses the issue by adding -fmin-function-alignment to the =
bindgen_skip_c_flags in rust/Makefile, ensuring it is skipped during the bi=
ndgen process. This prevents the flag from causing compilation issues and m=
aintains compatibility with the upcoming GCC 14.

Thanks for the patch!

> This is my first patch to the kernel, if there are any issues or improvem=
ents needed, please let me know. ;)

It looks OK, a couple nits are that you would normally not put this
line here (in the commit message), but below the `---` line (which
means it would not go into the repository).

In addition, normally you would: wrap your commit messages to a
reasonable length, use `scripts/checkpatch.pl` to check for this and
other issues, use the "Link" tag instead of "Reference:", avoid
leaving empty lines between tags and ideally use `git format-patch
--base` to specify the base of your patch (not really needed in many
cases, but it is always nice to have around).

If you can try that and send a v2, that would be nice.

But apart from those nits, it seems fine -- welcome!

Cheers,
Miguel

