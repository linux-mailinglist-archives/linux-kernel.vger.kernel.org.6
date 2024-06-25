Return-Path: <linux-kernel+bounces-229251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 736FD916D58
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC99D28DE28
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D18716EC10;
	Tue, 25 Jun 2024 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+4WmIUk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25864171E5D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 15:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719330175; cv=none; b=UK+yTGVBlrjPl9im6xHohIsZsLocuVRQU4yYLo4199oRmED1FApLNxOaf1dzWQMKey0IyV9d+lZCqlKlh0LYK3PwZi4HiWMKk9BqdRvGVuiQVxNLeHV7ZaJgh646oNiB49shT+lRCw3PTTBUJvvEooUrdO680L1Yi/7ZKN8vxeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719330175; c=relaxed/simple;
	bh=txNOGyRY53dlUad69BGVxtVaxoLEp4azdwC4bHVsxy4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxs4itodfFuvano0o3n9qHsoVs5RlBA2qBMNToSuWODDVFRo5oVd9xK47axgPDL68yGyKdJs64sW8y9rdLFHiZq/E2Kab/F2q69RAtfCogoTvdJh3oKh26J4IkuFCvlpL3Pz4vvyeq+NRhBdPvTZZF11O7szpfziVmgA0yZPvU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+4WmIUk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719330173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qHjDjQkkVV5MnIFI/wThRjGzfK8qMKOd15SXf1Vtg8o=;
	b=O+4WmIUk56JC/YKnALEEClT+F+RcMjpQ7HmvFQS/T4HaGI8mBXJ4ynF67sejCYRwlO6drV
	0yrd6vbAqAJctgyvSqockBNTbFQVDE6WHrZ1NgHPlw21hL0oKKAnFpNSqJDt1ApQ5fEzoD
	Ku8EDDNPLW0BqerbeLutd1rzZBrBRng=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-KMcXZk2lOcipIKTYemIOlQ-1; Tue, 25 Jun 2024 11:42:51 -0400
X-MC-Unique: KMcXZk2lOcipIKTYemIOlQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-79557d418e0so1426380985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:42:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719330171; x=1719934971;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qHjDjQkkVV5MnIFI/wThRjGzfK8qMKOd15SXf1Vtg8o=;
        b=nJy7oRsbggoruI//k8y63TGCqzefPPCPFKGeEjHcMtSccnEbqmFJCKaMwWzeQnXNXh
         HzM7MPLCK9jHa+27wRof6O1y+HSSsCYVR5ZwtRzkcUsOFoEEWgRbtu/pVvapgHpVv+Rb
         RZB3k+4ninpT6B4REA2kfRU/J/sKfbF1TaozAH70L1FBGxUdP6R7JbwCShyg0evZGiht
         fNoHTI1DUCJoTali3dy4mIgVwC/lhUxZMPoRigcY1rbpvSC2adLCY2Ro7xO5Oye64tfd
         pnYHLzuTU/NbFp9dxaVl0jTbBzbS68uD0l6ZWVV3lfKt+PksLg7CLHM3swlU4GqV3Qxl
         +upg==
X-Forwarded-Encrypted: i=1; AJvYcCVsPuzkEoyxZUgno5O56vU4G9Pwv9dcFNk5j77sLHzNZy4pok/rU2GVEU/oM0Ab5peol5aponnRxx2CbK5AHVpncRsxWVRI57mFb5nI
X-Gm-Message-State: AOJu0YyfaIs9LxOjNGoQeslORGOrqsudPWnkI7vnaqE+yAkjg/+A/Nu2
	LQEIpnKB4jeOSaPBtOcTSZjJCF8yzjg5L+2Mv7jrm3CIQPz6eRpr5i12dbt2R6XUmdLr0GsnvqB
	6bixY83Yx+gCNFHErmPc3oFTznTh3j74Hwzwp9gw87dwsdKTw1Azaaudn3v8ZkA==
X-Received: by 2002:a05:620a:17a0:b0:795:7abd:12e2 with SMTP id af79cd13be357-79bfd66d20amr693260785a.17.1719330171153;
        Tue, 25 Jun 2024 08:42:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHva43U36s/7Ml2cOyugoxc0TbehJGQitemaODb2b3+TkL7l4BU91CFLUjdniODZSXocu0RnA==
X-Received: by 2002:a05:620a:17a0:b0:795:7abd:12e2 with SMTP id af79cd13be357-79bfd66d20amr693243585a.17.1719330168725;
        Tue, 25 Jun 2024 08:42:48 -0700 (PDT)
Received: from maya.cloud.tilaa.com (maya.cloud.tilaa.com. [164.138.29.33])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79bce91f16esm415648285a.77.2024.06.25.08.42.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2024 08:42:48 -0700 (PDT)
Date: Tue, 25 Jun 2024 17:41:49 +0200
From: Stefano Brivio <sbrivio@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Aaron Conole <aconole@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, Pravin B
 Shelar <pshelar@ovn.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Shuah Khan <shuah@kernel.org>,
 =?UTF-8?B?QWRyacOhbg==?= Moreno <amorenoz@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH v2 net-next 0/7] selftests: net: Switch pmtu.sh to use
 the internal ovs script.
Message-ID: <20240625174149.3d37ed88@elisabeth>
In-Reply-To: <20240625070654.6a00efef@kernel.org>
References: <20240620125601.15755-1-aconole@redhat.com>
	<20240621180126.3c40d245@kernel.org>
	<f7ttthjh33w.fsf@redhat.com>
	<f7tpls6gu3q.fsf@redhat.com>
	<e4f69335f90aae3f1daa47ba8f69b24ea15ed3b7.camel@redhat.com>
	<f7th6dhgnvm.fsf@redhat.com>
	<20240625070654.6a00efef@kernel.org>
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

On Tue, 25 Jun 2024 07:06:54 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 25 Jun 2024 09:20:29 -0400 Aaron Conole wrote:
> > > I'm still wondering if the issue is Kconfig-related (plus possibly bad
> > > interaction with vng). I don't see the OVS knob enabled in the self-
> > > tests config. If it's implied by some other knob, and ends-up being
> > > selected as a module, vng could stumble upon loading the module at
> > > runtime, especially on incremental build (at least I experience that
> > > problem locally). I'm not even sure if the KCI is building
> > > incrementally or not, so all the above could is quite a wild guess.
> > >
> > > In any case I think adding the explicit CONFIG_OPENVSWITCH=y the
> > > selftest config would make the scenario more well defined.    
> > 
> > That is in 7/7 - but there was a collision with a netfilter knob getting
> > turned on.  I can repost it as-is (just after rebasing) if you think
> > that is the only issue.  
> 
> Sorry for not checking it earlier, looks like the runner was missing
> pyroute:
> 
> # python3 ./tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> Need to install the python pyroute2 package >= 0.6.
> 
> I guess run_cmd counter-productively eats the stderr output ? :(

Yes, otherwise it's rather noisy, but you can run the thing with
VERBOSE=1, see also 56490b623aa0 ("selftests: Add debugging options to
pmtu.sh").

Before that change, we didn't eat standard error, but in the general
case I guess it's quite an improvement.

-- 
Stefano


