Return-Path: <linux-kernel+bounces-367682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8392D9A0555
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 11:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4424A286683
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F359191F83;
	Wed, 16 Oct 2024 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZ4+M72o"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7581F76D2
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 09:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070575; cv=none; b=JDsc0Dwz4WCZKJmICdYMZbX7ZlMLWL+bzwG078VTCfErnbYTJOhwLbPYQezgCBbD7QBUfitCuPc6jRhoXZ2EUSZXYe9dkpZIPNAwxN2mgBchyqQdne8C3bQF/WgTmXw4THpXIzDdIAxzidmZkOgh1c8TCcFH4Ah3T2QmIBbbLmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070575; c=relaxed/simple;
	bh=7NHqxy8z9St5srRirP40JQGjKhgMJDkdXyhJQwFf7RY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eIF7MsSUlshgfgdhYUpdd3jQ3jJQrneC7JbHqxIKo5NT2HYoIJLJM5/BLIFOCAesOiVNkSOgizXInuHymMnyAz7e2pzXrWpwN4L0b0DTObchY6815xOQJI6dBuWUblKDgnvAQchSESj/6UGCFXkU5j6BBR275tlQ83ORNbJmu/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EZ4+M72o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729070572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7NHqxy8z9St5srRirP40JQGjKhgMJDkdXyhJQwFf7RY=;
	b=EZ4+M72oXR141XvVyE07bAcxijmOdmprknlNSRKYrSqWyDsGdDYjFgymhSHr3voFvXo2YF
	ZIOxvJ8Ert8hYgeuqjvYh42q2+539IHjmwo+JyNEN5H8qzmQE7v4g/IkmBEIlq0M5OlE5K
	iBM2Cmy8QuBknD7yIbRL3uOr0exBVpg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-rJF_YNpwNiS_JLrrpqxpXQ-1; Wed, 16 Oct 2024 05:22:51 -0400
X-MC-Unique: rJF_YNpwNiS_JLrrpqxpXQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-431518ae047so2054275e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 02:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729070570; x=1729675370;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7NHqxy8z9St5srRirP40JQGjKhgMJDkdXyhJQwFf7RY=;
        b=aXj8P7TMAOOWAaSUvQQLfl1nmrt9ktMYJfdrUrhhnFaiMJC+auWqEYMVXfbfHc4LRB
         ZBsp1EdiHfg74r4cM6aM+damc5mvoQfQFlnXpIt0luXJQ55JdchJ9/ZX/elF59fAd6xT
         ftLgmXZxQAdB8RpRbl+KdXtEtDK0sUkilPaWzwAUibZuS5yMhwu5PMAx8IXLR9Ox7tBN
         OPxDtJf7H1+ot2zy6qneF1UebDB3fQShzYMWvYHPr6bnT7NpDr2fJ8QHIGYJSquNyHy6
         YMDs5u1cHKE8YDbV5etOxcnEXZEeWMc7NJ4TMrLSBo2EjpkosBfErLMEuf8eCBqImnPp
         BDzw==
X-Forwarded-Encrypted: i=1; AJvYcCWM4+7/njSgwnkKA5/PzaFJOhRK0O8Ds0vKE/eiUqrpFLtFip04slsbwz+20POTgnE/kr/Rg2YMFr4INRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YylNDmAPFnepediUl+1i4PRRkn/FmYGtPlzmK64XNfjNpjwzfAp
	cBfrhFlysaSEHAsrnALT+ynnqkYzibbwHEtDhghh6pVmbc9DNM/CDFp7DLhuzZZCa/WUOwfBz9i
	AqAsPAcEFe1UEWTQu5ev38RlF0y6A/MCWDKmR71O/SzFhS3lyYUakjOp0FFifBQ==
X-Received: by 2002:a05:6000:ac1:b0:37c:f561:1130 with SMTP id ffacd0b85a97d-37d551fd967mr16230973f8f.18.1729070570113;
        Wed, 16 Oct 2024 02:22:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYuIRB3SOz3zBfW+1TrVdJdzEMd1HnJYU2msz5wLlhJ2CtVCce9o3U7IRhaBXskyCKsIvrxQ==
X-Received: by 2002:a05:6000:ac1:b0:37c:f561:1130 with SMTP id ffacd0b85a97d-37d551fd967mr16230952f8f.18.1729070569691;
        Wed, 16 Oct 2024 02:22:49 -0700 (PDT)
Received: from dhcp-64-113.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa9077dsm3825575f8f.55.2024.10.16.02.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 02:22:49 -0700 (PDT)
Message-ID: <17b0528bb7e7c31a89913b0d53cc174ba0c26ea4.camel@redhat.com>
Subject: Re: [PATCH RESEND] vdpa: solidrun: Fix UB bug with devres
From: Philipp Stanner <pstanner@redhat.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael S. Tsirkin"
	 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
	 <xuanzhuo@linux.alibaba.com>, Eugenio =?ISO-8859-1?Q?P=E9rez?=
	 <eperezma@redhat.com>, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Christophe JAILLET
	 <christophe.jaillet@wanadoo.fr>
Date: Wed, 16 Oct 2024 11:22:48 +0200
In-Reply-To: <Zw-CqayFcWzOwci_@smile.fi.intel.com>
References: <20241016072553.8891-2-pstanner@redhat.com>
	 <Zw-CqayFcWzOwci_@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-16 at 12:08 +0300, Andy Shevchenko wrote:
> On Wed, Oct 16, 2024 at 09:25:54AM +0200, Philipp Stanner wrote:
> > In psnet_open_pf_bar() and snet_open_vf_bar() a string later passed
> > to
> > pcim_iomap_regions() is placed on the stack. Neither
> > pcim_iomap_regions() nor the functions it calls copy that string.
> >=20
> > Should the string later ever be used, this, consequently, causes
> > undefined behavior since the stack frame will by then have
> > disappeared.
> >=20
> > Fix the bug by allocating the strings on the heap through
> > devm_kasprintf().
>=20
> > ---
>=20
> I haven't found the reason for resending. Can you elaborate here?

Impatience ;p

This is not a v2.

I mean, it's a bug, easy to fix and merge [and it's blocking my other
PCI work, *cough*]. Should contributors wait longer than 8 days until
resending in your opinion?


P.


