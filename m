Return-Path: <linux-kernel+bounces-379257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463ED9ADC19
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:22:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 925C9B22431
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259F417D340;
	Thu, 24 Oct 2024 06:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NHzdRQVQ"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C2617B51A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 06:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750967; cv=none; b=P6HnG7+AAgOgmP9OBaSalLm2/8rCXxTnzdhH78OniLj6fAunlgUyMM42TuLK42npDTbq4lNrD3rXo0JHG76pCOPbN1BbYEMuuo4+dh6cifZ/6ieS5rF/OCp/mWh5A1ua5EJbCj81OU5UqZ31rzQk2W0OrXCxMVyrjD48ND5PLkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750967; c=relaxed/simple;
	bh=Uhdy0crX7jd32UBgalA4Mp+yqTEKMoy5/aHTmMprIHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hK1vu/MLshBGQ3IT2z3G008OzKly75BGaf5qsKuan2C3MO49H8LPuk5BRmSXufUlCVLi/t7z6HsXpgMvbFKCJpzAVs5osEMpmhWsKG8LSJnMCRjqhqBbFeUmC7lTv40IIpasmFiSIx7pFg3dp0EkiVkWxD1BPnimREYE5ecgCEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NHzdRQVQ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so1136550b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729750965; x=1730355765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uhdy0crX7jd32UBgalA4Mp+yqTEKMoy5/aHTmMprIHY=;
        b=NHzdRQVQYtWCnuTqL79IZvLUsJ0/kIZno9nexSJHfepZq7RhrD81twOZ8yTTHp/x1z
         L4Gy7b2Phi6sGipx9l7JSfQ6oWQJsbChsC5nfM/TlNaNDhtNTs6x8bczCljVPwkSMcOa
         iS8OOUuT1fnYotH5pWwoaWiNDcqr+4Gt6/0Xs3jeV3JOvXe5gXpHXGMJzHZVyW4vmwUI
         wcfoykSV6RrNEiTtLIVi4gOCRHqG8R2zBLwzOgWnHzLi8GRjX+AcMtQJ5MWJzSCaJp1F
         TSIsFSqKJ7yEf7n5kLYShaAKBbJ1UWsFjHTEXDT/TqHvLBpYVke9nZmRLxnSKuMkL/39
         FrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729750965; x=1730355765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uhdy0crX7jd32UBgalA4Mp+yqTEKMoy5/aHTmMprIHY=;
        b=LOK0152GH7SaPtd4tdQkxvjhMU6fGsFFUP79F+VqeTwR8EK3ab+WAwPZTMY1lMjVju
         VeoeXdYZNaAwoohsTPmkARrdM/MEJ5PD5fubGy/v+8SoBz+WAl0/A1txwU/3To6cr1sL
         d/y0O5aAsgUgVS8mQla2IppQ8XpDqfB354mVOsWUqsGBt0NO6oyXzYbKjBdl8FbjNQUd
         zctnFTzAgh/WyYPhlB3kW0A/FDxuLMKbt4RiDMotUaADl3pO0MbUE4ID4ni0E37dit7Y
         nRxOx7eYpcAMPz3AN1uBuifSTOgd9lkWDyGo6CPYZdfiB1bcv5DYinzbxRSXfLNEGWbi
         T5ow==
X-Forwarded-Encrypted: i=1; AJvYcCWKmfHDKhpLgYU4zLVhlqWYaWsE7kFBjK7Kfx3hqGz5Ovfr6O+g7ruIOVNpOwb7KNL+gL7P2Dj3IpmjQy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YydH0Q5GoQVLoRYKnZaWQnOPZEPGXJ+E56rvl9QYFb5VNw16gwF
	Dw1OcOQKj9hn9mFLbT/zokuobJc4NFHsBxmf7oxB6l5fVQXoJ77QHLshA950aXxEQp9rT7pFI4Q
	REaHxKRn9TfZl8llvpX8CjIoxj29J33jsWODP
X-Google-Smtp-Source: AGHT+IHER6S+oXayYMJOfU1uT2MMGdiQY9D03ESwl9edjBhrQ1nxNVeRSlMwT7VT0vKe79wJ+iS8Umue/ckpKLjd6Zk=
X-Received: by 2002:a05:6a00:888:b0:71e:6a99:4732 with SMTP id
 d2e1a72fcca58-720452dc06emr1742555b3a.11.1729750964614; Wed, 23 Oct 2024
 23:22:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023191339.1491282-1-saravanak@google.com> <7a8dede1-ef29-4553-9412-de8e2f45b860@notapiano>
In-Reply-To: <7a8dede1-ef29-4553-9412-de8e2f45b860@notapiano>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 23 Oct 2024 23:22:04 -0700
Message-ID: <CAGETcx_nSoVy-C-pt0Q3e-4wsU--9MJKoxr2ZSUfVq1UBxMjow@mail.gmail.com>
Subject: Re: [PATCH] drm: display: Set fwnode for aux bus devices
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Jon Hunter <jonathanh@nvidia.com>, 
	kernel-team@android.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 12:56=E2=80=AFPM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> On Wed, Oct 23, 2024 at 12:13:36PM -0700, Saravana Kannan wrote:
> > fwnode needs to be set for a device for fw_devlink to be able to
> > track/enforce its dependencies correctly. Without this, you'll see erro=
r
> > messages like this when the supplier has probed and tries to make sure
> > all its fwnode consumers are linked to it using device links:
> >
> > mediatek-drm-dp 1c500000.edp-tx: Failed to create device link (0x180) w=
ith backlight-lcd0
> > tegra-xusb-padctl 3520000.padctl: Failed to create device link (0x180) =
with 1-0008
> >
> > Reported-by: "N=C3=ADcolas F. R. A. Prado" <nfraprado@collabora.com>
> > Closes: https://lore.kernel.org/all/7b995947-4540-4b17-872e-e107adca459=
8@notapiano/
> > Tested-by: "N=C3=ADcolas F. R. A. Prado" <nfraprado@collabora.com>
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Closes: https://lore.kernel.org/all/20240910130019.35081-1-jonathanh@nv=
idia.com/
>
> Hi Saravana,
>
> the issue faced by Jon needs the exact same change but in a different pla=
ce,
> drivers/phy/tegra/xusb.c, which I posted at:
> https://lore.kernel.org/all/f979aff2-34f4-4f6d-bb9a-03a02afc4635@notapian=
o/

Ah sorry, I was in a hurry and missed the fact it was a different file.

>
> So we need two separate patches, one for each issue. Feel free to add tha=
t to
> this series. (I could send it myself, but I think it makes more sense to =
keep
> them together)

Sent a new series. Thanks for the heads up and the fix for Jon's issue.

-Saravana

