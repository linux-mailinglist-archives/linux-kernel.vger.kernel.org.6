Return-Path: <linux-kernel+bounces-351611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6A199139F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 02:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21273284460
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 00:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023B07482;
	Sat,  5 Oct 2024 00:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJpFxq4u"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023F920EB;
	Sat,  5 Oct 2024 00:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728089220; cv=none; b=jLQ5cCJ6m0BgfO/luDLVcHywrvk7s/dhEBAwcSpRgsDrdYMBhEWZGERJlvhxbiJkAV6pp4z2ps8Q6GGusqYxSduBk/uRRDAtBQQz9TKZ7GSJbvkL2Ktir8lVxVY7QisLZZ/TPfAApI4i4WYe5cNCZ7ocpKDSt9pYIo1vb21mCK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728089220; c=relaxed/simple;
	bh=2ix1mXZutmLSg6b4ccL3+EFljhC+zc+04RJRRgHeAJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vt4PzaFd24fj9llc+InmbFqJJ3roNZ8ldfxZcsrttxg2dGZm50OelrYlcAPixuJ49LbaBQCO0PwqznwGXcJiZcttARREh14gqjQozbTiu5IYlUwZwpjr9XhlAXYa7GUjXyLSxRBnkwwy1j7kZUprfI0BQknjhb5XqwJwy41AXSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJpFxq4u; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7db908c9c83so1657078a12.2;
        Fri, 04 Oct 2024 17:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728089218; x=1728694018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ud4hrcbGKn/h1c0XGtZ8JIky1UZlfWSJvz4r2INa6xI=;
        b=PJpFxq4umY0+MDZW9Z7blfflLyviiwkVWx3K0cLaC1dpqYFmZHQPL6FyvNznEfx9mL
         OKR4L6C5CbK33OE75FFvN0xgGwksM3pP/L6unfoUohHITBko1GA7U3MGd2QCYZ+6KD0O
         ii6Jgu1fY7+0hWb/4zPLicWMV3k1UXbMKM6vFNK0ciZsrNcQ50EF7McwhEAFoqkkTgDL
         eItNEcAiSgE3tdYkFkDxgAcWylAQylkH5bFAcfwtDjqFdwyHl/Bfgph38ZRwXCoXrrQ9
         Xpi/PSua8N1sb7CppoNowT6dYC0Pb0rdWMy2hM+wcAtQ7ky8X36CJN0xuykXzBlUGcPJ
         gtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728089218; x=1728694018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ud4hrcbGKn/h1c0XGtZ8JIky1UZlfWSJvz4r2INa6xI=;
        b=v2eSKVJGPvEsNTBM/mGAPxo9esAOcHTgyRoPGQ0J4fNxUDGcAo/hKID2alQpFqpxTV
         fZIKaIMrEM0ZHZmBccuC6Tg92S692luR7vFavjS/n182pBmVEua+Y2zerVRVjU5aB0rJ
         XsrIwBBxW9XCNCPXhMFzl9vMe4phs8I3hPEL+F/I6dxmiGRC+ZTzIovI7g68O1TjoZEb
         JKry9k6fZDEHNmj5V/Guk72kJAd8Md87lCjoyGzhAq5iUx8dPocwztWmKKtri5quXfy6
         uV2YLf8L3YNbL92NtpiWSS+qrSBlQ3M1A9OTneR97fjtZNrA0bctRdnW+YGLi04mVxDQ
         2uvg==
X-Forwarded-Encrypted: i=1; AJvYcCU6Om7C3loYs4tr8G9VHZQNh/3w+Wx5gmsOYsZLRJNN8GKdEWd2kOxdRXJZNCfTY8NFi/JG/scM0Ug9DXJB@vger.kernel.org, AJvYcCVD957mB2HEEds0JHZ22gQqRoPXJOwgV87KsvFHL0k6F3hv+VOZTZ0w17CPvI9NensLYrDf42u14hpg@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+L31/9IVEuC/qJVVh4sLUbBB+aoWxjXgcbXBKMLeuIaE2iyk/
	Nqfpk9U7bKSSlcEWjOTbbBqskybGmMlsA/UpIgpRcmdRXNfV/kId
X-Google-Smtp-Source: AGHT+IHyITdZkA6wyOXK2hbRbUpdHaf3LcjLr9ZrEEdEgDHpLa//7ageDewJ0I3XP9i5ea9iQOaTVQ==
X-Received: by 2002:a05:6a20:c6c1:b0:1cf:3ced:bba3 with SMTP id adf61e73a8af0-1d6dfacafa0mr6432778637.36.1728089218046;
        Fri, 04 Oct 2024 17:46:58 -0700 (PDT)
Received: from inochi.infowork ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f680c727sm623464a12.2.2024.10.04.17.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 17:46:57 -0700 (PDT)
Date: Sat, 5 Oct 2024 08:46:37 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Conor Dooley <conor@kernel.org>, Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Peter Zijlstra <peterz@infradead.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Guo Ren <guoren@kernel.org>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, Hal Feng <hal.feng@starfivetech.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Yixun Lan <dlan@gentoo.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: interrupt-controller: Add Sophgo SG2044
 ACLINT SSWI
Message-ID: <42ndts6wuoor3tbt3uv5kuco37kc6bnnoepqtauqosw2gg2xn7@7hfdc6wgvlsm>
References: <20241004080557.2262872-1-inochiama@gmail.com>
 <20241004080557.2262872-2-inochiama@gmail.com>
 <20241004-patronize-doily-8406fa214347@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004-patronize-doily-8406fa214347@spud>

On Fri, Oct 04, 2024 at 04:44:22PM +0100, Conor Dooley wrote:
> On Fri, Oct 04, 2024 at 04:05:55PM +0800, Inochi Amaoto wrote:
> > Sophgo SG2044 has a new version of T-HEAD C920, which implement
> > a fully featured ACLINT device. This ACLINT has an extra SSWI
> > field to support fast S-mode IPI.
> > 
> > Add necessary compatible string for the T-HEAD ACLINT sswi device.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> > ---
> >  .../thead,c900-aclint-sswi.yaml               | 58 +++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml
> > new file mode 100644
> > index 000000000000..0106fbf3ea1f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/thead,c900-aclint-sswi.yaml
> > @@ -0,0 +1,58 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/interrupt-controller/thead,c900-aclint-sswi.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo sg2044 ACLINT Supervisor-level Software Interrupt Device
> > +
> > +maintainers:
> > +  - Inochi Amaoto <inochiama@outlook.com>
> > +
> > +description:
> > +  The SSWI device is a part of the riscv ACLINT device. It provides
> > +  supervisor-level IPI functionality for a set of HARTs on a RISC-V
> > +  platform. It provides a register to set an IPI (SETSSIP) for each
> > +  HART connected to the SSWI device.
> 
> If it is part of the aclint, why should it have a separate node, rather
> than be part of the existing aclint node as a third reg property?

For aclint, the current nodes that have documented are mswi and mtime.
Since the mtime is a M-mode time source, it is not suitable to add the
sswi reg into this device. For mswi, it is OK to add a sswi reg, but
this will cause problem while checking "interrupt-extend". Do we just
double the maxItem? Or just left it unchanged?

Another reason to add it as a separate node is that the draft says
sswi can be multiple. If we add this device by adding reg. It will be
hard if we have multiple sswi devices but one mswi device.

Regard,
Inochi

