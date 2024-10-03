Return-Path: <linux-kernel+bounces-349003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3C498EF39
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 14:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78281B25D94
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 12:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13171741D4;
	Thu,  3 Oct 2024 12:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyqNGmMx"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5A4174EFC
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 12:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727958500; cv=none; b=eeIbHaPoqgiu2RuSAoWdHzcZbXNlORDFT8FWjGG0O8TU47Gqjh6aZn4kFoEdYiruGphXIyA5r3PAHkyRmNYzOA6uWGectUwbSCpGoSWWKApgTBEO96RirCjK2IHNA6seXDAIxfODzgp1Xd5Nd6LMXF57/YOFbqniy4HT64UDyYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727958500; c=relaxed/simple;
	bh=ZnNdJyJWElv8zFvajdG9EQz72rBECEfs5klUeHTYmnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q55j64JUDZnU21Jao21ah+N6gaTVkggerXuXh2LbAaGWts3qw37dvNwry9eKCoULF15dniUI8RmRQ0TVamv9eTiful+k4HPqYjLx6YGB6EOvdFgCrEOw7ZDaasGc/YEJXGQKwykfaPks4O8NhdLrEgRPe37QuTgyLTK6iQH3Bvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyqNGmMx; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20b067fcd87so872295ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 05:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727958498; x=1728563298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZnNdJyJWElv8zFvajdG9EQz72rBECEfs5klUeHTYmnE=;
        b=fyqNGmMxLACbEJAlsFLvfnPYCyAjKfdPrqiOe9CH1utkUFxAzs5lskLu+jPNnSztQz
         wTU1fRrBnuhqJDMoRVoOrxI051jR6+7FnnnKX2jhb4Gi8paOStTEwLSVjDVzHf2T4qPO
         IEzL4e2eFH+dtGxkNmr9Mzk0homwfdCCtTfm5omuF7aA/L+jGkNbVEWEEjuDwWsimQcw
         l5eBMwYileBYI0qHNQ52APYzqy/b8qYVTqBPXyE08rK3LgLzqFrhAivobX4tQRuezXkv
         WD+t+U7m6KhXddfOyJGyWV+DFXUTsddRCNDY95wT7fZZeCjyNBvYyesm06RM5x+6OUNB
         az/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727958498; x=1728563298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZnNdJyJWElv8zFvajdG9EQz72rBECEfs5klUeHTYmnE=;
        b=rB4cq95FDbTfxbzma7kM+e23AFNwBwaIJ22CEigv4tsh+Ik2IZ8h7G8MHTJedsAGqQ
         2D5s/zLyqiXdwPh8eIf2F56CLvD8gAQ+KL+TEZDJU4Dx/qP+ihgWYBppqaLvsXonLsIY
         lzCA0VCTDyIrGaD0HHzgE3Km9xQEhXefO99DbDFizd9vwOxVTRcyXhW9aJgqhEO51+YH
         UnY6Kjm1D6i7NrxYW0/ebNdB9ATyaDvhWPHrv5NTHKBqtRROpKcgbGjVr06m2qtEchXl
         uS5Uk6zgnKxuar/DR95kui84K5KCuJuzp49zf72XaEq9JOvjBj68xalW3+D3dtuwRvA4
         V1Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVbqy2HrAKGPlOIKxAIdZVKAgdRIQR2UFaF6g6Pngzp01ILoIVlYDehdIXSKUog4XoXegWV7d2w/cU8++E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUw1ZQFO1u8LfPD8DqQ8S+RWtYKSCTesT4VLACmTatQW/0e31G
	HYMbVdWXlUL5FksbnRu1r/+4cBJypc4AxhKXYMmjvrO5NbyL7vLlaUATxq1ARVJuG5rXwMLr9JA
	C/TLxjI9Dsh3hFEhQhDegNUXayug=
X-Google-Smtp-Source: AGHT+IGCVaP88guYdifXEiIV1td/KEuY22fhh2zx7SGQEgFhCA1aFK5oaBilIMHuKF6hh3ljSAyfCIgxjjGsXN6S2Xg=
X-Received: by 2002:a05:6a20:7351:b0:1d4:f5e4:6a9a with SMTP id
 adf61e73a8af0-1d5e2d9ead8mr4499427637.12.1727958498183; Thu, 03 Oct 2024
 05:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1e82c551938c32b4dbf8b65dc779c1b772898307.1727853749.git.geert+renesas@glider.be>
 <87zfnmbfu7.fsf@igel.home> <CAMuHMdW-_oowzrzpoeU-=mD1t8P_65cBr4meY-BToYbkyQMXtg@mail.gmail.com>
 <87iku9r300.fsf@linux-m68k.org> <CAMuHMdW474PRT3F3qfcJaghoB1NTH0o2xXuuLpQfWPqpSSe-mA@mail.gmail.com>
 <87ed4xr22r.fsf@linux-m68k.org> <CANiq72k3BBCCChVhDRALxX=mrtq2dZYR1RzdVU00n2LU=sGXjg@mail.gmail.com>
 <87h69t75do.fsf@igel.home>
In-Reply-To: <87h69t75do.fsf@igel.home>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Oct 2024 14:28:06 +0200
Message-ID: <CANiq72=2MnRZKwVmDU7-XytFuA6BMSf5diOTfecXMTOa2oChDw@mail.gmail.com>
Subject: Re: [PATCH v2] compiler-gcc.h: Disable __retain on gcc-11
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Tony Ambardar <tony.ambardar@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Miguel Ojeda <ojeda@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 2:11=E2=80=AFPM Andreas Schwab <schwab@linux-m68k.or=
g> wrote:
>
> A simple gcc version test definitely does not suffice.

By build-time test, I meant compiling/running some small program to
check whether the compiler supports the feature or not.

Cheers,
Miguel

