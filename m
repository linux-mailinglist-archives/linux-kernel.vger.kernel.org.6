Return-Path: <linux-kernel+bounces-263007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC8A93CFBC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D6BAB237E0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0974117799B;
	Fri, 26 Jul 2024 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mvlqX+CE"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969C277F11
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721983134; cv=none; b=sa7sCgjv5EzC2ok+GEEFDin6g6+WX3bHBH+VO8RTlJhwI/vlqh+ubQcWOGVu7OwGi98/WgfGdZZVWUwxNdjCAZC4ZycbWGFWKFOR1oPp4xVdTB+OR7PIAF4tmC7KJdMSYmbpGi+/0/1m1d3B+dI5N58wl2ZRJ9ZjsRhcMhiOmec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721983134; c=relaxed/simple;
	bh=7AC3Io4Kt9BTDyWoNjxZ+pYRus05WYj+r0HbJ1+e7Zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uX5yE2y/57PRDgZ2HvizIz511Acz5CVgnv91UVfxLHkTrluIxsT5TB61zqDMWmF76KVXTf2UXAa5vhhhdfGDmcsGmABfkLb3LKeXE3HqjMW8Hf1YA/SIx9FXGMKgjkinKgizeWlVlXE0G9vfmxChYOxMOrR6FCwYdo0JhV1mN6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mvlqX+CE; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-8223f0614b6so120186241.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 01:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721983131; x=1722587931; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pZJmKdKLNSWaXA2BcuG9HwA3qZIS9BmYVk7uzNf6lpA=;
        b=mvlqX+CE4gPt00k5v6io3IPnVrE6ynGSLvwS2EHjdbqBaD4ew0NckHg3eNr8zGOUa4
         osHTRK+eh4/64ZX8iH2f5/9bJ+Xg+Ep/OEkO2YJMU/Hhe1iuMKZJMGWUjZ0LIr9XTjSE
         mEdDopw3uyegMVPzlhAfum+QMV1G4mz9ujMgPY2mLx5ZMlE2i/ocgRT/bsXjCAX+23w8
         CnsJbPeRuKFMMJM8qs4qTz0PdEyMWQj+b6djfQnSDTyY4JzXOmZQlP1TwhwAR+v/O/x9
         x/k66iEY4fxC1BO/ogLsvriSDLnDhnyzOLAjveszcE18sjz4x+YmCDOEYgK29WO/75FJ
         jg6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721983131; x=1722587931;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pZJmKdKLNSWaXA2BcuG9HwA3qZIS9BmYVk7uzNf6lpA=;
        b=fcRwUntFxrO0Upcgaoe+oE+kr00LL9kQ8iwZAzF0tUVVEv94PBmlkvUODcFcWZ9tyA
         4SLTW3zYtf0TFYDWB4oOrqPtx1e2ClkdHlw+C1BeovplCM7PZYJ/I9OIPpG9boGtTe2F
         rEstQIYNr3NLwarhDwdtzOecUhEaDyq2V/i5OEw4ytDhn0tis+1E0etH9JcSb53yYu14
         Dvs48DKMEiCEZlleJPhvvN5fAILIlEi5KiVQCDGWztpDqiZbOeERgW7zCyxD4g80whUa
         TMl+O9bNYxnXHCyXYapinxtfGlwXgUXPq/7M5PmH8dJRdeuF8RTgb15RoG7ViAqOSx6a
         aGow==
X-Forwarded-Encrypted: i=1; AJvYcCUUMsK0YAzSyPs8OAy1IHzk+LeeTvGgTUoa0J8Ll2RYRDIkuc14oeZaV+ch4hlZF2q+lf/ydLb4SfSUQuMz9QoOxsKeYoQjOv6wqorp
X-Gm-Message-State: AOJu0Yztzds3gYUHDoyR0gIFBm2MvyfdQcMKkpRMb8l+/DPabNRPhL5T
	9uRShyrn9xkYo+4i2vXwQxERkX94vvpPY3KO+A3kd1p2p9zz3zdpV/qol19Cp8ThOUXWvWSHYm6
	WSpW46s+1FGVrkF6C9JRRJbla5WQ6CHpWSjMo
X-Google-Smtp-Source: AGHT+IF8iWTh7DzXW7vu2uBQSe7BEb4YfC0rN9WlsW4xPwpj1weMX+fzAgT4q3Nh4F140wvi8BfU2ZkkeRutUx+hgVg=
X-Received: by 2002:a05:6102:3350:b0:48f:dfb3:f26a with SMTP id
 ada2fe7eead31-493d64737f9mr6876725137.15.1721983131330; Fri, 26 Jul 2024
 01:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725174632.23803-1-tttturtleruss@hust.edu.cn> <a6285062-4e36-431e-b902-48f4bee620e0@hust.edu.cn>
In-Reply-To: <a6285062-4e36-431e-b902-48f4bee620e0@hust.edu.cn>
From: Marco Elver <elver@google.com>
Date: Fri, 26 Jul 2024 10:38:13 +0200
Message-ID: <CANpmjNOiMFUM8KxV8Gj_LTSbC_qLYSh+34Ma8gC1LFCgjtPRsA@mail.gmail.com>
Subject: Re: [PATCH] docs: update dev-tools/kcsan.rst url about KTSAN
To: Dongliang Mu <dzm91@hust.edu.cn>
Cc: Haoyang Liu <tttturtleruss@hust.edu.cn>, Dmitry Vyukov <dvyukov@google.com>, 
	Jonathan Corbet <corbet@lwn.net>, hust-os-kernel-patches@googlegroups.com, 
	kasan-dev@googlegroups.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jul 2024 at 03:36, Dongliang Mu <dzm91@hust.edu.cn> wrote:
>
>
> On 2024/7/26 01:46, Haoyang Liu wrote:
> > The KTSAN doc has moved to
> > https://github.com/google/kernel-sanitizers/blob/master/KTSAN.md.
> > Update the url in kcsan.rst accordingly.
> >
> > Signed-off-by: Haoyang Liu <tttturtleruss@hust.edu.cn>
>
> Although the old link is still accessible, I agree to use the newer one.
>
> If this patch is merged, you need to change your Chinese version to
> catch up.
>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>
> > ---
> >   Documentation/dev-tools/kcsan.rst | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/dev-tools/kcsan.rst b/Documentation/dev-tools/kcsan.rst
> > index 02143f060b22..d81c42d1063e 100644
> > --- a/Documentation/dev-tools/kcsan.rst
> > +++ b/Documentation/dev-tools/kcsan.rst
> > @@ -361,7 +361,8 @@ Alternatives Considered
> >   -----------------------
> >
> >   An alternative data race detection approach for the kernel can be found in the
> > -`Kernel Thread Sanitizer (KTSAN) <https://github.com/google/ktsan/wiki>`_.
> > +`Kernel Thread Sanitizer (KTSAN)
> > +<https://github.com/google/kernel-sanitizers/blob/master/KTSAN.md>`_.
> >   KTSAN is a happens-before data race detector, which explicitly establishes the
> >   happens-before order between memory operations, which can then be used to
> >   determine data races as defined in `Data Races`_.

Acked-by: Marco Elver <elver@google.com>

Do you have a tree to take your other patch ("docs/zh_CN: Add
dev-tools/kcsan Chinese translation") through? If so, I would suggest
that you ask that maintainer to take both patches, this and the
Chinese translation patch. (Otherwise, I will queue this patch to be
remembered but it'll be a while until it reaches mainline.)

