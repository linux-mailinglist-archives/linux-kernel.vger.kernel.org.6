Return-Path: <linux-kernel+bounces-288488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC7A953AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 21:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8F2283CEA
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 19:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2C1824A0;
	Thu, 15 Aug 2024 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="b/833JVa"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19F776026
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 19:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723749099; cv=none; b=KbrYNCtNal9lcHkI/Ou7CIxYJYf1gD6treJo1IQRt7YmLe3VneKBLg4uzJzl4KYNYVnMq1811GpGGjbMlXKQXNz+7TmTqZMQIyXl9Xp5IxyMGquBJwsmrFus5cUOozeCS8L4JNWWZeMt5o/b0NEcphuODUZX7JcUVm1EbyEn1uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723749099; c=relaxed/simple;
	bh=iT8KcNkm5Vc4rWXXWzYad5f95oy1oD7zS37mBnhk8qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HfEwdGKhUOI8Ovo9rEpDUyU5hKqi63IGdy2Nkep77rA1FfjDP+NjI3oIB21Ydwz2B0gtPv8c0r0u8BzXdGtPTgpQwi2BXZhRwMSC7JIW+/MiLy4Tp8dUkRMOP9CV+cPwnAWU/qGBuVG8HlBMqPFv2ujPrPok0sll72d0JLoHung=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=b/833JVa; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6b0e93b7426so5056447b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1723749097; x=1724353897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FG2S68ohhhN7mqN86rt7i0TQ0nSZljd6+7LgE4Sf4cU=;
        b=b/833JVasD5s+Lj2eNJN9jLnSsWYatnDAHjM1TpBEDLfvTCzdph28c07nXTW4vkNYa
         QNrtI9G6N03ZSyXP+X8DRCBBYaqyvFHplkKg3XID3R83mc3lnzs1PaxCzNkt92CH5MWn
         cJoq0TL2TVsv4dQBuffE2O8RZ+WEEzWg9FTAw4XTTHviYXNapnutLobklKFGJttPj0bU
         Z3VKBCxhXxoOT9MW1UbVMoVwAOlr8EReuMy7YG2UMdJyHazEZ00oL/nQGvuRrYZ8Ftwy
         UHrq5tRJfuqtLEEwxuZWdCRCgx5G2O/znxclKJWi2QZM975aH4ctNrQEQy+oKMFSfn9M
         dpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723749097; x=1724353897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FG2S68ohhhN7mqN86rt7i0TQ0nSZljd6+7LgE4Sf4cU=;
        b=atbS0tUzJuYh1jsbQ/eLdPK1I2iU/g9WcNsF4mRZELhbgzWYEZ7XFMOQmpFypVVBca
         mwl/9Nn1Te68QVjCn8KSc+j4+3vcTSpGDVu4Pt/rlM/uvYCZQoO6wR+oqpeiRiJ4jmfO
         ChND0OauvRkOmSyUQQuW5wF1TndpC1EzET4Z75B6cxU/+ckseoqIrpzsCjVsYfDlx+mj
         jJ4cW9LxByEtzXzeVCtEN2KNg0sBlddzt+ZbxBhcvf1QMqjfGiiEHDQoc1Xq51kcfk+k
         mH4xV8xJm+M9fA6qJBXiCTzEg3I7N9Q0sv6dy4ZWyk4oj0j/W8Yp4HYgVpP25sINYloK
         Ynlw==
X-Forwarded-Encrypted: i=1; AJvYcCV5Q2FzPF89InKmW4bSiANzsOtne1h3m+CbDczLRjI/UwzqPQ0skIdl/UyTIqkkOM5aFgbz7aYbVq6V7Ev720Fp5aBqav5v/ar+jAhd
X-Gm-Message-State: AOJu0YynEv2PFMXLZp9lFEYEtlRoXqqBgSTmBaKcXawSJyCmbwt0wyYL
	SBRCsSbYrOtXYfmB76gzTiVGrJpgHGV/roYjjCHExoVqpQIZFgSgipj4kBiryrJXt58/HVlN3th
	yfISv8cY+TSRWSq2eVFyfqjzTm1aGN85AOJ5/
X-Google-Smtp-Source: AGHT+IHDMOF+V1detUBYqlec+/ieaF+20T3NZqgS/3i5J9m5G5afNPzd29f7rdg4GSJXu5gGfjj7nsQ0DdDhqrEmFZo=
X-Received: by 2002:a05:690c:3342:b0:651:4b29:403c with SMTP id
 00721157ae682-6af1b83243amr43005767b3.2.1723749095960; Thu, 15 Aug 2024
 12:11:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
 <1722665314-21156-3-git-send-email-wufan@linux.microsoft.com>
 <20240810155000.GA35219@mail.hallyn.com> <e1dd4dcf-8e2e-4e7b-9d40-533efd123103@linux.microsoft.com>
 <CAHC9VhTYT3RTG1FbnZQ2F68a16gU9_QJ-=LSGbroP-40tpRTiw@mail.gmail.com> <cbf1caa0-835b-4d1d-aed5-9741eb10cf8b@linux.microsoft.com>
