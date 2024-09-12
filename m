Return-Path: <linux-kernel+bounces-326986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AFD976F82
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:28:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CC25B2257D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661171BF7F3;
	Thu, 12 Sep 2024 17:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFMAw03O"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503021BE24A
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162090; cv=none; b=fXvyRcCVF3i7y99krw8FqRamQgMV3oapUW2x7V3JpHsOSShe+beyYY/mmx5g7zbUVhLfg8O2F3WndUyOLrq4wiJQInpLP/xmzlUloTiGv6YETvP7Hj6cp0+Nf8aNAyC4WZ+gnlneUf31P8Lp4GOXavR1EGpGqrLKa7h4EIsaYmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162090; c=relaxed/simple;
	bh=pNzZT3L9e6VWxfgvzItUS1gOhsrIuXLuqYmoWATq7rA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SjuS79phQyE5RbDw2f8YbMouieMiU8xlTXT2VXMIrOtmAMhwhNYET9gn+wmtCL5IUyzluSxoPLI/dx09NhhpryNR17aFb08tgl1YEtajwcfw83sMNBjZta7SZngLKbFIfYXBDuE41bWCmxBxiFfnzcarp3RSK9pTL6Fsd6nxA9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iFMAw03O; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c24c92f699so1057676a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 10:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726162087; x=1726766887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNzZT3L9e6VWxfgvzItUS1gOhsrIuXLuqYmoWATq7rA=;
        b=iFMAw03Oq1w8VkT1Uu3QwH22VWdXYXrkIhonuxJCoCGy1oJm9XLhtYnAxGi76yelb2
         4inw95rNcD6wQtChjcEt/qKNKZlXYRhDbwm0x+iFy4HNE397pVdMUjTrFMvEctYzLdP8
         QVG+keoh29zgsHATP1gm1QdwcczcYSqOPdfEIEtLN07IzM1JwYSq3QdMwzU5WVeUWRIK
         6KRey71KDNsyzV8stksGcWeqZBu9I3QLdUZMypSlqVuEuXiG4HvQC9+Bzb0VGTs2h8wf
         17hkv+tnGcKZMpSJYhxjDuhe0gj6hV3PjW2L/xrcU3Jlms0k+EUlJxvWw0d4yknI7psO
         IQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726162087; x=1726766887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pNzZT3L9e6VWxfgvzItUS1gOhsrIuXLuqYmoWATq7rA=;
        b=bWDZgvUDm64GPJ+QNgcd0PuXPvaYFGcR1+27X/LldvIMaXZYXd84aNBPxR71DEVCu0
         2hSqvlH4nLANwlgiPU1LS4PfxfuXJcGvdgZ7OmMbuQDWK8dtb49iOyz8SrOaTzHQxw2F
         lUQ/UL3t8VXNY49PNSXmoapLWJqBn+GTQ7jQOSfG4oZlEL/tJ7zT0+kZUDB6S+MyTUlL
         dVw27/GBPHuPrpoy3fxiVLa1+xFFGqrxu7n+54TJ5G3k7tZiemifI7cRyULu9wITRDYb
         M+Ju3P1E/usnM6mLquFvte+r9woualsGXLU4zjStU8uh/qZQqy0G2igxyn2EZxvciE++
         fzGw==
X-Forwarded-Encrypted: i=1; AJvYcCWRBKXUQn3d7LvAo6l+3d/3JDovG8UcaYDOGu5ir03Q2izVegs5NclRbD5oZt3C6kqjsTBN9uLg99ZEnXs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQjJZq+bp3tUD0vXf+5DNPr6ACv96jQMQQwchutc8KPvoLgeoX
	YoWJJGsrFN93fIcOFBMIcKe2XHBXYQN9HFdWuEJgHK9bqaL51N4mckhLXPE9Fw15J2JQeULqQh2
	F3So2vI0urt2mvNwGMG7/5j5lQkj+KllgIcpa
X-Google-Smtp-Source: AGHT+IFbNcWLaJqZUtn7OCEJS0hnZs9Kl3Zh39Ri8+VPCfh1sGGUXYEr5mfi3QAZDM8rleUPVh6Z7H1BfcmVi1H3l5E=
X-Received: by 2002:a17:907:7da4:b0:a8a:6d66:ab86 with SMTP id
 a640c23a62f3a-a90294e62c8mr337291766b.38.1726162087052; Thu, 12 Sep 2024
 10:28:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172547884995.206112.808619042206173396.stgit@firesoul>
 <CAJD7tkak0yZNh+ZQ0FRJhmHPmC5YmccV4Cs+ZOk9DCp4s1ECCA@mail.gmail.com>
 <f957dbe3-d669-40b7-8b90-08fa40a3c23d@kernel.org> <CAJD7tkYv8oDsPkVrUkmBrUxB02nEi-Suf=arsd5g4gM7tP2KxA@mail.gmail.com>
 <afa40214-0196-4ade-9c10-cd78d0588c02@kernel.org> <CAJD7tkZ3-BrnMoEQAu_gfS-zfFMAu4SeFvGFj1pNiZwGdtrmwQ@mail.gmail.com>
 <84e09f0c-10d7-4648-b243-32f18974e417@kernel.org> <CAJD7tkYY5sipMU+w8ygPTGKfjvdMh_e0=FtxYkO9BG5VpF+QUA@mail.gmail.com>
 <CAKEwX=PTA0OxisvY12Wa95s5KqzvQTXe1rZ7nw29nP+wR2dxkA@mail.gmail.com>
In-Reply-To: <CAKEwX=PTA0OxisvY12Wa95s5KqzvQTXe1rZ7nw29nP+wR2dxkA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 12 Sep 2024 10:27:29 -0700
Message-ID: <CAJD7tkbMph337XbBTbWfF8kp_fStP3-rN77vfR5tcn2+wYfJPQ@mail.gmail.com>
Subject: Re: [PATCH V10] cgroup/rstat: Avoid flushing if there is an ongoing
 root flush
To: Nhat Pham <nphamcs@gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	longman@redhat.com, kernel-team@cloudflare.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, mfleming@cloudflare.com, 
	joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:22=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Thu, Sep 12, 2024 at 9:35=E2=80=AFAM Yosry Ahmed <yosryahmed@google.co=
m> wrote:
> >
> > >
> > Yeah there is a plan to remove these.
> >
> > Nhat, are you currently working on this? If not I can try to find a
> > few cycles to address this.
>
> I'm not, but Joshua from my team is working on it :)

Great, thanks for letting me know!

>
> cc-ing Joshua...

