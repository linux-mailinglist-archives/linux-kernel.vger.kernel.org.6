Return-Path: <linux-kernel+bounces-192141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C9B8D1901
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D10D4B26975
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E289B16C444;
	Tue, 28 May 2024 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Euj9VM1h"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26A317E8F0
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893733; cv=none; b=uUuj1ejMsd3y5bo8qM1RfQzSoLPlTLgCu8Tkscfxmv+tmErEWhfpYiAzJ4gImKclAv7murPWtMwRSTak5ICRjlP5vUSKWS4sgdUmR+TrQAv7ue4TKFeGg1+y2/SNzdoc4uA6KYHuAets4IHt603/XtqoyfSkn9V+IHSj/sB5/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893733; c=relaxed/simple;
	bh=vHnCPeq7576aPfjGGsYU9wpALy1XPLbQ5pEiCJla2ec=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GR7axizLskWs9hfKClEMYIg609jNhmE7G/foO124c8ScT1ZLMgusNnOl6XKud0JCih6mLDj8dqeKmsHvlhr+QKbwZ9paD0rRhDoYOKAxhfBZ/Wb5WHFgAUprs8NddrSUAqJI9xJg5wL22OGKl2e+Ch48sUv+xbC4g0WWpmI64Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Euj9VM1h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716893730;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vHnCPeq7576aPfjGGsYU9wpALy1XPLbQ5pEiCJla2ec=;
	b=Euj9VM1hlEmr178jdCjFbPdxgDSUlLIVIihnDsgnIVPD2HalBifE7puN+4oQezL24znoPq
	cS/s+Gcf3Xy9QtqEQk7S8bRW7xYic4LsbtbUTKjz4PGIPt4BzMkWQbwQ/iyxorPNkDschI
	e5DL6SqMcA2xfQfSh+DTBEsRPLaN5WA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-ALYuuKNfNp6Nnhw-gfDr4Q-1; Tue, 28 May 2024 06:55:29 -0400
X-MC-Unique: ALYuuKNfNp6Nnhw-gfDr4Q-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2bddcf62cd3so633570a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 03:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716893728; x=1717498528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vHnCPeq7576aPfjGGsYU9wpALy1XPLbQ5pEiCJla2ec=;
        b=YJiCoE9dsi4BeCn9ZVB+13P44DrDEC5PqwUeEt2gFeFtqjfruveYwhzbCmHvMXFiDX
         0sK5srDYkBOfTRLCFmOayl+EcsTuNFv/hvLExjCfv21I9lgqAi1XLJKPeXgBXholdjsA
         joNdXGRFge7bEPyGrfLRyi8qeXAM18UzlMEDLfczS+3hhervMAvn1mDQg126kGXIcT4h
         jHCwMTgs5NM1twMp3m+m3qqiGR9DFYmQK1qxGmU4ig7lvDIe3c+lYrihqU/JhCGP1M9r
         Fwr7ftUoN9Gu2Ycyr9udQiYvcxUby+OZB7bUHtC131EaTxAruGurCs4TTVmqxSnn0qM9
         98uA==
X-Forwarded-Encrypted: i=1; AJvYcCUPHgvJ9u/fCFxO6fawk4hdQsfLNkU2AzqgubgHOeBC/daEIEwQg8muRGgZlzw9zMu//SbltuiKmH/+ZHbvRMTBT5UDLQBdgYPafnJj
X-Gm-Message-State: AOJu0YxobkUZMgTXX7N+VQGNvZMIY6gVO7KVXW7IvWcS/tBxE88tqamB
	RcQVVcr4mlsQFNjxacIttF3NiksyZoFKEbsCPSr+cToj4BDtDI22y++EG/rTD/yclfCjtCQxZyn
	sSmJmEmbvV2Af+FqcyiobCQBwRV6vObp8E2vmjoW9Kx5Fe1Oe9ju5XldGUULN7FCaLze4y/IZFB
	r4H3B12PYQuQ850EhKhaPVWR00YHDcW3+JH437
X-Received: by 2002:a17:90a:bd8f:b0:2bd:db8b:ca73 with SMTP id 98e67ed59e1d1-2bf5ee1ed8dmr11699721a91.26.1716893728210;
        Tue, 28 May 2024 03:55:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYl8Xlq5ut6UpRKjwx+ETwNHlwdmlFWwQr/zO9UXczA7Tbz2gkDKeAu1VWJDBrMtGJis8MV2mdm7z+Ltni4jI=
X-Received: by 2002:a17:90a:bd8f:b0:2bd:db8b:ca73 with SMTP id
 98e67ed59e1d1-2bf5ee1ed8dmr11699703a91.26.1716893727803; Tue, 28 May 2024
 03:55:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240528090244.6746-1-ecurtin@redhat.com> <CAJfpegvoao1jd7HhoPEeWCdS8jWEXhKTENbwvLdo=aMiNaLKQQ@mail.gmail.com>
In-Reply-To: <CAJfpegvoao1jd7HhoPEeWCdS8jWEXhKTENbwvLdo=aMiNaLKQQ@mail.gmail.com>
From: Eric Curtin <ecurtin@redhat.com>
Date: Tue, 28 May 2024 11:54:51 +0100
Message-ID: <CAOgh=FyHFE7qjfYq4BqGc20SYJ5FebhN2iYpJSsYYatO1TkqBw@mail.gmail.com>
Subject: Re: [PATCH] ovl: change error message to info for empty lowerdir
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: "open list:OVERLAY FILESYSTEM" <linux-unionfs@vger.kernel.org>, Alexander Larsson <alexl@redhat.com>, 
	Wei Wang <weiwang@redhat.com>, Amir Goldstein <amir73il@gmail.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 May 2024 at 11:34, Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Tue, 28 May 2024 at 11:03, Eric Curtin <ecurtin@redhat.com> wrote:
> >
> > In some deployments, an empty lowerdir is not considered an error.
>
> I don't think this can be triggered in upstream kernel and can be
> removed completely.

True... Just switched to Fedora Rawhide and instead we just see this one:

pr_err("cannot append lower layer");

>
> Or do you have a reproducer?

Run one of these vms:

https://github.com/osbuild/bootc-image-builder

And on boot:

sudo bootc switch quay.io/fedora/fedora-bootc:rawhide && sudo reboot

is the reproducer that is closest to upstream

Is mise le meas/Regards,

Eric Curtin

>
> Thanks,
> Miklos
>


