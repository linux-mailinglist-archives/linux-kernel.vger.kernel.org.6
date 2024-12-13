Return-Path: <linux-kernel+bounces-445132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83C19F11C6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 17:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC210163746
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 16:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12A31E377E;
	Fri, 13 Dec 2024 16:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="qBqPLD7O"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48F02F24;
	Fri, 13 Dec 2024 16:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734106049; cv=none; b=OxAoxhEMsAM9+1ylBm5mgfyLdzMO43pIqfMPSkbjXlT1JQr31yemvbycyiQ7AQF9loeFvau5MKl1x3tNqrL/syKWekFOpBBqhjCCN5YDN3FDoqEqlmET5KFO3yu9HG7qeK/u8I3KDcyM9ilJIlkJJPhn/0nfmsd3J3shffhTsgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734106049; c=relaxed/simple;
	bh=L4CDHgl9PIg/C2sKmHgK1JtZP7K5tJyjXWWj++Mmo20=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ifrBd8CTC34LjgXHrpwS4AOUvbO8TAB8R7ZKWBdmuTovm+DAsEQc1/eSUzLSw3O1M9YIrQhjsvTK+XfcUnozdhYNeZASymyvIAh66z6+waVbsMvD77edupjKdmQDh9aiu+pBK7PP5+pBLo4ZOcIQKqV0/idc8WP6TmlvxKrRSBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=qBqPLD7O; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net C4735403FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1734106045; bh=CDix5sdvn7zgkBy6uTqiRTOx3MpP5A+4PCqiNIfm0E8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qBqPLD7OC43Y6k5KkGaXD0o6amRH2ohPU4rg4ohjiIhp+S/4ktvRFvWjZwMmB82i4
	 beT5BZW6mG1peaLm9YdkVSOYTgsjMphRVpJ0r7mam5wXD0lKrAyYqrH7ybhNRxT/I+
	 DhZJr52G87B/P7A7N6OkIfSRyYCWgBG1+/msPG4bGrNgV+l+DAHmketzV2fmN7dqLA
	 1q8kRUQyrSFTJFo6sWTtkm1vfMLscuCapbgnVbdHu13BWZ5PZA9roA5Uxwfs/F1e9V
	 GIS0d6crn9nl3EYR3i9n/2TXvtn5G6knmxRTczc2322pjGs1P1EqT4xVtg3cLstPfv
	 DKsFWP9EsShUg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id C4735403FA;
	Fri, 13 Dec 2024 16:07:24 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Saru2003 <sarvesh20123@gmail.com>, minchan@kernel.org,
 senozhatsky@chromium.org
Cc: philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
 christoph.boehmwalder@linbit.com, terrelln@fb.com,
 linux-kernel@vger.kernel.org, drbd-dev@lists.linbit.com,
 linux-doc@vger.kernel.org, Saru2003 <sarvesh20123@gmail.com>
Subject: Re: [PATCH v2] Documentation: zram: fix dictionary spelling
In-Reply-To: <20241125165122.17521-1-sarvesh20123@gmail.com>
References: <20241125024927.GA440697@google.com>
 <20241125165122.17521-1-sarvesh20123@gmail.com>
Date: Fri, 13 Dec 2024 09:07:23 -0700
Message-ID: <87r06bwoqs.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Saru2003 <sarvesh20123@gmail.com> writes:

> Fixes a typo in the ZRAM documentation where 'dictioary' was
> misspelled. Corrected it to 'dictionary' in the example usage
> of 'algorithm_params'.
>
> Signed-off-by: Sarveshwaar SS <sarvesh20123@gmail.com>
> ---
>  Documentation/admin-guide/blockdev/zram.rst | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Applied, thanks.

jon

