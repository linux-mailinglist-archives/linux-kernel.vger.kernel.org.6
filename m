Return-Path: <linux-kernel+bounces-510112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97228A31853
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 22:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB3A165E47
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 21:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DDD268C4E;
	Tue, 11 Feb 2025 21:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY/SZyCW"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB2D26770D;
	Tue, 11 Feb 2025 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739311074; cv=none; b=ch/Heve5GyhDaEoEt82e0pgHywwdrvqAI+LUyRvr8uQP77vtxdOH24yfN8wSNbPwmhdoLW48r56ST64qXtmwjUiehNADCwLs4uraKr/PjOFmptGoaI2Qo1DRz/SqoIwaXRevxWa3+O+60Aw0JnaYtyyuE+UhNwrmDDHwLa3FfQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739311074; c=relaxed/simple;
	bh=GnSSHTilggRgjTh8Tt1HZilTfZYJzfHA2Mcz1okwS2w=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=m28yg1Eki6+JqjCnM9ZmSDDbEzRNE+oTmAy8AHxJfvILI7jP4LoYwVwAWMg4lu8bFWaO7hgaNTEZsipSnswdTjJtPX7EJ0y0ENVHO1mMYNmP4BrMOlnKxqTNMa0lIrCNkmFddB745FjszYz8+/85/fUNfEHddab7Wp7BDHsoIUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kY/SZyCW; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6f7031ea11cso58342327b3.2;
        Tue, 11 Feb 2025 13:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739311072; x=1739915872; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GnSSHTilggRgjTh8Tt1HZilTfZYJzfHA2Mcz1okwS2w=;
        b=kY/SZyCWIRsIZPqhGC3/COV/zvz5Lqs5K2hDSmNURLKLF+/u4UsgerQtt8k7hUH0S6
         J9rWzcgdd9hjrtHmqZlwBKxeLYqlsVNs2rJ4uENMS2uI1hIvOUnoWcU1BFMPkRsHUWA4
         RgngLWkC1RTqD7x6yJSuhF+s2fzf4Y+qAXYiGbz7bLpKeBZCqcIH3z+lzDrn+4MvDvX8
         QYzCPNONOqzzYQGYvuq8SO+QM6fgCNBbAhF0O4x3X3zoqCG9tMVOYS+Irb+zLr2N1sP1
         fX5MnNz/Kk2/aJSZ7AWik3DHuonE5Wsd4D1/9WXTPyr02jT9fiAbXW5hiqUaMtvMyG+W
         oFEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739311072; x=1739915872;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GnSSHTilggRgjTh8Tt1HZilTfZYJzfHA2Mcz1okwS2w=;
        b=u4L3xIxvxtj+7mQkZNC4bHRgpR+qJyOeWdlasqCRT8Sw05SEBPulFelVVoRPo9RXtR
         /ystdNpQ2WskOuN8RtvZeG6g5Md5nhp5E+/DDYWusC4eESsJYaY/cLU+o5oz3Fpy48Ap
         tquvoXfGldsuc2fCoDnkF4gC8nLjDCQwHhfl0st5PtV4yFBiT6py7aR3v1Bv76kaxYH4
         hguToTVzXO4WT2tCq1w8phMM4UUyUvN1sz7YKCQbdVGQTEoXDiS1SNXDkdNIYRQuhJEX
         aTwqT1C+d8XgDtynIF1Q8fUiV6ynSmS/HXLhCA2jyhOxwWGxcKslKV4i8oJzv9M6/X/E
         EeKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGb0bM8b2LR4vW76BvsTElUYYcP9Xo9VGUcC8O1T4SzTvrLADvJeGnZBXpsfcsp0b5NIAchvlDiV0=@vger.kernel.org, AJvYcCVQVYdkCcM48NdAyCSYZsRnU1dH/730641DFcKhFredhva3yADZ3KXdMTmzKrg8LKTdk3xaqzAYED/lekkPirw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2sX0GvIhTGCQToGcoN1pFKUjVrIGK1NJ5b+D8buVr0QdVq6Mr
	7vRLmhiVVfWRq+P+kZn8FDdTM53Tnwg+FgBL5h3TLzrSR8zw8Y/F
X-Gm-Gg: ASbGnct5/OAPYwTeFszXm2WAffGMScO8esBXRIpbmVb57V6AS2qwLquJ0WPKpldZQsk
	iEOXZ8OzCDrZlAR7bgnbvQW/evgzrAbQ/2zqEVCuEtWcFfAgBoLGGFsMVOuik7x4pBUGWlkQjnA
	bdJZYuiWgVXIETX5PAkmd5eIUY7BsWZGacwbwcKhyV6peH0ESma96K/Q6yL1nAwbumJu8d0r2Ak
	TmxcA7xMwEkzvz5VCl31nOcsowIAlchX+j/D+l6x99uYYCeL3iXgkacR+nhpvrC9Tcrosa8p2i4
	rM1/wjoq
