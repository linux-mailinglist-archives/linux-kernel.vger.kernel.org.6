Return-Path: <linux-kernel+bounces-391524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3BD9B8837
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 02:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B57B282199
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 01:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48AA3F9C5;
	Fri,  1 Nov 2024 01:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Xs2vPNlW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1404437B;
	Fri,  1 Nov 2024 01:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730423564; cv=none; b=jCiP5RUrSfYHkqD6KX5lGGF72583gGjnn4xtZUf0DtIx8obMY/eB3qgJ88cCwrK/1QJewaixTDPnes/dZeesI/Clgrf8wW/A1WIsw0RduroOqfFELyVDjnc0PpDbp9EiCF77FupR1d4IhBzSCoxXWoRycLDIGdoNaoIjXdyKusk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730423564; c=relaxed/simple;
	bh=RQOONkHaqbxaor1HJ/3mSeACn4S35CoSQauawhoFHDU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CwtacBRzlMXtp+Jws+aghov5KlrIbSfQjOwbw95T5eeVUCXvnFUQlV/IpWAr6EYtnxeD3Tg8FjPGdSRARjFxji84vONaSLJT4/jaCnbN3wgJofAZ04otJ1WHX1TvkD77PH+Eq7y5bSYIjW/KTDZu2/6Qtr+mkCvtITVODqXXBFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Xs2vPNlW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BB2C4CEC3;
	Fri,  1 Nov 2024 01:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730423563;
	bh=RQOONkHaqbxaor1HJ/3mSeACn4S35CoSQauawhoFHDU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xs2vPNlWlwn4+dq3tRtP4qVzZfZGfwX/gEawrKAvQNIY0MCF2rSSLgpmnxeM6Jxg8
	 G7oKtLEN2iou5zuDwWT9nyy4p2GnkzDcBs+laXkqH/JzgyOEf4Dkz6IA1BOMI5bRZ6
	 KqLkPpu3/qPNpqjHsSQ7puI4cK9BtmSwAL41L/uQ=
Date: Thu, 31 Oct 2024 18:12:42 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: =?ISO-8859-1?Q?Ma=EDra?= Canal <mcanal@igalia.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Hugh Dickins <hughd@google.com>, Barry
 Song <baohua@kernel.org>, David Hildenbrand <david@redhat.com>, Ryan
 Roberts <ryan.roberts@arm.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Lance Yang <ioworker0@gmail.com>,
 linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH v3 0/4] mm: add more kernel parameters to control mTHP
Message-Id: <20241031181242.96312cd4eff58ba2369342c8@linux-foundation.org>
In-Reply-To: <f2a213eb-e69b-4572-b837-0c384bbb5960@igalia.com>
References: <20241030130308.1066299-1-mcanal@igalia.com>
	<20241030155059.9e27019842ef7c009b728b27@linux-foundation.org>
	<f2a213eb-e69b-4572-b837-0c384bbb5960@igalia.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Thu, 31 Oct 2024 08:04:58 -0300 Ma=EDra Canal <mcanal@igalia.com> wrote:

> > There isn't a lot of info here - please explain this timing issue in
> > more detail.
> >=20
> > Because the question which leaps to mind is: shouldn't the
> > "applications that use shmem" be changed to "configure mTHP through
> > sysfs" *before* "using shmem"?  Seems pretty basic.
>=20
> Sorry about that, I'll try to improve the commit messages and add more=20
> details.
>=20
> As mentioned in the example I gave ("DRM GEM objects"), my main use is
> GEM objects backed by shmem. I'd like to use Huge Pages on the GPU and I
> can only do that if I have contiguous memory to back my objects.
>=20
> I can't think how I can change sysfs from a DRM driver.

So your term "applications" actually refers to in-kernel drivers?

