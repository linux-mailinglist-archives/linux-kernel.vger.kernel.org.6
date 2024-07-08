Return-Path: <linux-kernel+bounces-244255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C3D92A1BB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 13:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D26FA284F99
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 11:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3987780600;
	Mon,  8 Jul 2024 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CkBgPe6m"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418037E56C;
	Mon,  8 Jul 2024 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439825; cv=none; b=L6coU52yyjRNm7JQGDObJ2kDomzgoY50n9kagzYIQqs6fqfSERlHOpaxpbCY1zfFZL9f+yqmD1BfBXCS3iQ4wbMpTQklCSgCQl1BoInsk63Ivxw9GPGWW//R08Y11afu+keUopfgqEUBDPoofvJtMV3J7j3TEsrftqrnh4kDA18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439825; c=relaxed/simple;
	bh=SUIMCgaacRO0cSlQoird0ishcpaQlxLRaKsUM24BmkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TOHa3nb8mvXh8x3lhIb7ZJvBzW8f7G7BRdww0ZRsz202uUiza1nbimXl4TTG9FGRLytgexshZGvXLsMHy12lTDlXOf+VyMyhhGIIw445vQtU658F2KP5yHeLO9wrRxtvVx505at2Q8qcOeQtHdzFQXNW2mUlSwqaBz/cTfFIdsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CkBgPe6m; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7276c331f78so3141575a12.0;
        Mon, 08 Jul 2024 04:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720439823; x=1721044623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUIMCgaacRO0cSlQoird0ishcpaQlxLRaKsUM24BmkA=;
        b=CkBgPe6mnBunUTNdctD5PXAAir+dvzp5kPcA89u+KfYYruo205NzOAX/swHhaJVnTy
         2g6RAv4Tyi74zQqlxzJaXZ5clYIEubu4l+DV9EZzsXkL4huPypJEuZ6DmDwYXL5OxrpW
         xokO2D3JQ4SAdkh2TD7YnZIcu53lZDA6lWkq9H8mANEn3bgFt3OtSufcaTjcGKxjJMvZ
         mHyc2u4wgll62e+JesJNt98SEsfQwElPbNWhofBgxF9MpYRm3056fIQhdFG0V3QJr6x/
         KV0JxyDg+n9C9Uy3HXW62JRWFxRVXPL/ZbA8L/+XOMD1zVjHDG9jPCA0pcIh+Dw9G2uR
         wmcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720439823; x=1721044623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUIMCgaacRO0cSlQoird0ishcpaQlxLRaKsUM24BmkA=;
        b=aOs80VKFnLtZA8a2ykyXvXBWHpjXmHB8agy8/DY1YdPw/JoVlg2/9gv+0Jc6n8PJiF
         ztSPSAAjrfP/HxQm96ymuRM2623wU5MmHLR678Psy+d1z1skH82UW3Er3zvNeAEx24n5
         bxsafbKWjqH9tv46/7bCKVt7jxmNG4ov7iEkbi5MEejY5pPY9sQWr+GEVn1wq6Xc1paT
         gaiy7fho6Hj+Ta2s2wqxMG+4BiHqe6SWPkX9TtTJS3SiMBZQA5n0xhIV57bku6Y8KSyE
         To5RPWxehDdtHpWZqgV4NEk4SuV4nuH2upiYYNw7kyXhKSfO5ntiNx28ABtDToKKVEP7
         3XhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVciSdGiuiejH6sYHUmHm8jGs/XzNZ7g23kmfZcUZTl+AK1qvaKAdFMOYaoiaHXnFWTBBr3Et7q3pwiKjWpgDyK4fDagDXMe++HTGr0xYtGTP8zdJXvJHaXHeGLDA1gp+3rkpDdR5n3ISEaPY8=
X-Gm-Message-State: AOJu0Yx/YzkKfddQEUldWLe1JfbP7egbfxTVXD/gffEByRExKr3e1wC8
	srCqeWeCCMHt3VTSBchABMzt2xp3KNK6/nJqzxT9yCA7SYm74nZTI6W4p4GulLGp1qicby2HScX
	VFHUzokXt4oGFblL8NYKN2gUDUAs=
X-Google-Smtp-Source: AGHT+IEcG2yYYSggHwDRwPEuj3eNKhu048mkWdz+/GOOQznG2lh2nwbizm5Pru/c0We9zgHyuv2NeWm2UWwzGuBpyYg=
X-Received: by 2002:a17:90a:d190:b0:2ab:8324:1b47 with SMTP id
 98e67ed59e1d1-2c99f381a14mr17271344a91.15.1720439823359; Mon, 08 Jul 2024
 04:57:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240708090615.2267476-1-andrewjballance@gmail.com>
 <CANiq72mB3hA6GeN2XSqRpV4m+rCbr2+NLHgmfpphjm1Wo1wBBw@mail.gmail.com> <ZovMt7AHJdiGEobg@pollux>
In-Reply-To: <ZovMt7AHJdiGEobg@pollux>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 8 Jul 2024 13:56:49 +0200
Message-ID: <CANiq72=6LSGwRsc+deE+U8H=mdgFisrKEPOYgVkZfHhGm8hwog@mail.gmail.com>
Subject: Re: [PATCH] rust: firmware: fix invalid rustdoc link
To: Danilo Krummrich <dakr@redhat.com>
Cc: Andrew Ballance <andrewjballance@gmail.com>, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org, 
	skhan@linuxfoundation.org, mcgrof@kernel.org, russ.weight@linux.dev, 
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 8, 2024 at 1:25=E2=80=AFPM Danilo Krummrich <dakr@redhat.com> w=
rote:
>
> Firmware and device abstractions were merged in driver-core-next.

Indeed, you are right -- then:

Fixes: de6582833db0 ("rust: add firmware abstractions")

And with the commit message fixed:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Thanks!

Cheers,
Miguel

