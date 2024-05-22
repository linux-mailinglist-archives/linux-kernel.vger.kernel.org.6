Return-Path: <linux-kernel+bounces-186500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 101638CC501
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA3652815DE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 850751411FE;
	Wed, 22 May 2024 16:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDtrEhS8"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C346AD7;
	Wed, 22 May 2024 16:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716396096; cv=none; b=A6K3QGGLvjHJxiPxFKdOOmz1HWcMSKDz0dTKgLUfzhPhVZEWWcYytN/QUeMKUe5C98FXgTX9Vvr3XNnKAKeg6EV57x62yFsVS8gtayhawL3PeNxievCPCT8F4uKs9Wi+m20OfxURW8E1QgNftkOZpyNdv/YkIbjcesrmgiqjXuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716396096; c=relaxed/simple;
	bh=3HJZVeDMIv4Kz56r9LNuwnySLYRtafeI1iZp6necHeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tR7YwyLqFhRADKLygo2Bxkv2zCQTL35jqww+2THDZuIDEXEGA5PumARexXbCvWpIvkj+8PA0AGTBhkC7C2hFa7JGtuCmyfHYKcEtLquVHAr27lbR4z+epVCYQRYq73n8o84jJYIbnvu7fTu6fD6If4ULhiEr0orC0ELSoKJpIJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDtrEhS8; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56e6affdd21so3743521a12.3;
        Wed, 22 May 2024 09:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716396093; x=1717000893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D0D2E2cfbbxVHUzTYoIqfwhIyGan3otmR2xS4JLclOU=;
        b=MDtrEhS86Htnr2eGqsxzx70c/1+683CcrtrvB4ybTr58981c/9kp//jC8BVMG4UgkL
         rOedjW4x3saqW1tofQ56/O+s/wou9n5bwaLl71KuFrYste9HsEMKDxpT+YKeA3thAvGG
         PXbG8dxibhmaSIz7WUYRhrvi8cEolvp17JxoBdMqsHWIK5KnLqeHqIv5USoFwbQC8CKM
         sL5Q1hj0S1Qobb+c6f8tl9DIPEGrxpe8ToOFkREP7cwdKr0D63kY7Y+n6f9Yck47tkO7
         MhN0ka0kgFcpVsTbm99f60cCZNyXyGfqxNNsupfiTk3oot3dZqHbevewzHo6Pkfe95hl
         iMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716396093; x=1717000893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0D2E2cfbbxVHUzTYoIqfwhIyGan3otmR2xS4JLclOU=;
        b=IoMj3lqIazfAcqYr/WxxAc3KAvQ2GB2lvl/B72CuYjnaA13A4SqkF/9s5cY+GXakip
         HjQDqkdWilmCdHjOTHckcWwm+gKNYQSKO1Dd4h+/jJJtw++H3TKHvlm9f4O7pFjOIRyT
         OLIs3V2xBhvHzIW+H4oXCcmpxCs2+MLogCph1b3WM9NFGCUGZEFW0TqyL6C+bQCfWUlz
         CX/54FV85gfjiAI9UoHrnq8IkMRMoaWL/6pbs9tVAPFLjf/Onvf6dE+kxcnGBEWgKDN8
         0XV+V8tHk/kNTuXW2FejSDcfa6ygIH5MXVfkmOzFH23zM6h6GT/gco0BJkWjJle7GL0g
         oiLA==
X-Forwarded-Encrypted: i=1; AJvYcCUtck4To8hvOL7cq53mioJUHuZIoIUKTPKv7KswmMeU2F9WEXlwsYZoVs13vxBVD5GExSdDxALQQbHit2WawAG2IrjY9QABc22VKh538MNfKgrgi8FbmlHS4OP7y1ueN7mWm0dQckS2CA==
X-Gm-Message-State: AOJu0YzJgI3P7IJnI65iJOp8MFf+LqpN+FhW7gKNiOyWiYxwOsYqXeyR
	u9HUA7cgu4aieNV4/n4P6wrEHlZwNCvNIRZ2//GxHh3wQTZfLRPIw6ewho+aIKlyFPfn9LkFaxB
	t87TfmksYWzFs53TB077Hi4edbsc=
