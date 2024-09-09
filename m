Return-Path: <linux-kernel+bounces-322066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E553972386
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 22:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F723B23295
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 20:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58E5D18A932;
	Mon,  9 Sep 2024 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fwe92i7W"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD1E17D341
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725913117; cv=none; b=jCAuwazof6G8XLOf8X6Iu1MQylssvM107JddAb78Nne6WpkZplp+3Ig6lgSKQ895zhMUKQ3yC2nq4CpilwJV2SAUramgEQGZNU0eNLXmPZK8cgevLrl7aTaIFReq+DnUpibkNKpIDn/m/B+yWV2cm9LbFZEjv7xTlVCtD2UmR+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725913117; c=relaxed/simple;
	bh=13lNPuKmPyITXulsfthCeIKLInyN4P9c0i28FfIVMGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iOdsXEzYN13wBO+tXThMDQLZnATXm9a7yCH4ME4NNEKaihDm+N/wbnMHuBHawZWkVmKBfe5ZIiJpzFUrRWofFz+VR0jAAny6MvrHH/oy3MNsV62WCmwKGCKP1Bjqa02JRVnbuqRkrNkWbcBLViHJGwFtDsqqMtqW2iUO8lkIPzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fwe92i7W; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6d9f65f9e3eso45673927b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 13:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1725913115; x=1726517915; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CcszTB3xWQWU9WxKt8ijDXvzGMr0WMOou1WzUjCJso8=;
        b=fwe92i7WQkR6GwVO/kFbnsKoGr5rtb1p3QW8EwuJB+impu3lb4XWIKJl72Y6QIQFRe
         r/pQttJ87LG/xGLKeQYzs0gRcF8PbF27n5u/OBSksMnWD6d4t9U8amLKXktHn+nWtKXk
         22CjS7iJ6eHVrZVTKijeqNJwl4zsNwo1rSBw8abakiGuQWIIVifYftNJsm91XupuHDvj
         xPEtV26enn8o3RaUKZcIojOHhMRAsjue0+2pLp0dfqqNKOwHG1HfZeMu3gX6X8LcS2Z3
         HqDRUQ4gCzMt5aIUNWiaY80cajch4EmixAXRmGifoQW5KAWhjdEk03uLbdBuOx54Azna
         hy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725913115; x=1726517915;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CcszTB3xWQWU9WxKt8ijDXvzGMr0WMOou1WzUjCJso8=;
        b=tCUy3sZHN0Jt3CDU0Aeap1bHvE3CXw8VtLJqXg6CzN8E+Pl8Or5Q7G9iQiTZRTce4N
         /7i0/jNJv3TCdPS7yMSQmdRPFcwvBak0zj/3qapLheOLuLTNpbVnDIYnQTc1ozYpH0VG
         QKJSKgnxoRMKGolhhcGrQ7EX1bvLusbp5PbapKu9bNYyfPVEto4qKUf63DLRfobnwzLy
         GUtmFyfmfgvpF8rtLdFbuuCwY49XJWaJ1QkJkkhQci9vYQdQqtnCXeX/Ic6ThmX4fkLv
         56rtQ2tK4/nLbdWitwDnhxts4+nyON0ji9uwzhVS8yA2tYXDoESzfO2KApAiUlC2x7B6
         rwUA==
X-Forwarded-Encrypted: i=1; AJvYcCWW4aqOhahr1czQxcX520Oa2H6+BFsoz9Z6/Mvzr0TtLt5D7qiB0DfujpfkXPlR87rOXSpxEjA5I2IuJ2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLjtBrFUgKMG+bi2rf9xLlcVjDsjdS+9A3dqUXHes7NhxaWHIX
	R9czeAC4odpS2FX/qSyEPfpBlmlV1QKRkRymTlAfqzyuxxmfh2hi05DcAYLH//YTKzneCvUIZ40
	bYF/YfmvQpATwHIXULLuvtXcuds9/vPzeMY8r1HYUwZRdfHAuDg==
