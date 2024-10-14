Return-Path: <linux-kernel+bounces-363566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1353899C414
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C57282F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FEE15666A;
	Mon, 14 Oct 2024 08:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="fiIpGZUD"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61621531E1
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728895916; cv=none; b=bi61HupttH/Vw+fKKir/qp1sBGKFgJsFxiiee3lZgH8GCI3K2JGOF/MvCPWlkgaGsRq4c6kXuxP00rtJP0HOPWzTvpJnWdgf2vy6bwUxuLlwdQ/iFe52Gf1zAhQUbC+C7YP2b36a9vwli9lYspfEHC930kwGCB21oHr1fsvGEf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728895916; c=relaxed/simple;
	bh=7y3i8RI0B9xeH/V6pkYoLkhTjNtFrZO1Xsun3cPjRYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IK6Nxsad3lON8NEbQP6SVJACm3WMKQD/pLP1h7xuvHEKqVKHeDAIgrlfLqrZP6w+NW5W3/nFJvU1wwdWB4u7Jv3ID3j+WR02DmAEgrbqRLqiKvGNQhfjWrpSkbMRs0Eg/rayJVq70XwMvbB/Mqoij3bLmoae17bMPcJQJhSW+PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=fiIpGZUD; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43115887867so26679035e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1728895913; x=1729500713; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=50tK4yvCZ1zBy7QMujeB5OZr1BzENlZ/OjW/RDqvA4U=;
        b=fiIpGZUDWtcLS/X8Ss3W9RUpifunZZWmkN7rbh0/R5mn+qC0+oT5VOf2k1y5VntYnF
         yZxmwVBJgqu6nsHrl1isIawjKFfiEK8gqgeT60365+6j3KFTSKmBqRQsmzfxitebFnA5
         ZKj8m12pGXyiYf4/7qO3fwdPmdRk6VNLGiFO9PboWBTAcggXZFjm0sMoO7hCvhcqXmMJ
         ZAmQe5osgccH2PHh1hw1C0EEtUkPYqSI9KfwvOYS8ko6ioKVUeiSLKtOf7DvL5jEeaN/
         CGHiPQpos0BFpsRLsZKYrXX9ssv2JmH543aDqMMUp7orASSpXBg7U1R9yfFB/mAy90BZ
         wdoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728895913; x=1729500713;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=50tK4yvCZ1zBy7QMujeB5OZr1BzENlZ/OjW/RDqvA4U=;
        b=C/l4l0c1qCmv6TEDAQGkXOWT3VH/e6EjvyLXFBa/Ah+EG5BtzZPYMQQwpth3c5JCgc
         YlwV9+CdPnzG5plhGfy38Ygvtz5qWPEJ9kfSATKdnUEZU9egoYq4RZEBt+tC9HQNwxoi
         iTxCIYL3sMR/MBFsfSOaXNtWqk6gfsPnKa15T4FUzTaYKpKRFjwarJS81yogJWZ10LJR
         Kt5oXnaSOh8+KErcObPgswEKCssVwa/1QYxMArtVSpQtQIvVIFHbu79OAAvdv7WUMh4V
         UsmRHV1cLNVJnUTfCk6QNwfu3M67jhVuXCxII+cl2mzdhHvba5GtZx/Iop4+oG/nqyvd
         6GaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVCuU9YrDX3gRTsixNNlcfbnF03VDL6tCaQkuzDllOhgQJJ9EWvZDzXMQnOzmBENtqz+BVwtpHoR6s/ck=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Ey4ImaJlKkkOSTyjJ+4N3oy/40Y1hFJBjDzB2L6UBU68bqe1
	zWte/fu4D/0USNTRle4s5d3sBR3Kdcz+j9RW8PqnoRgjUDH3vO9Td6xC2Y+b+Xg=
X-Google-Smtp-Source: AGHT+IEU0Ii92En2nBlsoOH0pa0j37alp117gc0n9MfzbJE/bM8tD/pJayX7UozgKh/NuroT/DJw3w==
X-Received: by 2002:a05:600c:5486:b0:430:56f5:4d1f with SMTP id 5b1f17b1804b1-43115a96f4bmr123435565e9.2.1728895912833;
        Mon, 14 Oct 2024 01:51:52 -0700 (PDT)
Received: from blindfold.localnet ([82.150.214.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4311835d78fsm113754245e9.43.2024.10.14.01.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 01:51:52 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, devicetree@vger.kernel.org
Cc: robh@kernel.org, saravanak@google.com, linux-kernel@vger.kernel.org, upstream+devicetree@sigma-star.at, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] [RFC] of: Add debug aid to find unused device tree properties
Date: Mon, 14 Oct 2024 10:51:51 +0200
Message-ID: <3247761.5fSG56mABF@somecomputer>
In-Reply-To: <7aq4nedii5jgrlg54kzyi3plri6ivheeo2kpxxg7q6ofr3wfsc@acsrg5rzzmzg>
References: <20241013200730.20542-1-richard@nod.at> <7aq4nedii5jgrlg54kzyi3plri6ivheeo2kpxxg7q6ofr3wfsc@acsrg5rzzmzg>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

Krzysztof,

Am Montag, 14. Oktober 2024, 09:49:14 CEST schrieb 'Krzysztof Kozlowski' vi=
a upstream:
> On Sun, Oct 13, 2024 at 10:07:30PM +0200, Richard Weinberger wrote:
> > This is a proof-of-concept patch that introduces a debug feature I find
> > particularly useful.  I frequently encounter situations where I'm
> > uncertain if my device tree configuration is correct or being utilized
> > by the kernel.  This is especially common when porting device trees
> > from vendor kernels, as some properties may have slightly different
> > names in the upstream kernel, or upstream drivers may not use certain
> > properties at all.
>=20
> In general I don't mind, but I have a comment about above rationale.
> It's just wrong. The point of DT is to describe hardware, not the one
> given, fixed in time implementation.

I agree with you, sorry for being imprecise.

> What's more, writing bindings mentions this explicit: make binding
> complete, even if it is not used.

Yes, with this aid, it is IMHO easier to find bindings that need attention.
Just as an example, lately the device tree of a vendor used the property "t=
imers",
but in mainline it is "ti,timers".  With this debug feature, it is easy to =
see that
"timers" is not being used, and somebody has to decide whether the property=
 is
really not used by a driver, or if the binding needs more work.

Thanks,
//richard


=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT
UID/VAT Nr: ATU 66964118 | FN: 374287y



