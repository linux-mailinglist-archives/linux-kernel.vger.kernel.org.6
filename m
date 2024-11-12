Return-Path: <linux-kernel+bounces-406690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133CF9C6464
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 23:40:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAEDAB440E4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1009C219CAB;
	Tue, 12 Nov 2024 20:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="r0ia7Rf7"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246891A76D2;
	Tue, 12 Nov 2024 20:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731442330; cv=none; b=VDKkIrXz+IyoLoHks583Mp61zmhirDgBzsVpzs9M0+70gqmdNj3udXIZSaZ8BiFvIoDfoKVI57GMGnqnSXGHZJJ/Yb409NeWjkztgHXYuRdNiKAdwKLVLXcs1dXcb6bmcw4N4RsZtEU/jZcf9E2NqD8kVwgI0tjcP2nx53xhqf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731442330; c=relaxed/simple;
	bh=Fu/1Rg21Fzm0n9/O98bf05emGXukx/vTkSyf0y3r0qo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ligNinFzZ68m2uzQSnk9LjcqLa0snDX2D/q+gABxSz1DsdmbN+1D6Pn3ISL/4RFOjouMGUZN/uQX5/yxYabsDaBTmWNKleSdQ9Q+IlD404FN7W+kz6GDkzpeWB39N3KeSC1EVmwXSCNnBhwxo6TxAk34mmNf8F5O7kGDWqdfmRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=r0ia7Rf7; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2FB50403E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1731442328; bh=Fu/1Rg21Fzm0n9/O98bf05emGXukx/vTkSyf0y3r0qo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=r0ia7Rf7FAZyI4nJFwj77F2Pqf3jumnN6ehnVylqM7eNlhsKlNwfSdkp+7n+I7TrG
	 m7zrey0jzQOzZOxGoC1DuF5qb5jkEoj6jDCAIINek3nvSeGL6tAS3tR4IBfox+53xJ
	 IN2A9n6HtEYbrEya4CrdFf9QYoUzQFKDkjaZl9kpRraj3pHoV+41S6jYE0TmJbguQc
	 yAQgMNthoKRywfKPC2jilolx6/T/qBtDTFN3WWg3yG/v0nH6ixDh+BRT6zE/l4D/IC
	 tIehhc0KjrYR/SyWk4DbxE/q4fTniIf27E0j04y1lYXAL+gUNfgqjPM7zq/peJC+SY
	 24ufMcXZi4bIQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2FB50403E4;
	Tue, 12 Nov 2024 20:12:08 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: David Lechner <dlechner@baylibre.com>, anish kumar
 <yesanishhere@gmail.com>, broonie@kernel.org,
 u.kleine-koenig@pengutronix.de, Jonathan.Cameron@huawei.com,
 pstanner@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] Documentation: devres: add missing mailbox helpers
In-Reply-To: <8dee409f-4b38-4168-9316-1fd15c97fc89@baylibre.com>
References: <20241106235217.94718-1-yesanishhere@gmail.com>
 <8dee409f-4b38-4168-9316-1fd15c97fc89@baylibre.com>
Date: Tue, 12 Nov 2024 13:12:07 -0700
Message-ID: <87ikssqkiw.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

David Lechner <dlechner@baylibre.com> writes:

> On 11/6/24 5:52 PM, anish kumar wrote:
>> mailbox api's were missing from the devres documentation.
>> This patch adds them.
>
> I've been wondering... Is it really that useful to have all
> of the devn_ functions listed in the documentation?

Not particularly, no.

Far better would be to use the docs build system to bring in the
kerneldoc comments that are there for at least a good subset of those
functions.

Thanks,

jon

