Return-Path: <linux-kernel+bounces-282424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D712994E3C0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 00:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F9011C21353
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 22:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBC61607AA;
	Sun, 11 Aug 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wYWvL7gr"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1841547CB
	for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723416628; cv=none; b=B7ib3DuwgHfmvlJzWa9IDvuWv6DqgfgMhwpxgVu2gpnA2l2ySj/bs2SRYtbOoxvl6yYIJ3mLPvktZfFyWTLq+4L+6QwdSwaEkBu2lF1co+7pXpN62dcvOKrvgPNk+2rNQSuQHLAlNFA7Hp0UNmM60pjX5CDKLCLr5hAIuXZ5K5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723416628; c=relaxed/simple;
	bh=n3fkfCx4Uyd8Q3sAdNLS+GxwKr9HBWCgk4gMebUbC5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pb1xTZ13+inRyTJRNL8skJWCZAIoKQJo1KHdEScPsBbe0AVrmxAeDuTqhXpGtTqWRhm75VZlMbLx1qYuo6dT6OBtG+2PeKxBPy3EUACXyYfHg8lte4+fpaqfQNmx8CBbaTn7SheeQYKts1ujIBmiBc65OdztNLlMjQRADJE/xRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wYWvL7gr; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-664b4589b1aso36556627b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Aug 2024 15:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723416625; x=1724021425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qV5GpMneh+uImswSyYCL4r2U+RCmNEyfQi2TrKLonCw=;
        b=wYWvL7grME9x6xYD10lFA+ZFjdUJsr9c8RnE0a/cVz8uvtW7igcxfZWHYMG0ZEZ/DF
         wo1uYN5N4nNlMZDSlva1VGXPQ50rMpPTGRx2mkM+2Nm1tD82qn+uoTaJSGEMzMNN6wG8
         HRkH55qsxHkzwBqfrfMHjc/WGriNIaQh+ovF+AGVA2rJu99CSpsVCL+0YbTy0IXVWN1A
         7KlEa9T/4T/Lp8ao3D1GGDQVZdF8jmNuc/eRF9V5JGvTEzzYgZPPcCISpLWzL5keTbT3
         GitHsU6oXPXLCsDl4rQdmElWwsL5bt5rOq1sCxgxesLyF/p8t+n9InpJXpBXcpkWEdf4
         Wr+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723416625; x=1724021425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qV5GpMneh+uImswSyYCL4r2U+RCmNEyfQi2TrKLonCw=;
        b=q7CQwUWtRaV03kmRFbruf4SmDkgvrFGIR6lbt1VFzLAs7P45+thn0Qba1Y6sZTXJT5
         N+EhVYZwyAayW8fRJyZ1R+GCOI98vrCx98wkezH5b6EX+QfcyXYWKUosdXNAfi0txBQW
         qw+Y05hEs7m8gUt2d502BcF1YpoY8eHeM/crUkIlBK6MK5CxtZPaqAycIQfnOCXLgnpb
         FWtFdndAOQDgkWHb6YrB2Nqt/n8Bi672UIE7pFKhcWCi8Qz50P08bayDrCI/qCtFqqHq
         aupTU60Edi9rNd/je/Rhvvo3khS+npX8FBGGfM+wgMuo1wqLBU3q/JthMNfjTGEw9VBC
         ImdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrHYXDsBbf0IjIFugTK6UFcoLFpF3OXN+ERtBAkcSzPMfPbTchYw+g7N/ELP0GSzFEbIPVGkfqs+PjozW3jPsa/YuMbpL5R75zRTrN
X-Gm-Message-State: AOJu0YyAvMFgP+4C0JiKSRLfQrgMa38KezjyEX2rfHpWY+XVN0Ptg3C4
	rc+M37qU/6gjJ02hoEGw8G4WF9mZswxuOC5ZiSBl4AwEKsnMfwPc6GxPepHBkf/5pW5Nu3BP4gO
	1qpUSU7f0uWk6S33pOEFj9quy/OYGVteVwKnC
