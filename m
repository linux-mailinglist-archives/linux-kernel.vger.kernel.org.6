Return-Path: <linux-kernel+bounces-173926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C81F8C079B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 01:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6A5EB2160A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 23:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3958B86AEE;
	Wed,  8 May 2024 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjvdHGCS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2E034CDD
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 23:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715210491; cv=none; b=AGUUYdnu5WrcOgsDhLyHG8WJ3BO3sknlySzGXC5l29mLp5rriZgZpqGAJUiwgZBr8lqPz1Y7CgIqzxpzYqaR0iEBMHkCjynesVATjyNbrFoJzkBj0unfe6B6qzIrBu6pm4ZnNPolWmHx7ZMrZVkljMJsJSTtdVoA0+YmgSeHEZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715210491; c=relaxed/simple;
	bh=dVOYypf5FR+YlfU5kE+ClnSd5b6FPh8VKEP2Mzk/9xs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HnxphPjmva8W6lQjH68+jwpeIYeCpeOsSioeBjfulcHgqznvS7PvNqITFPIrv2bq4d10UlkMeNxmuDYgl0dLnXEpOWbYUyr49kYSEORgs/lOcKPSNU02JiuJEsthAFs8xVmpldcjdvZVQGCkIVE3c9Jb8m2ZPvC+bpxr/fYuprw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjvdHGCS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715210488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVOYypf5FR+YlfU5kE+ClnSd5b6FPh8VKEP2Mzk/9xs=;
	b=IjvdHGCS2If60Lo8MjznBlgbF1iSrKWlFn2KEsgggasknHSvCKocaPo/QhoX8PU8AZ41Ns
	mmsEF0GOmbgSZ63ojL4Yj/Hml9huPL5XGsnmJ0MXe5yax+bxIEeXpCjZ51dQyn4+OV0hTQ
	OQ3BOZr9kvfEuRArHcnFUlxX45x01tc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-O-qq1CBAOsW2bUcEQhindw-1; Wed, 08 May 2024 19:21:27 -0400
X-MC-Unique: O-qq1CBAOsW2bUcEQhindw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6a097848a56so2752736d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 16:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715210487; x=1715815287;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dVOYypf5FR+YlfU5kE+ClnSd5b6FPh8VKEP2Mzk/9xs=;
        b=I/otB+7dfAj+snZkIcctlNjtakbaaT+BLHWkVxlRkLIE09k6Z/wzkRNlm9RFMrhAUZ
         Lx2qhH+Zy32C1ZjczqciMKnRZj6cj9Bwi+kR91pawszmCpbVi9zilRpIlxvBydFrr+Dz
         wpdz/VtAkdjodESFIwFxtBZi4IZYcw1KLhBgaoZJjYa8IleTKF+4w2z8HMZHxeJ4Ak1Z
         Q2Ih/SC6Qq7sQ5cR4+3CbXoeO+1MI5Jac+pvJPHe2cErhztiGmOINVfl4WMBzGvaPDq9
         NwkFy3CUCINVn4XZCvJOqSrSBXO6cr5FLJbnmQ6SAvrJjUnr27wkxJQRz18bTIHAC51f
         LnGA==
X-Forwarded-Encrypted: i=1; AJvYcCXxMSgM72gOSo3pDEdF64YzpxRHTw++KCRJVyPKL23lRP7i4VJ7BSeZTkP4mJneI8XzzcftnSkiTl8fCLLRt0fzDc3xGQqf00Jy4hGh
X-Gm-Message-State: AOJu0Yzkb3aN/TdUdBbh6b1SnRZSFoQ4Xd7WvaTzM/SmO6Kerr/Oms39
	lUU7r1s8OYp6kneSYgi4tnyIl32KYzk88V4wKvZQsXiPxXL3973VBUSRqN+kBrosmAqhh6ABLkD
	VztSNqt57VfXphOTe2JlxC+v0THRcDoGHge5rDfwNBfqLVe+JJ/PW2hyl/lEpyA==
