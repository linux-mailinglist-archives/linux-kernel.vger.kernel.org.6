Return-Path: <linux-kernel+bounces-529983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAACA42D43
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6033A8C38
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D3120766B;
	Mon, 24 Feb 2025 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ABJfisMb"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B856F206F16
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 20:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427203; cv=none; b=fMbFlT2CuEikdWKeFLxcKnipNEDAR9LjGYACykV6tgUaihrlvZFGhMRPMwOPNvsW8CAMOAfHCAZeQEp4bSDbLSXnPg5OR0OB2zg2gerMgRouNW76MpNeo+zGd22RGNnsezJBOmSNyZjrMh+UDg8KDDgdfFmdKZihP8SFXeQsEpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427203; c=relaxed/simple;
	bh=nLwuOdjdJXvX/L9DiA+yud6gW2mm3fqYEuQw5/PQS/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LS+kGUYfnhtlBOtsn5wUkro6XQfnJcu0lA9sfcYZY+Zidu6/w8okKoHTQ6Cb4B0csmPZo85w2b8WpdQqh3tdASsewFSlytQIEd7EFuZPWX/aUxqxh7AY5zNePPEIC9wEAwJTfQyQqoxSa2vKyMTOcnilB+hKnClWE6T6e3ZGKPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ABJfisMb; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-abb86beea8cso865551066b.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 12:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1740427199; x=1741031999; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=14rd0ok4JN44cEuZAmi9ww/Q9ND69yR+FOc9H5NPv5A=;
        b=ABJfisMb9JhDTVWMpr/UO/7ii1puDFErlKpEc5Lw1JOt6lMNvIDzWZvSDkiMerHHLU
         JphjU2dDWBufSEdMnbnDQ9FMddhWmz+cZNbG2i26xBcvYZMOG2BOmdg65mglIXIf9Ng3
         4qA8r/AJ3Q9qotxgUkn/mxzD/Sa3QdpffV25g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740427199; x=1741031999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=14rd0ok4JN44cEuZAmi9ww/Q9ND69yR+FOc9H5NPv5A=;
        b=Yk83rqz/XCBom7G2VE0oRzLq7Q4E1Xv1RjKnfInPlkmqt/xm8IzZr7eZ6q9xDYGbNs
         HydgV+Vg/L/OM20F83RwppP0cHMrkKXyEtKPB2PB9VmLS/TVdcYQw1tlINkUvNh6bgwl
         6/3sqcla4LDZtg+OHne+EgVPFw7ulxAiJf/U4DWk4AerSrCKde142gR82o4sMB8DgMZB
         mzJWxh+y8fV8r0PSyWUUcV3NyJOaFNXHrxVqhRrDjJzZ6MiYKKV3t5TxHabXT5W8Iy+b
         5cUoRf4tQLqSZBgAiXj7KVuY2MJYqOZPM2eHxUFIqec0UNZ5kg7sddhsLB71iS/i4LXK
         +Bmg==
X-Forwarded-Encrypted: i=1; AJvYcCXSMOb7XRYfIFYfnFbb3keVkfiAKOgzoO5S2yXKKuNKlHfJejcXe1gmk6LJFK1p+Vw2KoZcWaHpsiaZrow=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOOMMB+gxZgMk9PwbusMjn3kgt+10tPc1m+8NT54ZvoSNgtAbW
	jck8eDriSePPiIfCQXyRLFijx2DeO7Yy2RagHuqn0vIGKcmlOfFKs9QSRbIxcXA8g1h4TjirFH0
	MFFI=
X-Gm-Gg: ASbGncteezsfySsOJxhjEhIaysExlxfAcYS4OnI4YU+si3mYcqjlGw6JOYULkVeNSQ9
	4hBQkPYY+yrzfn4mV/s2cV6y6OKxVDrCDT0aBxskGhV0S8vESIADmTW0GQL9zWKxou3WbuBNUbm
	g0ECaPC27N/r3SHZoWBXqFyVeOvrncxBgr2cx/MIVCqTJl/JJrpi+Cwa/7+JZ4TAjG21HRafOnz
	7fROBbvXyK2dFdhwLqndfQJjndDrNne4SBsKGjFVHEDkvgd/uEl9AnLnDqGwceAIyEcJWxVMARB
	V56nALa1yW7zZhjBDqABLYj4EKHFFayclJBpOm3IjCnUpfUoKHSui1JLSi8LGBJYrTkpOr86ItX
	t
X-Google-Smtp-Source: AGHT+IH/wxbjXIJt15mtFX+Eiz1Yjy+pMUL1y8nc6uvs09FwKll1UHN3CCSItqy4iMg/d+VWzpUUhg==
X-Received: by 2002:a17:907:2d8b:b0:abc:7d6:e445 with SMTP id a640c23a62f3a-abc09e58c9cmr1552320566b.54.1740427198813;
        Mon, 24 Feb 2025 11:59:58 -0800 (PST)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d53556sm14794266b.39.2025.02.24.11.59.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 11:59:58 -0800 (PST)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so146970466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 11:59:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQXZT291IKv0JtvSgiRP4mVNMRNwXDsQL0UjTd2Gz33qbkuzpr0nTlEkb7H25QSy18TgdsRjsKIfIa0sE=@vger.kernel.org
X-Received: by 2002:a17:906:c196:b0:abc:a1b:2781 with SMTP id
 a640c23a62f3a-abc0a1b2801mr1400279566b.4.1740427197882; Mon, 24 Feb 2025
 11:59:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224132132.1765115-6-ardb+git@google.com> <Z7y_i-ySL68BfkgQ@gmail.com>
In-Reply-To: <Z7y_i-ySL68BfkgQ@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 24 Feb 2025 11:59:40 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg0=Vh=9z_rUGSJn6p6xH8Z9Wkz0TLPenSt1m-1rHmJyA@mail.gmail.com>
X-Gm-Features: AWEUYZmJozyfchMZDhF3x7FUhBpFUzVG2GDnxWkFH_5a1ybndYOn9eQZJpYeuao
Message-ID: <CAHk-=wg0=Vh=9z_rUGSJn6p6xH8Z9Wkz0TLPenSt1m-1rHmJyA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] x86/build: Get rid of vmlinux postlink step
To: Ingo Molnar <mingo@kernel.org>
Cc: Ard Biesheuvel <ardb+git@google.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kbuild@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Masahiro Yamada <masahiroy@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 24 Feb 2025 at 10:51, Ingo Molnar <mingo@kernel.org> wrote:
>
> But in terms of justification for upstreaming, the reduction in
> complexity alone makes it worth it IMO:
>
>   19 files changed, 52 insertions(+), 87 deletions(-)

Yeah, absolutely. Our fancy make build rules still have too many of
the phony forced targets, but this is a few less of them and makes the
build confirm (more) to the usual rules.

I do wonder if we could just get rid of that
CONFIG_ARCH_VMLINUX_NEEDS_RELOCS entirely and make it just be how all
architectures do it.

Yes, it was apparently "just" riscv/s390/x86/mips that did that
'strip_relocs' hack, but at the same time that whole pass *feels*
entirely generic.

IOW, this all makes me just wonder why other architectures don't do it?

              Linus

