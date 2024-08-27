Return-Path: <linux-kernel+bounces-302823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E689603D6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 10:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09BBCB21773
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 08:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66083189BB5;
	Tue, 27 Aug 2024 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nlS549p4"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092E913A25B
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745764; cv=none; b=Uf9dBh4dCfvrHcD5wz5AuDgP/0QrqELIRusM+Kcrz3Aog2lHGlOLfQsPUnDyvpOkChBZFHqPhdPx2sXtSSx7iwvmpwom8biW5iqeoszHnDp/IJGDSx3lkl0NdXYgyRAHTpxZmRIdp9wXS5FjkLfj9Za0ZNKLGdHo11yGYV2A9Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745764; c=relaxed/simple;
	bh=wlrG+jo4u8AssfQwalnT72u3VqV0xp8FeGbzhPN+7dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uw352QBHIyOn9l7akJYjYVQilaESmoX0Lqc10Yu1Dy3x3HCcqNg0ASX7XVBU2IIEUErKrA+zegHaRGjH29vXWmhg7dZgGWnDE+A1L29GiN+2Q6KCCtDUVA9okg/nlBuCX4BUS/n5IcL2M+nfVonqQ7BdY92/B3t0enr6kuq/Mz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nlS549p4; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a8692bbec79so660814366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724745761; x=1725350561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBms7y/tBFsZy50lNtASZmPiwThWbZhDKwKfTMeuMMA=;
        b=nlS549p4JTo3fPOPqS4F/iD20dzwpajKPITR05dlg8y776p0hL7WBDW4i2TozmQL+x
         pEGfAcE7KDoesQk7VCA4O3IL8Fg68xysf5mqKFKhliU0xyLE0b+iSkHCt11uJcKkfmda
         KV1yBgtaNKy90QzGkOHMd3CY3JmZk7aUxh/LyO2IAAAGODHvMfNnKYBwhUBo15PzDZHN
         DBkc1+w0ySdCgOOEyiJc+k13spNu7IBxxrN/9JKalEAjKy5NpXp7uq73elvWZWO0G7j5
         Lve/Ephfe2jg9T7VBO3JWkyu2O0XFqNZu2M0HWyp6rdKE/mZwTOQ+0gjxuXyRxLBSRgx
         vr3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724745761; x=1725350561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBms7y/tBFsZy50lNtASZmPiwThWbZhDKwKfTMeuMMA=;
        b=PGmkVHQTQ6tf6OxirJNub1N1/4BpPYf0aB7FscqV2JuHSW1ZBbCWMBiMWzdInD/WQH
         EViZ7Mspf/vlx7Cd9El+gyaKyr/o0gUDHZO1oUh7g69raIuDgo35oyaC03pONyfVxZ7X
         TNpzeNbLtslHeNrKInkJ/1hmR8r/oaERA3cd40qAfzagSPY3MYdNuL9TcpFa9bBsjVW1
         kdgymG4yXnQ5sbF+Vt8zsUmfadBcMcb5Ei5iYOzM3E4JbJC8cJ7cAqd2ljQ616OCMNR7
         hG5nTQrz0fKMmUrQXwKElaqRNvDtHZhQtrnB3Wi1p96DyWH87zW0m4muiODsMEYiCF3i
         NnLg==
X-Forwarded-Encrypted: i=1; AJvYcCXvBJbO5i8QUWNXKwFbCJ/AxBgmkGv2wPur1k+/KNtT+CUpjgbqTvOWcI613ANmydjeheZCSOXmAzISqMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpXrKyNMPL+n2tqCPdPhCEX978kmJQ5jiy0MPR8lNRlF9+2Rhg
	FE2gpqdrCpvBujrbkoVvPlD4Uo/2YGyFzdIZi7nQ03ggVTvkMkt/8yTrT1fjNZAe7cLo6CmlY5F
	8f/gl+hm/nDOAEpHlr8xMrBONrySE2Kkl/+yG0w==
