Return-Path: <linux-kernel+bounces-290712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A483C9557C0
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 14:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A7BB215BA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 12:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F0414D433;
	Sat, 17 Aug 2024 12:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="N7bs9hsR"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500F113A250
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723896726; cv=none; b=T0yhz9HTTutM7c+HkMM8rpc00rXFc0yqpmCnoTtIoIwheiJmoEKTup875PC4HmqKEfk57oimhc7QYH3EnRG8MqN/u0Bpf+2Dl5lfJWowfKQ6/grtV5ljE8P0QzRux2LkwCK9ikDQJ9ifPAb0slfGHFgO/BN1IMRG9nXiT0b4p4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723896726; c=relaxed/simple;
	bh=RpgsAJAKFLfvyQysO6pzJImVx4sx5Xm8ekUEp6z2kog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLSf4YR9blvzgC6w0MhxfxwBuyJzbz3dHE0mCEO5ZePCp/4gxBdR0EvEkY7v6TZHhMX2ICopLqFjn+BAjfqvl/aHG9xJ0RA9n2qs9HWVJbiRPPcb97tZU0C429DOunsPRhW3AFnuX474UrkWGdBPGJ3j+s+ndkyO4bfkdIoWioQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=N7bs9hsR; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6b0c5b1adfaso17356847b3.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 05:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1723896723; x=1724501523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wa15Z2LS6tAGOhDHWkITGTtarUTEFItcjftQAV0dfE=;
        b=N7bs9hsRvLs2Wl+lS0uswhhib6MvLOzAUlBl49oKN6BitB6po/BiFZe+STOj3/NnUe
         1qB0h6v67NCvfZ3qQ/6A8OhgsKvX47XhQPDKlhQ2arzVKeZ+ClWn3CmCozhpz4/Cvn1B
         3+9TUsM9BYIidsl0Wd78eUYX2/VeSbmbpptIjYH1r2ZJHMy/htgpg4rB8EsVaqL5MUc+
         OlA95x0nuGkCY1S7IGyokaMCS4uGhPwFo3aF9FqANR6vMpiH6fDkbbvAXCpqTCqzINCO
         9SOGHv8COu22NRi8+aVD62MI22wKoQjitXweUtVVejU8e93uibz57R6/vlc+H9ZCJbaB
         rEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723896723; x=1724501523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4wa15Z2LS6tAGOhDHWkITGTtarUTEFItcjftQAV0dfE=;
        b=R5yQb5tKlzVKmRa8JUAAa2ow6HIg6w5ZHR5s8sBsy+19udnpBriJl46cNIvkUkYTJM
         Kx65kRTNFuQuy7zbPHXZEoyLM0Fx2nCXm7zhEsu+buaGEcI5nythCmv1cHIMTTPaUggq
         /UCPAGqlOiB7iNz7CXy4JX8epiu8oTlPX1MaUdsFb5bwAwwqNvZMjZxwEkfCOt3i4yMk
         1XBVHcCrRdNSDsjeOLvbqa+NCVv7Tjc983tRsTKuXY4i1bH8shtOQUWqfagdU7fsV2QF
         7CnEHF9x2LKnq8EBexj99uvowAjgXGoi0njZYkZpuX3aaSPmae0kMOOTtMBxRBOGevXF
         7Y7w==
X-Forwarded-Encrypted: i=1; AJvYcCWBVAFJo2fg+BLKbqdEfR8GUna65iLJnOMk5EZ2GbatWAVPJ5qQ53XTXeg6XcyIe3Xcw3RXeRp6+QcBs+JZPUrt7o11TMppB7xjxKdl
X-Gm-Message-State: AOJu0YxgQBsrV54LTVMRjnN7BFOOPjnBu4CvNlsVctCyvDRtAakU1yIp
	04p/cdkskjtccrYQCXB5DQYxLqr7JuQgJxvE5EQuCZ44FR3k7FzmhsWum/9hH7KeMsfCZKoAPFY
	K3hy0gRlexAWRG0+JT1r0lWd9MNv+zYq/chWo
