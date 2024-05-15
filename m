Return-Path: <linux-kernel+bounces-180265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6F68C6C32
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 20:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F423628348E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 18:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1CE3839C;
	Wed, 15 May 2024 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HWVyaIS0"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D42E3C466
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 18:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715797991; cv=none; b=Uyy1geTDx7iCmyDEW/XFqJEBvsFNiTTUHgAVqRS+uKFqNAXJIMe+OT4ZHZ18g60Q+oPwC14RQ3IXmwUGhzYNwscl2at4LyINCYWQEDnc4apS+fLz5qit5fC2vUAZINDUYFDLgOCwSOOm5ZJR+Mk5cB3xkTOm/fAyOoqKW2VJ1ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715797991; c=relaxed/simple;
	bh=yw+ipdvPqTKvzHRePFMCEGB32d2gTHY4yIizWZv9K1I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFP377RMy8OR9XQkAFiMI/JLMZKtE8Z/3QY0KlSOCVBveHiidJdyBZgXKt2t+Wms19/EbySHrEvZoSeDT9meHLYYo6/7VPhwydlVkVKb+O2L2o3DSnZs8K5goRBTjKsxA//ZxYDigVZIRUmSjMbvFMjEdtKoQ8sZsGcU9WVuMik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HWVyaIS0; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-572aad902baso36361a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 11:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715797988; x=1716402788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KKkDnLN7qusp5ZEvAbHRefNjI/EUrE6vZKOBSo4hBmc=;
        b=HWVyaIS0npQb1JpKRAJZztkST62euTKgxU7HH4B6I6s6UY/JYNOS2+GnzcMboRQuVg
         Fxe0U5VxQAL0Ls3kn4GeWlqSHkrhcbxxrWdlpCEa0vZMqL3b1dI2pIQ6g2n0sz3sgNPE
         JwcBZdn1f1bOMgbU+PaS3KTeYNOQD8os0uq/t+xk/OoCKm7pkDtBetoRpM46sq3dyR6q
         bNpCf1RiuFA/Ilr8CBHZ11X8ClH5V6GLBY1V8GlsgcOUfyj8ABab5tXExe6IH6X3M6/U
         twwvmxwnswpF3uucX+dFrHAMNi+3HPoHsJxTkuGT3E9juJneaEWM0SR4txt686dpHO2Z
         1hHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715797988; x=1716402788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKkDnLN7qusp5ZEvAbHRefNjI/EUrE6vZKOBSo4hBmc=;
        b=Mbh65NCZoKEe2UiEme1UDRBUdG5SCed6WX6WihNKf93oxzI+ATeoTo7AzZ+P9GEU8X
         ZJpZ641pxSvBOiI+WKmZzGL0sdsP7wtBYYzp/YY8wk7v7p5qpR1+GdM9mAiGl6PouDH0
         5GlUoR30y6cNuA/BhOY0DmhzJdcnaLRaQrs3fEh7JLOL4q8SRt+sx8m2z+K1iByC/rHS
         M4zhtMqI2OpDauCbmn3phRMuovBwy0vT7plICosVdKSsaJZ3pqL/1EnYVQjoOo7kMMFz
         +RtbWySahxV6BGKaz3ww4/jger7zZ0c2l7R2SHMx+b363yul26xTJ52LOreFqQ+opUpt
         v/8g==
X-Forwarded-Encrypted: i=1; AJvYcCUqn3xkvLx7Ku4oyoWwL8BhkcQSozbMCQN2MZETGOG7iFWLxl4giIoeN7uzQ2+W0AvzOYFUjb2U5T0q1bZiEXL+HN+aGaW9fkztkU/j
X-Gm-Message-State: AOJu0YzeMP+P0c0qfuyZdf5T7wN1kG8Ffv74RWCCb+NZeTj8me4HmcOc
	2gS8cuarHFzm5Yj+3rSo1rBN20P4a6j737CZvNvcpoPTfhXW5y6mDgmHkA+HuNccA5DnnG14iAI
	P7TmeortDiqjnZtBsRtyUnp5cG4HRxPJW7/Q=
X-Google-Smtp-Source: AGHT+IF6MleNTArg5bIvPJ3/eiTCxrRw7G9TB8KN62fOFsAAIP5+dlj2ACr18vI1mrmdbbKTxO7t/JgL68s+ize3a8I=
X-Received: by 2002:a50:85c6:0:b0:573:438c:7789 with SMTP id
 4fb4d7f45d1cf-574ae418342mr914673a12.1.1715797987465; Wed, 15 May 2024
 11:33:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515010805.605511-1-xandfury@gmail.com> <20240515010805.605511-4-xandfury@gmail.com>
In-Reply-To: <20240515010805.605511-4-xandfury@gmail.com>
From: Bill Wendling <morbo@google.com>
Date: Wed, 15 May 2024 11:32:48 -0700
Message-ID: <CAGG=3QWyeWuLmJg1R7X8T4CsSgM+EiDToxjd_-8MD94D=DCLtw@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] selftests/binderfs: Macro argument 'fd' may be
 better as '(fd)' to avoid precedence issues
To: Abhinav Saxena <xandfury@gmail.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 6:08=E2=80=AFPM Abhinav Saxena <xandfury@gmail.com>=
 wrote:
>
> Change the macro argument 'fd' to '(fd)' to avoid potential precedence
> issues. Without parentheses, the macro expansion could lead to
> unexpected behavior when used with an expression having different
> precedence levels.
>
> Example Code:
>
>     #define CALC_SQR_BAD(x) (x*x)
>     #define CALC_SQR_GOOD(x) ((x)*(x))
>
> CALC_SQR_BAD(2+3) expands to 2+(3*3)+2, giving 11 as the incorrect
> answer. Enclosing with parathesis CALC_SQR_GOOD(2+3) sets the correct

s/parathesis/parentheses/

> order of precedence and expands to (2+3)*(2+3), giving 25 as the
> correct answer.
>
> Signed-off-by: Abhinav Saxena <xandfury@gmail.com>
> ---
>  .../testing/selftests/filesystems/binderfs/binderfs_test.c  | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c=
 b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> index 4a149e3d4ba4..d5dba6c1e07f 100644
> --- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> +++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
> @@ -30,11 +30,11 @@
>
>  #define close_prot_errno_disarm(fd)      \
>         do {                             \
> -               if (fd >=3D 0) {           \
> +               if ((fd) >=3D 0) {         \
>                         int _e_ =3D errno; \
> -                       close(fd);       \
> +                       close((fd));     \
>                         errno =3D _e_;     \
> -                       fd =3D -EBADF;     \
> +                       (fd) =3D -EBADF;   \

While I agree that it's generally good to add parentheses in macros,
this line ensures that 'fd' must be an lvalue and not an arithmetic
expression.

-bw

>                 }                        \
>         } while (false)
>
> --
> 2.34.1
>

