Return-Path: <linux-kernel+bounces-318961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5C496F5B1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEA5B283AA8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 13:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48119188A31;
	Fri,  6 Sep 2024 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="BpZevAOq"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D131E4BE;
	Fri,  6 Sep 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725630329; cv=none; b=ZcgDtooPpRS8BeNkOM3FzeT5SjFiRL+/WOuhWY0u9+Oo/Py7INWd6BC1Hpv4j8hi5+7Oj+6ePhCAsg8X6fYivfaAQ9+eD+qsWzAfsERtgijLtzQMyqH9Z0kVeP3KyI2cdWIpxqLDAaGGImQl7LrrNptR5iyF4a8yBpiV7wCljBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725630329; c=relaxed/simple;
	bh=HAlepbeGBtIUm/c25wacsxd4oNHR1xSyPvQSDsIMNMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dioi6RyY0ytFn1Ff8B77S8XM5Fq7Xe0KEvcW//NjfJKwdLAeMNnCigtcULosYUOeWIXTNwwKDfUR5dAZTbehxib49qqwaH10K2zD0QBotDiGDGpwhNkyYzddbKtNI/uRBFet4uG8GFfq1uEoaJo3Z19ZYhx8N8yjYDwwsCe2ObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=BpZevAOq; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0CEAA418A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1725630313; bh=FAeNVEI+lvc2YcTpo6a9x+mzfcAQsZfl47V2KqlXTq8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BpZevAOqqQqIMuiwVKDxy+PcDsnecBc4ZIKeWK+kacyRtuTHKoGLWdj4St1UOXAYp
	 NnTmptMvPeaXQdEbBQm+8zboLNA5OoigvC+wRbiLuJPgbAblynXG0nsc7Tckjr2AwN
	 nBmXn2VuTbtz+qUajHPHOeRkp01sY2dlKlbKZGPkng34VTYbC0ys3gN6z+T5nvfjxU
	 OGx+yT1NgVRyhP7t/c9Tkw6sNLK3PAZByyHDJ8nAxNcD6IL6ydtZhANf6ltiqYMdFh
	 Iw9OpeqXBrfw9Een3m/Ap1lhFvnNuGQWeprNiKIDBVhTQdislrKsXHT9j6maRQnJ7Z
	 0/k3Yfs+D0OTw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 0CEAA418A0;
	Fri,  6 Sep 2024 13:45:13 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Jani Nikula <jani.nikula@linux.intel.com>, Takahiro Itazuri
 <itazur@amazon.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: bp@alien8.de, itazur@amazon.com, zulinx86@gmail.com,
 jpoimboe@kernel.org, pawan.kumar.gupta@linux.intel.com,
 peterz@infradead.org, tglx@linutronix.de
Subject: Re: [PATCH v2] Documentation: Use grid table over list table
In-Reply-To: <87zfoknc9y.fsf@intel.com>
References: <20240906104936.15558-1-itazur@amazon.com>
 <87zfoknc9y.fsf@intel.com>
Date: Fri, 06 Sep 2024 07:45:12 -0600
Message-ID: <87h6asgal3.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jani Nikula <jani.nikula@linux.intel.com> writes:

> On Fri, 06 Sep 2024, Takahiro Itazuri <itazur@amazon.com> wrote:
>> Using a simple table, a line break in the first column would be
>> recognized as two rows. To avoid that, list table was used but it
>> is unreadable for plain text readers. Uses grid table instead.
>>
>> Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
>> ---
>> Changes in v2:
>> - Use grid table over list table (applying to not only GDS but also
>>   other vulnerabilities)
>> - Link to v1: https://lore.kernel.org/all/20240903132533.26458-1-itazur@amazon.com/
>
> I see that Jon asked you to use a grid table.
>
> But when I look at what's being changed, I can't help but think a
> definition list [1] might provide the best compromise between readable
> (and easily editable!) source rst and generated html. I don't think it
> has to be a *table* in either.
>
> Up to Jon, of course.

I think it's up to the people who write and use the documentation in the
end; I don't want to dictate minor choices like that.  Anything that
makes it more readable works well for me.

Thanks,

jon

