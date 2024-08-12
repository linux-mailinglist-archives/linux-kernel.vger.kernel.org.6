Return-Path: <linux-kernel+bounces-283455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CA794F529
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 18:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41575281B48
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81E7187346;
	Mon, 12 Aug 2024 16:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2juMjDy1"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9975A15C127
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481182; cv=none; b=Vcg/9tszO1fb1cVeeXumM0dQ56zitbCz4XQWFdKvB2BNblRkAWxeajkHkf7KnXWMKJ0nfF66OiEfVQXniw978/wp4xZiWub9p5uR7sXlrX28otkrdZA2S1M823CSr9DozHkj3vzMp9M9nQu3up7zojUGaYWqpAELYnV6gEGJhIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481182; c=relaxed/simple;
	bh=M3z6WNgR0vo7LI2PJMO34phIbD2sqqEUOgx8234LZjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZRimjfoECqCGq/ydreCjry8tqPsj8P5UmVGEU3QtWDIYiPKeHAmn7/Z5fevOrfz2HGfSimR4rzhzdIw1tpsUIjfuzChNbnWju2e/1mTnkffpPcIBKG5LdqzjBzf/L+06i/iKVGY4ULJili3aLzlbGDQc96zfgmLA+e2X/lv6kd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2juMjDy1; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a79df5af51so8246964a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 09:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723481179; x=1724085979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMl2h2APrDXrRsd54ATUVhJ1PFBmj4VZhJws35hfiaI=;
        b=2juMjDy1w4je+LWsDLroqI8mksgT/hJxAxhbCBZdF44F795kdQ6Gb1pGfZ2e5z8rnA
         vdyvkiiUYUP6vUVcG6ovXh2Pz43yALXYaKlucEGiwFSaw0rRhD6GXyYcu2FniCGg7WmP
         W9Sg6M6vr5riVCSC3WLCLfutJcXX7USEDPRZ4yh/hB2J75GW/jFymkvvIlS9ws0cKJ/3
         JCxInK0cvgM4PTXfaJLWm0aJerg+4L5Ey8CtAgiCIxO7X9PpazFbEJkcf9K8Xt8cXwBE
         6TQAjGd68eWh46K0ozbZqqDm54p85bZbGi/TL+GdhWlT/9OtxHVeB27kJiQN8GD7SNkw
         T7qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723481179; x=1724085979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMl2h2APrDXrRsd54ATUVhJ1PFBmj4VZhJws35hfiaI=;
        b=Dbnzx3c6hMkgdEj4+LS44qsRFd1pMIxt9FqwjfOYia5DRJ/aJuWWcfNmyTQxkvRQP8
         pohHlqnLirqDf1a6ilGq07l21mvTd+lY/DTkYR94sjDh7tUy9diWkuL7xvmM49kdLiZY
         49pGfbRrk9fSFte62JHys0BaPq/lRaIHGhaUCVSYkitD5GzFMyaW23Uz2ciYb8SefhF1
         gwDLfd6Su5AwFXPrwZVHOJhR/xUZ48s246Y/Lx46Sd0odno/qmtymBwRKoO7dpcXWve2
         0OQZo9QbAryugoh5u/1BzKNPFxdp4qucAT1frYYBUcZjwz/KpA2TGqlSFb6kmxfBlyks
         zdTg==
X-Forwarded-Encrypted: i=1; AJvYcCVnU21XkOccwKI5EHNyem6ruOtYkJ6wfL8iX5i2V2UH6xJxt3i2Ghel4Gw0fIENoe9s/QalxfCu9hVrkpSqMokeVB05fyc/QO+HeMYy
X-Gm-Message-State: AOJu0YzwGFhJSfAJD/JLqpKGHRwJPV8ggTpU2DT7pQkXMgNmMRne11WM
	gs1Ui7ug2ryBw/kbAdCD0nU8h+PIi3Wtvf6QpsMoalEgV0xTOsInAPOfS4i2hFKaRdvjV0SGMKl
	VVmtDE11OuNGuplat+jql5aHeeqVJnKB9g1J7oVjPSKs8HSkqLw==
X-Google-Smtp-Source: AGHT+IErXfwiaED0+uNIcxVdV3hRK93+KUYrGzUzTEqPiKHU188LSxGEfoMREZR7DooTohUCAwFxrLXqRq49aFc9eNM=
X-Received: by 2002:a17:907:c7d2:b0:a72:66d5:892c with SMTP id
 a640c23a62f3a-a80f0b2f797mr21895766b.18.1723481178181; Mon, 12 Aug 2024
 09:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240810005911.684644-1-yosryahmed@google.com> <20240812083218.GA3493@lst.de>
In-Reply-To: <20240812083218.GA3493@lst.de>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 12 Aug 2024 09:45:40 -0700
Message-ID: <CAJD7tkY-JNgGXMGEcQFCfzqSNcmCZj=yNV6O1GMnOQFR4KEx=w@mail.gmail.com>
Subject: Re: [PATCH] dma-mapping: use bit masking to check VM_DMA_COHERENT
To: Christoph Hellwig <hch@lst.de>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	iommu@lists.linux.dev, Reiji Watanabe <reijiw@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 12, 2024 at 1:32=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> Thanks Yosry, this looks good to me.  I don't see a real urgency here,
> so I plan to add it to the dma-mapping tree for 6.12.
>

Yeah no urgency here, thanks for the swift response, Cristoph!

