Return-Path: <linux-kernel+bounces-225343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16494912F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 23:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C140D2822A4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4965B17C206;
	Fri, 21 Jun 2024 21:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZZQtfcVr"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E46516D4CE
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 21:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719004745; cv=none; b=V0C16wtzTTM0ucVr1UPWdjS1JWO2wfVO1llMmwLsl5+LDXijt8OnsgGLpoLy7ZQml3p9gL1st26bTgHyM4s0/s23R4z9+N5KMGtGhy6Rijo2nDAzqnVpERxaxBKUhiPycRj6hzo8aSxyWW1+jLdMOTPv8vom2/4rymXka++Zxcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719004745; c=relaxed/simple;
	bh=X9WSMFU/wNIJq2RKIpQCKPYG8Sq+Ik2gDt2GAk8E5kA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gIXTxEuDQWCWeh20+se46j+MQGz4UL4PlC6uNxCq39o/lYoc+jNmwnm9tuk1pKPfozlZPY432jh31Hs8DmOPu9vPvgGuv05jSIi/ZNBvsAbl9TmcQFPsyutUeg0qT87/VEJGCTwaZRRFpdvSRaI6cjluwvxbLADOcbwi4MGyirc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZZQtfcVr; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dff1ccdc17bso2591093276.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 14:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1719004741; x=1719609541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pCD4r20mrpTxmvcMRXNwOiX5qAdOlLJEKmqvDoOzpPQ=;
        b=ZZQtfcVr4rAIifpUrpBSrSr0wwaRMF2r56zZSDIge/Es78JpQj6HlQD55SzUo35QoB
         qDMSibqzG1qXRU0vaMjAI8RI37Et6X/cDpJxKcFGuboY2D+A2qohA5fMrRkD1k9PDnwt
         V+rZDtpnIAURXlNJN3xcvt87/P4UKtKJemWv/yS4CpVFmExYLSi5Q+sm7ddasog0Zvpm
         R7LsaOTz/0u/XZdSRrB/mY8bd3Wz9j2mes60YF45yB6AABSYbjUKk715qtvByOMINFdV
         epc5CRpGY55ykQMR8Iy24GgxhU/9j4MRr+Wsu7DYSM2bhnn99KWdw0BTXIDpBX0oqkzx
         OpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719004741; x=1719609541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pCD4r20mrpTxmvcMRXNwOiX5qAdOlLJEKmqvDoOzpPQ=;
        b=XchvOIxaQSg05x7hwgbQWq3eM5FJQYFYeexaTUVYF8H+1ZCSP0/Fpnjz3eIqxeA/aH
         XzeNqrLjwHqcJaatwI3egGSRdrZxAjYoB/WC7C2FM14FC9Ntb5ojy/AqVljNXhUdW388
         nScILh+sOuQeexysc0vnoPtuq/7vVGWTZ+/eysXOeUpn1MEPbx6IVXIhMQedcZhvmfmS
         EiwZ5fmTaQw3YSy4LEtGhUpqwjSJly4fO02FbGg3uX6QHdj4TBJefS5LECMDCXnbMohk
         7UF/zDXLmeAYCF+1cHC3tQ7misEn4gsleHuZkT2aoVr14vNh+tmI5O/N6GzmGstr2n8/
         Rt0A==
X-Forwarded-Encrypted: i=1; AJvYcCVuz1wzqv4etmysQqGVQofpl+I2XNYM101sQOf0MZkk7uDtP2yE8RcLkXoPh5fxFQaudbkqVzUNMnDlkOptttasE5KOEEdrLtCGsDD4
X-Gm-Message-State: AOJu0YyNDdUzQh7Q5J5kzov1Ou1Ux6OvBmyIQYjRtNi0CvzsuraHgXUD
	CTPJ9+ngSIWbKr2Yd0eXBdnprpR1HNdkcvPefh9/Yxc0qIc6EIPOMl7KRuVgWd158ZxgB2d8kf0
	ZzQ9ez3k0uw43KU1ZsNKXSXB23EoecrlynxYD
