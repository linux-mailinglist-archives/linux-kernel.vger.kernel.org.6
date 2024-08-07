Return-Path: <linux-kernel+bounces-278456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5554994B075
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 21:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7D6E283C38
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 19:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3881448C6;
	Wed,  7 Aug 2024 19:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Gc8OY0vx"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76771442E8;
	Wed,  7 Aug 2024 19:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723058951; cv=none; b=E1xT+6t8pnbLrcTkW/qiXL7HlNmkUVTN1vEatEMQxvmY4AXPxy4EsAq0JNTtj28RvmUGhMPb/jmp+KMv8O/aAbC86Krggvj7vGKymHANTR5uLXqYsK7xsXPu5nhitShr2qdrDmcSvtfIROlu2wed/6mALAPWFS5+0wsbMDa3cJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723058951; c=relaxed/simple;
	bh=lW6HS8G+JxAp6oEcAQdseqlI6vGj2x5qPDTn/NnW1RI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t+aT1GoIJdZO6iT8HskJWHWn9ouRzoG81giWM2w/zy5t4lQ5HG7jGfav0QOEgbcX1lApFR4tYzCcY8wdhw4J19N6Peu2V5suLzofI7NBTbiYyjLwx6xvIZtW7ioEf+/98mAPI+KQR+XuCZSWr9N+FIpv4F/GJ2mHfow9C0laZSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Gc8OY0vx; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net AFF5C418B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1723058948; bh=Us6rQ1VoD9HyO2vmh51JPYOdrE4J/tQPD8FLDohdDg4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Gc8OY0vxZotEafoDAZHv5wP17CHMEDv3H53ljs0RTNUOZLIVSgtPQ2lQUqmvAvtOG
	 kgDOpCN4EMGxfb7VolsqDaR0fyk3xrBcoqx4cSpph3Rb25FFB+oWiBHe02SEMtJX5E
	 2cluxZJQKi49unVHMjYnPOSn5OdtDleHajTF9/FGEBiyvKXhpF+eWOMC9zMJ/a/cTi
	 /r45rmHIggw9i05nXxtfDmWO2V5WsuaLYMEWtce0YQHwtRimGIORp7b3owlj/F4fx6
	 YtvNUY7RBAQOiVyFHCbNuF0lea7IJcaItJQg1wbAY0t8x6eBEq+CfuL2jsOM2I6VtC
	 96+2W7xpDqlAg==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id AFF5C418B1;
	Wed,  7 Aug 2024 19:29:08 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Shibu Kumar <shibukumar.bit@gmail.com>, agk@redhat.com,
 snitzer@kernel.org, mpatocka@redhat.com
Cc: Shibu Kumar <shibukumar.bit@gmail.com>, dm-devel@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Removal of unexpected indentation error
In-Reply-To: <20240803183306.32425-1-shibukumar.bit@gmail.com>
References: <20240803183306.32425-1-shibukumar.bit@gmail.com>
Date: Wed, 07 Aug 2024 13:29:07 -0600
Message-ID: <87cymkrv24.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shibu Kumar <shibukumar.bit@gmail.com> writes:

> While building kernel documention using make htmldocs command, I was getting unexpected indentation error. Single description was given for two module parameters with wrong indentation.So,I corrected the indentation of both the parameter and description and also added the description separately for both the module param.
>
> Signed-off-by: Shibu kumar shibukumar.bit@gmail.com
> ---
>  .../admin-guide/device-mapper/dm-crypt.rst    | 20 ++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)

Thanks for your patch, I have applied it.  Please keep the following in
mind for future changes, though:

- A patch should make a single change; this one made two (fixing the
  indentation error and splitting the documentation for the two
  parameters).  For anything more significant than this, combining two
  changes in this way could have resulted in the patch being rejected.

- Please read our documentation on the writing of commit messages
  (Documentation/process/submitting-patches.rst in particular) and
  line-wrap your changelogs at a reasonable length.

I rewrote the changelog as:

> docs: dm-crypt: Removal of unexpected indentation error
> 
> Add the required indentation to fix this docs build error:
> 
>   Documentation/admin-guide/device-mapper/dm-crypt.rst:167: ERROR: Unexpected indentation.
> 
> Also split the documentation for read and write into separate blocks.

Thanks,

jon

