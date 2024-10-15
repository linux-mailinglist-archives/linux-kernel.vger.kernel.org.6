Return-Path: <linux-kernel+bounces-366877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBBA99FBB3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 00:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E80528574A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 22:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F911F80D9;
	Tue, 15 Oct 2024 22:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="CrmZkrrP"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4891F76B1
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729032514; cv=none; b=lfIvaMkzFtz5H1ab09hjmUCas7+y39XUNYK+yj+eSgX0OZF7TFg7RU7QDSdcTVZCL2JhKFj8g+Rp6wllVNa2JOadNGo4U888rnbnaaNo9qu4Ia5AihmPmy7zddgw9cU8vTgkJV6Iql+L0ZO5RnZuZo+nVy74zCfdJJFnY+22wrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729032514; c=relaxed/simple;
	bh=MilXVF0Pl7zreQTOpN2ffuJKLXQVDsOWlshtxvK8NbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J2+y67AdF+/EFqXYSeZun5GgRaIcu3X7uIC3dt/eX94yOF5XApA9+25fvNDr+VFdui85nG7bkJUTy49dNZInoXLWo8DuZ2uBENdrLx0hpxLmsm6qUjziB8LGZc8fo3UI0iNXYzqsXKQiUdoIWfyWP1ZHUR1dx4RLwYpWR0pq7t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=CrmZkrrP; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c94861ee25so3648821a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 15:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729032510; x=1729637310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miq9FmtmjdBD0hWpSYeZA2klh/HZsIKy05pk3Zx+Afg=;
        b=CrmZkrrPc2154rE2OCIJSTZ9pywB6zp8WyprJ9EyCU4nxuVpLL9xmNvr7UtXaN8bzE
         fWEWhXx5cOfntR6q1tRSVWth5b93w9vZF+v7SIJh6N3y2XHa66L0aEj5rqD+cj085z1o
         nLikKUPJ9wfD4eThC7SVhRvkwh4i7lMEKQNgQf/frgiIJC8RZvUVxAbAgHpUGGNE/VTO
         kbOkS6Yk53L7oKyDJo0QEgc31XVA5vbz7J5TQzhyNRVNRF+E3tg8ybCcuQKRuBlssndP
         Xm31GETBwN3iK0Y2peUXR7TKctwKv4cxo5NbQHBwZ76rFWP9FS638XpyDCTzzcg2CY18
         6xPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729032510; x=1729637310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miq9FmtmjdBD0hWpSYeZA2klh/HZsIKy05pk3Zx+Afg=;
        b=edcPTl1HrHRVfxj+nyGiTmivVoxIzNXe4fhwPhGXfEEuVqVOml8RvoZKBecZ5Wgi4d
         KvVOPTizyZl1X6hWiY/oqiCt5KN2QJzqWesMplggqTQHsGKMbSSKs4vdHxYYprTL5dDT
         rIaKx55yxx0oB1I6OKJKNYHBlXBsGvtn5R4tjfdxbnppPmzS5ewsweOBLCBZB2GfmqJx
         z+FRw4pDH2ymlZ040f6Iihw1TCNrD1OlcZgqJxHZsAbXbTNn7BwJv3QEG4gYthIsXvhB
         ctQJ8paNM7/GwGwMOeRZ65tHXdO7HNj5nnztbi9ID6gCYThba3IvycUK6eWLtRjXZgk+
         wC2g==
X-Forwarded-Encrypted: i=1; AJvYcCVvnlfpHg7H2gCQa+BUiKCnxfVAAdohh3fZ9ez880ohSXL6t6oWPSkanEDGhFf0o+JkF7cusVa+yOVowRE=@vger.kernel.org
X-Gm-Message-State: AOJu0YysZurmuVsK9vuVmaMjNJ53rHoRYocQaf31dlnRR7Nc95Morg1W
	E9CPn9tPuy0KGX7CIpyrCnLUXVa6rdNqgOcUaflKHouLbWOEsXcOq6u5cH4LSO038N9hO3G8TBr
	+Af+BLWO2KXQ3pPFD6aT0dVcK8WykcIv1UGU9OA==
X-Google-Smtp-Source: AGHT+IEwOi3xOaRekA3PPJMkq6HAJdzViRwYCHfUYxVkjaE6to7N2i/cYZrGYTe0N4xvD1sOPBjtZAPxgpVW4Xl0qFM=
X-Received: by 2002:a05:6402:c41:b0:5c5:b7fd:170a with SMTP id
 4fb4d7f45d1cf-5c95ac50794mr18001007a12.28.1729032510392; Tue, 15 Oct 2024
 15:48:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015215157.18571-1-everestkc@everestkc.com.np> <99056bd3-748f-42e8-a25a-131f7b194f55@linuxfoundation.org>
In-Reply-To: <99056bd3-748f-42e8-a25a-131f7b194f55@linuxfoundation.org>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Tue, 15 Oct 2024 16:48:18 -0600
Message-ID: <CAEO-vhEwkQKnPprdw_r=mg6KRbadY6B4A3R_sOsyH0ds78wb2g@mail.gmail.com>
Subject: Re: [PATCH] staging: gpib: Move free after the variable use has been completed
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 4:35=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 10/15/24 15:51, Everest K.C. wrote:
> > The variable `in_data` is freed, but used later in the code.
> > Fix it by moving the freeing the memory after it use has been
> > completed.
> >
> > This issue was reported by Coverity Scan.
> > Report:
> > CID 1600783: (#1 of 1): Use after free (USE_AFTER_FREE)
> > 19. pass_freed_arg: Passing freed pointer in_data as an argument to
> > ni_usb_dump_raw_block.
> >
> > Fixes: 4e127de14fa7 ("staging: gpib: Add National Instruments USB GPIB =
driver")
> > Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> > ---
> >   drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/stagin=
g/gpib/ni_usb/ni_usb_gpib.c
> > index 1da263676f2a..75f39e1f3ed1 100644
> > --- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
> > +++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
> > @@ -690,12 +690,12 @@ static int ni_usb_read(gpib_board_t *board, uint8=
_t *buffer, size_t length,
> >               kfree(in_data);
> >               return parse_retval;
> >       }
> > -     kfree(in_data);
> >       if (actual_length !=3D length - status.count) {
> >               pr_err("%s: actual_length=3D%i expected=3D%li\n",
> >                      __func__, actual_length, (long)(length - status.co=
unt));
> >               ni_usb_dump_raw_block(in_data, usb_bytes_read);
> >       }
> > +     kfree(in_data);
> >       switch (status.error_code) {
> >       case NIUSB_NO_ERROR:
> >               retval =3D 0;
>
> Looks good to me. Isn't this on next though. Don't forget to
> indicate it is against next.
No, it was fixed in the linux-staging repo.
> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
>
> thanks,
> -- Shuah

