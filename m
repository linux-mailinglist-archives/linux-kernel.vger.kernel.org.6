Return-Path: <linux-kernel+bounces-565176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8939A66263
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:06:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A72993B740A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3975B204F7E;
	Mon, 17 Mar 2025 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ZGTF1Rxa"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613DB376;
	Mon, 17 Mar 2025 23:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742252790; cv=none; b=d7YwdZaV1VPdQUgsRD+GnOVztNxW75Cj1TdpHHabB8wSYX6BVUgiRFmuZ70nqpdHRAru464OyVTwji6bfXJ4AbmOYfaa11yAz7bSxyuY2raMGrwARewAX2d11gcu6IVzpQeahhvpH1sSzCYxLn57OuwjSTEN+bHh6G/1t5Kd6HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742252790; c=relaxed/simple;
	bh=jxWAeHs2T6y/dyxhwehtyNGGW4rGNYSTPFRvM8paFq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mJUNIHtZ1sJohefmmDJl5WIFi44HTMBlaoDDBImP4LoFQPDV0dcvDEzubWhCSHgma494fYeCsK2kiS3TQoG8Qr9x8+lNew0ukF1q1wAFYtoiEDmO0VDVBAxdBsfZ9+uBSJWzFbEfUmf9AfKBEOXlSdeQ+nYty238ZCcpOB348XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ZGTF1Rxa; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 50F4B41061
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1742252788; bh=jxWAeHs2T6y/dyxhwehtyNGGW4rGNYSTPFRvM8paFq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZGTF1RxaEISHMn33V3qy/DZG6r59ZW8CZQRYD8yeWnpcDhkif0xZriDqznveSnCrs
	 DqwaGV3WTT4ocsLpvxn/JK3/waNqjRV45RdA1oYUzJK0bWoLw+o60t3jsrq3Y0BBqz
	 4Bvo9xYMNkPU+7nbWI6OWFaTiKcQzuEAq1oz4qZNP5WoIfxXH2g9hUC6/lko6AhZL5
	 u17aD3CwiWVbJbgEQOFlS6dPCdO4+ipV1QW91rGY0ZsnlZ2g7XJRqbX7uHOwfw22Qh
	 QpzyuzYH6RXCqBvJ82J6acP9o85RCt1oUjEbcvoXC6jYVwT2kfgxnWri3bL0txIjxf
	 OwcaUZEtPttbw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 50F4B41061;
	Mon, 17 Mar 2025 23:06:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Dave Airlie <airlied@gmail.com>
Cc: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, simona.vetter@ffwll.ch
Subject: Re: [PATCH] docs: driver-api: firmware: clarify userspace requirements
In-Reply-To: <CAPM=9tzv+=+ZGRtHgapUVAiDjHn=Bp33BqyLLQKDuKsR-AoC7A@mail.gmail.com>
References: <20250314100137.2972355-1-jacek.lawrynowicz@linux.intel.com>
 <874izre0aq.fsf@trenco.lwn.net>
 <CAPM=9tzv+=+ZGRtHgapUVAiDjHn=Bp33BqyLLQKDuKsR-AoC7A@mail.gmail.com>
Date: Mon, 17 Mar 2025 17:06:27 -0600
Message-ID: <87v7s7cl58.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dave Airlie <airlied@gmail.com> writes:

>> Dave, you're the only one with fingerprints on this document; is the
>> change OK with you?
>
> LGTM,
>
> Acked-by: Dave Airlie <airlied@redhat.com>

OK, applied - thanks.

jon

