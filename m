Return-Path: <linux-kernel+bounces-529631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2A71A42913
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B293B19AB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B28267383;
	Mon, 24 Feb 2025 17:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VKi9JINe"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2032F264A8E
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 17:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416551; cv=none; b=laZ1qsC+s+z3Hik4UuBIdrXs089as7mNv1aVVln4ADNqt/6NKsP6mnh2dwnqqzUpBGS+WGN8ZTE4+lsAfbDUUKPTN9eHtX1+dAmnYolXo6Qoz5znz/8jdqhutveyLUINsWnHvsvBc9xM1YmN2TAD8rcoK5EBhrNfLCu4ojBkpTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416551; c=relaxed/simple;
	bh=YIKvgyamnQgmpSYwaI32gGdN6nJzCowQ2WNOrwnPjRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwAMdBI3EWJ1rKjABEcoogArMa4IEW6+YXUfddYUbWEwC8whfSrepWs5TljLasDGuJ2e0FamV2XQHINlpLLLddMtN3jTT+o1lTuvI41TOQDIyesQWp5gr4nloABJBlq0YvmdlSrFqUpB/7JzeVj/t8DIMZXK46y1FL7t9CZtElI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VKi9JINe; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-472098e6e75so623551cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 09:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740416549; x=1741021349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VR9fYD4ulxXrS8gZJjWrfuiZTIdun+GiiSoBV4GR/Fw=;
        b=VKi9JINeHdpQtjitOFe8py7OLEuAvlB5OFodKgm9DZQf4TNMrVDFMm990zfL8IhLAv
         JOG+8CwOOukW1UDSVTaExQ8leq+nLFcpQxLZnHIL9i2BCmKddyZTOb/kNQg+JcrPrtKI
         Y3m5HK0eVAthwI81HjftPSXQEWy2v1HcZxrnEhfDo8TK4OMIWWgj28T5h5Ohf27nL1xb
         iTuzr/VB2ZQmL+YFekKb67brQ5E1Jlav9U8O+M6Ls9HLmXKSWxQ1kp3co2QLecciHJHn
         ger84RcSfB6lTqQaXjFz1A2TKOf7LmX3n77vz1D4x12FrSYGAIA9HD0Wt/fNx5BEpas4
         M7fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740416549; x=1741021349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VR9fYD4ulxXrS8gZJjWrfuiZTIdun+GiiSoBV4GR/Fw=;
        b=W9MQfutCBMpg2NOvDHaw0YlY4xKuRh1Ndr7EqDEhWq2mtqd9iFugv5tef24iyN96pC
         OOEhjNcPR7S8wmFz+3CHChLG7vDCyB169zHaDqKOkgC2zO9X0S4xh7TXPxBiS/7NOjLb
         +xuOsCTa85kWk7QD7lwx7orov7GXQbLpPwAuez7Y9Sm1J2QesyBMZmXbsOpgvZi2YXGN
         Iu70Cgkn5R14B67cN0CvCzmzzo4r4F2NAx06ncpU9A4GtK6Xu4nf2yIxd2tA66VIQJ4w
         vbKsv0eVVcvfQvniR4mDfAglcHGbpcHJyol2eXzl4np5DGoRM4GZosmNVrDXT4kLfzBf
         g4qA==
X-Forwarded-Encrypted: i=1; AJvYcCX7No7CicCqQdptj4pIm8dGMlSER1gyFTeKa8S7nxY4zpJ3N+bH8+ZEE6cBsq6+i99B8kRXCRKuQWUjCAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMGB0sJwJbMH5hZbOQR9rEUtC8vmCut4QGzqjy790mQaQvml0M
	GqEc7l+CALq4QknbjLYIVGvXTcSDZXj0c279ANf97/KVYuMUzY7CYIXydbos/f46YtZicoeAQJ9
	cfa7+eoA9ifffU2Vm/AFdSdQTvpCDsi9BphE/
X-Gm-Gg: ASbGncv38xtfinIVNROJPKhFQWzNe7TF/pUH/RorzRNLivlXfMvov+ODcLb6DHvI6Wb
	BKAk+XI1AprOSK6IGug7mGB+ZDQ1GxRb6mWrcRelh8fg2fSOHRuAaShNom5+VbpXcuj5zPLsbM4
	oj/Dwq
X-Google-Smtp-Source: AGHT+IFVV/QSW2PsYP3VXHqjBpcE4L3RaCpSXY45J/dLEVmzaKzSZI2xSnS/YRNsQjCr3RqPRormupPSqzbPXf0Zgso=
X-Received: by 2002:ac8:5781:0:b0:471:9ece:b13b with SMTP id
 d75a77b69052e-47376e5ae3amr68601cf.1.1740416548614; Mon, 24 Feb 2025 09:02:28
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224141120.1240534-1-arnd@kernel.org> <20250224141120.1240534-2-arnd@kernel.org>
In-Reply-To: <20250224141120.1240534-2-arnd@kernel.org>
From: Frank van der Linden <fvdl@google.com>
Date: Mon, 24 Feb 2025 09:02:17 -0800
X-Gm-Features: AQ5f1JqyvF0cZUse3UCnnuocLyu1h_TE-Jmz-aTlK_6A7bNBbcPQf-el1-E8RJg
Message-ID: <CAPTztWauUVnA+ZRytPadKv7oHaRb1xmf_MneiiNXrD1j_1N9xw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm, cma: use literal printf format string
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nathan Chancellor <nathan@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:11=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> Using a variable string as a printf format can be a security issue
> that clang warns about when extra warnings are enabled:
>
> mm/cma.c:239:37: error: format string is not a string literal (potentiall=
y insecure) [-Werror,-Wformat-security]
>   239 |                 snprintf(cma->name, CMA_MAX_NAME, name);
>       |                                                   ^~~~
>
> This one does not appear to be a security issue since the string is
> not user controlled, but it's better to avoid the warning.
> Use "%s" as the format instead and just pass the name as the argument.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  mm/cma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/cma.c b/mm/cma.c
> index ef0206c0f16d..09322b8284bd 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -236,7 +236,7 @@ static int __init cma_new_area(const char *name, phys=
_addr_t size,
>         cma_area_count++;
>
>         if (name)
> -               snprintf(cma->name, CMA_MAX_NAME, name);
> +               snprintf(cma->name, CMA_MAX_NAME, "%s", name);
>         else
>                 snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_co=
unt);
>
> --
> 2.39.5
>

Yes, thanks - not sure why I didn't use "%s" there.

Reviewed-by: Frank van der Linden <fvdl@google.com>

