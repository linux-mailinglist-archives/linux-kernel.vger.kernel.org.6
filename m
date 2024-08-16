Return-Path: <linux-kernel+bounces-289916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C26954D4E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 17:04:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC36C1C213F5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 15:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631A01BD034;
	Fri, 16 Aug 2024 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="hWct/svc"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A3A5BAF0
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 15:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723820680; cv=none; b=qvYLrdIHVpPo0noFbWDsx55zwLJNfpmRLXPiMLXtRdM6sGBSDbHea3dCw7XFT5v8ElRB1Ke+vkKUgXJ49CqSQE+FlDzVbGgp5dtMyR1yIL9t4iPOnKl8LKYuTj0TdM31PHP4FpXQ+fH3xi0NIX2vnheJ7YoU6BWVBIy9FgpZ0lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723820680; c=relaxed/simple;
	bh=s3USxx1qgqL7lxLH1uWT0FkSk5kzDvMsaDTfgpb6fys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ul56L2vLP/uOUqlkKx4EqSA0Gkm3cAyaGMm+phTL7Jt985qf46zUGSfTcynE5KR3e8C40l35IdLexFuMneUGPnb9oshcQRZdLclLBpVCGGdJwHRNMokTsUo8GK9Pm8K3k9ZhVmQZF39izXkX7KlQ76vxMVbQpMhfAIINXbk/2zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=hWct/svc; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6b424e001e6so637647b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1723820678; x=1724425478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vHAIRH2kiCPOLhpwy1w91JMGd3u0z2V4nztIPw0osA=;
        b=hWct/svcTLmMOJxarnvFQJtxG0gIU82gSPYRmGhqKugbCGLotC17y06xETvqkE6rpu
         qDt2W0VWmvGQ26ZQGby4nSHEcB3+8rHEdIhD6teFtcnrO+OH7vzxjKMmVhsxx/n8FL2C
         xavNKQjd5iQupqecjDGR6GPMRcIrGpeOGjgSwWGsMbqDcIkhu/YMHzZgCrwmG+EM8zlV
         lDcpTMPomQxdu8eP73C8y30R9l9ohAqBNti3iNZD9fN/QflofjF6f4NOmdImuWBI8l+M
         iGoQyB+zM8c+EsSrgiqALFnN8Box4n2p2ZIcGTMjqu87ZtF/BVGeDu0LtCqJYzNNfw1i
         rzdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723820678; x=1724425478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vHAIRH2kiCPOLhpwy1w91JMGd3u0z2V4nztIPw0osA=;
        b=G4qcdvOPkkVE7/UNekv3mH7EWB1IVfWo099XaRF32QiJ9+L6/ZSXknxERF6yorOa+U
         Wj3kMIdP7NAxQw55B3FCz+A19Fb9i5TmdkD/MNGDdkqE5eiBNos2sH/Y7x2XP0aKY8vR
         3VuHin8n14lJ7++fHWuQlEROhe/VybZ0nS996TRrPCWJ5K6DtheeBq7zau+0PqEjPWli
         G/J9D+zA24WF52mrE/hhzK3a4Cqc/HlEnjX7dnBsZrqXGVZo8wcX9vpnLz5xLSE57bi9
         4qEn6apk+2FiB+5SssjTdUP5VWGcUVOXfRcWcAFUHhcCkgEwr1unAYgz7CdMgNySvh9H
         dTng==
X-Forwarded-Encrypted: i=1; AJvYcCVuINU0Eh+YBG/jHpKvRwmXAgDS/7aykESP7wIJjKLrYta8DJD/hVXhU52lvXjSW6AV1rOIn/7p0tuaHZeuPJjQrfN5AdVYKoyVxseD
X-Gm-Message-State: AOJu0Yy23c3LPpxBWZW8298y6ncQPDU1sqUXzw6NDpg5UcRFO24VnrZw
	PuzZ62oVAEjgNg0449aoQeU3YNHUoudXvaRKCkztihr6w6pZ7AOj1pI24XjEmzsV9JALAvGV7gb
	bJ7lLV6bxSzWyUnjD/sZdrMhOwm/QhK885afkkmnpajBJS271gA==
