Return-Path: <linux-kernel+bounces-258624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E14EB938AA2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 10:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A175E281742
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F43E17C6C;
	Mon, 22 Jul 2024 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gahwQ+0y"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B605F282FE
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 08:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721635322; cv=none; b=tgXOiNqS7VdSj5QgY8yJLAu0V+xq2ewJG1UBPOa8uXjqOgLXgQXoOHasCKMJ7c7PGlVXcwBgSnx9JD7e2Q3briIhOyfsrWf/1PNQJSTIGIrpCriFoxAxEimhZCyUMgksu2gXGPP0AgLBK+YWGQLUYo+SjospzoD2lN66Enf9cbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721635322; c=relaxed/simple;
	bh=0BirbRm+kgTZ/6PSUV3ulLz8ivD6qWRaU/XrHJu0rnc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdcioxVZ2Bn/NnfQ5YLhPe2Py6x9YSjUW8/UX7h3zCWS7L1D6XwtJmACyLoCcGoZxyMUYCyzD33teuOcYcC1wzd+G677kAs8l3BIa0g8uWVrqem5n+LS5sDcta+IJxRdm5VERnIpMCrwEzIsGCNzOxvcBc6cCXdahS42vzg9CXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gahwQ+0y; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52f00ad303aso1304739e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721635318; x=1722240118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6b/8hE5ThHqalqFhzwrKVICTF1CGDaYIS8tWzxne3NU=;
        b=gahwQ+0ye9ATWPzfa6hMl6BLNsERMBMCvyLIwamly5eoLpLSExdOdSSoXiqyVp3+v+
         Y8oghO1stD3ria8p4SXdPHB74WEdbdGoJ80Z3l1/UsImU1IIe8io5OQrTLN98Iy1tQPh
         3oIWpMAaD9DnQvi1OZH9+8kGn1GOmePT+AMMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721635318; x=1722240118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6b/8hE5ThHqalqFhzwrKVICTF1CGDaYIS8tWzxne3NU=;
        b=G0y6i5nZqPjl+CNmH4Md09G/lWaRFELfWqBAfqEMKNFRE4lWT8TBtzF17I645a3itB
         +jSza8nxi+rGmXWOEk3qfiQXHUmlX2tWgxAaoMYvPB8DhTXZ16woAWP9ft9jPueZOkmo
         YYBXKUHPhGsn3MIGcabB19x2B+Yd4wqzuueo79F54pSSvhsvdQzAtQ8GHPUbIUfQqz3H
         +vLOvb68i6fu1kV0LXJwIhxBFPsxFCC0/drfPAuCVZXTqqKW+a9twO1IOCwMsH7zH/5W
         UawoyFcpLSPH2hoWkN2pUy1ln1wv6D+K3ObP6KCqLfnrWL0QV94mTFQ9jbIiboBA6WBl
         CUsg==
X-Forwarded-Encrypted: i=1; AJvYcCWeSiKVgcGPCkadSUpXMgGDqTK8wqZEMLoSUrTYn95XlydhGvGcYcxAP9Cw33/o4yJXI4S/9AXeUD9A33Z5J7vnGdOCzxIP30BwOl/Q
X-Gm-Message-State: AOJu0YyFYBJlZSSenV0hsAmb+vyuFmLbQjYpGzRaMoqS6rlfAliyh9m0
	gjzcqGCHV5Xlop98wP8PwlzW8JYBxHorPI0ryAC/U9Lo6qtHAMHn/yW0yX1f60e4tLoN3EEX3C5
	R4Q==
X-Google-Smtp-Source: AGHT+IEemdM7dlowYb7c9o79+tpX9QceVXZbrKipIlAuS1MPtw3do4wR0X6GrUNfSum0PmPPQKKmFg==
X-Received: by 2002:a05:6512:a84:b0:52e:f9f1:c139 with SMTP id 2adb3069b0e04-52efb89cc71mr3340528e87.58.1721635317833;
        Mon, 22 Jul 2024 01:01:57 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a8077c1f36sm1005744a12.51.2024.07.22.01.01.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 01:01:57 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso3261602a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:01:57 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWFBk65lmg7jNNiKP4ROkyACkL3EpYeRoM2yBo3GX5S/8S5jMxvpv/qGTH8eaMu0PynCDMZVLoxKAWurGAqnzeaWYGg7fzQyXLUq9a1