In-Reply-To: <cbf1caa0-835b-4d1d-aed5-9741eb10cf8b@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 15 Aug 2024 15:11:24 -0400
Message-ID: <CAHC9VhQ6ndv4wU4CBBhABHuriPDg=CmBi+_TbjCg+DNsCRuRSA@mail.gmail.com>
Subject: Re: [PATCH v20 02/20] ipe: add policy parser
To: Fan Wu <wufan@linux.microsoft.com>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, tytso@mit.edu, 
	ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, 
	mpatocka@redhat.com, eparis@redhat.com, linux-doc@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	fsverity@lists.linux.dev, linux-block@vger.kernel.org, 
	dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Deven Bowers <deven.desai@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 2:23=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> =
wrote:
> On 8/13/2024 6:53 PM, Paul Moore wrote:
> > On Tue, Aug 13, 2024 at 1:54=E2=80=AFPM Fan Wu <wufan@linux.microsoft.c=
om> wrote:
> >> On 8/10/2024 8:50 AM, Serge E. Hallyn wrote:
> >>> On Fri, Aug 02, 2024 at 11:08:16PM -0700, Fan Wu wrote:
> >>>> From: Deven Bowers <deven.desai@linux.microsoft.com>
> >>>>
> >>>> IPE's interpretation of the what the user trusts is accomplished thr=
ough
> >>>
> >>> nit: "of what the user trusts" (drop the extra 'the')
> >>>
> >>>> its policy. IPE's design is to not provide support for a single trus=
t
> >>>> provider, but to support multiple providers to enable the end-user t=
o
> >>>> choose the best one to seek their needs.
> >>>>
> >>>> This requires the policy to be rather flexible and modular so that
> >>>> integrity providers, like fs-verity, dm-verity, or some other system=
,
> >>>> can plug into the policy with minimal code changes.
> >>>>
> >>>> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> >>>> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> >>>
> >>> This all looks fine.  Just one comment below.
> >>>
> >> Thank you for reviewing this!
> >>
> >>>
> >>>> +/**
> >>>> + * parse_rule() - parse a policy rule line.
> >>>> + * @line: Supplies rule line to be parsed.
> >>>> + * @p: Supplies the partial parsed policy.
> >>>> + *
> >>>> + * Return:
> >>>> + * * 0              - Success
> >>>> + * * %-ENOMEM       - Out of memory (OOM)
> >>>> + * * %-EBADMSG      - Policy syntax error
> >>>> + */
> >>>> +static int parse_rule(char *line, struct ipe_parsed_policy *p)
> >>>> +{
> >>>> +    enum ipe_action_type action =3D IPE_ACTION_INVALID;
> >>>> +    enum ipe_op_type op =3D IPE_OP_INVALID;
> >>>> +    bool is_default_rule =3D false;
> >>>> +    struct ipe_rule *r =3D NULL;
> >>>> +    bool first_token =3D true;
> >>>> +    bool op_parsed =3D false;
> >>>> +    int rc =3D 0;
> >>>> +    char *t;
> >>>> +
> >>>> +    r =3D kzalloc(sizeof(*r), GFP_KERNEL);
> >>>> +    if (!r)
> >>>> +            return -ENOMEM;
> >>>> +
> >>>> +    INIT_LIST_HEAD(&r->next);
> >>>> +    INIT_LIST_HEAD(&r->props);
> >>>> +
> >>>> +    while (t =3D strsep(&line, IPE_POLICY_DELIM), line) {
> >>>
> >>> If line is passed in as NULL, t will be NULL on the first test.  Then
> >>> you'll break out and call parse_action(NULL), which calls
> >>> match_token(NULL, ...), which I do not think is safe.
> >>>
> >>> I realize the current caller won't pass in NULL, but it seems worth
> >>> checking for here in case some future caller is added by someone
> >>> who's unaware.
> >>>
> >>> Or, maybe add 'line must not be null' to the function description.
> >>
> >> Yes, I agree that adding a NULL check would be better. I will include =
it
> >> in the next version.
> >
> > We're still waiting to hear back from the device-mapper devs, but if
> > this is the only change required to the patchset I can add a NULL
> > check when I merge the patchset as it seems silly to resend the entire
> > patchset for this.  Fan, do you want to share the code snippet with
> > the NULL check so Serge can take a look?
>
> Sure, here is the diff.
>
> diff --git a/security/ipe/policy_parser.c b/security/ipe/policy_parser.c
> index 32064262348a..0926b442e32a 100644
> --- a/security/ipe/policy_parser.c
> +++ b/security/ipe/policy_parser.c
> @@ -309,6 +309,9 @@ static int parse_rule(char *line, struct
> ipe_parsed_policy *p)
>          int rc =3D 0;
>          char *t;
>
> +       if (IS_ERR_OR_NULL(line))
> +               return -EBADMSG;
> +
>          r =3D kzalloc(sizeof(*r), GFP_KERNEL);
>          if (!r)
>                  return -ENOMEM;
>

Thanks.

Serge, it looks like this should resolve your concern?

--=20
paul-moore.com

