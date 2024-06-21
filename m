Return-Path: <linux-kernel+bounces-225344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3029C912F5D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 616861C220E2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B674917C226;
	Fri, 21 Jun 2024 21:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="KeNONThH"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E8F770FB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 21:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004768; cv=none; b=e/fqqI12gQqcQ44kXe2Cx16ZonBH0LEkm3tkjoOwSCjQz16TJMpQcKxkdJB4vRTpYbt8j43oSGvVMU5Pb8UC3xJZgPXpLWieqtCnE7YM+nIfvQWYHlDqwQRlu/30RhEz61eHZGpywKJGftcnW664yPOLlElJ0SIj3XY5/yXgVFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004768; c=relaxed/simple;
	bh=8lr1mwe6kp+kuxQVqcuMU3hSRlGZ/owZFV26zQzK298=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V4TWZGyOLftw1VTYSR6Y9SmTKSLvIrox2K7N3lzfMpWVuNTyUHH6jwBb+bX8IVJgrmA9xnKp0vpfFagqJj1UmNxXn0ChaY0FNgl+7dmvunjrTgG1j3pZb3NkM/CoXaditb6Tf/k2a/UYNIHu93KZTjeKxnjNp4nzedHueT8Wxqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=KeNONThH; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e0272692096so2287588276.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719004765; x=1719609565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTh4L3BY4iwQCbofoLDyf8SOpU+yU/iGqx41nKNZbog=;
        b=KeNONThHR5rPROY4WGN8GVZ2DfbLUel0xnJPzlL46IgAyJkA1rVEE5Bg/+aFYZm3y9
         mmxKAt42c2ucaHb2WV5v7ADvb0RXZZ/sRJ9GkOeNMUJh2slY1lVGT+hh+7D5w86U+4Kq
         Bovus/SOYTVddU2sC7FBZg80jSGq8+mZ/bYZh3aA6qwKfOaGcylvhLs1k0AGFP0+X8P7
         bl1UXL/+8egdNX+7Z+Ir5kiWxNHVCJFphG40U91lehEwX4FQ9nzpBBtsp00jGL3j5U3J
         B3oOysnh6hx9ztyZRwwJ+BKDmw90b8xo3hO+N8cScniI3/acY7pJWnbExncXlL+cWdQa
         l6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719004765; x=1719609565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uTh4L3BY4iwQCbofoLDyf8SOpU+yU/iGqx41nKNZbog=;
        b=nY2K6igVoSzD/rupPQcYWq/FLsdFIQlxbQ3pUIDlyDIk7rSjq1lrPfvdQ2RjTx5Uz5
         LuP7hnPCgz2C5JduDg81Z66EnzEkGOBYwn8B1ihrg1ChMUz0InYz3CqhusAJBgvWM6Hp
         Hmov9CR6ywMnAyF1ZG79suXrm1ACqrkNKDzwrn71SQReYx+tJvOFYWZtXRCqQDz7Ay56
         0wKOMAI3JHsEWrhZ64rtsVJpUx4d5EdSzuvdvm3l75rh/tVKC9eNb/5Ce9RriuD4GrbL
         M2V+06uTjxf6B5tOx7AFqzoDTFypnDRBKk41p3GHZmXA/iJ9RienUOl3i06sLv85pMIu
         GxiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqcfkmbqOKVYfsNR2SNRtFs8y3eXPfu47vab+waQf4NgqyO94EA/iuJQiKvFz8aSzduzLUF3JA5+U9YqQVzmxn+2K81fBMujUqlZ36
X-Gm-Message-State: AOJu0Yz31XjUi0o/hzb3eFD2csdMBZgZYQqIaaXdLDNKQmJlIjqqRjYs
	/GulAmvBrD7LYyReZG31IU/MaLLF0cU2idw7jhIY7fDoPcHU5ZqplWuxkcTpzSCBV1IKv9++7Ca
	yCeQ44okzAVdtJsoQYbxyStRV8jnfEsaFUfji
