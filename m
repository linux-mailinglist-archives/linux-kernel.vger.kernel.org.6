Return-Path: <linux-kernel+bounces-326188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66924976481
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 10:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A22F1F249F0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 08:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202FA191F71;
	Thu, 12 Sep 2024 08:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RzMwzLH0"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5DE18A6A9
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726129800; cv=none; b=SQs/r9mt7Se8MA6lq18ncRpFK7uKFkH5SyUETTbY8FAp2CYi7h3JyP4Ey/rM/4kNrpF/bEeak29xIEFM/jLi4bIKiLPRU/IbYctqdjxIePF7QXR0qTh75WB4AbEX/WuChhAcz2IJSMowdo4hXa0RAVM8SnRFPq6Nrqq8/e+QK8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726129800; c=relaxed/simple;
	bh=vgepv0dboKEDZIyalIuI+tBzMZSDMsAyMhbtlJJEdBE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qS0s/Hn98Eq/cbPe/QMNHsAu1bFxq0zv2OTdzTB5OnMrhu1t8YV9E03exOj7Nwi7ga9eSn46+3IrkvuHGcNIkt0cJE8hR4Aya7RyFHhJCzaXEzv5gp9gSUt7R1jecZpdbdco7r6Bwo7LXy42Jm4FgOv3bMuegKELwsgW1xIH10g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RzMwzLH0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7aa086b077so83821466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 01:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726129797; x=1726734597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgepv0dboKEDZIyalIuI+tBzMZSDMsAyMhbtlJJEdBE=;
        b=RzMwzLH0oz9gtLLaA59mBzsaYQK2RKEA73PojmnAor9H0R178KvApjEUAEsrnbXSaT
         tz6mv2PFIKCj497W03HibRyaU+Uvek31S1SL+GM5zcD7DN2Uu4lihu2yKRtXUcIBFW3C
         PS5shHDJ1utLJrrCnGtFVdpNP29M8MhKMWqS0uRrq1v347H6kXBiQ7ajkSfQdvSwxMWU
         YLD3mLPSLeMwW11bOcXCi3gXl+MuYJABucrXXFn+fDIIPYjp7zeJukqT3FBaq0xMs48u
         KxBRyJcOj0Ck3guaomIKXZG3LV5XzDFNe5LOGQE0pMa9l0R8HALUveMah8c1kzfXG5SD
         VvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726129797; x=1726734597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgepv0dboKEDZIyalIuI+tBzMZSDMsAyMhbtlJJEdBE=;
        b=Hjp8qJ/F7khFvYI4qRor9ZrASDPaGA0lVyz2Px88cVzUmmyM1yrJKF+N/GzBMIFC3g
         b6UDUsgV3oGYwxNO+iyJwj9VK2tybFVT0mVd5JYy2Sypw3z62/QXJaGHRTiFDNej3g8d
         r0uo9A5tUMNWTg0gemkJ7tWOi51tLThTicOgLT24oexkI8aPP9Ocf8wri1AZgs9TpgeM
         venFZUFcuvTfeGQKajYqF83u2LBo+gX3mCT0Mu3Ed6bXqjxtevlUZW6ps/qcWJ3lQBDs
         fjIKUYuhh4urffEt7CG8e9tNrslGWSQTQZJq2SrgWb1GiAMoP58NQU+Ni/q4JNArOTOi
         tLvA==
X-Forwarded-Encrypted: i=1; AJvYcCX8/D4P5uqEUc6tLI7R9xXe50KNFD2RxHam8o3KIKgkSiDTbP3kkZbW4CYet6IUejuN2au8DfK3BAp3pOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaAwmcEdk5B79R4DM5e9ERZ4P/Hwor5cbMAY3RzSona8tXjcSh
	fndSCxfxbFF0DkJY6GpCIwRMJvxyTXaggySTCqoLkWd/Z0MFz6x9qxzrEH9zpIPnb8PZ4MiL8wt
	01DSJSz61EgJ02egHCntEcL04ULKdE/YqHy7e
X-Google-Smtp-Source: AGHT+IFKXIJ+FLzOutx6ya3INwuoofzvp9Oai3Ccg7+eJzEPubs5oXYdvrhio5ROrLJdoSfGd6QneccQ3uQn1JUAWYY=
X-Received: by 2002:a17:907:e29a:b0:a8d:4631:83a9 with SMTP id
 a640c23a62f3a-a90293dc171mr206258966b.3.1726129796811; Thu, 12 Sep 2024
 01:29:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912075555.225316-1-en-wei.wu@canonical.com>
In-Reply-To: <20240912075555.225316-1-en-wei.wu@canonical.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Sep 2024 10:29:43 +0200
Message-ID: <CANn89iLR9RJqK9i6THjsqCtjM_20ffe2joV0h=Q_W=Yo3f6_qw@mail.gmail.com>
Subject: Re: [PATCH ipsec v3] xfrm: check MAC header is shown with both
 skb->mac_len and skb_mac_header_was_set()
To: En-Wei Wu <en-wei.wu@canonical.com>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kai.heng.feng@canonical.com, chia-lin.kao@canonical.com, 
	anthony.wong@canonical.com, kuan-ying.lee@canonical.com, 
	chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 9:56=E2=80=AFAM En-Wei Wu <en-wei.wu@canonical.com>=
 wrote:
>
> When we use Intel WWAN with xfrm, our system always hangs after
> browsing websites for a few seconds. The error message shows that
> it is a slab-out-of-bounds error:

Quoting Documentation/process/maintainer-netdev.rst

Resending after review
~~~~~~~~~~~~~~~~~~~~~~

Allow at least 24 hours to pass between postings. This will ensure reviewer=
s
from all geographical locations have a chance to chime in. Do not wait
too long (weeks) between postings either as it will make it harder for revi=
ewers
to recall all the context.

Make sure you address all the feedback in your new posting. Do not post a n=
ew
version of the code if the discussion about the previous version is still
ongoing, unless directly instructed by a reviewer.

