Return-Path: <linux-kernel+bounces-397294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0584A9BDA15
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 01:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E0BCB22589
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 00:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85AE7A47;
	Wed,  6 Nov 2024 00:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9QOrDPH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC671173
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730851803; cv=none; b=Z0WkJwbGB4ttb7RxMCfF3IKy9RnmOAIogQ5T6mNm2ZCKVA2ajbt7fDtd0Yna1R/vroj/SrKmIEQEHabTsG66TG1kAgQSUp0tBM8ypcBp51Encq5zA3eYqA1dRiUgLjPq3SjyZgmP6H66TycI5UcKF9RaOSALB+BzdRZ/RPlJ3TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730851803; c=relaxed/simple;
	bh=EhONxpoabnBdZIC+pPf3rO5NkMwnpcmCJFF6G7tieUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HStmxGxPpkrmRU8+nE38uaA22Zv+8mRnyK44/iJdILY1XHeyovEiJjj+m84VD5I9vnnWZJZLXlNwVNb69wwj4C+8IUFHyOZ91lT2gSdLygBEwz2niaYG2yy7Cusim07nAz2fRqdxZNz45dAw+TGFTBwHOLvQ2U7fbuKpoxxJzIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9QOrDPH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730851800;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xcvvbuQpV6OUCQzxbQQxlxp1LzAk7op1D4yotoJD2ro=;
	b=h9QOrDPHy8QtsHS+Yosau5YA1yiAXHSPSW2H0zxzeblXe0dHHTxUPDgj7D/6pROL8U+qiS
	2VN88/tBleqTUG8O7sFxUirvpBnEgtV8riggJpbdPlox9fC2K1hJJSn2C8TL/ePC3C3WdV
	/+lYrBeXY+Xi9+UNlQGXLItS6sdhQFw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-LAJ7BWzdOp6yZp4u3TCiZQ-1; Tue, 05 Nov 2024 19:09:59 -0500
X-MC-Unique: LAJ7BWzdOp6yZp4u3TCiZQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6d366904e8fso72249106d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 16:09:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730851799; x=1731456599;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xcvvbuQpV6OUCQzxbQQxlxp1LzAk7op1D4yotoJD2ro=;
        b=JhT9hH0mJy49gY2ZY1AMQW6xZCMKH7h5znRQVg/NpYc13AF6QCWRXzoEft3U0zqHm/
         fTSR8BLkSw2TNOm4kj/oJVujt2gDlMS9j1LYZVckWGEmkoqGPu6i+Dk6SD6y3AMMjVg5
         Mi0C8ZJjcR+a31FMv2k6udXhTYxNMVOOsQYoUzkeGK+2viICCh8QiKnU+s/HQxl1vlm/
         BqLCwROvSEqNKDXvD85i1MCVLlQ5jC+FTTPRXx99u75C+T2So9uhtxfsxLVkQs7h5fk+
         /T+UpFQZ1HbhT4y9h+1FiiCYfrImanjkCo8cDivMGFP0EDYrtMHgqp53KxrjPJ9ELn/z
         72qg==
X-Forwarded-Encrypted: i=1; AJvYcCU3v24kNt+jD0H1Uz3sC/KKs2DuU0E0SN2O8WWFdGBmGCUHLbtNs3Q/m55Gy6B/GAJRjdqd4BR35aHpqyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YznZLwbjBFUYTjzl6Mi/tci6SimWUzOH+6lZJ+VYVrpR/hMKCCu
	unhktuQqnFP3ICddBER5h6D7Qw3zpPxCgCnDLSULkqa8vgsG/Za/emDoBzfEslerIZM7rm/jxHY
	jKIRucFtMBjDdchBBE/g7MRmKR1HVNBeJJ1pYRtWm+pvaSu6grteMIA6vQO7ehw==