X-Google-Smtp-Source: AGHT+IGTnolWWBI+Wlg/qD251skyW7DUskZdIr4vvEEkBsEF8g5v2KaqEF5u01SGQNqsgyz1JsbmtuUoQGwxu//TTvY=
X-Received: by 2002:a05:690c:2f0b:b0:61b:3364:d193 with SMTP id
 00721157ae682-6b1bb570dd9mr29393947b3.40.1723820677610; Fri, 16 Aug 2024
 08:04:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816015355.688153-1-alex000young@gmail.com> <CAM0EoMmAcgbQWG7kQoe335079Y2UY_BmoYErL=44-itJ=p-B-Q@mail.gmail.com>
In-Reply-To: <CAM0EoMmAcgbQWG7kQoe335079Y2UY_BmoYErL=44-itJ=p-B-Q@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 16 Aug 2024 11:04:25 -0400
Message-ID: <CAM0EoM=qvBxXS_1eheyhCKbNMRbK_qTTFMa1fFBFQp_hRbzpQQ@mail.gmail.com>
Subject: Re: [PATCH] net: sched: use-after-free in tcf_action_destroy
To: yangzhuorao <alex000young@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	security@kernel.org, xkaneiki@gmail.com, hackerzheng666@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 12:06=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Thu, Aug 15, 2024 at 9:54=E2=80=AFPM yangzhuorao <alex000young@gmail.c=
om> wrote:
> >
> > There is a uaf bug in net/sched/act_api.c.
> > When Thread1 call [1] tcf_action_init_1 to alloc act which saves
> > in actions array. If allocation failed, it will go to err path.
> > Meanwhile thread2 call tcf_del_walker to delete action in idr.
> > So thread 1 in err path [3] tcf_action_destroy will cause
> > use-after-free read bug.
> >
> > Thread1                            Thread2
> >  tcf_action_init
> >   for(i;i<TCA_ACT_MAX_PRIO;i++)
> >    act=3Dtcf_action_init_1 //[1]
> >    if(IS_ERR(act))
> >     goto err
> >    actions[i] =3D act
> >                                    tcf_del_walker
> >                                     idr_for_each_entry_ul(idr,p,id)
> >                                      __tcf_idr_release(p,false,true)
> >                                       free_tcf(p) //[2]
> >   err:
> >    tcf_action_destroy
> >     a=3Dactions[i]
> >     ops =3D a->ops //[3]
> >
> > We add lock and unlock in tcf_action_init and tcf_del_walker function
> > to aviod race condition.
> >

Hi Alex,

Thanks for your valiant effort, unfortunately there's nothing to fix
here for the current kernels.
For your edification:

This may have been an issue on the 4.x kernels you ran but i dont see
a valid codepath that would create the kernel parallelism scenario you
mentioned above (currently or ever actually). Kernel entry is
syncronized from user space via the rtnetlink lock - meaning you cant
have two control plane threads (as you show in your nice diagram above
in your commit) entering from user space in parallel to trigger the
bug.

I believe the reason it happens in 4.x is there is likely a bug(hand
waving here) where within a short window upon a) creating a batch of
actions of the same kind b) followed by partial updates of said action
you then c) flush that action kind. Theory is the flush will trigger
the bug. IOW, it is not parallel but rather a single entry. I didnt
have time to look but whatever this bug is was most certainly fixed at
some point - perhaps nobody bothered to backport. If this fix is so
important to you please dig into newer kernels and backport.

There are other technical issues with your solution but I hope the above he=
lps.
The repro doesnt cause any issues in newer kernels - but please verify
for yourself as well.

So from me, I am afraid, this is a nack

cheers,
jamal

