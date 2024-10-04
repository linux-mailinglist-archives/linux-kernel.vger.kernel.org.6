Return-Path: <linux-kernel+bounces-349880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 833BA98FC99
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 05:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E7A51F2358F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 03:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739522E646;
	Fri,  4 Oct 2024 03:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="muhJ49DD"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31027175AD
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 03:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728014286; cv=none; b=kNnYq1t6q3dQO3xBrB/vXrJILGOo4Ki54dEUIoHRfZgkTTcdtGN70wkGL9dgzcGHwSwoH+1Yiwogkchya56mtoaacnzUH6b9ebEKUV0LHR5QJrakI8xNJ72+qX3dnYRjyhFgO6gdguIYPScPybkZyLyy9mJT/eZIel0voRxeVXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728014286; c=relaxed/simple;
	bh=kjYW+QziEcVJXhaCqljSKWk/0TU8L4We7FSabEho0l8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqrVP/Swh7QXRRVNig+EnlPUSM1w3H2gouOfW1TmVv5D56Wx5Lcdcvu/oRHPeIecXlQMYqKCw4kVBjNGy1+tyxeGM6tDJyx0cRVfjrVlW3K790WaOsVeKoAda6WSm8jY2I1tcpoUtDzShBq0U55FaLY2rKcBYgTWxmLmz2B3FHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=muhJ49DD; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5398e53ca28so1915723e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 20:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728014283; x=1728619083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjYW+QziEcVJXhaCqljSKWk/0TU8L4We7FSabEho0l8=;
        b=muhJ49DDdDv70KFp+KUb7EQGohzret80q3sPOsidq508tJGnblLU8S7/GQ5NbBnKyl
         5ogCjedh0afteJm1S5fHanT2vem3iVTht+kAac0o4+CSlTrevaF4Njf4l9yZL7WFtZ+I
         Iz7Oldrytx8OqpccbVXGxoF+6GNgNQFh9vcVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728014283; x=1728619083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kjYW+QziEcVJXhaCqljSKWk/0TU8L4We7FSabEho0l8=;
        b=kW6RzeVvWwPZik6IZsHYJvPMbHd7/p+ihHSCe+BkMtTGaOghGWTA75Ch9UDWBIFdj4
         C8zFAG6WKGmVv8IQrxgqLZnRHjL7+UAd++CA+W/IOXBaWy8o6BR820dxQd24DUUvU2NT
         tetBOwg1AIKoVpqq1ar9ezfxE9ObCWncPqRFsvw4LNw5JlJPAu5TS7PWara4taPp6Y8D
         omh0Byi6mUutt3HoczD1xJU7OboXktnA4k+JqDoGb1ok3f1OlWTLswL2yoXnrCo8gyzL
         s7q18WMtkOyz/whrKp0HNyVdYg+U77IZL6ObIfwJF8l/iddCodf/GUi6jCOmAKhI7XDd
         RJ1w==
X-Forwarded-Encrypted: i=1; AJvYcCU7cznBll98S9ZS5s1simNn6BBaOB+cFByU+WIF3ihBnYq4JgF4gqvUsX1BdJ1Rdhmy2DPKW2ciiyAi8rY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8D4xYg2e0bU2MVDVYACsCNPX9D3PkHKO7O7/rWCVYR/mlZi+/
	xjC0UIPYBs8ZrPAH/3jcy4wul131/27MYDqchKUH2/+3u49WyC/M+Kpo5JMICsEVZKbQut1wXu+
	8P5rRfGkex5BME6nbTFYXoCQ2UhfTgxRdPFjT
X-Google-Smtp-Source: AGHT+IGCSauXsJLec2oJrPfkYs9NEcva9UvjTHFkP+w1oM/AcTWaw9QXjbewWHBIo/wx6d90jb2ssOchDoJfghPpNZY=
X-Received: by 2002:a05:6512:282b:b0:539:8b1d:80b2 with SMTP id
 2adb3069b0e04-539ab88c3e8mr685562e87.33.1728014283144; Thu, 03 Oct 2024
 20:58:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001093815.2481899-1-wenst@chromium.org> <ZvvHdlD6E5bzsWwV@google.com>
 <ZvvX5KcKaVBLedD1@finisterre.sirena.org.uk> <ZvvyEux8f2ylRQOn@google.com>
 <7db1299f-f925-4689-806f-f1ea4191fd4c@sirena.org.uk> <Zvv1FuXBZpjDefb8@google.com>
 <6626b1f3-7c3a-4531-b006-9e29155025f0@sirena.org.uk>
In-Reply-To: <6626b1f3-7c3a-4531-b006-9e29155025f0@sirena.org.uk>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 4 Oct 2024 11:57:51 +0800
Message-ID: <CAGXv+5HYv3v3MMknjPvOf_hKEHM_UEmz7R3ATmpindebcK_FKQ@mail.gmail.com>
Subject: Re: [PATCH] Input: elan_i2c - Wait for initialization after enabling
 regulator supply
To: Mark Brown <broonie@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 9:13=E2=80=AFPM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Tue, Oct 01, 2024 at 06:11:50AM -0700, Dmitry Torokhov wrote:
> > On Tue, Oct 01, 2024 at 02:06:19PM +0100, Mark Brown wrote:
>
> > > Yeah, but that's got to get washed through the individual system
> > > firmwares to get deployed and my confidence in vendors is not high.
>
> > I think native Elan is only used in Chromebooks where firmware is
> > decent, the rest are I2C-HID.
>
> Ah, OK - in that case I agree there should be no problems with ACPI.

FWIW all the users on ARM (at least in kernel) are also Chromebooks,
and all their supplies are either missing or marked as always on.

So I suppose to avoid affecting the power sequencing time, we should delay
this until there is proper support to handle wait times with the regulator
API.

I might find time to work on that but I make no promises at the moment.


ChenYu

