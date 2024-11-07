Return-Path: <linux-kernel+bounces-400615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8B09C0FF6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 21:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24DBD1F23A8C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 20:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0351921859E;
	Thu,  7 Nov 2024 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="pin27Uwm"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBF621830B;
	Thu,  7 Nov 2024 20:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731012342; cv=none; b=faWW/BQHVhv3LsZsx8ZzGQv7sOkX40EhlT1XrHOj0XOvFx+axZsSdAGr4w/5RGItRwqbqFcqOJwyFIGE/sz2FcFRZIYFyRkAJiws/uBBkgiLcBxot5gsB34SDPMHWS5pyi+/r2JdijMu+cSMrZcQKQmUF1pJ64oOiydxTI5ligU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731012342; c=relaxed/simple;
	bh=n/eB7KhfK7BP837zIWLOHe7+NAjFY3sMqDDCzkeAIU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oWw7BFeAUYlJ+UrLA3U6QS8Tik4O7dvDpgEdM8lAUB6KXXGZ3Z10xDRgbS6oXVMvL0HFhGdXLWts6aTQG/lFF/baKqejRdMwv+LirXVl/+tQ9eK7zoGxwQd+siX9GePJpI7C5Eh9ahUJGhyefn1YLrOn2fVjE4GRKFsDa27SEtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=pin27Uwm; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2515542C17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1731012340; bh=HnueUzWqD3mCAftcKyQZS53p8PXVi/3VDLYnP9vcBIk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pin27UwmQiu/qK3+ikBOnyb7W1MiS6sjDeSD5FHFJg2lwKaKgeA40qe2zRItdN+Jl
	 PVB51sWf4e3whcMEgbWKsYk7imYgK0ZLOg+FqG3lC7krhPKmi6t9d361O1anmQf7vi
	 D+CVB6W976k/C00NiaYy+1d0w9Aj2oh263JMiNsS9gq3q2ozDuOTjC1h3wDmsFTE/Q
	 qdUNLiMZrjz/4nhDvJWA1BWysfC1D1YVEVlXKikhjYL96YZyugUsg8MxzpSHXsLVmL
	 oTdAEushXiio+UUnqfFzGEsuTjAZnxGqkfUwsNn3sMUPnBN3L/uhHis5nWFRnhxlap
	 mj4GjdrAKlO3Q==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2515542C17;
	Thu,  7 Nov 2024 20:45:40 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: anish kumar <yesanishhere@gmail.com>, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com, Sebastian Fricke
 <sebastian.fricke@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-sound@vger.kernel.org, anish kumar <yesanishhere@gmail.com>
Subject: Re: [RFC PATCH] ALSA: Add debugging guide for audio issues
In-Reply-To: <20241107200835.3033-1-yesanishhere@gmail.com>
References: <20241107200835.3033-1-yesanishhere@gmail.com>
Date: Thu, 07 Nov 2024 13:45:39 -0700
Message-ID: <87cyj622oc.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

anish kumar <yesanishhere@gmail.com> writes:

> Add a comprehensive debugging guide for ALSA audio issues, covering
> topics from bootup to runtime debugging. This document aims to help
> developers diagnose and resolve common audio problems in Linux.
>
> The guide includes sections on:
> - Bootup/bringup issues
> - Runtime debugging
> - XRUN debugging
> - Audio pops and clicks
>
> This addresses the lack of a centralized debugging resource for ALSA
> and should help improve the troubleshooting process for audio drivers.
>
> Inspired by discussions on LKML:
> https://lkml.org/lkml/2024/9/24/392
>
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---
>  Documentation/sound/soc/debug.rst | 334 ++++++++++++++++++++++++++++++
>  Documentation/sound/soc/index.rst |   1 +
>  2 files changed, 335 insertions(+)
>  create mode 100644 Documentation/sound/soc/debug.rst

At a first glance, this seems useful.

I was just looking at Sebastian's new debugging documentation:

  https://lore.kernel.org/all/20241028-media_docs_improve_v3-v1-0-2b1b486c223e@collabora.com/

... so my immediate thought is that this documentation should be
coherent and together, rather than scattered though the docs.  Maybe
move this to process/debugging and integrate it with his work?

Thanks,

jon