X-Google-Smtp-Source: AGHT+IEPKjzBgfiAk9G0dnZjYH9HkHNAZ5iX4+y8YvtQs+BwlAOu22sCjko/Iouwb9iDtzPGYnZU+k2kKs5nhqRDXTc=
X-Received: by 2002:a17:907:9491:b0:a7a:b643:654f with SMTP id
 a640c23a62f3a-a86e39f9082mr158372366b.15.1724745761303; Tue, 27 Aug 2024
 01:02:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731072405.197046-1-alexghiti@rivosinc.com>
 <20240731072405.197046-14-alexghiti@rivosinc.com> <20240731-ce25dcdc5ce9ccc6c82912c0@orel>
 <CAHVXubgtD_nDBL2H-MYb9V+3jLBoszz8HAZ2NTTsiS2wR6aPDQ@mail.gmail.com>
 <6f1bcc9b-1812-4e8c-9050-a750bfadd008@ghiti.fr> <CAJF2gTS4L6=HE_-9rgn3L8+6R7C4Jx=QgCkvOBhQHdHVGzr5MA@mail.gmail.com>
 <20240821-6befd27b90a9e9ff89f4a277@orel>
In-Reply-To: <20240821-6befd27b90a9e9ff89f4a277@orel>
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 27 Aug 2024 10:02:30 +0200
Message-ID: <CAHVXubiy3=bEf29qpzGX0MoBXkjBy38p9Xhz7yRYN5Sr3qRw0g@mail.gmail.com>
Subject: Re: [PATCH v4 13/13] riscv: Add qspinlock support
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Guo Ren <guoren@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Jonathan Corbet <corbet@lwn.net>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Andrea Parri <parri.andrea@gmail.com>, 
	Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Arnd Bergmann <arnd@arndb.de>, Leonardo Bras <leobras@redhat.com>, linux-doc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi drew,

On Wed, Aug 21, 2024 at 2:18=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Sat, Aug 17, 2024 at 01:08:34PM GMT, Guo Ren wrote:
> ...
> > > So I have just checked the size of the jump table section:
> > >
> > > * defconfig:
> > >
> > > - ticket: 26928 bytes
> > > - combo: 28320 bytes
> > >
> > > So that's a ~5% increase.
> > >
> > > * ubuntu config
> > >
> > > - ticket: 107840 bytes
> > > - combo: 174752 bytes
> > >
> > > And that's a ~62% increase.
> > The size of the jump table section has increased from 5% to 62%. I
> > think some configuration triggers the jump table's debug code. If it's
> > not a debugging configuration, that's a bug of the Ubuntu config.
>
> And I just remembered we wanted to check with CONFIG_CC_OPTIMIZE_FOR_SIZE

Here we go!

The size of the jump table section:

* defconfig:

- ticket: 12176 bytes
- combo: 13168 bytes

So that's a ~8% increase.

* ubuntu config

- ticket:   73920 bytes
- combo: 84656 bytes

And that's a ~14% increase.

This is the ELF size difference between ticket and combo spinlocks:

* ticket:   695906872 bytes
* combo: 697558496 bytes

So that's an increase of ~0.23% on the ELF.

And the .text section size:

* ticket:   10322820 bytes
* combo: 10332136 bytes

And that's a ~0.09% increase!

So that's even better :)

Thanks for asking!

Alex

>
> Thanks,
> drew
>
> >
> > >
> > > This is the ELF size difference between ticket and combo spinlocks:
> > >
> > > * ticket: 776915592 bytes
> > > * combo: 786958968 bytes
> > >
> > > So that's an increase of ~1.3% on the ELF.
> > >
> > > And the .text section size:
> > >
> > > * ticket: 12290960 bytes
> > > * combo: 12366644 bytes
> > >
> > > And that's a ~0.6% increase!
> > >
> > > Finally, I'd say the impact is very limited :)
> > >
> > > Thanks,
> > >
> > > Alex
> > >
> > >

