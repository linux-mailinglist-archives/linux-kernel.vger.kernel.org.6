Return-Path: <linux-kernel+bounces-366900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB6A99FC06
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 01:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81B881F268C3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 23:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028061A0B07;
	Tue, 15 Oct 2024 23:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b="26adAs3q"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C7121E3C3
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 23:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729033467; cv=none; b=T+n2ybTV9I3e+eHHNFWOg+mrSwcga5cXm6iKxx3lXDHmz/xznj4KAkiUldz72BVxwToJwPw38+rJkb4WQ7bsrgf9MkIbRh+Ci4FUo8M62LNMeBhTR28+uf6w40tWJ6mjXPkaOfVclR0BJrLs/16Bj995tiUrOg+C6KTzkcf2GLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729033467; c=relaxed/simple;
	bh=R5/0eEoP/NH5yQmWcdDx1zc8JfQ7uaHFsmINSqAK55A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2re5ArcgMhA6oqk9IBBX/ZxM6jAYLRzl4g4Mnu2BktFWj1TO+942EUHojxn7wrkLvgg1h+EgSGp4K92puNbR/C2krniqeMx1ok8b7sqXh8ImSuQlFQoSC8hx6SHMeiycunbDQ6Q5yyvmLTDqWgk2JGuAj4N+/gKDaYB1riTC6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np; spf=pass smtp.mailfrom=everestkc.com.np; dkim=pass (2048-bit key) header.d=everestkc-com-np.20230601.gappssmtp.com header.i=@everestkc-com-np.20230601.gappssmtp.com header.b=26adAs3q; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=everestkc.com.np
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=everestkc.com.np
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c96b2a10e1so4934381a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 16:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=everestkc-com-np.20230601.gappssmtp.com; s=20230601; t=1729033462; x=1729638262; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TGRNGdRV8OqKzXcTQcKrsJhdxGMaN645Q/fs5kQagE=;
        b=26adAs3qIiXx3EFJmUmu/KA09MyL1BN9fivybVRvceDWU/9kSqYqG8J6L6HyxHukgd
         r3CbzSi5G4SEo6sjS5Xi7sk6ylWQcsBFrkLSidBw3BSWHMyAWApn/fxHXDLaJ4vkCDml
         HFc6e3qY+CTuJAzHpR+ZIPrneK1Yz2KBYredmX74qDYF+MZ3KAJYVJCyOx6nyZ3loGgQ
         Z2RKgzvljoZe9xXJ1C2wvRlR7nUCzjg3BfFgg8NTonpAHwIL3dmlsZDO4KeWwquLUTOI
         /j14RKjHyV3l1sfbFh9k7bG+7deVWUF4Mssqh11ALDE8cQMuyakUz4QYAYSWafc5Me9r
         a4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729033462; x=1729638262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7TGRNGdRV8OqKzXcTQcKrsJhdxGMaN645Q/fs5kQagE=;
        b=Er5aG0trmtouoZne7gflU2nSt8LCSMtbNJnGhGCVQrLsl6ASTNj+KDHooOCf4NcWZr
         bDY4IdJX738CXMXDZozU+GVbLj8TMscc50i42BtC6f973diFjEYf3raU4Mj2lr0lPyU/
         IobTnQTraU6X4T8M5oErPaAnpcexzSmTj3YF8bvQkA6X/bSP83nJ2cNOgpzro53N2b3E
         NmCgS05VG2cXbHQf8fvgcR+cYX+sjovrhrb7W3FdNR93hqcqxbaIXzpk6OE7wxX/tErw
         gq8W5QslBguanQNxfdV2DzvThgp+eerNNVjVGFCGpAimaYruFHrnIzUkGkBpLsStzr8n
         YgTA==
X-Forwarded-Encrypted: i=1; AJvYcCXpEqzmuX9X0lIxhKy6WsAA/dKlI+h7mHZ+2zNovnEROyPJ/93TIOlgcm49BI5HNCFje0Rtpl2V14nJ3Qg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzUdc4Epiqa9dTJnpaKlThuzuDc9Xe6aytmG63TeXlVtmced53
	tV3DS2bcXAUTLt8MDNc5c8G1OCQlTXxgHnqvMuJjJZ16VeA0+kHXa3TE9VcgA+3AukEzJV0dtcZ
	TK+ud4KXDUJrKXUZ3PWu7aTssaSRHTvWVvCWDAqXFKwvYc+JHyh8xr2qAEKU=