X-Google-Smtp-Source: AGHT+IFFX3MYqZxTykrBDqEhWWplDnP3uOhy/1gv12cOKWc1GtiHAJtX3Yuzanuue7f8uxVzBuYnBeq7lKYou4B2Xrc=
X-Received: by 2002:a50:9b42:0:b0:570:5bcc:f749 with SMTP id
 4fb4d7f45d1cf-57832c326cbmr1934151a12.29.1716396093397; Wed, 22 May 2024
 09:41:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240522153835.22712-1-kanakshilledar111@protonmail.com> <20240522-yoga-blurt-dc5e40a0ae3a@spud>
In-Reply-To: <20240522-yoga-blurt-dc5e40a0ae3a@spud>
From: Kanak Shilledar <kanakshilledar@gmail.com>
Date: Wed, 22 May 2024 22:11:20 +0530
Message-ID: <CAGLn_=vfnQrNh63jWtUCojONAYqX3dm6qnXgA--Zi1KQ0P0o-A@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] dt-bindings: interrupt-controller: riscv,cpu-intc
To: Conor Dooley <conor@kernel.org>
Cc: Kanak Shilledar <kanakshilledar111@protonmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Samuel Holland <samuel.holland@sifive.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

On Wed, May 22, 2024 at 9:34=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Wed, May 22, 2024 at 09:08:34PM +0530, Kanak Shilledar wrote:
> > This series of patches converts the RISC-V CPU interrupt controller to
> > the newer dt-schema binding.
> >
> > Patch 1:
> > This patch is currently at v3 as it has been previously rolled out.
> > Contains the bindings for the interrupt controller.
> >
> > Patch 2:
> > This patch is currently at v2.
> > Contains the reference to the above interrupt controller. Thus, making
> > all the RISC-V interrupt controller bindings in a centralized place.o
>
> Don't do this, it breaks tooling:
>
>         b4 shazam 20240522153835.22712-2-kanakshilledar111@protonmail.com
>         Grabbing thread from lore.kernel.org/all/20240522153835.22712-2-k=
anakshilledar111@protonmail.com/t.mbox.gz
>         Checking for newer revisions
>         Grabbing search results from lore.kernel.org
>         Analyzing 3 messages in the thread
>         Looking for additional code-review trailers on lore.kernel.org
>         Will use the latest revision: v3
>         You can pick other revisions using the -vN flag
>         Checking attestation on all messages, may take a moment...
>         Retrieving CI status, may take a moment...
>         ---
>           =E2=9C=93 [PATCH v3 1/2] dt-bindings: interrupt-controller: ris=
cv,cpu-intc: convert to dtschema
>             =E2=9C=93 Signed: DKIM/gmail.com
>             + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>           ERROR: missing [2/2]!
>         ---
>         Total patches: 1
>         ---
>         WARNING: Thread incomplete!
>          Base: using specified base-commit 20cb38a7af88dc40095da7c2c9094d=
a3873fea23
>         Applying: dt-bindings: interrupt-controller: riscv,cpu-intc: conv=
ert to dtschema
>
> If you change one patch in a series, the whole series gets a new version.
> Just let git format-patch do that for you with the "-v N" argument and
> you'll not have to worry about breaking people's tooling.

Sorry for the tooling breaking. I used the "-v N" argument to make the
v2 patches but I bumped up the "riscv,cpu-intc"patch
to v3 due to it being in v3 already and it gave errors in the previous
patchset and you mentioned that I missed the v3 in subject line.
How shall I proceed with this version mismatch? Shall I make the
patchset as v3 and have both the patches at v3?

> Patches themselves are
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

I shall include this in my commit message. Is it required to bump the
version of the patch just for the reviewed flag?

> Cheers,
> Conor.

Thanks and Regards,
Kanak Shilledar

