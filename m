Return-Path: <linux-kernel+bounces-330310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AD07979C72
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 10:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4367B228C1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 08:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A3D13BC0D;
	Mon, 16 Sep 2024 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OADd1aFU"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5E5256D
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726474105; cv=none; b=WeBYLLJMn4BvGGPDaVH1Qu33O+blJejFPk0aTVnkeXkQwIrPbBGbwY3bmtN2n4blaTxV2p0r0CV03DGlf2c03Dz+3QQoB5fIUgeMisbmf76+4V6jFr2pR5dKXAz2I1QyD1nEG2ExFer6/PH2kL5u54K80XpKDolTq9yTO1iTLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726474105; c=relaxed/simple;
	bh=xvWOgGhr06YrjQpWY6uecZoD9WlV683oa1tQnmbVya4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XnE6nvZ7Yzw+T+c+6Gi67M0U0vi8/mRFrjleXYlF0AJoZ1b/CGgkBrGC7PxsB9v+RkJqHwdWXnR7PAPLU8rD3eXiD7FADZ9EwKbFG8WQlD7Vv+tjBVxmrULoRzYkrxjxysfwHN6IPKtT7MtpXv9dKAgOdNHTfwLS99ssLIw9sqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OADd1aFU; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6d6a3ab427aso28811217b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 01:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726474103; x=1727078903; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0+8g6W9Xy7DC9ahNTGaEIXFMvMobpS3AWPeOGTLD28=;
        b=OADd1aFU4Elq4XFQZptzSDBRtYzbXEFCFFO1NXyCTFDxbLe+DfGa18ObwDCj2Pe8ho
         xFzr6/2rXPfJmBqd5s8eOb9t/woLTw49YouOMtVpmgbP9ypn6daUnpW+s0szQMQQHYuS
         73g4C6NL4JXGMalnxgDOkc/sbM0pk/svctwkQw7Lst5TB6upct522f+rGT5EEZXbxTRh
         FgC/U3rDWBw3M8zVq8d5kp1Yg47SsRT8ar0ZA4Zum4Y7jsx5BSjUr7Ndvh+fl66E4Z0i
         SwjTSMk/sJYt2M++EPgygVXD5X2Q3NzqLoJBCp62F+hO5MMI0+D9Ls6x6pscuAgFNHNd
         uY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726474103; x=1727078903;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0+8g6W9Xy7DC9ahNTGaEIXFMvMobpS3AWPeOGTLD28=;
        b=rvqF973ojeMx/tPCTceFpK5DrV1fUVCf2YmhQmih6OHpsJUUOkE/Raq31p3ktMVUAD
         i4w/I15Tp6VnIDjLiBp7xfgucYDXCV9SzabaEAL0tLZzi+STztUgeJz3RF4NHeMVde2X
         HfbfsRnwWO4Khj4FHQjBKzR9AZM4h33BYJt3fpEmLqGXuwmkbjX5hTbje06tNoEn9bzI
         SaQgSI90VKnSqVkqeyYA+dkLQI+GaLZqsFhstb9KluDY4b6yvOl/gMTD+Sj8w/XBu/RB
         PR1Ui8mZi7HGlemtC9YUZ1Y08a+Xv2dstPRpFVxvHt/eH5FKKJ3oa1PjeRNWWbQzfPkT
         YeQg==
X-Forwarded-Encrypted: i=1; AJvYcCUBc05OKq0LbgoXdEWFAZkAltU18h+SG2q1dXKchTlq1n/btckgXWudXCNp31EzkpMKAUzZ9i34sejCkqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyehyw8qRco1WihVJHrDS5RtYeYoTbFjzfwVbPz3prMHeGLzTqk
	Rzftz7y1dI6irDeI/QLUmpPhTgX/EfJ02sgkCppQ+ZqTMzuSUgvpVSGxvjuOv/1EaISfb3fLmsP
	rHr2i1iZFbiYXJUE7C+yAYCInL1q9PYyWm3BT
