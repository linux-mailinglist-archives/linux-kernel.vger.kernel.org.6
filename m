Return-Path: <linux-kernel+bounces-391390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5119B8610
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 23:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA64B1C21952
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 22:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A935D1CF5FF;
	Thu, 31 Oct 2024 22:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CH0h5DD6"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D78196D98
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 22:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730413235; cv=none; b=MT5FD4Lk6i8Qeq7JhlkvePBiZkzsDH7f3NZSlF2VpKFHODg4XhbA655nUGJYn4ls8MqI19Mlk1StfJ3+9qovAGVHGfNK5Bwu0/53uOznsD3toO3z4gByA0KjLWtKiwPi2g/oGGhHn0l4yvCO3QZJDAWEKZU2SzeWFjuBS3twCTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730413235; c=relaxed/simple;
	bh=hD6FD16CqkuWDTUTgZo6lpVEDlKMOdFJ8ITeyCcqwtM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDqm6I/pZHeSfPih7lraBtQw4MiwhhHO/xYlCJo2Bslxj9NlAe8WgmcU9ycS6BiyZrMk3zQHo/PHpKylNLolUTmOQXu5Y3oUh7q4Hj8X2ZaCgTyYyWsC3XGVZjyihO33vOQvjDVGvurfrykpXT8cHbKRUy+Q1GcQZQxpY0pefmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CH0h5DD6; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e290554afb4so1615105276.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 15:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730413227; x=1731018027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQa7r/RlLtRu4piUR195BMCUdGYG4O9N4Miv/czlIOI=;
        b=CH0h5DD6iDTYUFdJMM3Rfn6Oc9nxUpPF+83u8w/GEAs9EGSCf03VzpNb+uzNgKGOeK
         x/yVNPOCmHJOrCwXNmDVVewThw3F8PGn/yHMKbN34VH60YnrUujaOKSGdT36ENUlwnL7
         0WwlV6DeakcGCGxvKplE84Kx2evG9USAble57Oo1+17rWG/+1qYAxfGXh39wzm1IM7NR
         ashPmPCb9fS8ILtbvqNxYXWbOwKG22td6UrP+Dqal6SWCDec5y5jOLOlWQSS1SLBWeR7
         YH8eQJ8gfvbY/7076lDvePKYzlf9z6zoT6v8iNxhI8ll1+IBZm48yFI80W4wnzImINIu
         WCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730413227; x=1731018027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQa7r/RlLtRu4piUR195BMCUdGYG4O9N4Miv/czlIOI=;
        b=wA56Vyz0RACkuqAO3ehVXqsi055zTNLewnNaHEe1U28KXSHZU/YytxLm0zs5m/HZaH
         pgahWAJxnXr17BRsa2fXDWSNFkAT8q4Z/x45K8zmdzEIPv0nydbXyWqY+hi0P89zcOzo
         hUVhHmGzHitKtDWf3aBEwY4WMZ1wj8SBXf7gjSCtujzBalQuhiIJH2Z9wMHuflbLKxIH
         o5r9AtnDJIww/0kRwOjAYkI1qeXne/jeWBDc55l+7aJ3ib6T7UZSXF1R1kl4WdfI/8Np
         1XHNCrmlVzh1Rsjvh78YNXfcFwAAoTHg/JNdcL+mD52IsiwK35lK4wpejYf8lewaWuog
         9ttg==
X-Forwarded-Encrypted: i=1; AJvYcCUVzIOAN8YfWjNxWKJEvh3VGcLqCbHUC9rfWV1aYoaL6xLX+MV74dxFPhZ0dvKbJrBmH+S68HL4qEhqAXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWhkJlfVkTTR90hZzvs4QJLku/gngp2fwa0yfXGpz7a5mDAcYn
	OQHMtXqW/FyPgbp7Vl5OMbRiKiFX58hW7CD4bhjcjAGna7XGNoyRRpSvjByO7kw81//CuShtnTM
	g2j7g0z14kRSyJsUFDGdzVml2Ps5cmTEDvV8P
X-Google-Smtp-Source: AGHT+IH/kGkXG6glEIjff2VpkKyaD9IIr/q+FjANR+s08/jBcbBq/p/8Fx7nmRrY+dKCnt3meJ3TNMOP/b2/BH6X9f8=
X-Received: by 2002:a05:6902:154f:b0:e2b:d5ab:986f with SMTP id
 3f1490d57ef6-e30e5ab5b16mr5247526276.31.1730413227190; Thu, 31 Oct 2024
 15:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405161042.260113-1-cgoettsche@seltendoof.de> <20241023152719.24118-1-cgoettsche@seltendoof.de>
In-Reply-To: <20241023152719.24118-1-cgoettsche@seltendoof.de>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 31 Oct 2024 18:20:16 -0400
Message-ID: <CAHC9VhQ+SmaYB-1zz2q9j1XJeAFaY+emn_KoNiXxqJDt6wjT0w@mail.gmail.com>
Subject: Re: [PATCH v2] selinux: add support for xperms in conditional policies
To: cgzones@googlemail.com, selinux@vger.kernel.org
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	=?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	Jacob Satterfield <jsatterfield.linux@gmail.com>, Eric Suen <ericsu@linux.microsoft.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	Canfeng Guo <guocanfeng@uniontech.com>, GUO Zihua <guozihua@huawei.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 11:27=E2=80=AFAM Christian G=C3=B6ttsche
<cgoettsche@seltendoof.de> wrote:
>
> From: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Add support for extended permission rules in conditional policies.
> Currently the kernel accepts such rules already, but evaluating a
> security decision will hit a BUG() in
> services_compute_xperms_decision().  Thus reject extended permission
> rules in conditional policies for current policy versions.
>
> Add a new policy version for this feature.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v2:
>   rebased onto the netlink xperm patch
> ---
>  security/selinux/include/security.h |  3 ++-
>  security/selinux/ss/avtab.c         | 11 +++++++++--
>  security/selinux/ss/avtab.h         |  2 +-
>  security/selinux/ss/conditional.c   |  2 +-
>  security/selinux/ss/policydb.c      |  5 +++++
>  security/selinux/ss/services.c      | 12 ++++++++----
>  6 files changed, 26 insertions(+), 9 deletions(-)

This looks fine to me, but I believe there are some outstanding
userspace issues that need to be resolved?

--=20
paul-moore.com

