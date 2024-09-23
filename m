Return-Path: <linux-kernel+bounces-336176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6B897F022
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6B51C21778
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7501219F129;
	Mon, 23 Sep 2024 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dm697ERg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1FD3E499
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727115027; cv=none; b=CpcFVm/hXQPlPB+jexdUiSWR84FB2IKK5dE8P3MEYq2seM0M2HDC0QhVB7tSv4H28zW6qR8Mp1Y7lc6HBbUti9PbuqD0PTdPr0SdvgHdh6VpGJfclMyL8KqhZQwF8G0S80VR1ItNcARmoR1HcOXawdjb8sMGskANlr5IxBnP1Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727115027; c=relaxed/simple;
	bh=pFx/BkxxmpbNt4KUQFbJiUIIkQmD3B08PsWJADsUSnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j4r2Tv/VW2Nk3opi94nXGJ0fd4upSDNG/xmINRmxN47grXjU9pv92XOnu1vNo/hCc5sYjohsdH7VP7mVbBkMvLx30vsKcz3zyDletsd8ucQHy7TkvYS6ytI1jMNium6j2IxcbAr+OlKsRdzFSsXIfx654+Ye/ZB+MS1WI0HSu5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dm697ERg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727115024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GoE+RFdwcbThteJHz1bouTpc6RqvgbuGTqx/2Pf6Jz4=;
	b=Dm697ERgHsUwwvjws2krI/kF7WUUEXd+bXpO/0v0Ql5J5JdZa2rkFq+SzvceQCPRDVVCgI
	uPCBw0v3SWIaXsEyjBh9he6LaFCfKXRNUO/7hER/5aUrxEVIwrqYUjuBj2hAv5uSFMqsRx
	H0/uTKTNzEWzgA8BKiLZ0jDZrIqT3JE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-IK3jACEGPNa7AYYrgFm3Bw-1; Mon, 23 Sep 2024 14:10:23 -0400
X-MC-Unique: IK3jACEGPNa7AYYrgFm3Bw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-207510f3242so57427305ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:10:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727115021; x=1727719821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoE+RFdwcbThteJHz1bouTpc6RqvgbuGTqx/2Pf6Jz4=;
        b=jPKMNS1ErZe4Vrw7mrB/W/GfEN1YhryHUhsH+XHUvCNeHdLqXzWPMaaVM9tYATtBGr
         0k0KC3uGoywN0hWYhDCIMVlTtjT12dS4TVtknpQ223hSbs1LPC4LZkYPlCKUi4HPmawQ
         UJS11bxOdAfsR0qik493DjETiaq4DjiJxp4sDQDgfBEUixi0SXK/3AYl+IWBDSuM/5/a
         Zo5Dt+NRlPuV29nfDk93ZnznRhgsFJrjgQyHHKuT1/TaIWB1Jv4++vr234db5voAxQ98
         QnjWAYBYQl17Z+sNu6R1mGYEy1npjgmxoOFymGJqqI6Fu36fy8eGKuRp9AUSF40to12b
         C6Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWgxO1+NjW1VpctkjzTeliTydOdMv2S5HMIfCFks+oV6LMvIPA06K1KBbJ9q6Vg2zOIp6hJ8QmUjuwlLX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxltvq3UwN4nLKGBdjwuyGhhcGBwqkWzfmBcqcPQSda/7fAluQ4
	D01ZNlxDubiaOMq+Tn4N05i49HPDYkH736KILvcsxI85lEvMLXiI7o5C98MLcni33GK/zJBbOc/
	5K5WeYE7/Yg0oPMdQwVFgD2HRhY7xKDho+y+BiPCa03tj1gYFuoJIP5LXBy4lm2MPRecBS18m6X
	Eqb0gr1Zuir8O+YZX4EhUawBPNJrcAF3dPXDdVFNj5njfYQnk=
X-Received: by 2002:a17:902:ce01:b0:207:6fd:57d5 with SMTP id d9443c01a7336-208d83cacacmr178819285ad.36.1727115020680;
        Mon, 23 Sep 2024 11:10:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOQdZIXq+wJ+Ii92m4IubK2BktRZXpOo4uRTIyG1lN+bua9WP9WBRnQ0j3KMKXjLeJb+dP39bnWsOTaUiXDtk=
X-Received: by 2002:a17:902:ce01:b0:207:6fd:57d5 with SMTP id
 d9443c01a7336-208d83cacacmr178819015ad.36.1727115020364; Mon, 23 Sep 2024
 11:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922140047.261100-1-agruenba@redhat.com> <CAHk-=wittQGvXXMB5vk5GYyBWSbNmEtuY_i0O1WcR2SZed2dVQ@mail.gmail.com>
In-Reply-To: <CAHk-=wittQGvXXMB5vk5GYyBWSbNmEtuY_i0O1WcR2SZed2dVQ@mail.gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 23 Sep 2024 20:10:07 +0200
Message-ID: <CAHc6FU7hZkHy5uTJ867zYJ1_Lp+ozP5tvBtW5_dDH1n6OruhTQ@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 changes
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 7:49=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sun, 22 Sept 2024 at 07:00, Andreas Gruenbacher <agruenba@redhat.com> =
wrote:
> >
> > The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacf=
abd0:
> >
> >   Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git tag=
s/gfs2-v6.10-rc1-fixes
>
> This is just a repeat of the pull request you did (and I merged) back in =
July.

Hmm, indeed. I've just sent the right pull request; sorry for the confusion=
.

> I'm assuming you meant for me to pull something more recent, but I
> don't see any newer tag names either.
>
> Hmm?

It's tag gfs2-v6.10-fixes from yesterday; you should see that.

Thanks,
Andreas


