Return-Path: <linux-kernel+bounces-263402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8826C93D558
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 16:50:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F49D1F23098
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF991CD23;
	Fri, 26 Jul 2024 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NzMBvwJ9"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C925F17997
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722005399; cv=none; b=lOvaRjucwxvxSl34fQJaj4xNAk4YvYke7LzCPTDW+G4dGMWBZQ4gii4lsTQHi3otzNo+dAHjMK/BYC53FvRcbOJG+AVALjDaCcyEUTxKvvY3FqrauWTnDKI3ldPxamNURHDeY2o45bcuSdmUjh8OlHV+JJrDJsRv+xh5feR9auI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722005399; c=relaxed/simple;
	bh=zYw5cml/fOZ5DmE2TFdKPM7OvcGgOZ2eWXn7juyqvGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oz7qz92HeFiIy3/q6njYWb1az0Wno9gk2wzMfQY0vpsdcq8ylwh3NkztZn8sC6GgqSv8JJhGkAjuACAqiZ/LXPaPdmDW/+oi2INf6ZnIbWbEDfz1DXmzOxokCY7G8d6lksa/49auyxjI58VjbAggsL7g6nv6FMp56/slwru0EoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NzMBvwJ9; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6b7af49e815so5036266d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1722005396; x=1722610196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYw5cml/fOZ5DmE2TFdKPM7OvcGgOZ2eWXn7juyqvGg=;
        b=NzMBvwJ9m2hCITINXWnJVHVljBXDPpWzDJYoHpDkJLCnsr0zMAwzQOitMTmOPsnAOv
         Jp0HDCd/sPSXcqOsl+TsKtheK7IQnC8tyI9mQMuuQzsoCLL4KmknLSB8hpmmMEC+IDW5
         j9c7PwVTllBOvY2+DX9G+vkEHSqHvpVTAyGqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722005396; x=1722610196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zYw5cml/fOZ5DmE2TFdKPM7OvcGgOZ2eWXn7juyqvGg=;
        b=o90Cmi2/yRLqDHme0LtwaxPIMAWVw6bs9n0E8SUvqDfo0LrPeInKrDLMgq1K+90GkZ
         m1LwBLxms4SPP8pGrIoqYJifXhKhaGBbgIA6FU/KL1GBRiRaPXPhS6vkkmx/VvPQC9x9
         iq0tquca1hKKEcdkc169OoRKpnyB6N/+zu9zSi4FuikpPRVDTH2B63p+NYCghbTJutUu
         EWnzzibmtofthacSMDE3AeiYSU+dC3gBpumQQgZf7ok7iRBlewUl16bL6blS6+FQRi/m
         45h0L4WXUdIXK30MdZgFwtsw5csPYZJ7ShsvsOZtdRtdtBmu268ORIAMUr7T4DqIjavp
         7UrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWr51VuZiBxPGd+7TKoeahkjB0aJ0mtnQ9Yx1G5bmNWtRAlMXDANpBkYKdwyeJxoVDdXqI9vuC2zwCkajj7J7JSgsq/o+GTjQ+YsvCr
X-Gm-Message-State: AOJu0Yyyz2j+v88ci7cx8fn2cps0CCaKdoJlyKiV0BJFvn3EOU60BtWJ
	iTZ5eMqKp2IlEQz/BTEWVeB2qwYxJpJRSZFW2XlYaM+YztkDOoU7LbjZZ5Ucx2fsHfd2HSTd4M6
	lew==
X-Google-Smtp-Source: AGHT+IEAllQw5+P68wDRogrpNMwP28q00lHWYV/N14T1XfsUq/Bp7y+uCcF0HScgihqO1a+JVoQ8RA==
X-Received: by 2002:a05:6214:4106:b0:6b5:423:52bc with SMTP id 6a1803df08f44-6bb559f8dd9mr619816d6.3.1722005396257;
        Fri, 26 Jul 2024 07:49:56 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3fa94e70sm17072956d6.83.2024.07.26.07.49.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 07:49:55 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-44e534a1fbeso200451cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 07:49:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVmEyMC3zykBNK5YdDDpIHcZCmUgtk1yDix6IrLM9fpNvy2pxHPZfKBBj3ZTYD+T7Nc/5eMPZtMplltIycJ1zseLKRMrwBpH1ovRCVd
X-Received: by 2002:ac8:7dc4:0:b0:447:dd54:2cd4 with SMTP id
 d75a77b69052e-44ff3b37e00mr3262241cf.22.1722005394734; Fri, 26 Jul 2024
 07:49:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240724122447.284165-1-tejasvipin76@gmail.com>
 <20240724122447.284165-3-tejasvipin76@gmail.com> <877cdakdq9.fsf@intel.com>
 <20240725-psychedelic-benevolent-muskrat-c7fd57@houat> <CAD=FV=WbXdnM4or3Ae+nYoQW1Sce0jP6FWtCHShsALuEFNhiww@mail.gmail.com>
 <20240726-cerise-civet-of-reverence-ebeb9d@houat>
In-Reply-To: <20240726-cerise-civet-of-reverence-ebeb9d@houat>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 26 Jul 2024 07:49:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WuupCmLPLkjAQrxr0JOngegoZpoXkR6GjnFem=WnPvGQ@mail.gmail.com>
Message-ID: <CAD=FV=WuupCmLPLkjAQrxr0JOngegoZpoXkR6GjnFem=WnPvGQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/mipi-dsi: Change multi functions to use quiet
 member of mipi_dsi_multi_context
To: Maxime Ripard <mripard@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Tejas Vipin <tejasvipin76@gmail.com>, 
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 26, 2024 at 2:15=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> > c) Declare that, since there are no known cases where we want to
> > suppress the error printouts, that suppressing the error printouts is
> > a "tomorrow" problem. We transition everyone to _multi but don't
> > provide a way to suppress the printouts.
>
> That's my preferred solution.

OK, fair enough. So I guess the transition plan would be:

1. Add a wrapper like we're doing today.

2. Transition everyone to the _multi variant.

3. Delete the non-multi variant which will cause us to delete the wrapper.


-Doug

