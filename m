Return-Path: <linux-kernel+bounces-557675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CD4A5DC51
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:07:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9493A7A75E6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BCDF243387;
	Wed, 12 Mar 2025 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UpuxB3HX"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD032405F9;
	Wed, 12 Mar 2025 12:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741781190; cv=none; b=LtcaPFMQmFT3mLeeXozHgwOUJDlBf1GRMIfe35RHhr7jmrqqvoLqywoe51cgcfdNUY40tZKvIzpTtqpmir7gEFGf//LJytAFnFZZxl3fBsAq8ENt4J4lM9W/S0tLs3Bovusdv1dEqqe3Av/C+IJIek8BQZsd2bWHQLwDYiQXQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741781190; c=relaxed/simple;
	bh=xypOKUIiqk37jy40fQBLrtEj4ywFYn2sLMjN0PvYc7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnUqLHZL31CpP+yU+DVxYq91FMpajQ1aiaNelAX/ULMQMrUzOrO5jxiAN8dCOuE/+9GqIE0142WBDWOBZDCE30utHhrhiz/fQATWcTNtAoHfkYSRqWEcAp1wfMrNFR/g+IuLOZyhmhdCVEsbMX2kBy6yu+D0Z7evL+voV6NjRUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UpuxB3HX; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-856295d1f6cso443979139f.3;
        Wed, 12 Mar 2025 05:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741781186; x=1742385986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=16gsqJtrWLlbGGVWtxUyKdKAGo91B2+znh+1e9ptq4Y=;
        b=UpuxB3HXAddcBhCSCqQGiOrDlhx0ftbI8O6MrsJITRpXMLSDpKtoueZl5GS7sC0e+0
         KUlAJWatNgtRx9TA7wkDKlW9Icy6DDuS8oQG8lb3yRH8dWrZYEunp8BXtlZM67jLqQZa
         lFQcN8gxSNpWeFQ6HYVr3bxXi1tKO9pgirTj/to8Mk37zWGzEoiFrA6p++0QA3MMVNNu
         W7AC3y1R3UYkzF+WQew9nJ52Lexij7A+n8oabungGdiZ04Mr19cabys5DboPsNo8s4Ov
         AICu87TWnmCJoJoAE3QBwhuRocrnEfTwIJzORqE9UJWxopdvT+ZYNXVkCRyykJir7IwD
         OLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741781187; x=1742385987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=16gsqJtrWLlbGGVWtxUyKdKAGo91B2+znh+1e9ptq4Y=;
        b=sHpOc8pojz704JcIGhkOWIo1wKU7rV25N7sUpg/U8ad83crmBuIrYZPPrXEp5PPh0f
         8gmgPbR7DLlC4vY9ueNUoltqnUk8tuxJUrA+H/uGTzo7s9s1EbxbPVsF/VXFxcKkL0ls
         9K+g1PrCuY9/oqFyHFiYfbBcs74FJ7OQUnR7EsfCKrB9wO6ondA+bkDoM120bKHrtUey
         uAcic0N3VAxJNISeSarBgrfKqcHw+Ecc1xEhk083xpT75owY1ZR/8CSN+qQW/X9ohcAZ
         /+2gH66emPeIjBR8c1vnGd+YBvZNFBw5D0oJ6YKR888YGgt6UvjvRvV0bkQFywxxLYBs
         lFTA==
X-Forwarded-Encrypted: i=1; AJvYcCWDtwE0gEIrbT5DgOEnOFaemQJ47wyheXcbIP3QbWYxzT84TTxfr7dmqL/Rs254XZY0j5qGWDVvPXLgsD7T13Y=@vger.kernel.org, AJvYcCXDWG8YsvelB2zm0Uvw70JsF8KIXEHqwzPB2X+XvxqZPzc1ko3tZ/K9N0tLtviNIah48A2P5ATuzHYsRyxW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8HaamcmDC0oi3N8Ap5nfUbLcR77xtSSZhFJc72JHBCM2Yuwxq
	FwgJ90hV0JRibW+Hoeqz4XFqdMdclQQnhFqX+Ren9yKBGFU64BZka/dCzcsDHnu4GOckUIewJdo
	phaZcNtwIZbJUp62oaXGwZtMisMU=
X-Gm-Gg: ASbGncvfIQX6bsnfSGpN/lgVDmkNcZSJ60PoB0Qgc55eCeDuq0QmGJ355HxsT4t1oZ/
	jgFXSX4+1574Pr1+qteSXn4vWVf81CeMiHALtBSMHjeddq+erl3DxeAya/PdC+LTMtknWP4X5Zq
	yDEu6TNmJ9n9oBNL4gMFwJ2eJ4
X-Google-Smtp-Source: AGHT+IGEsF+C5/vNm1H8T7WVPIYrmKDWuNPTJo1w2pmsEdpJ5Y2WsTAbWNetSHDpvj9YFbr4sOBl42eeBtR/jJ1a3Xg=
X-Received: by 2002:a6b:f20b:0:b0:85b:35b1:53b4 with SMTP id
 ca18e2360f4ac-85b35b158fcmr1451553539f.12.1741781186554; Wed, 12 Mar 2025
 05:06:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ed5089eb-fb83-4c69-9835-dd64735b8a73@stanley.mountain>
In-Reply-To: <ed5089eb-fb83-4c69-9835-dd64735b8a73@stanley.mountain>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Wed, 12 Mar 2025 13:06:13 +0100
X-Gm-Features: AQ5f1JozYbhjkOmitxRJRrSxuAPTbJrtddEsFZS-Y5mUWrui6-xHADVYvGOMyYI
Message-ID: <CAHpGcMJ4HTSRzqEWpVDDZi66Y86LRKCob9PAkMFfZBWdpUDU5w@mail.gmail.com>
Subject: Re: [PATCH next] gfs2: Fix a NULL vs IS_ERR() bug in gfs2_find_jhead()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Matthew Wilcox <willy@infradead.org>, Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mi., 12. M=C3=A4rz 2025 um 09:33 Uhr schrieb Dan Carpenter
<dan.carpenter@linaro.org>:
> The filemap_grab_folio() function doesn't return NULL, it returns error
> pointers.  Fix the check to match.
>
> Fixes: 40829760096d ("gfs2: Convert gfs2_find_jhead() to use a folio")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  fs/gfs2/lops.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
> index 3853c422040b..0fd3b5ec7d8c 100644
> --- a/fs/gfs2/lops.c
> +++ b/fs/gfs2/lops.c
> @@ -530,8 +530,8 @@ int gfs2_find_jhead(struct gfs2_jdesc *jd, struct gfs=
2_log_header_host *head,
>                         if (!folio) {
>                                 folio =3D filemap_grab_folio(mapping,
>                                                 block >> shift);
> -                               if (!folio) {
> -                                       ret =3D -ENOMEM;
> +                               if (IS_ERR(folio)) {
> +                                       ret =3D PTR_ERR(folio);
>                                         done =3D true;
>                                         goto out;
>                                 }
> --
> 2.47.2

Applied, thanks.

Andreas

