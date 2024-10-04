Return-Path: <linux-kernel+bounces-351435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AD6991131
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F431C23253
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DA81ADFFA;
	Fri,  4 Oct 2024 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MPCxGopX"
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C2A1339B1
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728076352; cv=none; b=EbSxreYz8Ptd9Ghhf+hP4nP81SZjf48bt2WvgN133VmrdNTsqzFIuH6Xdu8YHORywM5yCyBN4bsplojXu/w5EwvZWtot8jBlv4CkDAEs/+3eHcLdYQQig9K+1SfCTZuKUg/3DMFS/x1SeLAu5jBEDFBriWMC+8fS7ngthZ/Xl9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728076352; c=relaxed/simple;
	bh=Nm2zgPgni7HL32wM/JWby/cQpaMJRRCaSydvbB5vc/c=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=AtdL0eFw5S5OXvDkW3/HRc7FuhkVZ1/AxCdVuX8sq5YdvvWUIuVGSo0FNlJ/Sa9wv2XqX8bveuL2VN8ImxftglJE58/ZljiSDm9+QyqYo4g0y2jBO5HZ2mKmPFnqYy8bv3AWWs5fMffA/+L71tqmtjQq+DzOTIiJ51ZNbwpYNfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MPCxGopX; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728076342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nm2zgPgni7HL32wM/JWby/cQpaMJRRCaSydvbB5vc/c=;
	b=MPCxGopXDt8q2YlLxfayZ/zqlWcropZrnVM485alrc4EpyvL2PeCcr71trNQ2HqpE2Tz9/
	zGxvyGZ4GXJNcwdgHOOmeoRisUYStguR9I50ku3jyux4yD9MHgDAq9pf/U1ra7m0zw4V6O
	HIB++n3FU+H0qK2ZVzqU2GRnwdMaowU=
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
In-Reply-To: <5BDFB946-8E51-4A8F-B7F8-40290FCB0011@linux.dev>
Date: Fri, 4 Oct 2024 23:12:09 +0200
Cc: Christian Brauner <brauner@kernel.org>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7E908DDE-0B55-4429-9F8D-A9719002E39A@linux.dev>
References: <20241004103401.38579-2-thorsten.blum@linux.dev>
 <20241004133716.enkqnmosn42oagos@quack3>
 <5BDFB946-8E51-4A8F-B7F8-40290FCB0011@linux.dev>
To: Jan Kara <jack@suse.cz>
X-Migadu-Flow: FLOW_OUT

On 4. Oct 2024, at 22:11, Thorsten Blum wrote:
> On 4. Oct 2024, at 15:37, Jan Kara wrote:
>> On Fri 04-10-24 12:33:57, Thorsten Blum wrote:
>>> Reduce posix_acl's struct size by 8 bytes by realigning its members.
>>>=20
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>=20
>> Looks good. Feel free to add:
>>=20
>> Reviewed-by: Jan Kara <jack@suse.cz>
>=20
> We should probably add:
>=20
> Fixes: b0ab04a8ffd8 ("acl: Annotate struct posix_acl with =
__counted_by()")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: =
https://lore.kernel.org/oe-lkp/202409260949.a1254989-oliver.sang@intel.com=


Just realized Christian dropped b0ab04a8ffd8 (although it's still in
linux-next). I guess we don't need these tags then.

> as this patch is also a workaround for a Clang __bdos() bug (see the
> Closes: link for details).
>=20
> Thanks,
> Thorsten

