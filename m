Return-Path: <linux-kernel+bounces-348221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EB198E44A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CCF91F2383C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822F1217307;
	Wed,  2 Oct 2024 20:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NWhquqYy"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAD51D1739
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727901545; cv=none; b=o2Pfw+9xwV+MsRw1c4g7rjmhPZxit1GB/klQknMaIWjn+uG1HPaBrXt9l0YFotA+e3FbVd+svm9Lqw3LaOgSCVoNlWKs7rd1QJrZApny0fn5JOavWxYfTmB7+K/0SQGc2uS/PoccM4MH7lU4Br3fKFXXJ+tG7eoCQghr9aOWtVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727901545; c=relaxed/simple;
	bh=DNL795QT+5z9dTnnNTLOOaupqBSSBh4UNsoHd+L54qs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B7LzUigHAtcuH5bsmFskuU1KiE+dMGmWal3EK09B558ezVJDBRTNzCBDwlvalS9LKUrSvKNhTWCuGUAYgE1+0OzHdLomQ6uTnTACscfmGa2aKpqF+2PpO3WY8NsBP7TYGXl4kDz99+bCbBe8Q3NptRuB5j9eLvWfadid35v38rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NWhquqYy; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e18293a5efso198084a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Oct 2024 13:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727901544; x=1728506344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kWetV44sYoIfr8WFLB8kLqzkS6u8btS/1XZjRCqxU4w=;
        b=NWhquqYypdU193QMMOnyrAu+6Q7J4iVP4TJOr0r3MuBcsB1frV4YZV4x1XHAnKu1QR
         6lUlBRAYjfJ4XnAfGvN07/fgGg4rqNeXLcFhEldlJ7bepDU7BnTAVpObieiuKe87mty0
         cTt+T6K9lj5V0wCrClmCJesysEcN/j30m/MzlwBCAY8CIz7xaILQoMKS1xeM/4MCqlEp
         ys68V/cG3Jhks5qsArCn0R+pe7+rbFrG9cvbQwyYIsuMrXlzaYwxNClPv2bkdPzlEepV
         8b3zQX5AnotSH6HMSbfbUENEP8nDtVGkktNkitlDyqap1KRRxpZ2Pfc5d52AiHOiGyr5
         QWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727901544; x=1728506344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWetV44sYoIfr8WFLB8kLqzkS6u8btS/1XZjRCqxU4w=;
        b=VhLGBwdLBj0oOcSa5MXTAW0OB9MAFr53WQdx04pN+FKzZ4X2mBOkZrLY8Xl+EyK3cs
         0P2EvctuqcXKSt6HeB7cOy/WMRuUs+pYf28aun1iVEXiWUPfm+YhabKEx23wULnjw3Cy
         QooPAMJFf2SffhxtWqtGmY4jC+D1NYB1wmsZD9O5XwdkshzlGvNCtJ4h+bxwjaSDJFBh
         aM6DY+VOz+T0bem5gvPSjrnFT2UN/kPAxqXxw7W/HoCkBkrjTgt0sTW/tOJN8qWVqMbx
         HYg8jy/eECMEU5ZE8uL4AzCMdxWb+Ia/rylGza9bsC4fQLt+qdY71+OckumFgfYmEanc
         Xk6w==
X-Forwarded-Encrypted: i=1; AJvYcCUlUxn9oshHKT9TbUvlc2uJuty/X5fZ54IuEQSAmTMK6FI0lA10WcPMzwgLERhxY8X7g+fLGXup1dOWb1E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuWE3UNytgFp98DMf1E8IBymliSfuTNIDHITnTXJ2b4+7OdX0K
	fk8tW1Ommu9uxUpOt/N+uAqPF4NHSrgXC93z0mJdFaE3vsHbr18HCvCZAjD2nUm2buDgIbX9n7B
	hLUkOTYlEj2iNg+X7e01LwxMwPHa7iFgeuDEk
