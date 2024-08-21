Return-Path: <linux-kernel+bounces-295917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09AB95A2F1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38AA1C22164
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7148152199;
	Wed, 21 Aug 2024 16:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OnqKf2k9"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC50D14F138
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 16:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258137; cv=none; b=lc3URUqoOLYuNBGG5XyU/vk2HFnu+HEptUpEdQGxXnItC0+UyNUkcW7WvWfbMPnCYbHUIfgRMCRW8k3MsB+iiQ6lbXjYTiqbiSacVY4G1wVKPSKIEZk+827XpxC9j48tUa8WU0Wcf8Ce6sPp9ImORzDe8XQgLfnLWXsl/SlYwbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258137; c=relaxed/simple;
	bh=hzBeSbaTtIAToh/GaX5rZx/f1VGFsqzxE8W9F/KKb4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0fNSnO7AGdPmiEenM88vqhMSixWOHt5A2dl3R79LLXmnLZjDC8w+KE02KmhLIf7UW/r022kNNYPXEK1XE9gqSjHu5jSAXrEgakxLmyK/cJ6k029fEX26huhzkgWF9nEL5CUTiMjMTCIkCKxDj6O8vYcm424NzIMQJIXAWtSsFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OnqKf2k9; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6aab656687cso8557867b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 09:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724258135; x=1724862935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssKb6qw6aeMO+6QGtyvALnPcAvbpew5UWcwhrzSGCa4=;
        b=OnqKf2k9Xk9j0A1QhT3q6q+kCA+r5CfBKLYyE30T03DnlCFqtjnw1XubPKW/pIhZK6
         03cdqrbj/gjk8RWP0YXvi4+29gtyGY3IdQRmbbkI5cyyw6Tg9Ohqxy4ujjU9tUImxWia
         VriTqRDNgnXSVMWo7YzQdPdtNIQY5nLbRw0R2aHSpcy6afCgY5k/4toAZVb4CWuOA9+t
         ShXO6Cd3RYlEtYHaqRNdYWDC/HBnE3BSZLrZDDjwwqLp5ScpdbCil6V7eG67k/1q3OyU
         LNB1U5PGuBmcOG+jusLNSStc9iPRIzp2s+1WXUdWj79dK1qQaGV3sg36ZuzQKDzbOvFT
         /NqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724258135; x=1724862935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ssKb6qw6aeMO+6QGtyvALnPcAvbpew5UWcwhrzSGCa4=;
        b=OvRt8odRCQ1BbgzLk4o3fTBza9xU5TdDnug1ksjFbvAU23EskGFvTS7Ma/0DfV3tZW
         G1628Ze33QmKPbdYuE7QUtBod7VY7YRA1HdT1vFbVl/5UCjMMltHaOoR/N1nWIxQ+UNb
         CP/xOUGvdVuACsaveZKfA8ZmxUiI11PEI2xfST2eXcL7IqiOe/e9InZykph1FPKYGTOz
         wZP82S4IFUOeNRMHEwwmY8gk1FqoSYFOUCl32sh0AtqlLY/UW/baRSsk1prEfnQAlb/9
         SVmeRVrxGQwZrksH58URnTFEyh789XGoJutMdNwieaOtttf5aNYIy82ClJlCCGNYSCaa
         lOHw==
X-Forwarded-Encrypted: i=1; AJvYcCVd+PzZzr3yfh0PPzI+5Bmcl49IXIwQzIkrJKRc4mbtUV8xN+Stt2ffWK7cc5MhbdL4EGjhlpH2veufkDw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf47vLdRkMKaaSf2O1HzdOyEKnlHVmzyNKArM7W/IFwfdD1EVu
	nXQH/lmOsX/ZHYKTXgo7s+d9DWrQ3ED6OQIaAYzI/SZ/kPjc+//0G8kovwTMsBy0dvnqtpD74xM
	/DSRdgGfuF4MqVRdI77sTmOqsfqRvEOJDS5Hm
X-Google-Smtp-Source: AGHT+IFFJJaltNCA/IDKVau9jaELlCUOp8789S+uuTRwgIUoSv9E6HoUzHZ0yFPljmsWOYHtvETnEbDBnlf6C3JyEkw=
X-Received: by 2002:a05:690c:63c6:b0:630:8515:f076 with SMTP id
 00721157ae682-6c303cf67bcmr2591717b3.7.1724258134800; Wed, 21 Aug 2024
 09:35:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820235730.2852400-1-Liam.Howlett@oracle.com> <20240820235730.2852400-18-Liam.Howlett@oracle.com>
In-Reply-To: <20240820235730.2852400-18-Liam.Howlett@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 21 Aug 2024 12:35:24 -0400
Message-ID: <CAHC9VhTWRMKZiximDFAuhY0PwvHt8rk913LLKLQu20tjrnN7cQ@mail.gmail.com>
Subject: Re: [PATCH v6 17/20] mm/mmap: Use vms accounted pages in mmap_region()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, sidhartha.kumar@oracle.com, 
	Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Paul E . McKenney" <paulmck@kernel.org>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 8:02=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracl=
e.com> wrote:
>
> From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
>
> Change from nr_pages variable to vms.nr_accounted for the charged pages
> calculation.  This is necessary for a future patch.
>
> This also avoids checking security_vm_enough_memory_mm() if the amount
> of memory won't change.
>
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Cc: Kees Cook <kees@kernel.org>
> Cc: linux-security-module@vger.kernel.org
> Reviewed-by: Kees Cook <kees@kernel.org>
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  mm/mmap.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

I'm pretty sure I already ACK'd this, but I don't see it above so here
it is again:

Acked-by: Paul Moore <paul@paul-moore.com> (LSM)

> diff --git a/mm/mmap.c b/mm/mmap.c
> index 19dac138f913..2a4f1df96f94 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1413,9 +1413,10 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
>          */
>         if (accountable_mapping(file, vm_flags)) {
>                 charged =3D pglen;
> -               charged -=3D nr_accounted;
> -               if (security_vm_enough_memory_mm(mm, charged))
> +               charged -=3D vms.nr_accounted;
> +               if (charged && security_vm_enough_memory_mm(mm, charged))
>                         goto abort_munmap;
> +
>                 vms.nr_accounted =3D 0;
>                 vm_flags |=3D VM_ACCOUNT;
>         }
> --
> 2.43.0

--=20
paul-moore.com

