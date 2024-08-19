Return-Path: <linux-kernel+bounces-292807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DAC9574A5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 21:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61DB8281E26
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 19:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746781DC496;
	Mon, 19 Aug 2024 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ml+q0awz"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7D71D54CD
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724096472; cv=none; b=c/Znlxn52R1KFPduHasU5LOo7cVjIrEhGsTCZSNuJd4Y0qKjTH1DeTnh6nwTfA/7YbXjlv8cB2kwE+AOvtyV23H/EU/qR38838J40ReziMlUFhu51TdqQMowi8cegWFBSisEHa+JsCQFoLt4wxt3dGBPkeaJE41exCj9ywyfk3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724096472; c=relaxed/simple;
	bh=hcSbya+lQiysjoDdhMa2fNXAwE9cTf3HMVXCOHk8tdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UzPuP3YqdScBbTbGitwafOg8k7VkLy4GldMxeeAII+deD5lNQ8Fb6t1vjUMVx/fkQjuQo7FmghFligdXybQRh++C/L4N7b2/EvAR3WyKZEVliYIA4tLXyQ7acpVKuqYY+J29l1DjL0AMwLZq9jtWy6zZsvJr02FEmtMgEDEx7wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ml+q0awz; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6bd3407a12aso6284807b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 12:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724096469; x=1724701269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkyhANmIfoPUx8Ztj0L2oahwdkEC/9ySCXObPcfO7yE=;
        b=Ml+q0awz6T48Y28kUNsbAqMvhhLu1OT+Fw0Q2W4JkWxl6hDRrIwmMXiTtCI3BM0wIB
         1BVfrpdC+pdrXFrjxZwmwJFVXe2FvKLOAkCUsevU5fsIR8YHyKsuzbmjkOEMS8MP4+Lk
         8T3xNnHOfBccmUSlGwU7APIbe5Et5SRGxoFtbt3NNXi+lr16eHzU7wz5ZUvkkjBrRb+F
         AhpD6as2bkTGucQwCHteWPpgiSO2gB1pUHhKdN9s8rVBS7IuVWySrYAIfT8IqRLWhjZI
         jcB/TLJSRxgOP1IrerDKgY/ZwjTf/tzaD3GmGNNqb1jVXyaZ0IVvTy/M1SIslKmTSQFg
         RqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724096469; x=1724701269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gkyhANmIfoPUx8Ztj0L2oahwdkEC/9ySCXObPcfO7yE=;
        b=BNDfpFeLCiQLWImAv249GcN9ZGYU5kPVE91ZVtyiUw/KC8qdHRT8adh624ZfQQKnxN
         5SVDIIKzRwwNA74/6g0fxg2G6viUvn4sZmVPkmaJkyTMqhUBA/MUZ4UVfqU2908OzaND
         3ZMTHZnQHVLyQkcIzOx2mHW9xfMMfEGoaAf0vM+DqXqJglVS0MVyrhs6eknmARKEZ3h5
         HzHJYgmT/ARjTR98tUe6GElWZXo/JsbhqPF59ynz99+CZ+1qdMl4M2b93AJ7n8cxCdT4
         HZ9B5k6mqJh4JRpylvmb/1NH6zAaIM4gaWC6B6bRWZ3pxztCuD5tyufOyhjpMtrnLqF/
         HVKA==
X-Forwarded-Encrypted: i=1; AJvYcCXF5n7hRP6wtE4LBT/6bkYl2Ay66nfNZUh0N3llRcUZXeAF1EH+FnYmFfwBnvcG3ilo6EBpoCYpGRr3+Us=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ2gU10hQtwYtaCJe0tv3zd6N7qq5j5+O39uFBChJsjDfqHEb1
	2KPuYDOzO9I+bgro2+VV/wcFjPUiKQtxW6lmbQkoYUBoR7hjHLGUfNJ6tS5Vh7VdpVIPAu86ghD
	0lWVbLMKCylWN0qy2XEjaiCWp6weWnfPRuzPX
