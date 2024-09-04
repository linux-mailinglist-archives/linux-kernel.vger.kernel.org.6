Return-Path: <linux-kernel+bounces-315943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47D596C8F0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 22:50:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035191C25BB1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 20:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5930517B514;
	Wed,  4 Sep 2024 20:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+FVqOBN"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209251714C1
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 20:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725482910; cv=none; b=JlxieXwNBRNjpKx9G5UE359ymXj3Xr8CUdXECadEMnFvvSQZ7Jlf1V5qv9L/xs2+Swm0r7JKy8SFoJrE8RO4cQAwY1d4nKPAQ57AUtn2qAk47CEIkmq2EaAMoeEjjt+UAXMUJh5Kt/FrzQljyAFwN42sUotd/CV0HK8wZwz471E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725482910; c=relaxed/simple;
	bh=IlJyInQbVE7u36t+XXgKiK53ANBHKwwMMhwzf2pzfBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=emLDyDpBbkvWSD8y43n+fi7HlZrAqQKfydO/lNtt7BAUDUFXl0ROBxBsBUZCcZdB88QbQgbxM62P4imjNC7wbUqwvNIydYvfhHsQzQUEGzr87wgr0j1oyeUVbjduMAhSnyPpBFcjFnldMCTXDYtfXCxylujMflJwdnEqB478AqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C+FVqOBN; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4567fe32141so28051cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725482907; x=1726087707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlJyInQbVE7u36t+XXgKiK53ANBHKwwMMhwzf2pzfBs=;
        b=C+FVqOBNOxx7XkHDFlPxba1pKcW+FPVRZ1XczH35o1arUNEmTAt/yA961yMdFV7FX7
         Ih97totuYdKbOWzaiqikj9hjUTjY0yobopDRhO7BEeZMZGxaJXK+Yq0qubLNbunnmLJv
         BNY90s19C8iY8Q2/IoE31XCC6/xDgtysogXItJjFiwYeODdC66eom57HndQcTo/28Vnj
         8wCCy8noCcTbNNmfRb9bvPfcqggRN4gwiJfeOy6LOYJu9ZwIm+mnyw9QAtkDiyqzh/CF
         L9+aWnpQl8x/AfiUXyp+KqQ+CQqAFn/o+/oOWXE+5v4zenSLepeaSyK+jx3lzml/MCdt
         83Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725482907; x=1726087707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IlJyInQbVE7u36t+XXgKiK53ANBHKwwMMhwzf2pzfBs=;
        b=N05Bb9c6E5M9Fpg4RSUwo0uvVwOdubO1bQCZvcX+fG6oNtoFjKmXorhZ3nWgZEt/GG
         FarnAIj9WS2hqMDzK2tYHb6qaL8yMO2x5JgS5cNIjSd7QrREfunOxVQrDY+q8xYuIItA
         mpIJcIyCexv1ivbXCxnAO9ITyBob9b6l+EDfwM9mbm7U9JBSYC1h6EEiPADclZcR/4Aa
         4FonfseaUM3IDT8Tjfiz0ZVYDLcTleYqpNf9Upj1TyRyiz98cNQizYp1vCPGog5FQYlw
         LmafTjiedRi4G3R8d30lD0cVWso4/Hqn2hPOKj46kvXMd255mTf7Ymlgrm3em+tEWJQ1
         okwA==
X-Forwarded-Encrypted: i=1; AJvYcCUOC4xIeaakH9Z+dYoeGCAmQxUfhoHqMIDiuhTfPGv0cztJNtu6dvVI+1HTAPyCKSM3y+DVRcwuTzfUaYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjP3PnI8kTcGBqoTntH0pWvAp6NDIzrl5rLQMjEPWyvZEeMgmS
	JGyMaU3vjGHp1hIRtriPPNSITCEsKtHpYPx90Z00Ch7zixVklm+720p9sscM8J1mABRlX03i6wq
	HBESHa5pNC8S1xB2Hz4wKWu60AQEKXYZ7kK3C
X-Google-Smtp-Source: AGHT+IH29w72UxfNOmF+cOkn6nGTKhQJqTJySHQ6AISmMgpemfPBBYnt6mkLOYyAZK7vuhZ4wOocZ3LTTemcXVPpeUk=
X-Received: by 2002:a05:622a:64e:b0:453:581f:f29e with SMTP id
 d75a77b69052e-45801f21252mr1019391cf.24.1725482906905; Wed, 04 Sep 2024
 13:48:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815173903.4172139-21-samitolvanen@google.com>
 <20240815173903.4172139-39-samitolvanen@google.com> <CAK7LNAQ4Qy-Z7Z2ads7JNRs+aTP5BrRTqCZgmm51e+_6mU3sYg@mail.gmail.com>
In-Reply-To: <CAK7LNAQ4Qy-Z7Z2ads7JNRs+aTP5BrRTqCZgmm51e+_6mU3sYg@mail.gmail.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 4 Sep 2024 20:47:48 +0000
Message-ID: <CABCJKuccRnMAn4VUWjD4=2NXOR1a=wpHp-iNNUTv_Eh4e8155A@mail.gmail.com>
Subject: Re: [PATCH v2 18/19] x86/asm-prototypes: Include <asm/ptrace.h>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Matthew Maurer <mmaurer@google.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Petr Pavlu <petr.pavlu@suse.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Asahi Linux <asahi@lists.linux.dev>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Masahiro,

On Sun, Sep 1, 2024 at 10:51=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> On Fri, Aug 16, 2024 at 2:39=E2=80=AFAM Sami Tolvanen <samitolvanen@googl=
e.com> wrote:
> >
> > <asm/ftrace.h> refers to struct pt_regs, make sure it's visible.
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
>
>
> Then, why don't you include <asm/ptrace.h>
> from arch/x86/include/asm/ftrace.h
> instead of from arch/x86/include/asm/asm-prototypes.h
>
>
> And, this patch can get in independently.
>
> You should send it as a standalone patch
> to the x86 ML.

Sure, that works too. I'll send a separate patch for this.

Sami