X-Google-Smtp-Source: AGHT+IFhE1Kcw49fp32iK8EJ08bwBvxPENFJ/y+V3smbFXnYrUNi58Zv3vQegqoOoa07QG+mc3zJE7gzGCPuyVEk1Mc=
X-Received: by 2002:a17:90b:1195:b0:2e0:8740:26d0 with SMTP id
 98e67ed59e1d1-2e18451d6a6mr5558658a91.2.1727901543372; Wed, 02 Oct 2024
 13:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910130019.35081-1-jonathanh@nvidia.com> <2024091152-impound-salt-c748@gregkh>
 <d89c89f8-0036-44a4-8ffa-ea89ed576a9f@nvidia.com> <2024091627-online-favored-7a9f@gregkh>
 <b1b67db0-3b9c-4d96-a119-fe3fcf51b6e3@nvidia.com>
In-Reply-To: <b1b67db0-3b9c-4d96-a119-fe3fcf51b6e3@nvidia.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 2 Oct 2024 13:38:23 -0700
Message-ID: <CAGETcx8E9FddpwMO4+oqeEc0RVMLbUOs2m+=B900xzrLvEkSXw@mail.gmail.com>
Subject: Re: [PATCH] driver core: Don't try to create links if they are not needed
To: Jon Hunter <jonathanh@nvidia.com>, 
	=?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 11:30=E2=80=AFAM Jon Hunter <jonathanh@nvidia.com> w=
rote:
>
> Hi Greg,
>
> On 16/09/2024 18:49, Greg Kroah-Hartman wrote:
> > On Mon, Sep 16, 2024 at 03:50:34PM +0100, Jon Hunter wrote:
> >>
> >> On 11/09/2024 15:32, Greg Kroah-Hartman wrote:
> >>> On Tue, Sep 10, 2024 at 02:00:19PM +0100, Jon Hunter wrote:
> >>>> The following error messages are observed on boot with the Tegra234
> >>>> Jetson AGX Orin board ...
> >>>>
> >>>>    tegra-xusb-padctl 3520000.padctl: Failed to create device link (0=
x180)
> >>>>      with 1-0008
> >>>>    tegra-xusb-padctl 3520000.padctl: Failed to create device link (0=
x180)
> >>>>      with 1-0008
> >>>>    tegra-xusb-padctl 3520000.padctl: Failed to create device link (0=
x180)
> >>>>      with 1-0008
> >>>>
> >>>> In the above case, device_link_add() intentionally returns NULL beca=
use
> >>>> these are SYNC_STATE_ONLY links and the device is already probed.
> >>>> Therefore, the above messages are not actually errors. Fix this by
> >>>> replicating the test from device_link_add() in the function
> >>>> fw_devlink_create_devlink() and don't call device_link_add() if ther=
e
> >>>> are no links to create.
> >>>>
> >>>> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> >>>
> >>> What commit id does this fix?
> >>
> >>
> >> Hard to say exactly. The above error message was first added with comm=
it
> >> 3fb16866b51d ("driver core: fw_devlink: Make cycle detection more robu=
st")
> >> but at this time we did not have the support in place for Tegra234 USB=
. I am
> >> guessing we first started seeing this when I enabled support for the t=
ype-c
> >> controller in commit 16744314ee57 ("arm64: tegra: Populate USB Type-C
> >> Controller for Jetson AGX Orin"). I can confirm if that is helpful?
> >>
> >
> > That helps, I'll look at this after -rc1 is out, thanks!
>
>
> Let me know if there is anything else I can answer on this one.

Hi Jon,

See this.
https://lore.kernel.org/all/c622df86-0372-450e-b3dd-ab93cd051d6f@notapiano/

Ignore my point 1. My point 2 still stands. I got busy and forgot to
reply to N=C3=ADcolas.

I'm fine with either one of your patches as long as we define a
"useless link" function and use it in all the places.

Thanks,
Saravana

