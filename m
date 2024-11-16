Return-Path: <linux-kernel+bounces-411641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D119CFD36
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 09:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF06FB231B8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 08:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA471925BA;
	Sat, 16 Nov 2024 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b="q/wQrKHM"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2531218C004
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 08:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731744960; cv=none; b=eh3h9zjMoDzMGqJUiH4TsEqLUegf71ppxFMq81jECeVBBUnswUYnYTCY2c42QY12tAgoeAvZ+6Y2v+cQ78v7YeEwOePSE2lqMtlzdolKe4c+P/7jJzMuMQhL62ruWxj8nvh0hOPkcP4OgGUDDGyS1sDreXpAtG11KoSCPZ3UMZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731744960; c=relaxed/simple;
	bh=BZHDdgynYllHo9s/RBohlkX3EpDgKEvWgSe+O8M5w2s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=SvXAz8StBIz/KPEW9ccJVM4di49bxFwduY+7BWEcRUT96i6gxR7cxE5FVyxs0sAKWkrTYAddF00TAC4SmIwlRqbrC8bx9dNqBRYgsXloVC0c1FcdFhpgqvDI72+OlZmrhbYwAIrp2ytd4bXyGe5Abr8U9kiuIb4xXHcD5fFQ8cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com; spf=pass smtp.mailfrom=kruces.com; dkim=pass (2048-bit key) header.d=kruces-com.20230601.gappssmtp.com header.i=@kruces-com.20230601.gappssmtp.com header.b=q/wQrKHM; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kruces.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kruces.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a9e8522445dso60288466b.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 00:15:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kruces-com.20230601.gappssmtp.com; s=20230601; t=1731744957; x=1732349757; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0LnKdboHHEmfsI5Xr01w60NGeW67NF6gaue5MpHh7U=;
        b=q/wQrKHMj66Xyb9HsKjGLhXrWhe2ca5uKowd2UX0SKRGEN+qA/6rg0iK8y30UpeZtA
         J5UfaJCPMOFvsQVYhYFNKRVOmErKguXDzBSlgSlJzEZpVcmDhRqTats8okVghuYHO2+f
         FEqtGfqoSV/wUZQFlAwDNJH6Iqqm8Ol0/rc9fdQIuYl66/1MU7ywQo6cBaS2cSOyiX+x
         L9V5SJqqAcvSE/1o/oD5e/b7hd4AFfvQcT8MV/JuY+vrDxwCBDgL3iUK8+AMTa2LSt8h
         nfeTKq836qpmfz/eLFtemvn7PsSo373sMYmrrVQyWbPjdkLkse5QfZm5kEMK14LFeD0S
         9R5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731744957; x=1732349757;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M0LnKdboHHEmfsI5Xr01w60NGeW67NF6gaue5MpHh7U=;
        b=IJdRBEx9ESjsKwXfOOAn4QveouE421HqlqZQN4a5r9Pza162GUPalBqMYL88BznY3g
         sejFVtXSZrSVnRCyT2lBzSIKGEbmsff7dYxMSwknyJbo0vHj2PjNW0GU7tOoVICNXmQq
         rtKOPKT+f/jgrB+qxlFWdrg50nAYmNSiplqxiWmFvkY1F/9PqES8qhYzA0lgJADo56QB
         QWUqPxVwY7GLJT84rUCAeceTimhyxYq4U9Uxk/Dz74oVMG/B+QFSZQ/mUUoLadmcknn2
         1FRVUQRWkVFJGUnSjdUD9rWu9kaMQZejM5BIHLOR1ajip7DaOXF8tAeL9tRCRx9/34Ko
         V2BA==
X-Forwarded-Encrypted: i=1; AJvYcCVU875HbS+qWr4L9mJXWdOANcmtPDQYFYKACzKLMMf5codrCYamILeBrrHNN7PpyjunVG/fT2oufkY4TPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy1sdeV20wT1F/4DfLUCAaO1jakxqM+21JeAYcwI/ktrwfwFma
	HMGULennzQhy3I+wQedQURJlv9TjAtvH1BP/pmeSTanGiN5NyfnY1xJe1MOwaTE=
