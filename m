Return-Path: <linux-kernel+bounces-190753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A8C8D0226
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1C511C2147B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8BA15F309;
	Mon, 27 May 2024 13:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="KRzARuGC"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF6A13BC3B;
	Mon, 27 May 2024 13:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817823; cv=none; b=VZca92Jvn/yS4LZugnakPQIpyPdKx2uxP94N7oA+7fZMLNEptKs3GQVRW5JWeUZ5hCUTFnc+ejLVOVlHoLCdzah8OL2d2l/v22GaaX+fVCP+EKIMDAUtL2sSw7qQxx3C4b0gGtdi18eIVSUjbxlCDOYJoCeyucpZ4xMgmeSVn1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817823; c=relaxed/simple;
	bh=+nP0nFvWQTGmKN1h8mBWXPdJ/NyR49065Fmlx0vf/hE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ijWs+N+I/PQttu9/4q+dtMLt/P9/gwRtBh+Ez6R7D4tVuALxE2h4udhsx8VU/vZC8pCextsW7SGB0JN83zEYHpGnA9XeDJPiAoBA0SZatVlEf0ZGC97lyC3Og3qN88kvuEKfBloGVnVGZMSNvUdUh32ZK8yiikL/IhVHaV9lVgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=KRzARuGC; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 44AC247C39
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1716817818; bh=JskqYYyNz3dMD01WU+7KptXTcnGKmuo6XobKIxRvLCk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=KRzARuGChKTGCcbDUHYk3ELS9q4KssOknufzQxGTvfXOYWjW45Z5x8qzsjfzSsh2a
	 xQsNZcSAkOz3vRGzBnu1c9h9405N7mTbZSH97gBrvdKAJ5zbPrqJ0LRXGFWCyI4bhy
	 FDHUfk9nkcQZ/AGfp+4zLcGA/t2njvkxCwpjVYm6w9ZdQraiWGHxDutSh87SC7Ldwj
	 Me4QJzwPCFh1rk6BeYpfckdQM63R5O4KCec53FY8sYM3V8/1HQ/ZktC0rcnVtOt3Nj
	 QJdNEEAkl8Yt3KLdp3nrBaUKQm9IA5Y/BN+bEOqnB5DhUknVa0icYvVTEeUPuKrb5D
	 hv3NM+N13yIqg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 44AC247C39;
	Mon, 27 May 2024 13:50:18 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Yunseong Kim <yskelg@gmail.com>
Cc: skhan@linuxfoundation.org, Jinwoo Park <pmnxis@gmail.com>, Austin Kim
 <austindh.kim@gmail.com>, shjy180909@gmail.com, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v3] Documentation: cve Korean translation
In-Reply-To: <bf37bf39-32d3-457f-abd6-115215d631af@gmail.com>
References: <20240527103003.29318-1-yskelg@gmail.com>
 <87ikyzpgqz.fsf@meer.lwn.net>
 <bf37bf39-32d3-457f-abd6-115215d631af@gmail.com>
Date: Mon, 27 May 2024 07:50:17 -0600
Message-ID: <87o78rnz3a.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Yunseong Kim <yskelg@gmail.com> writes:

>> 1) Why do I have three versions of it in my mailbox, sent over a period
>>    of 13 minutes?  What changed between the versions?
>
> Sorry, I forgot the name of the reviewer when I first sent the
> documentation content related patch version 2.

Which is fine, but...

>>    Normally, you want to wait for reviews to come in on one version
>>    before posting the next, and you should put a comment after the "---"
>>    line saying what changed.
>> 
>> 2) When did this review from Jinwoo Park happen?  I was not copied on
>>    that.

You did not answer this question.  Reviews should generally be done in
public, but that does not seem to have happened here?

Thanks,

jon

