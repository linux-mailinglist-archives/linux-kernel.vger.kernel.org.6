Return-Path: <linux-kernel+bounces-442672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9097D9EE01C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 08:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8CF16699B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 07:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C366520B206;
	Thu, 12 Dec 2024 07:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CDokDu33"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C83B20B1EE
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 07:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733987799; cv=none; b=AMbKjby6Z6hrWyFUR9EmcCJatF5g45m736IXOYerJaliuMR2ZIq4qnH76Y9orwIxTEGgSxuwsyfQ93zEF+SUUyY40iM59ULOypZe1lARYZgS4ZJKUgj545sJfjkUFrf89ZaEelrsQigO+7bdmug0vPLOCGdZtv+eLJVBIVunNoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733987799; c=relaxed/simple;
	bh=DejVLYwyaxDBWkB6wpXp+Xf4jpr49GQR6BvFRUTtCD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPoUNhgQQjdJ9C4Ic06joEwVVQnuxCD3xVPorl6kIBykp9fH2ioXqTWk4NAaBhqfD2SfuP3HDdj7Vvr7dwbUrxqE7kKym9jArQmYzvn5zV+oV2QqRtHyRo9Pbd4maWe+0LCx4AMVUfMcT3fWLbolFKoY3YIUvNZ1CV9vPr+9ymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CDokDu33; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4675936f333so112621cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 23:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733987796; x=1734592596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAqzJau5MNI7uhPzwJwwA8EW7jYEvVF2H0CgK8xErAM=;
        b=CDokDu33ErgXHJgmMUYBZGBh2R94rI5HVN67qCsYgyuxKKM4h1rS1so/YgGAijdFJi
         rLRD3qEydjcZ1iXw/NoWSJq0SeDDCC/tvSV61me43Yggh4RroF1FnfeBhKXLLmyiZqqL
         2kmpcDEYz6YfOdOXAW3R1CUW3r0nTPc86bUtvnjRKxvIV6bDvdh0AJI0iOK/AZaggUss
         OwmR8FvLHWjSv+IJsdCeyA/BoLJoxss9xeUnLt3q9OgfxbI9ioWYueQ43leNjLnq6aQY
         YYig2QGqxImPwKkdFrFKm4ijSHx4S5jX+RbhATedeolOMdPjSOAqh+2ZvhsFTJmCFZ6l
         xiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733987796; x=1734592596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAqzJau5MNI7uhPzwJwwA8EW7jYEvVF2H0CgK8xErAM=;
        b=w1KBSGvB8UoWy1vzKotw0917dkhBUvZxRPWVSD1bJ7+3iqJQzXCJ0iVMZndlhOLnH2
         evNdv1RKQr5KBzzto921lsZlJ0o6JyVmY/X9+Cdj5GtesP/DiIRte76tWCL9qM+RXiR8
         z3OZR/RCy0VGtntmp+riMa7bumYs1igZKBNSPnmwAT/y5ozfMbxNG0efBeDHLwJP5kuz
         QErlTfK07y0iEof0sAiSSOegEaL8WiQRw7byAXhP8ld5iTaTzGxcVocpTNlrxlU8kVMq
         Ahm5FYVRq/og9LKE+c40+EtLG/7+zGEnbBjOZvj0jRCKSJ1EZSPZtTOywwuWx0aQeJA4
         bIww==
X-Forwarded-Encrypted: i=1; AJvYcCXhxa035XC5yimeFE3Dqso23AQCqu6VkoM4+mfOswbTTvv4ll/wDgfcSoOG/rHOc2yYNVzfG8+TF9CA7XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCEHTXaQQns+sp3X9mhugDB2VJN4cnSMNT7cofSrfRlJIjzeTZ
	dRq8IK08CDRVfMmTbgiFA85AQt+KLjjJE8bv/VfaY+FV5jHwDqqb4w5z+JzIVaYfV8UNh+DU/9+
	snXPK7ZIbjRhKZDmuEt4MngejmZM2IqqP1dnX1qyA9qkyL1l9+hBg
X-Gm-Gg: ASbGncvMzzjZS0Rw32QTRGTH8CH9XMVsNbdJSrN+c7G+Yutfd4n0+QnskYNjcl1bsVU
	jNyj9zoCB7+zk9dTXUMsrt8Q7Jpkt7ZfAV6rC1ppJVZD7Z3xllaBF+TzAYfW8nFN78/94
X-Google-Smtp-Source: AGHT+IGgAPHIygAP8O+rI1KHXuuM3G5cHRMeOHQ7eC5ChWIlENkidXiO0dR8zJiRe2OJ2witO/aX1uih99/P6Sng88s=
X-Received: by 2002:a05:622a:1cc6:b0:466:8646:c72 with SMTP id
 d75a77b69052e-46798246560mr1625341cf.25.1733987796309; Wed, 11 Dec 2024
 23:16:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211085616.2471901-1-quic_zhenhuah@quicinc.com>
In-Reply-To: <20241211085616.2471901-1-quic_zhenhuah@quicinc.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 11 Dec 2024 23:16:25 -0800
Message-ID: <CAJuCfpHP2QAhiYmzaAJgxy7A4H3mYep5NKL-iQRy3xSazZ13LQ@mail.gmail.com>
Subject: Re: [PATCH] mm/code_tag: Skip displaying the code_tag if it is not called
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 12:56=E2=80=AFAM Zhenhua Huang
<quic_zhenhuah@quicinc.com> wrote:
>
> /proc/allocinfo is full of callsites which are not called at all.
> Let's only output if the callsite actually been invoked.

No, I disagree. Allocation that was never invoked is not the same as
no allocation at all. How would we know the difference if we filter
out the empty ones?
If you don't want to see all the unused sites, you can filter them in
the userspace. I also suspect that for practical purposes you would
want to filter small ones (below some threshold) as well.

>
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> ---
>  lib/alloc_tag.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
> index 35f7560a309a..06fb7eb5c0bc 100644
> --- a/lib/alloc_tag.c
> +++ b/lib/alloc_tag.c
> @@ -95,10 +95,12 @@ static void alloc_tag_to_text(struct seq_buf *out, st=
ruct codetag *ct)
>         struct alloc_tag_counters counter =3D alloc_tag_read(tag);
>         s64 bytes =3D counter.bytes;
>
> -       seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls);
> -       codetag_to_text(out, ct);
> -       seq_buf_putc(out, ' ');
> -       seq_buf_putc(out, '\n');
> +       if (bytes || counter.calls) {
> +               seq_buf_printf(out, "%12lli %8llu ", bytes, counter.calls=
);
> +               codetag_to_text(out, ct);
> +               seq_buf_putc(out, ' ');
> +               seq_buf_putc(out, '\n');
> +       }
>  }
>
>  static int allocinfo_show(struct seq_file *m, void *arg)
> --
> 2.25.1
>

