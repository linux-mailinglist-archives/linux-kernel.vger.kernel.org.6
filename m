Return-Path: <linux-kernel+bounces-408999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E59539C8633
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 10:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 743711F2267C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 09:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700AE1F583E;
	Thu, 14 Nov 2024 09:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="izBHJ0Eo"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C96E1DA0ED
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576767; cv=none; b=gZmUwsV9Mda0+ZB6dID6q5eBXvx2qMeSAmDbXI3ked9qgbud8Gxa56ZWmiIfp9cUw8Py2CX7mYoVkUfndkS5bORuBLCW/YEb87XGagz917w4h0CvCW28OnpxtcWcBQzqApoGjAKdOzeC8FwbYCO2+KcaeJDtJSZl31Qra9qbjMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576767; c=relaxed/simple;
	bh=Jh4aeGj1mdpsM+U51RQ804W2aDR09aeRFKAhDZHQocE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZC12nc5jD0LJUOS7r/X3V4mF9lk1yipvixF4mc5jrlT9leVsFP2nK/yC0QkMwYuIRX9nxt2saa7f+E6y6mGwDFKMPhRaTfMSJ3YBGxB5YlQKp8MObGlFQizPTDcXBk2tw9SvNukq9WR2OB2iHXXwDSrr4/shgQOHcWBJGaGFORI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=izBHJ0Eo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20ca4877690so92595ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 01:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731576766; x=1732181566; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Jh4aeGj1mdpsM+U51RQ804W2aDR09aeRFKAhDZHQocE=;
        b=izBHJ0Eo6lhoFRjg7N8KUA4JilhBChBuzTDIDumQg02le9uWRMP0e7eFIwz75+/3P7
         +QSwv1Za7szI0Sbmexlq8bdoWb23Nj0VR5CmFEeTI0SxH3DxyWhXlUUVEPFWjbUv+s06
         VcBIsbjhT2/wE8Ix5j29SsrxJlzGNH7C3wEszLIBy+c5POBs4ccraVBpe1Fwewbq0rmj
         2DLiUrHGq6qq1ctGHCiMCXuIF6jkhxroAXMdND/Pbz+A2YxI3i4GniGJjcfEg+24iX2g
         8TSBDxg2r/RrsC12iFR9EsQk+bgovYIRFtKHsiw/Ji3O5UHcUYX616dnZtU7SdboOrpW
         OdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731576766; x=1732181566;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jh4aeGj1mdpsM+U51RQ804W2aDR09aeRFKAhDZHQocE=;
        b=pR37Qo78LFLocUMWYld23ux3NtWPRsFzgbay4vlHxinvRMg4YqpUXjzPEtGlYUWt8C
         veDZNf61YPKJi0c5J4VEi43QpZDzLi4n6S7/ZmbEpo27XzGDAMwFZec5rnmPT+CAu7PW
         UR6j3RYfFMPqUNmW63tvQq3IP9wKYFrAVq7rvf+hvxhj7eVrDi+OWdq0V61FyJqLOvOS
         yVrY+2OgDzs4GA48xQg3DOozicM6zsSKZi88xfoWw9rYBcUsflVeKnzTLlIGxzcpc4dK
         ayYyTM0gKLbdVnPc9ABCVSkUlLVp2+24KtX42MbeE1Y3YA6EbF1iQdsMHqHd82xy2prw
         93cw==
X-Forwarded-Encrypted: i=1; AJvYcCWD4ANSbNokjutQuw3FHKYyCPFYxm2xoqtPu3Yb1nh2zegfQIA1cVjPWER2T7ghxYCgIv8/5swrNs/lw58=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq2WrIW45W7SpU2dwkfWZRKu6+nvDM2ZfYd//fs/Hz0ZvFlB34
	prr//Fc1OCR9855qYRfwUpIvxXvwU061BXOtrHZBrQTKRa1UYr96RZ8YoD/yedkuWw0xL/aluvA
	In5Nayh8bjKfadqtvRIWSnwkBFbI9tmb/mRE5s5Q6+Fg7ptMFz2oe3Xo=
