Return-Path: <linux-kernel+bounces-533297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA239A457FE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 09:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAAA83A8FCD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 864311E1DE4;
	Wed, 26 Feb 2025 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AN0l5RL7"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C69258CD5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 08:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740558044; cv=none; b=kOV2Er1p6JgdAmGXfJltC9Rb6YPFboOXhaQYvRjLmf0JESFFJHVauHkwV8TaGM4qNOp/uOYliVJ2kAqkanjE/eomKfC9QRgCqv9Or9JSdGa4isHJgP/yEPpdyUWOP2xa5R9VNnfbJKYdEeRXddFNjiW/+EERHa8mlDJU+MRl6GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740558044; c=relaxed/simple;
	bh=mYd7usDylCAnvb9RNYjDnwvBydCwfbm+bku4sUKjSQ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kmvr2axTzH0oZTqcTKEKiIgXNNszL4a7fj17ANAOHUGEkkKbFzYXGCW/LvyPyz3iLVs/yll5JVXHtTdK/KZu9vzye+WUCmot117kpkf9+io4o0R0ni9SJOpagRzkc2gNeiQuxa9qXIJiWjXu6DnfFvVnoz/or1GPdhYFGQnF4Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AN0l5RL7; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e670d29644so49936586d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 00:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740558040; x=1741162840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3qqekXnfCty6pD+u0kExo5lVRho5Ggib5QzzRBW/1Y=;
        b=AN0l5RL7oA/GoulacdUl3T+RT+F+8VA1BIpM7TJJJ7b8KHNvzlCFUOOg0AyHHNV/nC
         dCPu1QyO42MWSOLgQGlx62zYMQd+PoNSaj411BmPdIhQsXqPdH8sayOQHhHeql/3bHfY
         gzuIOuiOnUu9P6ieaJSUqOzuZ36TIlwtC56fp0HmsuUUkHZLaPFg4KXfrpiIm3grMlP0
         eSragD/GhKiA4a3okbfrpj7HqMeHe3i0pM6l8TRm8RaclSuqveWh781jO7C1phcJib2b
         sZax10CztQZTOI+N8M7K4lo01pJirfAD97s96oqQF4kIlLUTF/O/M/HAmN0EY1IlEhQY
         1ByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740558040; x=1741162840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3qqekXnfCty6pD+u0kExo5lVRho5Ggib5QzzRBW/1Y=;
        b=jEvVuBuuFae6zVA0Kyi6MuMxFNTzjZfOfstDK43FatnuYClG8OvFArOdvkc1x4pGBi
         2rOx8UzBnIA0xYnyfucfXL6Ja8MTIvSokGohX2ACA7YOEoLvPPvXRVVK58jtoa0vyw5k
         1YY9bD/BGJPGKxTFIqe5kjHw/YQ7ek0JPL9HlPfkgJ7OelOJPdpd1u7ISxWJ60+mEiG7
         h5+cvhNQEdT2bpdD5SUovpnV2Q0ceqnJtiwOQaSPjxntqiWT2UVmm0ricWpR0OEuZ7sQ
         vKAZy6WVQQkjAu0PSBw/hhVE/9vsrrCKmbzzYJbNvMEfWNB33IsmMokyLzpzQvGZDLpu
         hRig==
X-Forwarded-Encrypted: i=1; AJvYcCW8jmHG6Q6f+yDs8ixMA0dti1LJWg2joZLfZZ3ALXm8u+O/WtGpfb68fQjth19Fmy1fZxzNjm9qQTTPO8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzHCdQC7Jnb4u6OgPAGunZHiZdeywzXTanq8xqg8Q6QCKU++XP
	kqDWJdxxxNNFyGRMO+dP/UP8kvyK21LJF9qjS9UI9mfBeOf7SgLaBb7ZDubrxsn2sUD011MFfuV
	MLINccJfzfckWkBJXrihfYJ68oIc=
X-Gm-Gg: ASbGncv/qda3df8QNCi1s61cxXOSt5LE3DiFeioY7GpaHkfZF36hWQ4fiWko3kNjkOY
	nSV9oI0yaegp1BvD8ltiAP3Z6B7W+Sspug+34f+3w9n9Iueen8l2hkpUCJz4WMQMWT7bzBeV0uK
	sIKYTutM2+JqfXEFeE7xrSIFcO43/LXQH5iK/nfas=
X-Google-Smtp-Source: AGHT+IEWyd2uoP8O3fxcApPtMrgC2/m3x8IhO6H+6scbI1NVt9HWN6/TkF/gDKS5jyehPOQ6TVBBKpXBXAXeTaf9rYM=
X-Received: by 2002:a05:6214:528f:b0:6e4:2e5f:c03b with SMTP id
 6a1803df08f44-6e6b00f47f0mr246625216d6.22.1740558040355; Wed, 26 Feb 2025
 00:20:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226080410.10433-1-sunk67188@gmail.com>
In-Reply-To: <20250226080410.10433-1-sunk67188@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 26 Feb 2025 00:20:29 -0800
X-Gm-Features: AQ5f1JrTKv_7Me942Eg9q54wIc5vYl8KAozcwMvYjMii_kjDIxDFDlHyGDse8lI
Message-ID: <CAKEwX=OHN-U1L6CnZhWhpnBG3rLy-OBCZ+1rYATR6PXY6hQNHA@mail.gmail.com>
Subject: Re: [PATCH] [fix] mm: zswap: use ATOMIC_LONG_INIT to initialize zswap_stored_pages
To: Sun YangKai <sunk67188@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosry.ahmed@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"open list:ZSWAP COMPRESSED SWAP CACHING" <linux-mm@kvack.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 12:04=E2=80=AFAM Sun YangKai <sunk67188@gmail.com> =
wrote:
>
> This is currently the only atomic_long_t variable initialized by
> ATOMIC_INIT macro found in the kernel by using
> `grep -r atomic_long_t | grep ATOMIC_INIT`
>

nit: patch description seems non-descriptive. Perhaps you can add some
context - when was this issue first introduced into our codebase?

Also, I think you'll need a fix tag:

Fixes: 6e1fa55 ("mm: zswap: modify zswap_stored_pages to be atomic_long_t")

since the atomic_long_t type was introduced by that patch.
> Signed-off-by: Sun YangKai <sunk67188@gmail.com>
> ---
>  mm/zswap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index ac9d299e7d0c..23365e76a3ce 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -43,7 +43,7 @@
>  * statistics
>  **********************************/
>  /* The number of compressed pages currently stored in zswap */
> -atomic_long_t zswap_stored_pages =3D ATOMIC_INIT(0);
> +atomic_long_t zswap_stored_pages =3D ATOMIC_LONG_INIT(0);

Code itself LGTM FWIW :)

