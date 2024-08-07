Return-Path: <linux-kernel+bounces-278002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A8594A93C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F043028201C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB08F201254;
	Wed,  7 Aug 2024 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ObuB9HND"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAD677F08
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039154; cv=none; b=qB10OXRde/vpjUbnPLOMSyGCtI6+9xGs6nfr3v/O+MtWZbEiyB5Pk8E0iILACOr1GCNYhtYrfXzKH84nkCtV2eOrLqrh2xlZSsf4UfnNICDu8+cD+UYLAwBL3WMbFRoBrTMlsBnlB7Kl7ZWcGyH+lm4j3c34PknYNx/otGKIx/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039154; c=relaxed/simple;
	bh=lct0/IrGdUeEYVTsKHLQO3M/5ke7ClgEwI5CCKE6YFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnl8+v+J7QLqHdHYAfKRYglodFubD2OiCDpAJbBV6wQAxP+azlZZcAxckOJca1mHMXyTeKrGY1YuL7Oi8e2aIEFgrUHi+KHTUVZSUPTeGCYa5wH2RGAjbzJMurTPoSd9pP7qGRHgTyo8hZoFjyIOyMZQ1jKbtkoGGRnvb254cVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ObuB9HND; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-81f94ce22f2so71511039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 06:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723039151; x=1723643951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1flWmxLbYXXUagOIem+EphM7m8Y4jtSRpnH9NCz+jY=;
        b=ObuB9HNDjZfG8vgNcpqYe/ZSihmx4vBgzOqU5gfJlnVJX1IuU8TcKi2LEYWrp3Idb7
         3jLE3NvbYPM6mUIzx0qVfM7grZoiOWs4QJpYatUw9Uyb/S1t3OFOCEimnuqbjwoHyo2i
         NaGhTg/FBmW3X0bc9DcsTzQqIN9i/Mhk73uLxPcAZlxo2v30oU6tupGfGB312l1qTcpl
         7t2sOWgMilLnctslZgc9qk/DRQtNG8Ey8sFBTJOEOKijiMPAJwnQKf+/HhhOf+Ljxovi
         gwX3Ex3dfF1AlqT2FQ/WveTbg/INrvqACv5Adnbj7S3Wx728k78f+mXSd9TC9KXRHeJ+
         BraA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723039151; x=1723643951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X1flWmxLbYXXUagOIem+EphM7m8Y4jtSRpnH9NCz+jY=;
        b=bt0POqesKBuAaoj16CStGRHLHiyXGTeTDoP49KgQceODOkcNGRLeoBGEB63pTb0ixZ
         r7UzZJ67z5XgmHmOrKq9jtSc9AfUasgBK6945UW0xcGpdsavX0NUn1xmcPpVS1bvtUHZ
         1HfP7IginoUYcIh3hrIf4rzYUVq666q3GiJQOFKeBU+izzheMztgJrqe2/bcSbdDbK1/
         QSIocHnfLn8dYUBZY3XemaY9Fgc2YIrhSp0PAs5HzM4g38PtieAJD5VKAl7Bmi2Ixpyq
         j5pbR52tzIGneV4lVmEaoAyH9WTmWl10WYBvF+uuzG/PZfnYpdFvF2rG1dfhHxTX+Wu0
         6tZA==
X-Forwarded-Encrypted: i=1; AJvYcCX/IAs27G78iEeJK3ZxibaZuIPayxxgP8PCtm4yUAV4AH2pQGwL57MM1CzC38/gxH172mFWiwG4dG3i7xw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5zK8SAqiMU4HxxxRA+imIsX+DqPTPMP36v1RQavu/4MD3L4M5
	dSkyd1KMlaUlX/JBKqS3nKzHgtozJ/wk2Ldl5lYHFC7DxVESSGXif5INMXuba2qhnkFa8u+Y/YW
	brp5yzzC/CR0asu2CafN4dqlkzQ9Ulfjy1hA6
