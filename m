Return-Path: <linux-kernel+bounces-361007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BF8799A24E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52A53B23603
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EFB215F77;
	Fri, 11 Oct 2024 11:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m10zUVUH"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9692E215F58
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644736; cv=none; b=XOJ2+Y4mUoAx48vezKegVi+DC4tGWfLXK490gKhOx8OIlgNBEHYYJcehzNzAKN6m6xw7pp2M2eAJz+STrdyOIDGkYpHHkM5lPi+pY3odOYtkWiRgGeofVE895u6rD+EBiKX0MCx3X1gH9lPrN3n2DYS9KIhFbUJeaFxIPY/C4XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644736; c=relaxed/simple;
	bh=6h8GvJLsX+Sl7OCFk+Nar08nJuxRjfgTxwSgImIeTYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qx5TA/P6ywzqcLHfZiyN87hogK7rMU6EQpAj8uM8rFRQEO6dCwdcKOOA3ksG6nQgqqrTMZh9RIkZvPvM7LBqiVvaAlbuthLC9ElCU4s848PnDBIQSJQZ/7YWueDM7muJWfVFr7+WIYsPblqL+2tExOkF+Z3uwbS4TH1U61h0BM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m10zUVUH; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2fadb636abaso18243381fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 04:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728644733; x=1729249533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kbOpiasA0JVBn4x9cSd301RQLbZlOSTgBQKKdmq+rw=;
        b=m10zUVUHIFh4/6uLSU6ThLyKSkKnyE47gawCGJ4mR1w3LAWwe5FW7CARntqiT1tUM0
         l+maKGFVm16FYvkvXIz0WnCWksn1mwCcXCYFBUXNPYzcXBezNBLjOnp+1xk1smOXDxJn
         RKVSfd9kGP5QCsUxvETAbNQKEq6jclDIciK8Kvvh5C67/T1UjN0L7A5ZLEVxY3IT3VeE
         nEsyK0Gg+fMbsTKvuZ4sq6AQQrRbOq2pkBxep0a+bzVwKPje2PBhhVFeUV9PnHHPEl+w
         XekjFaMyi+Xo0Zb2wLJoPHqOcyxlo2DqZO04NL+C8KyWRSOiOmIBcU/7GaHrgBGriL/5
         GALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728644733; x=1729249533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kbOpiasA0JVBn4x9cSd301RQLbZlOSTgBQKKdmq+rw=;
        b=ezfEnkQOfuUO5nEu6aldKwXU0CQHBnpzuVws6fAr+1e0o1r3qZDcqhxtk+LUo03oas
         pa2qci5YUB/i60U9nbMOYbwxoPo2Lg1yGs2yFlXOhC9jA76GGVd1KGNHvBHfXd3J7gGr
         30MxSMP7r+ydwfO8dKj8KTE3x90n1MLfqQYTIgJ8Z8sYQPFr+He2Sm9Tsa7+fwNJjbxd
         Cus12lnP4iLUDEJayxVScSeFKsVZz5sh87kiRCk5a2NpESvG5icg27TZiNnh34WPplWL
         cuu6WGWH3RUbKH2xAL0HWr0CBkjh/yNcd8+PHH3zVRmpqa1fYCQnrp4ljm2VtRXyR0C9
         DuiA==
X-Gm-Message-State: AOJu0Yz0KzuqGfNsh4vGPKumAuPZtJOXUCUV9mzgQ3JMEzFfZQGDfKgK
	zvX/SrmTZe99wig2Wq3dbBPp0fsfWKzvOKLwLz9zdhSMMAKpL96Elub8Xse7LjNwCGMeBdA+XwB
	WDUUbZmQLk5Fi/3J44rt/XbWSzRc=
X-Google-Smtp-Source: AGHT+IFG8A1O1crUYuVjiIX6ubtnKN9zIsHPvYsElRhWpf32TC8GUZgVzHZQfooXVAgdqmR/dpUtsZPjbJv9MYuu2J8=
X-Received: by 2002:a05:651c:b1f:b0:2fa:c49b:1106 with SMTP id
 38308e7fff4ca-2fb32b42172mr11064571fa.44.1728644732395; Fri, 11 Oct 2024
 04:05:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007041353.4756-1-suravee.suthikulpanit@amd.com>
 <20241007041353.4756-3-suravee.suthikulpanit@amd.com> <cc44a5ca-ddf9-ca7a-93f8-38bf26ac1f1f@gmail.com>
 <7accc5fa-7e0b-4cb1-abc7-debc451285b6@amd.com>
In-Reply-To: <7accc5fa-7e0b-4cb1-abc7-debc451285b6@amd.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Fri, 11 Oct 2024 13:05:20 +0200
Message-ID: <CAFULd4b12ytimeSiePmwppyEjQHQMSikHuG2pO7DhxMxwu3z_Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] iommu/amd: Introduce helper function to update
 256-bit DTE
To: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
	robin.murphy@arm.com, vasant.hegde@amd.com, jgg@nvidia.com, 
	kevin.tian@intel.com, jon.grimm@amd.com, santosh.shukla@amd.com, 
	pandoh@google.com, kumaranand@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 12:22=E2=80=AFPM Suthikulpanit, Suravee
<suravee.suthikulpanit@amd.com> wrote:
>
> On 10/7/2024 9:42 PM, Uros Bizjak wrote:
> >
> >
> > On 7. 10. 24 06:13, Suravee Suthikulpanit wrote:
> >
> >> +
> >>
> >> /*********************************************************************=
*******
> >>    *
> >>    * Helper functions
> >>    *
> >>
> >> **********************************************************************=
******/
> >> +static void write_dte_upper128(struct dev_table_entry *ptr, struct
> >> dev_table_entry *new)
> >> +{
> >> +    struct dev_table_entry old =3D {};
> >> +
> >> +    do {
> >> +        old.data128[1] =3D ptr->data128[1];
> >> +        new->data[2] &=3D ~DTE_DATA2_INTR_MASK;
> >> +        new->data[2] |=3D old.data[2] & (DTE_DATA2_INTR_MASK |
> >> DTE_DATA2_RESV_MASK);
> >> +    } while (!try_cmpxchg128(&ptr->data128[1], &old.data128[1],
> >> new->data128[1]));
> >
> > Please note that try_cmpxchg inherently updates &old.data128[1] above o=
n
> > failure. There is no need to update value again in the loop.
> >
> > Please also note that the value from ptr->data128[1] should be read
> > using READ_ONCE() to prevent compiler from merging, refetching or
> > reordering the read. Currently, there is no READ_ONCE() implemented for
> > __int128, so something like the attached patch should be used.
>
> Thanks for pointing this out. I will introduce the attached patch
> separately in this series on your behalf as author/sign-off, and review
> the current code to properly use the READ_ONCE().

FTR, for the mentioned patch:

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>

for Co-authored-by: tag.

Thanks,
Uros.

