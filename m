Return-Path: <linux-kernel+bounces-361667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DC999AB23
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 20:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2724B23327
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 18:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C167F1C9EAF;
	Fri, 11 Oct 2024 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UiMU2i4Z"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463901C9B87
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672135; cv=none; b=Qu0avp+TqKGF/XtljRFJQHYb4tLYH76rJcBOayZnwvp2xmjxgrQt093hOrJWRrzC50CCvA9BL+I/4UZ5TI3JetWYFkw4zAlY0bs5ohaT5KwLot9qKVfkt1+C8LhWYoTJj9w1IKqzSADa0BZ+yHZwziCD799fkO8SCl0ywODPD/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672135; c=relaxed/simple;
	bh=awZT28/RDhTSYIZAibdl2X4pg3u5JmC0q19vaw6Rwmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4ek3ukQlodnNyj3TacD+vjZIirnP8tT0eqaeK3zXb7v6nITl4Ct9wC9HxwztgA0FTq16EBX2FK5Bha3kA+myM6oebNshHTesjMS9InahzQwDqzQhwwbwpOl2tBQpjqaZD19E7Ta4VJdPCJvaiYUGYnHq34sMJRMTjjM1BMRWqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UiMU2i4Z; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e28fa2807eeso2483839276.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728672131; x=1729276931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEpU+ihmki2IJbXkgKPvOcj9mDJ1xqWdvlEU1cTSkUY=;
        b=UiMU2i4ZXfRL26G3DOTKJOEfJO+0+38VFacxrE1Op1wZXG2+/uPW5ZjFgQPISkk6bm
         ODwpbKEPSmiPw7j4j8t3CZvRa8kSq5a42EtL/4mCG5Gvg66mzK/iqddd6Z4YkTBP66jo
         hz2Tfxex9nPaPvsNckm5mA52Yf/CkWcEv8Mij1mFY8mP1a+RtoQEE0aV0A9ipYcpdd46
         xYHxt/xMKUngl+DH3d9O5JH4hf55MqSXGhq5UYLhsLHN0QPb/O9OgobumjPgOT3Vr+ra
         oLX7BJMFdzj2DLN1Frn0D8yKWhnmo7a2OF9nL4Wj6+94KAUNxvOw9+t3YoHZQsyOuSag
         kunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672131; x=1729276931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEpU+ihmki2IJbXkgKPvOcj9mDJ1xqWdvlEU1cTSkUY=;
        b=EXNjQgfL+0hqUDEGPpE78wL+2cWLqBKAqlu3I9HMP1KxtYGf+LtGkd66/eiLjLeFb9
         5h66wGinOxB/6WgUQk8o01Hih3ZUYMEfUuA2ceSekyjyyhhv3mi19u6BZ/2RMA+3ZlPH
         1/ruD1r6wW9Uv/93hPuiHEAWKESijIO8cJPmwSQZIITPsz06zSR2Yx0lAA7YPRCOWsUD
         CKVh00LhnIJOJiUgn27L/d+sQ2zoLA9eOfm/GQDLUdJHCyL5Q3DaQ2E6HETB+UCb7vTe
         s5yluAH7n3Aq1Bgv7/S+dmMwWKbW6A3qZMRoVjd2GXo/MzPyTSMAVk7GxI0/0aGP08gA
         vBNA==
X-Forwarded-Encrypted: i=1; AJvYcCVl3OfDQ7y8zAPPiYrjyv/b6mtwJkC+WJa1cOfyudGi0c5kC1U/pkmQEXVPxeA3OcEPDDGK1ipkXOSZsJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJOi2/+hdTIHOkYEL/0rZVVfS0lh1AbC93WAPWF/LLVmGM0tw+
	IDRbtqiCvIV7rYonqcguubVClQqnuZub4gghOd3XGe7Yt39nSWz/brpnXbsT6l9h7j6EVV9/Yp1
	n1SzVhawfy4EHvt/8yl/aRbD/J8IhShiAwq/4Z5hRHKXxAh4=
