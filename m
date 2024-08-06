Return-Path: <linux-kernel+bounces-276972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22464949A8B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 23:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3B2DB21539
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 21:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC0C16F84A;
	Tue,  6 Aug 2024 21:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OFKm6ezG"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B6B16F260
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 21:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722981366; cv=none; b=CO9xt0vPlts/FepLIabyRINIuIZKiW+Da7oTgNwQwjVo8pXnw5688YDJ25EXiY/gx76zQX422VzufakoqktOVtFfNuO8amVF6Xnf1Wfuq4QbINCF7HhB7yCcixA+n9Ja9tRI4g24ZfTBz9lKBzBRUz/KHCMUzCpmw4LOyz3/09M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722981366; c=relaxed/simple;
	bh=Jvd6d/g8j8GNeIP/2vY+rysLx4jcS6wFfVxuDrV0hx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7qC/P+jGqPLVQtb89mqoVND6a2CcFKN2A9n9OjgLlDIIKo0BP4/3gf/v+mfLsjADuFss6ccEmNOaKmcQLo/zMJ/QUACaNwihgxGmPX662jomdipgfg0N8Y4TgIcRL2oE4z32vhUd9gOBEJcA1ZT+uUk8H2+xQXrfpklze9gVGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OFKm6ezG; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-664b4589b1aso2212537b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 14:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1722981363; x=1723586163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kDAjrM4/RIRi3K/tRUnjq4ndMEWl1uNkteCqHbi87aU=;
        b=OFKm6ezGMCrq2e2n98ivl3PGtPJTt5SvKEFdxjf/Ti7ExV4gBvYc8fdu7bHO4S/09W
         j8XqNmghcx3dQ2IEYPxboyU7l8u2XhHeQw44dX6rOKPT89Hkm2fheeSL/Za6h/HF568j
         fwbgpP6AuRLVaN0WaiCHuw0qBr4BA7oDgaL3/uLed8aKE6wBafj0vbHj8danIV59rWck
         IZDD5jQP2dTfdxOp0/zYee6qq6tki0dfNKZtDA20BAnzDN2++6fgfuRs1iBnPiNoK4JM
         GGgpWwiKai/5/J1gZGMYi+iUEOi7MokMPcgtbBKB1Lr1vDjGokESAEKIrwx/J93m+8fo
         wUfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722981363; x=1723586163;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDAjrM4/RIRi3K/tRUnjq4ndMEWl1uNkteCqHbi87aU=;
        b=SCSrhAINB+c0BYfAyKUauRTeBHYJv0vi7HJEarb72gOVJzdZoI9U/wlSNjMPYcdit6
         7DT735ORfKhZo/xfud6Cn/wRUhKCDJ3vUFLjZ0bBH/l2ZIeYWweRhzdqGgAZUR++FkwX
         RHyNOmAW+jSBQxKud218yZ44CbciU1Udk752DmaA5P9ClubW1MaGoSriPW889K0cDZEV
         yS7bGs+DVN8TIEybpzSLS+f9bilZOWJIbb8ZOrpDHuj7cdgvBldpIjiIvETSLG8DhuqF
         mWpsxWr6gLQMvLv3jdcUz728CeH+vmQcmvvZk5GuG0Bxn3/PlbgHfCvqWtdc7/iz7jyv
         eR+w==
X-Forwarded-Encrypted: i=1; AJvYcCU8guS27PS7pWiprvzLE9bXX6GqVN8mcFwZ4EdAki47TYgNjIgV41DrfQNCgTO2Zrgwp7H9RnEYkgcDuO5kXVIP/SevVWJy1SdE0N8M
X-Gm-Message-State: AOJu0Yxs4LvM4zyt4DrwjvRoi19Hlo1SJAGw/fVFnVfDYXKS57z80Sok
	DkyBQIeC5AFZE2yruuYjFq8og9o6Vaww3+jvFhsVViB6TgIaDbAunu7I2AeCBw2nhqptl5fZCQl
	Cu8bNHA/4k3u5gsblvOUSv+sr+ijrhDyest5W
X-Google-Smtp-Source: AGHT+IH3dkrRfOJW0prmnIwdEA2mFjIA4RWSsRtLuzMPO64WTfKIRWGNz9sO84SFriTXfQ/Css9cuJZbEfdI7+2HQNI=
X-Received: by 2002:a05:6902:2782:b0:e08:6373:dfc8 with SMTP id
 3f1490d57ef6-e0e877f5902mr158689276.23.1722981363600; Tue, 06 Aug 2024
 14:56:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806065113.1317-1-thunder.leizhen@huaweicloud.com> <CAEjxPJ59=rHFovk3scmkhLuiAdu2uinGiua60y0naJ0e95GLmg@mail.gmail.com>
In-Reply-To: <CAEjxPJ59=rHFovk3scmkhLuiAdu2uinGiua60y0naJ0e95GLmg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 6 Aug 2024 17:55:52 -0400
Message-ID: <CAHC9VhTWye8Pm3EUr-Fy-mxq+6H1ThtAekqZd0nXX70f8xP5rw@mail.gmail.com>
Subject: Re: [PATCH 1/1] selinux: Fix potential counting error in avc_add_xperms_decision()
To: Zhen Lei <thunder.leizhen@huawei.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: thunder.leizhen@huaweicloud.com, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Nick Kralevich <nnk@google.com>, Jeff Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 9:26=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Aug 6, 2024 at 2:51=E2=80=AFAM <thunder.leizhen@huaweicloud.com> =
wrote:
> > From: Zhen Lei <thunder.leizhen@huawei.com>
> >
> > The count increases only when a node is successfully added to
> > the linked list.
> >
> > Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
> > Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>
> This looks correct to me ...

It looks good to me too, unless I hear any objections I'm going to
merge this into selinux/stable-6.11 and send it up to Linux during the
v6.11-rcX cycle.

> ... but I also notice that the caller is not
> checking or handling the return code for the -ENOMEM situation.

Good catch.  We should also fix this, ideally in the same PR where we
send the count/len fix.

Zhen Lei, would you mind working on a separate fix for checking the
error code in the caller?

--=20
paul-moore.com

