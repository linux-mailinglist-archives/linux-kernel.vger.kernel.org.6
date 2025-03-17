Return-Path: <linux-kernel+bounces-565062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 053AFA6601E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B225F1885D3D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 21:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1B31FBEBD;
	Mon, 17 Mar 2025 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="aOnkj8b8"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4C118A6BA
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742245444; cv=none; b=Mxr2TOR0QcYOrNgrX3O9t7jfVJnPfA0tU6Txpr5zewiTOrtZ+cJYknA316N+MJ+4u4MuX5f2toN/viZIN1JqZX3y/axI/i8D3oTMOQtUFtA+i0zfrzcYxFNwpHwUSt2e1Jnm9CQWEDlWsGa12MH/UpY4qzbfIIjloTERjokGkTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742245444; c=relaxed/simple;
	bh=4DZV6Mf22HPdspxseNYgEQU/HJNgzwH7tOtAOoYex8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBkSKL98V+x761bziekpkzr1ouOT+7SQvvSIp46LdEK0nMSefHvmftZmWjjcdjMO5rnW1w1Ny3rw0QhGn/7VLukJ+IwUVvbxEeGU9bWxyOi09qpFSWnl4KVd4eE3oTnzhGnr62jLEIrrH/h3VaqOdSdX5Tp3pwzpP35dRvd6IOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=aOnkj8b8; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6f7031ea11cso52146347b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 14:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1742245442; x=1742850242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lN0WAY63eQ+SjxSDZ4iWpY0cwX3v9NBuvFxMG3JYoRs=;
        b=aOnkj8b8mbPZyGV0rC9333QvbDI+I2R/Vz8nVQk42xkwb5J+exH74xNB4QJFxKGlxC
         GR7ZG1qEh5Ss9hrMEumj8ydE6qXZIH5cYzl7wzRIC6AL7EQZqYBmazG40urLsAaWqkyU
         bhv0fCmfLvgLAfgtY/dz1nLb/30CGUT26rKeQ9Q94R7px38yzj7aULMMndX7SgvWm/Av
         i0OYx+nI2noc77jVxn0xUnQB+IG8LkJ+A3EEMv0FnN0WmymRtgxTHMxR9ecnRPvbqfkZ
         vDrpNjeQZ6nCV+c1tRkJkzmYCC1lE8Ws/d/WF/XoKWDP1f1L6iGRwqduO8uTMNOFGlLA
         oH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742245442; x=1742850242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lN0WAY63eQ+SjxSDZ4iWpY0cwX3v9NBuvFxMG3JYoRs=;
        b=cei5jZCNAK8hT17hJ7vj33263cBj1U04CTzHAXGh/5lDW8k0OfpHTLOSzTIyMfqGYx
         8C3ZxHUI46XjkWafgmBw71xHEyRFTBUPgmkE6IvFzHxfT6GHWZvtJczTYrFxqxytJxcm
         mYdEb5JxsH4024Iq6nwKa9ilvOcw4hvKVwtgg6EbYXfT4Z6zNdx0qivnXrvKBwTxg10c
         AYgS6BQ425gR/gxnf1fne07ILqaVHKFU8fmm9pOIKrbPnE5Zo1C2keU9e144nDY276hk
         zTZqXDvMM0fGwCkE1+3SmaXJQA7ZXG+73BnfxBPGsPHaCly41dBu/ipQchITRjgpUCIs
         KimA==
X-Forwarded-Encrypted: i=1; AJvYcCVSohImxpTAQXLuVdSTSRnln3ADgKgqHqZZYMbqaoeCUJwr+z5KtmQNPEZviz7HuM3T2K1wgupC4i09ZKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJSTNyKqmQdSR+pGVLgbGryB2J/f2aGWQaEHjaBIUCG3AZ5SQS
	wu+/LR+8BeCppWhbZzW5uC/YoJyfCb+daBGaXdFfpzBawuExvCCD/iANviAZZ1qtwdC0mlaslRC
	TPRMhWZAZLKOhoXnMuYzvZYg3GsAnVtk22zCs
X-Gm-Gg: ASbGncvLXNKo6VaxFiAf8/fY3hfVTmdy+jtodOC06GJspS5Em2SXazbcZjkll8teABb
	dcLkl9dTsrwbH7LcXc+LuSiSP8r8sS/h6Tn2YiHDOPhu5Z/oizUUX3WU9SWndIhL5lTxFB/Ivjz
	zt4D9PX7juxATeor71eXZLSXipww==
X-Google-Smtp-Source: AGHT+IHCEoZCaxv7OeUD/lycaKqmsWh9p2nUqOcZQrmR9zpt7xGkZ3QRivr7CV15cEdv0CsTFj9gYBS74SPFr3Jm474=
X-Received: by 2002:a05:690c:4882:b0:6fd:2feb:eb6e with SMTP id
 00721157ae682-6ff460bbcadmr182599447b3.28.1742245441971; Mon, 17 Mar 2025
 14:04:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1741902661-31767-1-git-send-email-jasjivsingh@linux.microsoft.com>
 <1741902661-31767-2-git-send-email-jasjivsingh@linux.microsoft.com> <CAKtyLkGuRraMbArSQCGxb+m5p+M8G5WZCTHk-7dKVfQd2EJYxw@mail.gmail.com>
