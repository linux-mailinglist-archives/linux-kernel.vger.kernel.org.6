Return-Path: <linux-kernel+bounces-289306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B2495449B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 10:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D22801F23C00
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 08:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE06213AA2B;
	Fri, 16 Aug 2024 08:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jp7sFJaa"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51AD1D69E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723797633; cv=none; b=mS3WQ78lPHx0DkMUFk6U5U76yef2dTgyUnRna88XWvQ0ub2pedxOg1x5smmcLsmpSpR+V/ersp36Z5KIJK7tRmQHIeOvNi8voPK4YEwerNU12oQSTmN/yOIidDNdiLlRL2OMt4626/8lYgELH8ICLKk9pUFJrTmlG1gkWNoSEGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723797633; c=relaxed/simple;
	bh=iW79sM3hHo+mFnCCGnCj7nr83XhiO9hlT6whJOECIRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mbNC53r3glKv8FzOAVBdC0WfmIIvSsvVqtb2ekqr5a1yP5Uv45K4fLnRO0sHHFez6+YGLORcM8H2OadX9pX3GV71JhSlhcM4L74VHQdlEvF5fW1g2uY3oZILRhVp7NkUlM72iNc7Z9YwCC819p16QNVByavtl6rezaRpjSWohPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jp7sFJaa; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52efd8807aaso2359376e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 01:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723797629; x=1724402429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iW79sM3hHo+mFnCCGnCj7nr83XhiO9hlT6whJOECIRc=;
        b=jp7sFJaa26Ez35yu9bTICY46dr5Gm5oJQ1lw5DSF6SnfhEcBYOMkGahNPbnR0rg//e
         FtJwiZ/aw/XnBjW8QaIjt54jnfLMttfIzXNcB7152mRTzHDiPWArjXzQ2Iv+fCr7O1dc
         8pU7UY5N9SNgxkYfr9nuZhVSYIO7gvoBCpvp9K/hF3kXiG7YGBklib6oxfX3vBVpLoTt
         3MrQ4cNMj9mz0SG7YyszmJP+7h8mgOwOyK1giiwwSq3lkVMwwTGpUHZCSM+DIGkZlree
         4FHXn9z3839/h/8aU5XoQhWfDCe73MUTEf7izRdGOlYv0tx/CWkBUT2If2EBMnPV83H8
         Jg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723797629; x=1724402429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iW79sM3hHo+mFnCCGnCj7nr83XhiO9hlT6whJOECIRc=;
        b=WNHe25VbGfIiDQ1ZsGCMa5TpgEaallilhkln7DMHTrYe8fS5Q6sJSTSxfCOQDr0ofc
         jrVfnaFeCOHtO0z6jExdoBlZrt/x/28SzWlGfr2FBmTWOHEKmWJoP5Cd+ReCwIgEnMnB
         TtcIp6iwrMydK1Ay/6ltzN/q+oaznURR6pGTiwvrP7vZLwOtxFG68NV0zLBVEQeR9WzY
         SHcHxqbgwPFjnenxDsAV69LLpz5A37MAG7DR7DDfAvRK81U57bH7M+5gySFin4kNyZvH
         R2LAsrnCzh6xY3+2ix9cztOZoFvuGChK6Vstgayar4sgM1LWh2zVvjFvJ+HOKOk0YqMV
         D/Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWi8va3flBqq29LhCOdbR+qUAjuzNG8KMTjVNIoaltucSvcI7WQkAYKm4GX0CssVOgCKe4OhQwF8zC++X2UE5jPGCO/8BJc63ePeirT
X-Gm-Message-State: AOJu0Yw6It23t+jGKxiyaxd2btRHw/8BDP0o1zhl2ktsX6XvJR0EEyGL
	J7mTkAw9v4MOFhWxfoey9dpIpYy52Z/9VyRxX+HPtZy2rvpVSdDBixMDzTJb60jX6Rtmbo7G/Xx
	qrMPyKwcrci39OeZPvQdRKGKJF/FZn3pf3kjD
X-Google-Smtp-Source: AGHT+IEK8j4hjMmZi4qGx/qKmnXlqNbCTjDDytBa54fmrI2TvjtsIb0RoEBYPjaEmcSo3NgCpHBPsW90ABxFXliAnbk=
X-Received: by 2002:a05:6512:6c6:b0:52f:228:cf80 with SMTP id
 2adb3069b0e04-5331c6dc7b4mr1255122e87.40.1723797628284; Fri, 16 Aug 2024
 01:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815103016.2771842-1-nmi@metaspace.dk>
In-Reply-To: <20240815103016.2771842-1-nmi@metaspace.dk>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 16 Aug 2024 10:40:16 +0200
Message-ID: <CAH5fLghAMrKjCuJPEv6P8gTd7x0q=F2L+avfJC=XFA2QgGQBCw@mail.gmail.com>
Subject: Re: [PATCH v3] kbuild: rust: split up helpers.c
To: Andreas Hindborg <nmi@metaspace.dk>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 12:30=E2=80=AFPM Andreas Hindborg <nmi@metaspace.dk=
> wrote:
>
> From: Andreas Hindborg <a.hindborg@samsung.com>
>
> This patch splits up the rust helpers C file. When rebasing patch sets on
> upstream linux, merge conflicts in helpers.c is common and time consuming
> [1]. Thus, split the file so that each kernel component can live in a
> separate file.
>
> This patch lists helper files explicitly and thus conflicts in the file
> list is still likely. However, they should be more simple to resolve than
> the conflicts usually seen in helpers.c.
>
> Link: https://rust-for-linux.zulipchat.com/#narrow/stream/288089-General/=
topic/Splitting.20up.20helpers.2Ec/near/426694012 [1]
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>

Looks good to me. Obviously this will cause some conflicts with other
stuff, but that's okay. Better to get it over with.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice

