Return-Path: <linux-kernel+bounces-195041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A2F8D46B4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 10:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 690711F22B3E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 08:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EF51474CA;
	Thu, 30 May 2024 08:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bgBZ8BNU"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6582614535A
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717056487; cv=none; b=KuYNsjligqgTHMZjcLxAxrl6HSh+Q+reuIbRZeARbGLcpC7NR59Gto5A+7lnZC5v/n3T0jjy4DCVYU87hxFh8CH0ugF6T1rob8HvGVw6/jC7Du6kP+N/HVQINgsuYq8AnGjBgDGbgpOmatAbRG7GaRvJSaHaS/Vo1DOTjyv799o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717056487; c=relaxed/simple;
	bh=BKFupsJftGMs6W6ZZIn49gRpZlGuTWZ9PfyykZzrqn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbHSxLw/mPOv3Qjut6WpXA41rl6LZKQotMrMke8Mo4CNuQHD7PmP2nNed+w6Ugzam/haf2QKHbDqIvmRV1m0Z9gJpC/ughhUse3zW/CQIdTmQVko8MtVdfC/2RSwmgMaXzjmzzvrxg70FPdyNZRx8Q2UvIAP7ZNdJJ6yt6yIN2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bgBZ8BNU; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dfa4ad7f6dfso517027276.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 01:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717056485; x=1717661285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ea398ookltKnMcZe9XrXhw80TYHn5RUehEf25oaXTj0=;
        b=bgBZ8BNUj0eDg8oL2AFWY9kHE4TP6RtHeJXgfzCvA1pJ4VnoiGiRJjIX8Nyeh7XbS0
         GNA0uGA483S2wfG30ERpev70wFm3r0E2ZSX5hfGZvaH1S0xNYzUvKSy98eKMSq+ObLhe
         OxgShayuHRDO4Zl0KI9RES8Ud+EYvwbzjSX2wacIPdprMJie3X0oO58O/WF9An4z1CeW
         yXT7otZkQrKIYozDupREMnF5OzhK7YKJx7ygWuZXnjY8Q8T2YHhD4wbLwZMMHYq0a2Z4
         lkQGmz12mkLsW+v+m/bAx/y+zs1SDbzJdxqaJSlqUN6C1EGb1iGewf8/U6NyBUkP6XoJ
         jdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717056485; x=1717661285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ea398ookltKnMcZe9XrXhw80TYHn5RUehEf25oaXTj0=;
        b=cdc5nmSKJh96/Jy0aUMzHSZQiLxBs45D96hfbge/SqzF44SC7Dd9vWk4pgvm9GsnHl
         TbP/y1a3hcX+iKbFbk2LO25Q8rL0D9Ytpbg2hgdP9Xl2x5xELUY2EVfoyWOHhqvDYY6t
         e6bsb1hEeVhCYOVQorKZxw86Jdmb0QIsNSReDUxuYeroC9SLOLYzv8xxMw6ZrY5RN83A
         +0F9XW8re165TWbhU/JFZg4Hx/b9xjEBsqC+453/RIuqt8yqt+beTyW/QGmadIrpDNqP
         M7KK3nZoDZFWbKoygJXb9MYqiwrqg9xghGWdzZ7kfteWKka1pFSaTud5ROVj/eRuliOt
         +Aag==
X-Forwarded-Encrypted: i=1; AJvYcCXmc44PJiGVTnDOVDueHlzVwfBNbWTd5/uMA/ZObSLkBQ8wwSmWCvqpjCkyAoqpG3rY449gaDw6xubcbiUkeaOK7+gKfQBcDOJV9qt9
X-Gm-Message-State: AOJu0Yyfp48yqcYSTRvyHAnMmkFthOb2zUZ6J+mmTdZxlo3BKY+LEn2B
	Y5qR/J1BaRv7FPswkCb6lDF//j4cYMJTIkvu24HPE1iM+HX5om98dyCmv7byoFm7LCA8QGVFsWx
	DQBjzw1XI6h/tIGDVrKNByo68MRTPLWWlj5Yc7Q==
X-Google-Smtp-Source: AGHT+IGz+ZsfJJB5VdBGOljgIkzRdHhgei+gaKgI65RBquJxbv4kncJ2bpBR1QliVBmCJF1PLzPJlIZVnBu5WHt6piI=
X-Received: by 2002:a25:ac92:0:b0:dca:c369:fac2 with SMTP id
 3f1490d57ef6-dfa5a5baeb4mr1629327276.3.1717056485217; Thu, 30 May 2024
 01:08:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528210319.1242-1-mario.limonciello@amd.com>
 <Zlc4V1goFvU2antl@intel.com> <197d195f-9206-41dd-8ff1-f4bb4988fb9b@amd.com>
 <ZldMKZ1MzSDXOheJ@intel.com> <g34f3sdk22grheq2vaaonkl543dtk7nb5sffqgmkl5ywtj5skk@p5ht5ug33q4z>
 <873b7a7b-139d-498e-89da-098cb3d7599d@amd.com>
In-Reply-To: <873b7a7b-139d-498e-89da-098cb3d7599d@amd.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 30 May 2024 11:07:53 +0300
Message-ID: <CAA8EJpqODpGX-RthQ8qu3oU80qXp8a-N1Chz-dcQXjKYoDfEgw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/client: Detect when ACPI lid is closed during initialization
To: "Limonciello, Mario" <mario.limonciello@amd.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	linux-kernel@vger.kernel.org, Chris Bainbridge <chris.bainbridge@gmail.com>, 
	hughsient@gmail.com, linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 May 2024 at 07:41, Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
>
> >> Also a direct acpi_lid_open() call seems a bit iffy. But I guess if
> >> someone needs this to work on non-ACPI system they get to figure out
> >> how to abstract it better. acpi_lid_open() does seem to return != 0
> >> when ACPI is not supported, so at least it would err on the side
> >> of enabling everything.
> >
> > Thanks. I was going to comment, but you got it first. I think a proper
> > implementation should check for SW_LID input device instead of simply
> > using acpi_lid_open(). This will handle the issue for other,
> > non-ACPI-based laptops.
> >
>
> Can you suggest how this would actually work?  AFAICT the only way to
> discover if input devices support SW_LID would be to iterate all the
> input devices in the kernel and look for whether ->swbit has SW_LID set.
>
> This then turns into a dependency problem of whether any myriad of
> drivers have started to report SW_LID.  It's also a state machine
> problem because other drivers can be unloaded at will.
>
> And then what do you if more than one sets SW_LID?

It might be easier to handle this in the input subsystem. For example
by using a refcount-like variable which handles all the LIDs and
counts if all of them are closed. Or if any of the LIDs is closed.

>
> IOW - a lot of complexity for a non-ACPI system.  Does such a problem
> exist in non-ACPI systems?

There are non-ACPI laptops. For example Chromebooks. Or Lenovo X13s,
Lenovo Yoga C630, Lenovo Flex5G, etc. We are expecting more to come in
the next few months. And I don't see why they won't have the same
problem.


-- 
With best wishes
Dmitry

