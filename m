Return-Path: <linux-kernel+bounces-228644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD4E916415
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 11:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399A71F212E6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 09:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3388E14A624;
	Tue, 25 Jun 2024 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUhW1xbt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028E5149C58
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 09:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719309208; cv=none; b=DvwgsW2c00BUe7oociHoxdrFMZaiZL5XnqB5k6VMiwpe7Rz/WiSx0W+iMl/4yinrFbYYoDV78D93joQS2YAcWfg9WmJr0xhCrzjPIDRPEXQ46rhF+eUVfC7vD2IO3OnoeHYMlvHM8YAw/RQbfQz6w15cgT3yTD2KP4DxpeuHl98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719309208; c=relaxed/simple;
	bh=R3FCxbaMJtybn040DrjxA8NUBVBQpqRvUPiknZOt1TI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OUuwDO3o7f8SHytTFTMMp12pEswUBMq1Nha5VmMx/gB9ngLGlG0OMoVcOTeIE1A4oX1c82lg+ZGnx4UVFAxyXND9p7Xe8VtSJ47qNR6Ol2/BS7ItEMPnwTm7fYUsepRjYcG23FimIW2Lasw4MIvEqbPoUl2eoIgYTCkMv5chumM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUhW1xbt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719309206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VCDVg82SvAc+NbfdoyAHMeVF+Y0QRccTMhp18TkLsuQ=;
	b=XUhW1xbtgt9Fg7v344OXvOxL+uw007NmulTq+BYFywBeh4N7IsbTPTeZckqg90n+qyGDLa
	A3q9mI9BcB6OwJvRwUw8NQSMsnSsh8jxrNtq9xyfJS46OgKe83xn1BJTsiiluzpUdUwAVx
	grXJtMF6DzIMX8rjOo1HBv/MhGHmnc8=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-xASy1Ii-NyCbWevIlkS8WQ-1; Tue, 25 Jun 2024 05:53:23 -0400
X-MC-Unique: xASy1Ii-NyCbWevIlkS8WQ-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-48f4687d15cso3473335137.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 02:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719309203; x=1719914003;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VCDVg82SvAc+NbfdoyAHMeVF+Y0QRccTMhp18TkLsuQ=;
        b=lVix7CK86KYGb6FfSd/e5EQIHgjMSRSGKUezZHwVShrLURA/05KRgXztEPtmG578g7
         qy1W3VRhQQaYP7hit7DIh/HBclJh5cx9KIMOp7j0KLqHFxBeD2nT5/+vAJ7XYwpJvFAU
         8o9RrfcsHDb6iSglfBLfqT3CtstNzzBlNpXYSstuL7IKce25G84zem1zzfbGMdeBcBwq
         JZlYOPAc7b45dNVnVeXSlk57t/BbGKcPQ1My7JNQQCE6hdmEZEtXA9MM0FY5/O6IlmwD
         r8LBeV9l3xBA3bC48iSx14S+hwzpExLl3U1APy6LnQdgbDTz0TvUsQ9Os6F7KcxXI/Uv
         ga4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnQjtO/ltA7Wssapy6CRDyuJ3bcv8Bear54TjyOtWFGC/fEx9BpEhh8xlWOSROO76oNhwjQDZJRkEyZ/sh9Amfh8JrQfj6hBt3PpsK
X-Gm-Message-State: AOJu0YwfjOk/R41emsl5aBzu09s3wNI7RqRBrNUPEDdt/oQhSa9hfvJD
	p04gGdJWOHg9XjTYQqSIbLQhWdHgPhK/Xw7SWeol9ucDmxj5+/3lrp10BBlWjlhnHXsAiGjr1Fw
	pBcSvnj4eFk8aJHH1a1fUq9kEzZtam5PnlEgd5Tro7CIvVS0hdCTwkI67OZOkSw==
X-Received: by 2002:a05:6102:34c2:b0:48f:2f28:833c with SMTP id ada2fe7eead31-48f529c9ab0mr6186846137.5.1719309203347;
        Tue, 25 Jun 2024 02:53:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7GVgIeXQfikh8im4fFadRGZfZMvzwXv5Lgjya/R6ZwlnSU1s7SQ/q+IhvLlQc4qI0cL2giQ==
X-Received: by 2002:a05:6102:34c2:b0:48f:2f28:833c with SMTP id ada2fe7eead31-48f529c9ab0mr6186831137.5.1719309202782;
        Tue, 25 Jun 2024 02:53:22 -0700 (PDT)
Received: from maya.cloud.tilaa.com (maya.cloud.tilaa.com. [164.138.29.33])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-444c96b06a2sm45955701cf.15.2024.06.25.02.53.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2024 02:53:22 -0700 (PDT)
Date: Tue, 25 Jun 2024 11:52:17 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org,
 dev@openvswitch.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pravin B Shelar <pshelar@ovn.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, =?UTF-8?B?QWRy?=
 =?UTF-8?B?acOhbg==?= Moreno <amorenoz@redhat.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH v2 net-next 0/7] selftests: net: Switch pmtu.sh to use
 the internal ovs script.
Message-ID: <20240625115217.07c820c9@elisabeth>
In-Reply-To: <20240624153023.6fabd9f1@kernel.org>
References: <20240620125601.15755-1-aconole@redhat.com>
	<20240621180126.3c40d245@kernel.org>
	<f7ttthjh33w.fsf@redhat.com>
	<f7tpls6gu3q.fsf@redhat.com>
	<20240624153023.6fabd9f1@kernel.org>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jun 2024 15:30:23 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Mon, 24 Jun 2024 12:53:45 -0400 Aaron Conole wrote:
> > Additionally, the "Cannot find device ..." text comes from an iproute2
> > utility output.  The only place we actually interact with that is via
> > the call at pmtu.sh:973:
> > 
> > 	run_cmd ip link set ovs_br0 up
> > 
> > Maybe it is possible that the link isn't up (could some port memory
> > allocation or message be delaying it?) yet in the virtual environment.  
> 
> Depends on how the creation is implemented, normally device creation
> over netlink is synchronous.

It also looks like pyroute2 would keep everything synchronous (unless
you call NetlinkSocket.bind(async_cache=True))... weird.

> Just to be sure have you tried to repro with vng:
> 
> https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style
> 
> ? It could be the base OS difference, too, but that's harder to confirm.
> 
> > To confirm, is it possible to run in the constrained environment, but
> > put a 5s sleep or something?  I will add the following either as a
> > separate patch (ie 7/8), or I can fold it into 6/7 (and drop Stefano's
> > ACK waiting for another review):
> > 
> > 
> > wait_for_if() {
> >    if ip link show "$2" >/dev/null 2>&1; then return 0; fi
> > 
> >    for d in `seq 1 30`; do
> >       sleep 1
> >       if ip link show "$2" >/dev/null 2>&1; then return 0; fi
> >    done
> >    return 1
> > }
> > 
> > ....
> >  	setup_ovs_br_internal || setup_ovs_br_vswitchd || return $ksft_skip
> > +	wait_for_if "ovs_br0"
> >  	run_cmd ip link set ovs_br0 up
> > ....
> > 
> > Does it make sense or does it seem like I am way off base?  
> 
> sleep 1 is a bit high (sleep does accept fractional numbers!)

This script was originally (and mostly is) all nice and POSIX (where
sleep doesn't take fractional numbers), so, if you don't mind, I'd
rather prefer "sleep 0.1 || sleep 1". :)

-- 
Stefano