X-Google-Smtp-Source: AGHT+IHXwhuBIWXAr9+rqAVj9ybqWN6IUBNOCPPWvXr/K0p1tiWm4jxxDzzxlTYTXdIzQQUo7ABUBNWy4cb5eb7S6WQ=
X-Received: by 2002:a92:6610:0:b0:399:2c60:9951 with SMTP id
 e9e14a558f8ab-39b1fbf5c86mr195350285ab.20.1723039151511; Wed, 07 Aug 2024
 06:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803182548.2932270-1-manojvishy@google.com>
 <20240805182159.3547482-1-manojvishy@google.com> <04affbd5-828a-4327-8b84-8767c1c139f1@intel.com>
In-Reply-To: <04affbd5-828a-4327-8b84-8767c1c139f1@intel.com>
From: Manoj Vishwanathan <manojvishy@google.com>
Date: Wed, 7 Aug 2024 06:58:59 -0700
Message-ID: <CA+M8utN7FbwMF5QN8O0a0Qnd3ykQwq7O4QkHMVEaBj2jE9BEYw@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH] [PATCH iwl-net] idpf: Acquire the lock
 before accessing the xn->salt
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: netdev@vger.kernel.org, David Decotigny <decot@google.com>, linux-kernel@vger.kernel.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	intel-wired-lan@lists.osuosl.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Przemek & Olek for your quick feedback and responses.
Hi Olek,
I can add more details about the issue we faced in the commit message.
The bug we had here was a virtchnl delay leading to the xn->salt
mismatch. This could be due to several factors including default CPU
bounded kworker workqueue for virtchnl message processing being
starved by aggressive userspace load causing the virtchnl to be
delayed. While debugging this issue, this locking order  appeared like
a potential issue, hence the change was made.
But, this change is more a clean up we felt based on concurrent access
to the virtchnl transaction struct and does not fix the issue. This is
more of the patch to do the right thing before we access the "xn".
I wanted to start with a first patch to the community for acceptance
followed by a series of other patches that are general clean up or
improvements to IDPF in general. Will follow with with [PATCH v3]

Thanks,
Manoj

On Wed, Aug 7, 2024 at 4:05=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Manoj Vishwanathan <manojvishy@google.com>
> Date: Mon,  5 Aug 2024 18:21:59 +0000
>
> > The transaction salt was being accessed before acquiring the
> > idpf_vc_xn_lock when idpf has to forward the virtchnl reply.
>
> You need to explain in details here what issue you have faced due to
> that, how to reproduce it and how this fix does help.
> Otherwise, it's impossible to suggest what is happening and how to test
> whether the fix is correct.
>
> >
> > Fixes: 34c21fa894a1a (=E2=80=9Cidpf: implement virtchnl transaction man=
ager=E2=80=9D)
> > Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
> > ---
> >  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/=
net/ethernet/intel/idpf/idpf_virtchnl.c
> > index 70986e12da28..30eec674d594 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> > @@ -612,14 +612,15 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *ada=
pter,
> >               return -EINVAL;
> >       }
> >       xn =3D &adapter->vcxn_mngr->ring[xn_idx];
> > +     idpf_vc_xn_lock(xn);
> >       salt =3D FIELD_GET(IDPF_VC_XN_SALT_M, msg_info);
>
> The lock can be taken here after the FIELD_GET(), not before, to reduce
> the critical/locked section execution time.
>
> >       if (xn->salt !=3D salt) {
> >               dev_err_ratelimited(&adapter->pdev->dev, "Transaction sal=
t does not match (%02x !=3D %02x)\n",
> >                                   xn->salt, salt);
> > +             idpf_vc_xn_unlock(xn);
> >               return -EINVAL;
> >       }
> >
> > -     idpf_vc_xn_lock(xn);
> >       switch (xn->state) {
> >       case IDPF_VC_XN_WAITING:
> >               /* success */
>
> Thanks,
> Olek

