Return-Path: <linux-kernel+bounces-351394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD0B99107A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79A1FB32DDB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB151DBB0E;
	Fri,  4 Oct 2024 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xsqmyNDa"
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A651DBB0F
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 20:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728072682; cv=none; b=OUYSR4MNj96fWnWgyw9QySmbaqWWd5VuFpWrYohOKZyBWRtu8rMgXsl3I63xlkGfzV3gqKLU5/dRoWPWubvF8z9HY89uJN1+0Sb9f9dAvY9uC1VEfc3A9pSWhbqflN7wJD39j+x/DmhwblmxbMG8JEl7x+mQgyDpN0L/k833Qok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728072682; c=relaxed/simple;
	bh=1Q3ARqpo6ucPEOgOBCTE4UmqiP9jx666un4nzKeXtWs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cPIrtmwjlkXEeeb2K5RmzSP6Vj6ccpRF1MxVb1VPB5HPLWUqdr6YhJCdA9sYkHHdBVcxncRGcN41uH9XZB9n7KZKGasYDceeqVFPDQSQrfp9/pGm0FLeXUHLhVcchjm0XzNH3ee4WDlDIoroWA1Znq4RwAOhoXQH04zr8V1KdsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xsqmyNDa; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728072678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Q3ARqpo6ucPEOgOBCTE4UmqiP9jx666un4nzKeXtWs=;
	b=xsqmyNDaawfekWLDyNGp7gdxln8Ak7E1Yp4mB+h+AAETE0UYT6oGDzD8De+h82823Bs5Rs
	41+Z4+M2t8KWjzMXFGaW9xODwM8NXxdTgLr8C13psHTOKF9bReajNsHoulaGEa0+2CAe/b
	5i/btTPP0bgKEAyE3H04pPpFAdVfhwc=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] acl: Realign struct posix_acl to reduce its size by 8
 bytes
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20241004133716.enkqnmosn42oagos@quack3>
Date: Fri, 4 Oct 2024 22:11:00 +0200
Cc: Christian Brauner <brauner@kernel.org>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5BDFB946-8E51-4A8F-B7F8-40290FCB0011@linux.dev>
References: <20241004103401.38579-2-thorsten.blum@linux.dev>
 <20241004133716.enkqnmosn42oagos@quack3>
To: Jan Kara <jack@suse.cz>
X-Migadu-Flow: FLOW_OUT

On 4. Oct 2024, at 15:37, Jan Kara wrote:
> On Fri 04-10-24 12:33:57, Thorsten Blum wrote:
>> Reduce posix_acl's struct size by 8 bytes by realigning its members.
>>=20
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>=20
> Looks good. Feel free to add:
>=20
> Reviewed-by: Jan Kara <jack@suse.cz>

We should probably add:

Fixes: b0ab04a8ffd8 ("acl: Annotate struct posix_acl with =
__counted_by()")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: =
https://lore.kernel.org/oe-lkp/202409260949.a1254989-oliver.sang@intel.com=


as this patch is also a workaround for a Clang __bdos() bug (see the
Closes: link for details).

Thanks,
Thorsten=

