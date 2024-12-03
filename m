Return-Path: <linux-kernel+bounces-428932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E0D9E15DA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 09:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14C6AB2F7D4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFAB81E1310;
	Tue,  3 Dec 2024 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Rc9ZZzUW"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95961E0DD5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 08:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733212973; cv=none; b=nZCuE00TcHX9bPtzy4wj9L+ZF9R9SkcdVPo3BHbgLNiy4LdPrMKRyevzhUWIA/o+Dr6cYY5mTdJypg2T4VFvr4U6Ym3os8pW328MqN5+qbhnibPF0aArN0uRG1LE9o8Z3PFmQdh4mMLVvO3F9ZXItrbNLa347mi8DOflY2TPc+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733212973; c=relaxed/simple;
	bh=dbSDhnfCbi91PqZ/l2aVBfTCHQxqBIx1tgoLjMHoC5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e+ozFpm012WV52jshAlEF7mXn73JP8ciWDfQ2+w0dP0m08kMPAfF3IZKTpzB3JQEaQG7pUWCppdEQzWhuTs9HPUOCBD0UkyiBgk+M/1RgY0QJcO4VivnV3q72H262z3QSZaGyrZXlNWLuAb4Jbne5k4utH5lb7hb38tQfFqfUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Rc9ZZzUW; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5cfa1ec3b94so5976902a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 00:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1733212968; x=1733817768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dbSDhnfCbi91PqZ/l2aVBfTCHQxqBIx1tgoLjMHoC5g=;
        b=Rc9ZZzUWPDNHS8I4l81+1mqhNvFxiuJzCov737dfJsKMgKkOlwjzchNmLbhYuyE6e5
         mRCV5pHUD9e5jXDwEDSL46Pva+NvdXuQwyHfUGj5S9QJ7fdR6F89JunqnltZ9rFZAY/Y
         HL90klegzZo15QHtKtOd6Y/wTuaSRE2vhGkxY/7AdAcRv5zbRWNgpS6GJ5oT377hcASQ
         kQtKGwiM5jssVA50/QacOTUTUU/62JrVHGXl8nc76FuVADIUIEKbdfVhQChfXHyuq/KL
         LaYsngYN8f2Zt241awvUM1cYwoAZtoexXqDOsyd82yoGL3f7WmahF8yNQ+16vG2OXIOj
         X9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733212968; x=1733817768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbSDhnfCbi91PqZ/l2aVBfTCHQxqBIx1tgoLjMHoC5g=;
        b=i5pUtTT+2Wnc3yRQ1Alkfj0mUejkqwSZ+CoR4J+O/5Xi2F6JMUrAxjlfTCGX5g26y7
         NXNtksXKd5UV0Xnp06PxCTnSfZJHDV2hfFNtNTT6GER74/4uuqlEkLE92sJcaVeYUyr/
         K1VXTN0XODnf5SpubKfb9UpewPdsf/ddRKmKEx9k/vsBgWFsWnlsNk7128RjO6r5UB9t
         uuAOLyFp1fdAIkQZ9Vj801Ns1wdWJu4YvBy7gp364qZSCwzbzAUQvr9WtfNz9lS68Tle
         apjEo98mJJhexjhfFT7+NEorbWrkEl/q3xTrJHcNT2UswfUJUfk4n8xsUDAfajHTDelp
         M8VQ==
X-Forwarded-Encrypted: i=1; AJvYcCWauYthWUIbIiLpEzX3kniJbdyvplHFIAZZW4uspC5zxL7U2sMS0/lnyQunHjLFs3l+UQfrlHlAwBo30mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YynlA38MHlWuzqUI5igogxJuo98r5S7ZTtocAmE9UD5LAaxdpb5
	3CS1Ti4uFJ/Anp1nkC3CINQZJKv68s0M3LRiA1vBb9Wl2Ymj1wq1bWWd4am3l0q8OuBr/Y7epbv
	5VjyLUrK7HSpUGAkRJwrwvIFvfmoxz58JOhZNoQ==
X-Gm-Gg: ASbGncuaDhVx6Lu9NxObP66h8iKVg3HLriwMqvxFunPlcHLSByFw7BGTmJopI/lPA0g
	1wdonD4vRX8xQuBO+89eJPCgIUV6wVcUnPhsmiBJiv2qYn4GnQy9r06jcHPlo
X-Google-Smtp-Source: AGHT+IEigGtRgH6c0bO24eOAW8I4NETl5V69OdQiH9GHJHx77IaItBkztB2ZG7by98VApqUzEQYHOlibvmUD+tM8VDU=
X-Received: by 2002:a17:906:2182:b0:aa5:3b94:78e9 with SMTP id
 a640c23a62f3a-aa5f7de5872mr98972866b.33.1733212968141; Tue, 03 Dec 2024
 00:02:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241127085236.3538334-1-hsiangkao@linux.alibaba.com>
 <CAB=BE-RVudjkHsuff5Tmg2sumjDkPKpQ9Y0XN2gZzPFxUGa+hg@mail.gmail.com> <b68945e3-3498-4068-b119-93f9e5aaf3ad@linux.alibaba.com>
In-Reply-To: <b68945e3-3498-4068-b119-93f9e5aaf3ad@linux.alibaba.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 3 Dec 2024 09:02:37 +0100
Message-ID: <CAKPOu+9iDdP9zVnu10dy3mR48Z1D0U1xyCuZa3A6cYEFKD-rUw@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix PSI memstall accounting
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Sandeep Dhavale <dhavale@google.com>, linux-erofs@lists.ozlabs.org, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 2:42=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
> I think at least this patch resolves a recent regression,
> I guess we'd better to address it first.

Certainly your patch is an improvement, but maybe this just wasn't the
bug I was experiencing.

> As for your reports, I think we might need more information
> about this, since I don't find more clues from the EROFS
> codebase itself.

What kind of information do you need? I posted some high-level
information about my setup here:
https://lore.kernel.org/lkml/CAKPOu+-_X9cc723v_f_BW4CwfHJe_mi=3D+cbUBP2tZO-=
kEcyoMA@mail.gmail.com/
What else do you want to know?
This triggers pretty often now - can we improve Suren's patch to
record and dump more information when this happens?

Right now, we don't even know if this is an erofs problem (and if this
ever was). It is just one of several candidates.

Max

