Return-Path: <linux-kernel+bounces-313788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C0A96A9C1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 23:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E0FCB209EC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 21:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1051D58BA;
	Tue,  3 Sep 2024 21:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNiVWeCP"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9A7126C1D
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 21:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725397520; cv=none; b=ZSFlg4tb3ql/UO4nHsOJoyzL+BH/eIqx1ulA6J6sL1B8iqUD/RcZ/YAGmOqPvskWKH81ZxJso0tVVac/zn+T/jPJsxXpKDf6S6gJGrzdElx87nUjtFc81EgyOYkDDZHS8IZp+Kl3MI4dqZIuX9jKNmZdtWFjq8XflK+nPSaAz34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725397520; c=relaxed/simple;
	bh=NYMA1oq9BxFGRApD/T7k9bHoKBvP4yeD+4KNXBx5HME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqnUa7O1Q7sOPyMqqYLmPskzLUQPAM5jbqkAFLR9O53TrwAzt7EQvR0BZVeVx5eM7LBjKTCsVM7Q+NdzNO/q8W0GYP2X6dlwU3dm0vFsWo0xqksFsB6rWTZktE5M47DpmETlhImDZ/nDAi4dpqOYb91lYaDe+P/i1DA4Fx85h4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNiVWeCP; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-2705dd4ba64so2809585fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2024 14:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725397518; x=1726002318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7/8Mzl5CUtHsRnmmpHB7NbNUNZa2IsBOf+f+oZc0/E4=;
        b=lNiVWeCPhCI9HN+dscGkN7MtDb9htQafDUsxGyfRyHsKzOeCW+/EZ4dCXtl2CmkFZn
         uU2qHhAdJOEOfNgugyU6zKAJejCo2vh0jOWxNvIVWz3upMN+fP0yTNVupl0KwbQVFrz5
         VaeDHUTo2RsH2M/lC2WFMjoFVlHrzvvWKKtTXiZSZgOW6ckQi5ksDqiWjVh5S52T60Vm
         WPLOF3DT17dkEeYC8Xwvn0I+bLsHfI5+i5sb4DezoMZnjkC66WY+lr2gwKOkmalFzMcO
         ssnaIrRmzoj66OOCUHIIvQ4WqaUQnoGVd71ESx5YOxOYKGtLCGfA69sVeTgaK792ooek
         B0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725397518; x=1726002318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7/8Mzl5CUtHsRnmmpHB7NbNUNZa2IsBOf+f+oZc0/E4=;
        b=oLM1ji0C7ga8BiOK//9LAD+8K/eBki9Hmq0ZLymJW58TimdRsz5JklSY9lz98i+lZb
         Qz+emwaSPbBZNp29gFw0mfjU8NzCHsBYPtkDRWGU5YdqeLsRQx1V7FsT942wrXiKwh9j
         tO1oPpzi/4Lo5HKbV2inUpE/h6+FSiWaYHhKVT/Z+k7acqd+2nqenPznslmrskaBJG1Z
         9QNrbVW9M6r3mpAr1cxGXjN2+zuJWg447c6FR+VdWYJz0cRQo1OeMKt53gg7vrro5+RN
         5zSF103uuXPbzTlfwQTyd2DksqEAPhKAwCpdl6rbaNchyk5EIGKjVL9X4NJoot5F0tas
         J9Yg==
X-Gm-Message-State: AOJu0YxjBtcCXb8cHbKhcETjmObLPFc9xF6/7zKYUDfhzdr0Pqb+6ssM
	pGG5BtWcDqTkfTA68JkNWszDK85xtHX0Hs7YjpQnrjz2PYIRByryw2zMyMICAJV6U7XXqPzx3eL
	/76G0o7CKlTU860hHUPaXJElyfes=
X-Google-Smtp-Source: AGHT+IHOfbrrLsfQ0WJ9O+pB66W4fj99OHCdWaY145KTCgZVpmaqeDZZriGqHKC5T5lJEs85lu9/p3ib8FKyy95nvus=
X-Received: by 2002:a05:6870:b009:b0:270:5320:2d6d with SMTP id
 586e51a60fabf-277c825d723mr8683853fac.47.1725397518053; Tue, 03 Sep 2024
 14:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731201608.1840977-1-robh@kernel.org> <CAL_JsqLzpDC42G35TDjgQpDCJhmy6_oQxG97uut9VKdYCHi_NQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLzpDC42G35TDjgQpDCJhmy6_oQxG97uut9VKdYCHi_NQ@mail.gmail.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Tue, 3 Sep 2024 16:05:06 -0500
Message-ID: <CABb+yY1W53SJ1r1yspQpaBjMH+JPC89yBM7G9+WoewSJgjD+Mw@mail.gmail.com>
Subject: Re: [PATCH] mailbox: Use of_property_match_string() instead of open-coding
To: Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 3, 2024 at 2:18=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Jul 31, 2024 at 3:16=E2=80=AFPM Rob Herring (Arm) <robh@kernel.or=
g> wrote:
> >
> > Use of_property_match_string() instead of open-coding the search. With
> > this, of_get_property() can be removed as there is no need to check for
> > "mbox-names" presence first.
> >
> > This is part of a larger effort to remove callers of of_get_property()
> > and similar functions. of_get_property() leaks the DT property data
> > pointer which is a problem for dynamically allocated nodes which may
> > be freed.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> >  drivers/mailbox/mailbox.c | 22 ++++++----------------
> >  1 file changed, 6 insertions(+), 16 deletions(-)
>
> Ping!
>
Acked-by: Jassi Brar <jassisinghbrar@gmail.com>

