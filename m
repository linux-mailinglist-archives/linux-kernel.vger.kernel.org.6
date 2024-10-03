Return-Path: <linux-kernel+bounces-348910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D7498ED84
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 13:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2F611F21267
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 11:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47CF11531C0;
	Thu,  3 Oct 2024 11:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YimzIYnL"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C6B13D8AC
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 11:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727953389; cv=none; b=iNTj+9fllr/teHOeDjqUGzDwe3SqMFnmRQtYhF0qsAU5dFWk/XoqDzfi1q8nOgc2X8ax4hIvOiMCDXHAY7zfTB9snAcLBaA/9q6cMZgQwu/A05a8+YQd9Me1lKo/scnLvbPazGJZMJO0nKseyqIP4L+vfFzGMANQniOSeru0PVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727953389; c=relaxed/simple;
	bh=aNha/fg5xZCZkolD9zYT+zrdEGNqqlDSdXLF11DZsTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hj99i+qEot04/kuJCEBcoKc8NlVUqBKKlYt6/OjDcxOO6J8qY48Y++uWK8BTeZbyULvcrxvxLjKLzB8oYZ6OTma7Yn2ruXzJTqd/rPQ9KWmnL0Dpw9pwIu4wb4DTW45ZQ2/VQBzs3wF1IvDIFBR81eSphpDseORtYfT+1dvs2z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YimzIYnL; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71dc443f3adso110690b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2024 04:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727953388; x=1728558188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aNha/fg5xZCZkolD9zYT+zrdEGNqqlDSdXLF11DZsTA=;
        b=YimzIYnLnaT9oLJ/RMyzSC3rV9JQ76EXk1xlD3HBDZT+Qi2Q5RANCUPbi+woGhFwSK
         WvWY/HddCABXc7gZXhUSGAi1nUXlFUc4rejiLZLBs1YqhMt6V1Ndnxh4XdxW8giZ9VBR
         VqwLH2TWI5YjwjhYAC8frUXT4kOVB6agHAx0oa4u9ki0vHpcWWoc+bs50jVW770cPEwh
         SbSLw+L3MPNXAWrvgPRK4q1qCEZNUUWmnMn0fKM2AVoJqBonBptMSfMMcMSS8RXmclbU
         rp8SG6aoDIO5QS09P7TNAIjdD+UqMMnvCmeD8zRQwXWcyZKEh6E4vmyH65igztqu0uSJ
         Bnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727953388; x=1728558188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aNha/fg5xZCZkolD9zYT+zrdEGNqqlDSdXLF11DZsTA=;
        b=A4ffzQhjvJhetr8vZM2sCqkqp8ffzgJXAr8qZlgrnjddp+c1Vir4fCI0WuNPfpU2KQ
         Saf9lUO39GeSEsVSWOPmajIKYm6YPUI7o1un666mvimjCWD9pX2X5afZN7OBsoMvASGr
         3HGmJv2omxQogIy5yTbgM6Iuv4hdUxrSmYrL73wDuJKBbE1fQluapCpWIq7iRI0rhNc9
         O8uYRWGE8t2ve+DBDvzyYnEwEEbvH3v9AwgmZ3hhEA0x0P49+28UEBmZAmqLq2nuqGsA
         jA5rjcBBdgGz6/WuMZRg0Q34GACNGUlkzR4r1nI01GdXXPIt6BmrIxeG9ZaAJrgoGJ2v
         5rFA==
X-Forwarded-Encrypted: i=1; AJvYcCUr9q/O5WQ1eRElVoIO9aFVS/IytvyXeqMWWCPDNZWMnmGoGbg/ABOL3NOU3AUICh/mDmShjuBvL85yT9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLUaNy/58pwHUqDPPvh1euHPmSAKtRYy2g+6GxU/JRH82+J5CY
	njGysdCNHLwVBgIHnHnBy6jXIbzTrey/iKVns7NP1i1drBibap/5FWfseSNSvoNoyWU3s4U9Sfb
	0aOGFULHHgKvVx8NrH7nAdWDayu8=
X-Google-Smtp-Source: AGHT+IEpH8R7O5WD1/9sz8T/liYtbume7gigxoY0hXXWdiiZPesNYaMtU9rWc6Tfwg858Pct2htM41ubMXNvzv29v2s=
X-Received: by 2002:a05:6a00:4645:b0:718:e49f:137a with SMTP id
 d2e1a72fcca58-71dc5d9a6d4mr4288632b3a.6.1727953387719; Thu, 03 Oct 2024
 04:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1e82c551938c32b4dbf8b65dc779c1b772898307.1727853749.git.geert+renesas@glider.be>
 <87zfnmbfu7.fsf@igel.home> <CAMuHMdW-_oowzrzpoeU-=mD1t8P_65cBr4meY-BToYbkyQMXtg@mail.gmail.com>
 <87iku9r300.fsf@linux-m68k.org> <CAMuHMdW474PRT3F3qfcJaghoB1NTH0o2xXuuLpQfWPqpSSe-mA@mail.gmail.com>
 <87ed4xr22r.fsf@linux-m68k.org>
In-Reply-To: <87ed4xr22r.fsf@linux-m68k.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Oct 2024 13:02:55 +0200
Message-ID: <CANiq72k3BBCCChVhDRALxX=mrtq2dZYR1RzdVU00n2LU=sGXjg@mail.gmail.com>
Subject: Re: [PATCH v2] compiler-gcc.h: Disable __retain on gcc-11
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Tony Ambardar <tony.ambardar@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Miguel Ojeda <ojeda@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 3, 2024 at 11:02=E2=80=AFAM Andreas Schwab <schwab@linux-m68k.o=
rg> wrote:
>
> No.

Is there a high enough minimum supported binutils per GCC major that
we could at least rely upon? Perhaps in the future? I guess nothing we
can really use, given https://gcc.gnu.org/install/prerequisites.html.

Otherwise, does it mean we need a build-time test?

Cheers,
Miguel

