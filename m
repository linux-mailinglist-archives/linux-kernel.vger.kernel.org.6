Return-Path: <linux-kernel+bounces-216672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E0D90A2D4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6D95B2129E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B59917E476;
	Mon, 17 Jun 2024 03:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lTRQLKfR"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0F0374D9
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 03:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718594344; cv=none; b=ptEDVursNDSNSIRrRUQfCRMb724OaCUkc788IGCPyEqRxxiPHs2IzP5wS5lws6+5/7m/5Hb9tw0Rw4XXMwU54qG6jatfByBLRSf6XmWsPzsX1uGC8YYA96e/4pSwtVkWcCdZJA0M85t01td/8xcsRVU1zds0VMy+Aoj/IvSuDu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718594344; c=relaxed/simple;
	bh=LIVdduXifgv3JAoanTudcOcNqQVugPjPMGS36yvusW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpNy87eELS26i0ciQ0G9PCNeJiOYZq9vuL4GBppJyPplrpE3J7kE2qnaa4m7OVXw6s6QpqFzxRw1oUBjyOsiZxw11gzDn0k3PXa4ek1iBoQgfMuskhYkVga0m4JaQFEXuaXRV0e4U7jzTnzLkA4gZ/wEPd+QIavDYF5AYbJRAzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=lTRQLKfR; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dff0712ede2so4195760276.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 20:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1718594342; x=1719199142; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LIVdduXifgv3JAoanTudcOcNqQVugPjPMGS36yvusW4=;
        b=lTRQLKfR6nY3DFhQfufek6AUIfJ5+5TS3LrSJIXJPyrbX5P74zZZOXf5jXxnaa/OLk
         is9uZbTvntHRgPoy+ldzdwm0f3Q4r4Z30ySY8Hy19SaVCRi0Z9K5Y8FSdCsWVVwrfpI3
         /nxbCwIz+dEyn/Ff1AaMT5fLrhcjUS5dCxXdSmtLN25IqKG0CxwZYlEQO6x+kUG72Kbl
         m5Oli6c2jwgqZaipeJAkPJzOiNBsViCaWRwVUgxrOJ8OoQXn6BeX3slrJ6mL+SvFSOBf
         yzLjGaIpApWE1Mfkfsfeat9jKnnS1fmykNGmly5B2QiKRtVfMBE6aBZPRvNsvrSHvHlv
         NB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718594342; x=1719199142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIVdduXifgv3JAoanTudcOcNqQVugPjPMGS36yvusW4=;
        b=nFK2Lgr+tBzCoPxRmgLx0XacKDqQ2O5tVh44kFDGt7XdU58qPXUODXkU/2kvXo2zfQ
         74NgaB0KrluGv6Sme+7Mo65oPZI8cJX1JkBCkjtG9QUleQrwgo84TSOyueGOneHRGct5
         BWX2893RJPzr1ft0t/96uQeL6fXxJMml0dARv3tHSe+AZmMjtdAvqLeP180GuACdvQaD
         LYsehOa6Tlx34L7apE7+evZjJOujuJoBHRiOrH835CQWzpL4YPPr6Yxtw03i/WWecOYe
         vGcBsu/gq74xkSZs9JsBAbNNIr59NDC31PlnPhEdAkHi8PEbtDUL6Ytltfhlk8lcuDLW
         KEug==
X-Forwarded-Encrypted: i=1; AJvYcCXpd1pkWL3c69nucnHqqP8ui41HcJuwNTOZVfEZPl7Mrwd6L/SwfLJ0E3TrhofXQp4S8H2/ILENN2PFDAMqUebbF0glinR3zRWDg0MG
X-Gm-Message-State: AOJu0YxJx5Ri3JlfOPZOFL3K47yWQ9hferkNvsUCrOh/Lfmo7UR9zJSm
	jiEHIXO54zLOS1Vkvuxq29ppmbcR3X9q/vZcFvn8EcGnC0eAusgiEuc0U5Vx+gKSnGQb4lHyhDl
	GzaH4d8CPIzHlPeaFYRRbiJ7gDRqKLRF70XxAJw==
X-Google-Smtp-Source: AGHT+IHQBV4IwupBpori4XbWjSbGIJPFyF5FKlAKUEJsi6jBrWepsvJOB+hZdB1NKM0GIIV+IxEU2bAJZtz5lcsABYo=
X-Received: by 2002:a25:bc82:0:b0:dfa:527d:d91e with SMTP id
 3f1490d57ef6-dff150dce30mr7958870276.0.1718594342086; Sun, 16 Jun 2024
 20:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613191616.2101821-1-jesse@rivosinc.com> <20240613191616.2101821-2-jesse@rivosinc.com>
 <20240614-oyster-ditch-80e8f00fd91b@wendy>
In-Reply-To: <20240614-oyster-ditch-80e8f00fd91b@wendy>
From: Andy Chiu <andy.chiu@sifive.com>
Date: Mon, 17 Jun 2024 11:18:51 +0800
Message-ID: <CABgGipXKY0JPT8Z+U0g=KkFHFPyL3grd=1_GjQHNLbWehN-seg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] RISC-V: Add Zicclsm to cpufeature and hwprobe
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Jesse Taube <jesse@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Jonathan Corbet <corbet@lwn.net>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Evan Green <evan@rivosinc.com>, Andrew Jones <ajones@ventanamicro.com>, 
	Charlie Jenkins <charlie@rivosinc.com>, Xiao Wang <xiao.w.wang@intel.com>, 
	Eric Biggers <ebiggers@google.com>, Greentime Hu <greentime.hu@sifive.com>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Heiko Stuebner <heiko@sntech.de>, Costa Shulyupin <costa.shul@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Anup Patel <apatel@ventanamicro.com>, Zong Li <zong.li@sifive.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Ben Dooks <ben.dooks@codethink.co.uk>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
	Erick Archer <erick.archer@gmx.com>, Joel Granados <j.granados@samsung.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 4:09=E2=80=AFPM Conor Dooley <conor.dooley@microchi=
p.com> wrote:
>
> On Thu, Jun 13, 2024 at 03:16:10PM -0400, Jesse Taube wrote:
> > > Zicclsm Misaligned loads and stores to main memory regions with both
> > > the cacheability and coherence PMAs must be supported.
> > > Note:
> > > This introduces a new extension name for this feature.
> > > This requires misaligned support for all regular load and store
> > > instructions (including scalar and vector) but not AMOs or other
> > > specialized forms of memory access. Even though mandated, misaligned
> > > loads and stores might execute extremely slowly. Standard software
> > > distributions should assume their existence only for correctness,
> > > not for performance.
> >
> > Detecing zicclsm allows the kernel to report if the
> > hardware supports misaligned accesses even if support wasn't probed.
> >
> > This is useful for usermode to know if vector misaligned accesses are
> > supported.
> >
> > Signed-off-by: Jesse Taube <jesse@rivosinc.com>
>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Reviewed-by: Andy Chiu <andy.chiu@sifive.com>