X-Google-Smtp-Source: AGHT+IEtjQWvWBNnu/4Nm2e4jVNcENFMN8zZXbALCj2BpwB1jQ4SS9xrt+8GM3EUi/xA8h9UtzFmswreoUCjhv4fSDY=
X-Received: by 2002:a05:690c:92:b0:6dd:d5b7:f33e with SMTP id
 00721157ae682-6ddd5b7fa95mr5442187b3.33.1726474102738; Mon, 16 Sep 2024
 01:08:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d15ee1ccfb91bda67d248b3ec70f0475@paul-moore.com>
 <960e740f-e5d9-409b-bb2a-8bdceffaae95@I-love.SAKURA.ne.jp> <69e4014e-0a34-4fde-8080-4850a52b0a94@I-love.SAKURA.ne.jp>
In-Reply-To: <69e4014e-0a34-4fde-8080-4850a52b0a94@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 16 Sep 2024 04:08:11 -0400
Message-ID: <CAHC9VhQq0-D=p9Kicx2UsDrK2NJQDyn9psL-PWojAA+Y17WiFQ@mail.gmail.com>
Subject: Re: [GIT PULL] lsm/lsm-pr-20240911
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 15, 2024 at 8:38=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2024/09/14 0:28, Paul Moore wrote:
> > I find it somewhat amusing that you are complaining about the LSM
> > framework not accepting new LSMs in the same pull request where we are
> > adding a new LSM (IPE).  As a reminder, we have documented guidelines
> > regarding the addition of new LSMs:
> >
> > https://github.com/LinuxSecurityModule/kernel/blob/main/README.md
> (...snipped...)
> > While I have no intention to negatively impact out-of-tree LSMs,
>
> What I call "patent examination" is "New LSM Guidelines" section within
> that link. That section includes "here are a list of requirements for
> new LSM submissions:" and "The new LSM must be sufficiently unique", and
> out-of-tree LSMs which cannot satisfy it won't be able to become in-tree.
> If we apply this requirement to userspace program, this requirement means
> you are declaring that "postfix" (or anything except "sendmail") cannot
> become in-tree because "sendmail" is already in-tree. This is a clear
> intention of negatively impact out-of-tree LSMs. People have the right to
> use whatever subsets/alternatives. Even if a new LSM has were completely =
a
> subset of existing in-tree LSMs, people have the right to use such LSM.

Comparing userspace applications to kernel code isn't a fair
comparison as a userspace application can generally be added without
impacting the other applications on the system.

> While I consider that some of out-of-tree LSMs being unable to become in-=
tree
> is inevitable, the requirement that any LSM has to be built-in is a barri=
er
> for LSMs which cannot be built-in.

Anyone is always free to build their own kernel with whatever code
changes they like, this is the beauty of the kernel source being
available and licensed as Open Source.  You are free to build a kernel
with whatever LSM you like included and enabled.  You have been shown
examples on how to do this in previous threads.

> People have the right to install whatever userspace software / kernel mod=
ules
> they need.

Anyone is free to build their own kernel with whatever LSMs they want,
either in-tree or out-of-tree; the static call changes do not prevent
that.

> > My focus is on the upstream Linux kernel and ensuring that the upstream=
,
> > in-tree LSMs have the best framework possible to ensure their proper
> > operation and ease of development/maintenance.  While I have no
> > intention to negatively impact out-of-tree LSMs, I will not harm the
> > upstream code base solely to support out-of-tree LSMs.  Further, if
> > improvements to the upstream LSM framework are determined to harm
> > out-of-tree LSMs, that shall be no reason to reject the upstream
> > improvements.
>
> I have been asking you for a solution for "in-tree but not built-in" LSM
> (namely TOMOYO). You are refusing to provide a solution for the sake of
> "in-tree and built-in" LSMs. The "static call" changes fails to ensure th=
at
> the upstream, in-tree TOMOYO to have the best framework. The "static call=
"
> changes makes the upstream, in-tree TOMOYO to have a worse framework than
> now.

As mentioned so many times before, the "in-tree but not built-in" LSM
problem is entirely a distribution/binary-kernel problem.  The
upstream kernel community is not responsible for the choices and
individual build configurations of the different Linux distros.
Support for mechanisms which allow for dynamic LSMs in pre-built
distro kernels is something we could consider, but so far everything
that has been proposed has had a negative impact on the upstream
kernel sources and has been rejected as a result.

--=20
paul-moore.com

