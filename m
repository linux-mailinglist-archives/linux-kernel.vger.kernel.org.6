Return-Path: <linux-kernel+bounces-185041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1518CAFC1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 15:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBA911F21E47
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A767F464;
	Tue, 21 May 2024 13:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUjDVmgU"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F737F48E;
	Tue, 21 May 2024 13:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716299831; cv=none; b=X0eN7Mw4T1RMYdJFFWi0UU6P7JrJeRh/4lWLfWzNPqw3r6vLC6ycqllpnAA8/vwlVAzneVwQNsBM+xN8cX6QLfkOKWyWb/Y1rSiKYRhOSDh/9m3FDUqQixuEZnzH/SMfc5Z46kbQ/n9sLGKiwB4esNJt5bF5/mrlFECe6zSB850=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716299831; c=relaxed/simple;
	bh=nh700QlV7zHPucf/ZaUoc9P1Sc5stx0DZKKVJkF+Dbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AKRozAy4Y6Fw049sbmALQt+4OrdQ4IZhazCNufUClgYn6Em+XRMBGwi/gqEp6jOolVfFEMYYSSuRt4bZhEoHAaRmIxMRINK6H3H4nsABjhxlPczn7NBJd02XqVtFbn3UiAVnaU4yAINVePM29zqBel+rbxjabDRKycmTzuxDRM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUjDVmgU; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56e47843cc7so8014560a12.0;
        Tue, 21 May 2024 06:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716299828; x=1716904628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emM0buPGHM3Qea7pkdrtiXLfG88POGw+bVMSHXBBdtA=;
        b=XUjDVmgUrfDFQOKgHBQigzza6EEIrakKYefuB5ED4nQAwt/R0eye7jtRTMNZj+rtSc
         catydGzX0bnGODmm+K3KKr7dImI/sbnFcG2tFnlLkIicBdvtWG8VOizRkKNcG/MfTxw7
         OasuMIWf6EsEZ9S9iT51XJRPb/TTXANdhQrfMW6dDGVezj9ZW4iqmK/ebxMTbSH+xWCB
         m69J4+LuInob3WVfYloq4cvHWgefWwhJ8xvXdixMh6R7Iy1DxLikimdh5iEMu/X2Lpkj
         /wHs8kypVDQp/rpmw7l8XzyJZL7umJhMOpNZUViTyQke/d0gNIoFVrJv7eyUAElFafiq
         9P5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716299828; x=1716904628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emM0buPGHM3Qea7pkdrtiXLfG88POGw+bVMSHXBBdtA=;
        b=YlhNirSe5gdA61MriPtvdQ2hV8xzJU9jncOTqjkl/Sv3cuZAJsPDYx0DwvnEYKF1Dt
         JIU5iTLg+IAWUCvqet8l07HvV5XgPmeBK8tp95NBiZVGnLVEd3RGNeCas6MDsJKzyKlM
         UK8+8ytSBeBJ75eLwRwfudGLNSD0NvXas4ZQ6Xql3I+MYbXDo9S5EgrF73aLfvU6E4nn
         ThwHXjJZWJfFEHXEl6w1tlvobjjVpTmYdHV7/wlEptQZ6GmxJ6Ybc9grl4w80IgPkBY8
         tRKWNTUYYwmI8pzuL1OQUOdFWe/4B3uLKJOiLewpxJX+fzeDk72w6SOwCSvctkDi4aOf
         lJiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2694Wa3ExwViSGq/ImuSfPGz8D9mfl6FjvHLuH5OZ2X+QoPPeRXmVynDU1yzkSrWDsgzIQ0kEbYN2F6YygpC6ktbbvsGI9CsbM7jiD6L03Id5yUcEHxmLmCVqzeG4HjTLdsMvQg1tAQ==
X-Gm-Message-State: AOJu0YzAnKoM1t+qWBaYO8oOvhYMSKwspMv5WktIpHVAwnav21f4akIe
	u2WNQrAXpFl09w/xibFWiBohUar8WQzRBrjC6FuEbOy5rtY7267eiaTc8yzrZzCjViEenQcAuJZ
	xDkvB8lyb7Cpv8Lrk9EhwFch5f/U=