X-Google-Smtp-Source: AGHT+IGNxAzznyZ+b7siXNq+DgYF6mU9BKHCBgzIgMxr5gD2jPGN9khm6ib1o830lq2PyGnu1xXnHmPm9H/tqvZOtYQ=
X-Received: by 2002:a05:690c:f8a:b0:64b:69f0:f8f2 with SMTP id
 00721157ae682-6b1b9b5ad78mr147420827b3.3.1724096469531; Mon, 19 Aug 2024
 12:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
 <1722665314-21156-13-git-send-email-wufan@linux.microsoft.com>
 <9dc30ca6-486c-4fa9-910d-ed1dc6da0e95@linux.microsoft.com>
 <CAHC9VhQrnu8Sj=XnDvg=wGTBxacvMSW6OJyG3-tpwrsbGat6vA@mail.gmail.com>
 <88695db-efc0-6cc6-13ee-fd7c2abe61c@redhat.com> <ac6e33b8-ec1f-494a-874f-9a16d3316fce@linux.microsoft.com>
 <CAHC9VhSe0HkzX0gy5Oo+549wG9xqfeHmsveJqdR_xRcYtim+sA@mail.gmail.com> <8421b247-41d2-4bf5-ba80-f356a2b696fd@linux.microsoft.com>
In-Reply-To: <8421b247-41d2-4bf5-ba80-f356a2b696fd@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 19 Aug 2024 15:40:58 -0400
Message-ID: <CAHC9VhR1gkiB=etUwgqnkZuBiSy1VD4ZgyUeTWvLQTowgQchFg@mail.gmail.com>
Subject: Re: [PATCH v20 12/20] dm verity: expose root hash digest and
 signature data to LSMs
To: Fan Wu <wufan@linux.microsoft.com>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Alasdair Kergon <agk@redhat.com>, linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, 
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 19, 2024 at 1:47=E2=80=AFPM Fan Wu <wufan@linux.microsoft.com> =
wrote:
> On 8/18/2024 10:22 AM, Paul Moore wrote:
> > On Fri, Aug 16, 2024 at 3:11=E2=80=AFPM Fan Wu <wufan@linux.microsoft.c=
om> wrote:
> >> On 8/16/2024 6:35 AM, Mikulas Patocka wrote:
> >
> > ...
> >
> >>>>>>
> >>>>>> +#ifdef CONFIG_SECURITY
> >>>>>> +     u8 *root_digest_sig;    /* signature of the root digest */
> >>>>>> +#endif /* CONFIG_SECURITY */
> >>>>>>         unsigned int salt_size;
> >>>>>>         sector_t data_start;    /* data offset in 512-byte sectors=
 */
> >>>>>>         sector_t hash_start;    /* hash start in blocks */
> >>>>>> @@ -58,6 +61,9 @@ struct dm_verity {
> >>>>>>         bool hash_failed:1;     /* set if hash of any block failed=
 */
> >>>>>>         bool use_bh_wq:1;       /* try to verify in BH wq before n=
ormal work-queue */
> >>>>>>         unsigned int digest_size;       /* digest size for the cur=
rent hash algorithm */
> >>>>>> +#ifdef CONFIG_SECURITY
> >>>>>> +     unsigned int sig_size;  /* root digest signature size */
> >>>>>> +#endif /* CONFIG_SECURITY */
> >>>>>>         unsigned int hash_reqsize; /* the size of temporary space =
for crypto */
> >>>>>>         enum verity_mode mode;  /* mode for handling verification =
errors */
> >>>>>>         unsigned int corrupted_errs;/* Number of errors for corrup=
ted blocks */
> >>>
> >>> Just nit-picking: I would move "unsigned int sig_size" up, after "u8
> >>> *root_digest_sig" entry.
> >>>
> >>> Mikulas
> >>
> >> Sure, I can make these two fields together.
> >
> > Fan, do you want me to move the @sig_size field when merging or are
> > you planning to submit another revision?  I'm happy to do it during
> > the merge, but I don't want to bother if you are going to post another
> > patchset.
>
> Thanks, Paul. It seems moving the field during the merge can expedite
> the process. Please go ahead with that. I appreciate your help with this!

No problem.  I'm going to merge these this afternoon, I'll send
another note when they are in the repo.

--=20
paul-moore.com

