Return-Path: <linux-kernel+bounces-221854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4457F90F997
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 01:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2998B210CA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 23:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03F2152792;
	Wed, 19 Jun 2024 23:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b="dHNHh77+"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4DC61FCF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718838155; cv=none; b=oAoEmuOv1R6oUD2FFeH6xdSQLcHOlehpEW9AWZKja23o/wR5mRHxbog6fy1Umwg8WmOyNuktnzRgsMWNDGxxH12W78fY6pafkS2MKTWL9fZGlW/MgFLBDUz+Sb7I7GFF+vXK5YSihWEYNgJKjE5hmiJxaWF5u6YIGRDmcMPtTVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718838155; c=relaxed/simple;
	bh=8cOKgCCE+/fZV5sUFgeaHLiS1p/hzdH8D1P9ORGa9BQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BCFKeLhZsI67X9COYH68c4UeEXaybvEMadmrc5iwE/umt8UWPIl8pGv09EDhU9dlZAM6Ox8QiO5rghD8ctjOg9RuLXwTNj3J0b0Wt02mh5GdqpExwQNtqOE+uX1BQxMQ3ehiElDTs9CVCMwO1OjqBW//cqG+duzvndVsZVCPBzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com; spf=pass smtp.mailfrom=tenstorrent.com; dkim=pass (2048-bit key) header.d=tenstorrent.com header.i=@tenstorrent.com header.b=dHNHh77+; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tenstorrent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tenstorrent.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2c7c614b7dcso56088a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 16:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tenstorrent.com; s=google; t=1718838153; x=1719442953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dWkQUm9OfoeajTLTENIn0KJlC31Px5cJJWI4W24MQ0=;
        b=dHNHh77+dkc0Ao1drIH0B6Rlbvt0AWfPVSupXMx+3CWj4ueWdj8EBxlV4BdgeQMYpO
         NoB0zxn/ObKU9/maYDkyHMB6WTF+SyQbHcNyI71sjgsIn0OxoK7QOQtSJP7Q60fe3DnT
         lDvtBI7JFYmhWPmshS1MH5A/V0/zUVwUNYM8TZ5hSi+qkh/6ZonOJVVeG9wJZ/YD0Lja
         npNeIZZ0NU2kQqqZ7OkC5LCYfApEJiJM2KEBeZYTozhDPoj2i7CzYvh+3n0bZsvZewo9
         /iploOyMsmjqDZQCkaaEKHPPOX0Us7VMwE6IzgTETM075kCiywcmWuPG1APMvmtBJrSI
         IZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718838153; x=1719442953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0dWkQUm9OfoeajTLTENIn0KJlC31Px5cJJWI4W24MQ0=;
        b=ktIDTxov/O5l4QB9dI4ZVCf2hJ+w6ZUvTr36oiVFWkpWQjFOcGUC67GPRCrLl/K2OQ
         iVxKu3NZcyV9m3vh6u7astySPcVXnvir7oGHYr9Myuh5CwsTClgMpU27x9jldyUOr9lR
         SpoS2Plf/sVC81uMkTQt0hWz0vzFxYNPPGgNoyGcFqx3fpDsPGK1gTWbX6SUG9dZadbf
         4Njkl9WxPpLp++t353pAFvkj0Zdam+we/92//4bQvftsyo2E6lkwbLoKZMwQWE8Z8VPO
         vbkLtThwnrkaRnqJX9dHvLYQOxGBHeoR78BTRjUwlW1MG/Ju6sZbliMV9Wu55ElMxPCQ
         TPEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP0EC62ZzHRhCf4yOwDPgIvSIUXID8ZRmGpnl2GILLPWZxxacClQjqIq4EIuAN3VZ70R6ughi0+AootOFDGEWEVC5wg6C4Q5Q7qIaA
X-Gm-Message-State: AOJu0YzJQambW0GSbP6/avb7w5Kq5kZoFD9VPDzw4HAKup2eGj3lM0fX
	ftgQLDM+ATGCrzwc1sfh32Pd/NlPj9Fe0FBbX4xsmZrupOfGudVc9blBXJnxjA9INyDm2o1ZaFU
	aR6dXhDQ+EMMS2VI/Si8F7fzcndR7W57hkQR9
X-Google-Smtp-Source: AGHT+IFp9XjlaNwKpDcHheqgWJaXZAWTOxzQ7d7NnVWmLR8GKXgj3RDZPizKzrUy0sHdB8foZjeJ62eKyxCGWbss+Ro=
X-Received: by 2002:a17:90b:3113:b0:2c4:cd15:3e4b with SMTP id
 98e67ed59e1d1-2c7b5db2a79mr3640661a91.4.1718838152744; Wed, 19 Jun 2024
 16:02:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240616170553.2832-1-jszhang@kernel.org> <20240616170553.2832-3-jszhang@kernel.org>
In-Reply-To: <20240616170553.2832-3-jszhang@kernel.org>
From: Cyril Bur <cyrilbur@tenstorrent.com>
Date: Thu, 20 Jun 2024 09:02:20 +1000
Message-ID: <CANtDSirgLW2_QCOO7kLLotONcgnYC_mHOxW3=-2d+FJ3FfBduQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] riscv: avoid corrupting the RAS
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Samuel Holland <samuel.holland@sifive.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 3:21=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org> =
wrote:
>
> Inspired by[1], "modifying the return address of to point to
> ret_from_exception will corrupt the RAS", so modify the code
> to remove the code of modifying ra.
>
> Link: https://lore.kernel.org/linux-riscv/20240607061335.2197383-1-cyrilb=
ur@tenstorrent.com/ [1]
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>

I've run this and it is the same idea that Anton used in the previous patch
Reviewed-by: Cyril Bur <cyrilbur@tenstorrent.com>

> ---
>  arch/riscv/kernel/entry.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index c933460ed3e9..81dec627a8d4 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -235,8 +235,8 @@ SYM_CODE_START(ret_from_fork)
>         jalr s0
>  1:
>         move a0, sp /* pt_regs */
> -       la ra, ret_from_exception
> -       tail syscall_exit_to_user_mode
> +       call syscall_exit_to_user_mode
> +       j ret_from_exception
>  SYM_CODE_END(ret_from_fork)
>
>  #ifdef CONFIG_IRQ_STACKS
> --
> 2.43.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

