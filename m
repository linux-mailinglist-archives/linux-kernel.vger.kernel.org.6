Return-Path: <linux-kernel+bounces-364398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCA499D422
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 18:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC4AF1F249A0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 16:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA5F1AC44D;
	Mon, 14 Oct 2024 16:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="GoFMk+xu"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BDB1AB6D4;
	Mon, 14 Oct 2024 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921620; cv=none; b=ksBTv2PVfmhsZ7uIYU2Vwj/5QrcKJzsSWIgZektEDt5E9kjM2jIFGABpcc9GnzyHFJnLDWMr0YMeCTFIOUOCIxthraZZsc3Of6HG3lxfTGXiR+VW/enPHSa+RkI9yN34iGndXsLdTb8cslDwaKI6OxmR+ICtcNvTbIyEiRmIYAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921620; c=relaxed/simple;
	bh=MQngB/MHvhbg0nsUXsyM9DrlC7bVUHUNJUjTSrt2vpY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D8g4trH14jB1N/+rgNZjgy7rrNMNRLZFyVJ+4ZhI13Ix5kFF9b/RWsDW8l6XAc/FYqvY8BbU4ecsJnFRXiqahZIYvun70dZ6OlNR11FhV3mb7oU61zWGuZNlsfUsMYN6bQ8BS1Lo0ntYf3ASpiNfCn9u9sJYgrzQWeShzQLncR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=GoFMk+xu; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 247D542C17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728921618; bh=m5aTWgTB3rbjMaUkF+EfzTnK1jLAn31pH/uHfaSiOx4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=GoFMk+xuN+H4a0L6BOFALEiQWTC7TukcJfXdnB6wTF0xjCwFHeNtDzBj274a8PKpa
	 QmF2F9qBmrQ9m3JyB+GwrRSRXCcPjRtXy/Rlkz1MY7041YIWYlEViY8eyrP8jgHNNw
	 zXp3K0WDzpEYFJySujwLXJA9pL+ZOaig9RRbjCqDVv15ZUz74D5maTw7ZhMm0enX9t
	 maU3uJFM542S1gkQOcAzu+39JWeGOVk5ruxuYAkJ7FH9k/vid3kQaTmVtWJmIOfxpY
	 BQvKbdlohqNRPIIGelMP3fxV3dBt0L7t2Pt7iu70JKkX5Ui843qjQPgpbrxLsjSzDj
	 m0V+1sVFPE3qg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 247D542C17;
	Mon, 14 Oct 2024 16:00:18 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: =?utf-8?Q?Andr=C3=A9?= Almeida <andrealmeid@igalia.com>, Randy Dunlap
 <rdunlap@infradead.org>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-dev@igalia.com, =?utf-8?Q?Andr=C3=A9?= Almeida
 <andrealmeid@igalia.com>
Subject: Re: [PATCH] scripts/kernel-doc: Fix build time warnings
In-Reply-To: <20241010225933.166436-1-andrealmeid@igalia.com>
References: <20241010225933.166436-1-andrealmeid@igalia.com>
Date: Mon, 14 Oct 2024 10:00:17 -0600
Message-ID: <874j5eu12m.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andr=C3=A9 Almeida <andrealmeid@igalia.com> writes:

> As stated at Documentation/kbuild/llvm.rst, to make usage of ccache one
> must set KBUILD_BUILD_TIMESTAMP=3D''. Setting this together with W=3D1
> will trigger the following warning for every compiled file:
>
>   date: invalid date =E2=80=98+%s=E2=80=99
>
> This comes from kernel-doc script, that produces the following command
> when KBUILD_BUILD_TIMESTAMP is empty:
>
>   date -d"" +%s
>
> That triggers the warning above. Add a space between the flag `-d` and
> the string argument to fix date command and remove the warning.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  scripts/kernel-doc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

jon