X-Google-Smtp-Source: AGHT+IG1tZW2T9lJLSEufhGDgCb6dKP1KdXiuyUdzky3pB3O1PYH5F8Ejzr1CdkPIHVV4tORBJ8IFxBNeSG+QW4IZFo=
X-Received: by 2002:a05:690c:688d:b0:6af:719e:cbb0 with SMTP id
 00721157ae682-6b1bdb215f2mr60967087b3.36.1723896723217; Sat, 17 Aug 2024
 05:12:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816015355.688153-1-alex000young@gmail.com>
 <CAM0EoMmAcgbQWG7kQoe335079Y2UY_BmoYErL=44-itJ=p-B-Q@mail.gmail.com>
 <CAM0EoM=qvBxXS_1eheyhCKbNMRbK_qTTFMa1fFBFQp_hRbzpQQ@mail.gmail.com>
 <CAFC++j15p9Ey3qc4ZsY4CXBsL3LHn7TsFTi6=N9=H+_Yx_k=+Q@mail.gmail.com> <2024081722-reflex-reverend-4916@gregkh>
In-Reply-To: <2024081722-reflex-reverend-4916@gregkh>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 17 Aug 2024 08:11:50 -0400
Message-ID: <CAM0EoMmUSGEY_wGHmZJkP5s=sr0zPJ2sOyTf3Uy6P3pN8XmvhA@mail.gmail.com>
Subject: Re: [PATCH] net: sched: use-after-free in tcf_action_destroy
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alex Young <alex000young@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, security@kernel.org, xkaneiki@gmail.com, 
	hackerzheng666@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 5:35=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sat, Aug 17, 2024 at 05:27:17PM +0800, Alex Young wrote:
> > Hi Jamal,
> >
> > Thanks your mention. I have reviewed the latest kernel code.
> > I understand why these two tc function threads can enter the kernel at =
the same
> > time. It's because the request_module[2] function in tcf_action_init_1.=
 When the
> > tc_action_init_1 function to add a new action, it will load the action
> > module. It will
> > call rtnl_unlock to let the Thread2 into the kernel space.
> >
> > Thread1                                                 Thread2
> > rtnetlink_rcv_msg                                   rtnetlink_rcv_msg
> >  rtnl_lock();
> >  tcf_action_init
> >   for(i;i<TCA_ACT_MAX_PRIO;i++)
> >    act=3Dtcf_action_init_1 //[1]
> >         if (rtnl_held)
> >            rtnl_unlock(); //[2]
> >         request_module("act_%s", act_name);
> >
> >                                                                 tcf_del=
_walker
> >
> > idr_for_each_entry_ul(idr,p,id)
> >
> > __tcf_idr_release(p,false,true)
> >
> >  free_tcf(p) //[3]
> > if (rtnl_held)
> > rtnl_lock();
> >
> >    if(IS_ERR(act))
> >     goto err
> >    actions[i] =3D act
> >
> >   err:
> >    tcf_action_destroy
> >     a=3Dactions[i]
> >     ops =3D a->ops //[4]
> > I know this time window is small, but it can indeed cause the bug. And
> > in the latest
> > kernel, it have fixed the bug. But version 4.19.x is still a
> > maintenance version.
>
> 4.19.y is only going to be alive for 4 more months, and anyone still
> using it now really should have their plans to move off of it finished
> already (or almost finished.)
>
> If this is a request_module issue, and you care about 4.19.y kernels,
> just add that module to the modprobe exclude list in userspace which
> will prevent it from being loaded automatically.  Or load it at boot
> time.
>
> And what specific commit resolved this issue in the older kernels?  Have
> you attempted to just backport that change to 4.19.y?
>

And if you or anyone cares, here it is:
d349f997686887906b1183b5be96933c5452362a

cheers,
jamal

