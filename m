Return-Path: <linux-kernel+bounces-235831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFE391DA43
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2D1AB22713
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD0B85283;
	Mon,  1 Jul 2024 08:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rqwbi8Mp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCE6839F1
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823319; cv=none; b=rsdFORrym26kod9s+k3o/bPhIqpg9P+OoV/2Ir7jW+uKvCn0EqO12PY6nM2LVgsB1Y27QYLO7LYiOc7qt/UW7QLt9xrdg4nbOAOfxoeRD6g3ayvo7lAimW2wZiURJJVDXM4Nn3NQ564q3CMhC1+FR5JjbCiea67lIFpsTcy7ja0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823319; c=relaxed/simple;
	bh=98/yARMgR7LwngA3FFhVlRw2ly6+sDcbpTvJSV5r3Jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ino1bf4iE2Ne11xHoJ6KAvm7b/lXZPXptAWgVpKNBmSi1jcSn3JOw2W+Ij7t5Q3ZxbYSE0wJicWaB3rUHw/rKm09AJz+/FbhgXxSa5eLJHm9Ix3u0Z8ZMsce4u/SB45xvVNynPqRJVN9Wf9u/Aesvf0dyjj0LHY8bNNIhaYiI7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rqwbi8Mp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719823315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iFuYJuF23ilR26DvtLr3NKMhW/7ERM9own7UOA3paPg=;
	b=Rqwbi8MpyMYYHfzpW7Ha5HAhaNi/VbagfJe0qOWARHwhemj3FppG9EDSG+kHK2k0qlxMYu
	7gkd6hoCtU/STazSQfO/rEdBE1n6yIyhJIc74ZSZs3OGobUzOZ5IyTMlMoW5ovnRRg01CR
	IlOINPZ9+22HX3eThAPDc7qFq9lDUec=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-GfLUsmXKM0ScI3THQfOW1w-1; Mon, 01 Jul 2024 04:41:52 -0400
X-MC-Unique: GfLUsmXKM0ScI3THQfOW1w-1
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-37623e47362so31206305ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:41:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823312; x=1720428112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFuYJuF23ilR26DvtLr3NKMhW/7ERM9own7UOA3paPg=;
        b=WP5FMvQ84gqhdQAYxld4fo9/rnj3zq+vrGNOhdepJEXYjs/HwDeP247o7lbKNXQotv
         4hAPxOac3RvNE3JYacJVEz+957elG+Uz33n7bFeFYfrvyNBUAu27FwNTGneRaa4hnt9+
         M7aGaeUvBVx9C0Yr2yyH5HTviA/iymE3Au/S8YrTYfv8ruC7D2s52BTk53jPLb7kcrTT
         Bg7OR66Zj/8uiPwH/fiPsazvfxJAqpuDt69piWFK7HtKObaM2q0DmRn/F+cWNZ8X73Xz
         Mo/ASNHhVdYUAvUrP0Ykopgt4OE20q4gf1J2XFNBQlFzNkRRCWdFMiF0pA7Mp7ZNKEEU
         i36g==
X-Forwarded-Encrypted: i=1; AJvYcCU2IEuyaTx7/h2DSvDuRkm6yR7uFlmXXs44Q+QLyrnHGdbhFBmW7mUSPEns3h5zr+6jkW7yOtD8XGm1D7JCutwVqlvI9UXbbGAg73G2
X-Gm-Message-State: AOJu0YybKxY0HbPJUsIPfW/1FgD+NbedZWawyInK0ZuaHFQRn9AUE2aj
	vG5huCZjuEDKQowQ29udwfZ356PgDDwmfJoLyqv5i0ptQdY9HjvG9379xoxIvhYIBMAZKuUpdNW
	JTJ7uNrkuOnIjxkQGI29K4uQ9z0y/01R96bxiOxcaXJPyRYeOtDbHB67jN+YFlWvV2bZSeaI8AX
	f9+j5qSYicbYPwrMKzWDgqLaYnG2fgxgsm4KFF
X-Received: by 2002:a05:6e02:18c6:b0:376:3e9c:d9a8 with SMTP id e9e14a558f8ab-37cd169a012mr60188035ab.9.1719823311921;
        Mon, 01 Jul 2024 01:41:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZ3y4drjAYdSWs4QiL8X7hDAC6CgqCfAJPZG5DjOd5WCm0ZkwSvXgxmwb93eBH/DXOt6glH8WwXWNWRBJw1cw=
X-Received: by 2002:a05:6e02:18c6:b0:376:3e9c:d9a8 with SMTP id
 e9e14a558f8ab-37cd169a012mr60187965ab.9.1719823311695; Mon, 01 Jul 2024
 01:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626201129.272750-2-lkarpins@redhat.com> <20240626201129.272750-3-lkarpins@redhat.com>
 <Znx-WGU5Wx6RaJyD@casper.infradead.org> <50512ec3-da6d-4140-9659-58e0514a4970@redhat.com>
 <20240627115418.lcnpctgailhlaffc@quack3> <20240627-abkassieren-grinsen-6ce528fe5526@brauner>
 <d1b449cb-7ff8-4953-84b9-04dd56ddb187@redhat.com> <20240628-gelingen-erben-0f6e14049e68@brauner>
 <CAL7ro1HtzvcuQbRpdtYAG1eK+0tekKYaTh-L_8FqHv_JrSFcZg@mail.gmail.com>
 <97cf3ef4-d2b4-4cb0-9e72-82ca42361b13@redhat.com> <20240701-zauber-holst-1ad7cadb02f9@brauner>
In-Reply-To: <20240701-zauber-holst-1ad7cadb02f9@brauner>
From: Alexander Larsson <alexl@redhat.com>
Date: Mon, 1 Jul 2024 10:41:40 +0200
Message-ID: <CAL7ro1FOYPsN3Y18tgHwpg+VB=rU1XB8Xds9P89Mh4T9N98jyA@mail.gmail.com>
Subject: Re: [RFC v3 1/1] fs/namespace: remove RCU sync for MNT_DETACH umount
To: Christian Brauner <brauner@kernel.org>
Cc: Ian Kent <ikent@redhat.com>, Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Lucas Karpinski <lkarpins@redhat.com>, viro@zeniv.linux.org.uk, raven@themaw.net, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Eric Chanudet <echanude@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 7:50=E2=80=AFAM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> > I always thought the rcu delay was to ensure concurrent path walks "see=
" the
> >
> > umount not to ensure correct operation of the following mntput()(s).
> >
> >
> > Isn't the sequence of operations roughly, resolve path, lock, deatch,
> > release
> >
> > lock, rcu wait, mntput() subordinate mounts, put path.
>
> The crucial bit is really that synchronize_rcu_expedited() ensures that
> the final mntput() won't happen until path walk leaves RCU mode.
>
> This allows caller's like legitimize_mnt() which are called with only
> the RCU read-lock during lazy path walk to simple check for
> MNT_SYNC_UMOUNT and see that the mnt is about to be killed. If they see
> that this mount is MNT_SYNC_UMOUNT then they know that the mount won't
> be freed until an RCU grace period is up and so they know that they can
> simply put the reference count they took _without having to actually
> call mntput()_.
>
> Because if they did have to call mntput() they might end up shutting the
> filesystem down instead of umount() and that will cause said EBUSY
> errors I mentioned in my earlier mails.

But such behaviour could be kept even without an expedited RCU sync.
Such as in my alternative patch for this:
https://www.spinics.net/lists/linux-fsdevel/msg270117.html

I.e. we would still guarantee the final mput is called, but not block
the return of the unmount call.


--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com


