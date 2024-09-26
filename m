Return-Path: <linux-kernel+bounces-341104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01339987B57
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 00:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30B011C20E40
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 22:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E115F1B07A4;
	Thu, 26 Sep 2024 22:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKGepnxR"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7821B07B4
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 22:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727391022; cv=none; b=f8q6I3y0uqw+/Xxf7WMX/aL6ZjQ8afX2YzXgDVFBQvNUR/Vlp8/v0ZQ/0IGE86iXdJE8NN8EYHniYJ0Rl65ya3pGJPto1temq+fHk7k00H1jkiaqbwcI/lbpHyqn6TBPpZWNJ7xqn0ABIovq+hKjkzzZ7v2WNePIUAcxZVxVpnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727391022; c=relaxed/simple;
	bh=Q2YFvMU6hEXtnnkyZ9mWQAexYhMK4XN76e3zAzG7Vm8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CSQFDUUnaDkI6iffzhCH8Yf6HZ++POcm2fI2wJf/49/zG65WeQn/RC7vR3t6K2o3lr85ckmVgExsc6+abKPZFd3FYYJK5NJNHtgfugr9qTyBpvXwLRGTE54yz+TWu8pXMOdax+h0XD0Ftn7N2VpQNETch/9JRiPxQzoyTNF1vN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKGepnxR; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cb22e9c6dbso9012566d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727391020; x=1727995820; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QMfdq3/Pvsbt60PVJC9Jtm6nQiaNCIJWpvSDaqQirY=;
        b=OKGepnxR9AjGyzN3tzTGqhjAcIc4Jo70eOR+6x/9DZ7xUjjjWoI8Ak5FbLd+r8j4HD
         N122apGAt+YOosVMpq9IPNmAuLGowct/hzDIuDtv9gp7yRtcyiE8P7VUioiIPFjGKhR0
         AEh1YRDgQMtVT06ob3jaTGeM27fq/aXrAqbEcMwJSG2Zm1ekMLtP5vii+LhaIAnp3+Mb
         zuJOzLZIEBCq5o/O5H4vYiN1hlWrUgh93fGwZJJS1JNzLVFaCNADymzQ1HswpZS9Kuek
         XCjPDaojk3qWP/+B4mYRI5zL+ZEY3eMBefCElTFfl1bJpRT2PZwXYNech8iJ9euS4yj1
         geqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727391020; x=1727995820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QMfdq3/Pvsbt60PVJC9Jtm6nQiaNCIJWpvSDaqQirY=;
        b=oJmT8YUHC3jGKeDUa2fJGkpQ1Ziplk03IEojSajTqYnlfFam5D2y0nubc6EMsB42eN
         ZFaCiS3pQIFjMpTg+P5ZbByD2GFSpFDrrirh/tDBVVY9k3z+ImWgaSA2FE7VDDUB9hiS
         c93lTZI+nFGoDrIuFpWn63CMbYQUDMH/O9RcXidC1XJyER0yCA3ZDKFIw4zxXO45/cwH
         AGzEnliMxAC5zl0dOschjMegnm1Al1T4kdkY/iGiy8HtrTAsTFgdao409c3KEQHhbYvN
         49SQuMJMg21EO78PuKGAivsyOT1frj9LRU6KxZ24Qc7mkSU09ST47RDdJz5FCmX/arbg
         VYUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt3NYFwtUxV4xHvsrA3A9JD7O1e7kJJji3b2RIQjnvdkJWnsDDd0Yyr0ksOj0frxTozjBRm+yF781p/js=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiylCIEcYIZ7lezirE6tmGkYrCjlHUwMtpBWnuQKuxwPiyMs1P
	CiSdDSYGEYSl4DTMjvV7MyS2S1uCXC/cxO71dzNr17ZYx7vUeN16lL2F29v1mTlkWSdomxAEOGz
	J2HeYg2iI1fBnXrqjMq1VtiSjEAUZFkj3
