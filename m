Return-Path: <linux-kernel+bounces-389025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 483759B67B0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 16:25:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9017EB2368D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 15:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F5F21313C;
	Wed, 30 Oct 2024 15:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FrhzbvM5"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF8F213EE1
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 15:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730301571; cv=none; b=Vf8Md9ERQDd1ZYuN7dt/dpyzuYNv3u7wJ8dHiVg6zMZ5x3JyIUzJv+ZM+25kSJnxwee3gIk4AmiGS+rPNY6reu7uDObjIrThae9ewwxW0JR7GlsGKYvoZ4QL9SnAps6vm2j8fl+6nrNgGllh4HnLi7xDDjBfUw7yOV9tNN94tCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730301571; c=relaxed/simple;
	bh=lJnGuusQCAELCp7rqkmBqFsUdmlzbjlJEOwppjDChmY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MhdjYM6eDJYw3nmtb5qtlffBAJKtditsKRWWzMUuO5r70lJx+MWR9jIs4+KWQziWtHkVm6ytiYP5qjEp4+vuUeQorsmJPV3W9X+vzgJaQEgAiXmXhkS8Xs5bhO2OUcM7fRazHKy9sMtCXkktW2R3cpKnJnGG0aB6SRK8Ip98yws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FrhzbvM5; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460969c49f2so319951cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730301569; x=1730906369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8svNofplrG2Q6V5+9hfVfJTbtmZizG7D9AXysNLGCE0=;
        b=FrhzbvM5rX86CvZcNatYjq0eN/6N2MDAodE+TiouLaIKzw55rM2FwitrTsltFdOkzN
         S43yhjM+f0pL8CEtddnkix8tl9MKpmnTbIa6bDq8YrfLrICONrjjdEsbvoa3Sq6DbaBg
         NpWkWb3mx/n18ZJvjxutU2XMZJSJPi9UreHKPokG4ahYFgN1Pa6TvnIfzNZ4ro6EYChJ
         f9vX3DdG7DhzVoZhwuF6/LSxwX+71qw72kHtwQDQqo2ygd7AaF234OhXUgQqVyJPRFh/
         9q3VMdr0IG30oSoGlXSe5LhZRhFQNlebbl+DW/TSKRU2u6u5SDM6inIYc8b1WSI6o5i+
         SQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730301569; x=1730906369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8svNofplrG2Q6V5+9hfVfJTbtmZizG7D9AXysNLGCE0=;
        b=eAJ4tvfp7hyfANGiyfmusjylbpsheRRDs5uQEbflybiI1/kAblt9NXayb2lINkgrai
         bIdDZFXCPMaJ7Rld9PKNc2JEVAOqBMfZVPTbTQTY7OhTEZ9LdBAbPC54VvAW1W2R038U
         6FoXX+mqGOm7WfgTh7R14Bos9eSZKlGnl14sCdxdpdGpVjkLcXcaNoKD63YQj+YLROhQ
         tzcuF38O5bC5RdtFyHWQ8a64TZJK7cAMCXkcpR9GeDIcvzmvxqi/L92StmQ+17ZusiF6
         0otmcSwV50ve9jouj9ip6khJTRjSGVwecGgKnukOQh/rqvAgngzVhsak6FMM7l7aWIZw
         hWyw==
X-Forwarded-Encrypted: i=1; AJvYcCVCmDDml4M4x3d/ePbf/nbBwPy2NIkd7NA/AMIE3559xNBP8KezleKJo/u9kakuG9KFDO+U5bJg0YpgmG0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxjvGzQ4hDGYjaLaJjx0PcItCqj13rIifPaKL7jYbxLyu4fHS+
	XVgYaFqQn8JZKBxI2xYSL55FP/Kyjgl6hC9pxUW4k4kZW8VARzYhEC8uCLVvHadn/Q9LAO99mnz
	Ga7QhnvqCv2N4iz18IBXYkWA4adBi3oTbdMG/
X-Gm-Gg: ASbGncuePmghYZoG7Wi/+DgjZ51uw3WSUvHBjJY7GZEzlD7cG8DVuZUUdYr1IShu//l
	k8NAlV5+vjPRRjCwf3ysM2FKZvZlKk4U=
