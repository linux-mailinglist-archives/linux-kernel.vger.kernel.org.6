Return-Path: <linux-kernel+bounces-213629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD85B907815
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 409DCB241B8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4881448E6;
	Thu, 13 Jun 2024 16:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UAbku8va"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D21A23
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295467; cv=none; b=RJIJwmZQkpKhLwQqh2pM29Hn7bQEVQ8j637BGQ9Kp3MH99APF+SW1uXb0w+O/X9XasnaaO0VDonoKxxdH3mRoNZGQ3dHBYMOX9cWslhOl5LKojwHsvVo6mp7voQUZQU+gzSCypLKGK+nyGvUDDGyciJjVRkYzQCOvql6Ay5bT1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295467; c=relaxed/simple;
	bh=NxetfL+8UA5elqSQR6Cen3UPmfvfE9TG7qcJTxAigXs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGzPrNlrfOtTUXK69Upnw9dg+Fj4aJoRuXhHNo4nT4/ir6q7PcE4ENpvwLM5ObbwDAIk/viMnYXn48JIOi2zQEvl6ugVoTGRHjhSOosRrDQrCYBo2O1ZM2yomtB0J/CNXLnTtZWtC3bAfNRHyQv6O33m+QISjrS/U+u2XlzNz2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UAbku8va; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a63359aaaa6so175772066b.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718295463; x=1718900263; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UBOcYXNoCGPTWNLnO75nM0G5NCzcYXH2vvEcL0OCf+o=;
        b=UAbku8va09FbrXzbl8QncyS4ScME2TG1EZGLgETVnT3wDVzYrzl3ICLpBzopO/z9QX
         dSIhmOYsEDhVXk7RrfYgMLt+o/nHom08akVpQtxTwCgWdvwY3am9CQAe2hlr2srIqXsh
         KkxLJaatef3LNhNh8zowd84zUIdkw94zF1fa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718295463; x=1718900263;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UBOcYXNoCGPTWNLnO75nM0G5NCzcYXH2vvEcL0OCf+o=;
        b=aTRHJgpYkhReyd0sS02X1WgXh1U450aO0zWJWU9aWdMrsRI4KYULX6mFf6mqp1qJrJ
         4H21ym826ZMKwQmzwM6aB65z2KfEbvqvMtVjnP/ZmyyDI5lAOT0c1vwlV0CEP5CFAgQ7
         +2cmKNIyasxAoQDdWCx+AAA/bTIRMW3RwOGSMeFvzazR7Mh4GsDz2Qb3kg+8nknwWJZs
         uZBs6C8pbTKSuvySFi5DEy/qh8MTiPoKC76ZvU7mp8TUsmqP//LK47WpcMDIAp8PlEs9
         pI4cWolE9TMx8Rf9Owsbg4jtHUVY/EnVAL1P+rXelItNzUbkmo3CE4vGN5JS/elf32g2
         qSCQ==
X-Gm-Message-State: AOJu0YwMhlLTn0R9Mxu8L7guaOCohFESyHJsVVBNgVNOY7nxgYLhd+6s
	MpTIVcdwVQNKdmqz7beDxIOafza3AfYNNPR5xFdOBziRzw4WZOXKHL4FcLFXX7JIYNlu6Z3RGDQ
	rL/gqDQ==
X-Google-Smtp-Source: AGHT+IHVRlaCf4kVN7PvAgTRgImSZ/pPFHIfq4vMy4kZzWlR89s1mPRjg8faCoM2imY5wwdI42vx+Q==
X-Received: by 2002:a17:906:b858:b0:a68:ece7:8db5 with SMTP id a640c23a62f3a-a6f60d2c9e0mr14073066b.31.1718295463247;
        Thu, 13 Jun 2024 09:17:43 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db681fsm87224366b.72.2024.06.13.09.17.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 09:17:43 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57cb9a370ddso1134576a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:17:42 -0700 (PDT)
X-Received: by 2002:a50:a6d8:0:b0:57c:6e94:a1a9 with SMTP id
 4fb4d7f45d1cf-57cbd66c9d3mr182768a12.17.1718295462010; Thu, 13 Jun 2024
 09:17:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wjQv_CSPzhjOMoOjGO3FmuHe5hzm6Ds69zZSFPa4PeuCA@mail.gmail.com>
 <ZmrTZozoi0t/tuva@duo.ucw.cz>
In-Reply-To: <ZmrTZozoi0t/tuva@duo.ucw.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 13 Jun 2024 09:17:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjqHL7KjOWYBVKFewcKPWL7CJxddWfJnvL3AfOqfR8vMg@mail.gmail.com>
Message-ID: <CAHk-=wjqHL7KjOWYBVKFewcKPWL7CJxddWfJnvL3AfOqfR8vMg@mail.gmail.com>
Subject: Re: Linux 6.10-rc1
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 04:09, Pavel Machek <pavel@ucw.cz> wrote:
>
> I tried ~6.10-rc1 for a week or so, and it something was very wrong with
> the performance, likely to do with graphics. Thinkpad X220.
>
> It looked like GPU is working way harder than usual, leading to
> machine overheating and thermal throttling, making machine _really_
> unusable.
>
> I went back to 6.9, and things seem better. At least "have to buy new
> machine" feeling is gone.
>
> Unfortunately, these GPU perfromance issues are not exactly to
> confirm/debug. Hints would be welcome.

Well, it sounds like it is a big enough performance issue that you can
definitely feel it fairly easily.

Which would make a bisection possible?

                 Linus

