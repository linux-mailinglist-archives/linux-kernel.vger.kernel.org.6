Return-Path: <linux-kernel+bounces-186527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE04E8CC538
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7501F21E82
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AD71420D1;
	Wed, 22 May 2024 16:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PslpeSsv"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A121419B5
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716397074; cv=none; b=EwUpA3CNoAq8eSd7/1MJUV3CywIUkM4kZcEAg9PjvcQxuKU8+nn7lO8LbF7yp9H5xKbzwdJCrDRmUSBRVYgDHxEONhzZV/jWdX/D0uZ+Arx/oCbVY6KCcIy5ndLMVtdMnxhHMpvhB3Fc93kToSEI7UONRVK/RIwkfYQOrw2lrOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716397074; c=relaxed/simple;
	bh=x6ol8NNtqyR5N4adBohXI5DIsH4OG/KKUJhcyxsPiB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qOqhAF5c48ACmoYU+/j5kH4ZgPNoWmDmzDHB367j+FghthXTKAVgOVXtcJ1OYysGYOPPZgd67Wl5O1lLWQHtb1uTccqHRUT8y0+zA6u41xrcC5R/HC0vZVrV/yjEOCw6g0ET4o8Zr2OMFD52PwAY820ry3XqVWyXX4nzGbakHU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PslpeSsv; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51fdc9af005so10112467e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716397070; x=1717001870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVqQilWnEvaPMm9v3i+xshWzcKoqdVjetPe0efHlOEA=;
        b=PslpeSsvPr+wJ6XlbzslXgcG1dsd0Tv+C46jiugDVvdTQTRLjrqb6fPaNyTyttdLGM
         +2NnM5AIwI+Ieu2uV6rJ21ijHy5bBsvsvZDZam0bpBZWcGsGFRr/Sh7crn0MYqMDqDWO
         XX2FvRBvbIDP+eP1FGqJvvy87eX2joocL1uN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716397070; x=1717001870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVqQilWnEvaPMm9v3i+xshWzcKoqdVjetPe0efHlOEA=;
        b=X9qWgxz24UHdHcGseBlyMgpbnluNSbc1XdSpm2bwU8kRFK+yCeo6nZrHrOwAvQU/iA
         r5P34k66YpAv7nWKAwglqlzcCGfshXCQqhF+Yii++6XDs2eL7hsBiuqyebU8oHz5AHIB
         vUAmeXPZOFevch589QfCRivrkYjrNHIp6Lb9th4mbucmlhfam1t/N4TEjKa/rsXCt9QF
         9muEzJlb4XDf/aBUoXx+u985U5Mhle0/3TdnQ5FzDAtQnHA3vOsCF7W0dosQ6oBVzvSZ
         8UqGvr4CZW71AoR2szuwRR840d5vp7wXnsvkTgk9TOU4noK+a6WyE39Vq8Q+DqgkMfmN
         /O8w==
X-Forwarded-Encrypted: i=1; AJvYcCU/vAiP23zxTkPZnH5zK5NRXhJl3p9a+t7dHQYuug/DXdbQiInZtF5oXVzRDZRdM7EqFwUfv0qULjpot/1+SNallA9Nxh9Bwif/zgGv
X-Gm-Message-State: AOJu0YxZBVMgCXZKNMJdTmneaa0OCXKu6eFkRFmio9vVEtkGoL0h/Vea
	dkBcXPFVJIswBUTtQwUPJdh8usGrG3DtvAbE25/OPBFAUyQOAo5l4Sphr+A+MmOLBGDFfsGiOER
	xV01WYKs7/gf58CzS0G8we6t+wrmCNnXS4ck=
X-Google-Smtp-Source: AGHT+IGrptWSdMdPR63//GttFSx2aUNf30uQrwxec28DmTObbvHKZqGgtlSu6ewyMoM0P1HhEuZ0NmwvWHhLNI4pUjM=
X-Received: by 2002:ac2:447a:0:b0:523:9003:88a0 with SMTP id
 2adb3069b0e04-526bf82caffmr1833740e87.39.1716397070517; Wed, 22 May 2024
 09:57:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516174357.26755-1-jim.cromie@gmail.com> <20240516174357.26755-23-jim.cromie@gmail.com>
 <CALwA+Nb8EKBRk+1ejxWhRBhoYf=Arge5TvA-mPzDD95Am+7pYw@mail.gmail.com> <CAJfuBxxhTzOOBz_kTc9APGVw==r1fkyk+rdiri3wJAYJZSYoLQ@mail.gmail.com>
In-Reply-To: <CAJfuBxxhTzOOBz_kTc9APGVw==r1fkyk+rdiri3wJAYJZSYoLQ@mail.gmail.com>
From: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Date: Wed, 22 May 2024 18:57:39 +0200
Message-ID: <CALwA+NaYPZY6956KG6u4t3WxN5YAWABitvhwYn30kcH_nrxeuA@mail.gmail.com>
Subject: Re: [PATCH v8-RESEND 22/33] dyndbg: split multi-query strings with %
To: jim.cromie@gmail.com
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org, daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, seanpaul@chromium.org, 
	robdclark@gmail.com, groeck@google.com, yanivt@google.com, bleung@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 6:08=E2=80=AFPM <jim.cromie@gmail.com> wrote:
>
> On Tue, May 21, 2024 at 5:58=E2=80=AFAM =C5=81ukasz Bartosik <ukaszb@chro=
mium.org> wrote:
> >
> > On Thu, May 16, 2024 at 7:45=E2=80=AFPM Jim Cromie <jim.cromie@gmail.co=
m> wrote:
> > >
> > > Multi-query strings have long allowed:
>
> ... input like:  (Im using it like a verb)
>
> > Missing been ?
>
> this is an alternative.

I see

> maybe s/strings/commands/ too
>

I like commands more

> > >
> > >   modprobe drm dyndbg=3D"class DRM_UT_CORE +p; class DRM_UT_KMS +p"
> > >   modprobe drm dyndbg=3D<<EOX
> > >      class DRM_UT_CORE +p
> > >      class DRM_UT_KMS +p
> > >   EOX
> > >

