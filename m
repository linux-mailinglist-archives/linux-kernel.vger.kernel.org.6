Return-Path: <linux-kernel+bounces-376616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E855E9AB3F9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4132816A1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1171B5820;
	Tue, 22 Oct 2024 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FNyJs8ZA"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859B1A76D1
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614519; cv=none; b=VXqpyGgSlROXFk6rgnNCZsqG1J64OElsTeWBxSxz/AC439o2viO+yLAMN7oxZoJcpEwG0RItjTRtnXsqrU/c6UuiQXVC3vRDaqohK6BKWv8HhGvRG2etnawoegY4Nq0ouz7MXWJbmJauiWbNbGNG5z/PBEzzqOvfe30xqc8vnkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614519; c=relaxed/simple;
	bh=iXjeFKiD99haFW/5MC3Hv9lDG8yZPMN7OzwoUnSvoRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLmx8pv/TJyroIVZ9de031H5JphO9ySGzXRQw5hUQpUiWExnZRqB/7Ljc2mnddaAv+iLF8G55ov3jrwUuRM2zBBtyUMuU3BxqsBJZ8WcjB0m5rGsWnE0OGLfrU1xo4EED7jHt9LOW9YfRNSSMp63zMo9A79a3fSjTs6p/bJeiQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=FNyJs8ZA; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e28fe3b02ffso5480347276.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729614517; x=1730219317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tWYJNGzZWfbmwj1ofhCHll6/oPb1z1h29ShW2Fi22MM=;
        b=FNyJs8ZAmFYvq4M4Cro/+ITlt7MppTmuKsaI9XEdsWZJqdC5JAe84o8VGDG+objZ51
         jM7eY6SljnSXUHvmgwpGVll+FiJcKc7GlkJIkqlBf+qGoSPCX4oKv2rd6iLOymSfEysb
         HA3iLDqL7Cm92mP4QIzmTpJkUnDMhHlozb2EdDsaPOwmixaJlhGHpTTrV50URAdSuKqu
         oRjTO5eYTkhBuRz4i4VYrEJQbA0D7ApUXZA2H5is4KRlQITEsVnHsLXKSewZpWYFDLRJ
         ROA4VTBMtuXEghn/+yjPK0y+8x018Mhx6q2on2d8LYEEXrOp0CU4SG7Lp+C1RY881e1z
         IW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614517; x=1730219317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWYJNGzZWfbmwj1ofhCHll6/oPb1z1h29ShW2Fi22MM=;
        b=N5lExaWaqJ4XLWTgCZEm1Aa1vIQPD/QGoXMpu0IMEmNzK1urZ9y670JaZaB4+iQCR0
         2PxbDr5rXVt/86aAfFJhWrJTlbo+bu/znyZOSSVFbhbyAiJZvSsC911mMtpTDHOAugR5
         +GtJcCnxr1kIFQQegwEJnARfepJOx1SXhCBHVvmAtFFiyUyYZllSmMuzfamXQsFYG4Ur
         yPMCO/+cYYux+GexYv/UBCpY4I5Wm9XxKjfX9Qdea/+RNs6KZRv6GmszdAs2GwEwAM4A
         1URIEdhn+OBcLsXv+feWaGd3hoJ4fSU9PQ21WjpSs0NsKT2zCBkiEpkjTIf2sQJswKFL
         ejAA==
X-Forwarded-Encrypted: i=1; AJvYcCWYbqNu9E8zqns3khKlH74bKcz/TuURKxOrI4q1riMaI9Hf4pcaPJGs7/0gKsHhWHCpyw7EvY4V1hj6+0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/T/bsa3TK7e9vJBAOXZHNic2veE4uBFAAmqin7fxCmIK5m6DC
	Mqd47PLAl0PGzgdtjnInNR6Fyxs5swlm+TzQSG9CSiMU6WHTFM8aec0lZWIMamvYamUS4+KjcGu
	NG5a3bddhG8GN8kpjy7db38ktut3P4m1nw9VM
X-Google-Smtp-Source: AGHT+IG8gwlSMlcXwhB5hmB2a2N3NP1Y0saoWpYAmsDJuzddp8xHNIDF6id0PJuosvZNqRP2WWC0i4XxnfSqteqw3o4=
X-Received: by 2002:a05:6902:2501:b0:e28:fec0:c673 with SMTP id
 3f1490d57ef6-e2e271bb115mr2837315276.31.1729614517559; Tue, 22 Oct 2024
 09:28:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014151450.73674-6-casey@schaufler-ca.com>
 <5b6addd938c9feae0b4df8f54d56f9f0@paul-moore.com> <617a2679-404c-4127-8dfd-4f3895e2372f@schaufler-ca.com>
In-Reply-To: <617a2679-404c-4127-8dfd-4f3895e2372f@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 22 Oct 2024 12:28:26 -0400
Message-ID: <CAHC9VhQzva=uKWqFduADzvyTR+NXokCH6R7WNe6RgmDDa-Ge1g@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] LSM: secctx provider check on release
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 8:06=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 10/21/2024 4:39 PM, Paul Moore wrote:
> > On Oct 14, 2024 Casey Schaufler <casey@schaufler-ca.com> wrote:
> >> Verify that the LSM releasing the secctx is the LSM that
> >> allocated it. This was not necessary when only one LSM could
> >> create a secctx, but once there can be more than one it is.
> >>
> >> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> >> ---
> >>  security/apparmor/secid.c | 10 ++--------
> >>  security/selinux/hooks.c  | 10 ++--------
> >>  2 files changed, 4 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/security/apparmor/secid.c b/security/apparmor/secid.c
> >> index 5d92fc3ab8b4..974f802cbe5a 100644
> >> --- a/security/apparmor/secid.c
> >> +++ b/security/apparmor/secid.c
> >> @@ -122,14 +122,8 @@ int apparmor_secctx_to_secid(const char *secdata,=
 u32 seclen, u32 *secid)
> >>
> >>  void apparmor_release_secctx(struct lsm_context *cp)
> >>  {
> >> -    /*
> >> -     * stacking scaffolding:
> >> -     * When it is possible for more than one LSM to provide a
> >> -     * release hook, do this check:
> >> -     * if (cp->id =3D=3D LSM_ID_APPARMOR || cp->id =3D=3D LSM_ID_UNDE=
F)
> >> -     */
> >> -
> >> -    kfree(cp->context);
> >> +    if (cp->id =3D=3D LSM_ID_APPARMOR)
> >> +            kfree(cp->context);
> > Should we set cp->context to NULL too?  One could argue that it's an
> > unecessary assignment, given the cp->id checks, and they wouldn't be
> > wrong, but considering the potential for a BPF LSM to do things with
> > a lsm_context, I wonder if resetting the pointer to NULL is the
> > smart thing to do.
>
> Wouldn't hurt. I'll go ahead and add that. If a BPF LSM does anything
> with a lsm_context we're likely to hear about the many issues quite
> quickly.

Yes, I suspect you're right about that, at least we can protect
against a UAF in this one case :)

--=20
paul-moore.com