X-Google-Smtp-Source: AGHT+IFe108rxfdI4dceOPLQyYzs1eDja/U43G2YmMGoBEVShtoTYQzpQ8euwTVDfc0m+2FKogi3L+jAlR4yzx48SCE=
X-Received: by 2002:a25:5f50:0:b0:e02:b9ac:1486 with SMTP id
 3f1490d57ef6-e02be22e5ebmr9441533276.57.1719004741560; Fri, 21 Jun 2024
 14:19:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215221636.105680-1-casey@schaufler-ca.com>
 <20231215221636.105680-2-casey@schaufler-ca.com> <CAHC9VhT+QUuwH9Dv2PA9vUrx4ovA_HZsJ4ijTMEk9BVE4tLy8g@mail.gmail.com>
 <CAHC9VhSY2NyqTD35H7yb8qJtJF5+1=Z4MHy_ZpP_b7YDT-Mmtw@mail.gmail.com> <fbf7f344c518d70833398c2365bb2029480bd628.camel@linux.ibm.com>
In-Reply-To: <fbf7f344c518d70833398c2365bb2029480bd628.camel@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 21 Jun 2024 17:18:50 -0400
Message-ID: <CAHC9VhTPE-dcwVWeMf=S8ci2J_h9Cm4B54knaskFKBOaYSEWiw@mail.gmail.com>
Subject: Re: [PATCH v39 01/42] integrity: disassociate ima_filter_rule from security_audit_rule
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org, mic@digikod.net, 
	linux-integrity@vger.kernel.org, Casey Schaufler <casey@schaufler-ca.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 4:27=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Fri, 2024-06-21 at 15:07 -0400, Paul Moore wrote:
> > On Fri, Jun 21, 2024 at 12:50=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > On Fri, Dec 15, 2023 at 5:16=E2=80=AFPM Casey Schaufler <casey@schauf=
ler-ca.com> wrote:
> > > > Create real functions for the ima_filter_rule interfaces.
> > > > These replace #defines that obscure the reuse of audit
> > > > interfaces. The new functions are put in security.c because
> > > > they use security module registered hooks that we don't
> > > > want exported.
> > > >
> > > > Acked-by: Paul Moore <paul@paul-moore.com>
> > > > Reviewed-by: John Johansen <john.johansen@canonical.com>
> > > > Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> > > > To: Mimi Zohar <zohar@linux.ibm.com>
> > > > Cc: linux-integrity@vger.kernel.org
> > > > ---
> > > >  include/linux/security.h     | 24 ++++++++++++++++++++++++
> > > >  security/integrity/ima/ima.h | 26 --------------------------
> > > >  security/security.c          | 21 +++++++++++++++++++++
> > > >  3 files changed, 45 insertions(+), 26 deletions(-)
> > >
> > > Mimi, Roberto, are you both okay if I merge this into the lsm/dev
> > > branch?  The #define approach taken with the ima_filter_rule_XXX
> > > macros likely contributed to the recent problem where the build
> > > problem caused by the new gfp_t parameter was missed during review;
> > > I'd like to get this into an upstream tree independent of the larger
> > > stacking effort as I believe it has standalone value.
> >
> > ... and I just realized neither Mimi or Roberto were directly CC'd on
> > that last email, oops.  Fixed.
>
> Paul, I do see things posted on the linux-integrity mailing list pretty q=
uickly.
> Unfortunately, something came up midday and I'm just seeing this now.  As=
 for
> Roberto, it's probably a time zone issue.

Oh, no worries at all, please don't take my comment above to mean I
was expecting an immediate response!  I try to make sure that if I'm
addressing someone directly that they are explicitly included on the
To/CC line.  I was writing another email and it occurred to me that I
didn't check for that when emailing the two of you, and sure enough,
you guys weren't on the To/CC line ... I was just trying to fix my
screw-up :)

> The patch looks ok, but I haven't had a chance to apply or test it.  I'll=
 look
> at it over the weekend and get back to you.

No rush, enjoy your weekend, the patch isn't going to run away :)

--=20
paul-moore.com

