Return-Path: <linux-kernel+bounces-180073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965818C69BF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 17:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3E35B2212E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 15:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD48155A52;
	Wed, 15 May 2024 15:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMDLvRDL"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA18155A2F
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 15:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715786983; cv=none; b=CbMJM6HmP8PWjXIKlAEZsPdiKY+EB4gECVw2FQnDd9uM8owjx4xPmd9scs2EYSfK+pvQcfB353eKPFxRyntPnzY8vrFVOTxHIfgQNF0Khi6gXdyW8eqlCbJWmhesORyd0fCYogp1d/nezPpkVEwdcExYUcl52cSpoLWAGQgneeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715786983; c=relaxed/simple;
	bh=vCSa1KuHePnvzde+P6QMAlkJbblPLYJcaY1o1Uw2xfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W9PjQam9xsdMLcN6YetDNkgn0Lyl9ROEptkUcsCzq+KoffTx6kGHfYMmL83iDHSAenKXpKG2RMZIukz9JcEqEP/OrYzByngaUJylNsqUKYF3o4N6xBGv2RI1utCQdv935raZfOawXWNWOLQHYEJOYLmlK5I7HgjweUafk28IOi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMDLvRDL; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6f0ecec6411so3347483a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 08:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715786980; x=1716391780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtkMv/EgLsHXC5FmqGFw3UMwSSA5R2CQQS/VaXR7uT8=;
        b=SMDLvRDLj/ktl+Vy/AshscCwMXThFsUri1J6k/g632+6l3s77vh4pjXunsTExmzmBh
         jReBVx4yPm+FM9N2dcf0UeoR7hgF2D2kIepgcnlK1QjvhudsGAg7Z7e3IMxywEmwjpPC
         5NU2mDPtAyP2dkvKjj8issNHdbmZ7e0WDlvjKV2tIBj0ZO8F0ejTM9vUHYumT6qb7rhq
         1D8tewl6bpndqfsPQ5JrpogiDfJQTU2XDba8jHl+lzwIU8yyUS+FJKBsKTvYJYlXtPod
         8V3ks7LlmT0EOE/C5PltB3aStCflk6QA/MYlKY5MasziA8V697WMerRLgV9yFBott/OX
         vYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715786980; x=1716391780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BtkMv/EgLsHXC5FmqGFw3UMwSSA5R2CQQS/VaXR7uT8=;
        b=tvbI573iy2A0yOweY0270WhXCg07VoU3MNxzaK7MGxFdJF1Heusd8fecKBHoccPrWU
         3aSMYMhHdXK+Y9z8zSSyzbSUvVNnxqoL+xb+0yqSZg4UWGOs+6KPtdYCTb07B+7tNPGn
         1V/C8BVCZaVI80lYM6v+nJtddMXIAyPgU4KMayC26YU9wSB6I77K16mwDlRiMAXAwb3B
         YW96DpBVJLcT5ZR4e4ViosurKbl3VTP6Fcyqm3VkrA80I5SUxqQnkpasI2pnnD7k0Sjq
         LpU3Lgtz4SXpZ88XWSvzJenJ7ES2hW7JrLUaiUb0sAeZGdcvZG8sFqLqE7Bwfy9z7/Xf
         1xpw==
X-Forwarded-Encrypted: i=1; AJvYcCVC+BMz6+V+bNTfWcl3NqDV0Rv1whuKBXn+JnIHjWXDEL8iBrnPZXzIJ4+aRG89XxDzBIjjaOZ1qbx2Ccb15TRDNkwARrWYUjl8FZfk
X-Gm-Message-State: AOJu0Yz20mHWbPUpBccaMbhjKFdPREkBVnDZIZEVDiU+hxXFsPlhUMQj
	79I/EkBzQfvK/P1jy3pUS8xmCHqGn/mINditYruzZvWyCQ5CwIpY9+LR7PBCt0FaiRnO/o/C7J/
	kINLsd7ic/g/KqzcQiTNGlxXBShvY20deHmlP
X-Google-Smtp-Source: AGHT+IHYbvFsyksrPC59Qfk6xAq1CYyEGpv3F9IHpnXYRHusRaDsoKK/fjZWc1hlqBZJDA0+PT2hVNrl2Puj1nEsGE8=
X-Received: by 2002:a05:6870:d153:b0:23e:65ab:a3df with SMTP id
 586e51a60fabf-24172a4937amr19771222fac.13.1715786980236; Wed, 15 May 2024
 08:29:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514160926.1309778-1-cmllamas@google.com>
In-Reply-To: <20240514160926.1309778-1-cmllamas@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 15 May 2024 17:29:29 +0200
Message-ID: <CAH5fLgjzVHSAQBF5-C1BthK1jspAGRr1z4SQXdQepkeVL9Eq2A@mail.gmail.com>
Subject: Re: [PATCH v2] binder: use bitmap for faster descriptor lookup
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Christian Brauner <brauner@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org, kernel-team@android.com, 
	Tim Murray <timmurray@google.com>, John Stultz <jstultz@google.com>, 
	Steven Moreland <smoreland@google.com>, Nick Chen <chenjia3@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 6:09=E2=80=AFPM Carlos Llamas <cmllamas@google.com>=
 wrote:
> +static inline int
> +dbitmap_get_first_zero_bit(struct dbitmap *dmap, unsigned long *bit)
> +{
> +       unsigned long n;
> +
> +       n =3D find_first_zero_bit(dmap->map, dmap->nbits);
> +       if (unlikely(n =3D=3D dmap->nbits))
> +               return -ENOSPC;
> +
> +       *bit =3D n;
> +       set_bit(n, dmap->map);
> +
> +       return 0;
> +}

Could we rename this method to something that makes it more clear that
it's not just a getter, but that it actually also sets the bit?

Alice

