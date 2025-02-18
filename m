Return-Path: <linux-kernel+bounces-518632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34669A39245
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 06:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06649188953E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 05:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6901A8F89;
	Tue, 18 Feb 2025 05:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Ir1abrC7"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B5515E5B8
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739854913; cv=none; b=GfUSS2IZiNUbArEVa6kvLdmqdkXSisrCclwUfYp7qG0DelKMruZpWDRxxIKQvWzBuLnHOAuZ1feRPAjGK0M7BW5+sqJeB68Q8h3G2q6VtmP7uiGTDBpIVn+aJrOIJ1Bz8FWsJa/nbPt7fIS2wPwMLP4x/gXkyVYz4VlwyXWoVYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739854913; c=relaxed/simple;
	bh=hGAR3ZwoaIsq5hwwkgzfjRG2KIko8sJB+3uz2rs5wT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ks7+lk2GIHdMOO1zLdTjqpCwurleG8K67VZwbTfjsYG/P+m+BXsrNuSCFX431l+aT5Hya6FHv+tUKVr2IB9Cr+N8G1MAz5WsRJWygkVIlVi+WOXG1cjEa3nxZlsVbguTPyra656KlhpTTp3QdmyTZoA3Tgtd89f5NA+X7Q2uqaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Ir1abrC7; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9B4083F477
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 05:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739854906;
	bh=jDOQiVSxgFvgjSI4VcGsykeR8qBgIlZA/vBXLnYhpgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=Ir1abrC7/gtYi1qYUgu5lQNK3oMSWt8kdae68FZ724UQYx9HIBnDBZofXIgY8mBpT
	 Xh9tpQkzC4FFI/JaTXJblmRK8mFEg8CyylKADNy17lOvECkU8ARHw3AGrIjc46g6YC
	 5DMHdgXOsxgTkYpgPNRIMwKnrUTV8ECBcZ2xmdfnREtUGbeDzC1gqDxUCXOXg43N1Z
	 XgsK6V/ip7EoiTRt4njQgpK4idxljZeZplMsX8elhyYk4FMw73Mdz252e5XAdIf9Ka
	 s8ML0Jt+sxHwD0Mtc2JjDkTS23rBOwsvpr7I+AuXuftpCMuLKnakFOE/GLDLCM99JY
	 vz9ZQ3sx/eJMA==
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc0bc05b36so16356084a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 21:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739854905; x=1740459705;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jDOQiVSxgFvgjSI4VcGsykeR8qBgIlZA/vBXLnYhpgc=;
        b=H4JboFy2+tSmnxH3Ldcv8AKt+8Xrylm0rY4STnTV4tZDbWW8Z9/uiJNnQXuC2nksvd
         YfxbffOt+aJ192fVPwm10mfh/ckklvOr7+oG9b4eWOHJNKEsfwoCMboiG9hHX7s1am8b
         RjIwWOl7qe8PCk5XtbkPvxtmJ0w1In+VEsBqemhPrtDnIK2RoAIs8PuOyR9F1hX1kB/A
         giiEN1u9l0+DyN49D8QbT7FPVJ56fMr0lURvOZe7jL01CmIpJdsc/6fl1FIPMVnRlmNO
         En+dBeINKz8FUIkOFq2Oo9KsIEZsa2qfqKFtCsmZJKj3bE2qqRdq5jPjIK1V0xnAmWNw
         bNVw==
X-Forwarded-Encrypted: i=1; AJvYcCXCFZd9XZ50aYw0CqOCJAeiIAKUoB5mQW5ySPZZSa7iVADzKizJmRRMpi2EYENqqt8KjvQ89ss4Ej/GQDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YybD7u0DI/JO7GDnI53p/yXBMjZYmA57lbowMAeuh22sqdq+Q0Y
	vR9fJdsayMa9NZiifsrkkdE/tmkJhllC39PAv05RgDj27DpAxoTMVem9waAtyMf8K9pcb9ZzcPj
	lpTL6aXcao+iA8/fJBasiusXSDyh0TKqNo5JY/bQgOHIoNQcuxCgYwHyvX9ApMf/osvAspCXVOP
	850Q==
X-Gm-Gg: ASbGnct1m01dIV7JO6dgjcjAlTyV/G7p59QhDRxcI5/cRL7cUSGoj386busIrtdudmW
	fClvxGwdTUDiY9noTH8KewOUEH5r+t3RZd68IOlY5+jw77B24nX8HKUAqd0UM57m87kM36CteJr
	XovvWE940A9k6C87IQOBBnSQxq/ZomzIkF/GnB3IPX3on07g7SzLVCJoTXo9/6wuudBUOOpxiHp
	jU12wKFuHJ4nkfpHPAfMqaXNbIaaq7cq1gYGst5XDMdSzVFXSCIkJ+HmUh9yi89WwqXfhj7GhxC
	kZ4hnbU=
X-Received: by 2002:a05:6a00:6f05:b0:732:6217:8c69 with SMTP id d2e1a72fcca58-73262178e79mr19896400b3a.3.1739854904832;
        Mon, 17 Feb 2025 21:01:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN7ENmQ7UTCtkITQX6L9ZZEIwCi4nZCWarJR5zmnR4HrstBiYxYvuJae5cwQZZfiEJrF1o2A==
X-Received: by 2002:a05:6a00:6f05:b0:732:6217:8c69 with SMTP id d2e1a72fcca58-73262178e79mr19896359b3a.3.1739854904412;
        Mon, 17 Feb 2025 21:01:44 -0800 (PST)
