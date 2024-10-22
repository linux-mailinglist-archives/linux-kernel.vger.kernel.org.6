Return-Path: <linux-kernel+bounces-376977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82CF09AB850
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B1F8B22555
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19E71CC8A2;
	Tue, 22 Oct 2024 21:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tCPPqVxz"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673D31940BC
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 21:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729631750; cv=none; b=KS0AdTI+HUzxgWKMQZ1WGcCEQP5oVjVDtv8rW4p/aPZv7OWnD1mqAaPluRCVD32mpavrCh2uTj92Mg7SY4EvvsQlmRsEIw7jMJqqMfmIi7jXa0Ec40mYhQT6LdJMEguN+43oAtxUqxYuQqy6AFUvztycb1nY1U/QjBa4BRIqykI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729631750; c=relaxed/simple;
	bh=L++Zn4yHFUXaf4uad+xRLsW7mESJ9eaN8lBrKxldlZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHEgxgI86v8YKNm2Rqpu9Fd3NEjAvEbwWshVd5ZrV9tcIkKE5IK01b+KIK6hafwE4KtvzC86wU2tQbSBlt7Z6vwxqMqL4OztrdDyfglwxGJRRx8jmoFtQLnQm9f4xIxFK0h/VtxTlAE0vwqxUoosMG4JB+pOIfj0PridoqbrB/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tCPPqVxz; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315ee633dcso25835e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729631747; x=1730236547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pGesWSt7Pp+Gh6T3OlF5sBLVYn/BSEEnVUNyN8fpN4=;
        b=tCPPqVxz5fK3SrwwhHtAg+IKu08wUAdoLwybcJkZLyU2ym0E3OUap8KKriUDvs1hrI
         x0wSekGUB2u5etWPgF4MoXESlAjsJRRdxCsRdIK/KYphoRtdpRuA65e9+tUPbcMW9ga7
         RkN2wZQW3DQCsDk1P+cD3cVF6JSVV5Ct2faO6u2jgkEAzJk9idk7pGd3IpjgsFmmkUPg
         Fifl/SzcE8AZnCWkODOuDLhqADLnxQolOtTobg8N3cOkc4KKSZnEuwYycWn8NFNEDB4+
         gm7vg4k66YxfTryi7w4M4BS4yMlgumagc67V4gweHzd9LwckccrnqTv4gf+pbUMkM5eI
         1MzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729631747; x=1730236547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pGesWSt7Pp+Gh6T3OlF5sBLVYn/BSEEnVUNyN8fpN4=;
        b=usZx61PLggVDR25/+ossVz8O8NhEbkVoMMVddo8qLE5tT45DIJ9hzbZM3SoQqTMTGc
         QXOGUwY9GXI5ZSQrj+arXTy6qg4GsNYCv3UHGD5poXnJ0qJ6eZ/lZRnemJ9FL27vCxnz
         DKzUzsLC1ousHYRKgbhG5qQjY0wPWswT1+77N/kOn7JvLjz2DVUOLX7niwylspUWKK13
         RSRy9iAYCX6P1JyInjaY+QoHQXZDaBBi2BUv6OP61rCGV40VNq7jU5Eks9h4g/JR7XWK
         2UvbsrEp24AYilOprm14V/saaOWP1ZpBR0yY0Xx8rHyOohmZKS+2KEOao76RyA8qdMRl
         s3YA==
X-Forwarded-Encrypted: i=1; AJvYcCXr76fZSx72z31t3KldU/VAAumw6pVpTBtmQRohF3pFnpIe+4ONJYLmupolGi9xFCuAetGXUMcd+/537AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbvXl3DUs50z1Vf1is6PDuc4kWZ1GqyAkdnF55XmEuzAFbuhWh
	P5t8sLfNiMs4j1pKAfrbriWchIeVTkIObV5uszML7RVgQ9vf0eA+tNzm+fZN9xXO4MfoHFlz7Dv
	Zs4+nvNFsb5DXJntIW2fbfaA0jH0ifgKSNxRX
X-Google-Smtp-Source: AGHT+IEXgBJmrtTqt6j5PCdaoj4Mf33BrPYLoS8pUb01lfqzY8RTGBIzteKmWHqlsXwmR4pgwf434k+lz9cleHblJRw=
X-Received: by 2002:a05:600c:1d97:b0:42c:b0b0:513a with SMTP id
 5b1f17b1804b1-431851ffd98mr70835e9.2.1729631746274; Tue, 22 Oct 2024 14:15:46
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1729628198.git.lorenzo.stoakes@oracle.com> <9a84bad9fdebbdb0adca2b5b43ed63afceb5bacc.1729628198.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <9a84bad9fdebbdb0adca2b5b43ed63afceb5bacc.1729628198.git.lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 22 Oct 2024 23:15:10 +0200
Message-ID: <CAG48ez3-ZcWzf5at25PTxcB0FVUCQR5OqjPpFKKgW=r3NTQmgg@mail.gmail.com>
Subject: Re: [PATCH hotfix 6.12 2/8] mm: unconditionally close VMAs on error
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 10:41=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> Incorrect invocation of VMA callbacks when the VMA is no longer in a
> consistent state is bug prone and risky to perform.
>
> With regards to the important vm_ops->close() callback We have gone to
> great lengths to try to track whether or not we ought to close VMAs.
>
> Rather than doing so and risking making a mistake somewhere, instead
> unconditionally close and reset vma->vm_ops to an empty dummy operations
> set with a NULL .close operator.
>
> We introduce a new function to do so - vma_close() - and simplify existin=
g
> vms logic which tracked whether we needed to close or not.
>
> This simplifies the logic, avoids incorrect double-calling of the .close(=
)
> callback and allows us to update error paths to simply call vma_close()
> unconditionally - making VMA closure idempotent.
>
> Reported-by: Jann Horn <jannh@google.com>
> Fixes: deb0f6562884 ("mm/mmap: undo ->mmap() when arch_validate_flags() f=
ails")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Jann Horn <jannh@google.com>

[...]
> diff --git a/mm/vma.h b/mm/vma.h
> index 55457cb68200..75558b5e9c8c 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -42,7 +42,6 @@ struct vma_munmap_struct {
>         int vma_count;                  /* Number of vmas that will be re=
moved */
>         bool unlock;                    /* Unlock after the munmap */
>         bool clear_ptes;                /* If there are outstanding PTE t=
o be cleared */
> -       bool closed_vm_ops;             /* call_mmap() was encountered, s=
o vmas may be closed */
>         /* 1 byte hole */

nit: outdated comment, this hole is 2 bytes now



>         unsigned long nr_pages;         /* Number of pages being removed =
*/
>         unsigned long locked_vm;        /* Number of locked pages */