X-Google-Smtp-Source: AGHT+IFPXBLWR5bWg7Y+EC/MbuYNZyE0OS8EIdxpUsVAI1TsnbnFwiWuHFAv5UQ4nz+8uww/VQ4hfCgzUUqxYOlFrfQ=
X-Received: by 2002:a05:6402:4311:b0:5c8:ae42:88b with SMTP id
 4fb4d7f45d1cf-5c9950e759emr1527721a12.27.1729033462478; Tue, 15 Oct 2024
 16:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015215157.18571-1-everestkc@everestkc.com.np>
 <99056bd3-748f-42e8-a25a-131f7b194f55@linuxfoundation.org>
 <CAEO-vhEwkQKnPprdw_r=mg6KRbadY6B4A3R_sOsyH0ds78wb2g@mail.gmail.com> <f53523ff-1222-4fc0-9069-10ab895e1136@linuxfoundation.org>
In-Reply-To: <f53523ff-1222-4fc0-9069-10ab895e1136@linuxfoundation.org>
From: "Everest K.C." <everestkc@everestkc.com.np>
Date: Tue, 15 Oct 2024 17:04:10 -0600
Message-ID: <CAEO-vhEGJ-5vX6=32VwNfiV7nSkDL4iEJVti8U0=q=NfOKrSAA@mail.gmail.com>
Subject: Re: [PATCH] staging: gpib: Move free after the variable use has been completed
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org, 
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 4:55=E2=80=AFPM Shuah Khan <skhan@linuxfoundation.o=
rg> wrote:
>
> On 10/15/24 16:48, Everest K.C. wrote:
> > On Tue, Oct 15, 2024 at 4:35=E2=80=AFPM Shuah Khan <skhan@linuxfoundati=
on.org> wrote:
> >>
> >> On 10/15/24 15:51, Everest K.C. wrote:
> >>> The variable `in_data` is freed, but used later in the code.
> >>> Fix it by moving the freeing the memory after it use has been
> >>> completed.
> >>>
> >>> This issue was reported by Coverity Scan.
> >>> Report:
> >>> CID 1600783: (#1 of 1): Use after free (USE_AFTER_FREE)
> >>> 19. pass_freed_arg: Passing freed pointer in_data as an argument to
> >>> ni_usb_dump_raw_block.
> >>>
> >>> Fixes: 4e127de14fa7 ("staging: gpib: Add National Instruments USB GPI=
B driver")
> >>> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> >>> ---
> >>>    drivers/staging/gpib/ni_usb/ni_usb_gpib.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/stag=
ing/gpib/ni_usb/ni_usb_gpib.c
> >>> index 1da263676f2a..75f39e1f3ed1 100644
> >>> --- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
> >>> +++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
> >>> @@ -690,12 +690,12 @@ static int ni_usb_read(gpib_board_t *board, uin=
t8_t *buffer, size_t length,
> >>>                kfree(in_data);
> >>>                return parse_retval;
> >>>        }
> >>> -     kfree(in_data);
> >>>        if (actual_length !=3D length - status.count) {
> >>>                pr_err("%s: actual_length=3D%i expected=3D%li\n",
> >>>                       __func__, actual_length, (long)(length - status=
.count));
> >>>                ni_usb_dump_raw_block(in_data, usb_bytes_read);
> >>>        }
> >>> +     kfree(in_data);
> >>>        switch (status.error_code) {
> >>>        case NIUSB_NO_ERROR:
> >>>                retval =3D 0;
> >>
> >> Looks good to me. Isn't this on next though. Don't forget to
> >> indicate it is against next.
> > No, it was fixed in the linux-staging repo.
> >> Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
> >>
>
> Okay - by the way the same problem is in ni_usb_write_registers().
> Did coverity catch that one?
No, there were no similar issues caught by coverity.
Also, I just checked the function. I didn't see the variable being
accessed after
it had been freed.
> Both problems could be fix in one patch - I will leave it up to the
> maintainers to make a call on two patches or a single patch.
>
> thanks,
> -- Shuah
>