X-Received: by 2002:ad4:5cce:0:b0:6a0:b4fd:d0a0 with SMTP id 6a1803df08f44-6a151433040mr47888066d6.6.1715210486712;
        Wed, 08 May 2024 16:21:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqGAoBt4qsg0Jz6aVRvN3hoL/hszZ/cIpBe42amCMPIhyFcmhD3C84W8ALulBzC9caIOAkdA==
X-Received: by 2002:ad4:5cce:0:b0:6a0:b4fd:d0a0 with SMTP id 6a1803df08f44-6a151433040mr47887936d6.6.1715210486386;
        Wed, 08 May 2024 16:21:26 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c6c:a300:ded4:e2aa:1dec:4d9? ([2600:4040:5c6c:a300:ded4:e2aa:1dec:4d9])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1d92c2sm801816d6.128.2024.05.08.16.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 16:21:25 -0700 (PDT)
Message-ID: <d2c6f335a6eb5892b0d894d5df4a6e713fa013b5.camel@redhat.com>
Subject: Re: Early boot regression from f0551af0213 ("x86/topology: Ignore
 non-present APIC IDs in a present package")
From: Lyude Paul <lyude@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>, "Linux regression tracking
 (Thorsten Leemhuis)" <regressions@leemhuis.info>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Mario Limonciello
	 <mario.limonciello@amd.com>, Borislav Petkov <bp@alien8.de>, Linux kernel
 regressions list <regressions@lists.linux.dev>
Date: Wed, 08 May 2024 19:21:06 -0400
In-Reply-To: <ea927dad269cc21de1d0baf3d6c9f66ee025b862.camel@redhat.com>
References: <3d77cb89857ee43a9c31249f4eab7196013bc4b4.camel@redhat.com>
	 <20240418082703.GCZiDZVyra7qOQbyqn@fat_crate.local>
	 <fd040809d95b3e12b2fdc78a2409e187716bc66f.camel@redhat.com>
	 <87plumxz4x.ffs@tglx>
	 <abbb7d7ca781f6c664e4c5b1dffc19394ac79691.camel@redhat.com>
	 <87le59vw1y.ffs@tglx>
	 <3a0afe545747e5314a9cb6bbaa9ce90b259ddfac.camel@redhat.com>
	 <87edautcmz.ffs@tglx>
	 <3b1d16e357c1f9badeef405366492f05af26c085.camel@redhat.com>
	 <878r11t8zu.ffs@tglx> <016902d9-3858-4c65-b3ec-f7a5103af63c@amd.com>
	 <51d0dff8-2888-463c-95ab-71b491f12a8f@leemhuis.info> <877cg4ppd5.ffs@tglx>
	 <ea927dad269cc21de1d0baf3d6c9f66ee025b862.camel@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Ok - so re the serial port comment (which I missed the first time I
read your message, oops!): I can totally get a serial console on this
machine, I happen to already have a serial port hooked up to the
motherboard. I'm not sure where my USB to RS232 adapter to connect to
it on my laptop is though, so I put in an order for a new one and it
should arrive tomorrow.

Regarding the test results - I tried possible_cpus all the way up to 17
and nothing got the machine to boot. However, possible_cpus=3D8
intremap=3Doff did get the machine to boot successfully

On Wed, 2024-05-08 at 17:02 -0400, Lyude Paul wrote:
> Yes sorry - I was out of work for a bit but I'm back now and can get
> you the info today - thanks for the patience =E2=99=A5
>=20
> On Wed, 2024-05-08 at 12:30 +0200, Thomas Gleixner wrote:
> > On Wed, May 08 2024 at 10:38, Linux regression tracking (Thorsten
> > Leemhuis) wrote:
> > > H! Lyude, Thomas, what's the status here? From here it looks like
> > > we
> > > were close to a fix, but then it turned out to be a bad fix --
> > > and
> > > afterwards nothing much seems to have happened. Did it fall
> > > through
> > > the
> > > cracks, or was this already fixed and I just missed that?
> >=20
> > I'm waiting for more data still.
> >=20
> > Thanks,
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tglx
> >=20
>=20

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat


