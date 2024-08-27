Return-Path: <linux-kernel+bounces-302454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3931395FED8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BFB0B21A11
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 02:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5544AC2FD;
	Tue, 27 Aug 2024 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TTvDjq0m"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137AC1854
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724724588; cv=none; b=VTznC0tkY9Si0dNjpJWjqIc8LqaoDcP9liJn8jMhZmqgZ9BMxB0sPmpOU/WUGWwnNzIZzKThNC1Wv7EDJTWFPUcgYNi1ssI9kMOBS/AKn4wT4x7to95WALUBq/tgUE1sl6hdq3OVinegzeBeOr/63z6L7NrVy5Qav7zE443E7qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724724588; c=relaxed/simple;
	bh=Ox9TBLnaP9aPqB08aXBL462yt/Vovhhe8i02LnN88aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sb/f7OWiQH9gQ+t858cwkjbFWZ2vFkAS/0xMiRKlBpTryXUAZRX5haI4t989fK6oJ1U0GeVBMlaqH2aWeHON762hyneWmDW50s/RL0cVkQMPQFjdJ6g+EKfJqPgunvi8F+EnpUqsJ8pLWk5WbYSKrZ7Fth+krYd3WmZkKkbEAjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TTvDjq0m; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724724585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ox9TBLnaP9aPqB08aXBL462yt/Vovhhe8i02LnN88aM=;
	b=TTvDjq0mtWV7szr8E7OrKGDqokBcVyK73FiZe9zzwRFJkRYU1Bpz84UPvintrYyO760BuB
	Jm62godsawtON608KC3VJPJ3o4LozBeKmTYz1YPH/wgYUk8Bv9us6Q7L+mZ3EX16s7AuUn
	ez1aBWb3oFtKAf5NkszjWHrpV0hi9b4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-O3HIzyPiM_Gam6g74rVRpA-1; Mon, 26 Aug 2024 22:09:44 -0400
X-MC-Unique: O3HIzyPiM_Gam6g74rVRpA-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2d432914cc7so4348810a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724724583; x=1725329383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ox9TBLnaP9aPqB08aXBL462yt/Vovhhe8i02LnN88aM=;
        b=JCDciLqHB8glVIrwPetcqhuzZ0vT0EhyGQkkD7MrNipLIMg3mLnPqqCSHepZEzQ7TH
         cZooXWqtAUx/p6X/iFv6dHWPpjYHQD9duqrknoHZJuugBajbPtCLmtxWi8PZ4jB7T0Zr
         0/fbNOG7nDhUhUyWE/L7Ly2D1U81byOoC4+x5lGmBf0eQ6DEm6u75gmhNOWX3/mQxCMy
         SymMAXE0pC8ccQdOmAX8AASD/XWqq1PcAw2nR88M+wj7tJAgYTYrKyCe1CN4WPIUX7tF
         M4oLGMvV7ZWLD9YVsJDzcsBPNJiwcZjWmvoPKPRrWkrzI8hMg1S1M27YdYlEHbiPqoB2
         4Qjw==
X-Forwarded-Encrypted: i=1; AJvYcCU1lFcnNXdRygvh/fiDrHW+sdck8ZkSWOOMwJSFQ8RLSBZtLyRlwtKGVG1XIY9PZ14tP/7paKlRxYWbPw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyieqT8RxIWhNuIDROceoMIUBywfJQtOpm7E1WIziDYP1/q6PE2
	2N+HygArXkeAKHB83eE00syMwct2oE5c4uRoEdeWQ9RGql0ayrwCfCq8tSGAvyXewekiIUyRps9
	io7xjHTMhAFRAzsLHohwC50StbkTlXpny3lxoUq+8EeleJ/B7C2raM1ot0DZmxdc5o+kganDntS
	9lSkH0ygkPpjnT0T99ems4QLGPzcNHjG3mNNvP
X-Received: by 2002:a17:90a:e604:b0:2d4:b8c:7b91 with SMTP id 98e67ed59e1d1-2d824b86862mr2306056a91.11.1724724583001;
        Mon, 26 Aug 2024 19:09:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRyIGDqgMb80Kz29snKJoL6F7ntR8ReI4Kah7pwXxuEBlrtNMgtfDwjDhYAnUEB6W2Fb5sLwP0TFw5Q1+kDjE=
X-Received: by 2002:a17:90a:e604:b0:2d4:b8c:7b91 with SMTP id
 98e67ed59e1d1-2d824b86862mr2306011a91.11.1724724582450; Mon, 26 Aug 2024
 19:09:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819092851.441670-1-lulu@redhat.com> <20240819092851.441670-8-lulu@redhat.com>
 <ZsV17ACIEelIQuKx@infradead.org> <CACGkMEv=cQqXeLdsM1ivOFvUcG+-eOOwHE_BVQmF_scbqYxUpg@mail.gmail.com>
 <ZswgHTRUR-wstAHf@infradead.org>
In-Reply-To: <ZswgHTRUR-wstAHf@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Aug 2024 10:09:26 +0800
Message-ID: <CACGkMEu882qAovckSf7ufak9+hfQ9jpLOmrm2TmCJTRGrm2D2A@mail.gmail.com>
Subject: Re: [RFC 7/7] vhost: Add new UAPI to support changing Kthread mode
To: Christoph Hellwig <hch@infradead.org>
Cc: Cindy Lu <lulu@redhat.com>, mst@redhat.com, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 2:31=E2=80=AFPM Christoph Hellwig <hch@infradead.or=
g> wrote:
>
> On Mon, Aug 26, 2024 at 02:21:52PM +0800, Jason Wang wrote:
> > > What is the application visible behavior that the API use is the prox=
y
> > > for?
> >
> > Vhost used to be created by kthreadd but some recent patches change it
> > to behave like being froked by the owner. So the various attributes
> > that interhit from the parent has been changed (scheduling and
> > namespace etc).
>
> Well, if that breaks userspace it needs to be changed to opt into the
> new behavior rather than requiring a flag to not break the existing
> applications.

Yes, if I was not wrong, this is something this series tries to reach.

No flag means old behaviour, new flag means new behaviour.

> Assuming the change is intentional to start with.
>
>

Thanks


