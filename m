Return-Path: <linux-kernel+bounces-409457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D229C8CF2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 15:36:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F0728258F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 14:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1FF3C466;
	Thu, 14 Nov 2024 14:35:58 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8362943F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 14:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731594957; cv=none; b=EmlEJaczPU1TMIFrccIIP2T85exiB2GLPpsZSbos70FeSYeiPRXQxLwzFqwwNiNeIwXYiWsEhGCj0Nz5kROHBbnwN1DZiq9CeuCfIjQPc80baaFYLq6hEU4pT+IGShrknQbIbrMGiBXXoplwKwQz0TWWNUIZcGm2yUPdNLUwLp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731594957; c=relaxed/simple;
	bh=mvIuLbW2pKBuLK4pMRt3BfxAaIkOUE7FMfxgIPOyymk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YYbjgaXcBVcCY265z4hIH3eLY26YNWN35vEXyck2BPInVV7XR7Llty/xf5lPKOyoA1LBNB0tMCyTZtWT+RXIWYPq3OBmrvuFjuqE/SToNG0smISvd8PYKhW9H2pCae847ruXjZEf4yp7MBl3lrE1rHW6KVZYmeY3HS79YqT4Its=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6e9f69cc576so6164407b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:35:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731594954; x=1732199754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=46L+e3bH+nT+0jGJFLr1AI0Ez4pi2J5iqbML9+tLGWY=;
        b=ntOaR8NVieNhcOKAdeEoA5Bgdv4ExqHSBwDoVY/O6O4WscLEKe6CNohiR55KJlrq4y
         LK6o/pNU40oS8IhqkQV1/oMyEH9G1A/nIclgLEv25mNcCLB+3OZR8NwpNOxzgt66qEWp
         kvcajbHkvjTK/zt7oUgFQIpN/UtPNIs+AUuS6/f8DEdyZzzfrJq1OAviCJ3f5sK+/PKq
         4c5UPoPl0nR4fsPGP312F+/3T+pClOk8+/mIXmJvKP9zrZd+LyDaorH+PEa+3/syxuzr
         NIfXjXit+GLNwZn46xx9GIEYRCu2KDOIHQJk42/RwNKFVTF7wDuRAmLpz7IcHy3SGT2S
         lU1w==
X-Forwarded-Encrypted: i=1; AJvYcCU0uo3Q3K1yXGsXyazV+329s6he2sodeCVd9SZDA5j3mNNCfTjadeh3YL08QANXv6vPIl45lcb206JH0qA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7Ttw5THezckGOyxmICAmoXrHuxDpgjYxKiBSyKoqK7L/aLEJL
	ZujjLTs6M4GGA61QZOXF5b6YiCz7OkPrqljOdfF/6b3HcImcwx+LMvEJDLlG
X-Google-Smtp-Source: AGHT+IGW8gUT63lCJdZ+vJmdwZDFRjtWyTrsncM+f/17O4csO4Zvj+yWf1JW2hKK9MGcyAzbFFX8EA==
X-Received: by 2002:a05:690c:660b:b0:6e3:21a9:d3c9 with SMTP id 00721157ae682-6eaddd8a64dmr254386357b3.9.1731594954509;
        Thu, 14 Nov 2024 06:35:54 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee4441349bsm2542187b3.89.2024.11.14.06.35.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 06:35:54 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ee4fcfd92dso1450427b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 06:35:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWV1ll2wQYJBL+XkoY4zq9GftpkEoV2HBDn+WAJu/jxjUjbF+xtYluRY1LoZPExQHZiLN873A3Yk/hXIR8=@vger.kernel.org
X-Received: by 2002:a05:690c:9986:b0:6ea:8a23:7673 with SMTP id
 00721157ae682-6eaddd88edemr260442417b3.8.1731594953802; Thu, 14 Nov 2024
 06:35:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241114131114.602234-1-mpe@ellerman.id.au> <20241114131114.602234-8-mpe@ellerman.id.au>
In-Reply-To: <20241114131114.602234-8-mpe@ellerman.id.au>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Nov 2024 15:35:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVsn7Km+ut3jqhigv9cA4XADQc-4bSMe_PGO4rVpx7Fow@mail.gmail.com>
Message-ID: <CAMuHMdVsn7Km+ut3jqhigv9cA4XADQc-4bSMe_PGO4rVpx7Fow@mail.gmail.com>
Subject: Re: [RFC PATCH 08/10] macintosh: Remove ADB_MACIO
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 2:11=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
> The macio-adb driver depends on PPC_CHRP, which has been removed, remove
> the driver also.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

