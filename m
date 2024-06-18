Return-Path: <linux-kernel+bounces-218454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C7190C011
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AEF82811B6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC36C256D;
	Tue, 18 Jun 2024 00:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="nsO6jHQv"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B37A2D
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718669198; cv=none; b=EMy9rH/wcx8IAB3A/EUgrlnZL5UVxM4J3eX2eLhXxAmyv50HgXU9ObKwYK46wRcSBAz85pj0aUN5bvo7n5OR+2g2AwX79hUL09rc71aYLv5MGRH7cKGnlxV7PgSvtjZyN7aVtAgKnbMhlmt6KwGwzVvzNBGM1fhEI5hABR0GnMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718669198; c=relaxed/simple;
	bh=UGatSlxeogA3j0K+wKO32ig6IQDTDriv/UTII2rF8aA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYoHjuG+VYMdYLbhZxgg6kcgTCQidTz2Zoe+18h5SFDl25BXmhWL4TW8ZC4O27yyXmlAP1Vec9QjQymfKyinBbpFxt/MCiCaFhpZUJu4iz8bkOuNGiCx3V7t661reIWbC2AUwC3lSoX9Ech94nJr88b6kgMGiGnlkmFrJRBNsAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=nsO6jHQv; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-57a4d7ba501so6075204a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1718669195; x=1719273995; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhBCdjZfpxKVO+6tjifmXo9LRGWI17cs8I9O4iYikok=;
        b=nsO6jHQv07tGiBwKMISNMG+VMjPGv2/ZXDkEwH1aCHs313Vd2qYOobr82YmQVyL8oP
         c+vFC8fq6Lh0dTNZKd4yFWLrICzWaJUDoEP7PA5dTwEZySocs79D8MvtEa5uPbSIn3bf
         RxGBYw+okkn31YPO1o9MuNUaUTd9tevpcVxWP7sghLc25ptBHROtfBpTQinKSnVfVW/6
         PvHH1cUcsvds6ER/mclPXY9JQb7hmNpvYoAcdaUyy6MLTVYSYp8XBmtKvu5m+/BBvMQG
         Oqu4qF2Wp7hTjh6Ol3U7Niy3DVT2meOzaFEKLoXG0yvh639VXzTd9j6kTqs/4dP0jF6f
         oPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718669195; x=1719273995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhBCdjZfpxKVO+6tjifmXo9LRGWI17cs8I9O4iYikok=;
        b=qIM0mKgwjbZ0KJalJ+9KnkgxXsb3wzS8WNZJ4qiacUgRzGXeKPYf9SsxKJaqtqJwfk
         oLbwl0QTgRVct6gXfFl1uGpklx3zHaxVnW+pZ+NaqvzWERonvezvzQoWL6AF159qvbsf
         e3RMVjGEH+FbCwrqsBMAd+j5lOspJ1D+3FscdZkyj185dKsnyiNlXN6ZtP7iLTZEXO++
         18y4fli5KeNC5GRWs3CHwXAb65AflTozVVlzctdxA22GoA7788TVzpne6NJCYc1Ui9yR
         Un/w78F7AIvwAqeRxpLt9Exw2mzp7sEiXao8/0WGNypJUeZAtBeDaEemdV32/b8sv8Ka
         gVJA==
X-Gm-Message-State: AOJu0YwuYq1iZmIj9zhzuNSEVDKGfH/tunvq+jDa3rXPManoWo08szIC
	CeiuYr8TpTus+DTx8EgT7dK8yaV7v8TlLvOAbkl444qSpp9JQPWCMhKHGOSDAiIqo5V34mt1v5x
	WhRuP5Iez2V+mru+x8ZQVnu3LAXWF475S0hQG
X-Google-Smtp-Source: AGHT+IG4GxHatmoy2CQa4K9NAS5MI8D1mWbcUvj+Npci2j6Mst8MU7YuWAjJuO9TwNpePI1dphaTrN9ug+F4RXaI42Q=
X-Received: by 2002:a50:cc9a:0:b0:57c:61a3:546 with SMTP id
 4fb4d7f45d1cf-57cbd67c8acmr8252492a12.21.1718669194582; Mon, 17 Jun 2024
 17:06:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614190646.2081057-1-Jason@zx2c4.com> <20240614190646.2081057-5-Jason@zx2c4.com>
In-Reply-To: <20240614190646.2081057-5-Jason@zx2c4.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 17 Jun 2024 17:06:22 -0700
Message-ID: <CALCETrVQtQO87U3SEgQyHfkNKsrcS8PjeZrsy2MPAU7gQY70XA@mail.gmail.com>
Subject: Re: [PATCH v17 4/5] random: introduce generic vDSO getrandom() implementation
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, tglx@linutronix.de, 
	linux-crypto@vger.kernel.org, linux-api@vger.kernel.org, x86@kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, "Carlos O'Donell" <carlos@redhat.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>, 
	Christian Brauner <brauner@kernel.org>, David Hildenbrand <dhildenb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 12:08=E2=80=AFPM Jason A. Donenfeld <Jason@zx2c4.co=
m> wrote:
>
> Provide a generic C vDSO getrandom() implementation, which operates on
> an opaque state returned by vgetrandom_alloc() and produces random bytes
> the same way as getrandom(). This has a the API signature:
>
>   ssize_t vgetrandom(void *buffer, size_t len, unsigned int flags, void *=
opaque_state);

Last time around, I mentioned some potential issues with this function
signature, and I didn't see any answer.  My specific objection was to
the fact that the caller passes in a pointer but not a length, and
this potentially makes reasoning about memory safety awkward,
especially if anything like CRIU is involved.

--Andy

