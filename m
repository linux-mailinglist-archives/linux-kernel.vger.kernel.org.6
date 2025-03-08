Return-Path: <linux-kernel+bounces-552335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E994A57898
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 06:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98BE16FD52
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 05:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC5B0188A3B;
	Sat,  8 Mar 2025 05:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nwY+Kmhh"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAB2196
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 05:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741412469; cv=none; b=hRjsqDvoyQikNEvqlTLqKGz5MIxluu/ome6xDhrqqUwlCawjH0gI+w3uacDNx15GhQMT5kCmanOCBzWTq7y/AxcuvxD4GZ6DR1Zb/wAjBqhbAH/WVErOvJg84aqmY7rkJeAC++PoiKpxNDh7CCB9tC99I35ufjBNQlnACc4MomM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741412469; c=relaxed/simple;
	bh=zdInW9/Q0g3TtRuFFjxtdjGT1ntLsubGIabA7azNnF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pC1vUcLk8TEdv7Xg0URRxE9wnzoejNVlBTRzI3uvG2nOINQfSxUEtdHdeXlOrKro3G3wbRa5IMrOqYUNIkzYVKaoqS2kLeRCIxrCNqmAMJ6LHsOYZIrzi8KUfwLGhI5ILWrcVb3l71vH5I6cUs/yl/82r56gMZjbGTm5G6WOenM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nwY+Kmhh; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e6167d0536so836840a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 21:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741412465; x=1742017265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdInW9/Q0g3TtRuFFjxtdjGT1ntLsubGIabA7azNnF8=;
        b=nwY+KmhhQf+38vFFQEm9kV9LFhWK8Jy3sEka9D99j9X7OvCMtu3G5LFTvQ7+1KjQzH
         /Nbdemw+dU4XMWcclDVOPmrXf9W3wC0af920HfvKjeCFOF7R8ber/KysZfDKdoXN2CkI
         ShH7yGxKrerRBXZxUXmUdBLpxgGhYA6zZcHB7G1oTK9eba6XtPkrujf48o/Kejw0h07G
         xCWoo6IRpMw4KQ7LU6N0XHSekiK5dCcHN6PF6vuSH0C6+KrroEFt9OLekj03mXEHU6EK
         cyGO8KXT5mRp4zx+g3yXu0ln5lBwhr9peFDZq0JmeV516c5UTuoG6WuEMDzL7YqJuGMt
         Xueg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741412465; x=1742017265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdInW9/Q0g3TtRuFFjxtdjGT1ntLsubGIabA7azNnF8=;
        b=uUcVi9zGQoT1Bt240+ogi70+5BNBFnROp1QWkU4g9IvFEl840RCVjhOdoH6uJ9NiNL
         5QT4Rpm4FZICYRgoA1QXSQlQXDuYojsTmmjhWvj18/1OL4LmDHbad4gaXKrySlh7+Gb3
         ZsezBlLmHCOP+ByGbUC3uvdVQ/uTkoz7PI+Dl4rZXb2y79AG+Ad/HL3r3q3CZVy7P4wh
         XvlYtGXZbwx4nU236RTbQ7jWpWHzd2EVC26xrwFX5eJwYcwTqJA3tXyS5Vpjw2lC93bh
         DsTScQvUqCnwVopiaFsYn2YZ49Zfis1VWSZyWEykVpIL5orpmLx51wx0O24ioK99Uv/7
         GGcg==
X-Forwarded-Encrypted: i=1; AJvYcCV72dHWNOTH5iUti56mEEIFgJbomYgfm9CB6j5lvd3Sl4S2rdcdycNKt21K47XF4KC2LYQdDpOuzcIjGLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI52+xKNs/BIrXnIK85EPxcOxqtj71n4rlTM3x8STm01rtuBJF
	Vb4/VyoajtcavIdjWjU8/JR7rAKwAKMKi53sciObXRqm3NP5T781QKe6dAncR9+RuLWosfqsPh5
	QdY98vffTKyVuDy6eufvqV3GXxzallwnJ8TfH
X-Gm-Gg: ASbGnctW3nodDBwaQV9/pxaPN1mG1+u7jTWVNzxt55eM4sjSI5KjsG+hI3VKRCklIg9
	V3DCjCDwI7qeXaf0RNsBzmfSt7NiqPQT3i9GN96NF1+iX5T7UYedd8/VcRnDdDl43INBnlRGfZ4
	N6sOqITRYdSlLAZjE9ZhCiRqwZz4F3VDaxqwCT
X-Google-Smtp-Source: AGHT+IHo2PDDI9I6qlRDO6UBHqyRzd05L8tQZ+VxcalVUvx7hfwObQ0npt6/o1jp9kL48JbYgSiDJElWv/K6VQ8EdhA=
X-Received: by 2002:a05:6402:2791:b0:5e4:d11e:7c4c with SMTP id
 4fb4d7f45d1cf-5e5e24bb58cmr7202371a12.28.1741412464668; Fri, 07 Mar 2025
 21:41:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250308011028.719002-1-aik@amd.com>
In-Reply-To: <20250308011028.719002-1-aik@amd.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Fri, 7 Mar 2025 21:40:52 -0800
X-Gm-Features: AQ5f1JqHUPD1cUQbwC0XGvEQjFvxgeTUlhoO_RT4hTgIRg1b6omcoJrhiqinDuY
Message-ID: <CAAH4kHaK3Z-_aYizZM0Kvmsjvs_RT88tKG5aefm2_9GTUsU4bg@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccp: Fix uAPI definitions of PSP errors
To: Alexey Kardashevskiy <aik@amd.com>
Cc: linux-crypto@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Ashish Kalra <ashish.kalra@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 5:10=E2=80=AFPM Alexey Kardashevskiy <aik@amd.com> w=
rote:
>
> Additions to the error enum after explicit 0x27 setting for
> SEV_RET_INVALID_KEY leads to incorrect value assignments.
>
> Use explicit values to match the manufacturer specifications more
> clearly.
>
> Fixes: 3a45dc2b419e ("crypto: ccp: Define the SEV-SNP commands")
> CC: stable@vger.kernel.org
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> ---
>
> Reposting as requested in
> https://lore.kernel.org/r/Z7f2S3MigLEY80P2@gondor.apana.org.au
>
> I wrote it in the first place but since then it travelled a lot,
> feel free to correct the chain of SOBs and RB :)

It's all good. Thanks for seeing this through to the end.


--=20
-Dionna Glaze, PhD, CISSP, CCSP (she/her)

