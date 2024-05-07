Return-Path: <linux-kernel+bounces-171566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9428BE5CF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60A0A1C20B36
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 14:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A81D15F30F;
	Tue,  7 May 2024 14:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="YNkxBBZt"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F4A15FA79;
	Tue,  7 May 2024 14:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715091803; cv=none; b=lt0a0ZrgJuEWGSLHRUhpoPDD5DoWKv7OQosHkR2Pa6w2Y5kcOGouBELZ4S6IaqrK5S8Q5KZ0O5/U1O3lZ2lOJFz7qzL/edQIJOCOxriX2map52i9+216cP+SRPRbueFI7DjI2E9M5M0Ky2c/rL86JQDxJ8iRvOaH8yeHzLJRk5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715091803; c=relaxed/simple;
	bh=z1JhMXdOjLsfkUP8OGJnR28LCIOXgCXVet23oeOhiGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YHnW5MDHr/RoMy1l7/HfIk2qzK6pZantwAKg27WB8WsNu0H/USJ0OsQWqAgEDDxGkzZzR6HLKrjLsRzqjeYEcdflE/la3MdqUHhSoOuOhQTiLBD7b9G+OWsg9F7K7SZJdXdcqkn1z53BuFz+mfdkAk8IKsU7c+YSVyOg5dKec4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=YNkxBBZt; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 5A44147C32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1715091801; bh=wPvOCynBdMR4ObPxz+E/9jMUOCmN2pJgbpqr8bZceXI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YNkxBBZtSdOJzFmSHblVsGEy3am9towDVGl6CPC2sx0YFKNh5RGdTPsA/dm3WU9bl
	 5ZCp8s9ry0+5b2oTmBhfu4HlQT8qSoLfk4XMl5Qw6qT3n1WTnWZhwnG9WdSJgcoUmm
	 Ca0AzpWtR6Zhi49bNLeNXWbHEFR3IwuebtRR95XaGSHwaiHKdAD74rz+1sdE2lCCPL
	 +XyCgecqElahsOAhJ9ScTw+P+ZQjMQfaHQ4t+1aLduy4Wc6pf7Q76g/9OKHDoQUs06
	 MkZLDzGDYdxxm9mFDMqaZoMxiz4GGO5cSZcSSIvdF/jyTb/CdAfaQR5MI/DLOuWVPL
	 ESAvVOOEEHgiw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 5A44147C32;
	Tue,  7 May 2024 14:23:21 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Utkarsh Tripathi <utripathi2002@gmail.com>, akiyks@gmail.com
Cc: Utkarsh Tripathi <utripathi2002@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH v3] kernel-doc: Added "*" in $type_constants2 to fix
 'make htmldocs' warning.
In-Reply-To: <20240503182650.7761-1-utripathi2002@gmail.com>
References: <20240503182650.7761-1-utripathi2002@gmail.com>
Date: Tue, 07 May 2024 08:23:20 -0600
Message-ID: <87v83pg0pz.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Utkarsh Tripathi <utripathi2002@gmail.com> writes:

> Fixed: WARNING: Inline literal start-string without end-string in 
> Documentation/core-api/workqueue.rst
>
> Added "*" in $type_constants2 in kernel-doc script to include "*" in the
> conversion to hightlights.
> Previously: %WQ_* -->  ``WQ_``*
> After Changes: %WQ_* -->  ``WQ_*``
> Need for the fix: ``* is not recognized as a valid end-string for inline literal.
>
>> The kernel-doc script uses the $type_constant2 variable to match
>> expressions used to find embedded type information.

I've applied this.  I made a changelog tweak, in that this line:

> v1 and v2 discussions: https://lore.kernel.org/linux-doc/640114d2-5780-48c3-a294-c0eba230f984@gmail.com

..should really just be a Link: tag rather than something special.

Thanks,

jon