X-Received: by 2002:a17:906:7315:b0:a6f:586b:6c2 with SMTP id
 a640c23a62f3a-a7a4c44efb5mr426001366b.60.1721635316929; Mon, 22 Jul 2024
 01:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <af462e20-d158-4c5c-8dae-ce48f4192087@molgen.mpg.de>
 <2024071939-wrought-repackage-f3c5@gregkh> <20240719093819.GE12656@pendragon.ideasonboard.com>
 <2a2cac3c-f9cd-4b20-ae53-9e6963c7889f@molgen.mpg.de> <518cd6b4-68a8-4895-b8fc-97d4dae1ddc4@molgen.mpg.de>
In-Reply-To: <518cd6b4-68a8-4895-b8fc-97d4dae1ddc4@molgen.mpg.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 22 Jul 2024 10:01:42 +0200
X-Gmail-Original-Message-ID: <CANiDSCuPR8LryVVhodJKFoYh6xGLGo47_XJ3Oqt9+nz84JfpYg@mail.gmail.com>
Message-ID: <CANiDSCuPR8LryVVhodJKFoYh6xGLGo47_XJ3Oqt9+nz84JfpYg@mail.gmail.com>
Subject: Re: Linux logs error `Failed to query (GET_CUR) UVC control X on unit
 Y: -75 (exp. 1).` (75 == EOVERFLOW?)
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Greg KH <gregkh@linuxfoundation.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, linux-usb@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Paul



On Fri, 19 Jul 2024 at 14:31, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> #regzbot ^introduced: b2b5fcb1c5b645d5177ef3e3f41c7a706fc2688d
>
> Dear Laurent, dear Greg, dear Ricardo,
>
>
> Am 19.07.24 um 13:33 schrieb Paul Menzel:
>
>
> > Am 19.07.24 um 11:38 schrieb Laurent Pinchart:
> >> (CC'ing Ricardo)
> >>
> >> On Fri, Jul 19, 2024 at 08:05:35AM +0200, Greg KH wrote:
> >>> On Fri, Jul 19, 2024 at 07:22:54AM +0200, Paul Menzel wrote:
> >
> >>>> Today, starting the Intel Kaby Lake laptop Dell XPS 13 9360/0596KF,
> >>>> BIOS
> >>>> 2.21.0 06/02/2022 with
> >>>>
> >>>>      Bus 001 Device 004: ID 0c45:670c Microdia Integrated Webcam HD
> >>>>
> >>>> Linux =E2=80=9C6.11-rc0=E2=80=9D (v6.10-8070-gcb273eb7c839) logged U=
VC errors:
> >>>
> >>> Does 6.10-final have the same issue?
> >
> > No, it does not. Linux 6.10-04829-ge2f710f97f35 (Merge tag 'ata-6.11-rc=
1' of
> > git://git.kernel.org/pub/scm/linux/kernel/git/libata/linux) does also
> > not show this, and 6.10-rc3-00148-g8676a5e796fa (media: uvcvideo: Fix
> > integer overflow calculating timestamp) neither.
> >
> >>> If not, can you use 'git bisect' to track down the offending commit?
> >
> > I am on it. I tried to pass the USB device through to a VM and try to
> > reproduce there. Thank you for the comment, that reloading the module i=
s
> > (of course) also possible. That avoids rebooting the system.
>
> The hard way found commit:

Thanks a lot for bisecting the error.

BTW, besided the error messages, the camera was working fine correct?

Could you check if this fixes your issue?

https://lore.kernel.org/linux-media/20240722-fix-filter-mapping-v1-1-07cc9c=
6bf4e3@chromium.org/T/#u

Thanks!

