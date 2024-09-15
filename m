Return-Path: <linux-kernel+bounces-329728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C75B97950B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 09:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7D41C2195F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 07:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D889A1EA87;
	Sun, 15 Sep 2024 07:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nUDjP21j"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD939168BE
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726385813; cv=none; b=V5CSgN1a0rnE/er7tRdGmUmYYIQTKbiWwXiCeZ8CuiZ6KSFRFYZN7ZPtkyUhkoHeErGEqerrBgtr9xqbVSFjSc494+UddSRSjKzJWtbvuDjg1fGw+PD097jRE2iO6w7Xq1XYLdWPEv58MCW+IWBRK6cBYa6VIUMGBSS0juMl2gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726385813; c=relaxed/simple;
	bh=1B7cgcS5/f/1M4cHtrtnC2A25aX2vnJFtlpIot20TV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOp4Gimb3Ux3A/NqVwYCqwJrvDpsjICUhIq2KC0F6awGyalmLtm0Nvlz0l5qOTaSevbBzHr6B4helZG/NswFyvKnlne+Bz5lMJkW+shGaV6Ithp1tpE0stHHiaNTlGwiJ0GGIVrbAizRjOUYmqC1nWZ/DXf5zvWees1JENr7TH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nUDjP21j; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6b47ff8a59aso17986047b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 00:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726385811; x=1726990611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGaXjVCO3i8LoFwZh2F36ZtmZZi6E6Y8Wmdl+xj83WE=;
        b=nUDjP21jT8L1iuAHKj8n8h0nLafmEm9iAx9M8f73iHXM8DoqeIICiX09TdorHGExpz
         x7CK+Q8r20sOHCG0yQSELcK6ZswmnrPS4KMWg3QCSIiaZbTzT8mfylIOLgQSodfERbcm
         H0hAm03Zo9y8u8IQ5UEChkGLnYbt4uNCoOPCzvi65qg+HcoERXskTN4sPD4CqvWqjF97
         09wo85w9WXfmwK5hM38pfmlGUVhrn5WXAxT+Uw16Fb9jKIsCuSILyhY3bmddx0jCTSZJ
         Z+qahvpTepUOYUsDoFLMyv2iZSEIdRhFotLF7evG7gJmv6WvYTP0M6tBwBMuZO8021Kl
         rB7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726385811; x=1726990611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGaXjVCO3i8LoFwZh2F36ZtmZZi6E6Y8Wmdl+xj83WE=;
        b=cF2lxv0zDniGrCRPURpSsA/paBQkLOhf6nmQTIZssd7uJYJ6h3imB65i/L80ZNiVzh
         hrKczbfBLHHeiZ/VzL6KLBQJdiBfnS91GbM8MB3sAOLV6ZT7eJxTlRaf2vroyaKWC05I
         f7p7Hk1wnKov7k67jpmMQ8gK3i86VDVHznh55bjqIiJ93vnVPAIjMxF3P+GXFdxmnbyt
         o/6uqsTWmXYtXU/e9U6LnN0+1a2CL/Pt5OEAedt0cf5I3ecB3ggpJDCifqApK2PcDR2+
         2IH8say2zhY7kPNMKtuK3FGJG9WQYtXiTKfnM/SWnThdq8HwD6GcMM/O+jRxUHLnWWYi
         bm8g==
X-Forwarded-Encrypted: i=1; AJvYcCXaumhnlijwvsanfIY2iceEbS1nS1Ei3Oyu3N/WATz3TynykQn50Cooj/H68Qa7tjYvvlM4/VNG0atdcxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiSat3zs2dH4cG28L4Czx/5W888HL9GG21wyORuULB1SKlscYX
	SFzR71aAG6DDik/UuEaD9KdgAG4aoz5PgtfHg2yTeqDFjpOuPmV5+vAy0tGEmOHjE4FEE8fjZJS
	woSxamnhVF8GcDcAiyxJHKfbq1629AiNsLDU7