X-Google-Smtp-Source: AGHT+IE9yCEcMO+lCnrP9yNF+Mf+86S5faNE+nwmeHBAF0+fVTt7jyWmaLLCKlaU7vzX3rud5DSy378atq3g5aBToNA=
X-Received: by 2002:a05:690c:4882:b0:62f:60db:326 with SMTP id
 00721157ae682-69c11a93040mr90641957b3.20.1723416625287; Sun, 11 Aug 2024
 15:50:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808185949.1094891-1-mjguzik@gmail.com> <CAJuCfpEsYi77cuUhvQrFOazFX1OK0vp0PyevKqZsi0f1DeT3NA@mail.gmail.com>
 <CAGudoHHHOH=+ka=xw6cy51EYaGsUZEaC=LXYFvnXgFT+co9mKQ@mail.gmail.com>
 <CAJuCfpFXdx40UGRsXUYFgFGvEy-nM02f+TQ9nOPPepw6gbykmA@mail.gmail.com>
 <CAJuCfpH36sXvCaYL88nzi_8-Yr1tpxHuaLfCMqCac-zN6QHWmg@mail.gmail.com>
 <be0be869-4daf-4530-b90d-6dd6c27c8736@suse.cz> <CAJuCfpEMyRATp+6Xhe_XX-8hPKzONKonWbt_Jnkyp-wOJkN9ng@mail.gmail.com>
In-Reply-To: <CAJuCfpEMyRATp+6Xhe_XX-8hPKzONKonWbt_Jnkyp-wOJkN9ng@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sun, 11 Aug 2024 15:50:12 -0700
Message-ID: <CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_kbfP_pR+-2g@mail.gmail.com>
Subject: Re: [RFC PATCH] vm: align vma allocation and move the lock back into
 the struct
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Liam.Howlett@oracle.com, lstoakes@gmail.com, pedro.falcato@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 9:56=E2=80=AFAM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Fri, Aug 9, 2024 at 3:09=E2=80=AFPM Vlastimil Babka <vbabka@suse.cz> w=
rote:
> >
> > On 8/9/24 05:57, Suren Baghdasaryan wrote:
> > > Maybe it has something to do with NUMA? The system I'm running has 2 =
NUMA nodes:
> >
> > I kinda doubt the NUMA aspect. Whether you allocate a vma that embeds a
> > lock, or a vma and immediately the separate lock, it's unlikely they wo=
uld
> > end up on different nodes so from the NUMA perspective I don't see a
> > difference. And if they ended up on separate nodes, it would more likel=
y be
> > worse for the case of separate locks, not better.
>
> I have an UMA machine. Will try the test there as well. It won't
> provide hard proof but at least some possible hints.

Ok, disabling adjacent cacheline prefetching seems to do the trick (or
at least cuts down the regression drastically):

Hmean     faults/cpu-1    470577.6434 (   0.00%)   470745.2649 *   0.04%*
Hmean     faults/cpu-4    445862.9701 (   0.00%)   445572.2252 *  -0.07%*
Hmean     faults/cpu-7    422516.4002 (   0.00%)   422677.5591 *   0.04%*
Hmean     faults/cpu-12   344483.7047 (   0.00%)   330476.7911 *  -4.07%*
Hmean     faults/cpu-21   192836.0188 (   0.00%)   195266.8071 *   1.26%*
Hmean     faults/cpu-30   140745.9472 (   0.00%)   140655.0459 *  -0.06%*
Hmean     faults/cpu-48   110507.4310 (   0.00%)   103802.1839 *  -6.07%*
Hmean     faults/cpu-56    93507.7919 (   0.00%)    95105.1875 *   1.71%*
Hmean     faults/sec-1    470232.3887 (   0.00%)   470404.6525 *   0.04%*
Hmean     faults/sec-4   1757368.9266 (   0.00%)  1752852.8697 *  -0.26%*
Hmean     faults/sec-7   2909554.8150 (   0.00%)  2915885.8739 *   0.22%*
Hmean     faults/sec-12  4033840.8719 (   0.00%)  3845165.3277 *  -4.68%*
Hmean     faults/sec-21  3845857.7079 (   0.00%)  3890316.8799 *   1.16%*
Hmean     faults/sec-30  3838607.4530 (   0.00%)  3838861.8142 *   0.01%*
Hmean     faults/sec-48  4882118.9701 (   0.00%)  4608985.0530 *  -5.59%*
Hmean     faults/sec-56  4933535.7567 (   0.00%)  5004208.3329 *   1.43%*

Now, how do we disable prefetching extra cachelines for vm_area_structs onl=
y?