Received: from localhost ([240f:74:7be:1:ad3a:e902:d78b:b8fa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73252051ca0sm7242421b3a.111.2025.02.17.21.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 21:01:43 -0800 (PST)
Date: Tue, 18 Feb 2025 14:01:41 +0900
From: Koichiro Den <koichiro.den@canonical.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, geert+renesas@glider.be, 
	linus.walleij@linaro.org, maciej.borzecki@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] gpio: pseudo: common helper functions for pseudo
 gpio devices
Message-ID: <saszavmizjwhzechspy6otune2xwtgjjygaitxminzclgj7zep@ofwfb5jdfcam>
References: <20250217142758.540601-1-koichiro.den@canonical.com>
 <20250217142758.540601-2-koichiro.den@canonical.com>
 <CAMRc=McB0bcG4jERmUyrQ=eTP+kcfLBBAOaT7mCMKbgUB1W5nw@mail.gmail.com>
 <d2qdoq3f3jk6gzgsjeqszgaqk7z523r7cfnopxfq4ghsbsqgp3@zjw67ewqzi5u>
 <uogv4ckqo2e2byspffvfayu44v6fl46sxtu7eudweoye62sofi@5iwsumpttpca>
 <CAMRc=MdNtDW_Gbd6dsG345110SCWe1vD_rNd_QaWBYRApHBoxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdNtDW_Gbd6dsG345110SCWe1vD_rNd_QaWBYRApHBoxQ@mail.gmail.com>

On Mon, Feb 17, 2025 at 06:29:27PM GMT, Bartosz Golaszewski wrote:
> On Mon, Feb 17, 2025 at 5:21 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> >
> > On Tue, Feb 18, 2025 at 01:12:17AM GMT, Koichiro Den wrote:
> > > On Mon, Feb 17, 2025 at 04:46:30PM GMT, Bartosz Golaszewski wrote:
> > > > On Mon, Feb 17, 2025 at 3:28 PM Koichiro Den <koichiro.den@canonical.com> wrote:
> > > > >
> > > > > Both gpio-sim and gpio-virtuser share a mechanism to instantiate a
> > > > > platform device and wait synchronously for probe completion.
> > > > > With gpio-aggregator adopting the same approach in a later commit for
> > > > > its configfs interface, it's time to factor out the common code.
> > > > >
> > > > > Add gpio-pseudo.[ch] to house helper functions used by all the pseudo
> > > > > GPIO device implementations.
> > > > >
> > > > > No functional change.
> > > > >
> > > > > Signed-off-by: Koichiro Den <koichiro.den@canonical.com>
> > > > > ---
> > > >
> > >
> > > Thanks for the review.
> > >
> > > > Looking at this patch now, I've realized that there is nothing
> > > > GPIO-specific here. It's a mechanism for synchronous platform device
> > > > probing. I don't think its place is in drivers/gpio/ if we're making
> > > > it a set of library functions. Can I suggest moving it to lib/ and
> > > > renaming the module as pdev_sync_probe or something else that's
> > > > expressive enough to tell users what it does? You can make me the
> > > > maintainer of that module if you wish (feel free to add yourself
> > > > too!).
> > >
> > > I had vaguely envisioned that this might eventually contain some
> > > GPIO-specific code for some reason, and also it's just a tiny utility to
> > > reduce code duplication, which is why I placed it in the neighborhood,
> > > drivers/gpio/. However, of course you’re right, there’s nothing
> > > GPIO-specific here, so moving it to lib/ makes sense.
> > >
> > > I'm not really sure if this method for synchronous platform device probing
> > > can be broadly accepted as a general solution, but I have no objections to
> > > making the change. I'll move it as you suggested and send v2, setting you
> > > as its maintainer.
> >
> > Regarding this series, I feel that it might make discussions smoother if
> > you submit it directly. So if you're okay with it, please go ahead. In
> > that case, there's even no need to mention me or CC me - I can track it on
> > ML :)
> 
> I'm not sure I'm following. Why would I submit it myself? You did most
> of the work already. If you want the changes to gpio-aggregator
> merged, then I think that it's time to refactor this code before we do
> that because repeating it three times is just bad programming. I
> probably wouldn't have done it otherwise at this point.

As I mentioned earlier, I'm not really sure if this particular usage of
platform devices will be generally acceptable. gpio-pseudo was intended
solely to reduce code duplication in methods already accepted by the GPIO
subsystem. Moving it to lib/ would shift the approach, effectively trying
to promote this method as a standard solution.

For example, if for any reason drivers_autoprobe is set to 0 on the
platform bus, the synchronous mechanism might be blocked indefinitely.
Moreover, in the first place, I'm not sure whether employing the platform
bus in this way is appropriate.

For drivers like gpio-virtuser, which we can define virtual GPIO consumers
via DT, or for gpio-aggregator, which we can use as a generic GPIO driver,
the expectation is to use the platform bus/device mechanism as usual. In
those cases, adding a synchronous mechanism via the platform bus notifier
to piggyback on the existing platform bus probe implementation is
understandable and obviously has already been accepted in the GPIO
subsystem. However, moving just the synchronous mechanism into lib/ can
potentially be perceived as an abuse of the platform device concept?

Incidentally, Greg K-H’s faux bus work was recently merged into mainline:
commit 35fa2d88ca94 ("driver core: add a faux bus for use when a simple
device/bus is needed").

Correct me where I'm wrong. And I'd appreciate if you could share your
thoughts.

Koichiro

> 
> The code looks good other than that, just put it under lib/, rename
> functions to pdev_sync_probe_init/register/unregister() and send it to
> the list as usual. With that it's good to go. Just make sure to
> mention to Andrew Morton the need for this to go through the GPIO
> tree, I don't think he'll mind.
> 
> Bart

