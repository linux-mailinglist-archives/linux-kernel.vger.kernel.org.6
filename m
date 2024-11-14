Return-Path: <linux-kernel+bounces-409479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324C69C8D55
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E9CCB3139B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4861F78C60;
	Thu, 14 Nov 2024 14:48:07 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE461EA6F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731595686; cv=none; b=CpntIQD12FYo/k9ly23Mj0Pu53hV3JZloELehKkirWXcC4x2eQDB16GlZvmPBx3XFWt7g+x2ZLsvxxK8Ia5qmHc8O3g5ScwENREvkzBozI89QOZIOekno/NDDmupKbxw/BY6s1RBVtFV+3Z2i6EFewJdGRSnPsm3oA8MYElMa/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731595686; c=relaxed/simple;
	bh=e6/S+V1DaviwAKbHbrR/y2EiTOl1GhkmcEFCvF7rE7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P2AXqjME1dIQtzgIV91FeFAfNY4UmRERnA9BHD9I1xP9b5G2g3+c4HeWExgjDrlNQcJISTKvljn6Bx5DfRSSMFL+uR5PpAswb0cDnJlzQ3wCF+2WRnP6yesBWgwmE8TLBi/8FrRHrOAIZ4Xbs6qj1EGfzxgkMUvZqWNIaJumvhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6ee40e83288so9042847b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731595684; x=1732200484;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PPExdKQ/tJobJg3y/a7AXkHlNJlN5qknfYvlBFbwJ1g=;
        b=LXDCtxUACi8P8lSP0pF8YN4D8RYGcdNsJbv2Kk0QyoYSfyDv6V/pPd4+KxJbpIR8NA
         t+k011lROzVS3zevyMwugEuF6yDruKhMWcLrafuoZ6s6dpsOU4Sl/cirdv7caHvtNcZk
         /ZJ2HEWvjPKTsoHoCpwXF1oGUI92aYY6vgcgTB0YLpc7CAbEDzl0SSzXIJmQhGY4cUpn
         zpttFTHD6zlvkxeOi+D+65WZYYq0F3q9O89ynmqy6YosBhPEUnuo5qM6rfoHstRezVmi
         9qWcbhoHpv8gdmC5fkoArX1pu+n9gbNUcMUpO7CTfDPUr1SWOeyYA6zbxPn7tvmFwsDJ
         hDdA==
X-Forwarded-Encrypted: i=1; AJvYcCVISntAUqtPWHbWzttBq1aNZoeE4TSXFSglssZNiw6tlmresoKkB9EYPoBE8D/uFbPMaeHt5f6MatdgBM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDo/RP+q3kwMMh4fwvtuWzn/VW+L5+7cxsjJhCLFFAj/KQTNPU
	pv6O/UtmuOVNNVDJ1EE2rMKTcd9eNsFxVPvpJmxCzv83xD5igT2Jp7rPREuN
X-Google-Smtp-Source: AGHT+IFa6935beE3W1izD7X1tJr07o7yCE2Fqyo75vVB3tnejOlRppD+bijtPPXbhIe4C9b6OsWQrg==
X-Received: by 2002:a05:690c:83:b0:6e6:248:37bf with SMTP id 00721157ae682-6eadddbd253mr256986127b3.22.1731595683999;
        Thu, 14 Nov 2024 06:48:03 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee44045794sm2687327b3.30.2024.11.14.06.48.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 06:48:03 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ee40e83288so9042587b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:48:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX1PyBotleSzs9v63SoM9GMbnvr1WLe1c0kD6pSYkhfm6HK7ewqxvxk9K0j+EU621kOkZTB3F/DxbxUnwQ=@vger.kernel.org
X-Received: by 2002:a05:690c:3684:b0:6e7:d974:8d05 with SMTP id
 00721157ae682-6eaddd86fffmr247240007b3.4.1731595683535; Thu, 14 Nov 2024
 06:48:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114131114.602234-1-mpe@ellerman.id.au> <20241114131114.602234-9-mpe@ellerman.id.au>
In-Reply-To: <20241114131114.602234-9-mpe@ellerman.id.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Nov 2024 15:47:52 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWtqNsmO=t=OF-2R-gA+khuKiGQOrBXRigE62bNjnUxPg@mail.gmail.com>
Message-ID: <CAMuHMdWtqNsmO=t=OF-2R-gA+khuKiGQOrBXRigE62bNjnUxPg@mail.gmail.com>
Subject: Re: [RFC PATCH 09/10] i2c: Remove I2C_HYDRA
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Michael,

On Thu, Nov 14, 2024 at 2:11=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
> The i2c-hydra driver depends on PPC_CHRP which has now been removed,
> remove the driver also.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Thanks for your patch!

> --- a/drivers/i2c/busses/i2c-hydra.c
> +++ /dev/null

> -#include <asm/hydra.h>

Looks like this was the last real user of arch/powerpc/include/asm/hydra.h.
drivers/scsi/mesh.c still includes it, but I don't see why it was ever
needed in upstream.

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