X-Google-Smtp-Source: AGHT+IF9PmCLN/iHV4dVxFIKo2VkVmtmfRnstkhRi0tZSr57mN/5hf8sesIuPCR24W/CcD0STcSXtH1sap8TUOTYdDw=
X-Received: by 2002:a05:690c:6609:b0:6b3:f01c:9a57 with SMTP id
 00721157ae682-6dbcc579a4cmr67747047b3.35.1726385810099; Sun, 15 Sep 2024
 00:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912063119.1277322-1-anders.roxell@linaro.org>
 <20240912082307.556db015@kernel.org> <CADYN=9+OTGJtN-z_ffQx9C+UA=a_9rpF7bGtnunFJoq0BWL3vQ@mail.gmail.com>
In-Reply-To: <CADYN=9+OTGJtN-z_ffQx9C+UA=a_9rpF7bGtnunFJoq0BWL3vQ@mail.gmail.com>
From: Willem de Bruijn <willemb@google.com>
Date: Sun, 15 Sep 2024 09:36:10 +0200
Message-ID: <CA+FuTSc15f=+zC_p3seVShGMW164Mi+_a-XiSONzx7A83tEPqw@mail.gmail.com>
Subject: Re: [PATCH] selftests: Makefile: add missing 'net/lib' to targets
To: Anders Roxell <anders.roxell@linaro.org>
Cc: Jakub Kicinski <kuba@kernel.org>, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 8:45=E2=80=AFAM Anders Roxell <anders.roxell@linaro=
.org> wrote:
>
> On Thu, 12 Sept 2024 at 17:23, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Thu, 12 Sep 2024 08:31:18 +0200 Anders Roxell wrote:
> > > Fixes: 1d0dc857b5d8 ("selftests: drv-net: add checksum tests")
> > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> > > ---
> > >  tools/testing/selftests/Makefile | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftes=
ts/Makefile
> > > index 3b7df5477317..fc3681270afe 100644
> > > --- a/tools/testing/selftests/Makefile
> > > +++ b/tools/testing/selftests/Makefile
> > > @@ -64,6 +64,7 @@ TARGETS +=3D net
> > >  TARGETS +=3D net/af_unix
> > >  TARGETS +=3D net/forwarding
> > >  TARGETS +=3D net/hsr
> > > +TARGETS +=3D net/lib
> > >  TARGETS +=3D net/mptcp
> > >  TARGETS +=3D net/netfilter
> > >  TARGETS +=3D net/openvswitch
> >
> > Please make sure you always include a commit message. Among other
> > things writing one would force you to understand the code, and
> > in this case understand that this target is intentionally left out.
> > Look around the Makefile for references to net/lib, you'll figure
> > it out.
> >
> > The patch is incorrect.
>
> You=E2=80=99re right, the patch is incorrect, I could have explained bett=
er.
> I=E2=80=99m seeing an issue with an out-of-tree cross compilation build o=
f
> kselftest and can=E2=80=99t figure out what=E2=80=99s wrong.
>
> make --keep-going --jobs=3D32 O=3D/tmp/build
> INSTALL_PATH=3D/tmp/build/kselftest_install \
>      ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- \
>      CROSS_COMPILE_COMPAT=3Darm-linux-gnueabihf- kselftest-install
>
> [...]
> make[4]: Entering directory
> '/home/anders/src/kernel/linux/tools/testing/selftests/net/lib'
>   CC       csum
> /usr/lib/gcc-cross/aarch64-linux-gnu/13/../../../../aarch64-linux-gnu/bin=
/ld:
> cannot open output file /tmp/build/kselftest/net/lib/csum: No such
> file or directory
> collect2: error: ld returned 1 exit status
> [...]
>
> Any thoughts on what might be causing this?

I wonder if this is due to the O=3D argument.

Last week I noticed that some TARGETs explicitly have support for
this, like x86. Added in 2016 in commit a8ba798bc8ec6 ("selftests:
enable O and KBUILD_OUTPUT"). But by now this support is hardly
universal. amd-pstate does not have this infra, for instance.

Though if the only breakage is in net/lib, then that does not explain it fu=
lly.

