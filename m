Return-Path: <linux-kernel+bounces-512143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19461A334B8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D21118885F2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5045780034;
	Thu, 13 Feb 2025 01:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OfAmb9EF"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F32B73451
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739410309; cv=none; b=qqmvNdn/LKY7c54PzRFNxhfwWW6IdgoVpA3zWIDy9X2buDQtbmSG9pB5843myck+bhB44Iyyzghj7fwsfuFDfxjHPBLJgLwGxhAYeLhutZk9VOFjd6kxciwG3tgsbg11NbwUi/2zWFXod1Cp9zYG3JfOb38VI6sNuhaZi+7ICWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739410309; c=relaxed/simple;
	bh=wn5hWy4NEGTuClKw5sCk4GYJlY0nnR8c078Ej4cCFN0=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=SuMKIfAe2N9SmEQb7gacfJmVtJhprFZ08ojG55YTd4RGnFUfpIKYUOAGsB3NVmv+4iV12g9cBxu5KhfxGflKw227b+HqRKFHbVAR4R1YfuSW6N9gYC61PgA0TjD7FgFKRHuQi2VH0GVnChmy2vZrWkQGYVTsTaGhxlguaXvEMe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OfAmb9EF; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739410305;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKJAC4copdSWlAGYz8yNaCEGCQjMPNS2pZX3LrD5kik=;
	b=OfAmb9EF+y0GmlO6e4S+Kw4NDqJcxDeNfE1pcvhPP6JK5gtNhy8ztNauakx0LOlzIfXQJQ
	5UN61lXUf53AerBRPHt/NpUPLR/wuuLjtpZmsTJLv+ShQSzn12ne1voxpiTTKBYwUl3reE
	ynB8B3i81FS4gE4LS6/9MF6e7X2abU4=
Date: Thu, 13 Feb 2025 01:31:43 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yosry Ahmed" <yosry.ahmed@linux.dev>
Message-ID: <3f4ff25513fa8a6589288418694f614e4d0399c4@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v5 12/18] zsmalloc: make zspage lock preemptible
To: "Sergey Senozhatsky" <senozhatsky@chromium.org>
Cc: "Sergey Senozhatsky" <senozhatsky@chromium.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Kairui Song" <ryncsn@gmail.com>, "Minchan
 Kim" <minchan@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <etumn4tax7g5c3wygn2aazmo5m7f4ydfji7ehno5i6jckkf27e@mu3fisrw5jcc>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
 <20250212063153.179231-13-senozhatsky@chromium.org>
 <Z6zXEktee8OS51hg@google.com>
 <etumn4tax7g5c3wygn2aazmo5m7f4ydfji7ehno5i6jckkf27e@mu3fisrw5jcc>
X-Migadu-Flow: FLOW_OUT

>=20
>=20>=20
>=20> +{
> >=20
>=20>  + atomic_t *lock =3D &zspage->lock;
> >=20
>=20>  + int old =3D ZS_PAGE_UNLOCKED;
> >=20
>=20>  +
> >=20
>=20>  + WARN_ON_ONCE(preemptible());
> >=20
>=20>=20=20
>=20>=20
>=20>  Hmm I know I may have been the one suggesting this, but do we actu=
ally
> >=20
>=20>  need it? We disable preemption explicitly anyway before holding th=
e
> >=20
>=20>  lock.
> >=20
>=20
> This is just to make sure that the precondition for
>=20
>=20"writer is always atomic" is satisfied. But I can drop it.

Right, but why do we care? Even if the context is not atomic, we disable =
preemtion and make sure the context stays atomic throughout the lock crit=
ical section.

>=20
>=20>=20
>=20> size_class_lock(class);
> >=20
>=20>  - /* the migrate_write_lock protects zpage access via zs_map_objec=
t */
> >=20
>=20>  - migrate_write_lock(zspage);
> >=20
>=20>  + /* the zspage write_lock protects zpage access via zs_map_object=
 */
> >=20
>=20>  + if (!zspage_try_write_lock(zspage)) {
> >=20
>=20>  + size_class_unlock(class);
> >=20
>=20>  + pool_write_unlock(pool);
> >=20
>=20>  + return -EINVAL;
> >=20
>=20>  + }
> >=20
>=20>  +
> >=20
>=20>  + /* We're committed, tell the world that this is a Zsmalloc page.=
 */
> >=20
>=20>  + __zpdesc_set_zsmalloc(newzpdesc);
> >=20
>=20>=20=20
>=20>=20
>=20>  We used to do this earlier on, before any locks are held. Why is i=
t
> >=20
> >  moved here?
> >=20
>=20
> I want to do that only if zspaage write-trylock has succeeded (we didn'=
t
>=20
>=20have any error out paths before).

Ack.

