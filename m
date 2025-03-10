Return-Path: <linux-kernel+bounces-555098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3CEA5A55C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E216A167395
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB241DEFE6;
	Mon, 10 Mar 2025 20:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDamXJmS"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704871C3F34
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640080; cv=none; b=THrw87uhHiZVOK2CB0mxeCCK/pIVZBIYAJqBqPn30jb4oVhOBdpqHP/MWTNC9fMV/MqqvkwwptjHHxF54fUSBVw2s7ve5hOeuXLbDLAW3khFidaX2HxfKKlSSEGIRnllIFug3+isD4WilzsA6Ocee8R5AyniBGGauX9bNH9pgQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640080; c=relaxed/simple;
	bh=zwGvI6un39i9oLCAYxFMCPolJgc4zME0SbTKfUJhTtc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ltA6vpkHhAK/0ziD65SUChGkE8vjsX6uTutqHzLIDthwa2FhSXhHYk6RK8I4QEUeWGQ6Xj9f3TvcplRGCDOzyYxB+kIa8SIKAHDrAcCf6SZkJek3lhn8SwyAMulPMtwT3BqKnuVppwAUGKUwaFx8CnzrQCsEfQRF0AYJd4mhUZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDamXJmS; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-548409cd2a8so4561781e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741640076; x=1742244876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwGvI6un39i9oLCAYxFMCPolJgc4zME0SbTKfUJhTtc=;
        b=QDamXJmSXvHdQ0whfwIK6JvgbgAzk+PZDQ/ftcgc5+Oqrrbtiuktnjtmw2TzCtcVmB
         4FyMRCwvfOXxjpyIzaeGsgBfWwrCmlZzGsb+nK3ZlCK00KICOaCuUBdxpoNx7DOmfvJ6
         5rGbzrORAeNDYBrydW5dEPfODmpJGUL4UVzyyAuqv4Zk3RJztVxp+21VDH0onYCjBFT8
         uTFu7A7HxhP+1XyICiG1mUE9Ev0vuDcZwf7e54H0FkNRUGkw4C8mWLKAlL7NnDG5XIkc
         0kZwskC+mNI8zH2lSRzl44pa1Chc16Y1i86NpaBm7T/P4f+wdWxjD8SRdPxjYNmRujB+
         JBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741640076; x=1742244876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwGvI6un39i9oLCAYxFMCPolJgc4zME0SbTKfUJhTtc=;
        b=VrmVLle9BEoEnUgMuHlgtJr9f31dSsxvzRilDH/XQ2J8Q3tCn0Ljq7a2scxXDArBuD
         vftzPf9w1KuTYmc5ziSio3BRMzMZL5LcDbMt/Q1UDH5sQEC6qdxT6vf5m+sD4wuH/IQO
         wfc3/xnV3XbK5sYEfVVB/pGe61dpRlFYi1z1/SDz24pOi/YozjBhFzBYhpqC+Bz6ENyS
         Q7hb0HORWh2FjEo7XGE+8Vd3QP+M6PH6ErgHOTM+dz7rYN0IZWp25zm3cPdh4s8xLZ9f
         d02PRRtrpQSow1rVJnxBWU0ssbvrqH4UAHa9yy6jGfhhj/zLaDTxrDS2yAP6pYdMUAyP
         TQcg==
X-Forwarded-Encrypted: i=1; AJvYcCVuQsBTlH6i7rInerXWDWtgFElpRUVwkZZKIsJkkLF35B/xLQ7UCYjxqrYLB+F94/HoJbvvY6pZGdhjXRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO0x4qtQnhS7WUPYJEaK5O8EPBqNijfPprFt3qIeyxg7D9X4qe
	7JLgEJfiAIB04fl+u2KtkvrxK4quJh1grDNYjcKRZBEpiIK4b24wfzPFslLu7qyhfEa6jTbyx6L
	US3L8ghdlZWfQFvtXjkh+JG+X7ZfF4DB2
X-Gm-Gg: ASbGncvaXRb3Y8DcNW81cf8bRtDyW16Xqoq9+TPQzZaQi0Sb0tQsiq4mPc7tWJFu1nT
	d7P9oenIRm+O99jeq5LoiJjaNyg0ioM57x+Bj3DVtdGcIY+vVruAdyWSq1b9ukCwBay/6m2xByL
	dYDYgA5KV/8vKWbaiY/azgF2iNx71qCD8u32Oj
X-Google-Smtp-Source: AGHT+IEK0bAxccg6965Dt9MN8C/plxxNeVyOmME6fhzBnIoaWQ6b0N7MCAUpr4RmCBd56G4ZHXCVWc5aPcujk//5tkA=
X-Received: by 2002:a05:6512:281b:b0:548:91f6:4328 with SMTP id
 2adb3069b0e04-54990e5e041mr5794253e87.15.1741640076364; Mon, 10 Mar 2025
 13:54:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310200817.33581-1-ubizjak@gmail.com> <20250310201227.GXZ89Hq5LVWKHjHBeO@fat_crate.local>
 <CAFULd4ZCc08kJU+3ZVdyWhO4s5fu0Y-RDPS-Y-_sPB1R0KrnoA@mail.gmail.com> <20250310204454.GYZ89PRl3dBR-9oBIY@fat_crate.local>
In-Reply-To: <20250310204454.GYZ89PRl3dBR-9oBIY@fat_crate.local>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Mon, 10 Mar 2025 21:54:25 +0100
X-Gm-Features: AQ5f1JoSOf9Ri54Ur87pupLvD-SjfhH1LXuypQEThyLTrsonp3attjR6vY2SJlM
Message-ID: <CAFULd4YwQ3dcRwugyr9-GUWbVh2cREu6qNQctKG2S5JpoEfQcg@mail.gmail.com>
Subject: Re: [PATCH] x86/hweight: Fix and improve __arch_hweight{32,64}() assembly
To: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 9:45=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrot=
e:
>
> On Mon, Mar 10, 2025 at 09:35:42PM +0100, Uros Bizjak wrote:
> > On Mon, Mar 10, 2025 at 9:12=E2=80=AFPM Borislav Petkov <bp@alien8.de> =
wrote:
> > >
> > > On Mon, Mar 10, 2025 at 09:08:04PM +0100, Uros Bizjak wrote:
> > > > a) Use ASM_CALL_CONSTRAINT to prevent inline asm that includes call
> > > > instruction from being scheduled before the frame pointer gets set
> > > > up by the containing function, causing objtool to print a "call
> > > > without frame pointer save/setup" warning.
> > >
> > > The other two are ok but this is new. How do you trigger this? I've n=
ever seen
> > > it in my randconfig builds...
> >
> > It is not triggered now, but without this constraint, nothing prevents
> > the compiler from scheduling the insn in front of frame creation.
>
> Can you please stop with this silliness?
>
> When we start doing git archeology months, years from now, it should be
> perfectly clear why a commit was done. This one is not. So either the com=
piler
> is doing the bad scheduling or it isn't. Things can't just work by chance=
.
>
> Geez.

Ok, so let it be your way and let's just sweep the issue under the carpet.

BR,
Uros.

