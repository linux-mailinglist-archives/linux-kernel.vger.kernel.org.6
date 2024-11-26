Return-Path: <linux-kernel+bounces-422791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D839D9E36
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 21:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17051605CA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 20:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ED91DE8AC;
	Tue, 26 Nov 2024 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Kygr4UHk"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6C81AAD7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732651572; cv=none; b=nonMqiALQyk4l8ms5VZPA77EuAZX/w7YC5e5UsUstNofUO6lAkDbw48wLHPrE42aD25Aad8YIxySTSe24dn+Qba5MfMJN9VC6XqG/Eyld5gXoubLcP2/u+zGc6rhdmnC6QXg2pRvDiq+jpRUzAaq+6sXQldJpKB6aSCfy3Wzhrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732651572; c=relaxed/simple;
	bh=enFKirhtu7eBOSGfayRPvvrtBwtfiPFjvJOkR9Hv5ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZwzB45gpgR2Oj8JAQMMOD2INTNrskfqbJ6bYs07zzRglJPzpPWT5YrUCMN2wfz3CqmDL2Xxu8wfrUfHoYd1FW7KEBJWFpGOdqHN8BDyHTYYu4TlOkJglKVPbmhVGEpDH4er1Lt7//jPjUZxd/Va8iVfzlkWucXQUV2ilUvNOoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Kygr4UHk; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46687f60b73so42111cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 12:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732651570; x=1733256370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzbSsP/NQ+JOUcxvgZ/AqL7Yim+Wji2oxIvbRrTA9Mk=;
        b=Kygr4UHk+87nUxXesAMYac3O/zV2pHk46G29yOtKzelCJmrGYxET9jbF6JaZoGnfUc
         BnksjGeRN7oYjR3XxYdf3vIVyl5tDytpdSRBwNvEykt9CNJv0ffh5GrlXy/+ey4sMYKx
         nkvTiZTznCvCgkjiuec+smgurTc02msvHUI1/q9P+tBKXe/Friza6RAQu4SCAW8NdhsJ
         Vt2sgKOcZEnc2gKJnM2mLuVqnpbWTJepW+9J5+rKUw7p8BW/TPDqaUBsLdvOdq3NpRzb
         0/tG+3sPQkgtmZSTB5cZYkPdEju3GaJGIW5nAzFth2cIS+qxPNHmH+vl4GK4vDg3tXTv
         HpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732651570; x=1733256370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzbSsP/NQ+JOUcxvgZ/AqL7Yim+Wji2oxIvbRrTA9Mk=;
        b=LiiMZF9169cNew5HJfAVj1WRiECGE2We3mqjyJdV8x0n6qbqDRZglhQkURHltC1/mc
         kYb1UhGaKOXXUzq45Dat0Mf25ZFo7EiR+oDGARKjmZrnb7T5a1CQzU5L4oWmX/cWyqgC
         Yu2Opmm3OmP38EDMphth/NBjObpO1YDy9HWm69lO/Fo1lo2GU27wpDM53JW8c4BgnM4a
         BV8sijlUWLhwVBoWc1b1D8QzhpMBy2VuZnVRzy5VX0YKezs2vR4sj3TV/kO1OS53BQUQ
         8WgECOqeNq2/2tvK0VahSMmKioUx2l/ySiplbYRUKflpB77FIDweHA9PdK5WDACe/IOh
         TkGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVj5b/EHbDvQAehE0/0nfUmyvVs1r5xplB6zvPqqSDS7cVO9A6el/yJVkob0V8hXK0hqwsvJB3uJwNL70=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRZ/BnbLUKXEx1UE4liudsy/5k4Y8aBXap29p+sGJAB7xpMARN
	YHg1lcnngH2AT8kQXqmyAHHULWSPCjCy4UpWMHDj5arxYYVTcy9HEQ6iqUKhOHVqL7Bn2EJTyi2
	alrg/RiDLyaHsnAvzTMY8GTHzdfH8kr5gxCjt
X-Gm-Gg: ASbGncs0P5cDuYb9DqieCvgXDpSA1tTjmPa4qZF+sEAFntIjYl8olKDZzQJp27jGrw3
	nc9X5nu0cE5C32FST74fQn5okZqkQQhnYyuiFZoIjYrNrla/z5SoPq8+zs+dN
X-Google-Smtp-Source: AGHT+IFuVBOjAPRdRvYyb02vpPbNu3C+Bd4UhfXCn9UmN4u+jnOVD2XEbMjC1oyXPiQd8NB0rvD3jk0p0PmVGgND6xY=
X-Received: by 2002:a05:622a:1919:b0:460:f093:f259 with SMTP id
 d75a77b69052e-466b3e13498mr370991cf.22.1732651569942; Tue, 26 Nov 2024
 12:06:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241126184021.45292-1-cmllamas@google.com> <20241126184021.45292-10-cmllamas@google.com>
 <CAJuCfpH+B1HrzXtM_3+H9m8NPkTzAX8S4oSwhTEW+07g9JceeQ@mail.gmail.com>
 <CAJuCfpHdYPf-WgheBSCK6Md1WakEy_XCiPrw6xTFmPHr7TgnqA@mail.gmail.com> <Z0YdXqS-rARwYI5L@google.com>
In-Reply-To: <Z0YdXqS-rARwYI5L@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 26 Nov 2024 12:05:58 -0800
Message-ID: <CAJuCfpFZ3L-OvZEdhCipx17=A9yMFNWfuaWVN-BDrbXjce=v-w@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] binder: use per-vma lock in page reclaiming
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 26, 2024 at 11:11=E2=80=AFAM Carlos Llamas <cmllamas@google.com=
> wrote:
>
> On Tue, Nov 26, 2024 at 10:46:03AM -0800, Suren Baghdasaryan wrote:
> > On Tue, Nov 26, 2024 at 10:45=E2=80=AFAM Suren Baghdasaryan <surenb@goo=
gle.com> wrote:
> > >
> > > You did add a clarifying comment I asked for in
> > > https://lore.kernel.org/all/CAJuCfpESdY4L_sSwiCYVCX+5y1WOuAjLNPw35pEG=
zTSyoHFYPA@mail.gmail.com/
> >
> > s/did/did not
>
> Oh, I added the comment to patch 5/9 since it fits better there (sorry
> that I forgot to mention this). Now the kerneldoc section reads:
>
> + * @mapped:             whether the vm area is mapped, each binder insta=
nce is
> + *                      allowed a single mapping throughout its lifetime
>
> ... and the vma check now has the following comment:
>
> +       /* ensure the vma corresponds to the binder mapping */

I think the above comment does not explain the race we are trying to avoid =
here.
Something like this perhaps:
/*
 * binder does not allow mapping of the same buffer more than once, therefo=
re
 * alloc->vm_start could not have changed since the buffer can't be remappe=
d.
 * Checking binder_alloc_is_mapped() ensures that the vma is mapped and sti=
ll
 * covers the same area.
 */

> +       if (vma && !binder_alloc_is_mapped(alloc))
>                 goto err_invalid_vma;
>
> This was the feedback right?