X-Google-Smtp-Source: AGHT+IHl9pAM7khqQXTT6XeQ83ZZMoJPB/ej4flIEfjQ9ig+rT5Tafd7vJpMVu9ZDKNGmsLDDiBR89PO0T5VeahSCpQ=
X-Received: by 2002:a05:6902:727:b0:e29:255:c61b with SMTP id
 3f1490d57ef6-e2919d66b89mr3821890276.5.1728672131311; Fri, 11 Oct 2024
 11:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009173222.12219-5-casey@schaufler-ca.com>
 <4e2669fc0be9b0f1ca15b17ca415a87d@paul-moore.com> <a4094e38-44c9-4ab2-9b37-c1eafee16d5e@schaufler-ca.com>
 <CAHC9VhSaCVvj-+U+WEBxvzXyi=FPNaL7HMt4Kg86Ugi1SNnCdg@mail.gmail.com> <c3423767-91df-4dc9-afe8-895540b185d7@schaufler-ca.com>
In-Reply-To: <c3423767-91df-4dc9-afe8-895540b185d7@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 11 Oct 2024 14:42:00 -0400
Message-ID: <CAHC9VhRcAj8Pjt9E0_bMa5ybW0+LuzpQkgQ8Q+hZ5Pc6GHH9wQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/13] Audit: maintain an lsm_prop in audit_context
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 12:34=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 10/11/2024 9:11 AM, Paul Moore wrote:
> > On Fri, Oct 11, 2024 at 11:52=E2=80=AFAM Casey Schaufler <casey@schaufl=
er-ca.com> wrote:
> >> On 10/10/2024 8:08 PM, Paul Moore wrote:
> >>> On Oct  9, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>> Replace the secid value stored in struct audit_context with a struct
> >>>> lsm_prop. Change the code that uses this value to accommodate the
> >>>> change. security_audit_rule_match() expects a lsm_prop, so existing
> >>>> scaffolding can be removed. A call to security_secid_to_secctx()
> >>>> is changed to security_lsmprop_to_secctx().  The call to
> >>>> security_ipc_getsecid() is scaffolded.
> >>>>
> >>>> A new function lsmprop_is_set() is introduced to identify whether
> >>>> an lsm_prop contains a non-zero value.
> >>>>
> >>>> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >>>> ---
> >>>>  include/linux/security.h | 24 ++++++++++++++++++++++++
> >>>>  kernel/audit.h           |  3 ++-
> >>>>  kernel/auditsc.c         | 19 ++++++++-----------
> >>>>  3 files changed, 34 insertions(+), 12 deletions(-)
> > ..
> >
> >>>> +/**
> >>>> + * lsmprop_is_set - report if there is a value in the lsm_prop
> >>>> + * @prop: Pointer to the exported LSM data
> >>>> + *
> >>>> + * Returns true if there is a value set, false otherwise
> >>>> + */
> >>>> +static inline bool lsm_prop_is_set(struct lsm_prop *prop)
> >>>> +{
> >>>> +    return false;
> >>>> +}
> >>> If we're going to call this lsmprop_is_set() (see 5/13), we really sh=
ould
> >>> name it that way to start in this patch.
> >> Agreed. That's an unfortunate artifact of the lsmblob to lsm_prop name=
 change.
> >>
> >>> Considering everything else in this patchset looks okay, if you want =
me
> >>> to fix this up during the merge let me know.
> >> I can do a v5 if that makes life easier, but if you're OK with fixing =
it
> >> during the merge I'm completely fine with that. Thank you.
> > For trivial things like this where I've already reviewed the full
> > patchset it's easier/quicker if I just make the change as I can do it
> > and not have to re-review everything.  Otherwise it's another revision
> > for you to post, me to review, etc.; granted in that case I'm really
> > just diffing between v4 and v5, not really doing a full review unless
> > something odd pops up in the diff, but I think you get the idea.
>
> Indeed. Go forth and merge. Thanks again.

... and now everything is merged into lsm/dev, thanks everyone!

--=20
paul-moore.com

