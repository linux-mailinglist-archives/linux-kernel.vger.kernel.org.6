Return-Path: <linux-kernel+bounces-430262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4647F9E2E95
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 23:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D70F72837B1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CC31E1C03;
	Tue,  3 Dec 2024 22:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DIYnxpRa"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC541DF748
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263323; cv=none; b=lzLzTbo8Su9vupyX5z2HtDAX2G5jLfHoBM+xHN4lTYbR6qvHXKAySD+RQ403df/JE9LXIr1+xQ275OndqSF0hAUOJNNe4gdySKAHs15t0WoXkI8bJPppVa4cNRhTxFvBlDq7A8nsAl4Tw3iJe16wmCSmCL+uGJnX2yNTshvQURg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263323; c=relaxed/simple;
	bh=iMjiW31JLFa/JNAGxQxIb5V7x3JFTsVdFyhdXhygqyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYCivpcnmv3nkfUCFkwHBgox9G3Yfai2BdDlsQBnkJZ714MkumtSgamDj7iD2wdPy5gscxJprtP1FjoUdcLLTA2A0dw/X6QsWJl5gbjfOr//s0dtJ3xFigLUMUv514Ifu510ym9qBOn0Jd65KeA5PZHqXL8tI5QDLIvp24I6vNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DIYnxpRa; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e3971be41d8so4563348276.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 14:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733263321; x=1733868121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7U0GjbcfzhAQB9IgZbw6IGwPJ93YtDIzJ9Nx+titdo=;
        b=DIYnxpRas/702wQjlv5JEDIagTr+a+H+yIw7foToh38+Dwek4EH9nsN5usNGShJf8k
         t7Ead+7sHfBX6d1RZAC3Zs2MJ5wDKyo6wg1WfOTD1rh8hZufN1BTNK/aoE+1dspfrT1Y
         uz9DQ7L4bAbfz0UFx+hGyQsNbyOBFeffg+S3RhGGQBhy0ZDVMBUL4SWhYLp6Dg86dbYf
         BcpscCEbZIfyRB6EK48PpLs2pZ/JIx84alNykL70nLMEvL7VBVSORTtW4jUgmtGCxmFD
         1aojfnEpSkr9zF6AyIGXP2cgKtostbDIvbhXEpwA5wAIfhwYViEEHYvsERDDkwh4tuoR
         JE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733263321; x=1733868121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7U0GjbcfzhAQB9IgZbw6IGwPJ93YtDIzJ9Nx+titdo=;
        b=Ee5VST3jBkphj/HAhjQtjpemmwNYrLa3dxDn8Xjv9FnY9ZxydZraeQlWpn1gPjSg8X
         aj0g/dzMk1QJL8jXWlv5l4UETXnrGZvHnVJQGvXDTjTZB9+Qm/SbX+MomKHhCNhOzDVq
         nhuujdKlZx4f9gPIzrASlptIF5KfG0Qnm3RUq5XxBn+gOzX7HlNqQF3Qt39Z7nUW7dsD
         4MprZcxg7ox5NxFGa4AuROWNTDPxJJu4ZpjFFAq/lSslOQtzZSOoaOEFfiOd0DAaAFWI
         GvrkJoT4X12wb1cK+KNSsDiGHZt24b+Yj4Jd1uO8k1/GQ6qtoTlUGxaptxhzpwykjLUx
         OSvQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5L1FWoF0bYjUrOIP2z3D9fmiaG7HC9KSKinUursIOJfymJBhDlCtt82ZMswz6gfmWVX3utmn9tl91WtM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk7zGE9t1ckEWwhoFp5Hs2UMjSlbquvwXnh3IP5o/hQwlHN6H8
	XVWTFXpBUvuzoFk3FShdRzPkq26z7++1TK6sHaL6clLgbTB/Im/ffE7dcabhjwpDhLsN5w/munn
	WvgViondvT7UEYyaPf5oief/UGbv37yqNVDbJ
X-Gm-Gg: ASbGncszkT/5fNiSR+AZTc3/BOWmkktJF6fAmVsk/aDC7gZxntsS0qJx4fcB3EoaRhR
	V/1kfzEJdBZ2ehNb+KsLhgo5GKW8EOg==
X-Google-Smtp-Source: AGHT+IHZWymOeLz86ZZRjaQvg6FaFEzznigeaQilocvHe2i14UK6m1/rQtTJLdasUB2xj3FxFm3j0utddMz81VPRtH4=
X-Received: by 2002:a05:6902:2193:b0:e38:b44d:a959 with SMTP id
 3f1490d57ef6-e39d43740c9mr4105929276.42.1733263320861; Tue, 03 Dec 2024
 14:02:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CY8PR11MB713438072B901F890913803F89362@CY8PR11MB7134.namprd11.prod.outlook.com>
 <CAHC9VhR6t_LLB5nc=kqqE5FpN4ftxZYidQ8F5x1Lzowf1H9juw@mail.gmail.com> <CALOAHbCz7mpxv3Dt9jJtJJ2g=A6Nf_rn687BHgOmrzQt3Udv_w@mail.gmail.com>
In-Reply-To: <CALOAHbCz7mpxv3Dt9jJtJJ2g=A6Nf_rn687BHgOmrzQt3Udv_w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Dec 2024 17:01:50 -0500
Message-ID: <CAHC9VhQAUfocUT08U99hWoKPM2F=J-F+Ph1Xeb49k1YinN8sTw@mail.gmail.com>
Subject: Re: v6.13-rc1 build errors from kernel/auditsc.c
To: Yafang Shao <laoar.shao@gmail.com>
Cc: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Kees Cook <keescook@chromium.org>, 
	Eric Paris <eparis@redhat.com>, "audit@vger.kernel.org" <audit@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 11:04=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Tue, Dec 3, 2024 at 11:35=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Mon, Dec 2, 2024 at 10:19=E2=80=AFPM Zhuo, Qiuxu <qiuxu.zhuo@intel.c=
om> wrote:
> > >
> > > Hi,
> > >
> > > I got the following build errors from kernel/auditsc.c file.
> > >
> > > The GCC version      : 7.5.0
> > > Kernel version         : v6.13-rc1
> > > The bisect commit : 286d7a54c8a2 ("auditsc: replace memcpy() with str=
scpy()")
> >
> > Unfortunately this is a known GCC bug, see the lore link below.  Kees,
> > Yafang, do you have any more information or compiler-based workarounds
> > for this bug?
> >
> > https://lore.kernel.org/all/CALOAHbBB-__eyERw82QnS3Wmgi7_BpPaacY2urVmpW=
X3ZkVtvQ@mail.gmail.com/
>
> I'll prepare a patch based on Kees's changes soon. For now, let's
> implement a workaround.

To close the loop on this, the patch can be found here:

https://lore.kernel.org/audit/20241203060350.69472-1-laoar.shao@gmail.com/

--=20
paul-moore.com

