Return-Path: <linux-kernel+bounces-249830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBA492F076
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 22:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A1A1C2265C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 20:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042CE19EEDE;
	Thu, 11 Jul 2024 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IfOkl1Fc"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CBB8BFC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 20:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720730836; cv=none; b=rgebtqB/XR9L+S0twb4Ja9lnRzo0LRi4Qk3BEa24VBZl+XkkvzUxx0n6mKXu3g1zDpSLXvuB5Mf1qThP1/VO4SrzTVn2FF5YX3QKS32a2jB/HSd7Gyk3cneK3tBAu4c47quuOHHumcF/bvkE/0DFWXpNfi9ioELRoqstnhstay4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720730836; c=relaxed/simple;
	bh=ihOAv991CYcx4J5lENxImeMdZKV5ZnV+kNckH7A07KA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k8/VlukGl8LhqeSEph2BYCLHDaI09pgU86lGBUilKX4xRdyX+hPtF9LCFSs/vSktYHcJXDhAiRoWAHXv8AuBu/x4WcwKIxXz30ne1FEwvHfukzhd/gL2K1q1cSdrzUHk2NwM/QHvtBv/w4PagsRk5DzaF4j0U0lBBZ0TNOuEn1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IfOkl1Fc; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a77c080b521so174413566b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 13:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720730833; x=1721335633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GwK8GUdrQUXFWHXDop1YJ2PJk0zJ/dd9nqhUvq95/V0=;
        b=IfOkl1FcvUjgBc4bOJGE62YfZ/NaVUQw8/KMe4eNtAfUHXQx328A+nEAhwfX9/xUhh
         E5uvzhmq7zZ3b0dG0zhOh6oH9TvN5x2SDONhLe0F9elQdQbVVbwgZBDIzoQOaT37xUal
         BDB69rWPSDeCFvvsTfFU1ClFGujs6OyJCzmy2vgAppPAZ+ztuIF2vbZzJMJ/Uwyu0fto
         kKdoZ5NdV4kK63Ti9D3010aXuTGFY3Lh+YFtpEWR67x1bHtFv1cLaEym4UAsik2DcGYG
         Odqq8rKVzlUc7+3VwQXDTnxXnCunNRTrRl1yuRkTsLOrm5pduis1w+NCqDmmONdX7hmr
         lQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720730833; x=1721335633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GwK8GUdrQUXFWHXDop1YJ2PJk0zJ/dd9nqhUvq95/V0=;
        b=fv+o1dqSqLBUwVbDixB0mSjO4Tg40R/HcgD+evaVev2F93JIdyByA7b1PCTQkL1+OM
         2Y7mztlGaWOX9z6Ei260ol8espfg07rXJ3KnS0743R8LJsYrKvssiRa3t6rlpVQBbBLX
         mmp/JCY9y2g0c4ChVMc3/0/0XHDT1CKhWV1QUeVKQnbWZWknXvSzwkGUl4XLN62xKmka
         +XcOujW6z+1HfqYnrL/YX5ylPGGwp4Asr3vzCTAIGc6MvX1Hgd31gMKAdNfekETvkQr6
         WDbZJKQt2vZjFjeXZDxGsT+dJhbWIBNyEknly4sGiL/ZQG4xtC7OpbcW3GCZfONSAIJE
         I9xw==
X-Forwarded-Encrypted: i=1; AJvYcCVrvG2LP+3/Os9Wxt0TdV6rDG9sYkbvR0wXNBD6baZzEWTB+5hX5R9RbvKduZlOyOHZrUiowT/lBiQgRbJ/CcgIz5ZkeRqX7wSsvpOJ
X-Gm-Message-State: AOJu0YyPeeRVzKLft/1UY/SI+HKfdHHEf2/d9MaRIH3YtU1KapGMBX/A
	4EVvG5jiUuX1DtkLAKWApKU4IrSjjf9HkE2+U9OpKyULV4x1nyiyts2NrCgcRqKsrspxPGP8ZJK
	CHTIs6vHx0L/LBHv/8WaSbCHqoMc=
X-Google-Smtp-Source: AGHT+IHg/C6AmHAKiFNiDFpubVSapeVT+Y4fUzwRAL7rFWuqJoUjbijq9ERqQMO/a4PcHUUPAk8Ox3AZUD+Nd6CTz+4=
X-Received: by 2002:a17:906:2bcf:b0:a6f:6803:57ef with SMTP id
 a640c23a62f3a-a780b6b1b8amr607919766b.27.1720730832723; Thu, 11 Jul 2024
 13:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240118133504.2910955-1-shy828301@gmail.com> <2d7bd8b2b9736d4a7d0a26169978372b5e002a62.camel@debian.org>
