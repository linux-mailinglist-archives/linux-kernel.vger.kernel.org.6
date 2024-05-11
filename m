Return-Path: <linux-kernel+bounces-176374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B70138C2ED4
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 04:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40CA4B23079
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 02:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BC1171AD;
	Sat, 11 May 2024 02:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbIH83J7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDF412B8B
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 02:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715393337; cv=none; b=t8FvKp+Upwm016Hhh1hNrMhZo358p7KrR29WymYpm3uyfUB3KLL8cKHKJPabmUP6u+ngGzXjr5mLpeySLCd16GD6+q/E8vIUvq0UWNgHW04MP0HuQZmIBykEzS183GW/BC32SStbU5oo9s8oDtYfY9OV2W4tKH4rzxe+Num/wCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715393337; c=relaxed/simple;
	bh=np0Z1fuiBcflwNQFi+xKet4c5omvJy3ca0Kw0l8fvlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=HrKk99VELggjSjgVx+t8t9784/nHJ9gNdXZSFU0+jms32QJLFG/oALW5ujFHGnP7tT/0htV7ltl93BtblkwbcjEGHHmIhX407gKaMaLWSiP068vsgsr3wzxxlxbby/1rTTWwGWPrrenPlBazVmiQBEjyQTlHD3hTtwirKHi906A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UbIH83J7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715393335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ldWbGd4nBvOALfC8J/j4qgg0tc9VFEznhv729dVOtjs=;
	b=UbIH83J7o4QqmBTcmTOiwwIN4/yAClPcHwPOfPW0yIe49rtiZ8TfkAYYdkjU1TLvsG1T8e
	XocLsqumYvcvpastwIZVn8hBkQwvWsGO+3GxAgcOP9kHIrHFExxB9rUoRVPNPErAwNxGO0
	5XsrzjRYmnMagluWujSwRpA9gXZvNAY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-VmwRdkDnMIq-SFa8JsxtCA-1; Fri, 10 May 2024 22:08:48 -0400
X-MC-Unique: VmwRdkDnMIq-SFa8JsxtCA-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6a0e7d77b41so34431196d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 19:08:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715393328; x=1715998128;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ldWbGd4nBvOALfC8J/j4qgg0tc9VFEznhv729dVOtjs=;
        b=QgkjFd1U8zo3Aj2uY8b0ozi9gShRx9s2FmuclI8YjTqaORhVuFqJptbk3Tr0GWkim7
         vF7L4xtcfVA7VKb1ONSvhdD+D/TezZEtDh0ry7eLBIyZ8v3Ac3sV1Mzgvnc8Lv3iJXUr
         5pXYlS/pSJXdK7qe8zsxtBPITgQ0RlHTT7PZVQYpI+HbfigS7n/cv/8fZxefL03QvSp/
         6tWGCgH04bl/bbkGAnM0fT8WSTh9igdk/3DcuJX5w8zZ6EUMCzKHV/8H/OCCDX6YuPAq
         9pseUyZ/DnGclgVBGhW9PLAlar/01OaRXXVHysep0jtso9M5leiJZtipNtry2Wthi1v1
         Jxmg==
X-Forwarded-Encrypted: i=1; AJvYcCUMPpasxymfoxhgW6NP8Xi3anwDjYFZQZ96A4ydv8YhtT3DitL4ZIz2lpVL2cfoJ+QpT77S7IY9PtFdmnFDs4FXQYg31bu6VDqre69X
X-Gm-Message-State: AOJu0Yx14CQ+XBahdCdXH1HMbIVLYzNCFE0qNKfBy4DmLv8rdoKEgBtb
	BzivXjtFnQqNMN6B5l9uMwTqQ1+1iwznvpLUWwXuURqnCa0tq76Gksj6OfY+2xFey87NLHhGU1s
	NRBhOSMcjLjMpCudRmyNE6EKsaxKCQAP81HCahtvRby5UJAwlTgthO6krKYxf4A==
X-Received: by 2002:a05:6214:419b:b0:6a0:cc6b:1945 with SMTP id 6a1803df08f44-6a16817941dmr47893236d6.9.1715393328022;
        Fri, 10 May 2024 19:08:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjcdgcF/HEKP3kOg3iydqWDJeFoqiukAnH2Rm7lQcejSc9bFnEqxca28/Unv2eur6eVSuRzA==
X-Received: by 2002:a05:6214:419b:b0:6a0:cc6b:1945 with SMTP id 6a1803df08f44-6a16817941dmr47892996d6.9.1715393327577;
        Fri, 10 May 2024 19:08:47 -0700 (PDT)
Received: from LeoBras.redhat.com ([2804:1b3:a800:8d87:eac1:dae4:8dd4:fe50])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf27584asm236681785a.10.2024.05.10.19.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 19:08:46 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Avoid rcu_core() if CPU just left guest vcpu
Date: Fri, 10 May 2024 23:08:42 -0300
Message-ID: <Zj7TKg9tHTwgWOIQ@LeoBras>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <ZjuFuZHKUy7n6-sG@google.com>
References: <ZjprKm5jG3JYsgGB@google.com> <663a659d-3a6f-4bec-a84b-4dd5fd16c3c1@paulmck-laptop> <ZjqWXPFuoYWWcxP3@google.com> <0e239143-65ed-445a-9782-e905527ea572@paulmck-laptop> <Zjq9okodmvkywz82@google.com> <ZjrClk4Lqw_cLO5A@google.com> <Zjroo8OsYcVJLsYO@LeoBras> <b44962dd-7b8a-4201-90b7-4c39ba20e28d@paulmck-laptop> <ZjsZVUdmDXZOn10l@LeoBras> <ZjuFuZHKUy7n6-sG@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, May 08, 2024 at 07:01:29AM -0700, Sean Christopherson wrote:
> On Wed, May 08, 2024, Leonardo Bras wrote:
> > Something just hit me, and maybe I need to propose something more generic.
> 
> Yes.  This is what I was trying to get across with my complaints about keying off
> of the last VM-Exit time.  It's effectively a broad stroke "this task will likely
> be quiescent soon" and so the core concept/functionality belongs in common code,
> not KVM.
> 

Hello Sean,

Paul implemented the RCU patience cmdline option, that will help avoiding 
rcuc waking up if the grace period is younger than X miliseconds, which 
means the last quiescent state needs to be at least X miliseconds old.

With that I just have to add a quiescent state in guest_exit(), and we will 
be able to get the same effect of last_guest_exit patch. 

I sent this RFC patch doing that:
https://lore.kernel.org/all/20240511020557.1198200-1-leobras@redhat.com/

Please take a look.

Thanks!
Leo


