Return-Path: <linux-kernel+bounces-436373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DACD9E8518
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 13:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0743316229D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Dec 2024 12:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601B8148316;
	Sun,  8 Dec 2024 12:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuLnFpQY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCF845BEC;
	Sun,  8 Dec 2024 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733662078; cv=none; b=MBX+tspuz6BjzNkY4UJHJ/WCZp2NRTZbSC2XAK0wTEjcmFo6v1XaWmBG2N4atQ3zHdx5qJ1TdtZd2fcVBo727Pp0yCa058Ww9PBDMg5op2Kb8UT7SgUQtju4LaIB3Ro9zpDI1ciDWhgUjcDb27vViQawt+LQv7yGV+YIZ8+H/Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733662078; c=relaxed/simple;
	bh=ljR09SNerocdWnP/UG5g69/zFqz/bw4tPGb75DTGSfs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lGBbEmBruB7/Uj05IacbHElH/19uPVAm24P5jQXkZ38GoedJ7FSTVk2caAoT0aRF4AzRFI+ZsTEleMGEwadw+t657vTh3nLWtOv3Pape9/QeY/Xw0nhSXjqXeEuI7wVGdX0OkD5HCR0vtinVe3QcCm3LMQLtG5n0N23V39knvSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuLnFpQY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D7AC4AF0C;
	Sun,  8 Dec 2024 12:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733662078;
	bh=ljR09SNerocdWnP/UG5g69/zFqz/bw4tPGb75DTGSfs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VuLnFpQYyMjAZVlNhgHCpxivgd0nwV1mz46mX0ISAdqdEpWbzXc80byzAuKO6D+XK
	 kqLvtrHuujxLAFfO3dkNE1NCpb5Gej04GdP/1kIVh20jL2O1EmJyoy093mHV0y24NQ
	 5o1SHu864DeP3FxyTB1E4Wvl55grQ3rPe+gFhf/f13pNfoKibyIADrDYL2dcVDpxA3
	 uTZI+vNDiGZBHvDdVYGVFM7iP9i+6EWM5T7lsgEmqSobc9G1SLCjp1XRthIUVZsI5o
	 XsEjjKIvuP5yl3MX5+jYH9A26jCiGU+r1zuIfwwnM6lW58hkHzNGQeEVzdJjNyh86v
	 lYlcl7OUKk9Lg==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5cece886771so6350311a12.0;
        Sun, 08 Dec 2024 04:47:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWgrMRUNty/H+jD1X3Hj2+9nHZ2qFYl0B6C6XlCKEdRWp0gj+hG/wUJXqX1amDalNvMnlLUvatw3wYgTj9G@vger.kernel.org, AJvYcCXw93oil+1AbEUAH1YuWd70gyADtnUgcPbHS51yeGFr1VpMGeCdt9rclX0y9NbwGIlUTUjqfd+jTz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws8PalqmKIE5h5X4QmlmbgnNN/60vf71RwhA52RY48J8EytMdj
	dGWHA52BWwl8cjZApJmX+Uww5q5AmhbZAXbJD5m7hdI3VRJ0kEz3TmujHEzsexYLibBSGNh5FyE
	CUeUL+KznuRAcUXKlM0WWStrvnIc=
X-Google-Smtp-Source: AGHT+IF6afwWusvK3yGY6ywNa7NeptN2+8OxzLlZj0IAFpUnEbjZLbxH8IaPcdkBM3LX1gSlCjdC9cFqDBNpEyul5go=
X-Received: by 2002:a50:ed01:0:b0:5d3:d2d0:12c9 with SMTP id
 4fb4d7f45d1cf-5d3d2d01355mr5940729a12.8.1733662077026; Sun, 08 Dec 2024
 04:47:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241103025436.69196-1-yesanishhere@gmail.com>
 <CGME20241108043735epcas1p39b2350911bd630f58be192c1680acd5c@epcms1p4>
 <CABCoZhANKY5wjc=NqAd64Fhmdjx1k-x=zVkU+ySRDRvK0Gj2iw@mail.gmail.com>
 <20241116052130epcms1p4f503dac1338c96ff33f8e5d7d58d6389@epcms1p4> <CABCoZhC7uRcV5if0PnfPkVFtyE-b=_9SQCvs7dBbpQY3VLu5wg@mail.gmail.com>
In-Reply-To: <CABCoZhC7uRcV5if0PnfPkVFtyE-b=_9SQCvs7dBbpQY3VLu5wg@mail.gmail.com>
From: Chanwoo Choi <chanwoo@kernel.org>
Date: Sun, 8 Dec 2024 21:47:17 +0900
X-Gmail-Original-Message-ID: <CAGTfZH0cbxSwEk9cFimvx9zg_5KAOVP4V-0EAQyB7kQwXsSbBw@mail.gmail.com>
Message-ID: <CAGTfZH0cbxSwEk9cFimvx9zg_5KAOVP4V-0EAQyB7kQwXsSbBw@mail.gmail.com>
Subject: Re: Re: [PATCH] Documentation: extcon: add documentation for Extcon subsystem
To: anish kumar <yesanishhere@gmail.com>
Cc: myungjoo.ham@samsung.com, Chanwoo Choi <cw00.choi@samsung.com>, 
	"corbet@lwn.net" <corbet@lwn.net>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for your documentation.

Applied it. Thanks.

On Fri, Dec 6, 2024 at 5:41=E2=80=AFAM anish kumar <yesanishhere@gmail.com>=
 wrote:
>
> On Fri, Nov 15, 2024 at 9:21=E2=80=AFPM MyungJoo Ham <myungjoo.ham@samsun=
g.com> wrote:
> >
> > >Hello Myungjoo/Chanwoo,
> > >
> > >Wondering if you have any comments?
> >
> > Nope. It looks good to me.
> >
> > Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
>
> Thanks, wondering if I need to follow up further or it will be picked up
> by you or chanwoo?
>
> >
> > >
> > >On Sat, Nov 2, 2024 at 7:54=E2=80=AFPM anish kumar <yesanishhere@gmail=
.com> wrote:
> > >>
> > >> The Extcon (External Connector) subsystem driver lacked proper
> > >> documentation. This commit adds comprehensive documentation
> > >> explaining the purpose, key components, and usage of the Extcon
> > >> framework.
> > >>
> > >> The new documentation includes:
> > >> - An overview of the Extcon subsystem
> > >> - Descriptions of key structures
> > >> - Explanations of core functions
> > >> - Information on the sysfs interface
> > >> - A usage example for driver developers
> > >>
> > >> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> > >> ---
> >
>


--=20
Best Regards,
Chanwoo Choi
Samsung Electronics

