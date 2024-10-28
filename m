Return-Path: <linux-kernel+bounces-385574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EA29B38D2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 19:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A94B1C20DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF611DF753;
	Mon, 28 Oct 2024 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LE/aZVbJ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB97F1DEFF7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 18:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730139109; cv=none; b=GzGkt2oit/DGV0jGuKucJROI46motrCeAdoskpaKcCrHgvGG2e2YffDSKQ945giP6aXAOrYDobU9fkPpr7+hAT1Oe3JBF5cGcmj97lzw2wWu0hBOuaHsCK6PZUhzvtKozHTLLDD78lLeD8FXw/JnuTHeojaT1euKEM05jSBPeIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730139109; c=relaxed/simple;
	bh=fbnLJGdBoUXkG4F1kWM2e7N4J0NhnGUvlbGNvY9va5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUM3DmhRDzGRbCy72KiZT7rCHfZmqNvkWLVPhvN0PEfJ1OyMG9W1xmGx+mLew259GEsAU6VDyYWxUiw5VY/4dth6rrtvr2zjRN1xjiKXBFK2cVZhUGn9NcLmcIrQCuYZ97TBcrxLkHAACQ3HxD2ukYFUD6jMf4F+NAdxEttUpXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=LE/aZVbJ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53a0c160b94so5139533e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730139102; x=1730743902; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S5UI8Ycq46pSTtV4R594ykmuHChRzRyHTc8M42JBCVc=;
        b=LE/aZVbJLwgnrBDYGQrFq9Y5mUmp27ciMJSQ7nq0qs5dQB9CjMDgG/hgvIKSyF6xEA
         HOO259uMWscRrZZeFNtLkOw4MvV369GHT6TnkkNACo43Ao4V6E5u8kuHczywUBErVnfo
         XzlkK7SDzwZU/AB+lonGB0WHLdoYt2/Sb0vDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730139102; x=1730743902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S5UI8Ycq46pSTtV4R594ykmuHChRzRyHTc8M42JBCVc=;
        b=QUf4GtNCeSQOWN7NKsemkmpMA1kTtuh23Qw2AueXHP4y8R5ziXxIYAHZF7LmzV84cc
         fgaUshFJ7pWm8x1msFtjZBWUT48K4gPMIhFMIbQCX8qFZe0oujawVYpt/B1OrtHFFbUy
         8ei71Hl8ZOnP6dn80M/VuycUuKOx3nzKwC5drbcO2XGPUDeYXimczxqegpCRQweiszjY
         ViDCWZLULF0Vxz/hQtNzJ81ZvPCUDM2euBZUgehRGVBLmmLnQJs3RyHERzy0x4omdW6c
         5SM8e1sIOq1Z+314dsfYQ/y0fp8MlU/70eKcwengcXW946Owq0dBS2gtJ2AWCtR/WF9j
         wPoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUix0Q1rRrSlCQ25ctDo6HTY7GjdEZRfdWEoYdrq1dhhBao30mswQlB6R4HbmpAX+gtA3F5sU98ollx9wA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMsVHwu+fvnIsQGEidnyDHndkOr1zOLxXZe/8MyMdU93C1Uy3L
	5kipvqhjkthCz2OQU961lmLB0WGXaoFrMk0CCouNIfEv2+T08QaZYJRz1XjD/QkEThFhAy9cyyP
	p0Q==
X-Google-Smtp-Source: AGHT+IF59dwTrBMDlzxB9b8IFtsK68Zax2HQbt2Z6vuEfVHEmVT8hFHD+S0Mim4nI/UF3+HEyu9Gjw==
X-Received: by 2002:a05:6512:3b1f:b0:52e:987f:cfc6 with SMTP id 2adb3069b0e04-53b34a321bcmr4257804e87.51.1730139102198;
        Mon, 28 Oct 2024 11:11:42 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a547sm1143917e87.32.2024.10.28.11.11.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Oct 2024 11:11:41 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb559b0b00so38117261fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 11:11:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW+gfpyz7O3HNRxQd/F+Y9ovr0GzddhNcRj6qwDJJ53TaoC+4liyb3BT9YyNIoZFsELXA3KjoaRtL/9tlg=@vger.kernel.org
X-Received: by 2002:a2e:802:0:b0:2fb:2bda:3872 with SMTP id
 38308e7fff4ca-2fcbe0ae3a7mr28225301fa.45.1730139100482; Mon, 28 Oct 2024
 11:11:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026144724.GA892311@lichtman.org> <20241026150040.GC892629@lichtman.org>
In-Reply-To: <20241026150040.GC892629@lichtman.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 28 Oct 2024 11:11:26 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X4Wg9fC7eqhV7sAy-QK6+oE49v2nY0+gnaZpDeA=kiAQ@mail.gmail.com>
Message-ID: <CAD=FV=X4Wg9fC7eqhV7sAy-QK6+oE49v2nY0+gnaZpDeA=kiAQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] kdb: Remove fallback interpretation of arbitrary
 numbers as hex
To: Nir Lichtman <nir@lichtman.org>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-trace-kernel@vger.kernel.org, 
	yuran.pereira@hotmail.com, jason.wessel@windriver.com, 
	daniel.thompson@linaro.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Oct 26, 2024 at 8:00=E2=80=AFAM Nir Lichtman <nir@lichtman.org> wro=
te:
>
> Remove logic that enables a fallback of interpreting numbers supplied in =
KDB CLI
> to be interpreted as hex without explicit "0x" prefix as this can be conf=
using
> for the end users.
>
> Suggested-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Nir Lichtman <nir@lichtman.org>
>
> ---
>  kernel/debug/kdb/kdb_main.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

