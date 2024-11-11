Return-Path: <linux-kernel+bounces-403552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBDE9C3717
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 04:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C854B214B7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 03:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4890B147C86;
	Mon, 11 Nov 2024 03:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YORleJyk"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D6113665B;
	Mon, 11 Nov 2024 03:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731296290; cv=none; b=qfaYPSaSI55IS5w3ILuX/hBOuNFVwvaFxcSPLlFWVZluVcwf3OLtjb1Z0vS+r4XvENpin1/ywntEKYqiT0uI2igtjJQcgdrV6HEWJ31L87n8KjVKIcBNFpzrzfMxGNXf/U7ZbVrfZYC2bxOlBO+gP3vp4U3FsEMw5ducomEEDHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731296290; c=relaxed/simple;
	bh=ZA8OHg3+Q+KSRXretnApCX6ve8goJNJnnOgbzaePsMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zsw1FHqmLdso+oATDp766P3fGk/M7zsGHbDdffw8ssq1DyfXJtVlnSRMGMSlhWr2pChobmVe0UewKqiFfh16dZcXrzpVdmVPBUrgpGNfDjxFFxwkO47W9AeHx7eFIi/+9sz4DcXvPMXwML9gTIrl/sJxvWJynHsLpCBLEvC3SPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YORleJyk; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-539f58c68c5so6686643e87.3;
        Sun, 10 Nov 2024 19:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731296287; x=1731901087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oC4JPLCLRDYMO1RPUeNNnfQJv+4YzjVh9J6kx0DE+o4=;
        b=YORleJyklPfMfbSVi4Y4qrwHt1YwvDc9akTiDSwcsLswec1si3Fp3tB+XuigwDvcur
         PL1sL5Fs6rVTiQKI/i0Af6ztZ/c2E1kZdkrkHeRZmmmUZ5UJFjUaw5uUcNxoZeiS/oMY
         CnLE47XS0s4azvQPllSyRIsNBifblpunB+VwGKM1Pbyz6kVc7P+pBnQMDe2yHnnmqV6q
         fA2oKwjGqrRVDLHSd3Izfb2z4+96S+NCwKa4EOWEW4ul9VO2t0YsBihAsN4l5msE0+34
         0VDo8pop1FzSl4c80npfk6SZFbEaQZR7wKK8QZoCl70Gcn9b3/zVPqYvrmRIXj/YjRZ4
         M7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731296287; x=1731901087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oC4JPLCLRDYMO1RPUeNNnfQJv+4YzjVh9J6kx0DE+o4=;
        b=V44truBaYLJfWpAR/WxYj3HEQPDQcIe9Ef317HMWlADCBOzsK9+5xtj85si6OZBbyd
         l7sJ7xw4HK7R/YiEqUapPZR4nUKUNhMsR9zCtWN/0hR2+0Ml1pQTKrB+99nEKy9ifUTz
         Ph++eAZa4VCcPEJnbmV2qrkPbFV5jls2vLaUmoWTk4tXmNJTZc/iP8wvRz0OQvNwmqMf
         QXwOdig3BJJYLmmULmE1GqzYNrsJ4ol3+5EXtzHMlqm7RzCivWEpofqa48gKpe3/WStF
         oCJWIqftrdZqvsugaeJpb5K9yl1B9all24Q15Eu+Rpr6XAXSAae35W8qv7LI2DXhjrjz
         xlUA==
X-Forwarded-Encrypted: i=1; AJvYcCUpLtI8ewQLBaQLJeiAJT1LCZRhW8LZEk+q/g5117LyiXknxK/fooZ/hoEb42y+5aa8LWjAGjLKi2jksGA=@vger.kernel.org, AJvYcCWRUf7Lq32DW8eBkHmpnT+K6SLR52Crjwoqn0ovvRUardWnVdOX5iU5sCc29E5wfR1ep+Y7AwvqsDM=@vger.kernel.org, AJvYcCXANLECdg13hyS6eg23bjXfuU6iDuBJKRfOC5bqWuo5DH1u7iZ4H5lKmax1jXsApA9CBAr5RDukU5/jvxt8@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8ZwpStq+4pwyM4FT0LJ+qp/0ueUxb94RCL5Rmz31nu6Fwrt6C
	C73re7C8xDS0M8TcVhKIis2YIKCM4+gKnUegKhZ2UVcSDlAd/h0jSe2G6Ti6sacgAmCKWGIazqA
	2L1ZEU0YcmaTo7is+BX2xf66djwg=
X-Google-Smtp-Source: AGHT+IHBFDY1PibMOh+vdFnoFYfzQQKDW6n7kSjEqQSavh8wTx91d7/tUPpxAtMEp4os/dNOKl0FhhhSUSR75eZdqPM=
X-Received: by 2002:a2e:9a0a:0:b0:2f0:27da:6864 with SMTP id
 38308e7fff4ca-2ff201bc4a3mr56913731fa.17.1731296286894; Sun, 10 Nov 2024
 19:38:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107200835.3033-1-yesanishhere@gmail.com> <87cyj622oc.fsf@trenco.lwn.net>
 <274400c3-fd64-4e45-bbd2-319634a09d61@infradead.org> <874j4i205j.fsf@trenco.lwn.net>
 <70a27fe2-cc85-4f35-b24a-8e3425e447d0@infradead.org> <87v7wyznow.fsf@trenco.lwn.net>
 <109984d7-98f7-4b2a-8fee-1f7b30230a44@infradead.org>
In-Reply-To: <109984d7-98f7-4b2a-8fee-1f7b30230a44@infradead.org>
From: anish kumar <yesanishhere@gmail.com>
Date: Sun, 10 Nov 2024 19:37:55 -0800
Message-ID: <CABCoZhAaAhUhm5pvc_FgOY6LP0eS+tUUrE-tPnO3k+Xqa7GWBA@mail.gmail.com>
Subject: Re: [RFC PATCH] ALSA: Add debugging guide for audio issues
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, 
	tiwai@suse.com, Sebastian Fricke <sebastian.fricke@collabora.com>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 8:53=E2=80=AFPM Randy Dunlap <rdunlap@infradead.org>=
 wrote:
>
>
>
> On 11/7/24 2:25 PM, Jonathan Corbet wrote:
> > Randy Dunlap <rdunlap@infradead.org> writes:
> >
> >> I see a few possibilities, none perfect:
> >>
> >> a. in Documentation/driver-api/debug/  [not quite driver-api though]
> >
> > No, it's not API stuff, and not limited to drivers.
> >
> >> b. in Documentation/core-api/ along with debugging-via-ohci1394.rst
> >> [maybe in a new /debug/ subdir]
> >
> > Again, not really API stuff.
> >
> >> c. in (new) Documentation/debug/ and invite the kernel debugging
> >> community to add some of their docs here as well.
> >
> > If we really want to separate the mechanics of kernel development from
> > the associated process information - not always an easy separation, IMO
> > - we could make a top-level "development" directory, put a lot of the
> > other relevant stuff there, and include the debugging stuff.  It seems
> > really weird to put debugging by itself, though; it's only part of the
> > picture.
>
> I could go with that.
>
> >
> > Why is Documentation/process so bad?
>
> Documentation/process/ is meta-documentation about kernel social "standar=
ds"
> among other things. It is "soft" documentation, whereas debugging (IMHO) =
is
> "hard" documentation.
>
> But hey, it's all your baby. Do whatever pleases you. :)

Jonathan, wondering if you want to me to go ahead with your suggestion
of merging on top of Sebastian patch?
>
> --
> ~Randy
>