X-Google-Smtp-Source: AGHT+IGzX/x5c/SyLBqexGC/TEAZkqdoPqG1WhTIJsQ26Gck4xATCL54AtMI8ZHwRwVJ45Nq85nEZ9BaflbU8P1Mxxc=
X-Received: by 2002:a05:6214:5549:b0:6cb:2ab7:56df with SMTP id
 6a1803df08f44-6cb3b64deccmr18195796d6.49.1727391019651; Thu, 26 Sep 2024
 15:50:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240923231142.4155415-1-nphamcs@gmail.com> <4d38c65d-760c-43a5-bb47-8e0235c13a51@linux.alibaba.com>
 <CAJD7tkamKcaqHR5V+4+9ixmFc3dC2NnGcu7YzdXqxqNEe8FqqA@mail.gmail.com>
 <9a110f20-42ad-468b-96c6-683e162452a9@linux.alibaba.com> <CAKEwX=PiOdrR7Ad5XoT8pRZDLB=q6B_fmwQ3ScgWFPNptBuHPw@mail.gmail.com>
 <CAJD7tkZFu3DbovTwyRdQmEG=7nQtmzrjQVgyhE4mNzbCtZxFZA@mail.gmail.com>
 <CAKEwX=ML4+iW+WkyjezaqipZU=N=DeB561M4XzOqQMD6drk9dA@mail.gmail.com>
 <85a2fd61-93d3-4cd9-95a3-e9eaef87286b@linux.alibaba.com> <CAKEwX=NB-vf4zTTJ2KaRFGJmcfeDQpLLuiX=Rh6X+49ib8S=wA@mail.gmail.com>
 <CAGsJ_4yTbLwfzMTk9sivBDLJb1JAcDNdvsFHUeag9mUvAi0SUQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4yTbLwfzMTk9sivBDLJb1JAcDNdvsFHUeag9mUvAi0SUQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 26 Sep 2024 15:50:08 -0700
Message-ID: <CAKEwX=P=xwdfzT3UZchi3GAuZXKXWTUK0nNN=YfbugyFK+tYVA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] remove SWAP_MAP_SHMEM
To: Barry Song <baohua@kernel.org>
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>, Yosry Ahmed <yosryahmed@google.com>, 
	akpm@linux-foundation.org, hannes@cmpxchg.org, hughd@google.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	chrisl@kernel.org, david@redhat.com, kasong@tencent.com, willy@infradead.org, 
	viro@zeniv.linux.org.uk, chengming.zhou@linux.dev, linux-mm@kvack.org, 
	kernel-team@meta.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 25, 2024 at 8:59=E2=80=AFPM Barry Song <baohua@kernel.org> wrot=
e:
>
> On Thu, Sep 26, 2024 at 2:37=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
>
> I=E2=80=99m not entirely clear on your point. If your proposal is to supp=
ort the
> case where usage =3D=3D 1 and nr > 1 only when we don=E2=80=99t require
> CONTINUED, and to issue a warning once we determine that
> CONTINUED is needed, then I=E2=80=99m completely on board with that
> approach.
>
> It seems that your intention is to simply relocate the existing warning
> to the scenario where CONTINUED is actually required, rather than
> maintaining a warning for the case where usage =3D=3D 1 and nr > 1 at
> all times?

Ohhh yeah we definitely agreed on intentions, but I think I
misunderstood your request :) The code below was an attempt to satisfy
that request...

Please ignore it. I'll submit an actual patch taking into account our
discussions :) Hopefully I won't forget to actually test with thp
swaps this time...

>
> I wasn't actually suggesting a rollback as you posted:
>      err =3D __swap_duplicate(entry, 1, nr);
>      if (err =3D=3D -ENOMEM) {
>          /* fallback to non-batched version */
>          for (i =3D 0; i < nr; i++) {
>              cur_entry =3D (swp_entry_t){entry.val + i};
>              if (swap_duplicate(cur_entry)) {
>                  /* rollback */
>                  while (--i >=3D 0) {
>                       cur_entry =3D (swp_entry_t){entry.val + i};
>                       swap_free(cur_entry);
>                  }
>

