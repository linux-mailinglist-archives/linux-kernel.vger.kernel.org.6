Return-Path: <linux-kernel+bounces-512650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA938A33C17
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:08:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 931CA16738E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 10:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D37211A37;
	Thu, 13 Feb 2025 10:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QikCWkuh"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6641B21AD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739441309; cv=none; b=ZA+nLd66EI0RDrgKHz41VXvLTA/ZaaTnUPM2+f5dHRzIpsgoqbVhXfQ8UvJM+nwxs2KcX3TBXbw/XSlQNVc0tB+hTzGYjxPTQ636jr40Gyy76pV8QJ8oxWZLnnhfz6zYqv39ef1HLeEIsxRsKWr0/UKIgKTTIIfugBme+fJRroc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739441309; c=relaxed/simple;
	bh=MPp5OyNG8huFeTnYvXndU5Mwduu7zQqNOU5UvvAsCkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDp0fx4GLhryPVbH4IncyvDyAl+09kuDJX7Ry5CveY6z1pvz0xQMfFE0CywToXGRRLi1cZSENi1HhZjDEyxRR+bx86H8TAWhX4Ck5PALBlsUXPN7Zn+k1LPl3tIYD2k4/K72qmAimWaGMOleaf+CkUwg138rBlwy4iwWLuBkGTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QikCWkuh; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e4419a47887so536140276.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 02:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739441307; x=1740046107; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lwzp97aD2QWWDIwey7i2KBlb6xs1j2oYUuVqrLaH8/Q=;
        b=QikCWkuhm0qdcLNebI4nTy4kTbUCqYS6jXhcgbpuP/D5qt93N41mz4VW1ADk8GbQJ5
         V/7GyKmGZzcUjj2N42zrb/FlmRVwynCz1bQ5DmdXsd3wziV0YbofQ/YfRl/kw7E0U/g7
         ZveXwp5ZLsBv6BNiFS6ZWeeYQ6pvPxgnrHXZeX6pe4PuboDZsWsqzDpzYf80BqJUoNXW
         /VmkrnSDYJ7huSq2Qo+EvgCYA+bYWAsYIox6yAdhGALaqLCxj0MyVpWsz5lfk4xHTtPp
         1F7qccXvMtZcJTeol4ilrhhoF35J8pT0Oucasm9aqbmUlDUfcW/pmZpA4Zp++FJmf0Bu
         KHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739441307; x=1740046107;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lwzp97aD2QWWDIwey7i2KBlb6xs1j2oYUuVqrLaH8/Q=;
        b=Sx8ZHdYF4V4Zvyante1mVhAsgCB5N7tlbc8OpQtYpZeJnQ1nnaHPYPx1cmCkx9ptIR
         eHAUPkqAFAIdqviLn1caT2g8fIUD0DKBmvaC7iVeQ+ztI+1KCHJPmg5gm22OoAKz+PNk
         fGHs+k9740tgxplyclnap53yjD7o6nUpLpC8i/ozyprZSJ31lr/zkTrWT+EoKSgb3m50
         haM22oI2sZJaJN5hR7wETZQTe1U8RA264ffNxSr/GXqzNHogKzBFt+xstukQMfaAjUaq
         QGKYA96wDgnMkXT9NlaXxwp85V8AMWC41r3KJztMaglGUgpxeCGCeNU5FxDBywxa1uvO
         DkQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGMpyaQHo7dh15+wG5QAARGuQH2WsDzwcmwf7vGwnzLozwRCZ/Mu0dQxqUzNlcRinjJ7st1Yvcz0LXeC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3BrgsgBWvw23pFztm6QSjtCudm6YpClol+fmULDZJT19rtSxV
	FXPZ19REoU+SyfYge8PH8QphCjBalLtKaNg9U3IaAH+IUPlyCMXgVXghar8+FLq8wfHE12u2T7O
	PLUpo+WZIcA835wiHcBXcXM/UEYfCgrAp0BGi
X-Gm-Gg: ASbGncsMrfdVTFMW0JspH8d+kceRkN0UbBEkvSz/d33kx2CnMupgEdPg/iXgm1u5jqd
	j78t4Ovl0E+RYIax3seZz/CTQqexMe6bxIPwzdMlDgIZFjN8Kjmu02qZj3mflOeCfSyFtGa/t4Q
	==
X-Google-Smtp-Source: AGHT+IGy4AJIYMekfNAzT8Z669VTj2mjB/mXyVh8a7WY2PmXyOtQ1vdxc4L5aI9AOjbt6SKGda4JhxZUJ0EYYviQToQ=
X-Received: by 2002:a05:6902:1b0a:b0:e5b:2472:f4dc with SMTP id
 3f1490d57ef6-e5d9f12cfebmr6415584276.29.1739441306723; Thu, 13 Feb 2025
 02:08:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213114400.v4.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <20250213034413.3808375-1-chharry@google.com> <2025021325-faction-upward-6395@gregkh>
In-Reply-To: <2025021325-faction-upward-6395@gregkh>
From: Hsin-chen Chuang <chharry@google.com>
Date: Thu, 13 Feb 2025 18:07:59 +0800
X-Gm-Features: AWEUYZk_Ij80igDm-p1nzK0NlpnpJH5yG0GRLFkOsZRlsL3i7fgedcKSuNj0Q00
Message-ID: <CADg1FFc9_QH10UqxGqjf8hnJkHWjhy6EMPrfDCgvBx2OdOydLg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] Bluetooth: Add ABI doc for sysfs isoc_alt
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 6:01=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Feb 13, 2025 at 11:44:01AM +0800, Hsin-chen Chuang wrote:
> > From: Hsin-chen Chuang <chharry@chromium.org>
> >
> > The functionality was completed in commit c04f2e4f4ea1 ("Bluetooth: Fix
> > possible race with userspace of sysfs isoc_alt")
> >
> > Fixes: c04f2e4f4ea1 ("Bluetooth: Fix possible race with userspace of sy=
sfs isoc_alt")
>
> Where is this git id?  I don't see it in linux-next, are you sure it is
> correct?

This hash is the first patch of this series. So I guess I should send
this patch after the ancestors are all applied then.

>
> thanks,
>
> greg k-h

--=20
Best Regards,
Hsin-chen

