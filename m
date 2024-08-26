Return-Path: <linux-kernel+bounces-300927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5DE95EAB4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 334FEB20C17
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EC5139D07;
	Mon, 26 Aug 2024 07:41:04 +0000 (UTC)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A2F85654
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724658064; cv=none; b=Lgwg/9milTOTwquSep33bu/JEN8aIIE0SodXUVMn/LSeTxrG/gNoXDKFrYSGu1odQBs+BP7m+cnqehqKllm3UWKrERG+DWmCcVs9jNnc0K8E8Jn11Ke0nKY+zOvkzxUEUEv/+L5NaRAYH7Hf1j89P8SWbZQ5vc7J3pdt+Z3ILvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724658064; c=relaxed/simple;
	bh=mv8Pp1wkhfykBKBcC8HVYavCR2o1ge2QzhS9my8hE3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FJRR7BI97O1EoxfGCGYLDDOe12CJ/yMaqnAhbRBb0Rd1O4VfhOts9+WUuRZlXB1qyO2O9xdGstkPfxwk5EDTD5AZiCUs2DGVvacu2MoAjsQtK1KWv6uyv1Jqf2Adfqo94Zr03LclB3n4WFF9HZuPwNI4voS1Gc2N5g1Saj8xi54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e116ec43a4aso4426291276.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 00:41:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724658060; x=1725262860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAyv12PG4gFbZPXf6m2WyPltkHRactx6nRFArnc14NU=;
        b=dqZjyLsvxynxGwM/ZVv8JKFExZIty7dyALpnAY/L9DD9+fhQJlae0PZh/tBXR6yHHd
         HRKnsJk35rkHJtH7Tt83uTAKjm+Nh5hY9LLmkaJNdpsDqJrBZvhxMoqA/B78AtDhqFJY
         vI3+G9Nt+ktzPzXNQe1EvlzRWacmBHerZhyHfR53pUok7J+Ra/5GgPOsbbG8vmzu9myU
         bf8LW6hCW5BdBB2GlbQA5LwPRk2OGxjkiDHyTG+nsq6Gwzn2fzIKSWrZcLp2Yzh0AniU
         1hgWyjVArWMnP9Wes7dKKt91i3vv6EED7iRXOpOjkNYnrbtzoccPje4IhJriK+/vo6ST
         Mdrw==
X-Forwarded-Encrypted: i=1; AJvYcCW3Vi2UMizsCgj6II5UZPLmc7+hZO0Bk5Q9wDSJb48L/w4cL01Dts6+FShjxThoAx61dZa6vmuqghCOwVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOSq2z83tfpIuHJazPQY9W220g8FUa13NVEG+Dzpuy8L/MqwPW
	OAZL8LgxIsGbUjBmeiEjRnRhoGqFn58e/f0Gw1doFTNvqtb3OCRy2iqqo4jY
X-Google-Smtp-Source: AGHT+IEfI+OeOOJvbPfFdR144Q/TIAJEeqVtLBd4aC+kmbUn88Vppx0dR6s3oqyFv7YTnfz4ap1diw==
X-Received: by 2002:a05:6902:2203:b0:e17:a220:6425 with SMTP id 3f1490d57ef6-e17a83bca56mr10465070276.5.1724658060168;
        Mon, 26 Aug 2024 00:41:00 -0700 (PDT)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e4403fasm1876208276.8.2024.08.26.00.41.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 00:41:00 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6b5b65b1b9fso32915667b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 00:41:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU/jWZaP87f/D8vCJ7+DcT3LkGlao2MAdvyKmaXU7V4gmy5dqcaQ4CwevwYRYLMWY/OyGbadm1xRazslLU=@vger.kernel.org
X-Received: by 2002:a05:690c:f84:b0:698:bde0:a2dd with SMTP id
 00721157ae682-6c62422b00bmr101766317b3.7.1724658059782; Mon, 26 Aug 2024
 00:40:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3463f1e5d4e95468dc9f3368f2b78ffa7b72199b.1723335149.git.fthain@linux-m68k.org>
In-Reply-To: <3463f1e5d4e95468dc9f3368f2b78ffa7b72199b.1723335149.git.fthain@linux-m68k.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Aug 2024 09:40:48 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXot=WG9xca7XgiWtZmXhTJ_8oPkZoNifxUvnu21baJzg@mail.gmail.com>
Message-ID: <CAMuHMdXot=WG9xca7XgiWtZmXhTJ_8oPkZoNifxUvnu21baJzg@mail.gmail.com>
Subject: Re: [PATCH v3] m68k: Fix kernel_clone_args.flags in m68k_clone()
To: Finn Thain <fthain@linux-m68k.org>
Cc: Christian Brauner <brauner@kernel.org>, Greg Ungerer <gerg@linux-m68k.org>, 
	Stan Johnson <userm57@yahoo.com>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 2:13=E2=80=AFAM Finn Thain <fthain@linux-m68k.org> =
wrote:
> Stan Johnson recently reported a failure from the 'dump' command:
>
>   DUMP: Date of this level 0 dump: Fri Aug  9 23:37:15 2024
>   DUMP: Dumping /dev/sda (an unlisted file system) to /dev/null
>   DUMP: Label: none
>   DUMP: Writing 10 Kilobyte records
>   DUMP: mapping (Pass I) [regular files]
>   DUMP: mapping (Pass II) [directories]
>   DUMP: estimated 3595695 blocks.
>   DUMP: Context save fork fails in parent 671
>
> The dump program uses the clone syscall with the CLONE_IO flag, that is,
> flags =3D=3D 0x80000000. When that value is promoted from long int to u64=
 by
> m68k_clone(), it undergoes sign-extension. The new value includes
> CLONE_INTO_CGROUP so the validation in cgroup_css_set_fork() fails and
> the syscall returns -EBADF. Avoid sign-extension by casting to u32.
>
> Cc: Stan Johnson <userm57@yahoo.com>
> Reported-by: Stan Johnson <userm57@yahoo.com>
> Closes: https://lists.debian.org/debian-68k/2024/08/msg00000.html
> Fixes: 6aabc1facdb2 ("m68k: Implement copy_thread_tls()")
> Signed-off-by: Finn Thain <fthain@linux-m68k.org>
> ---
> Changed since v1:
>  - Cast to u32 instead of using lower_32_bits() as suggested by Geert.
> Changed since v2:
>  - Commit log ammended with -EBADF instead of -EBADFD.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v6.12.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

