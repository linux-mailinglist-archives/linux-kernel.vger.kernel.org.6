Return-Path: <linux-kernel+bounces-344539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2E998AB08
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 546D61C22E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3C7194C9E;
	Mon, 30 Sep 2024 17:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bWSl9Kdy"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B354E286A1
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 17:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716970; cv=none; b=MjYQjDYCQicCCS/AKNdWa2Y+7U8/tVXmCWHtEfSYKPXXk6A7b+lEmIfeR8rgS/2eUgrf4tLWVWJClS51ni9a8I76utBphRkOKFoW6TKsJGEvbMlb/SoXsL8UgwVfdxlaQzt/QEAbWRsynpOdt91OcCbEOtiT9bu8s4xdVeKVg1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716970; c=relaxed/simple;
	bh=hzTWxOWcJCYv8Jt8W87HMA9WQTO5uUVByjogcavO6lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I+BdD7E8K7nqcJ3Fwsi2J6NIydBfAkpHx7UDUfAlYvHONOmWLZa1XXdrTgYh4ZBQdD358/+bkJ+3P7jlQ57X+Vo64e1dY/Zevti3S7BIHxISD9uvLkZMPgWoPFSR5ZIDcFGswsJ6GqZE0ciVrsPMR4IWRFMbtnv81/ZVnQkFhRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bWSl9Kdy; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a8a7b1c2f2bso768951266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727716966; x=1728321766; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IzS1vEtj1mpfzBO+imsdBSIGNGarlb2Qxwc8XfAn2Sw=;
        b=bWSl9Kdy4z0Y+DmOEw6CS4mwQf3gLgnk8kGpLHh2YYQ2QvgaIKcJpIvK/EvQGFuiXj
         r1C3Emrvbe1NvRnuT+TpwA4XXI8miYLduGhzSDYn6b32smTD9hZNa3GqIHT3dMHbxjlG
         sJ+Gus5HeIu/Dsy8gYv+KTSNFAJfSZGPy0SYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716966; x=1728321766;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IzS1vEtj1mpfzBO+imsdBSIGNGarlb2Qxwc8XfAn2Sw=;
        b=KwjHQOT3CwnBazczFw/Omla+yqyo2dULarvNCEcv8KvhSEjKmJB/bA92n+ZJv0KfSZ
         eHmzpTUjY0OWIsZHNZL+dNAF9WJKHVqNaoMuD4H83hTZ12vVhjg9xAEXMYejS6Lo3epC
         EXTcQNZMljcCIZSwa3pHPd2nvMipLo1hCRjlf6UMD46IU7hQOS7PqkkOBYKvcJ4iRuxQ
         19NTyh+9yrAbJAPV/AWZ4EJ8FA/OviDsRuwYqTsb8QU0kdR1H36uuxKj2b1KLVOyktmQ
         Ipqm3tTQjw7V2lA2BtlWzIzz7LjlOiCBe2Bfp3m59cAAbgCpj5mrLOIEoz/wrCB+O4+5
         HYoA==
X-Gm-Message-State: AOJu0YwVDPdpq2r81zMNITaniJQ4h5oHNP2cDc5l5jlmprRuaiRIhkRF
	uyhtECQE/e3zFQxPxYKCi/1lCp8EuNyrgXB+Y6HeVgPIWzJIBYHTyFhql3TabKAvF6fImIft7aw
	itvo=
X-Google-Smtp-Source: AGHT+IEXlMG0zE49FinPnXWoVyNp0Vi0VWko3Y1LCqgTeRSkkziZ8SFEhVfGuAo0KWayARtZVlYO9A==
X-Received: by 2002:a17:906:7315:b0:a90:b73f:61c1 with SMTP id a640c23a62f3a-a93c4aa6b45mr1445888966b.61.1727716965756;
        Mon, 30 Sep 2024 10:22:45 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c299abd0sm559430166b.213.2024.09.30.10.22.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 10:22:45 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8a7b1c2f2bso768947866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 10:22:45 -0700 (PDT)
X-Received: by 2002:a17:907:3fa2:b0:a8d:29b7:ecfd with SMTP id
 a640c23a62f3a-a93c4aab828mr1540225066b.54.1727716964834; Mon, 30 Sep 2024
 10:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiwVOCZsC6a4dLdb1UjL2fS_CnLNjrPL0XGFbDd9C26Cg@mail.gmail.com>
 <ZvqkfSM_8sxTSzz_@zx2c4.com>
In-Reply-To: <ZvqkfSM_8sxTSzz_@zx2c4.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 30 Sep 2024 10:22:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjm1jLqnMnLar9XRDAwDTHcG7e9+cFhq2bgz4Q+5yysKg@mail.gmail.com>
Message-ID: <CAHk-=wjm1jLqnMnLar9XRDAwDTHcG7e9+cFhq2bgz4Q+5yysKg@mail.gmail.com>
Subject: Re: Linux 6.12-rc1
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 30 Sept 2024 at 06:15, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Pushed 5.12-rc1 too? Odd.

It's an old tag that was renamed to v5.12-rc1-dontuse when it was
found to have some particularly nasty problems:

  https://lore.kernel.org/all/CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com/

For random reasons (read: I had an old repo) it re-materialized under
its old name, and because it was *so* co-incidental in naming (getting
pushed out at the same time as 6.12-rc1), I felt it was too good to
fix up again.

And if somebody goes and randomly starts using v5.12-rc1 (from
February 2021) and hits the swap problem, I can only go "why did you
do that?"

               Linus

