Return-Path: <linux-kernel+bounces-523612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05828A3D933
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 12:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037A7188DD75
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7511A1F4288;
	Thu, 20 Feb 2025 11:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="Vfb9XVD5"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221621EE01B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 11:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740052342; cv=none; b=i7cn0WoP3OEKi9tnnbxOX6OL1X3xB9XVRpE45yGrvl8kL7FTIMBYGXSCE8Tqm3zAVA1NecjoU5XW9MsLIul6f6UZrhIkk849RBYpzXOcWWSVnItb/EdYJDFJlcOnHwA7uEVbuUYpeAYqkpZ56Exsc2Lf13OeGotj9kNpShzZv4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740052342; c=relaxed/simple;
	bh=OO/lRbml8EOx+1I2P8+mJ+GB6x9c3YMzz/THQiiQX0I=;
	h=From:Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:
	 References:In-Reply-To; b=pEhd4hiPC6edvCb3NcMN7vaXb9vgYjz/IMah0h2xZ1dTVfmw5QD+toDGQEGO7mn8cxoQFFyv3rDKcvuCEe3fGT3dliw58SmP68shZQ5ox33q60/couwApGAyqn2QV224AfwFjKnhowl6tfCtNUejkiubP5bYv8qcAWE6PXysNfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=Vfb9XVD5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-219f8263ae0so16034195ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 03:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740052340; x=1740657140;
        h=in-reply-to:references:cc:subject:to:message-id:date
         :content-transfer-encoding:mime-version:dkim-signature:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OyJ48cEBf3ybJXcCwpkQTA9L9UCk0AqM1gKaY3xOrqs=;
        b=VSd1iNB8GcXvjW/KCOaGFknyfC1paeOY4JRpuR7snAnhL5fQbbVeisFZZApGuzMUSo
         zV0zRzOqttgzKT2wFsDYf4JXAzYNxxCvbXo+U++BWKsmO73i+HT2rLxSh9TVKCHemYTZ
         Z+srt/8RWyGMhTwZ6DOJ23FYC5Dm6QA9AK6toIhcjj7bZUmCANWXKuZDlUd+Edux6yPd
         aMobUilVKYynL+hYsZ+IgIo+h1Ge/s53f4WLtvlOfgYX1j+y64GjyzCG//YwGpWsboKU
         +gEw7M2gN9XPRL8By4ZXJqZM7IVDc7tYDWgFFmwhxCdD3DXPy7y3zfjfAi5rkHIvnQHF
         FCAw==
X-Forwarded-Encrypted: i=1; AJvYcCWiaYiYU8PzOUquTJhVXPUJfI9KfuMEDFwo7FW9wRPr6/x+AFb75f934aaSBRQ3BTyMguZhefcaOSHItbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhoSu8UU7eKI+iguljYq1Smh9rj0jFDi+iqIMklzX8d6jUQw8Z
	8dQ/F/P1AXga3yHXVHJjqqb/gLtCWuR5wOer7YjXYhEEYm9ezzwV
X-Gm-Gg: ASbGncuy/H1Mtg4MguqsO3Qe59IhKO35vAdHTE3f2ZuO/9roRG0XE3v3ZeBB1b9DiZK
	AxAadF5S1lk6VT7O5VVzrmlZ+8doFPW7mPhxH841KIP29tz8CYBLWhby558Y/xWmYZLKD+yOzCP
	dJ7LsolimW373ousH0yLglmTeV1duN13ExusjF1G497u5nAbQ79ZcNDGlmbGJsgtJBKYEGlbDME
	POlQsCL6IHMfJ/tInoaD/3UlCvRc+CuD/S2Nqth14wnOPoSntvI4xfNUKYWeGaAhMTXH6lXqdgA
	srnRPaU8wrx6Ef8qD9UlqlOE5G6Ym7n2
X-Google-Smtp-Source: AGHT+IFlZ37sTtrXAFFHnJ1iBCOi+zyZ/E1NwHgnBT+x6hyKHVv35rYFShprGW7uHdq+ccHBl7Zgdw==
X-Received: by 2002:a05:6a21:3989:b0:1ee:dded:e5e with SMTP id adf61e73a8af0-1eedded1658mr10186421637.35.1740052340128;
        Thu, 20 Feb 2025 03:52:20 -0800 (PST)
Received: from mail.marliere.net (marliere.net. [24.199.118.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-adec4756d0csm6917539a12.55.2025.02.20.03.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 03:52:19 -0800 (PST)
From: =?utf-8?B?UmljYXJkbyBCLiBNYXJsacOocmU=?= <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2025; t=1740052337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OyJ48cEBf3ybJXcCwpkQTA9L9UCk0AqM1gKaY3xOrqs=;
	b=Vfb9XVD5Ky9trJ43YnNZ/rfYoDdKJ75IOVoMoNihtbXIkLDjxnGlOzA97+PLgzzZHKDlE9
	t7zNxFL8/sDmiNRC6U6s5Atz+wV4hMKBZOOgWu03FWeaL01+ZKStHPbWVNdb+ztO61/6Bh
	0J8JBY1miVRBPAW5zrXy9k7Fn2+eFsgNNDzLoD2p8mf3URWrZqj2KFEt/iAtNf2FGiblN7
	JMJTRyUazCUop+pyCM1+g5qHjQQ7ZEuf2N+EJKTJAOyUBV7qCUUefyuUr60wDjAzjhZvJf
	Ttdf0O9MPmQeCKkoEb3rVVj5bD6qyX1wZJcB6dYmr25EBMWbNgmeXJSHpO/2yg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 20 Feb 2025 08:52:14 -0300
Message-Id: <D7X92MYPURFI.1BHED9UW00I82@marliere.net>
To: <ritvikfoss@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/checksyscalls.sh: Add usage message, fix
 -Wno-error
Cc: <skhan@linuxfoundation.org>,
 <linux-kernel-mentees@lists.linuxfoundation.org>
References: <20250220105940.5241-1-ritvikfoss@gmail.com>
In-Reply-To: <20250220105940.5241-1-ritvikfoss@gmail.com>

On Thu Feb 20, 2025 at 7:59 AM -03, ritvikfoss wrote:
> From: Ritvik Gupta <ritvikfoss@gmail.com>
>
> Currently 'scripts/checksyscalls.sh' does not
> provide guidance when executed without specifying
> a compiler, instead it attempts to execute
> '-Wno-error' parameter as a command,
> resulting in 'Wno-error: Command not found' error.
>
> This patch adds a usage message that is displayed
> when no compiler is provided as parameter to
> improve clarity.
>
> Signed-off-by: Ritvik Gupta <ritvikfoss@gmail.com>
> ---
>  scripts/checksyscalls.sh | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
> index 1e5d2eeb726d..14c04227c96e 100755
> --- a/scripts/checksyscalls.sh
> +++ b/scripts/checksyscalls.sh
> @@ -10,6 +10,21 @@
>  # checksyscalls.sh gcc gcc-options
>  #
> =20
> +usage() {
> +cat <<EOF
> +Usage: $0 <compiler> [compiler-options]
> +
> +Example:
> +  $0 gcc
> +EOF
> +exit 1
> +}
> +
> +if [[ $# -eq 0 ]]; then

[[ is bash, while this script is POSIX #!/bin/sh

> +	echo "Error: No compiler provided."
> +	usage
> +fi
> +
>  ignore_list() {
>  cat << EOF
>  #include <asm/types.h>


