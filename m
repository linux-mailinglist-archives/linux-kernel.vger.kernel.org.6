Return-Path: <linux-kernel+bounces-321153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F610971543
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 12:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A34B287CD1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A51C1B3F38;
	Mon,  9 Sep 2024 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OypH+DJN"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BAB1B29D9
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 10:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725877507; cv=none; b=XZSIxdOI7X6IbHRJtVAMs8WT73QSABrrH7DnMrJVmE+CTWJbzUu7V6TqeMgB368IzChOwV8UcIdNYD4MSeeYqjxZNYe6xzw1Nwkuv3niVR178tWGD/DAoA4MQ/ITRj5z67/1R5YO6qgw0axGiolxQ0Qd94My4u1GyL8M8H5hXT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725877507; c=relaxed/simple;
	bh=igWYc2HLTlHgxbHeBp+GlEfh+jAfbhcDCLq3lozYnok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5hZP+hD8GIf/MPX0TYzoNjcQFWvWb45E9aHcPVecEggzfmLYd/UpvL3bbPytg/JOyoHG0keumidpH54KK97FjoilmaW+YU0H/IwqnEHzWGsru4zVslt2rdi2fNg8DReZ+J8baivNMDVi60JMJih9QLh3RGbdBJjyYalZhdhPOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OypH+DJN; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e1a9e4fa5aaso4008369276.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 03:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725877505; x=1726482305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g45hI+dbrFl5zHoBA8y+ci0W/+L8ASesTKBmhCZ596o=;
        b=OypH+DJN7iibmaapq+CHuoX/GP+h8ScuNv9tksQ3w7N1WcnflZ44COjGxxLe/k4z/7
         LqYb3jwKikCznDGySu36BHDI5Kn5jATJ6fCfQigHjmeaK1/vrXPHdEjAAcRBS4ZwNwHK
         v5H9bWtCJNc3YuSi2JN/exJ0CtGi1CLPBgIDYgw6as/AwGe/rcBxh9EveAbkLsOO8YHS
         8xNUNhpzuaCSguD8GgDbaDm7/dWBk9t3NrQA1LXtdFVKXMlcH/mOtveT/VZZyL9UTrc0
         Ijo26T2oWvv9y/zOXP+4ZtdpduoDmZlbj8+ae4BXVzlPjrPqYqSZaXWR5wwnpHwJrvVg
         WjzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725877505; x=1726482305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g45hI+dbrFl5zHoBA8y+ci0W/+L8ASesTKBmhCZ596o=;
        b=Uu8CyZkIs6ntDLmbTQNiu85foILcydNUAb7g0LjTbXPHa50DG2Tj9y5jqwktQso3xj
         L+F7ZUGsYjDjEJ2VuArawCyJiZjnjUAbLeYhewZRN5/h/EurMoEhg5UR2Dg70OSN8JaW
         A3u1bN/fFS5Npaqb9116B7vJcnMC8QPzg1XLaWW3EjXA+IX/Kv3OswBXtTEzdv/eQCbu
         XjuYSM7Jx2jIDyBz71nig0klGH1KI+kXDeCSpSfspWbVSX3XMtE+CEkR5Gv4yf8tUXQ4
         Q/MTC8F5oeOxRuYxMKTfydMjjm/LB3qa3QOpke52bevIbzdHGeKG6mPX0MnIgQk3/vLh
         WVoQ==
X-Forwarded-Encrypted: i=1; AJvYcCX09hqQaQfBLV0U0WiAYrw4Dynecr7YBYTm9pFmzKMiq8KcmrLrSL1Iqf/Clp4JP5AG2HKeoHimShC3ZDM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5ZhQbnr5lVZU2T2TLBB03MRCGwI4VVkiPdO7j9wW7yzH6SRtZ
	CYvAAAw2a1IHpwG/zYwKW1J3e7noNrS0W1rTGiw6xWbbp9jOMDc0518TqSTPKUV8/kkC6M8H1Pr
	I1z+XlAsIyXe4iBx4YBTMnrbOvQXjHGUuVCY87A==
X-Google-Smtp-Source: AGHT+IFDQSlZUFFqwjtBGFubuT/aNajcR0fBHSdSHs9NmXKaik+0yq5I6jj/Abm0bIMeVTTkEEVdl1mf2/pkFTxLiWY=
X-Received: by 2002:a05:6902:2188:b0:e1a:3dc9:c422 with SMTP id
 3f1490d57ef6-e1d348829edmr9561915276.19.1725877505183; Mon, 09 Sep 2024
 03:25:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f8c12aed-b5d1-4522-bf95-622b8569706d@stanley.mountain> <CAHUa44H4XHOxn_=TxTUM=S6oqUNL6-kVVU2=jFPZyobzmtbQPg@mail.gmail.com>
In-Reply-To: <CAHUa44H4XHOxn_=TxTUM=S6oqUNL6-kVVU2=jFPZyobzmtbQPg@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Sep 2024 12:24:29 +0200
Message-ID: <CAPDyKFoe+_m8VLWFdB_jgv915WcyLbjkFJq_Regb1qXwQaVchQ@mail.gmail.com>
Subject: Re: [PATCH next] optee: Fix a NULL vs IS_ERR() check
To: Jens Wiklander <jens.wiklander@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sumit Garg <sumit.garg@linaro.org>, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Sept 2024 at 16:09, Jens Wiklander <jens.wiklander@linaro.org> wr=
ote:
>
> On Thu, Sep 5, 2024 at 3:17=E2=80=AFPM Dan Carpenter <dan.carpenter@linar=
o.org> wrote:
> >
> > The tee_shm_get_va() function never returns NULL, it returns error
> > pointers.  Update the check to match.
> >
> > Fixes: f0c8431568ee ("optee: probe RPMB device using RPMB subsystem")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/tee/optee/rpc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tee/optee/rpc.c b/drivers/tee/optee/rpc.c
> > index a4b49fd1d46d..ebbbd42b0e3e 100644
> > --- a/drivers/tee/optee/rpc.c
> > +++ b/drivers/tee/optee/rpc.c
> > @@ -332,7 +332,7 @@ static void handle_rpc_func_rpmb_probe_next(struct =
tee_context *ctx,
> >         }
> >         buf =3D tee_shm_get_va(params[1].u.memref.shm,
> >                              params[1].u.memref.shm_offs);
> > -       if (!buf) {
> > +       if (IS_ERR(buf)) {
> >                 arg->ret =3D TEEC_ERROR_BAD_PARAMETERS;
> >                 return;
> >         }
> > --
> > 2.45.2
> >
>
> Good catch.
> Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>
>
> Ulf, this is a fix for a patch in your next tree so if you could pick
> up this patch, please.
>
> Thanks,
> Jens

Patch applied to the next branch to my mmc tree, thanks!

Kind regards
Uffe

