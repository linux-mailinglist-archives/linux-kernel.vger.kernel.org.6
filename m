Return-Path: <linux-kernel+bounces-191021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 387368D05A1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 17:14:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 612501C21CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8643C16089A;
	Mon, 27 May 2024 14:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="OpSRQSnA"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C96A15FD19;
	Mon, 27 May 2024 14:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716821736; cv=none; b=kMeLdXWmhkO8e/hMf/TYVM7EnAObRydUaq/zreA2vbsjgCTboGh6vetIMtqV1rsiSXGUPbnpt9GKujTV0esclmdAt1O3myVK/tvI8oUEKbDYYhOwZBr9TbvqqQdJ2Kq4CwtNVOcUsyl6cutqL8H2E4H7QkGr2n2JthY0G7OVkUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716821736; c=relaxed/simple;
	bh=WqdfSky25P014jToQJxbbx2jmpw/Y6gIbx3q5jkMXhQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r0oXFDlfO+oXok30RXIXuKr38vstRx2h+cJ3MvyfN/I/egpHWqJyytM9bXPKuuRAWj/7QMsD0UX2uaN6wdpozc8oJ5c3YIwEtvsrXx7Vq7J/+3P/ECBO8oiV6jnIAheAxqy3UO6VM3knhRp11lqopBqelu3SYz6rYZYHs0YEknk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=OpSRQSnA; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 3BD0547C39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1716821734; bh=JUk9kiyoUx5RdgIxL9VYYk1ttK/biBJXbO+frYzpI0E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=OpSRQSnAig4IIYY8BNqix2k+Yb6FWJLwUUDh/7zJR3VliwFvSwhjOVu+Z00OWVUTi
	 KVw4IkJcG5msbhLvlUo1sTFRWleDxOukx7T4tmzLHByyJOy6WBoMQSoE6Z4VSj5BNh
	 wCoU4L9+TRxIe0jBtjA1q9CovmgzTdxCOQMzpRLTRj3LkpHIAEgFEA6yy5+Q2HGI0Q
	 FM43LYmqlZedmh5NcbRxWKNjYk8UYXdxqSsRLcfqgT+CyufHyV+BJrCbjenZAOG8kO
	 7LfrCr41ZPvqI+8bFU0s7/jDCVKQxYGIJHgACbRe+inNRNKS/hgtXKkEvGcJaSVSbY
	 agwtFAZLmVOSA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 3BD0547C39;
	Mon, 27 May 2024 14:55:34 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Yunseong Kim <yskelg@gmail.com>
Cc: skhan@linuxfoundation.org, Jinwoo Park <pmnxis@gmail.com>, Austin Kim
 <austindh.kim@gmail.com>, shjy180909@gmail.com, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] Documentation: cve Korean translation
In-Reply-To: <8880b0ec-9315-428e-b9c4-e578690d3c08@gmail.com>
References: <20240527103003.29318-1-yskelg@gmail.com>
 <87ikyzpgqz.fsf@meer.lwn.net>
 <bf37bf39-32d3-457f-abd6-115215d631af@gmail.com>
 <87o78rnz3a.fsf@meer.lwn.net>
 <8880b0ec-9315-428e-b9c4-e578690d3c08@gmail.com>
Date: Mon, 27 May 2024 08:55:33 -0600
Message-ID: <877cffnw2i.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yunseong Kim <yskelg@gmail.com> writes:

> On 5/27/24 10:50 =EC=98=A4=ED=9B=84, Jonathan Corbet wrote:
>> Yunseong Kim <yskelg@gmail.com> writes:
>>=20
>>>> 1) Why do I have three versions of it in my mailbox, sent over a period
>>>>    of 13 minutes?  What changed between the versions?
>>>
>>> Sorry, I forgot the name of the reviewer when I first sent the
>>> documentation content related patch version 2.
>>=20
>> Which is fine, but...
>>=20
>>>>    Normally, you want to wait for reviews to come in on one version
>>>>    before posting the next, and you should put a comment after the "--=
-"
>>>>    line saying what changed.
>>>>
>>>> 2) When did this review from Jinwoo Park happen?  I was not copied on
>>>>    that.
>>=20
>> You did not answer this question.  Reviews should generally be done in
>> public, but that does not seem to have happened here?
>
> Oops, sorry about that, Jonathan.
>
> Jinwoo Park sent me the review below, and I've updated some of ambiguous
> words in patch version 2.
>
> https://lore.kernel.org/linux-doc/57f0d90c-4cc6-4418-ab79-6ae026d8ae09@gm=
ail.com/T/#t

It does look like the patch was reviewed, but no Reviewed-by tag was
offered.  *Never* apply a Reviewed-by tag that has not been explicitly
given to you.

Jinwoo, would you like to offer that tag for this patch?

Thanks,

jon

