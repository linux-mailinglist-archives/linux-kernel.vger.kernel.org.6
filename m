Return-Path: <linux-kernel+bounces-440555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D71079EC0BD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 01:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED64E188458D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 00:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0BA6136;
	Wed, 11 Dec 2024 00:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="nbWbRENi"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2A55672;
	Wed, 11 Dec 2024 00:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733876959; cv=none; b=QzQ17NWec2215Te+QtmdX/WbI+8KwfERmdLOsRkkVUUU7PKE73DmtJ0dkePV2J3m4O+2m6c1CGFtuLDKPXgCLIADd67YAzHo0TIgvgCHILxadtR0AUYK4i1px4tno0uplgxC9B4NignWjYHqyov2yt4wlZi5xEgX5buXDtB6aP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733876959; c=relaxed/simple;
	bh=N5dEOV5iC4qvPpuNrD0NA8LkqSeZfYzYMfG9frGYw44=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ugcl2FOP8rUuYyoRWOmo1l7WANhTLrr+nhAhx6j/6U2aV2JkQ3dkpaHBRhgTaqCj9I3sIcpCXTGNmDIukIp6HXBzvv876aKXkHd1KIgJyDN9qL1bclW13gqaZIfXw/3NcLK7Fc5Somm+6lwpg1g4QEtxQ3clICfJAeO3Ortr3Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=nbWbRENi; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 48BBC403EE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1733876957; bh=qb4HBif2F5Ff4lk7AbAxZpuERk0QwKG56MVom7PI7Cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nbWbRENiEQk/+FABpU9JsetZ6pt4YGua0l86I8hFkwwe1IVE4Ox6zJnYZO7qy+7qu
	 dB63E+L1TsDXh5jrJjSfDOnqOPfAigwF893Fj3pY5YY0fhx1nlqsmV4qra23le/Oh0
	 DSbVY+60SdCfnO/9kN5liuJ4/3VzPqDJjBgCAJwNExk5TufElbeISs4bsKs1SmtS0h
	 M7c1C7xZbsznNnp1rvzTRdADknGP26Z5LVNOdNmuLPxPygiTG9oJ6YGg3LNtXf7txU
	 YJ78RA8mJ14bIsM6SKhgsHLoROdgRD2JXfKy0bCvWv7d9WaEbD4sOE7qq2Plef1pVk
	 QNoUgwPLXk+VQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 48BBC403EE;
	Wed, 11 Dec 2024 00:29:17 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Akira Yokosawa <akiyks@gmail.com>, Greg KH <gregkh@linuxfoundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Masahiro Yamada
 <masahiroy@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH] scripts/kernel-doc: Get -export option working again
In-Reply-To: <b7c99226-7c03-425a-91b6-c7969bdbb1cf@gmail.com>
References: <e5c43f36-45cd-49f4-b7b8-ff342df3c7a4@gmail.com>
 <87pllz2r30.fsf@trenco.lwn.net>
 <b7c99226-7c03-425a-91b6-c7969bdbb1cf@gmail.com>
Date: Tue, 10 Dec 2024 17:29:16 -0700
Message-ID: <87v7vr12qr.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Akira Yokosawa <akiyks@gmail.com> writes:

> Jonathan Corbet wrote:
> [...]
>> Ah ... I should have thought of that ... I'm glad you did.  I've just
>> pushed the fix out to linux-next, will send it Linusward in the near
>> future.  Thanks for fixing this,
>
> Your docs-fixes is based on v6.13-rc1.
> This fix needs to come after v6.13-rc2.

...which will happen once the fix hits mainline - the *fix* doesn't
depend on -rc2.

> On current docs-next,
>
>     ./script/kernel-doc -rst -export drivers/iommu/iommufd/device.c
>
> returns:
>
>     drivers/iommu/iommufd/device.c:1: warning: no structured comments found
>
> I guess restarting everything from v6.13-rc2 would make our life much easier
> for v6.14.

I suppose I can rebase docs-next forward (or back-merge) if there's a
real need to do so... I'm not sure how important that is to get rid of a
few warnings?

Thanks,

jon

