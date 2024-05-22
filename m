Return-Path: <linux-kernel+bounces-186231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D1C8CC159
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8573A1C2118B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECCD13D63D;
	Wed, 22 May 2024 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXoM8cF0"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A7813D600;
	Wed, 22 May 2024 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381537; cv=none; b=fdmlsnJVTlNflR2sXb3g2ubaMPs7C/lUr2OEUDgcAiFO5M28ujTdOdG4XiBk0dasISA1F0v8SR6O3PcNQbbnwZ9JuGHJJZ26PoM6mdJCb5tzdzFp6PPVMSNX9mCBaSUPUi1ordH9TZ7npnaUPcH7L1PSdhaNdMHBKBiPd7n9pfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381537; c=relaxed/simple;
	bh=xDIQkhllY02adSjrb3kzc45LzfmT7BSoh0HJs4BYivQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nJp9SyNwTU2aU6t5g9i1g3ClrUBcFILc/ztGg9YAvSTbiIlEWyKBZ2pdFs3U6W8AWG2gikza8cW9gX/ntKTkU0wTKEL5bYkMxZDKFt07X2eQur0quhWTdtXcepdqOPrqQehw/PrQl+kKqU6eLF4Taw5L9ofv9EmuysgPrKyWzhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IXoM8cF0; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5d42e7ab8a9so860353a12.3;
        Wed, 22 May 2024 05:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716381535; x=1716986335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDIQkhllY02adSjrb3kzc45LzfmT7BSoh0HJs4BYivQ=;
        b=IXoM8cF0DH/9PloL1JMjF8SyqVdhfZeEo9NO7PXWwQB9JXKZUVN70GYxMBkMlzZcpZ
         CmiPDh4t4i5ZRqzEDuSYkqQuBkZVx7MutSuAOMiy2knWm/bpLOtmX2azfoJ/ak2tEzMf
         FwjcOnybKKjry456Ay9bQmVG3QzosQFUXiqH3yH0Mzryp3JEw4nyDzV21+AwX3kjQzN9
         Q06xJ759zF2N6RJ9VntAf6r72Sq41oPTttvG7m4YZFj83KHg83tAXfjlV5atohz51EZc
         r4RXSIs3Nvmdy+xtQ9PylbA8nCHJBLetzQt5IP9MUbSnf8fJHhDh0DujRF4TI7qxRPgu
         QwIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716381535; x=1716986335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDIQkhllY02adSjrb3kzc45LzfmT7BSoh0HJs4BYivQ=;
        b=B/VMT1q6xOrCQ86n2SJjdBpQjC6mHBzuaHDuLwfF5LnHazcvZOqGBagQ21tKixzp5p
         qlwWeeAwIs16Xri6QO5hsklb/jO5up9ved3X5v3S+DBz+Sf3rRcyTgee4s5OyG19EOZj
         uGlJymWxAd4NRK/wemQvrht55GpNRIoYUBDFKHtRYDhRWIATBs8hsni6QVr/1W1wEn0o
         PTZa2H9lybh/7bpHlOrs1JHBSZlL/23Zf76AEUEjxJvKwtAaHB7/Wm/hjs9T3ttbFFpR
         meCVbGm62gskAGCr3HvceaL50PJjGt10yrs5nhiQIQF8hNKQZr4kb26oN5mCZ+uDWKj+
         NnUw==
X-Forwarded-Encrypted: i=1; AJvYcCVlCCIGzWKD5KiTEwj9c/EMkddafI9lPWTKpTjqwmcSS8HRxYuBi/7PBRvIGSeXUGOYgEjvQlPSYZ2HbfkqPaKOBQLx/fbcjfT9o0MZnu0uAcb19ffueh8a44CITsDUPeROZ054Rt3XP3xf0jY=
X-Gm-Message-State: AOJu0YwLBqWeNRYpbEUKRS7J8RIT3ntmweY8Cj6jGoQ90rdD28uTfkiI
	HTdAu9WZFE1kz7tYWMTNxvmNDt8xu4UsSWwqILNFflmYg0p+dtQcVoJP26FtpVyteurf0DVaRux
	nCMg2NH1HlOjTolNgiDUMnIWK1d8VwsOU
X-Google-Smtp-Source: AGHT+IEPY9L1CQGXcDSdzc/AQZtCJISoFHziN7HvOH6CC+P8l8mkXZrG5UQqX2mvOqUE90zDFXAKAq0Zkc71QWI8og8=
X-Received: by 2002:a17:90a:4409:b0:2bd:6f31:2ae5 with SMTP id
 98e67ed59e1d1-2bd9f5b9624mr1737534a91.44.1716381535376; Wed, 22 May 2024
 05:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ME0P282MB48901A79E405F9CF615FF2F1CCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <ME0P282MB48901A79E405F9CF615FF2F1CCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 22 May 2024 14:38:43 +0200
Message-ID: <CANiq72nz1a2hm0co80er+Xx3F99gjNfc4Xs6Fpp138EPhdU49A@mail.gmail.com>
Subject: Re: [PATCH] rust: kernel: make impl_has_work compatible with more
 complex generics
To: mu001999 <mu001999@outlook.com>
Cc: ojeda@kernel.org, boqun.feng@gmail.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 2:27=E2=80=AFPM mu001999 <mu001999@outlook.com> wro=
te:
>
> Signed-off-by: mu001999 <mu001999@outlook.com>

The kernel requires a "known identity" (it does not accept anonymous
contributions) -- please see
https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-=
developer-s-certificate-of-origin.

Cheers,
Miguel

