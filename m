Return-Path: <linux-kernel+bounces-406711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564EB9C628B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 21:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09A5F1F2380F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 20:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731C321A4A0;
	Tue, 12 Nov 2024 20:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="b7LqUr8G"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6F8219E2F;
	Tue, 12 Nov 2024 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731443196; cv=none; b=JJBzW0aAkzSqVp5WclL/gkXqDrJBL45oBB/6ekjC6vzWmySPOOsV+MJtMIutrIy1mYUJVAHgUTaJuUc0G9GGeBF4olpMkm2QYYEPL+8eqgE4d4xxMF9Z87NNlh2ljLiW/SvAJb2+zo2IsQtV77F4Lajqqg2MhvSU1tDx0LMLH1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731443196; c=relaxed/simple;
	bh=2b/fokZMHb0mMRwj4SG4B6zOQZ3sRC9O4uIs5na1X/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qghxgY0WIv8jvXXbCfLOMIyZwh2Ey8UOG6nZMEP45Q4XR6uTOQ9bSa3n/1pdN/esYGCu8Lo5A9tbtUb4+DJPFZJEG+wO3AxCsmBIdG5KLFqIlhiShSjeQxbRqWtqE4ajyY62SOuaNQlAlsJKbIP05nz2ETFrF/9X/02HvPkvqRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=b7LqUr8G; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AE5E9403F4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1731443192; bh=FSCC1rF49xJWet6H9Ph1rCvq7uKxif/+mtVyYE/+3ps=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=b7LqUr8GNVq9pqlGrDabNR5cP5M93hDJc5aQw4NKHgCjwKa7BVM/p5GwHeK/yv45d
	 zY8GSIx8xKR1zDv+zXZPOkZGmICvdLGF/S2S4c4ETXRFgEiv6lViHGt0TFPZu8PjAc
	 W2ozqL10aNKrukcTFUIK2Ed4GEYVnukrk7GxuUFDdEPzRTdKWcldgziQsyOH4+A4oX
	 kITDDuNUH5I0DGDlcIYcBrWeyzG3rWnadW0Zc0KwldKyLX41h4H3xTeWIySQ8n6LfO
	 sUnYbIumMb52h7fv8L/Cphmt7WEoDdAqdoGqBU05rnFkRkOkh1OeFHM9EYHzeFLheq
	 G7/lGeZX95H1g==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id AE5E9403F4;
	Tue, 12 Nov 2024 20:26:32 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, anish kumar
 <yesanishhere@gmail.com>, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, Sebastian Fricke
 <sebastian.fricke@collabora.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-sound@vger.kernel.org
Subject: Re: [RFC PATCH] ALSA: Add debugging guide for audio issues
In-Reply-To: <109984d7-98f7-4b2a-8fee-1f7b30230a44@infradead.org>
References: <20241107200835.3033-1-yesanishhere@gmail.com>
 <87cyj622oc.fsf@trenco.lwn.net>
 <274400c3-fd64-4e45-bbd2-319634a09d61@infradead.org>
 <874j4i205j.fsf@trenco.lwn.net>
 <70a27fe2-cc85-4f35-b24a-8e3425e447d0@infradead.org>
 <87v7wyznow.fsf@trenco.lwn.net>
 <109984d7-98f7-4b2a-8fee-1f7b30230a44@infradead.org>
Date: Tue, 12 Nov 2024 13:26:31 -0700
Message-ID: <87wmh8p5ag.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> On 11/7/24 2:25 PM, Jonathan Corbet wrote:

>> If we really want to separate the mechanics of kernel development from
>> the associated process information - not always an easy separation, IMO
>> - we could make a top-level "development" directory, put a lot of the
>> other relevant stuff there, and include the debugging stuff.  It seems
>> really weird to put debugging by itself, though; it's only part of the
>> picture.
>
> I could go with that.
>
>> 
>> Why is Documentation/process so bad?
>
> Documentation/process/ is meta-documentation about kernel social "standards"
> among other things. It is "soft" documentation, whereas debugging (IMHO) is
> "hard" documentation.
>
> But hey, it's all your baby. Do whatever pleases you. :)

Hopefully not all mine...:)

My suggestion is to put it under process for now just to not block
forward progress on this work.  We can surely relocate it if we want to
make a proper development-processes top-level directory in the future.

Thanks,

jon

