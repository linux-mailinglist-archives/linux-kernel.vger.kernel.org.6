Return-Path: <linux-kernel+bounces-185108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7648CB09C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF5A1F21776
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C18142E7C;
	Tue, 21 May 2024 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAASLyei"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E02142E6C
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 14:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716302537; cv=none; b=F1NoXmIeCd6zX9Abmn6TU0ZuDOWwo8h7m04WlHUca2OnfYDKRRqbcFNVwtw0bGVBsn9QWX/a2fcL9IpKyTOO9VWWlTDw7dp6azz0aeJ4kpGpZzfFA5ZD8WLTxKG8/7AHhlXimW/3QkUbaJ3EbHcvvbRGWU15wjRCNPIdajashxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716302537; c=relaxed/simple;
	bh=hBe3vNhy5rd6p0YbIFGsDgfDT7OSLlZtKRupRbi27uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5NoSFveVnFzO+pR2YBsLPduWpEGWCYhxqQi8wjVbBke6w6b6SK3b+Av2+sWde7e+x7UEx7UZrK7yv5bji6r588HuQf+xjNztKMClrZNu6PfEJrlW1icrs0wtCr6PsZ4H75r0hOxbv3gEWCO88O7sx8CTrFuyQLVWh+/v7ZlMFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAASLyei; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-488e8cb86c9so857085137.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 07:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716302534; x=1716907334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBe3vNhy5rd6p0YbIFGsDgfDT7OSLlZtKRupRbi27uI=;
        b=eAASLyeiKEMhxoYGfS6+BUY+ZaNKdNMkJYOWkeJssjK6b7xscjUBm7/bvVit1ky3Es
         Gqw6vjIv+k04eS1I7Va4GPeLjsTRo4xUgyqwc4Sd86yqCxlyjJ9zaVz6qu2R9w/kTEYO
         JfZmc3MzFxkHsnkD46LYBcf/ikJ7aYjPiRoUfdnwPBKHy4WQzBVh4r+oTwmUTnNUlmLK
         0RQRbGCWGfPNhhCy4meoFW1kvx1Xcx+gr90Ot+1fatOdQP84r9Se82jhiEOFAIbTXQcS
         Z8GIc/gmT6l5xc79FtaeOR+J6kxOJgxlpnzy95ogVLqDWs3P3lM2N1ZiJ4LnqBatBIHl
         SFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716302534; x=1716907334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBe3vNhy5rd6p0YbIFGsDgfDT7OSLlZtKRupRbi27uI=;
        b=eM9PYVUcPiW+75k0vEr19LhcBTrkRH2wcpZQhi88RkrjGNsKU5wjYXRxv3XXDr7Gta
         SjECJ6t1AGyXwkjftV3QDzCByw4bqqVforYR1q4Jjrlt9R2+XhrchvDZAjUWbn0588dZ
         0LD2KUgMlAc10S+g3FWUbzqjcHJHOGtT7dFjIVT2GasmbJ9UkYPNQMUQ8T8bngEcW2Gj
         FOkI9zp3BL8pUXVcXxy077hbEm61c36b3Z0VcWpkM9svOVX9D8oCJ/pxda0KhaHqtiWJ
         VKgHlLEaRpDn1LgFWOmmLU7y0FojxthHTz9WFnlZ8opMOAJPkSb8PWaPGsVW3Bq6sMWe
         oz0Q==
X-Forwarded-Encrypted: i=1; AJvYcCX67m8V6GLWdKsR0fdgOjvwe4q5XYeZBreWZfPKaJz5yUUFqVsWKqJN5098MzhqMmMw4zshqJz1qSESA45y89AsRhIgXLw6j86aDrue
X-Gm-Message-State: AOJu0YxndtD6sqb7DqJ0xYLPAwlXKDutCO5WC4dIjpvDQHjNwtrzXj+B
	cVSft/p26O0Uuxu5tzgrqBD6G7mjYqEuiYq7D359F4c9j8wBi39AIoIx4bbEWT/rkwOf7zUltXY
	TUEma0kmGiQmaloG22qL/MVWa3G4=
X-Google-Smtp-Source: AGHT+IGahFDuxkcW4dbI8TtFQ3JprquFkEjBkZoxG6RpZ1SrCdd6FyEPWiq8HQNkzwyL5OEbqf2jJQTCL7SIAXC0R1w=
X-Received: by 2002:a05:6102:6d3:b0:47f:2478:b763 with SMTP id
 ada2fe7eead31-48077e9dd37mr28234583137.33.1716302533056; Tue, 21 May 2024
 07:42:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240516174357.26755-1-jim.cromie@gmail.com> <20240516174357.26755-5-jim.cromie@gmail.com>
 <CALwA+NZP7OkAh3_h+bk_iKosBmbshvMfwU58JVjRwG46XevXSQ@mail.gmail.com>
In-Reply-To: <CALwA+NZP7OkAh3_h+bk_iKosBmbshvMfwU58JVjRwG46XevXSQ@mail.gmail.com>
From: jim.cromie@gmail.com
Date: Tue, 21 May 2024 08:41:45 -0600
Message-ID: <CAJfuBxyera+QsjgH95Qm1bAzUY0PivwvO7Pg1-oUQ5esj+dZ=A@mail.gmail.com>
Subject: Re: [PATCH v8-RESEND 04/33] dyndbg: make ddebug_class_param union
 members same size
To: =?UTF-8?Q?=C5=81ukasz_Bartosik?= <ukaszb@chromium.org>
Cc: jbaron@akamai.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk, joe@perches.com, 
	mcgrof@kernel.org, daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, seanpaul@chromium.org, 
	robdclark@gmail.com, groeck@google.com, yanivt@google.com, bleung@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 5:42=E2=80=AFAM =C5=81ukasz Bartosik <ukaszb@chromi=
um.org> wrote:
>
> On Thu, May 16, 2024 at 7:44=E2=80=AFPM Jim Cromie <jim.cromie@gmail.com>=
 wrote:
> >
> > struct ddebug_class_param keeps a ref to the state-storage of the
> > param; make both class-types use the same unsigned long storage type.
> > ISTM this is simpler and safer.
>
> Why is it safer for members of a union to have the same size ?
>

Its mostly extra paranoia.
but if 2 users somehow get the class-type mixed up,
at least theres no alignment issue added into it.

And a problem like this would naturally happen (murphys law)
when the PARAM_REF macro is used, which uses/shares the existing storage,
so that existing code can use that storage.
For example, DRM uses PARAM_REF so it can continue to use __drm_debug
for a few spots in code that still examine the value during normal operatio=
ns.

I'll reword the commit msg to say that more clearly (than this?)

