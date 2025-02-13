Return-Path: <linux-kernel+bounces-513119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAE0A341B9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 15:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25156162B73
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 14:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FDD281363;
	Thu, 13 Feb 2025 14:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dVicuATO"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E3B281346
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 14:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739456360; cv=none; b=LeP2KM7V0gwdaHwNmmkQNW9dPN3783GEMbLUfxKnVcFTbdIYCMnostGVl8HlvPkVi09Nv+zszfoA77HSWVKqBKxIatd5Zq5Ie8TK4cN9c+/YrG7yNjuXfkjzL34eQds17GsslffAyie1ARXAP2kAMSeDT9ku9uLMPXYh7YrKdNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739456360; c=relaxed/simple;
	bh=uvwW2M0tsg3X8YSCEGE1nEThdpnwA3AYKjZ9BOrjojg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzRnh0RUtyOCcXRxZO+t5swE7MgvCkatnnaoAD0LuCFOKt/Hpa22nrtTMtBQ0pJQUIGnopdX4gE6rCKd/2Lg1k9AZn6brBVwXfbRc7mxkdB+D0zSP07qdZMfUrixTI3hOj6sCdZONb7oVTZ+nCJ4+oTYnclMVzOU/fzpFk1fK0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dVicuATO; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-726fafb7aacso50530a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 06:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1739456358; x=1740061158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvwW2M0tsg3X8YSCEGE1nEThdpnwA3AYKjZ9BOrjojg=;
        b=dVicuATO5+njIY76HlhFYIyH8Ag0TCxOkyXLTm/EAlw6tpMkpeEYidgNO+rT4gaqTL
         O4DZeIQg4YVPuqzB+1awXy++S6AmBtH+Lp9+1XEr35Px8h2EBFLvmVSej2YWUdiCDY3D
         rOK8JUCY1cgxZtfz3CDV8wtgBQPdP5MqOAAWI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739456358; x=1740061158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvwW2M0tsg3X8YSCEGE1nEThdpnwA3AYKjZ9BOrjojg=;
        b=rOoasfMr65bAnzVGCHWHMFT+rgSpM9dEYUuNFfmfB2MYjKcoh0BAmgnk5G+ASiMz52
         1lg4B3yBfQKuNqon8fIdv9mb6Me3mtMug41SaPqKPraJIV6XTBPYx6gndxDx7HD6G5/u
         2BMcSeab90erUjXoFK5Tv/B0Zdbs0UhPJa5gk70msM9P1vhxm1AMUn36BZt68HOV+IO9
         5VYs+SJptvpoQCDqOooitTwy0ciWBaDgxrNZCwlI70ql4/XtlpTHYq+Y+H9965vS+9ss
         ooRw5FSOb9puKG88WZRwqzgXf/RWKkAZHVoKwQz+TbV7fJs8DtqnMYtBauqgUiCM3WtD
         zBGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDpL1XUI5Fl24tD6C9NIbNEISCUquHjPzfdhlMywbRHQ2VW6Ef5rNEL+meDtzhTe/z7A5psZBPJFvP4OE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcKMdusj5jsrnohukdgnAIbsqAaNGUTi7Lpr6oiJYHgUVkHycX
	scup2znCCpNYvnrq7bKSiSV4EG+jACGXYjGRq2K1E5R/EiKA5bOLVfbxXgKwUN6KY0e0eINcaRB
	dg3HVuuqGyL2n9e5sGqUEMifFg2FYX1uqMHrU
X-Gm-Gg: ASbGncufF8Y/QG5zxwwSIXHYF0d3UltV7kBC+c3WlwOnmqSYAbkiQ33+1PWNZGolrrA
	tJyZ4+p4EMkXSL9ZecN9EJbb/lHfrcoMCotbiMswtpL3DdNhaQWNI9oe+JyXOUhQahbbv7j6xQr
	SZE4Ti/0wTdnkmuH/HJwRXeiDBw4iejg==
X-Google-Smtp-Source: AGHT+IEDqI9pfjnnU/sTPvTq6q4LFKcqw8kNwZAhOcRWyUEaa9UGeRzGdRy+xyqhMEsX8LjY+QmDAxL4M8xudw2I6rM=
X-Received: by 2002:a05:6830:488d:b0:71e:4ce2:4331 with SMTP id
 46e09a7af769-726f324c02dmr1708739a34.4.1739456357827; Thu, 13 Feb 2025
 06:19:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250212032155.1276806-1-jeffxu@google.com> <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>
In-Reply-To: <b114f48a-a485-4ebd-9278-6c62a1f33d9c@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Thu, 13 Feb 2025 06:19:06 -0800
X-Gm-Features: AWEUYZkh57X2nN0U81mtrUf8380_Mz2GDTsMAg8QIsAN8W21sRJ2eFLIaAt_1F8
Message-ID: <CABi2SkWbYpQsUUAukG1xCnX1FmZpr90r_LtKMrAji_HuB6E6zQ@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/7] mseal system mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com, 
	torvalds@linux-foundation.org, vbabka@suse.cz, Liam.Howlett@oracle.com, 
	adhemerval.zanella@linaro.org, oleg@redhat.com, avagin@gmail.com, 
	benjamin@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, linux-mm@kvack.org, jorgelo@chromium.org, 
	sroettger@google.com, hch@lst.de, ojeda@kernel.org, 
	thomas.weissschuh@linutronix.de, adobriyan@gmail.com, 
	johannes@sipsolutions.net, pedro.falcato@gmail.com, hca@linux.ibm.com, 
	willy@infradead.org, anna-maria@linutronix.de, mark.rutland@arm.com, 
	linus.walleij@linaro.org, Jason@zx2c4.com, deller@gmx.de, 
	rdunlap@infradead.org, davem@davemloft.net, peterx@redhat.com, 
	f.fainelli@gmail.com, gerg@kernel.org, dave.hansen@linux.intel.com, 
	mingo@kernel.org, ardb@kernel.org, mhocko@suse.com, 42.hyeyoo@gmail.com, 
	peterz@infradead.org, ardb@google.com, enh@google.com, rientjes@google.com, 
	groeck@chromium.org, mpe@ellerman.id.au, aleksandr.mikhalitsyn@canonical.com, 
	mike.rapoport@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 3:24=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:

> It'd be nice to update the documentation to have a list of 'known
> problematic userland software with sealed VDSO' so we make people aware.
>
Sure. It will be added in the next version.

>
> And I _want the series to land_ :>) I suspect we're close now.
>
Thank you for reviewing the patch and giving support.

> I am tied up with a number of other tasks at the moment so apologies if I
> take a second to get back to this series, but just wanted to say thanks f=
or
> addressing my various points, and that I will definitely provide review
> (it's on the whiteboard, the only true guarantee I will do something :P).
>
> I will also come back to your testing series which I owe you review on,
> which is equally on the same whiteboard...
>
Thank you for the heads up.

-Jeff