X-Received: by 2002:a05:6214:469a:b0:6d3:45ad:d850 with SMTP id 6a1803df08f44-6d345addb51mr376583796d6.26.1730851799158;
        Tue, 05 Nov 2024 16:09:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHXBHa2z2eWneZW6mLo2gXLkw1di+NHGIzzjCFZJq2VQ9t7gcqVWFnTuedpuwJcGgzGcdsJIw==
X-Received: by 2002:a05:6214:469a:b0:6d3:45ad:d850 with SMTP id 6a1803df08f44-6d345addb51mr376583676d6.26.1730851798860;
        Tue, 05 Nov 2024 16:09:58 -0800 (PST)
Received: from x1 (c-98-219-206-88.hsd1.pa.comcast.net. [98.219.206.88])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d35415b1edsm65837366d6.75.2024.11.05.16.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 16:09:57 -0800 (PST)
Date: Tue, 5 Nov 2024 19:09:56 -0500
From: Brian Masney <bmasney@redhat.com>
To: Saravana Kannan <saravanak@google.com>
Cc: "Bird, Tim" <Tim.Bird@sony.com>,
	"linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Boot-time initiative (SIG) thoughts and next steps
Message-ID: <Zyqz1LBDXZosrjle@x1>
References: <MW5PR13MB5632321E93B031C0E107DB38FD4F2@MW5PR13MB5632.namprd13.prod.outlook.com>
 <CAGETcx_c2nfFQ++-FcsdUdLUo3e-oe07MkLgbuyrnq2FPrcsXQ@mail.gmail.com>
 <MW5PR13MB5632E4EFFD802E0839027A51FD4A2@MW5PR13MB5632.namprd13.prod.outlook.com>
 <CAGETcx-Y6LHpZZUeexeuSF4RJ1E2MDtNtST=ytEUPAj7kKzwFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx-Y6LHpZZUeexeuSF4RJ1E2MDtNtST=ytEUPAj7kKzwFA@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Mon, Oct 28, 2024 at 03:33:29PM -0700, Saravana Kannan wrote:
> On Sun, Oct 27, 2024 at 6:30 PM Bird, Tim <Tim.Bird@sony.com> wrote:
> > > On Fri, Oct 25, 2024 at 11:18 AM Bird, Tim <Tim.Bird@sony.com> wrote:
> > > > = wiki account =
> > > > The wiki where we'll be maintaining information about
> > > > boot time, and about activities of the boot time SIG, is the elinux wiki.
> > > > The page we'll be focusing on is: https://elinux.org/Boot_Time.
> > > > If you are interested in helping update and maintain the information there
> > > > (which I hope almost everyone is), then please make sure you have a user
> > > > account on the wiki.
> > > > If you don't have one, please go here:
> > > > https://elinux.org/Special:RequestAccount
> > > > I have to manually approve accounts in order to fight spambots.  It might
> > > > take a few days for me to get to your request.  It's very helpful if you
> > > > put a comment in one of the request fields about this being related to
> > > > the boot-time initiative or SIG, so I can distinguish your request from
> > > > spam requests.
> > >
> > > Can we instead keep this all a part of the kernel docs instead of the
> > > wiki? Couple of reasons for that:
> >
> > Ideally, we would put some material in the wiki, and also
> > produce a document - some kind of "boot-time tuning guide" that can
> > live in the kernel tree.
> 
> This is the part I care most about being in the kernel docs. Eg: what
> configs to use. What commandline params to set. Dos and Don'ts for the
> drivers, etc. So, good to see that is an acceptable option.

I'm interested to help contribute to a boot speed document, and I
suspect some others at Red Hat are interested as well. Personally,
I would prefer to have a section in the kernel documentation over a
Wiki. Besides arch-specific recommendations, we can also contribute
some boot speed improvement techniques that we've done that are
specific to RT.

In addition to the recommended configs, I think it would also be
beneficial to list some upstream patches that improve boot speed along
with the kernel version it was introduced in.

Brian


