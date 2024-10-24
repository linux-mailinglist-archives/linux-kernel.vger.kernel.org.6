Return-Path: <linux-kernel+bounces-380766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5732B9AF5C0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 01:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87F951C20A18
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 23:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF91218D7C;
	Thu, 24 Oct 2024 23:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VIeomGTd"
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEA112D1F1
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 23:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729811690; cv=none; b=gCk5EQvlHslTYV08YniZSls5Yn3Na9CLAUkf7jPZg9TsqoBkyZbcbWi5q7sWmqhAci7lNfR2+gibOoEkeALBtFdhqChjuHe4BaAaa2LENXLbcpYBCRXAucZ0O6malAWWVEc5paX9OiX0Ws/JVQrmL/8WeX6dNLY8xTZ+GkHXRMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729811690; c=relaxed/simple;
	bh=uvS/43Pc3miYvswBEwB0EqgDLZD4RN/c7+aF/faXJYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l5bO+XIWbFOkfYbEjm/AaleS6LrfrLx7IKImlxAuwAfPo7N3J+fCamNl6iEWzK/4aHRggviIyc770OCUNUDF2hBOdkZKK5Po72R8DWlg8zlwgb5PinKNZOPEPQTm/wDBuu+Pc7DITYUFQUuIdTlGzCSigKLk+thKafuY8jH5O0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VIeomGTd; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e3b7b3e9acso13342817b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 16:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729811685; x=1730416485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6TbZMHZYY06WP3040Ly2qJFOtFeyhe5zuLR+4zyx04=;
        b=VIeomGTdlyAwPFS0R3zDH2G2C+BvWCKgr0H7/IgwfGW6xvFTbAw3p4WdCTvXCtDtB3
         KtgycE/IhtRQIKph+0v0t4v9TnkHFVXbcg5ZOo9NB/aZ+E1PuEua0FzAoVOvSTdrJTHI
         6NSGNu7cqprI3y+RG4OFSmzE9xdDzWvttFWaPowMEeZ1DqzbKdmhOu5uTTCCRHA47Zxv
         Qaqn6oaUMPW3Oa2MDbN/KkAeXSXnh5gz8bMgNfLo6ZivUw4H2dVrXeJ2yu+aggISJrkR
         RUUmsVwTZBBwviuk7tYaNeVMyktlh1C7NUZ99xjJKUH/GI/0y2Y0/qVG6al/HTE+Lr5d
         fy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729811685; x=1730416485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6TbZMHZYY06WP3040Ly2qJFOtFeyhe5zuLR+4zyx04=;
        b=UTIqsecfDPeSuMDLXye5HSAyJBA5k41/f+8swo8Cqzvnh1JNImOFpoOQCcFiRZDg5q
         VrZ5A5fPoxnAJUSPCwRdT8G0tQC9eyZhvF584t16dIL+mD8U5yPdJMtGgyD9H9aLVGAW
         fHv5IKCSGTjW/uCb4QFlCUio6J5bw+RaB1KVLouEuD9aAvMRtfCYPkL0jJ4E22e8MxVh
         jExmN7qERpiAhfA5BYT5g7aXaktY0f5+2Xs7QVeTIn0hVpZr85UPXIl6EYO4bH8J4yrc
         tPjGfSoRsRky1vUH5vo6Cxgg8hpOH0N3vNe7yDxU9XMG98xqx+lnEim3XLXNTmWDcWeP
         rl3A==
X-Gm-Message-State: AOJu0YyG5ZGqpLLINDkcjIkFxjlwR9w+3TLvhr541ISNKK1NbgoUaQn6
	vpPQxfq5t9qrXC1fhJyy/lmNm+O0+XvTrTdz5nlMHAqE8HiNEhBu0B/imUz6IcJwk50WFXIV4o5
	cn2QMxxg5ss788E03CaqmR8sC2JVE/pcYqgUFHAtIkNK90DU=
X-Google-Smtp-Source: AGHT+IF3GSzVY98XIC10KA1hIjigEbv2BeG5pxaHdP771xzcqbTKQ1039tChfEsGSuWPRbwE6IGXRlkJBIlfoCDHYUE=
X-Received: by 2002:a05:690c:300c:b0:6e5:9dba:68b5 with SMTP id
 00721157ae682-6e7f0fd8096mr69047627b3.39.1729811685583; Thu, 24 Oct 2024
 16:14:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002142516.110567-1-luca.boccassi@gmail.com>
 <CAHC9VhRV3KcNGRw6_c-97G6w=HKNuEQoUGrfKhsQdWywzDDnBQ@mail.gmail.com>
 <CAMw=ZnSkm1U-gBEy9MBbjo2gP2+WHV2LyCsKmwYu2cUJqSUeXg@mail.gmail.com>
 <CAHC9VhRY81Wp-=jC6-G=6y4e=TSe-dznO=j87i-i+t6GVq4m3w@mail.gmail.com>
 <5fe2d1fea417a2b0a28193d5641ab8144a4df9a5.camel@gmail.com> <CAMw=ZnSz8irtte09duVxGjmWRJq-cp=VYSzt6YHgYrvbSEzVDw@mail.gmail.com>
In-Reply-To: <CAMw=ZnSz8irtte09duVxGjmWRJq-cp=VYSzt6YHgYrvbSEzVDw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 24 Oct 2024 19:14:34 -0400
Message-ID: <CAHC9VhQOY-T1hJqf+9hvdtA59ZEdrwhN9Kz-=1KbzcGTyhTQjw@mail.gmail.com>
Subject: Re: [PATCH] pidfd: add ioctl to retrieve pid info
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 7:56=E2=80=AFPM Luca Boccassi <luca.boccassi@gmail.=
com> wrote:
> On Wed, 23 Oct 2024 at 00:45, <luca.boccassi@gmail.com> wrote:
> > On Sat, 5 Oct 2024 at 17:06, Paul Moore <paul@paul-moore.com> wrote:
> > > On Fri, Oct 4, 2024 at 2:48=E2=80=AFPM Luca Boccassi <luca.boccassi@g=
mail.com> wrote:
> > > > On Wed, 2 Oct 2024 at 15:48, Paul Moore <paul@paul-moore.com> wrote=
:
> > > > > On Wed, Oct 2, 2024 at 10:25=E2=80=AFAM <luca.boccassi@gmail.com>=
 wrote:

...

> > > We are running a little short on devs/time in LSM land right now so I
> > > guess I'm the only real option (not that I have any time, but you kno=
w
> > > how it goes).  If you can put together the ioctl side of things I can
> > > likely put together the LSM side fairly quickly - sound good?
> >
> > Here's a skeleton ioctl, needs lsm-specific fields to be added to the n=
ew struct, and filled in the new function:
>
> Forgot to mention, this is based on the vfs.pidfs branch of
> https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git

Thanks.  I'll take a closer look at this next week.  In the meantime,
do you have this patch in a tree somewhere publicly fetchable?

--=20
paul-moore.com

