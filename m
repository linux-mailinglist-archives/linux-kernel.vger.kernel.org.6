Return-Path: <linux-kernel+bounces-526609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7907CA400F3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 21:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B099442660C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 20:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FDF2036FC;
	Fri, 21 Feb 2025 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="BIRMxLyi"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54271D8A14;
	Fri, 21 Feb 2025 20:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740169812; cv=none; b=NOFXWJvwxd9bJClPliKaBMQl9VUQD313sDv8/r+A4k6ydoXs0z0X5yaalpWx23xA6DlRhNA7b+i2xN4tywV2QohkgM947+U93UChgZ18p1a5mJwoQOsci8CqXYRaHgsuNpnwgo/W3Mcafffjr1oIneDKgb8n1nPLr04PbKBdzoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740169812; c=relaxed/simple;
	bh=U+acMgWQFwwiSlsLth/6S7K08cP7DrbTwY6/DqelmJo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jpGKs4OUfsIhs/Am4uXwt+Ya5Jn80uaCRo2g4oqNn8y8SgYcwwL90SVqL5kV1WeMYuM3tEVF4uGCGUizd9IpfNG+LnSQ340bFAWWWE9s23IRkaSQC4OJaBEnbg58fIm6zABaOzypsVg+TgCpVgAiKRVeUoAiN612p8JdnZiXPko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=BIRMxLyi; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E3CAC404E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1740169808; bh=TLcjADcCMW6BptEiTnfDxPwMNUG++cha/p36HARG6C4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BIRMxLyiNFeLm9cnw8sWj8Vs7JfV0y0vjw9BUQln8kdG7lMVBPNFgrCicVRcfRz+M
	 y3Nw19mSa3+InJyJibIs1Mhq6kS2S3GRuw3YXFtStzWKdSKJE1MAjCSSnO9z0HwMKn
	 MpGdXFGvtYM+ED+ntXxxfmInwKSl0hVvL1jQxJGvJ34p612XQMCYdpLKO6Rravf63q
	 brP9ERj0Z3l3YjddxSoda3r696ciJy5Rz+GuNXVYjEaighbGE2CQ6Ef92kh8DM2eFQ
	 Igo7rU3g2OmHq93Lb9nY8e53XHulYf4QviS8bUqv/vQ5qxQUwkH2ocuf2nHMbZl95U
	 0p0DXpF+7DGGg==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id E3CAC404E4;
	Fri, 21 Feb 2025 20:30:07 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Brendan Connelly <brendanjconnelly17@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 dmitry.torokhov@gmail.com
Subject: Re: [PATCH] Documentation: input: Add section pertaining to polled
 input devices
In-Reply-To: <20250208173554.209688-1-brendanjconnelly17@gmail.com>
References: <20250208173554.209688-1-brendanjconnelly17@gmail.com>
Date: Fri, 21 Feb 2025 13:30:07 -0700
Message-ID: <875xl3ghww.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Brendan Connelly <brendanjconnelly17@gmail.com> writes:

> Added section in Documentation/input/input-programming.rst about
> input_setup_polling() and input_set_poll_interval()
>
> Signed-off-by: Brendan Connelly <brendanjconnelly17@gmail.com>
> ---
>  Documentation/input/input-programming.rst | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Applied, thanks.

jon