X-Gm-Gg: ASbGncvf5YCrsjVg/Kj18+AKiCF3YcAfyci/xMJMaj50/tQmsMK8ThfT3clQqwaJCMo
	bRsBOn2wZZSD3lqpg6ngUh+Bk1q0Wcm3/hA00f+pH+lzrUxEFMxTAWyS5QoSsGw==
X-Google-Smtp-Source: AGHT+IEp0F0CxSb11Po8XxOkYL2eegQtvdopsCd3kf/YWhI3mqamWjuiSv81lZa5FW2Fv+yeTa0dHcqDt2riKuyuHYI=
X-Received: by 2002:a17:903:244a:b0:20c:eb70:6a5b with SMTP id
 d9443c01a7336-211c18c08f4mr2627305ad.14.1731576765472; Thu, 14 Nov 2024
 01:32:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <LV3PR12MB92658EA6CCF18F90DAAA168394532@LV3PR12MB9265.namprd12.prod.outlook.com>
 <f3ddabdc-39fa-45fa-97fd-d8508c2229c9@amazon.com> <CA+i-1C1zN_GcLagTRgfJqT6uFoZaMZj1NUfxkvP7eG=VGQ0GGQ@mail.gmail.com>
 <LV3PR12MB926503BA63C616562E508D8C945A2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <CA+i-1C2JXYUBnE7fn6df0=KR4KeD0VgwO5Cc2xRhO8rBqC_p+Q@mail.gmail.com>
 <LV3PR12MB92653337C2377D640BF81F84945A2@LV3PR12MB9265.namprd12.prod.outlook.com>
 <CA+i-1C2mJYwQYF9WrCjBTO0rfyNtDW=r8ZTpMwySrKSniVtXSg@mail.gmail.com>
In-Reply-To: <CA+i-1C2mJYwQYF9WrCjBTO0rfyNtDW=r8ZTpMwySrKSniVtXSg@mail.gmail.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Thu, 14 Nov 2024 10:32:34 +0100
Message-ID: <CA+i-1C3R=56CAMiDwuzrtxmQN+CN14hUeMfbv4k4WqyQfexZ1g@mail.gmail.com>
Subject: Re: [PATCH v2 19/35] Documentation/x86: Document the new attack
 vector controls
To: "Kaplan, David" <David.Kaplan@amd.com>
Cc: "Manwaring, Derek" <derekmn@amazon.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>, 
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"pawan.kumar.gupta@linux.intel.com" <pawan.kumar.gupta@linux.intel.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>, 
	"x86@kernel.org" <x86@kernel.org>, "mlipp@amazon.at" <mlipp@amazon.at>, 
	"canellac@amazon.at" <canellac@amazon.at>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 17:19, Brendan Jackman <jackmanb@google.com> wrote:
>
> On Wed, 13 Nov 2024 at 17:00, Kaplan, David <David.Kaplan@amd.com> wrote:
> > I wonder what would happen if there was a mitigation that was required when switching to another guest, but not to the broader host address space.
>
> This is already the case for the mitigations that "go the other way":
> IBPB protects the incoming domain from the outgoing one, but L1D flush
> protects the outgoing from the incoming. So when you exit to the
> unrestricted address space it never makes sense to flush L1D (everyone
> trusts the kernel) but e.g. guest->guest still needs one.

I'm straying quite far from the actual topic now but to avoid
confusion for anyone reading later:

A discussion off-list led me to realise that the specifics of this
comment are nonsensical, I had L1TF in mind but I don't think you can
exploit L1TF in a direct guest->guest attack (I'm probably still
missing some nuance there). We wouldn't need to flush L1D there unless
there's a new vuln.

I made a similar mistake in [1] where I had forgotten that you can't
really do direct user->user L1TF attacks either. I was thinking of
"Foreshadow-OS" [2] which is not really user->user.

[1] https://lore.kernel.org/linux-kernel/CA+i-1C38hxnCGC=Zr=hNFzJBceYoOHfixhpL3xiXEg3hcdgWUg@mail.gmail.com/

[2] https://foreshadowattack.eu/foreshadow-NG.pdf

Anyway, the underlying point I'm making is still valid I think. In
RFCv1 ASI has flushes on both transitions. In the RFCv2 as well as the
two transitions into & out of the restricted address space there are
transitions between different restricted address spaces and we can do
flushes there too.

