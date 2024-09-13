Return-Path: <linux-kernel+bounces-328924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F949978ACE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94341F22BD0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 21:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8043155324;
	Fri, 13 Sep 2024 21:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="I12/DHD4"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794F5155A4F
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726263916; cv=none; b=Cdfw3tDR+Vwn4FefbgoPqFHwxN1+SCZi2SXtcZ42e0jqMvJVLSrzGxGHWcr9y6NeONoLDONKEK7oA52eDQ4zE3uufhgWAMMD7pMrhCcD0iIxbzF9LkuuyEa3uhSV6eKP65Q3rPmUiH5m+i22U4jQ1fW9bMX2a4drg9h4+3kIaJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726263916; c=relaxed/simple;
	bh=FRuh+KBT0a7k37NAtcwsuij34NzWTTyM/ab3DyrzLEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4NiyvQk+z5Njb658ZPrqJl9ge8bf780ExOdyGmZxgySlfFQxkxh+bf5SQWbyZk6bKBdvh8kDOWe6GeCwilZmbQ0i27zhcoNzHuXfcXYhllaIamwHfyo4zONdUdbqbsrPVphgiiddZtMsliUfDfaa2eAMcQJ1aX7zJl/RQx94JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=I12/DHD4; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e1a74ee4c75so1321521276.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 14:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1726263913; x=1726868713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lwn37t/iSKoOZ7UvHqU4qQdhusIvGBPeQaXOibPFjp8=;
        b=I12/DHD4bbOdwoFHzXxjuJmT6OqVkMcxItHTOZi0kXc9nf9xFq03PglVxV9EUeCgBD
         n+sQRj+Z224C8/rtuBCqrE2HyjBtQ2QWZVevjOZd2Si4IhUahQ3C7nXrKTGtuMsYPX2I
         eIhCvWPV+nt7yEKHE9YlM5/9I6fWx8ne2kfDYpf49/LfCgPSuKNGEurcN9MhGdKV5LTZ
         LRAfsGuPWKgcFdrUk/6+M7SPcUt/PzKG+CyslKYjL7TITE994UCRBe34Kd77B7oVGl3Z
         j1AT1uqjQLVQY8kFYauvF6xYnlGBRXCANrBTdmKN6SfMy3yj6AbspkbLT4ACarPeA/0g
         a0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726263913; x=1726868713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lwn37t/iSKoOZ7UvHqU4qQdhusIvGBPeQaXOibPFjp8=;
        b=tLfExg48gWc/PQWF5HE9fPEwrAb+IGPUfMcHSXXndOoI7wu+DRZM466ErXU5Tt22+z
         T3Euf9SpKeq5pRHkXoB9y+kqm8UaGOCZNLIC+QO8zc1gwagtkvoTFmuF2hn0GJ6I/Jgn
         nwNNwa6IwHfTmJdRNmR2ZPBuBLWoggPX2v7+zb2Kz30pSu5zbpGruG0m/UmgH7uI78/Q
         5/c7PcUXdLHT8V786LP7GUia8MRGaa/V4AKbA3kUfEnk2cbQ+WIw0hvAwLptu/CFf2T1
         CS2JQaxFkVqadzX0J4KgjMlAo4ZzIm/E4cxhct3F+gwMD5OG1n/zYCz3yZ9xdaKSsZ5J
         iS2g==
X-Forwarded-Encrypted: i=1; AJvYcCVZxZnQrJvKtMDGdem06+fhoAX7zmanRmYw8lyYYAqeAPOdILmUluOlKco2Z1c035tzwjc0aOVC92ZPD0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUokrJNkAjN0Hml1p3jp6e87tantx4PXF89EsWVUQf7J2K/m9T
	O+/CAPHIa6gULcwhw8s1FgKJ7EL45o7c8XGXpRZYN5t9pURv8Gc2GXZEuxitHj8ySnTOfB99EH8
	xHUQR6MVgoAlVh4ZLEy9wq8hVsrIYASAsqIIa
X-Google-Smtp-Source: AGHT+IHVR8chyAryrgWoD0CfuiVCPSTNyXA8dqCpTcxPwQRyhtBbIrntDXbyeDkcU1pJ/lYcycmDXrk0C8l4LPdW6YQ=
X-Received: by 2002:a05:6902:2186:b0:e1d:2261:cb25 with SMTP id
 3f1490d57ef6-e1db00c664amr3581421276.18.1726263913366; Fri, 13 Sep 2024
 14:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910184125.224651-1-casey@schaufler-ca.com>
 <20240910184125.224651-2-casey@schaufler-ca.com> <2e1da617-c437-4ff9-93e0-e0e212aabfaa@swemel.ru>
In-Reply-To: <2e1da617-c437-4ff9-93e0-e0e212aabfaa@swemel.ru>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 13 Sep 2024 17:45:02 -0400
Message-ID: <CAHC9VhQfLRfKTjksZ=KxuNPHXXUAV_0Q0ejKEDmFXc82wOZu2g@mail.gmail.com>
Subject: Re: [PATCH v3 01/13] LSM: Add the lsm_prop data structure.
To: Konstantin Andreev <andreev@swemel.ru>
Cc: Casey Schaufler <casey@schaufler-ca.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 4:49=E2=80=AFPM Konstantin Andreev <andreev@swemel.=
ru> wrote:
> Casey Schaufler, 10 Sep 2024:
> > ...
> > The lsm_prop structure definition is intended to keep the LSM
> > specific information private to the individual security modules.
> > ...
> > index 1390f1efb4f0..1027c802cc8c 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h
> > @@ -140,6 +144,22 @@ enum lockdown_reason {
> > +
> > +/*
> > + * Data exported by the security modules
> > + */
> > +struct lsm_prop {
> > +     struct lsm_prop_selinux selinux;
> > +     struct lsm_prop_smack smack;
> > +     struct lsm_prop_apparmor apparmor;
> > +     struct lsm_prop_bpf bpf;
> > +     struct lsm_prop_scaffold scaffold;
> > +};
>
> This design prevents compiling and loading out-of-tree 3rd party LSM, am =
I right?
>
> Out-of-tree LSM's were discussed recently at
>
> https://lore.kernel.org/linux-security-module/efb8f264-f80e-43b2-8ea3-fcc=
9789520ec@I-love.SAKURA.ne.jp/T/
> https://lore.kernel.org/linux-security-module/960e740f-e5d9-409b-bb2a-8bd=
ceffaae95@I-love.SAKURA.ne.jp/T/
>
> but it looks like a final decision to ban them is not taken yet.

For those who haven't read my latest comment in the v6.12 merge window
pull request, I'll copy-n-paste it here:

"My focus is on the upstream Linux kernel and ensuring that the
upstream, in-tree LSMs have the best framework possible to ensure
their proper operation and ease of development/maintenance.  While I
have no intention to negatively impact out-of-tree LSMs, I will not
harm the upstream code base solely to support out-of-tree LSMs.
Further, if improvements to the upstream LSM framework are determined
to harm out-of-tree LSMs, that shall be no reason to reject the
upstream improvements.  I believe this policy is not only consistent
with that of previous LSM maintainers, but of the general Linux kernel
as well."

--=20
paul-moore.com

