Return-Path: <linux-kernel+bounces-406341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 133F69C5D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 17:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAFBF2814F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0FE206E61;
	Tue, 12 Nov 2024 16:44:25 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E828206949
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429864; cv=none; b=geuBU5+IpURlORoP/Gyfqx+9oCV3NFBXa5vRp5ViC/V8UZD9lU5CSc7K/v5CWZwVZWg0hNbY6JaveWPY+Xn4gjcAmvhT9DJyGH5a+YUBLXJzaqq88OPnJYYEwPg8asdd/cj2mgvKjNNg9hy0OgoNqqtVUgmqJ6Ip8xgCRJhApME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429864; c=relaxed/simple;
	bh=5dOQGx+gwTFo3YZ6rPXpccV6zQZFHM5N+yigQEmgv1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3lNDDiwa211rA6c7VsEhtaLKkX36vKMc8H7Go2raGIu/CtayCgcq2oU0aZ8rDQz6/k8c/ddcOZWapLZL3Ndo86eZ7SrrIUh8YNIraPE6Jk1Rjk8hyvDAc4EfqvevCFat5iC5JHa3uUbD93avGzB4sE5RuJ6AQqmZrnRWTy+Zdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6ea1407e978so52416957b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731429860; x=1732034660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zTjZnNxgN7bW2/C60743NYitcoHzCR9nvm3BqV+HmI=;
        b=UBnOo+ILd5b3rcs+fdQ2HVLyJq6kQPB415m/al5Nib8I0vPWMvo+ghm58EJqVFKmbp
         Ff3Ng3YH0dPatRYQ9iXAqBZp8DRhrH29FUle7j8Hfsr0/1uzJfZTnv4uvPNEd1+UoABM
         Ga0hwBi4PwDics6wJzo0N9y/xQ6Gf57kS8QAlLHKIjyD8dSePe9U1NHgGhtUNgkitqcA
         MrxNrN8yKjxhOJ8+x4PPUB/2CHaMRGyrlPwzdZfjKWI/r9aGl1pE5W8B8jekHeaYzfpg
         LASRjrJlTaQmGwDE7ntWbBHA8rdUP2d5W+dnVX7ZwtK3a29NVoxbyPghyHIrKifhY7a1
         z49w==
X-Forwarded-Encrypted: i=1; AJvYcCV3eo19UOCA3umMp5ZIu89V1zpRLkajjeqJDFEXVZgYOquVRZKo3qCWfh4tDV9oHjXyOwqOX81hls1hxZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxijNFuhlp9hbSZhMReNF2i70AuKLbRBSZrQkv3kGvaBH7G0Aaj
	GblSEXNwVJ0CZvVfHNLns51BN5QWSua8Q/fls1lcH46cCUYbze4+Lg3OGSZG
X-Google-Smtp-Source: AGHT+IFau37ho6H492cvCl0gxFCgo8xumgYDt7olx931oBx5J8507OAE1cZuUGlXy4oQ+KYa6EY/7w==
X-Received: by 2002:a05:690c:3609:b0:6e3:26dd:1bf5 with SMTP id 00721157ae682-6eadddac491mr171587817b3.20.1731429860621;
        Tue, 12 Nov 2024 08:44:20 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6eace8f0bdbsm26073897b3.47.2024.11.12.08.44.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 08:44:20 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e28fe07e97dso5948528276.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 08:44:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGrholljjW871kkHuWw0hpTQXIv4WGP16SN24lRYmvsI7f+nx/+8Vq889OL3fn26iLSBTrqL3+0MerHIk=@vger.kernel.org
X-Received: by 2002:a05:690c:c93:b0:6e3:3336:7932 with SMTP id
 00721157ae682-6eaddf8dc3emr154639957b3.27.1731429859569; Tue, 12 Nov 2024
 08:44:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1097d054ed4c67f714679de1253e45a034e647a0.1731425416.git.geert+renesas@glider.be>
 <338c06d8-627e-4ca9-b5d0-6ce87b5cc83c@sifive.com>
In-Reply-To: <338c06d8-627e-4ca9-b5d0-6ce87b5cc83c@sifive.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 12 Nov 2024 17:44:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX-MV1W2MBV0WQuXkEU-qvfbsb_pcAFrHCGWUFT7TYd6Q@mail.gmail.com>
Message-ID: <CAMuHMdX-MV1W2MBV0WQuXkEU-qvfbsb_pcAFrHCGWUFT7TYd6Q@mail.gmail.com>
Subject: Re: [PATCH] irqchip: THEAD_C901_ACLINT_SSWI should depend on ARCH_THEAD
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Samuel,

On Tue, Nov 12, 2024 at 5:38=E2=80=AFPM Samuel Holland
<samuel.holland@sifive.com> wrote:
> On 2024-11-12 9:31 AM, Geert Uytterhoeven wrote:
> > The T-HEAD ACLINT S-mode IPI Interrupt Controller is only present on
> > T-HEAD SoCs.  Hence add a dependency on ARCH_THEAD, to prevent asking
>
> This is not correct. This interrupt controller is part of the T-HEAD CPU =
IP, so
> it is included in SoCs from other vendors (Allwinner, Sophgo, etc.) that =
use
> T-HEAD CPUs as well.

In that case I am withdrawing this patch.
Thanks for the explanation!

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

