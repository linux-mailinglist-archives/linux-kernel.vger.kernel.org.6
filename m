Return-Path: <linux-kernel+bounces-246823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBB992C7A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 02:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AEC11F2170D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 00:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D03A23A0;
	Wed, 10 Jul 2024 00:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+Q/r6Th"
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12E21366
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 00:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720571148; cv=none; b=cKEqX3XcCAX7yiGE7NBpKxbGO6C6hx+Wr1B4Fcet+oDgUC5lco3Gk5QwgG8SmtY+yrckfiGykHUBufUA9ua/L1g3ZVcaf512HiL26WKwjid+whbXfYMbNgSHrgoAURruaoPTu2KWt2FiGsLEcO1p2i53W0C9chlxzj8mrqIFReo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720571148; c=relaxed/simple;
	bh=qIPbW7h2/BplkGl3lx9W3e8Hr1hVYIxtEc0qge5hJ08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjTu5RQ64Q639isduPZUa7ochivIu1L6VqGJJGtNx797h4GUeoQklwAD9KvrNnwWaxov1Pn7EJDeKVPoabif2R7PjrHns+CucMcOYcscsrdWAq8kYrAul8ngdtGIKe4O9hGFU5e66rqvyYHYorVEZXCVivY5rMcaN5xnnQ+QXOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+Q/r6Th; arc=none smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-48c2d353b01so1967931137.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2024 17:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720571146; x=1721175946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GLMMCTOEE4C+kE7P1kVc+ZnjaPA7yhchwaYpxbxPQqg=;
        b=F+Q/r6ThWh7b6TPdiWPm2vEh4cA7LZPfIL2v6S1XebDFVy9PR9fYIyeOrcrd7yJMRF
         y8Q+vchK5FXz/Y4qe1C7e+MwCZ4UgdJNDCufgJZjOweja/ieM0JJPe73n6HNZNRDMtBq
         cgCS1WJ/Hn9zOyNKOCvijDqQxyZtbHOpmDoJBU12jLK1Gzgpat2JQGeVDcBGkYLLDxd/
         VKs8E+WkRrbFvJf504M7JfmrNqyXCvjY/faiflDQ7XTB6iLg9O7dUYPdf52V2106hVbQ
         jhJ31Astz784YjJTJnBL2FdGB9T4C3I1h+bKpcD8UR+eVObNqgFMVdUFYY7hnH2jsRF5
         5tuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720571146; x=1721175946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GLMMCTOEE4C+kE7P1kVc+ZnjaPA7yhchwaYpxbxPQqg=;
        b=BMnz4/9GZ4B/fOHtg6UYpovp9ooh0UASgG/Bc1qm55k0ka3GbVuxlXrlcdzGJwYziU
         QsuIrGdQP8GzIl9x3jStORACe+ezWol3yrCP+PWmZWcHndn5mqaz+w/HskwJ4EPEnd+g
         xLapDxybx+F5SBZ5QaAskpnnzKQyknwXTpg42JJAMDIz6RjaXv5Ex40VxDLhehVjXrVx
         BV8jJ7PJa1pjot0iEVVwka8ICBzwR/2Xa95L6CmadNoytnaeQ2Uev1ya7DfgXWshANjg
         3P5+yG1D9Ggk6I/+Q2KssQREp1DX5osVSHD69+ZPrugBSd52IwWxrIuwX8pjQUFJOXRl
         W5xg==
X-Forwarded-Encrypted: i=1; AJvYcCWt2LBZ5NJooXu6u0IjNffR18EAI/RQntkh0kp/J7CxkQWC1LO9cioS26FnZ1v8q+jZfW7t0nw6bQz4jqyB0TjBUllybbLspTbEmd90
X-Gm-Message-State: AOJu0Yxq8eNgF9T3CuNTJ9Mf7H7YQo4zybrdU1eW+M9HSVKcBBZH4Nny
	NbQp6NPzzqQJOF+rHcUumY8/I4eSCs2n75TMtFEtRxk2kKUWa+5vRt3tbPH6WbsoToqCI47Vwdo
	DIJm9Fc/xQ51Nd7jjxaEF/I9q+GI=