X-Google-Smtp-Source: AGHT+IE/yEH6zX+iddMnL8L5gybyWZzy+HVsRSlydG/ggXxEumZX5LgIE3lQOa8f/K9UZie0EgbC3H5cMcOhq0THBss=
X-Received: by 2002:ac8:776a:0:b0:461:6727:253f with SMTP id
 d75a77b69052e-4616727292amr6108901cf.24.1730301568454; Wed, 30 Oct 2024
 08:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030142722.2901744-1-sdf@fomichev.me> <CAHS8izOBp4yXBg-nOSouD+A7gOGs9MPmdFc9_hB8=Ni0QdeZHg@mail.gmail.com>
 <ZyJM_dVs1_ys3bFX@mini-arch>
In-Reply-To: <ZyJM_dVs1_ys3bFX@mini-arch>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 30 Oct 2024 08:19:16 -0700
Message-ID: <CAHS8izN6-5RJgKX08sgntYDVgETkBGpgoYToq8ezcy+tYHdaSA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 00/12] selftests: ncdevmem: Add ncdevmem to ksft
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	andrew+netdev@lunn.ch, shuah@kernel.org, horms@kernel.org, willemb@google.com, 
	petrm@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 8:13=E2=80=AFAM Stanislav Fomichev <stfomichev@gmai=
l.com> wrote:
>
> On 10/30, Mina Almasry wrote:
> > On Wed, Oct 30, 2024 at 7:27=E2=80=AFAM Stanislav Fomichev <sdf@fomiche=
v.me> wrote:
> > >
> > > The goal of the series is to simplify and make it possible to use
> > > ncdevmem in an automated way from the ksft python wrapper.
> > >
> > > ncdevmem is slowly mutated into a state where it uses stdout
> > > to print the payload and the python wrapper is added to
> > > make sure the arrived payload matches the expected one.
> > >
> > > v6:
> > > - fix compilation issue in 'Unify error handling' patch (Jakub)
> > >
> >
> > Since I saw a compilation failures on a couple of iterations I
> > cherry-picked this locally and tested compilation. I'm seeing this:
>
> Are you cherry picking the whole series or just this patch? It looks
> too broken.
>
> > sudo CFLAGS=3D"-static" make -C ./tools/testing/selftests/drivers/net/h=
w
> > TARGETS=3Dncdevmem 2>&1
> > make: Entering directory
> > '/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/=
drivers/net/hw'
> >   CC       ncdevmem
> > In file included from ncdevmem.c:63:
> > /usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/.=
./../../tools/net/ynl/generated/ethtool-user.h:23:43:
> > warning: =E2=80=98enum ethtool_header_flags=E2=80=99 declared inside pa=
rameter list
> > will not be visible outside of this definition or declaration
> >    23 | const char *ethtool_header_flags_str(enum ethtool_header_flags =
value);
> >       |                                           ^~~~~~~~~~~~~~~~~~~~
> > /usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/.=
./../../tools/net/ynl/generated/ethtool-user.h:25:41:
> > warning: =E2=80=98enum ethtool_module_fw_flash_status=E2=80=99 declared=
 inside
> > parameter list will not be visible outside of this definition or
> > declaration
> >    25 | ethtool_module_fw_flash_status_str(enum
> > ethtool_module_fw_flash_status value);
> >       |                                         ^~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~
> > /usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/.=
./../../tools/net/ynl/generated/ethtool-user.h:6766:45:
> > error: field =E2=80=98status=E2=80=99 has incomplete type
> >  6766 |         enum ethtool_module_fw_flash_status status;
> >       |                                             ^~~~~~
>
> This has been fixed via '#include <linux/ethtool_netlink.h>'
>
> > ncdevmem.c: In function =E2=80=98do_server=E2=80=99:
> > ncdevmem.c:517:37: error: storage size of =E2=80=98token=E2=80=99 isn=
=E2=80=99t known
> >   517 |                 struct dmabuf_token token;
>
> And this, and the rest, don't make sense at all?
>
> I'll double check on my side.

Oh, whoops, I forgot to headers_install first. This works for me:

=E2=9E=9C  cos-kernel git:(tcpdevmem-fixes-1) =E2=9C=97 sudo make headers_i=
nstall &&
sudo CFLAGS=3D"-static" make -C ./tools/testing/selftests/drivers/net/hw
TARGETS=3Dncdevmem 2>&1
  INSTALL ./usr/include
make: Entering directory
'/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/driv=
ers/net/hw'
make: Nothing to be done for 'all'.
make: Leaving directory
'/usr/local/google/home/almasrymina/cos-kernel/tools/testing/selftests/driv=
ers/net/hw'
=E2=9E=9C  cos-kernel git:(tcpdevmem-fixes-1) =E2=9C=97 find . -iname ncdev=
mem
./tools/testing/selftests/drivers/net/hw/ncdevmem

Sorry for the noise :D

--=20
Thanks,
Mina

