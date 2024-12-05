Return-Path: <linux-kernel+bounces-433965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C76B19E5F95
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 21:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7427018855B1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 20:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1691BD012;
	Thu,  5 Dec 2024 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBvOxmqu"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C39901B219E;
	Thu,  5 Dec 2024 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733431249; cv=none; b=qS16sYIJNYcTMSsHxPwjASgToBJnQ/nLxW6AssFnhOy/VFLxB0P+KQBRExaagDaQc50J3ce5Cjkxpm0itLDn6ZjlRiuorFeUiNSmIT+Ht4W7mNyCwJ9PDCT8AssJKndTQ7MC/9hQUDLFEq0jKh1+Nfk4wTzlR4twVu0zsgTBpp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733431249; c=relaxed/simple;
	bh=cImm4lkrvGL63icY61PYdEGKBL1xKijlWS+XG6nPkgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6TexnMymQnXwCINKJ16Vrg1n4uq+TI4ux3tORnT4LoBFOhVtBdFuDjMfws3jQKpLekOb5BmQFa75Q2TsIOjmjjekMSsY3r2A7AHtZELUkGKhft5gdlr8Zb/kcwLJgqqgq6nJzUgcpCbP1mkuk1MwCwO2DI60Zd4pu/H5hO4kl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBvOxmqu; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ffa49f623cso14094321fa.1;
        Thu, 05 Dec 2024 12:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733431246; x=1734036046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cImm4lkrvGL63icY61PYdEGKBL1xKijlWS+XG6nPkgU=;
        b=SBvOxmqu7YOIEnqsjzOXkDsFavDjYa5wIG92O2l2GAHPGLRwyFAnIP4ovKd1bYIPS/
         c3oA5GdCEDJL8a4xJ1rxdBj9Kj/dfNj7Uufm0G/3BZjCcNc4uN0Lg3YWnYnrAXkYSXaE
         fkxUtjmw5YcEkD3bgbvGiI8cFw7rSwEpkvAeTxbpr89bT7bEqgEcuVYkBsEfRzJqmtk9
         WJ0XWJF9QweUnKbg2pPXQ89LQDNp9qFD+6+0A5WRhgZHDecyKdoVucipnSMdnQW40o0y
         p4ssY7h24yR0CXA3wBFZmGnMQ2HHzeL1QIcW+KH6nDvL2JVcfnWwg2yf8k3S9A5wf1QL
         pA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733431246; x=1734036046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cImm4lkrvGL63icY61PYdEGKBL1xKijlWS+XG6nPkgU=;
        b=R6F8d6AYhnj+FW+6fvS2msZiyQZXVsNXE1yBHCopwThp+sdsr0jz4VILQ6izo5/gLL
         Ic8RtMANjps9Hrfe7xXJMNurBXqqI7bRZnTKDUv26rJufHwOUzH8o+ghmDCz7PFjDZua
         ySUqaDmeyvk7JrLXIOJ/3SU5sob9Ev/Mq9jh/oOVQSVhz4Wl+ftfNXfdFIW9W52I7qRd
         7M++KnkAtkce1CcH7uJJBc86VXY2gWTARzkG58qsHih5Pxxo2v+vSwYk26yeRe88LWYI
         xAFvcIGCnN2kCp99e6zRUT5AQSbXLDAieqDPQjtfJIoHThC7ClwilR0ErYAFJsYLnDBe
         4HfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0ibtFvm7zF9ZQ8Q5uH6r5SK/VsCZyPPGxg8p/CEjwtOZWDO9NR+axAUBZtNjScZNQnDa3af5hlSgx0KUW@vger.kernel.org, AJvYcCWE7dFPAdgWwgngA/aUiZ6lO6nEFXvFLgfHqAoa37rlB0emPANNfL34eYp6uC878Ju70eNMyOfKCpw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/0+MCc09OpStdDJ9Yfl2nq9KNLsOWZ7j8ai0TnQLTZLOOyY3C
	ylAW69PGUuCaB6TZ9ulyCCdBET3Sx0Mi6DtZbndT8TuRpjT8XsdxlUk1bPPSA/TOZAcfAXHwLFl
	Re017RG2BHHaeLTqCdI+Z7RevBhA=
X-Gm-Gg: ASbGnctS1/mRLvysHQUl+KfkJU6T8A8mczTXVvJd5R4qpZT124URpFxatOCC/bj39KY
	FvMct9k9eP1RfjbuTPxsi8wglqAitL3g=
X-Google-Smtp-Source: AGHT+IFu7xNB3lApKAFpWK30vqQiZShTcNflG6f49wCzzAuTeIKGotRc/kUNnrqSDZvSmUVF52z5lt2gPurkpEM2MXE=
X-Received: by 2002:a2e:9a0e:0:b0:300:2a48:fb63 with SMTP id
 38308e7fff4ca-3002f89e390mr1351021fa.6.1733431245689; Thu, 05 Dec 2024
 12:40:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241103025436.69196-1-yesanishhere@gmail.com>
 <CGME20241108043735epcas1p39b2350911bd630f58be192c1680acd5c@epcms1p4>
 <CABCoZhANKY5wjc=NqAd64Fhmdjx1k-x=zVkU+ySRDRvK0Gj2iw@mail.gmail.com> <20241116052130epcms1p4f503dac1338c96ff33f8e5d7d58d6389@epcms1p4>
In-Reply-To: <20241116052130epcms1p4f503dac1338c96ff33f8e5d7d58d6389@epcms1p4>
From: anish kumar <yesanishhere@gmail.com>
Date: Thu, 5 Dec 2024 12:40:33 -0800
Message-ID: <CABCoZhC7uRcV5if0PnfPkVFtyE-b=_9SQCvs7dBbpQY3VLu5wg@mail.gmail.com>
Subject: Re: Re: [PATCH] Documentation: extcon: add documentation for Extcon subsystem
To: myungjoo.ham@samsung.com
Cc: Chanwoo Choi <cw00.choi@samsung.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 9:21=E2=80=AFPM MyungJoo Ham <myungjoo.ham@samsung.=
com> wrote:
>
> >Hello Myungjoo/Chanwoo,
> >
> >Wondering if you have any comments?
>
> Nope. It looks good to me.
>
> Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

Thanks, wondering if I need to follow up further or it will be picked up
by you or chanwoo?

>
> >
> >On Sat, Nov 2, 2024 at 7:54=E2=80=AFPM anish kumar <yesanishhere@gmail.c=
om> wrote:
> >>
> >> The Extcon (External Connector) subsystem driver lacked proper
> >> documentation. This commit adds comprehensive documentation
> >> explaining the purpose, key components, and usage of the Extcon
> >> framework.
> >>
> >> The new documentation includes:
> >> - An overview of the Extcon subsystem
> >> - Descriptions of key structures
> >> - Explanations of core functions
> >> - Information on the sysfs interface
> >> - A usage example for driver developers
> >>
> >> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> >> ---
>

