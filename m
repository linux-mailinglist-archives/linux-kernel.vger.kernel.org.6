Return-Path: <linux-kernel+bounces-428375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5549E0DAC
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71F12B3FA16
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 20:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14B31DF245;
	Mon,  2 Dec 2024 20:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WiSZQH47"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EB51DEFF4
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 20:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733173182; cv=none; b=FgligBB3mRCIQj7sgSYs89zdahFUYK9VHDPk87y279+Y+U1pcGpYHqbQCG+UIwI5oOMIj8thJns9R/UOOPVgcwt/s1VDqqY7R53TRfRVm0Xfju0NoIBI4GVtts3o7zekR9pCawKcIcrasj1jBXeiQw+55ynCd3H1OUkmgUb1C8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733173182; c=relaxed/simple;
	bh=bWUbsbYzAXpNGIx3FEeO/he6o43ml139S4/Re94zVhM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J//5kCAFlo4dpaBiAOcDSlD2CbPvb25vGiY+lhI79GyWMK9q0LdkIJrWOBPKnRva4+e2LgREO/nnFazkoOEeiz9Z/Vp4oK44wew7V5iXKlkdFQ/jNk0pmVlPOmBBmZXqwrRQvSZrIVzoRCzxFLdTxmAo+O/9VNXrMg6a8V4bn1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WiSZQH47; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-46687f60b73so17201cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 12:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733173179; x=1733777979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3oVEWy2iyizmNbl2ITO+8ooVXprBB5JT3rcAZ9azxCo=;
        b=WiSZQH47AC9Nu2HsTtwxhUFddzssiZ8uNg7TUB1BQmN2BocA2zeR0CAm69YVPuQ9k2
         WNvB0KquFga8UKMDZ6CpRcPa5O+3StK/t41r/kW6WgQ6gXa80q0Hd1KryyCKc9CVLAM8
         i2KIQ5cvUSV3TCU+bVSTk8n88tv8KSrS5LlWN4YhxLDpYdvNZR90SdigUmfDWtZbZAGq
         5Bbwo8LHlBwTEiJaqXOrY4eshLc+gVU+qESfaayoswZnNytNpFXcwxplDiUkdLaVK5lI
         tw73BdP4Twgd7NZL+Kyn3IHn31s3PwNs3mLnNhU9H2zsEGwQDsNT0I038Fg0BBGz9Mqj
         eXSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733173179; x=1733777979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3oVEWy2iyizmNbl2ITO+8ooVXprBB5JT3rcAZ9azxCo=;
        b=L86Eb9+cu1GFzBbuzA45zJm8TtzNZamdUAbJHUMf6JgTpsiEkAvMn6vSTRdeAVUbqR
         pTK6D1szf6Infx0BuUF0AkOnPu10uXlDmKs55YnrFPRcbBIYQaA6iClzATHvsFs9s/9x
         +K9FqqGKfSJyK8X1HVvYbkZYTCmVtds2Pe16WxmP418R/MCGjvCH9+VgKd/wKvdz+++E
         pcn/SJThzaetMKlWQ8wn5gzc3F4VmeXu+XO69Kifvrk2y1SWIlKgmlFNgbHprphX4NPu
         TclwXnwhXqrwrqaH892IyFqvhu9+TYwpEG88R2sI/nqvI60VTEPmGIT7IYnJrODsM6uG
         INXg==
X-Forwarded-Encrypted: i=1; AJvYcCXQ9MEaKp/X58Mxj4fKk0dfPciFQrOX9ismlYQKpwhJqwFG5IAH9PHXzP1kRCynXEfmSOJHmRIWlaK28Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxv/w6JA6yjf0Ur15AkFsVgvmvfoPaZwRSyiZxbmULdj1ro0fN
	FuN4AtODzZEUv87E48T8bUB19X7a+9yQslrCydqmB0HdMa6GZDBDRgx/loh9+0/VFKTiEKicKAi
	W3LR81ucjsTVIf51268Z8SiDrL70YOkOkOaf8
X-Gm-Gg: ASbGncu/wngiUm5zPRW6iKCmwYSpNymV/BDbfzmFaeobo+isRKVb+x4Pw+1e3R0Guud
	gk1amMfSzeNzHMxxU+fk58xmMS1Kdl4vXkzfyZPweDslxh87YZvUV6nKIwkCRGw==
X-Google-Smtp-Source: AGHT+IHXajz9FjvZ5+7EyyCzVsXQCy9Z4GCJO1PItlq2H+4of7VPChdd4GL3fxrK7I1fkXmoDaG7ouG2iPSNtCOsmZw=
X-Received: by 2002:a05:622a:2516:b0:460:463d:78dd with SMTP id
 d75a77b69052e-4670abded03mr34641cf.4.1733173179359; Mon, 02 Dec 2024 12:59:39
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202062909.2194341-1-masahiroy@kernel.org> <07dcb646-d806-4767-b29d-77092f6819e4@roeck-us.net>
In-Reply-To: <07dcb646-d806-4767-b29d-77092f6819e4@roeck-us.net>
From: Rong Xu <xur@google.com>
Date: Mon, 2 Dec 2024 12:59:27 -0800
Message-ID: <CAF1bQ=R_VUDR9rGAWhjPa4jHuauftLg=A9Mp=thJaK8PdjM0Wg@mail.gmail.com>
Subject: Re: [PATCH] openrisc: place exception table at the head of vmlinux
To: Guenter Roeck <linux@roeck-us.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	linux-openrisc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Han Shen <shenhan@google.com>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This looks good to me.

Reviewed-by: Rong Xu <xur@google.com>

-Rong

On Mon, Dec 2, 2024 at 12:33=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Mon, Dec 02, 2024 at 03:28:22PM +0900, Masahiro Yamada wrote:
> > Since commit 0043ecea2399 ("vmlinux.lds.h: Adjust symbol ordering in
> > text output section"), the exception table in arch/openrisc/kernel/head=
.S
> > is no longer positioned at the very beginning of the kernel image, whic=
h
> > causes a boot failure.
> >
> > Currently, the exception table resides in the regular .text section.
> > Previously, it was placed at the head by relying on the linker receivin=
g
> > arch/openrisc/kernel/head.o as the first object. However, this behavior
> > has changed because sections like .text.{asan,unknown,unlikely,hot} now
> > precede the regular .text section.
> >
> > The .head.text section is intended for entry points requiring special
> > placement. However, in OpenRISC, this section has been misused: instead
> > of the entry points, it contains boot code meant to be discarded after
> > booting. This feature is typically handled by the .init.text section.
> >
> > This commit addresses the issue by replacing the current __HEAD marker
> > with __INIT and re-annotating the entry points with __HEAD. Additionall=
y,
> > it adds __REF to entry.S to suppress the following modpost warning:
> >
> >   WARNING: modpost: vmlinux: section mismatch in reference: _tng_kernel=
_start+0x70 (section: .text) -> _start (section: .init.text)
> >
> > Fixes: 0043ecea2399 ("vmlinux.lds.h: Adjust symbol ordering in text out=
put section")
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Closes: https://lore.kernel.org/all/5e032233-5b65-4ad5-ac50-d2eb6c00171=
c@roeck-us.net/#t
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Tested-by: Guenter Roeck <linux@roeck-us.net>
>
> Guenter

