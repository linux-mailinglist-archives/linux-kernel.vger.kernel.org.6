Return-Path: <linux-kernel+bounces-448199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C708D9F3CC8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FBF6167F7E
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 21:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21EE1D5141;
	Mon, 16 Dec 2024 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FgngwnpA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C441D45EF;
	Mon, 16 Dec 2024 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734384555; cv=none; b=ivbQpf9gq4/iVUUhMMGrMfaVPtQkkrLv3GzZ3IYJLUzet8KYs9NMmanL1nge8dlQi3Df9015JEPEuYU71nnX5A2vebG9JYH9leNR6pXcDlWV3h0ft/f4LnydCsmz2nKXerPsixew+Cl9IT3UgWSDvnP8aVhQV16UVQHlS9lruUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734384555; c=relaxed/simple;
	bh=gSIkmQCfHAzfwQuK4HNufI9qqE47okTGD+4fZMKhvVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GKZxUgN3ZXovQIiIZGMfM0BAJijKn27cTFqrbguo88SLT3PSU9PZueHQWM8L3pmwk81lEydM6kZfK2kpXYEyBPGTsgU8sCFiHi45ucQ4MXjFcIJYWWjLQka/dkK0+tkfe2zMQvfTwh9EhbI0nHLYOsxL5fqGx5/SVv+jn1+OVNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FgngwnpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82954C4CEDE;
	Mon, 16 Dec 2024 21:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734384554;
	bh=gSIkmQCfHAzfwQuK4HNufI9qqE47okTGD+4fZMKhvVI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FgngwnpAy4dJ1/Bdonwwadswg4dp/7ewSVKduK83LWZarEmB/tv4cEVAjivoik0Vw
	 vGzWkN/9Ad16ViQZ6tamNez5FLgdRrPd6vlAZ0gDo7GzOAS8LI09zweJ+t4ZT12aZM
	 vjd1+eSG8kisu4rynsSB3hlQhuGYFZR9t1X6AqphBIjoCFk1/TteL8dGdl0AQ3rua+
	 fXw7eXHyaB8RB/PTecGHJztk4Km+tUNIiniirD4uQDEdUFMZxjS3f2pG5ItyczkQkf
	 rzVp3MkTm2YpFogVD3Np/0ZF+P8tkSzRH1ADxixYu/v6CqLTW/hqsaxVJr4tY6ELs3
	 I7Jf7RhuAHaNg==
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e39779a268bso3664005276.1;
        Mon, 16 Dec 2024 13:29:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFLEoLi11sGuaA3sBNqNjsGPFVjF3R5XX5KI4oHgt/cQEAPfeMe6hfnkySZXVd6y6snF6MtGVPu+hT@vger.kernel.org, AJvYcCXMgC9JK3FCSqVQrlKHZeKnB+tVpAOXEp+pStLKbwdR5Q8xwzo3aboGszgacpOyRNk4wB4PVg5ontu3C593@vger.kernel.org
X-Gm-Message-State: AOJu0YzbC6+99Ajj7NUdyroVTSiadWv10jsU0RDVuVrsus6WEUT6gWji
	3pp2KLWOcOriwkucVP4o/Vs0mizfxDMMndKc6sEWvpFdzCwjaVZlppl8PbPhElab+nF5m4rgAut
	0akTkHd27s736052LHUHJqttV9Q==
X-Google-Smtp-Source: AGHT+IEP/jmghN1XQi1lCBd4PO2HRxUyz85ZXt3joP1h/+tMxVtMDfbCMqGhrAqpeJ6tnfwGMQ4V3AAz6XY0T7VnN7M=
X-Received: by 2002:a25:6b0d:0:b0:e38:2a3b:ea58 with SMTP id
 3f1490d57ef6-e53299709a3mr1068435276.20.1734384553651; Mon, 16 Dec 2024
 13:29:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241216-of_core_fix-v2-0-e69b8f60da63@quicinc.com>
 <20241216-of_core_fix-v2-2-e69b8f60da63@quicinc.com> <CAL_JsqKa62-OGHYb9ZLf_s+iMoyAtdazFeMuoz_1Hvz7Qkzeiw@mail.gmail.com>
In-Reply-To: <CAL_JsqKa62-OGHYb9ZLf_s+iMoyAtdazFeMuoz_1Hvz7Qkzeiw@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 16 Dec 2024 15:29:01 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJEqm_=SZcs4rczuTthhHMY+ntXkixtcDdRfKfSqhbwcg@mail.gmail.com>
Message-ID: <CAL_JsqJEqm_=SZcs4rczuTthhHMY+ntXkixtcDdRfKfSqhbwcg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] of: unittest: Add a test case for API of_find_node_opts_by_path()
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Saravana Kannan <saravanak@google.com>, Maxime Ripard <mripard@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Grant Likely <grant.likely@secretlab.ca>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zijun Hu <quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 1:23=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Sun, Dec 15, 2024 at 6:41=E2=80=AFPM Zijun Hu <zijun_hu@icloud.com> wr=
ote:
> >
> > From: Zijun Hu <quic_zijuhu@quicinc.com>
> >
> > To test of_find_node_opts_by_path() take @path argument with pattern:
> >
> > "alias-name/node-name-1/.../node-name-N:options", for example:
> > "testcase-alias/phandle-tests/consumer-a:testaliasoption"
>
> The test passes with or without patch 1 applied.

Sorry, an error running the test on my part. This and patch 1 applied.

Thanks,
Rob

