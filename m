Return-Path: <linux-kernel+bounces-197663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAD78D6D99
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 05:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D120B21E51
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 03:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BF2AD32;
	Sat,  1 Jun 2024 03:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+c4GBFq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D0B6FA8;
	Sat,  1 Jun 2024 03:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717211279; cv=none; b=ULfqoTDSuWLd2/jlMbXEJlO4yPHG4xRZLR16ksio2VVA+ll0Yj6FKqOLUburnCQQGLQ3wsiWXIhaJIAuImieC8AmdoNjaLsVvISd43FkG8LDKvkRSxH3jVBlOneA3KX4VarxNuqNmfyM9KTD+iaeNrbAIFHsZm5SdvLaD2NTPfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717211279; c=relaxed/simple;
	bh=cqaO2mscY2nvy4zNayXNs9Wfa7beJ4b5F0q/LUYBUJg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UH8JPjl78ll4CPm4YyI+8canZ+T7ig8h5VKSZ7hoNj275ITPObHdGSZr8pF6JUjWEabh3fWTD7LhA6igPoSin7+U87aMF+vA5+w75C10u1bexKOjFPSetjfwA8656c8nZBQ0HHbNtKyJLvbzDytvQd1WyC1Kvk9QQdMgrzt+XCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+c4GBFq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51E6C4AF09;
	Sat,  1 Jun 2024 03:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717211278;
	bh=cqaO2mscY2nvy4zNayXNs9Wfa7beJ4b5F0q/LUYBUJg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V+c4GBFq+AJHHmirAvekwH+/IsgVpXuVDd6U1UGAeXUfuzeuc1NLSIlYjMaCq3cmJ
	 vlysgvnRMYy6fbCPsjSDGEREJMBNvVr81YevgCzJPCPgOGhSQCTgtx5PvWT8CHBY1v
	 /yPwdx4NIBGx43SaBnJ8nQ9nGajK39IW4a7wr+Httdk1IK8Q807TYGra/c1vqiYYzZ
	 pmZbGJIe1+3iSk1eWZI8wofiJQlwGYEJ3OY6dOzqBmhN0cAena1h98Ora+uQUZpL3X
	 6LyKqzRejUYZUofbj2uZTfVapENfSC8tIJ0Ld6KeJ5ieHKyE2y5+Wyg4HZYorIkJQ6
	 ooYqqYUIs87/A==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-52b912198f1so218319e87.0;
        Fri, 31 May 2024 20:07:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5q3Wq+p8CYVIQFmj+ySuxTaY8jT0xKFO3rap+6Xz2rLgPNCzBY9MYKTBGdf83FlLjIGdO4yjzEt4O4EebpoLwXm4WGCf/rZgZXDEbN3+1y7zY1HeLZKXksqY7RNk5c0+cDQz9FlT0FA==
X-Gm-Message-State: AOJu0Yz1OO5t3fNsLh5Gr9etegxi9To1NHbh5QFBHrjwsH2q2/jJK5EH
	dsPfc8PaW0yhXuHBWkif8Ub/gPf4yER2dq8oBoAdBownKPZ3KzSEuSU2Li/8Zq87Sxq6O28IcUt
	F04nmHPflwPnn12wZE2HMXPXHYI0=
X-Google-Smtp-Source: AGHT+IFeCE4qyDl4YzuCOe6hydlRibgFllVHhxftqrceEaiCEbO5cuy+v8E7x8MdzPi9PQ5s4gSuJfAumWwUV24KUA8=
X-Received: by 2002:ac2:5dc3:0:b0:52b:88db:a554 with SMTP id
 2adb3069b0e04-52b89564ffcmr2258561e87.8.1717211277004; Fri, 31 May 2024
 20:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <IA1PR20MB4953BA3638A0839FCB0EF86BBBF32@IA1PR20MB4953.namprd20.prod.outlook.com>
 <CAJF2gTRu8WUkjOOzH4MZvinZv=0cgF988c7HyzP5jw0p3w+MWQ@mail.gmail.com> <20240531-reseal-sabbath-4994673eb98c@spud>
In-Reply-To: <20240531-reseal-sabbath-4994673eb98c@spud>
From: Guo Ren <guoren@kernel.org>
Date: Sat, 1 Jun 2024 11:07:44 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQYT+2Q4K4jPoD3X=JArKReD6O8uF4Q1o2fGqYXb2RPWw@mail.gmail.com>
Message-ID: <CAJF2gTQYT+2Q4K4jPoD3X=JArKReD6O8uF4Q1o2fGqYXb2RPWw@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: thead: th1520: Add PMU event node
To: Conor Dooley <conor@kernel.org>
Cc: Inochi Amaoto <inochiama@outlook.com>, Jisheng Zhang <jszhang@kernel.org>, Fu Wei <wefu@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 31, 2024 at 11:03=E2=80=AFPM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Fri, May 31, 2024 at 09:43:00AM +0800, Guo Ren wrote:
> > LGTM! Reviewed-by: Guo Ren <guoren@kernel.org>
>
> Please provide tags on a new line so that tooling picks them up.
> I had to amend this commit cos I forgot a signoff, so I added it.
Okay, Thx for telling.

>
> Thanks,
> Conor.



--=20
Best Regards
 Guo Ren