X-Google-Smtp-Source: AGHT+IGECqipxoMr9LXTGLmRKFz4B8Xc35pmBX/LCXPTFZurDCgbtol3fdXdT6TkXYh5nKfDM1iSxmkL5helPLunxBc=
X-Received: by 2002:a05:6102:5123:b0:48f:5b4c:bb0a with SMTP id
 ada2fe7eead31-49031dc8f16mr4627169137.0.1720571145737; Tue, 09 Jul 2024
 17:25:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
 <20240702215804.2201271-31-jim.cromie@gmail.com> <ZoSOMClB0MeWeokU@intel.com>
 <CAJfuBxzsZUpO-Q_uAfMhzXs0WHYMTnj1F8ju7af-kQZKQjLvNQ@mail.gmail.com>
 <ZoU7kR2aYwVDvd_G@intel.com> <CAJfuBxwVWbJ9TdgH0ARmxUy+_DfNVKrTewjkqWKmCQtfOKQEAg@mail.gmail.com>
In-Reply-To: <CAJfuBxwVWbJ9TdgH0ARmxUy+_DfNVKrTewjkqWKmCQtfOKQEAg@mail.gmail.com>
From: jim.cromie@gmail.com
Date: Tue, 9 Jul 2024 18:25:19 -0600
Message-ID: <CAJfuBxx1wz=bMOyfiRRhrGyZTqnqZsUmi9Vubs23Yi1px9sZ-g@mail.gmail.com>
Subject: Re: [PATCH v9 30/52] drm-dyndbg: adapt drm core to use dyndbg classmaps-v2
To: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, jbaron@akamai.com, gregkh@linuxfoundation.org, 
	ukaszb@chromium.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux@rasmusvillemoes.dk, joe@perches.com, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 10:11=E2=80=AFAM <jim.cromie@gmail.com> wrote:
>
> Got it.
> I had some mental block about passing designated intializers as macro arg=
s.
> it just worked, I needed to eyeball the .i file just to be sure.
> thanks.
> I have a fixup patch.
> whats the best thing to do with it, squash it in for later ? send in
> reply here ?
>

I have to retract on designated-initializers into DYNDBG_CLASSMAP_DEFINE

While it works for DRM, and looks good, and self-documenting,
it only works cuz DRM_UT_CORE =3D 0,
and breaks when I used it 2x in test-dynamic-debug.ko.
the 2nd _DEFINE needs a _base > DRM_UT_LAST.


With designated-init exprs passed in thru the macro, I get:

    1st classmap below is bad - the length should be 8, but is 28 cuz
init started at 20.

    (gdb) p *di->classes@di->num_classes
    $2 =3D {{mod =3D 0xffffffffc0203740, mod_name =3D 0xffffffffc0206220
"test_dynamic_debug",
        class_names =3D 0xffffffffc0203080, length =3D 28, base =3D 20,
map_type =3D DD_CLASS_TYPE_LEVEL_NUM}, {
        mod =3D 0xffffffffc0203740, mod_name =3D 0xffffffffc0206220
"test_dynamic_debug",
        class_names =3D 0xffffffffc0203160, length =3D 10, base =3D 0,
map_type =3D DD_CLASS_TYPE_DISJOINT_BITS}}
    (gdb)

    so 1st 20 classnames are empty, and classnames -> index -> classid
translation fails later.

    (gdb) p *di->classes[0]->class_names@di->classes[0]->length
    $4 =3D {0x0 <fixed_percpu_data> <repeats 20 times>,
0xffffffffc0206356 "V0", 0xffffffffc0206359 "V1",
      0xffffffffc020635c "V2", 0xffffffffc020635f "V3",
0xffffffffc0206362 "V4", 0xffffffffc0206365 "V5",
      0xffffffffc0206368 "V6", 0xffffffffc020636b "V7"}
    (gdb)

Basically, when designated-inits are passed in, the _base param is redundan=
t,
and the once guaranteed contiguous 0-based classnames list is now
guaranteed sparse.

the macro could be altered to expect designated-inits,
but I couldnt distinguish between the 2 different uses,
so theres a mis-use potential either way.

Id prefer to keep the _DEFINE the way it is,
and better kdoc & howto this to explain away the potential.

BTW: Im aware I failed to delete some v9*patch files before git send-email,
Im considering my penance, will resend soon.