X-Google-Smtp-Source: AGHT+IFpa3ZOas1Q54qPxzEun+I4mgqG4mxd7sr/9TQpL9cUQ4fTvg/R8JGtaEXleIP/OyrqBVL+Nw==
X-Received: by 2002:a05:690c:6d0d:b0:6ef:8177:c322 with SMTP id 00721157ae682-6fb1f1aab45mr16800147b3.13.1739311071695;
        Tue, 11 Feb 2025 13:57:51 -0800 (PST)
Received: from localhost ([2800:bf0:61:1288:72d5:e7e1:d832:2e3d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f99fd55c92sm23343637b3.55.2025.02.11.13.57.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2025 13:57:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Feb 2025 16:57:46 -0500
Message-Id: <D7PYBD1V7Y0W.3TGGTJF6MHY5Z@gmail.com>
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Lyude Paul" <lyude@redhat.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>
Cc: <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Danilo Krummrich" <dakr@kernel.org>, "Alexander Lobakin"
 <aleksander.lobakin@intel.com>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 "Jonathan Cameron" <Jonathan.Cameron@huawei.com>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Lukas Wunner" <lukas@wunner.de>, "Mark Brown"
 <broonie@kernel.org>, =?utf-8?q?Ma=C3=ADra_Canal?= <mairacanal@riseup.net>,
 "Robin Murphy" <robin.murphy@arm.com>, "Simona Vetter"
 <simona.vetter@ffwll.ch>, "Zijun Hu" <quic_zijuhu@quicinc.com>,
 <linux-usb@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH v4 1/9] driver core: add a faux bus for use when a
 simple device/bus is needed
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <2025021023-sandstorm-precise-9f5d@gregkh>
 <2025021026-atlantic-gibberish-3f0c@gregkh>
 <D7OU5VOXCS8M.39YEYRWFL1MPW@gmail.com> <2025021038-pushy-prior-5dfd@gregkh>
 <D7OURQCZ3I1X.85BUFMYU6H8A@gmail.com>
 <2025021028-showgirl-waviness-b4bf@gregkh>
 <D7OVXDJEMH53.18HAI8VKLN997@gmail.com>
 <e2087716a8328ba9c8359e50977e31a85c6fadf1.camel@redhat.com>
In-Reply-To: <e2087716a8328ba9c8359e50977e31a85c6fadf1.camel@redhat.com>

Hi Lyude,

On Tue Feb 11, 2025 at 3:06 PM -05, Lyude Paul wrote:
> On Mon, 2025-02-10 at 10:52 -0500, Kurt Borja wrote:
>> > Modules usually don't need to do the probe callback at all.=C2=A0 I sh=
ow one
>> > example in this series (the regulator dummy driver), but it can be
>> > easily rewritten to not need that at all.
>>=20
>> This is a good point, but from a developer standpoint I would always try
>> to use the probe callback. This API seems to suggest that's the
>> appropiate use.
>>=20
>> Also it would be amazing if the probe could reside in an __init section.
>
> IMO I think it is fine without the probe callback, plus we're the ones ma=
king
> the API - it can say whatever we want :).

IMO I think you are right.

>
> To be clear though, generally I'm fairly sure the only reason for drivers=
 to
> be using probe() at all is because you want a driver-callback the kernel =
is
> responsible for executing in response to a new device being added on a bu=
s.
> This doesn't really make sense for a virtual bus, since we're in control =
of
> adding devices - and thus probe() would just be an unnecessary layer for =
work
> that can already easily be done from the same call site that added the de=
vice.
> So I think it's fine for this to be a special case imo.

I'm still just a newbie in kernel development so keep that in mind.

For me having probe and remove callbacks on "real" hardware devices has
always been about gurantees. Gurantees about lifetimes of resources
assigned by the driver/bus/subsystem (I just started learning rust :p).
Me as a driver, I know I can initialize a bunch of memory, interfaces,
etc. In a safe way, inside the probe because I know everything is
guranteed to be valid until just after the .remove callback.

Of course, this does not apply to this bus because the bus itself and
the single driver are very minimalistic, so we can achieve the same
gurantees in module __init and __exit.

So I agree, the probe probably should just be dropped. However, if the
probe goes then so must faux_device_create_with_groups() because without
a probe the API can't give any gurantees about the lifetime of for
example the drvdata opaque pointer.

I think this is a small problem, because in platform-drivers-x86 for
example, there is a lot of "fake" platform devices that expose a sysfs
interface. So if this devices were made today, they could use this faux
bus, but they would need to create/remove the sysfs groups at the
appropiate time, as to not mess with lifetimes, which is a bit=20
bug-prone.

Additionally the current faux device API is very misleading, because
although it gives you a choice to add groups, this groups get added way
before the probe you provide is even executed, and even if it fails. I
believe this could lead to a lot of misbehaviors and bugs.

--=20
 ~ Kurt


