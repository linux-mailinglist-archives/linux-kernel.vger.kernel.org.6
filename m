Return-Path: <linux-kernel+bounces-380458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 081529AEEF3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 19:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34C61F2382F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 17:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F269E200CA0;
	Thu, 24 Oct 2024 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJzBuHdZ"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1E62003DB
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 17:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729792689; cv=none; b=K+c3e5pXrC9QQIImwwhJH/WOkSalYNECeW92fNB2W9WIgv1a6y9w++8ynr7MoUtcORRGBjw2ZVBqS974AyJyRvax1kY8IJ8273IcfRfYqO1xrn06knVsfzHyFx2YQVVGNKZJA3SzIeBb0+hUqRK9/rGceIJVrApWXfRj7fvhApc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729792689; c=relaxed/simple;
	bh=IDg9T5Qfv2udS414YtOooo7ru8VVq4FD4hd6amCYuAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UU5mmRf7FHaslmVGQcJuvdqtMfGnULW3UeYerxrcfrXZrpO2fbvyEkHX5IpJhH3MBBtjBDEADIGFtYD1b5GBIzFaiKSBSCURpGzxKe7STI1luRqGM6uDxnPJc1ZjgqkyYLYQmxl9grBGGvpAV74pe08bI/GAym9dZTOtg0K5jhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJzBuHdZ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-720519c4e2eso115369b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 10:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729792687; x=1730397487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOOALsANStOeuuEkl2qAgILCmCOMlJnv3Z3aW8sSQTI=;
        b=EJzBuHdZkOjFUhz5IVVZiRSlv9Dc24fw6Ryi1EjCD5P0e67zJVHugoCpIbavNd0Hy0
         61WH78pQePb8gnTzVHp4AWk99TGbS523XIc1PSJzmIPjrAD0hRXKhQN0YnRcfHVu6k/C
         GLqL3qZjdDlOygWmfWD+/MBKXxM54DKsc5ZT95FojFAnoB8jwbUxj9yKSR0rTFEXY/BJ
         vKmh9yngDcI0c1UkwuQmurbaIP2StV01m2r9/d87V5neK+FnXNIwzJYkCzBQQ2cdMToZ
         O5G9djlJDtw612PqISFsJFfXwqbjRIpKjf46MCakW/aZpfjZ5o4/mduKvnAL0ey5CcRD
         kmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729792687; x=1730397487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOOALsANStOeuuEkl2qAgILCmCOMlJnv3Z3aW8sSQTI=;
        b=V72rVY07blb8G+fNLsOlW0qQDGiWWQgvAifTOyPJ/ZBreqwSkSSRAGm//yKPlE1eo2
         4p+0RP3eMPjAS8BidKVdJ+MhMsjWBvnNL73JPVwf08QCnHwA+hnxcaaSO0SfzTzOWiHr
         hDgMNHcM0SLyzA7ZOSNtFOWpKO/fOTkXAhYA1SYmCeipPI0EI/wcxxdNt59d5A6Yblxu
         DcNF4hXJTJvgI+D1OYSI/fIjyDyVBuMd8EV/RL4K544muOT2lVd1L0FV/cmv0vqFx0wS
         uo0RDnbrdlMEUMVtrnCLanWoJXQzJuSrmAyaFLwiyv/rvr/co4JL4BnrBcLWWWtCNpQs
         3gQw==
X-Forwarded-Encrypted: i=1; AJvYcCWbyDeVJdPLe8Gu7t+79srL2SGO51y+1hqDGhry2Zp8UUXXKAwCIRk4INnXUJZZpHp5GRbMbUsREmTWSr4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN3ng27zWDSYHvyvvNp4+o7AQHv/R/jQmKaYQP8JRi26d7JNSu
	38T/i/4EAfG8cEeBYqt13EprXAWzyvWIfbCZHlyMF487J6YexupRimEDT3U3q2CpzsYZXa1Mm1k
	A11wu8Qd6YwfVn0+jUr9tkWgyBf0rPa+u
X-Google-Smtp-Source: AGHT+IFAk6QlKiQ2m35u3vHdzC9nkRetI3VtuP5Qt4n3QzS2cNh0LibQmS8CXMMOOOGO+4k2Oqw2SJK3Q+JtYTTYcfQ=
X-Received: by 2002:a05:6a00:1307:b0:71e:6743:7599 with SMTP id
 d2e1a72fcca58-72030a8a143mr10153586b3a.7.1729792686812; Thu, 24 Oct 2024
 10:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024-revert_multifolio-v1-1-becfa0dd385b@codewreck.org>
In-Reply-To: <20241024-revert_multifolio-v1-1-becfa0dd385b@codewreck.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Oct 2024 10:57:55 -0700
Message-ID: <CAEf4BzY_j9e3Awqn-mOmHOy4+SWn752mXX+mySQYdKoEHr2RPg@mail.gmail.com>
Subject: Re: [PATCH] Revert "9p: Enable multipage folios"
To: Dominique Martinet <asmadeus@codewreck.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov <lucho@ionkov.net>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, David Howells <dhowells@redhat.com>, v9fs@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+cc Linus, in case he decides the revert is necessary and wants to
apply it directly

On Wed, Oct 23, 2024 at 4:29=E2=80=AFPM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> This reverts commit 1325e4a91a405f88f1b18626904d37860a4f9069.
>
> using multipage folios apparently break some madvise operations like
> MADV_PAGEOUT which do not reliably unload the specified page anymore,
>
> Revert the patch until that is figured out.
>
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Fixes: 1325e4a91a40 ("9p: Enable multipage folios")
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
>  fs/9p/vfs_inode.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index effb3aa1f3ed..fd72fc38c8f5 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -295,7 +295,6 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
>                         inode->i_op =3D &v9fs_file_inode_operations;
>                         inode->i_fop =3D &v9fs_file_operations;
>                 }
> -               mapping_set_large_folios(inode->i_mapping);
>

This fixes our issue (might be worth recording the link to original
report for the context, [0]), so:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

I think the bigger question is the MADV_PAGEOUT behavior in the
presence of multi-page folios. Currently it seems fragile and
inconsistent, working for single-page folios, but not doing anything
(and not returning any error while at it) for multi-page folios (if
the theory about the root cause of an issue is right).

  [0] https://lore.kernel.org/all/20241023165606.3051029-1-andrii@kernel.or=
g

>                 break;
>         case S_IFLNK:
>
> ---
> base-commit: 42f7652d3eb527d03665b09edac47f85fb600924
> change-id: 20241024-revert_multifolio-3e117978b5c2
>
> Best regards,
> --
> Dominique Martinet | Asmadeus
>

