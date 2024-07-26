Return-Path: <linux-kernel+bounces-262889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 328B293CE50
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AB941C20C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 06:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A8717625D;
	Fri, 26 Jul 2024 06:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zPNaj7X3"
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647142C9A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721976664; cv=none; b=IZh14b6yiIw7sqt2qJbQrcwMwFUQMaAfJ/j9WM7liDOAnAhh1XYtMDJ0eUxYNgHFyF9R3uTcef8K/C70ZDv9VEZNZLNTsvkrBHf/ANd5yCwq0v1s7OxQC9Nfp62tExUt+mVPwezDIDU5ELiJErte4x3W0AYZcbRFL5yr0zBppXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721976664; c=relaxed/simple;
	bh=bOrdCKvguQC+YaB6h3s3lVZl3WBnLHpu+JUwcZnQ2Yo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EdvWJa1dol5wDwhJyyY+Ws2qQNu0HlfZ+c/1KukF9t9m1B1Q3LUGIid49Zw3c1AVzNsXY355Wxy8OV9VJAfjh7ralOuPg49nQMUH6kRdD+c3zqZ9Esf+uNrWZCe0aPVz4CaYX7o1joW9VM9F3mPNVsevxGVLoyQKrjMJ6UNxJM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zPNaj7X3; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a7ab50e6735so66251766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 23:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721976661; x=1722581461; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOLKGqHkSptnv/m/NuKOIAdG2X8Tq9WhgZPqQX5CUc0=;
        b=zPNaj7X3MPrXXKLeAhH81dfM7r6V0xFDhGQZzDA/ahW/OkNVDLkBfWPg2BBCtzlKRt
         lXnz4hBHeMf0zAiklYgwQtLglygTrbaMozjtK2BUyNvOdqsoLUG7+O6gd7GYB7CzVDCJ
         HRlJUowJYSA/fp5F+L8c2IOo4ZIGmsB90huOCaFsvhoQoEI8g91rb8pQRWUkLWoELlkJ
         JKLnRoJc0tf16Q/k1nXNcEyMDu4NA5Fbpv5qhshr5mlfih+HOyVr7LLRi5Vx+pHiaEWT
         Ebn65HQrOUpIqr5uIfUABuS0XiMnXWJUTxnRawv3k7sZfcYp81nPFemCEw1IDUvrVxRR
         43XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721976661; x=1722581461;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bOLKGqHkSptnv/m/NuKOIAdG2X8Tq9WhgZPqQX5CUc0=;
        b=rrQLgIjECi3w0wlcLMNZLtb61Q+ENPyU19VL3ZWOOIkUF3pgYTo3PSnXYfXeAOzpsu
         eSqKU/5vxpyCU15dG4C6yBOLNKhgZC+t7kWX/HW63DJiVKIgAA8X90pNmGCF0Mta1MPV
         I/60O63KuWti+6vWp4/p5GY3sn9gl98WInXfEDsvmpvfPHrYyyAHn9/6SKRL5+iG3RNe
         K7s0YXi4qSV00ypCvz4z2J7JFWsmijFCO7RZeVDM9/z5q9ohbvBoykWwFvq4/S66MMHl
         v+QBw60Q4NAqI5gTBiBXPg9lRlSV4fIA9dQ1HVD4oHtUWktrjzB9Nh6xICHSO4cGgbXz
         12tg==
X-Forwarded-Encrypted: i=1; AJvYcCUoXPeEE3twP/fYew7oSzxzuhkZ6czK23iGjDlGKeYTwKSZS8zShcmRKPGfCA1s/geqcl+uYOBffYnraOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxclqZ701h18Ky25CtDz6NNX15HpRJa2CqIa35GHkWJLEDeCNVS
	OVws3AMKF7sd94bjB5f3lRQ2iZHJwpYi9vfFbQC4K7WHYzThkEoJnH9KD7jP5QlWtSLntc9FC0e
	K2g==
X-Google-Smtp-Source: AGHT+IFx9VhTiVJ6SOadIa9dxcURzunfi3a2JEINT2ESVsbZ2/OWjU51l+q8FY6uKZeu50wlnGWFGbQrjdc=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:dff1:b0:a7a:825a:de55 with SMTP id
 a640c23a62f3a-a7ac51735d4mr300366b.5.1721976660485; Thu, 25 Jul 2024 23:51:00
 -0700 (PDT)
Date: Fri, 26 Jul 2024 08:50:58 +0200
In-Reply-To: <20240725.wahChei0Hoo4@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1721269836.git.fahimitahera@gmail.com> <d7bad636c2e3609ade32fd02875fa43ec1b1d526.1721269836.git.fahimitahera@gmail.com>
 <20240725.wahChei0Hoo4@digikod.net>
Message-ID: <ZqNHQcqPuMUUjOc9@google.com>
Subject: Re: [PATCH v7 1/4] Landlock: Add abstract unix socket connect restriction
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Tahera Fahimi <fahimitahera@gmail.com>, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bjorn3_gh@protonmail.com, jannh@google.com, 
	outreachy@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 04:18:29PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Wed, Jul 17, 2024 at 10:15:19PM -0600, Tahera Fahimi wrote:
> > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.=
c
> > index 03b470f5a85a..799a50f11d79 100644
> > --- a/security/landlock/syscalls.c
> > +++ b/security/landlock/syscalls.c
> >  /**
> >   * sys_landlock_create_ruleset - Create a new ruleset
> > @@ -170,7 +171,7 @@ static const struct file_operations ruleset_fops =
=3D {
> >   * Possible returned errors are:
> >   *
> >   * - %EOPNOTSUPP: Landlock is supported by the kernel but disabled at =
boot time;
> > - * - %EINVAL: unknown @flags, or unknown access, or too small @size;
> > + * - %EINVAL: unknown @flags, or unknown access, or uknown scope, or t=
oo small @size;
>=20
> You'll need to rebase on top of my next branch to take into account
> recent G=C3=BCnther's changes.

Actually, I have missed this particular line in my recent documentation cha=
nges,
but I agree, we should follow the advice from man-pages(7) consistently -- =
the
preferred style is to list the same error code multiple times, if there are
multiple possible conditions under which it can be returned.

(Please also fix the typo in "uknown".)

Thanks,
=E2=80=94G=C3=BCnther