In-Reply-To: <CAKtyLkGuRraMbArSQCGxb+m5p+M8G5WZCTHk-7dKVfQd2EJYxw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 17 Mar 2025 17:03:51 -0400
X-Gm-Features: AQ5f1Jrwt6khDXjv0IVheA9isqgUbo47peyyUpS_OaZh_PBVr6OQzM6Nq_CsvzI
Message-ID: <CAHC9VhRPU1C1-B=PUwUcheOmYhSDzHJMmcpg3j9z0DPiMOHydg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] ipe: add errno field to IPE policy load auditing
To: Fan Wu <wufan@kernel.org>
Cc: Jasjiv Singh <jasjivsingh@linux.microsoft.com>, corbet@lwn.net, jmorris@namei.org, 
	serge@hallyn.com, eparis@redhat.com, linux-doc@vger.kernel.org, 
	linux-security-module@vger.kernel.org, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 4:59=E2=80=AFPM Fan Wu <wufan@kernel.org> wrote:
> On Thu, Mar 13, 2025 at 2:51=E2=80=AFPM Jasjiv Singh
> <jasjivsingh@linux.microsoft.com> wrote:
> >
> > Users of IPE require a way to identify when and why an operation fails,
> > allowing them to both respond to violations of policy and be notified
> > of potentially malicious actions on their systems with respect to IPE.
> >
> > This patch introduces a new error field to the AUDIT_IPE_POLICY_LOAD ev=
ent
> > to log policy loading failures. Currently, IPE only logs successful pol=
icy
> > loads, but not failures. Tracking failures is crucial to detect malicio=
us
> > attempts and ensure a complete audit trail for security events.
> >
> > The new error field will capture the following error codes:
> >
> > * -ENOKEY: Key used to sign the IPE policy not found in the keyring
> > * -ESTALE: Attempting to update an IPE policy with an older version
> > * -EKEYREJECTED: IPE signature verification failed
> > * -ENOENT: Policy was deleted while updating
> > * -EEXIST: Same name policy already deployed
> > * -ERANGE: Policy version number overflow
> > * -EINVAL: Policy version parsing error
> > * -EPERM: Insufficient permission
> > * -ENOMEM: Out of memory (OOM)
> > * -EBADMSG: Policy is invalid
> >
> > Here are some examples of the updated audit record types:
> >
> > AUDIT_IPE_POLICY_LOAD(1422):
> > audit:  AUDIT1422 policy_name=3D"Test_Policy" policy_version=3D0.0.1
> > policy_digest=3Dsha256:84EFBA8FA71E62AE0A537FAB962F8A2BD1053964C4299DCA
> > 92BFFF4DB82E86D3 auid=3D1000 ses=3D3 lsm=3Dipe res=3D1 errno=3D0
> >
> > The above record shows a new policy has been successfully loaded into
> > the kernel with the policy name, version, and hash with the errno=3D0.
> >
> > AUDIT_IPE_POLICY_LOAD(1422) with error:
> >
> > audit: AUDIT1422 policy_name=3D? policy_version=3D? policy_digest=3D?
> > auid=3D1000 ses=3D3 lsm=3Dipe res=3D0 errno=3D-74
> >
> > The above record shows a policy load failure due to an invalid policy
> > (-EBADMSG).
> >
> > By adding this error field, we ensure that all policy load attempts,
> > whether successful or failed, are logged, providing a comprehensive
> > audit trail for IPE policy management.
> >
> > Signed-off-by: Jasjiv Singh <jasjivsingh@linux.microsoft.com>
> > ---
> >  Documentation/admin-guide/LSM/ipe.rst | 69 +++++++++++++++++++--------
> >  security/ipe/audit.c                  | 19 ++++++--
> >  security/ipe/fs.c                     | 25 ++++++----
> >  security/ipe/policy.c                 | 17 ++++---
> >  security/ipe/policy_fs.c              | 28 ++++++++---
> >  5 files changed, 113 insertions(+), 45 deletions(-)
> >
>
> ...
>
> > diff --git a/security/ipe/policy.c b/security/ipe/policy.c
> > index b628f696e32b..1c58c29886e8 100644
> > --- a/security/ipe/policy.c
> > +++ b/security/ipe/policy.c
> > @@ -84,8 +84,11 @@ static int set_pkcs7_data(void *ctx, const void *dat=
a, size_t len,
> >   * ipe_new_policy.
> >   *
> >   * Context: Requires root->i_rwsem to be held.
> > - * Return: %0 on success. If an error occurs, the function will return
> > - * the -errno.
> > + * Return:
> > + * * %0        - Success
> > + * * %-ENOENT  - Policy was deleted while updating
> > + * * %-EINVAL  - Policy name mismatch
> > + * * %-ESTALE  - Policy version too old
> >   */
> >  int ipe_update_policy(struct inode *root, const char *text, size_t tex=
tlen,
> >                       const char *pkcs7, size_t pkcs7len)
> > @@ -146,10 +149,12 @@ int ipe_update_policy(struct inode *root, const c=
har *text, size_t textlen,
> >   *
> >   * Return:
> >   * * a pointer to the ipe_policy structure     - Success
> > - * * %-EBADMSG                                 - Policy is invalid
> > - * * %-ENOMEM                                  - Out of memory (OOM)
> > - * * %-ERANGE                                  - Policy version number=
 overflow
> > - * * %-EINVAL                                  - Policy version parsin=
g error
> > + * * %-EBADMSG                         - Policy is invalid
> > + * * %-ENOMEM                          - Out of memory (OOM)
> > + * * %-ERANGE                          - Policy version number overflo=
w
> > + * * %-EINVAL                          - Policy version parsing error
> > + * * %-ENOKEY                          - Policy signing key not found
> > + * * %-EKEYREJECTED                    - Policy signature verification=
 failed
> >   */
>
> The indentation here is not aligned.
>
> I don't see any other issue, if there is no objection from the audit
> folks, I will pull this into ipe's tree.

No objections from me.

--
paul-moore.com