In-Reply-To: <2d7bd8b2b9736d4a7d0a26169978372b5e002a62.camel@debian.org>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 11 Jul 2024 13:47:00 -0700
Message-ID: <CAHbLzkr1LwH3pcTgM+aGQ31ip2bKqiqEQ8=FQB+t2c3dhNKNHA@mail.gmail.com>
Subject: Re: [PATCH] mm: huge_memory: don't force huge page alignment on 32 bit
To: Yves-Alexis Perez <corsac@debian.org>
Cc: jirislaby@kernel.org, surenb@google.com, riel@surriel.com, 
	willy@infradead.org, cl@linux.com, akpm@linux-foundation.org, 
	yang@os.amperecomputing.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Salvatore Bonaccorso <carnil@debian.org>, Ben Hutchings <ben@decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 1:10=E2=80=AFPM Yves-Alexis Perez <corsac@debian.or=
g> wrote:
>
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> On Thu, 2024-01-18 at 05:35 -0800, Yang Shi wrote:
> > The commit efa7df3e3bb5 ("mm: align larger anonymous mappings on THP
> > boundaries") caused two issues [1] [2] reported on 32 bit system or com=
pat
> > userspace.
> >
> > It doesn't make too much sense to force huge page alignment on 32 bit
> > system due to the constrained virtual address space.
>
> Hi people,
>
> sorry for beeing so late. I've looked at this following the OpenSSH issue
> (CVE-2024-6387 [1]) and especially the impact on IA-32 installations wher=
e
> ASLR is apparently broken.
>
> There was a recent thread [2] on oss-security discussing the issue.
>
> Looking at the commit log I think the intention was to fix this both for:
> - - 32 bit process running on 64 bit kernels: in_compat_syscall()
> - - all processes running on 32 bit kernels: IS_ENABLED(CONFIG_32BIT)

Yes. It is supposed to cover all 32 bit machines.

>
> Unfortunately, as far as I can tell, CONFIG_32BIT is not enabled on 32bit=
 x86
> kernels. Maybe CONFIG_X86_32 would be the right one there?

I have not been working on 32 bit machine for years. I'm a little bit
surprised CONFIG_32BIT is not enough for x86_32. Sorry for overlooking
this.

The below patch should fix your problem.

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2120f7478e55..2944b3fc88a5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -857,7 +857,8 @@ static unsigned long
__thp_get_unmapped_area(struct file *filp,
        loff_t off_align =3D round_up(off, size);
        unsigned long len_pad, ret, off_sub;

-       if (IS_ENABLED(CONFIG_32BIT) || in_compat_syscall())
+       if (IS_ENABLED(CONFIG_32BIT) || IS_ENABLED(CONFIG_X86_32) ||
+           in_compat_syscall())
                return 0;

        if (off_end <=3D off_align || (off_end - off_align) < size)

>
> [1] https://www.openwall.com/lists/oss-security/2024/07/01/3
> [2] https://www.openwall.com/lists/oss-security/2024/07/08/3
> - --
> Yves-Alexis
> -----BEGIN PGP SIGNATURE-----
>
> iQEzBAEBCAAdFiEE8vi34Qgfo83x35gF3rYcyPpXRFsFAmaQPCQACgkQ3rYcyPpX
> RFvSHQf/VE7td7scTTsrK7Cx0F3MmDLFgjUDbMDuyPq6lNQqnDbd2zc00JP1eeLs
> /mW1uZNbR92bn6xq2sPJu7c6tB3MJuiQme+ZqnPfIgyoWc89i6V6WUXTZN077lIl
> xJZxHLMei5KreHz66AYU66HdU89knMTcX362YyyI8dEZKXS3FlP0SLSoBM0UKY0G
> HYM6+GetE+fINhfNSMpHgqkTQB825Vqdq5UBsBjHYMg5RJ92/fDgUo5RD7qm/HVz
> SDDNSGwpVwYZ20RnnD+DOS9rsnyR4FcAP0m0dcTmQdM8GcY4SyjnEux5idvCicjy
> a1jmvsSLxCMZ9mZsrsipIZoNhSHlDA=3D=3D
> =3Df0Lk
> -----END PGP SIGNATURE-----

