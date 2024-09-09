Return-Path: <linux-kernel+bounces-320823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC63971116
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 10:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239021F232C8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 08:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDC41B1512;
	Mon,  9 Sep 2024 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkUJVRM9"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F941AF4DB
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 07:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725868688; cv=none; b=k7MnvFYFUeuAPbVb+JyRaD1LZQ3MFI8vpvL6TW3LYP1xLmAsE914kZX4XHZx2w4RNDbFcgBudSJWCcGXk/ylmqvt+/1j076U1aaSdQTCOrbA4palw9aahc9h2DCIVr60svmo+GkKyyyQJxoDCVKvIR1t+Mk/itIdYGhz1LqArJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725868688; c=relaxed/simple;
	bh=ujQZ7V9Cm02L09suGBtipIxQCYQBICBuJyEa1q23u6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iWI0BrUoaAatmgwi7LVW8eWYqzvCSpw55g+vvkLow7Hb7JON06PUJHiz1uDUEfLcfq/fpLXswcIfTdOWZPOckaZvugDOGzBckxO5+ajjt8Ca5CZ0AP0Bf43Oz8MO6lgjcfAmNXqd5BtcTaLxhJWvEcdLQdOZcKKig4gRK5ucFlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkUJVRM9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-718e3c98b5aso1236356b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 00:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725868687; x=1726473487; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WLpjFUUtia9zYW7FEaGOWh41pWa41DKtXQj0BBM9zQ=;
        b=DkUJVRM9YtGFszjvF2dFjds/Y3WjxQ+6sLRAeuNwoS+gLQM4zsSAlMD6xPGIzCfW0+
         rF0CWoUnHrGb/M0+0/Djt4VTWLyfQcZulk0L9lwuZVQGr9jwd2JfrJ7X9+mg0DB10PBn
         xMetiSoZSSBuZldMVtU8/f4BWAlFvzJfoMmwsP8gF/AF+ZLP1zlhrEIdG1hliglqoB5Q
         tDHPmx+59ctvm17zxO50DNcXsMGwl+NQGuYuJ4lLHoZo69e3Iqp1qCmWZdcIGj5Ba9xq
         mu4Mhjg7rqx94i+kt87WlUIFsH9QQdxGt0WXUddwanUz186b5XnrWthmB0hk7HDWlRLO
         YuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725868687; x=1726473487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8WLpjFUUtia9zYW7FEaGOWh41pWa41DKtXQj0BBM9zQ=;
        b=muFgvbLoWj7ByePIqMqOw9SMRhVa+tM22nEQRi4rGt/Z9i1ENUIWynZ+7FkFr5Sglt
         BDzzvDuuB7Rr4WFLX/QdFXbS9Fg9q8gmcyFS10bQsMSzk4bgicNK8Q6byuIEbsDZxkb5
         Lp0svz4aOqOsCaifaS+2F9MCxf85KOr3tFrJ/vjcnnqncwp/Zy8I7l6P46aTkdOWcCt2
         D8/FRp1g10uKnqTLvOqZcVCbvY143C2sPGz7Ax/o2iA/7WR+P/30YcJvSnE+e2XBcQgS
         NRRbQT229qJDt1S82XLwhl/zvL0e3lYt6dbNFJQr8PG/zs07fFmNqvQ7gOrZjJCcx4y9
         1huA==
X-Forwarded-Encrypted: i=1; AJvYcCUBljgVotFPuRQtkB8qfwMiUK5ErC7pHx5/8zlwn+1v2LRVCEq8uOFo2iQITtJ453DMScEN7Bk7S64AbPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbdt18lonrXUPD3+5qXF3SkWYpzMMwIZcuxyfL/2S5H4qmlTgM
	ifXNAuGTjZsO5BNwOSCZ7EcTnOObr1Qrbt3FknBGoLhi9SduSjryDD/5Gg/8Tn8VftgncU1KnnM
	DV1bv0HMIqhAfNHwbofbCQlT8nqQ=
X-Google-Smtp-Source: AGHT+IGlg6KQbu8efR4O6zSp7JM9bj/ucZq060p+QZxUZrTjOrFZ+t+vWteJBrj/2K9uVa6f/Geos3mOGlUDcyzedk0=
X-Received: by 2002:a05:6a00:94a2:b0:714:1e36:3bcb with SMTP id
 d2e1a72fcca58-718d5e0f288mr8741735b3a.9.1725868686660; Mon, 09 Sep 2024
 00:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908101110.1028931-1-sayyad.abid16@gmail.com>
 <20240908101110.1028931-2-sayyad.abid16@gmail.com> <4176c4f5-7da4-4f0a-a632-d2a46b8d3035@gmail.com>
In-Reply-To: <4176c4f5-7da4-4f0a-a632-d2a46b8d3035@gmail.com>
From: Sayyad Abid <sayyad.abid16@gmail.com>
Date: Mon, 9 Sep 2024 13:27:31 +0530
Message-ID: <CACVUEB=BJKSGiW3vDd_t56AZCiUGAEuvyZTM2t9K-DLepEqO6A@mail.gmail.com>
Subject: Re: [PATCH 1/6] staging: rtl8723bs: fix use of tab wherever possible
To: Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc: linux-staging@lists.linux.dev, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 1:53=E2=80=AFAM Philipp Hortmann
<philipp.g.hortmann@gmail.com> wrote:
>
> On 9/8/24 12:11, Sayyad Abid wrote:
> > This patch fixes the coding style issue by fixing the use of space
> > instead of tabs on line.
> >
> > Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
>
> Hi Sayyad,
>
> please make your "Subject" line more unique. Consider that we may end up
> with having dozen of commits like yours, all of them referring to
> different removals and all without the necessary information to tell
> what they differ in (except the driver/subsystem). So it would help if
> you add the changed file or function to make it more unique.
>
Roger that, I'll keep that in mind while sending future patches.
> Please also improve the Subject Lines of the other patches.
>
sure, will do.
> If you send in a second version of this patch please use a change
> history. Description from Dan under:
> https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/
I think I am having some issues with the local repository,
I'll rebase and check again for the discrepancies. If the issue persists,
I will send a v2.
>
> Thanks for your support.
>
> Bye Philipp
>
> >
> > ---
> >   drivers/staging/rtl8723bs/include/rtw_security.h | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8723bs/include/rtw_security.h b/drivers=
/staging/rtl8723bs/include/rtw_security.h
> > index 98afbd3054a4..487d69460cec 100644
> > --- a/drivers/staging/rtl8723bs/include/rtw_security.h
> > +++ b/drivers/staging/rtl8723bs/include/rtw_security.h
> > @@ -75,8 +75,8 @@ struct {
> >   };
> >
> >   union Keytype {
> > -        u8   skey[16];
> > -        u32    lkey[4];
> > +     u8   skey[16];
> > +     u32    lkey[4];
> >   };
> >
> >
>
Thanks for pointing out the issues.


--=20
Abid