X-Google-Smtp-Source: AGHT+IHc4L6JkqeFSBB9BK6rAsGL3YeNds05C7S+maiUQFeSVRh+xQunmNUj1DuCD0ouJglzxHFEDUTi5DIW1HiKjR0=
X-Received: by 2002:a05:690c:102:b0:6d3:d842:5733 with SMTP id
 00721157ae682-6db4516beb6mr137303177b3.35.1725913114540; Mon, 09 Sep 2024
 13:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <caafb609-8bef-4840-a080-81537356fc60@I-love.SAKURA.ne.jp>
 <CAHC9VhT_eBGJq5viU8R_HVWT=BTcxesWAi3nLcMgG8NfswKesA@mail.gmail.com>
 <d16cd3d1-4b32-487e-b116-419c19941472@I-love.SAKURA.ne.jp>
 <CAHC9VhRdQAoiKMVVUiDyCbEd4EDL9ppH3V4xRGhoOoFmHFy8nQ@mail.gmail.com> <d1e5b74a-5161-4906-96eb-4987ff440d19@I-love.SAKURA.ne.jp>
In-Reply-To: <d1e5b74a-5161-4906-96eb-4987ff440d19@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Sep 2024 16:18:23 -0400
Message-ID: <CAHC9VhRuG5V=ccdH6Ti-2+KhU7brnh+TQ-iqNrpJNY-jJN79Mw@mail.gmail.com>
Subject: Re: [PATCH] LSM: allow loadable kernel module based LSM modules
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, tomoyo-dev-en@lists.osdn.me, 
	tomoyo-users-en@lists.osdn.me, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 7, 2024 at 6:14=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2024/09/06 23:24, Paul Moore wrote:
> > On Fri, Sep 6, 2024 at 3:43=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >> If you ignore my concern, I have to NACK the static call changes you a=
re
> >> going to send in the upcoming merge window.
> >
> > I'm not ignoring your concern, I've responded to your emails and
> > patches on the topic over, and over, and over, and over again by
> > trying to explain to you that your goal of supporting out-of-tree LSMs
> > regardless of the impact to the upstream LSM effort is not something
> > that is acceptable to the upstream LSM effort, or the Linux kernel in
> > general.
>
> I want LKM-based LSM support in order to allow one of in-tree LSMs (namel=
y
> TOMOYO) to be delivered to my intended users ...

As discussed many times already, the solution to in-tree LSMs not
being enabled is to simply enable them in a kernel for your users.  If
your users are limited to a specific kernel configuration due to
distro support issues/contracts, that is a problem you need to address
with the relevant distribution.  If the distribution is unwilling to
alter their kernel configuration to suit your needs, or your users,
that still does not make this an upstream problem, it is a problem
between you, your users, and the distribution.

> Adding Nacked-by: lines is not an indulgence for ignoring my concerns.

Adding NACKs, just like adding ACKs or any other patch metadata, is my
responsibility, nothing more, nothing less.

> Commit f3b8788cde61 ("LSM: Identify modules by more than name") is an exa=
mple
> you added Nacked-by: line without adding hints for why I nacked it (e.g.
> links to my posts).

Please see the associated pull request email I sent to Linus where I
wrote several sentences about your objections:

https://lore.kernel.org/linux-security-module/3f5a7bc467d221543444a268dd1a1=
fe0@paul-moore.com

"Support amongst the individual LSM developers has been nearly
unanimous, with a single objection coming from Tetsuo (TOMOYO) as he
is worried that the LSM_ID_XXX token concept will make it more
difficult for out-of-tree LSMs to survive.  Several members of the LSM
 community have demonstrated the ability for out-of-tree LSMs to
continue to exist by picking high/unused LSM_ID values as well as
pointing out that many kernel APIs rely on integer identifiers, e.g.
syscalls (!), but unfortunately Tetsuo's objections remain.  My
personal opinion is that while I have no interest in penalizing
out-of-tree LSMs, I'm not going to penalize in-tree development to
support out-of-tree development, and I view this as a necessary step
forward to support the push for expanded LSM stacking and reduce our
reliance on /proc and /sys which has occassionally been problematic
for some container users."

Unless you present any new ideas in this thread, which I consider
highly unlikely at this point, this will be my last email to you in
this thread.  As mentioned previously, if you would like to see your
NACK recorded in the static call patch, let me know.

--=20
paul-moore.com

