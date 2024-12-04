Return-Path: <linux-kernel+bounces-430422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B56C9E30C1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 02:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A41D4B25327
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 01:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECF6BE4A;
	Wed,  4 Dec 2024 01:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNqz7lh3"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201B54C8F;
	Wed,  4 Dec 2024 01:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733275655; cv=none; b=GAbli/c6/4VZ+IbOc+mFb88ZunQhFlEAmkTTUaEMdWPGTGj+paVQUVAR+9kbohURy2OHgrhnQXNefwv/Vyns9FSyUtEeU6jhVXo5l0TmDprrgEuoFuXIoR+T2mIr7+dFIPt3hR8hdYaUAtC7Lpeovw6YlPC5ZpZGQiOYZQxNvQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733275655; c=relaxed/simple;
	bh=pgZt2M+Pwhjrmzxt+QO2q5ObG9qhyr231Wbd5HX4CQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJQhXKslUGcrsQaUjkDeu2fhxvzGC7qgrNcxJ2q1BxRfgUxNN/IklZxPPhlBDfomr+7UANKZtb4DbqC8Vjdu0Tzr1BYypR49PLz+eVpsVYI3wQimz2C/hn7yaL9QR4myxyBU3sGqltfBDsWclgykx+9V1wrR2NGuiI77lTPwRLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNqz7lh3; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e9f8dec3daso49662687b3.0;
        Tue, 03 Dec 2024 17:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733275653; x=1733880453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50u1RJmER8i7s9/SprHkL8TRwZkGr9nPZOt7IMSKd/Q=;
        b=lNqz7lh3X4MXNngl+F0glsiODhBZPI6b4eDibbaE7mIPlQa3sn9EyL/PLpWnKXA/aC
         klRMvTwQQS4H9pozCRdCbveLhHz0tqWuoIjGONzySKaxV6qMMdkiM6Y9j1DkeRb+eCiP
         Q+nf0WnMs1o+BXzR+dxZ4rfp9X/1Y5VfcScC7MUEfkKzCBjItJocq2mxHfBjGAN731PT
         4ylP6QfRW9GSWKw9GlFyJaJc31QOR7VxLq16UDRF2OFKiEMStXBdNfjgWcsUfsN7kfKR
         wmfEBpq4AcYd3xeEqLnER7hxjAfFuySJBZXggumvPd8K70MJ8kbKdnp6pqbq7cx14ewn
         dhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733275653; x=1733880453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50u1RJmER8i7s9/SprHkL8TRwZkGr9nPZOt7IMSKd/Q=;
        b=YFW+NOFL/ovk6WdjvcQtKxZR0J1I8z/nrGVn8f7dFQ8/HjbLMpDK5xtcEb7Tiw7IT0
         Ud/RBsLus36njIHsmUC85MHz7HUNm+Zfd4tCmw7XaIW1rfIsM9Y7xOIRM2XJWbW51RC5
         OwWKvP2DUFd+rDTkrPgbGsOJZduSHnCHosxzcsCiwKda5DbXZqpBwfjVIpvMgdrRtbBi
         VEXj06Ya/JTVCbaF7q8270h55jevRMo/T77Vx8/36SFYboe4tydnC07kGQYjLhf2LNkU
         rgBSEu0f+AeO8eNm6Y96VFTOgS/fNU3UBtvSjqsUrc5CJbNr7AD3wUWXDnE65XAQ8XBY
         ssfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeI8/0R+8VxXCqsUbpptBmvOTScFoSIRs7vcfzr/Dsck1vW0cfDYd9pGncQICzHBfwZ0SeIo7UL3B1hPHX@vger.kernel.org, AJvYcCX/0Jb8AeoHIoSL9htZrUwPISKeDyosdSUekb39I5ExFlk51n65itwtNpuzaJ524YQxfvfS1hWbPRNg@vger.kernel.org
X-Gm-Message-State: AOJu0YyRVf5HkKLIUnX7/prwbnPF0H7ikqKPzqB9pBicjH9ygN8maDcD
	dFLKZoXCSvtEPtwQlZAuUlhwY3Fl+NVU2XY1cRzgGiSwiUgTjwkx/ACiJaNPYxwT7LEnT7WBEut
	tRVeIrhdFuVn96wIhgH4uj87BZx0=
X-Gm-Gg: ASbGncuvsgeOFIJfe7Fvmxjr+i1JxEkQD2FnSIY9o9eeyqLBpxEGdtNHXzCAkbTrP4u
	kXo4Ndulh1RdxFaJim2psAUT7JRA6yfCvYSM0cXSNSSLF
X-Google-Smtp-Source: AGHT+IGrd/NkggySgngjjRAWLRFHYhjYZYjpO5V3Ph17rxzb/RIMEJRHh6MZW7V/BkdjtwKB1NIeF84yZ7lgyc0QtuA=
X-Received: by 2002:a05:690c:d89:b0:6ef:8c41:def8 with SMTP id
 00721157ae682-6efad311464mr68861377b3.38.1733275653265; Tue, 03 Dec 2024
 17:27:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203233717.185016-1-rosenp@gmail.com> <560369d3-e37c-4c44-86df-a0b81c899f9a@lunn.ch>
In-Reply-To: <560369d3-e37c-4c44-86df-a0b81c899f9a@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 3 Dec 2024 17:27:22 -0800
Message-ID: <CAKxU2N8gVqUKmD0hj_rXwJEOL8KStNHm+O23Sww-yVT5cp2yWQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: armada-3720-gl-mv1000: use nvmem-layout
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-arm-kernel@lists.infradead.org, 
	Gregory Clement <gregory.clement@bootlin.com>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 3:44=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Dec 03, 2024 at 03:37:17PM -0800, Rosen Penev wrote:
> > nvmem-layout is a more flexible replacement for nvmem-cells.
>
> Do you have this reference board? How did you test this patch?
Only compile time tested.

2cc3b37f5b6df8189d55d0e812d9658ce256dfec marks nvmem-cells as legacy
and most dts files have already been converted.

This is not a crazy API change that would break anything.

>
>         Andrew