X-Google-Smtp-Source: AGHT+IHyh4hTVRqHe7iP2X/OykKbk2d5/cc41SVXiUl/rLecdctguq73j7MNYRvzb6T9OiZJ81pymA==
X-Received: by 2002:a17:907:9308:b0:a99:46ff:f4e6 with SMTP id a640c23a62f3a-aa48357f73bmr463687266b.61.1731744957314;
        Sat, 16 Nov 2024 00:15:57 -0800 (PST)
Received: from localhost (89-23-255-189.ip4.fiberby.net. [89.23.255.189])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df74fb6sm272332566b.82.2024.11.16.00.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Nov 2024 00:15:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 16 Nov 2024 09:15:55 +0100
Message-Id: <D5NGCPSP7EO8.28YI337NY203X@kruces.com>
Subject: Re: [PATCH v5 2/2] module: Block a module by TUXEDO from accessing
 GPL symbols
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
To: "Werner Sembach" <wse@tuxedocomputers.com>,
 <u.kleine-koenig@baylibre.com>, <mcgrof@kernel.org>, <petr.pavlu@suse.com>,
 <samitolvanen@google.com>, <da.gomez@samsung.com>,
 <linux-modules@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux@leemhuis.info>, <vv@tuxedocomputers.com>, <cs@tuxedo.de>
From: "Daniel Gomez" <d+samsung@kruces.com>
X-Mailer: aerc HEAD-434ca29
References: <20241115185253.1299264-1-wse@tuxedocomputers.com>
 <20241115185253.1299264-3-wse@tuxedocomputers.com>
In-Reply-To: <20241115185253.1299264-3-wse@tuxedocomputers.com>

On Fri Nov 15, 2024 at 7:50 PM CET, Werner Sembach wrote:
> From: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
>
> TUXEDO has not yet relicensed a module for GPLv2+ as a reply from former
> contributers the committed code under GPLv3+ is awaited.

FYI, the SPDX identifier GPL-2.0+ is deprecated as of 2.0rc2 [1]. I think y=
ou'd
need to use GPL-2.0-or-later [2] instead. And when using the SPDX identifie=
r,
you don't need to include the full text boilerplate in the source of every =
file
as long as you include a LICENSE file or COPYRIGHT file with a copy of the
license. One example upstream here [3] commit 1a59d1b8e05ea ("treewide: Rep=
lace
GPLv2 boilerplate/reference with SPDX - rule 156").

[1] https://spdx.org/licenses/GPL-2.0+.html
[2] https://spdx.org/licenses/GPL-2.0-or-later.html
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?h=3Dv6.12-rc7&id=3D1a59d1b8e05ea


Daniel
>
> Teach the module loader that this module is not GPLv2 compatible despite
> the declaration to be GPLv2 compatible until the relicensing is complete.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> [Remove relicensed modules and accusatory language]
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> ---
>  kernel/module/main.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 905d7b60dd709..df2549352ca8a 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -2029,6 +2029,14 @@ static const char *module_license_offenders[] =3D =
{
> =20
>  	/* lve claims to be GPL but upstream won't provide source */
>  	"lve",
> +
> +	/*
> +	 * TUXEDO awaits 2 final answers to relicense the last module to GPLv2+
> +	 * See https://gitlab.com/tuxedocomputers/development/packages/tuxedo-d=
rivers/-/merge_requests/21 ,
> +	 * https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drive=
rs/-/commit/dd34594ab880ed477bb75725176c3fb9352a07eb ,
> +	 * and https://gitlab.com/tuxedocomputers/development/packages/tuxedo-d=
rivers/-/commit/c8893684c2f869b2a6b13f1ef1ddeb4922f2ffe3
> +	 */
> +	"clevo_acpi",
>  };
> =20
>  /*


