Return-Path: <linux-kernel+bounces-242602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3159928A57
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 16:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 982631F21CBA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 14:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFBC116A36E;
	Fri,  5 Jul 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nacf79q4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF41914B07E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720188089; cv=none; b=Qhq3o4NhCaNU4qiNSRwiFOcaE4v5K12bHa1WbjRjS3yDvNvUsPZrKFTA4zIFbUiW4ez+W38ZMopCk8d/WrGcjf5LcEij+l/0j1bV25dSXePKBW5gzrkJvnDZYE6CUG9kRAYiEZ0R+kP5wx501gszx+OA8cgV23AJqIFMHbXPRKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720188089; c=relaxed/simple;
	bh=7tGSHKV8sdgdC7RNbGaWsfZ+SPiR4Zzlma2qqZNVdWA=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2ppgkpC3+nY8o+iNfAMHszkXiKDKaSI4j6ceAS2A6sE53gqfeFe5DryBtwMUXWVB6fFFyJioRhKLUzqVyfv8cwU+KMbckgcMkGUroO5Ltzr1Hs70+NlvZKvUulW6ePeJv27r8xIbzJGptFD6USjeDOII0gdeUGJFk8MVR5XCc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nacf79q4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720188086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q4BN2DKVnIi0/FYqV0P1Y2iVXb87vc8jKGdpfjXw8IM=;
	b=Nacf79q4AS7r0f8pE/EI03trZ7wUTGznNQusErAzfPxsa4bJN//1iM/FJuhH67LwJ4DRe4
	4g6LhaYplEbOfHOrkcx5w29/M/7BRUuu8iuCyGjyciL7TejOcZpTio9WHC1BD5qNKcCA1N
	AkXlMjaYIaZFSFW3USfimEZBBjrjyXM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-st-MZtknMgWGrGzX03FPQg-1; Fri, 05 Jul 2024 10:01:25 -0400
X-MC-Unique: st-MZtknMgWGrGzX03FPQg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-79efca8478bso26506985a.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jul 2024 07:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720188085; x=1720792885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q4BN2DKVnIi0/FYqV0P1Y2iVXb87vc8jKGdpfjXw8IM=;
        b=bkkcOQL3cFMwYDC/TF1b/hH/KFcp4hLxsz64hzvZN6ymKdntEYh4f+rRRp8Pad715P
         fxODGsFmWJGOLUDxAQ3arTcmJ1yfKa79IFOBueXnGtHh4dKxLmtXqFZE33XXRvMC6GPX
         vSYVE7blJZBiEBn0gi3zZWYBUubqIkW5TKqvejA6DhM+zbjYHiRGfWuE9VMp4gf5mJwp
         NMYwjpS2RxquV3+4y1faXUH05/7oPVt6C3v68cEIPdVsIDr+mDHFdP4tEPWXO37LYETw
         xCgSmA/Y1jZWM6S7i8Ty8dYrW5qvVIkf4sm3FHzwR7LFytjdk/G4sxEll4UUweWyyR6c
         59Yg==
X-Forwarded-Encrypted: i=1; AJvYcCW5nuu+j+MvqmJYDDC3WJvqiHv1fBC9TYksfNQU0c50oUZugSsdrZlC2twftoRIGYfaurEGNxEAaSi4F39CmpGwS47QJoqsVmFi7sGv
X-Gm-Message-State: AOJu0Yy63DYY7FftmRYUPkLLxcB37Bu6enAUqlb99UutLkpOlU0lgC2X
	1yHcq7Rm/7EAWpF6/7mzcwnMLLQ7FC9sLokrQx+aaNds0a1wsZHODTHO15zo0b8YAFqtRvTTo4p
	YQrRXfTdT0NIthkk/KSnca0U3ZPseeiGpTQBcqPiNOjdtMZO7etcb6QA/4srPA5bM4TOmPl3+yH
	qvUWtgoFRJ5os8lHS9JYv3JNtNTgtDSA3DvHEa
X-Received: by 2002:a05:6214:e8b:b0:6b5:e5f7:7ffa with SMTP id 6a1803df08f44-6b5ed093efamr57690876d6.63.1720188084935;
        Fri, 05 Jul 2024 07:01:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG41KdTtAEfnQLNxhWthl4at6lVGAdChdZNVWU5AfJWlf4kei01pwe3OHUEL6/Kntn5X3dSc4CPSTCUguMa1pc=
X-Received: by 2002:a05:6214:e8b:b0:6b5:e5f7:7ffa with SMTP id
 6a1803df08f44-6b5ed093efamr57690366d6.63.1720188084394; Fri, 05 Jul 2024
 07:01:24 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 5 Jul 2024 14:01:23 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240702132830.213384-1-aconole@redhat.com> <20240705062851.36694176@kernel.org>
 <f7th6d4ne3r.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f7th6d4ne3r.fsf@redhat.com>
Date: Fri, 5 Jul 2024 14:01:23 +0000
Message-ID: <CAG=2xmMDm-AuTZVAC3WwXsax1z_NSx9kYXG37q8EAnZMdk3BNA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] selftests: openvswitch: Address some flakes
 in the CI environment
To: Aaron Conole <aconole@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, dev@openvswitch.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pravin B Shelar <pshelar@ovn.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 05, 2024 at 09:49:12AM GMT, Aaron Conole wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
>
> > On Tue,  2 Jul 2024 09:28:27 -0400 Aaron Conole wrote:
> >> These patches aim to make using the openvswitch testsuite more reliabl=
e.
> >> These should address the major sources of flakiness in the openvswitch
> >> test suite allowing the CI infrastructure to exercise the openvswitch
> >> module for patch series.  There should be no change for users who simp=
ly
> >> run the tests (except that patch 3/3 does make some of the debugging a=
 bit
> >> easier by making some output more verbose).
> >
> > Hi Aaron!
> >
> > The results look solid on normal builds now, but with a debug kernel
> > the test is failing consistently:
> >
> > https://netdev.bots.linux.dev/contest.html?executor=3Dvmksft-net-dbg&te=
st=3Dopenvswitch-sh
>
> Yes - it shows a test case issue with the upcall and psample tests.
>
> Adrian and I discussed the correct approach would be using a wait_for
> instead of just sleeping, because it seems the dbg environment might be
> too racy.  I think he is working on a follow up to submit after the
> psample work gets merged - we were hoping not to hold that patch series
> up with more potential conflicts or merge issues if that's okay.
>

Yes. I am working on a patch to solve the failures in slow systems.

Thanks.
Adri=C3=A1n


