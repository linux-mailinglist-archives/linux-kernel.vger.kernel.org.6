Return-Path: <linux-kernel+bounces-541262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B55CA4BAAC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 10:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C3E16FBAC
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 09:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6611F0E38;
	Mon,  3 Mar 2025 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b="dHwPO15f"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BDF1487F4
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 09:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740993629; cv=none; b=digRH78QFNQw8OqKHC/1J0qfZSLXkMEp3VDnu0Ih7cih55siCwXr30gp7tbClvIPhMCSCUOTPq/rmuuHhz5CHhAvU8tebw4cJTDcXUR90UifA9ElUG1QaxP1mIk5hhqXhxviPJ9ol3D1LLrB3PODNf7mSfC/b74j2raF/cFY6Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740993629; c=relaxed/simple;
	bh=0mkbi+pWV9lNgC4jdlK5EkBndlyRwDkcJnjagi0x4kM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=S8PgpMNJRObHFHTiU0pYH/8qdxIZDqmaO7sQqdJwAEiWqLYHTN75IzJ395ziTBHAcUxrbHnHzEzI3tO5osUijRmgZ0Z0/QVbGkpkbC80Mrapilnf53/2Drefxr0k0X2LCiBvF/ZfXeDXHO0HFb6OtonYeAikrekkPNC7rJpzzVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu; spf=none smtp.mailfrom=kragniz.eu; dkim=pass (1024-bit key) header.d=kragniz.eu header.i=@kragniz.eu header.b=dHwPO15f; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kragniz.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kragniz.eu
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-390ec7c2d40so2612342f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 01:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kragniz.eu; s=google; t=1740993626; x=1741598426; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tn9NiVtrc/j1OIcqH+L0OnKwaHLUjUZ0cVMF/aqFASo=;
        b=dHwPO15fgz5KFpaGbGvG+Hg0woLiNPtusZ0Ta6EYfBoKtgVJlLeHWLrSINcDIGvJjm
         DrXgUWAQReGlfpr6lPMtgXrLv9gCK52rLpJcWaNd55Ti+n86ho3xREcSttbZL1M2IyLT
         2WW7DBLJ8Eo4zHLila3Uo7ZFtSyvxG61FYd3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740993626; x=1741598426;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Tn9NiVtrc/j1OIcqH+L0OnKwaHLUjUZ0cVMF/aqFASo=;
        b=Zqgrb1wM567vSWsbzLtRzuAKtnhkrGu/RI7ETAqt9otQj5SL4dpOuCzA8odRI/veuX
         bATA0WiyZAttn5OsBWdOz2DGEc4n09uHPsdsVN3sWTtyUfi6Fxa36aZrFWXQRiUu6yDC
         VRtfcFYNPf56SA9Q+Qh6QJY6cOrjMhwTjIP7PojJvLQsyEcl1jxJCs0eejI82Gv18/G/
         AdBkqTAz3WWhfEUtDSWkxMn7oeGEavYjqfu4W6vlyn/UexFip5UtrlJLEvwhM20oQa5k
         aqK0QhrRI0MsbGfJSpNEDTOrpoPov0csiYjDQ7Elgnux2z8bi6R9B5+4SiCD1EZACV7I
         8+zA==
X-Forwarded-Encrypted: i=1; AJvYcCXfn5g5TuNUZX8kU+uzPUBkdIN9ZDdd9l90zPMERMIlhEkp4dpjPNRFbRpcGn98e/jvlVcLzRAFhdhE834=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVuvrEUKFJegRFlcWVdbhAEYAaREh0/1HLYY2DWO8ING9bxbPD
	gB8hKacurKzgc6awEIdtsFuCNt1W/t5TBoXorelS82m2W588ppqkTcXvjhrJl5k=
X-Gm-Gg: ASbGncuuGhUuBLJgJmvNrh8PxklHZm5udjSZl/B8GBUXw3/ZaAYwvzXfPSkteCOAv5Q
	ZyyA3TuhlzIgh3JBxdtroWkS8TORm2r8BjMJLFAnFSm9tQExXY2PE7gIRt2OVMHxXBudufhphsg
	/OUjL3uGGqPmW34k2gE1QAWMekJ5F9/r3ZcY0FUpX4McB1s7IpWfkIy78LEk+DOB9ucpW6bdvc7
	ojgFNK+mgmcfp5J2wpRO6EICA5JiwJ+saJQjQpmWcm9P45fvOSc/b+nqkaBlpnq2Sjb/DDqz1qP
	/ByxeMYGAQeRoLDShLN8xqigGmKxsKHm3CvnoGxOyZlYl/NDgD9ITbubD5ZQ0ckUIQ==
X-Google-Smtp-Source: AGHT+IHpvVAe1hiW/Kg+NZizFxiZQdKOkluPFpQNOe4kEmLp/oqdczH77+lMwgOhbtWKNPNlqPrwWg==
X-Received: by 2002:a05:6000:20c7:b0:390:fe05:da85 with SMTP id ffacd0b85a97d-390fe05dc1bmr3970057f8f.16.1740993625669;
        Mon, 03 Mar 2025 01:20:25 -0800 (PST)
Received: from localhost (161.26.169.217.in-addr.arpa. [217.169.26.161])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba52b947sm181416395e9.2.2025.03.03.01.20.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 01:20:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Mar 2025 09:20:24 +0000
Message-Id: <D86IQDQZRN67.95DLK0YYQE1A@kragniz.eu>
Cc: "Willy Tarreau" <w@1wt.eu>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH] tools/nolibc: add support for openat(2)
From: "Louis Taylor" <louis@kragniz.eu>
To: "Louis Taylor" <louis@kragniz.eu>, =?utf-8?q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
X-Mailer: aerc 0.18.1
References: <20250302202528.4169024-1-louis@kragniz.eu>
 <d0ed3b0d-4b7d-40cb-bbce-1f2a6605db7f@t-8ch.de>
 <D86I2TBQIPLZ.TCUUJWWM5DMO@kragniz.eu>
In-Reply-To: <D86I2TBQIPLZ.TCUUJWWM5DMO@kragniz.eu>

On Mon Mar 3, 2025 at 8:49 AM GMT, Louis Taylor wrote:
> > > +}
> > > +
> > > +static __attribute__((unused))
> > > +int openat(int dirfd, const char *path, int flags, ...)
> > > +{
> > > +	mode_t mode =3D 0;
> > > +
> > > +	if (flags & O_CREAT) {
> > > +		va_list args;
> > > +
> > > +		va_start(args, flags);
> > > +		mode =3D va_arg(args, int);
> >
> > mode_t instead of int?
>
> This implementation is yoinked directly from open() below. I have no
> opinions, but if it should be changed it should be changed in both
> functions.

Actually, maybe this openat function could just entirely drop the
varargs since compatibility is less of an issue, effectively going back
to the interface before a7604ba149e7 (tools/nolibc/sys: make open() take
a vararg on the 3rd argument, 2022-02-07) rather than copying the
current state.

