Return-Path: <linux-kernel+bounces-174342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588778C0D68
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 11:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA681C21211
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B307714A607;
	Thu,  9 May 2024 09:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UgczYuyB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CF114A4F0
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715246384; cv=none; b=SmaYcbVdl5vX7v2z6bCDz+q439YL4E7pWAz9vfSD0bvi5bG1q9CnC8L0ZEaMM4XXmSH314ZDosaaTYw6/15fyOk/iStoEpLfIW1AVToNY2ZYJCmqxumqYKCfak76Cv5qZzR3Km/K85+HtBSn/pPkjKZKLwEhxANJGoOiB26wiQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715246384; c=relaxed/simple;
	bh=jmevKMrzeJi5mvBgez98VR78gzPQTQVp4irn0sMKTDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RA+EZQoePoDioPI6T8wyFi/e19Qq7G53kaook2exRC3E2fG0n/+PFQxKtGSnme2JKrgv7EHYWIZMs/nQwl64LJdaBFfkKJI3zAlENBW9hYC6rpMZLpYJezYLLM+rYXIxaBiJGqLuH0s/8Q4h616qwqGlyiIgMxgR7cFXetO4HrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UgczYuyB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715246381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7vMs94siUkMQ0Z1b8w6GKdXPEsrvSAFnIe75Ff7i9K4=;
	b=UgczYuyBueQ8GahjpIsZ6loRjIDJDb3ozNvPHqel5T0ArG5ySTGLefRjVKptYDbFvbFgku
	mGCHwjWquCphlVWD/l/E953dAjGXmRMbX5QNLQ9+g/1Z/Jbis43HElEpNBT+5jywS0gh/6
	5ET/Yz3nroDh6Q7oVxYBjtx+gWMNLIg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-uWhQjAtuPnu-wSQl1RPEBw-1; Thu, 09 May 2024 05:19:40 -0400
X-MC-Unique: uWhQjAtuPnu-wSQl1RPEBw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41ec1528d83so4502225e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 02:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715246379; x=1715851179;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7vMs94siUkMQ0Z1b8w6GKdXPEsrvSAFnIe75Ff7i9K4=;
        b=CxB8fniM45n0xu/H4RYGBKTPaAleQQiNpNZGgWhSUZFL9h9rzEASVnMQH6kx9QpIvY
         M+emqSaz1FtTTc0cNwPdlkx/WqHOe0HCwDmlH3spq/Ne2JJWbeeq+ADepqAxf8R6lqUs
         Xex1eO7AGZKr1QvjWTXJQ2QAi6c6PNqV6TMXcqloZkotvzRsRmHigo8sLtxbfOFKalh6
         kYkmz2wrCuzB3Jdjduh6gzcUh89zkRJKoE4HGGDhT7DOHWaJkQWnFLwWM8LsdOHkEdzd
         WgUeNNrB9C4jWr5cNxwKlXOjCmUpGTbAuUcPFWQ3xK5Bl0mpBRP92DSEs4QI2YlyIqih
         jjVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbv4nO3Jsf66gc0wJQaPFxY+Mt/5NuDs0c2uT/eZJEAs+i08VptY3oToVJMUMwRgE1X8Kc9lZvZh+aK/9IAMDexq5195VZPif8INKa
X-Gm-Message-State: AOJu0YwhF5XO4jTNlnl+dGeTEt3PfVbKbnFLd938dpB4225ClC7BR4BB
	jWTyR8Lc4exAAeum7n+RvdlbuSyyX3bjFJZ07HfnjDa87D9ujFSpgUkYFW8Bk70MSrw9it7vNqH
	soyw53GVwO8jdgxEx8Nynk7yvGTrHvkCijzqtQtH2X9lbW0Br68iGUNdIkYuapYvKGkJzoR8PKZ
	7Z0JruFDOzQ/uAioiFHDPTSv0zTguiMH57/W6fgP0YNuzhsYLqqlw=
X-Received: by 2002:a5d:4533:0:b0:34c:72aa:6fe0 with SMTP id ffacd0b85a97d-34fca241368mr4389969f8f.18.1715246379069;
        Thu, 09 May 2024 02:19:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJh3SuqH3yNbzIZYnYk688DTBqYlucoBOzYmZ3Dv4FrnmITUrIQUfykuQrafBaMOakQpi/Zw==
X-Received: by 2002:a5d:4533:0:b0:34c:72aa:6fe0 with SMTP id ffacd0b85a97d-34fca241368mr4389931f8f.18.1715246378646;
        Thu, 09 May 2024 02:19:38 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b8a8454sm1172307f8f.56.2024.05.09.02.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 02:19:37 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Alexander Graf <graf@amazon.com>, Ashish Kalra <Ashish.Kalra@amd.com>,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org
Cc: rafael@kernel.org, peterz@infradead.org, adrian.hunter@intel.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, jun.nakajima@intel.com,
 rick.p.edgecombe@intel.com, thomas.lendacky@amd.com, michael.roth@amd.com,
 seanjc@google.com, kai.huang@intel.com, bhe@redhat.com,
 kirill.shutemov@linux.intel.com, bdas@redhat.com, dionnaglaze@google.com,
 anisinha@redhat.com, jroedel@suse.de, ardb@kernel.org,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] x86/snp: Add kexec support
In-Reply-To: <c2732461-e768-4356-82ce-a80c73997f02@amazon.com>
References: <20240409113010.465412-1-kirill.shutemov@linux.intel.com>
 <cover.1712694667.git.ashish.kalra@amd.com>
 <26b3b3b5-548d-4ebd-9d21-19580a41e799@amazon.com>
 <87msp8mmpq.fsf@redhat.com>
 <c2732461-e768-4356-82ce-a80c73997f02@amazon.com>
Date: Thu, 09 May 2024 11:19:36 +0200
Message-ID: <877cg3fil3.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Graf <graf@amazon.com> writes:

> Correct. With IMA, you even do exactly that: Enforce a signature check 
> of the next binary with kexec.
>
> The problem is that you typically want to update the system because 
> something is broken; most likely your original environment had a 
> security issue somewhere. From a pure SEV-SNP attestation point of view, 
> you can not distinguish between the patched and unpatched environment: 
> Both look the same.
>
> So while kexec isn't the problem, it's the fact that you can't tell 
> anyone that you're now running a fixed version of the code :).

..

>
> I'm happy for CoCo to stay smoke and mirrors :). 

"Only a Sith deals in absolutes" :-)

> But I believe that if 
> you want to genuinely draw a trust chain back to an AMD/Intel 
> certificate, we need to come up with a good way of making updates work 
> with a working trust chain so that whoever checks whether you're running 
> sanctioned code is able to validate the claim.

Launch measurements are what they are, they describe the state of your
guest before it started booting. There are multiple mechanisms in Linux
which change CPL0 code already: self-modifying code like static keys,
loadable modules, runtime patching, kexec,... In case some specific
deployment requires stronger guarantees we can probably introduce
something like 'full lockdown' mode (as a compile time option, I guess)
which would disable all of the aforementioned mechanisms. It will still
not be a hard proof that the running code matches launch measurements
(because vulnerabilities/bugs may still exist) I guess but could be an
improvement.

Basically, what I wanted to argue is that kexec does not need to be
treated 'specially' for CVMs if we keep all other ways to modify kernel
code. Making these methods 'attestable' is currently a challenge indeed.

-- 
Vitaly


