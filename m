Return-Path: <linux-kernel+bounces-564854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF78A65BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A74B176EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5161B0435;
	Mon, 17 Mar 2025 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TQjZ4CNq"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C677A13A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 18:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234551; cv=none; b=Z44sgODGSYjiCUEYR55/S03/ZUgQpWhmwzavesWWeJ0qOkGrgVjj4dQmKhzPZXs1J2bTgPbxt9WSX1b91yMsOQcYaL1H4n2zQgF0mntVd+Eol6y/fbU3JrwvVvzX0dyzz2qIrI9+aJeyfITVn76aAtLx6ZYTtu5mJmk4RNgjkPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234551; c=relaxed/simple;
	bh=4KfOxJpzkEUrnebM6VwsEcKtTjAcaAGCcRWL1ZuUb3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnKpLuxDym3ksGnt/0HAOkPUy/IqKM2WbcoxYrwds5QRFNitZLL8tjq4PfJm+UoS0zLNzEepFzI2aH82FqcaY+umcmPpEYEOfXilFo1f0rxJ2mMCgRxdAZh4Eod5Rduo7dkDrhSxlaK/MqIFaJURoPb00iIIbSV8R89oP5GqtZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TQjZ4CNq; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2b2806d5b61so198738fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1742234549; x=1742839349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o1itwOhs8U8rwjZwMJNYdUQbaZzgT4ddqbJE4Ck2w3E=;
        b=TQjZ4CNqIwc2FsLwoUROBmKU4JWNjh3o8eIfLQ3z8BH27GA48l9TH5+mp7FfoE0LZi
         4pIWtW/AjMPd81+N956AThvEtOR+EV9nOOPF6MXnPzNfLSFJ2VTGoDDPeIg+Z0kj7BV+
         aBvnOcGq5Q0qaVWg7ojsJTOwWqCoeJpynAZW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742234549; x=1742839349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o1itwOhs8U8rwjZwMJNYdUQbaZzgT4ddqbJE4Ck2w3E=;
        b=qEctccjCzYM23clk34dEgvRllY9aRs51gn+85ZHB90a8HCPWZi/cenFgXY6cwjk8wm
         yQQ0kf1jlbV6q0Ll3fRPfuZHGvSLE5lqPukDvk8qHnZm0c5CFb9/r24DCUBeV913C8la
         jkKHqWFYfj1ZLrENREsjOT4zD04RX2c3FoWCd7aP2Z4LouqhehqegF2IRCLtqPJS5PXP
         2Ae+LyDFwxv79hJSTHjR+rv36Ffdn2etRALvZzuVCtk4sMIMF+U/kMYlrD/GoRoihmYY
         jUgpT2ObJqbrC1UbCR3AAz6pxBWNk+45DJu+FdhwXrUoT9iH91LSSrmdQ2LYYSRwCZ37
         Ht9A==
X-Forwarded-Encrypted: i=1; AJvYcCXCRauqI4YsoxqK0t9SQuhOqyVJGfzJTb8cQyPcE7LvDm+RjGoH6bJzsz672pdW1yyoZcmXKIfI9a2EvGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWfHQ+HzO4klSIGMYEb84Yji7HJ+mChgS+F8ULeuo3J1D5QvKf
	PCxIxWZpemo5+Jv+FvkeoXGNZzsGvCu5GaU3jwSwXeZQ65b7RBqk7rdPbhq6mnm9yJXfsotiuRU
	i4R8kRuKmZFjPWCAPQ+DaZYukZtejPQfhnfpE
X-Gm-Gg: ASbGncv/3+bbS1SP7W8vND8az8NBZtMRo+XjsgWKHDG4BFVOZyePkXW9x/nN19Dbyp7
	9kDjPLiT5dcZ+qj3v93aieDTaVW/nChFvAZQ5pScAwF6dEIRrj1L4xFjR1HKvs7RCyOwWV3Zkbc
	nASWASvt58cXRwLhJ3KyUXofDOw769XzC0Z7ZlkW5pks8/HYcJ4ACrAZEg+9SpYIseGQ==
X-Google-Smtp-Source: AGHT+IH41ADt60ghf2dtIE0xa1vEg/Fl38J9bkXH2gfzhBcovPRVrAs1ZYcAeCq+O+e58p8x/FAYdjgdu3Uz68CYukc=
X-Received: by 2002:a05:6870:1649:b0:2b8:f99d:7ce6 with SMTP id
 586e51a60fabf-2c690e9eb05mr2645749fac.3.1742234549024; Mon, 17 Mar 2025
 11:02:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317131917.1332402-1-hca@linux.ibm.com>
In-Reply-To: <20250317131917.1332402-1-hca@linux.ibm.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 17 Mar 2025 11:02:17 -0700
X-Gm-Features: AQ5f1Jr1hVHzTn4m-ziG33n8GzM14Gv6-Eef_doYe18OdvN44Mevu0pERcSM5Ws
Message-ID: <CABi2SkXajtCz=wBpuFLbiW7jDWRR4+5DRNB5p+Rniy1By1QGCA@mail.gmail.com>
Subject: Re: [PATCH] mseal sysmap: update supported architectures
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Kees Cook <kees@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 6:19=E2=80=AFAM Heiko Carstens <hca@linux.ibm.com> =
wrote:
>
> Add s390 to the list of architectures which support mseal sysmap.
>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>     Andrew, please feel free to merge this with "mseal sysmap: enable s39=
0".
>
>  Documentation/userspace-api/mseal.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/userspace-api/mseal.rst b/Documentation/usersp=
ace-api/mseal.rst
> index 56aee46a9307..1dabfc29be0d 100644
> --- a/Documentation/userspace-api/mseal.rst
> +++ b/Documentation/userspace-api/mseal.rst
> @@ -143,7 +143,8 @@ Use cases
>    the CONFIG_MSEAL_SYSTEM_MAPPINGS seals all system mappings of this
>    architecture.
>
> -  The following architectures currently support this feature: x86-64 and=
 arm64.
> +  The following architectures currently support this feature: x86-64, ar=
m64,
> +  and s390.
>
>    WARNING: This feature breaks programs which rely on relocating
>    or unmapping system mappings. Known broken software at the time
> --
> 2.45.2
>
Reviewed-by:  Jeff Xu <jeffxu@chromium.org>

Thanks for this patch and caring about the documentation !
-Jeff