X-Google-Smtp-Source: AGHT+IGlrIEhEpyh0449PtWaBUIUUbn6UYoi23li4foh2VI15hVY+W7ucOK0F7C/5WROZbwXGti7tIAwaK42FPEibYA=
X-Received: by 2002:a50:d7c2:0:b0:572:7bda:1709 with SMTP id
 4fb4d7f45d1cf-5734d5904b4mr22542040a12.9.1716299827717; Tue, 21 May 2024
 06:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240519175906.138410-1-kanakshilledar111@protonmail.com>
 <20240519175906.138410-3-kanakshilledar111@protonmail.com>
 <171614715439.2941344.11264816105918092609.robh@kernel.org>
 <CAGLn_=tLdJU1F-i9YV5aCZQbS0L7y7Wu+_k6Dn=6HwH5JmZoMQ@mail.gmail.com> <20240520-verbally-vibes-47604636b8db@spud>
In-Reply-To: <20240520-verbally-vibes-47604636b8db@spud>
From: Kanak Shilledar <kanakshilledar@gmail.com>
Date: Tue, 21 May 2024 19:26:54 +0530
Message-ID: <CAGLn_=vsFSrEi9uaZosZ6hOK5WKyOhBWvhWmz1GXz8vp9M9M9w@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: riscv: cpus: add ref to interrupt-controller
To: Conor Dooley <conor@kernel.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, linux-riscv@lists.infradead.org, 
	Kanak Shilledar <kanakshilledar111@protonmail.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Samuel Holland <samuel.holland@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

Thanks for the clarification.
On Mon, May 20, 2024 at 10:34=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Mon, May 20, 2024 at 03:09:44PM +0530, Kanak Shilledar wrote:
> > On Mon, May 20, 2024 at 1:02=E2=80=AFAM Rob Herring (Arm) <robh@kernel.=
org> wrote:
> > >



> By "this patch" it means that having the information in the cover
> doesn't help, but info about missing deps should go under the --- line
> etc.

I am still unable to get this part. I don't see there is any dependency
other than the two patches dependent on each other. In my cover letter
I have mentioned that the two patches are dependent on each other.

> | base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23
> | prerequisite-patch-id: 158157d32a32e765834a0cb4fc6335f9009d9962
> | prerequisite-patch-id: 4007c7386e66f93b67a2631dddca08cadcee708b
>
> That said, why do you have two prerequisite patches? This applies on top
> of 6.9-rc3 without any issues (other than trailing whitespace warnings).

For generation the patches I am using the command:
`git format-patch -2 -o outgoing/ --cover-letter --base=3Dauto`
It is automatically adding those two preqrequisite-patch-ids
automatically along with the base-commit id.
Is it due to the fact that I am having 2 older patches which I have
rolled out already? Shall I remove those
prerequisite patch id from the coverletter to solve this issue?

> Also, you forgot the v3 tag on this patchset, which confuses tooling:

I will fix it in my next version. I haven't changed anything in the
patch so I will add the v3 tag and send it.

>         shazam https://lore.kernel.org/linux-riscv/20240519175906.138410-=
1-kanakshilledar111@protonmail.com/T/#t
>         Grabbing thread from lore.kernel.org/all/20240519175906.138410-1-=
kanakshilledar111@protonmail.com/t.mbox.gz
>         Checking for newer revisions
>         Grabbing search results from lore.kernel.org
> --->      Added from v2: 1 patches
>         Analyzing 10 messages in the thread
> --->    Will use the latest revision: v2
>         You can pick other revisions using the -vN flag
>         Checking attestation on all messages, may take a moment...
>         Retrieving CI status, may take a moment...
>         Some CI checks failed, see patchwork for more info:
>           https://patchwork.kernel.org/project/linux-riscv/list/?series=
=3D854147
>         ---
>           =E2=9C=93 [=E2=97=8F PATCH v2] dt-bindings: interrupt-controlle=
r: riscv,cpu-intc: convert to dtschema
>             + Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
>           ---
>           =E2=9C=93 Signed: DKIM/gmail.com
>         ---
>         Total patches: 1
>         ---
>         Applying: dt-bindings: interrupt-controller: riscv,cpu-intc: conv=
ert to dtschema
>
> Thanks,
> Conor.

Thanks and Regards,
Kanak Shilledar

