Return-Path: <linux-kernel+bounces-206605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ADA4900BF5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 20:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 615911C21BC4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 18:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0816413E41D;
	Fri,  7 Jun 2024 18:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="lIFmfqmE"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27D413DB9B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717785650; cv=none; b=IP7XS96YIElSVAtjq2LaToGW+gLkrTdu2WJS03Iw1hCQ9grwEOC42KQY2TAkDqkBjJlWCk93lSbhKN0XQTkF/KSMy0uUA9OYhiTIbclJEkrq5Q0l7HcAdtbYllBrq+jrkei5itCFOLumATDKp9cc7njJ4u1CqgsdUC+bp5096gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717785650; c=relaxed/simple;
	bh=nLT1CS3bAADtDvYR/iyCMdc1XfAIDAMUu13CcxexJ8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I5FduQwtYBOc7VzMMA9J1scM+lyL6A179AgVtV7Ofm3JMGL0CmYREpdwXLoNZY/loyN4WF8F0OxnnNtFy2TIXCm6QucbbWyWEbDeL9zDiqJQ9vxb+H53R24ax0ySCvVlTTbF7VIrB4B8D5APmdBAB7Fx6EFlYRiC+FOHgHnmDM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=lIFmfqmE; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c9d70d93dbso1432855b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 11:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1717785648; x=1718390448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWP3oVZEyR0+a+YIhKNFwQ+oDZLDTYUDKfQwa7N72nY=;
        b=lIFmfqmEbNvXbeyH1jERzARJtTWuAvqn8uqb5SK7/PMlu5+bWUAmknsp5f1oG/eEGU
         2k7Ykj0gM3WIHu6hZtiEjhFZgBOsLLMSq1rTjGP6vgEZnxK8gzr+ytbTtnkf9q39Cgx+
         1r1FqudUiDptvrkVDye7NpeMW6irl7xOtOzfmLOnK7kgpnAX5oxaskeoorRvA9HhEmVt
         +4WImlEm4LQseVwMZRcD25us6e6AANqC9NMTMMFBNaDP8T7TFdSwd8FHX8XVEwWt4I4J
         ymmTTYL1XE/qlUM0+qdP4PHPYRWPZIPQt+DHQyZij8D0hJox5HXez+0G/7QSJC5tkxFJ
         u4nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717785648; x=1718390448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VWP3oVZEyR0+a+YIhKNFwQ+oDZLDTYUDKfQwa7N72nY=;
        b=fAZu4Ldchzh/z6XCc99vhPswnW4lDFE6QKKkzQci4WWZYXXsgF8ZMfCEoIC7h/Y+hh
         Kg2KVsUrB09tcTi86bbB0Wx3Vf6LG/W1ysJN5KxU0tGLvfvwH1sdUWcpKSPFVCP+6xJw
         l6Nq38pCpJFd02urOAMrhF6ZLCpRUtqcmu2vF5VOzpcBbPd6rL7ZRc0+IbayThbEFI0y
         PN3rNfazlAvD/JP9kcnau7G96bieIU51M9faP6xaC7N/fhSAIjPVOVRC4pWJ7tMBkGsS
         3MQ5Xg/Ct7hpfRB26Pk2zgya/iNO37afmPO3F5ASMeN35KNJKD/cL77Hyiop0gLFZWmn
         xZdg==
X-Gm-Message-State: AOJu0YzfO74SvvmJT18UnGQvDVXud16uV/ibd+gbmVpXImTrUm6BXNSh
	Zb3gHW/zOlp3J/Vw8nEro3+wOsTSjgald/7zVQ+D+q6BlwXfbKvX1mXwfk/f40E5WLUxh0p9ZmX
	lkgXy4BAlS/sIzNOXtmuUIbu1bYg55medLJsH
X-Google-Smtp-Source: AGHT+IGM13uj3U+ARgcKJSVs/VmcSppJ4o+ZTjupN8yH80mNMzyyWgUWj/akZRB539Rs2Rn6cvM6cRncobvhndjrU8I=
X-Received: by 2002:a05:6871:e015:b0:250:7353:c8f2 with SMTP id
 586e51a60fabf-254647efd11mr3404898fac.43.1717785646594; Fri, 07 Jun 2024
 11:40:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528122352.2485958-1-Jason@zx2c4.com> <20240528122352.2485958-2-Jason@zx2c4.com>
In-Reply-To: <20240528122352.2485958-2-Jason@zx2c4.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 7 Jun 2024 11:40:33 -0700
Message-ID: <CALCETrVJFefyDT6U3QoHdZvNh=3nqk=3AK88eRuqdn4W4t8vsA@mail.gmail.com>
Subject: Re: [PATCH v16 1/5] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, tglx@linutronix.de, 
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 28, 2024 at 5:24=E2=80=AFAM Jason A. Donenfeld <Jason@zx2c4.com=
> wrote:
>
> The vDSO getrandom() implementation works with a buffer allocated with a
> new system call that has certain requirements:
>
> - It shouldn't be written to core dumps.
>   * Easy: VM_DONTDUMP.

I'll bite: why shouldn't it be written to core dumps?

The implementation is supposed to be forward-secret: an attacker who
gets the state can't predict prior outputs.  And a core-dumped process
is dead: there won't be future outputs.

