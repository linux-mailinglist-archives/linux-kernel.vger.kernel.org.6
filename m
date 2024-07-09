Return-Path: <linux-kernel+bounces-245895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A7E492BAED
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 15:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF1D1F24142
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 13:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022C215B968;
	Tue,  9 Jul 2024 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fwag4LSY"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E97915FA67
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720531316; cv=none; b=OuBhkqen0cZiknCvCXBVIWxRR1lp10HtErxVFywH3i9outI0NK5GjOAAP1IDF7E2DoZd9UBidVbh5e8oPwBJQ5AROE5e4xG7Alxls4qQ2bveVxNOJQZwhsendcoqSdQimOVqUft38brPJSVixP7F5Zr3upj0ZR0p7dKPnJgt0E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720531316; c=relaxed/simple;
	bh=k6JiNPjzCUXlWLR2VKrt+9v5eOoNlh/Q8eoxarWSitI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tuJ+cr3j78d4YUNA2DqEGU19MKmH565HzJsaP/LEQdJbSmdDWQQwZBMH0XXvdyj5vqb0FOs48STGdMCy9N0V5ElLdAp6vUmRLNSs/GVmvRUhN5wYcGeB1b2OYxBgRC/FPIwR9HIwgI/z/id5omdbpE81W0KtGcV53iMD0CHQ4bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fwag4LSY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb2936c4ccso201645ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 06:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720531314; x=1721136114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWfCXnbUzbCcNCB7MVb6Cv6HV8LAXJzhSocPRu67CSw=;
        b=Fwag4LSYaA5EGyThl77DA/cH2VIQ/ETN4yjzDhIo02c0oi6/EOUkQ1/obkEnVNDfti
         UO78zZct+2bumL6vv82pXES9UF+75k8LOAbzB3xOLa6ajjMfc3svnWNJDDT50yMwGnqz
         AB6GhicyD/2zorig+v9+VfzMi7L0yBtMW/QqnQHGVdEP2TL5VMtnZW49hXTPVvDIIdBO
         nO/4/w8tL3aenxVov9Uce+8wQ6tvrTkG6YW/HD+8eqr+wvhAzkiRLJTrUpDh2UP+7VFk
         kh2IELzNXmSIHKFxKOLz9/8dWy8I4I44bM05GcTT+lf+jxTioOMlx3nCRsrlf5BUvuQe
         18+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720531314; x=1721136114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWfCXnbUzbCcNCB7MVb6Cv6HV8LAXJzhSocPRu67CSw=;
        b=ALefWQuShdzIV6m8MVMV+vhjXedEkZ1n+ndIOnKjuQUw54562CCmfNwUrAm+ybUmsZ
         U6/CsTBIrXx+lQhtAgUWZHqXzXT2dd2S9fpEVjSOZb/t2uV117lcTXnzl1fDViYggruq
         zKRE7kXGsEYAEm1bk+plC4Lsut+vfkxwvy/SF41vkUCEwYTy62+Hgybz+aorwoZv9Cp2
         l75iXSlOwxe9iAURWdCsoaPIXLu3rpWLL7oq4hd9kqS0zQVSgT4qBka26VjrdELCl4SA
         AB1T5H1q/tFDbbqv9oB2XOa/jLYVdsHB8ex/ap5v6u17mZjqWCBX4VWIpKyCchHgI7kJ
         706w==
X-Forwarded-Encrypted: i=1; AJvYcCU6MbMc7or4pq2m/zdVfS4avj4hOrmCsHwLAiRpQ79Z3B6CGbnlC3qJ1egK4eGLZC+StelYPzMuDHlA+1Xu6i51jFPxar535ZTno5ai
X-Gm-Message-State: AOJu0YystgAPT6NVM5+XtclooFCN9DMP7VFI9B3AUh1XCRFkpDtZBJVw
	/xzdWJzT3D4AbqH2ZBT3PqOWg/89jZArYIR5akX6jDpdaV40EUQT70zHtMtv3RG501idWc5IKol
	Aossj/tsAtlE7BjRs8Ot1H99+xCpsnSnUqsUd
X-Google-Smtp-Source: AGHT+IHqwd134yFfeEIa6jEM4ZZ5PFKf/6flzJz0D3TM2orSLKf1ymG+qZkZbsIWwbjHya7rb59L2SSMPP4BjBUG3aM=
X-Received: by 2002:a17:902:7b8d:b0:1f8:80e1:8dcc with SMTP id
 d9443c01a7336-1fbb997a044mr2602075ad.7.1720531314085; Tue, 09 Jul 2024
 06:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708164319.3801778-1-jmattson@google.com> <20240708170541.GGZowcZZ0tZmt7znYA@fat_crate.local>
 <2024070949-blame-emperor-a764@gregkh> <20240709111101.GFZo0axWLVb2e-n_fK@fat_crate.local>
In-Reply-To: <20240709111101.GFZo0axWLVb2e-n_fK@fat_crate.local>
From: Jim Mattson <jmattson@google.com>
Date: Tue, 9 Jul 2024 06:21:41 -0700
Message-ID: <CALMp9eQ4kO_x_eS_ehLQKrvn+9cfh6b_WNcgaNj1jfakh4e8-g@mail.gmail.com>
Subject: Re: [PATCH 5.10] x86/retpoline: Move a NOENDBR annotation to the SRSO
 dummy return thunk
To: Borislav Petkov <bp@alien8.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@kernel.org>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 4:11=E2=80=AFAM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Tue, Jul 09, 2024 at 07:15:37AM +0200, Greg Kroah-Hartman wrote:
> > Sending fixups like this, for things that are already committed are
> > fine.  But note, someone needs to at least send them to the right place
> > (i.e. no one cc:ed stable@vger.kernel.org...) if they wish to see them
> > applied to a stable kernel...
>
> Jim, should I or you want?

Done.

> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

