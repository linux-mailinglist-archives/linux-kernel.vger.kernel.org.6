Return-Path: <linux-kernel+bounces-376764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0F49AB5A2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 857101F23809
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26E901C9EA5;
	Tue, 22 Oct 2024 17:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="NzUTKapk"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8261C9B6D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729619931; cv=none; b=RpdpCnFkVhUACGWFgsJXfgnHGXXk3oKy28ZunVLlJPJZCHWwjqIRpTByh9vRSfkSyHsDXEr6UbpzMvrUdPwHoeL63hebQAghawkPzt8Mne9fduDHPz7LGioj4Ut0H0s5NJVOr0bO8IE1Sa8JB8d6haebPoOSJnDf9lLmpH6NBX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729619931; c=relaxed/simple;
	bh=bzWd8rKalKLnCDEJXyAj/PFeqHxExSaBmYI1WaZdk80=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oaJPKxs+JPM3kC8Eyln5SYpdh5sAIvBfI4yix9LCGRPCJkbM2BKugtP2wboQSs3pSfyHTul4DP4XqRytdWqEMlm45uc6zEi021CSWzw9QFk/7yvn1r0zFBdTnEam5eW9FNcZ9iFPIzTUeNzuZ6BC4p5md4WJxPfQuj6hup0MWgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=NzUTKapk; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b1539faa0bso390297285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1729619929; x=1730224729; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bzWd8rKalKLnCDEJXyAj/PFeqHxExSaBmYI1WaZdk80=;
        b=NzUTKapkmGYBrvJAuyTdg00GeIUINpWtujuL8VgJnW87iKpzrT22j3YO8vYIEdUuAv
         iDhMLEvMMyIt5gD1PcSVE4eX6x7tLm+JAhwIfUC5jN8ir0Vcsfil6FI69a4UtZxlIrCb
         wBl0L9xO7vIDLeX6ROx4AFf62eEVesqZO+TwiRATmCwS8JwD1YAxy2ZCs2O2GtrXyUcv
         2mSzfkcDz0kl9CZciKkiWCG/V/eMoIAbqjaGhfiX+ZdVKOrONQhRRQO2JibHfjaz3T8r
         cmze/ECPhOr3mKoPiOaMsXwSrd28+ulMGIsf7lnWepWVat8lTgEyZvdzmbtVs4mHFWoC
         R0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729619929; x=1730224729;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzWd8rKalKLnCDEJXyAj/PFeqHxExSaBmYI1WaZdk80=;
        b=QPdCnOpM5HrC1KKCBHOalQ6TTD996mQ5YX1vRxXSJOR9l7eB7tMndgEq+Ww/+l9NpW
         fNwKlEzVBCfpfpgeM7oaiCTNaDm6jd1Ao5V2kvkEiSUxre8yI4Ge9tv9k2ZJL0ZuS2bk
         8ebBMeKUTeFvkYLT3iO6sfMEghwO53mUYY7+550CjFlni4KlfvLSL739i3Y/oPvzFQwJ
         2PjPPhg3nNpe9gUHyf7bXomaxMmISXKoAo/TyJCIfnQ/4X+huhxNILQZkrG7aKO4nz/s
         O1/EOwI1r6+AbwaewqXwXmqzZBHBbFqhb6PP4OItQr5zcgsEJAP1lzbdZ5Q66RTV1pCb
         PhFg==
X-Forwarded-Encrypted: i=1; AJvYcCW81Qe9xs2cOvtG2/2JsUpGtivSXvcID6+pAKGh9KLgBJMhjWtFpJvy66J3OJTJjbRVinwlaw7QtQN3CK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEIxR689jKK37HFwHW52/fwPIzgwSADPR3iA+LIRncqZYO6hHo
	1rGJ+3mV5z1AIha3bmd+ruxHX5915m+uzhYs4UU4wfVriVIX20Gc/WfEL+BYPQQ=
X-Google-Smtp-Source: AGHT+IFdA/p619PkELXaREfuUW3E6V0uE6dktYYNp3frR0HpWhrRRTYooq1Sbx8ODU8q4H36RgRX0g==
X-Received: by 2002:a05:6214:3991:b0:6ce:305e:324f with SMTP id 6a1803df08f44-6ce305e3471mr15960826d6.23.1729619928754;
        Tue, 22 Oct 2024 10:58:48 -0700 (PDT)
Received: from nicolas-tpx395.lan ([2606:6d00:15:862e::7a9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce009996e0sm30984706d6.82.2024.10.22.10.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 10:58:48 -0700 (PDT)
Message-ID: <f8831b4e658b19a1df4cc02449bb74d730908de6.camel@ndufresne.ca>
Subject: Re: Requirements to merge new heaps in the kernel
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: John Stultz <jstultz@google.com>, Maxime Ripard <mripard@redhat.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
 "T.J. Mercier" <tjmercier@google.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,  linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org,  linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Date: Tue, 22 Oct 2024 13:58:47 -0400
In-Reply-To: <CANDhNCoLgzy=CPBWjBKLiJzRdnf=SS3AgtFJNB-CBYAo=UEQJA@mail.gmail.com>
References: <20241022-macaw-of-spectacular-joy-8dcefa@houat>
	 <CANDhNCoLgzy=CPBWjBKLiJzRdnf=SS3AgtFJNB-CBYAo=UEQJA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le mardi 22 octobre 2024 =C3=A0 09:19 -0700, John Stultz a =C3=A9crit=C2=A0=
:
> On Tue, Oct 22, 2024 at 1:38=E2=80=AFAM Maxime Ripard <mripard@redhat.com=
> wrote:
> >=20
> > I wanted to follow-up on the discussion we had at Plumbers with John an=
d
> > T.J. about (among other things) adding new heaps to the kernel.
> >=20
> > I'm still interested in merging a carve-out driver[1], since it seems t=
o be
> > in every vendor BSP and got asked again last week.
> >=20
> > I remember from our discussion that for new heap types to be merged, we
> > needed a kernel use-case. Looking back, I'm not entirely sure how one
> > can provide that given that heaps are essentially facilities for
> > user-space.
> >=20
> > Am I misremembering or missing something? What are the requirements for
> > you to consider adding a new heap driver?
>=20
> It's basically the same as the DRM subsystem rules.
> https://docs.kernel.org/gpu/drm-uapi.html#open-source-userspace-requireme=
nts
> ie: There has to be opensource user for it, and the user has to be
> more significant than a "toy" implementation (which can be a bit
> subjective and contentious when trying to get out of a chicken and egg
> loop).

If there is a generic logic to decide to use a carve-out when using some
specific device on specific platform, it would not be a problem to make
userspace for it. I'm happy to take DMABuf patches in GStreamer notably (wh=
ich
could greatly help ensuring zero-copy path).

But so far, all the proposals was just a base allocator, no way to know whe=
n to
use it and for which device. The actual mapping of heaps and device was lef=
t to
userspace, which to be honest would only work with a userspace Linux Alloca=
tor
library, with userspace drivers, or inside mesa if the devices are GPUs/NPU=
s.
This is a project Laurent Pinchard have hosted a workshop about during XDC.

Nicolas

p.s. libcamera have device specific knowledge, and could of course be a sho=
rter
term user. Note that major distro are not happy that there is no memory
accounting for dmabuf, bypassing sandboxes and limits.

