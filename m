Return-Path: <linux-kernel+bounces-262122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E462793C10D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 13:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 219CF1C214D0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 11:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BF6199259;
	Thu, 25 Jul 2024 11:42:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15751198A2E;
	Thu, 25 Jul 2024 11:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721907771; cv=none; b=MgfgyJgwMjXBr6YqWTmSGJy4DSH6gt3dFuRoFIlHbtBg8kJja9WjGGxj148h2Ou54XjOSQjIyUbSDskmlur/FGwA19KrcyGdB15lR8c8uOYpjq8LtbSS67ih8PPiaXFYwqZgimJTYw5uAlViCHx1WZDv4dwEBrBqcSq0KQdPdbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721907771; c=relaxed/simple;
	bh=3xZ/hS9kV76RHBlISvMxIh19+LpfwBY/WqoQTCTyoAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sPNRwFl6UUpocLSNMv/+Nha7ae7HUojEjwKrTvpzXBcD1imwEb58KWn4p4hKSN33kytu7h1h4NVY54hnMmc/lEOPstyl2B7qlmJKBqcwp7wUr9RMb5K1n9iG+4QP3DYkw4Ut4efyR8mfMOefWh3ai1fDz9KfZ+GAY5yTnss9ZN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.arm.com; spf=none smtp.mailfrom=foss.arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=foss.arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9BFB1007;
	Thu, 25 Jul 2024 04:43:13 -0700 (PDT)
Received: from [10.1.196.44] (unknown [10.1.196.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D16E3F5A1;
	Thu, 25 Jul 2024 04:42:46 -0700 (PDT)
Message-ID: <68f0fdfc-8bc2-462d-9d0d-4d0ad41c6811@foss.arm.com>
Date: Thu, 25 Jul 2024 12:42:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] drm: panthor: add dev_coredumpv support
To: Steven Price <steven.price@arm.com>, Rob Herring <robh@kernel.org>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Daniel Almeida <daniel.almeida@collabora.com>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, ojeda@kernel.org,
 Danilo Krummrich <dakr@redhat.com>, lyude@redhat.com, lina@asahilina.net,
 mcanal@igalia.com, airlied@gmail.com, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <fe84a028-01a8-4987-b1b7-141fb76d263c@arm.com>
 <4344B22F-D859-4C64-A351-69FFB5208362@collabora.com>
 <edda856e-3102-495a-8cc6-b79f5f114833@arm.com>
 <20240723180642.73502856@collabora.com>
 <6ce8fd12-b175-4a8f-8ea9-6221a555b69c@arm.com>
 <CAL_Jsq+Dr5zO5MKEGq0dW9SuTuawaJMhHziFd73Ef_S1zbOkXw@mail.gmail.com>
 <6b60a83d-8416-4cf8-b373-dc3c697c788a@arm.com>
Content-Language: en-US
From: Carsten Haitzler <carsten.haitzler@foss.arm.com>
Organization: Arm Ltd.
In-Reply-To: <6b60a83d-8416-4cf8-b373-dc3c697c788a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> We did discuss this, but I've come to the conclusion that's the wrong
>> approach. Converting is going to need to track kernel closely as there
>> are lots of dependencies with the various rust abstractions needed. If
>> we just copy over the C driver, that's an invitation to diverge and
>> accumulate technical debt. The advice to upstreaming things is never
>> go work on a fork for a couple of years and come back with a huge pile
>> of code to upstream. I don't think this situation is any different. If
>> there's a path to do it in small pieces, we should take it.
> 
> I'd be quite keen for the "fork" to live in the upstream kernel. My
> preference is for the two drivers to sit side-by-side. I'm not sure
> whether that's a common view though.

I agree that a panthor.rs should to exist side by side with the C for 
some time. I guess it's going to be in the order of a year or so (or 
maybe more) and not a few weeks, so keeping the C and Rust in sync will 
be important.

My take is that such drivers probably belong in non-mainline dev trees 
until they settle a bit, are at least fully functional and we're down to 
arguing finer details. Especially since the other Rust infra they depend 
on not mainline yet either.

Given that, my opinion is this patch probably needs to be originally in 
C then with a rust idiomatic port in the in-progress rust rewrite, or 
there needs to be a lot more effort to building the right panthor layers 
such as better register abstractions for example as part of this which 
certainly will raise the workload to get this in.