X-Google-Smtp-Source: AGHT+IEO3bU6Bkwuyqrkdth6ewbR+7IHhepu1IYoa73UuwczNOTdI9rtJb2IzNy/CVVXrmq3jsM8cCXNxJAJ4+XXpKo=
X-Received: by 2002:a25:ad06:0:b0:dff:2ef1:e3d5 with SMTP id
 3f1490d57ef6-e02be227615mr8816096276.63.1719004765371; Fri, 21 Jun 2024
 14:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215221636.105680-1-casey@schaufler-ca.com>
 <20231215221636.105680-2-casey@schaufler-ca.com> <CAHC9VhT+QUuwH9Dv2PA9vUrx4ovA_HZsJ4ijTMEk9BVE4tLy8g@mail.gmail.com>
 <CAHC9VhSY2NyqTD35H7yb8qJtJF5+1=Z4MHy_ZpP_b7YDT-Mmtw@mail.gmail.com>
 <fbf7f344c518d70833398c2365bb2029480bd628.camel@linux.ibm.com> <d953fac4-9dbe-42a0-82eb-35eac862ca6a@huaweicloud.com>
In-Reply-To: <d953fac4-9dbe-42a0-82eb-35eac862ca6a@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Jun 2024 17:19:14 -0400
Message-ID: <CAHC9VhRKmkAPgQRt0YXrF4hLXCp7RyCSkG0K9ZchJ6x4bKKhEw@mail.gmail.com>
Subject: Re: [PATCH v39 01/42] integrity: disassociate ima_filter_rule from security_audit_rule
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, mic@digikod.net, 
	linux-integrity@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 4:34=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On 6/21/2024 10:23 PM, Mimi Zohar wrote:
> > On Fri, 2024-06-21 at 15:07 -0400, Paul Moore wrote:
> >> On Fri, Jun 21, 2024 at 12:50=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> >>> On Fri, Dec 15, 2023 at 5:16=E2=80=AFPM Casey Schaufler <casey@schauf=
ler-ca.com> wrote:
> >>>> Create real functions for the ima_filter_rule interfaces.
> >>>> These replace #defines that obscure the reuse of audit
> >>>> interfaces. The new functions are put in security.c because
> >>>> they use security module registered hooks that we don't
> >>>> want exported.
> >>>>
> >>>> Acked-by: Paul Moore <paul@paul-moore.com>
> >>>> Reviewed-by: John Johansen <john.johansen@canonical.com>
> >>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >>>> To: Mimi Zohar <zohar@linux.ibm.com>
> >>>> Cc: linux-integrity@vger.kernel.org
> >>>> ---
> >>>>   include/linux/security.h     | 24 ++++++++++++++++++++++++
> >>>>   security/integrity/ima/ima.h | 26 --------------------------
> >>>>   security/security.c          | 21 +++++++++++++++++++++
> >>>>   3 files changed, 45 insertions(+), 26 deletions(-)
> >>>
> >>> Mimi, Roberto, are you both okay if I merge this into the lsm/dev
> >>> branch?  The #define approach taken with the ima_filter_rule_XXX
> >>> macros likely contributed to the recent problem where the build
> >>> problem caused by the new gfp_t parameter was missed during review;
> >>> I'd like to get this into an upstream tree independent of the larger
> >>> stacking effort as I believe it has standalone value.
> >>
> >> ... and I just realized neither Mimi or Roberto were directly CC'd on
> >> that last email, oops.  Fixed.
> >
> > Paul, I do see things posted on the linux-integrity mailing list pretty=
 quickly.
> > Unfortunately, something came up midday and I'm just seeing this now.  =
As for
> > Roberto, it's probably a time zone issue.
>
> Will review/check it first thing Monday morning.

Thanks Roberto, no rush.

--=20
paul-moore.com

