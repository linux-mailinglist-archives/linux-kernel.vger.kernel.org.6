Return-Path: <linux-kernel+bounces-301735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2516695F4D4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 17:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A4328298F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 15:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94647192599;
	Mon, 26 Aug 2024 15:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZziDy4YE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D470B1CD25;
	Mon, 26 Aug 2024 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724685285; cv=none; b=FjKz9/7iPSc+rR+pfhekk2cpPPm0tTTEH0XxlOyOHwY/UqVBkICoKVHwKWOQ9XyoziS9w6/17QKOSKfmFrDSy/CP76+gAd4+XnZaDAwnyxqMAO4phvOPbRoOukB3beMbsoyrdVFAz0qZhuOUkIRykULKSxek0p59iae1PM/HRoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724685285; c=relaxed/simple;
	bh=o3AayVgPDQ/fox0ISFsYAhB9fqQj/kPZyYVlO4sDUHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s1sExDdpEbu3EPlCRnkrV++C9o38wR9iyWuNqK0YVlRsYsu1C5fRDo/AwkC7A8TssN/8qQq+a7AnwXTaRx8hyT3KSaCQt/wc/SP/DAIYT52VDDp7lSfFMHBewGmln9PtUEzZ0nlDgRE5TvDq0UGnim+WwGZkg4m+RMdO1ufdHwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZziDy4YE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82903C567EF;
	Mon, 26 Aug 2024 15:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724685285;
	bh=o3AayVgPDQ/fox0ISFsYAhB9fqQj/kPZyYVlO4sDUHg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZziDy4YEOHUWNQO+QUizoZNYSJRMoBiH8SIfNm84pma0oFlCfpM0uv5LLW4Og98m3
	 8INiZ8+C+LtgRavQ6ql7jzEedyovlePUngdr3VvBpiUMhqW63DXKTUN085iNJDsK/K
	 n1NCdMQ9wOgbfYe0ALWmA/ftHLfuHx4Uyz+Xx1ihnHS8N+4+6dTzV/WaBRBJ5UrQ+U
	 SAL1gcUUadvSFGbOC/4JHM9cBJSASMkTeXBCwrsoSTkpYscYkepXTrNyD2NlcHBPEC
	 E2yjVM7FpuUeQlhAQELHiqKVw4114OVH4XVJnwQ2gjwZstAfT+epuDCdIskYIN/TDr
	 bdaCELiI4mtBw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53438aa64a4so3982146e87.3;
        Mon, 26 Aug 2024 08:14:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVk7NF1Z1jsEgexV2AjFmwmEcqi5wfsDnj6B4dQqmqm4lFBTLSl936H0heaCT+d53M9rcxYSsnxBhQj0vuf@vger.kernel.org, AJvYcCXIjsdJ7zHHxXb3DFDxwryCA+MwpS3/E4kIVjIPTPvnW+K/4onnyOu3RcNXtpAPu1RgzzlrVKHWf2J9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0UrgNHeUUSL8Wtk5RRt7AWY80v01Bp7c4t529A4n6qrAY5WQN
	rJTgOq45QYXs3VaPU0UPZrSTRJ2GTqBn9kZqUU2epw50iHrMXug1djrl9GwXCzwM1GbVqQCIXXK
	bVy+vClrz8E/0sRw1Wj9K/v6oiQ==
X-Google-Smtp-Source: AGHT+IH+fKCQFUE4FScy/Z+auyBZ3EA1T76xBgwCZosuSWBo7h2RErteaofa1l0foA1ZuPS1tDMsDFOkzMo5SOouT9s=
X-Received: by 2002:a05:6512:3056:b0:52e:97b3:42a1 with SMTP id
 2adb3069b0e04-53438831f6cmr6690306e87.24.1724685283873; Mon, 26 Aug 2024
 08:14:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821-save_resv_name-v1-1-b9c17f103ffb@flygoat.com>
 <CAL_JsqLeVPBz4mEedXEm=rb6ghWwROB7jr-PDw3qVsNRz20Z_A@mail.gmail.com> <c0df4919-21b4-4526-8861-f74234ffd390@app.fastmail.com>
In-Reply-To: <c0df4919-21b4-4526-8861-f74234ffd390@app.fastmail.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 26 Aug 2024 10:14:31 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+=KPKqkjd1JFNGJRKgF-FQPM=+we+09EnY3AQVGkP-6g@mail.gmail.com>
Message-ID: <CAL_Jsq+=KPKqkjd1JFNGJRKgF-FQPM=+we+09EnY3AQVGkP-6g@mail.gmail.com>
Subject: Re: [PATCH] of_reserved_mem: Save region name string into struct reserved_mem
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	Huacai Chen <chenhuacai@kernel.org>, Kevin Wheatfox <enkerewpo@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 9:22=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoat.co=
m> wrote:
>
>
>
> =E5=9C=A82024=E5=B9=B48=E6=9C=8826=E6=97=A5=E5=85=AB=E6=9C=88 =E4=B8=8B=
=E5=8D=883:09=EF=BC=8CRob Herring=E5=86=99=E9=81=93=EF=BC=9A
> > On Wed, Aug 21, 2024 at 8:51=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoa=
t.com> wrote:
> >>
> >> Previously only a pointer to fdt string pool is saved to struct
> >> reserved_mem as region name.
> >>
> >> As on some architectures booting FDT will be wiped at later initialisa=
tion
> >> stages, this is breaking reserved_mem users.
> >
> > What architectures? Be specific.
>
> It's LoongArch and MIPS, I'll expand commit message.
>
> FDT might be placed in .init sections or memory not managed by kernel, th=
us
> it may be wiped out.
>
> >
> > Why is the FDT wiped? It should be preserved and you need it later to
> > implement kexec.
>
> So KEXEC is using kernel's self copy of FDT created by unflatten_and_copy=
_device_tree(),
> while reserved-mem scan is performed before copy to ensure that reserved =
memory
> are being tracked by memblock before possible memblock_alloc in unflatten=
_and_copy_device_tree().

The FDT being copied is not the same as 'wiped out'.

I'd rather update the pointers when copied or eliminate the need to
store them than introduce an arbitrary max length. Though if name
comes from the node name, then that has a max of 63 already.

Rob

