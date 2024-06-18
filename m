Return-Path: <linux-kernel+bounces-218805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7424E90C648
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B18B1F22203
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A576115DBA0;
	Tue, 18 Jun 2024 07:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b="hWXSjWUx"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AF75B1E4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696731; cv=none; b=ItGF7YVtIEjMBn4KZZSJZrPEsO+S881k4XFKbGCf1ssak2FyFS1zP5qXrQbXlkW6MrDi4RIfp9vFMhx8mXHtE1CRXLxuXs6ZBU73YrFJKLoDbvxsTJNRW9neVzqu6ZsNumbex7hWsUA5FYigufjNGWGhSmNo3Hw9+o7XMvrCFyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696731; c=relaxed/simple;
	bh=6y9EBQd9spPSlym6ahMvT//O8fjaB25I4zeYnyNC18E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8safV12OO9DueVsQjgF3a2Y4EGmyCDKAYzEDjRSQAxH8rXbtvkTxhsk6YRABz2i14PS1kWCGNCuumuIU/tMZRE//iLM3u/L9Cn7EedaNC5voyv1hSCH++QjjDI8ODGv9pekMChB3nkX66tkpx/FWMPgj3HUYADIViSxh/c774U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com; spf=pass smtp.mailfrom=timesys.com; dkim=pass (2048-bit key) header.d=timesys-com.20230601.gappssmtp.com header.i=@timesys-com.20230601.gappssmtp.com header.b=hWXSjWUx; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=timesys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=timesys.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6aedd5167d1so25897636d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20230601.gappssmtp.com; s=20230601; t=1718696728; x=1719301528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6y9EBQd9spPSlym6ahMvT//O8fjaB25I4zeYnyNC18E=;
        b=hWXSjWUxp/+QywILHkarQljr0/9b7wjzNcg6UpG5ard/0oACWbBB1y2iFzMJ2Xhu39
         QG50Pqvvb09TbN6Nl/A1dYdNO5NNiRkMhdJx5ZMqj8p9T8dq9RJNW7+RtzK84x6po3Fw
         r2F0jO4LDbxmgV3EVcCWOYLuiICpcvsLHFkDZBNW0EJP4MVYJX0quuZuTngvq9ABVx1D
         dwvtPZGu1uwV9ss/lX7iITypdqcG6DowwkSZiWzjKtRMcIMutRBOcFbgJibBRw4T6sUl
         SkLbloFLJYarBdukj4sOl/uGRPcLBdK8Cm3dm/wxtiYI4+7XoMiCv0VWWYes6Y4pEzOt
         vSzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718696728; x=1719301528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6y9EBQd9spPSlym6ahMvT//O8fjaB25I4zeYnyNC18E=;
        b=eUWT8/OaM7Oq4K6nCpvvwp8e+T36Uj79Qjveo+K6lHBRaV/nRZLv8DXhd8/QCTgrKC
         I0hVPY7zz3hyk9JpiY4Uu03do9SUmWVeGxiKG2gKsziZn7zB2QKfQJ6CnZo7vZKWjP5T
         R2bmFNchgXkImcHDBNfJTxU12qoMc7eOL6pBiElDp5MuiOYAsh6VCdP9FMYbKBamZZQe
         AXYyDymzrVNeTsZ8N1zVUdJfpQO6E/Kpc1XoowpUThvCkAaCxu7TDjYQvwHhr2TRKacz
         aMTd+0oggfpQDR6qcjFuB4HDlCwlffoadUFlfGTS1FlejM1m4k16n95AgRcxp5P3bCNF
         /GVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPquWZx5KLkTK3oNRcICKMwXtbzRu+oVV6JQYwkGT4fEcdObs8fqE3aa71+1UYSlMfRjhcJDrr7ehWK0ffs92MZsinZW4YsMh9BNqd
X-Gm-Message-State: AOJu0YzG4gvXPAG+xgUtcDUhYNwkiuq5UeesdoQTwkCESoI0vyG0wlZW
	YKQh5tjK96H3EswRQrb8L4fgyM2eZ7Qni6zGHW/s+D89cqaUUC8ExCr2NzsLwl8gsTX9S/2VfP9
	7Ha7ogbQ3Fh+ZiziSiWK4sseO9njQg35NZ2uNdQ==
X-Google-Smtp-Source: AGHT+IH7+3WcSHlqSCn8E776/vDX4KlNni6h709sa81SFyuFMo7TNQZN/dD9TK/cBC9XEnkBmumnQonT9vtIqu2MJcM=
X-Received: by 2002:a0c:c58d:0:b0:6b1:e371:99cb with SMTP id
 6a1803df08f44-6b2afd7792dmr117082556d6.3.1718696728034; Tue, 18 Jun 2024
 00:45:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614163500.386747-5-piotr.wojtaszczyk@timesys.com> <3fb7f6db-6822-413e-9aa3-953a5e3cd566@web.de>
In-Reply-To: <3fb7f6db-6822-413e-9aa3-953a5e3cd566@web.de>
From: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
Date: Tue, 18 Jun 2024 09:45:16 +0200
Message-ID: <CAG+cZ05LW5WZJqzs1yXZ3zV972iA-mE2HBtdGZPf+B0bAyWO_A@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] ASoC: fsl: Add i2s and pcm drivers for LPC32xx CPUs
To: Markus Elfring <Markus.Elfring@web.de>
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Chancel Liu <chancel.liu@nxp.com>, Conor Dooley <conor+dt@kernel.org>, 
	Jaroslav Kysela <perex@perex.cz>, Jonathan Downing <jonathan.downing@nautel.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Rob Herring <robh@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Takashi Iwai <tiwai@suse.com>, 
	Vladimir Zapolskiy <vz@mleia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 9:30=E2=80=AFPM Markus Elfring <Markus.Elfring@web.=
de> wrote:
> Would you become interested to apply a statement like =E2=80=9Cguard(mute=
x)(&i2s_info_p->lock);=E2=80=9D?
> https://elixir.bootlin.com/linux/v6.10-rc4/source/include/linux/mutex.h#L=
196

I take it. Thanks.


--=20
Piotr Wojtaszczyk
Timesys

