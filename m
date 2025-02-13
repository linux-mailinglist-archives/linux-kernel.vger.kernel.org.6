Return-Path: <linux-kernel+bounces-512126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64021A33469
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 02:13:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E643F188B0CF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 01:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B127E765;
	Thu, 13 Feb 2025 01:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BG8Ykno0"
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E626FC3
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 01:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739409178; cv=none; b=H8hrCbl0ln/S/Kl2xfDs+EH3X7O6OJjOlvhn04SNuqlQleV3aJBliDQVEpVmIZGeXQZp36z4d+qlG9XF4nZKgILEBxaFzgUDdzPeHnjna2co8eE5WZamZXlERWzdNdUomXyt1f96x1OiOGlObsuarOnjf0IYpBmz6Wad0oLv4Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739409178; c=relaxed/simple;
	bh=umarvi+SmBi89HuRYfTR2ECWsaRz8q2kXNgrgY789k4=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=C4DRyl2lVrG2Hrv7K7AMlZyJzwKt36u7VRj0TgewStSsvPoSGgExOOyLzQUmeQiyPgIxewl1z66O3AfJNfRINL/8W/Ke5BoU+Pv3O9lVa7CM8FHwj0jmvmcDhZT3jDwqNSLglVNNhh6qBrnnvNNujbLUKpKw7L1t+fbPycyATCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BG8Ykno0; arc=none smtp.client-ip=91.218.175.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739409173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCvt8acAjM6dGUvp/uJWfVH+KiIFeLo3NXreay/RMQs=;
	b=BG8Ykno0D9tc88+oJYPGgHmXPqe04tXla0kMjoUYlIPOCplUpScQqsg+F8XNn5blfwzCxS
	gQXBj2GIcih2tOLtky3WnhKm8u7ruzYy6UTnBFrkHySoNgRzcBeCsAXKktpivTG010c/rc
	T0joKnuusOLKBcmOxoABKVmd50kqCa8=
Date: Thu, 13 Feb 2025 01:12:51 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Yosry Ahmed" <yosry.ahmed@linux.dev>
Message-ID: <28ed23c00effdd531a9e027feb0bc08e22fc677d@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v5 10/18] zsmalloc: factor out pool locking helpers
To: "Sergey Senozhatsky" <senozhatsky@chromium.org>
Cc: "Sergey Senozhatsky" <senozhatsky@chromium.org>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Kairui Song" <ryncsn@gmail.com>, "Minchan
 Kim" <minchan@kernel.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <5htndqx74yv2lq2zr2odozrrbi5cz6zizn3vk4uosobn4ceoji@5zuknjmi26f6>
References: <20250212063153.179231-1-senozhatsky@chromium.org>
 <20250212063153.179231-11-senozhatsky@chromium.org>
 <Z6zJxvLbRQ6pKtue@google.com>
 <5htndqx74yv2lq2zr2odozrrbi5cz6zizn3vk4uosobn4ceoji@5zuknjmi26f6>
X-Migadu-Flow: FLOW_OUT

February 12, 2025 at 4:57 PM, "Sergey Senozhatsky" <senozhatsky@chromium.=
org> wrote:



>=20
>=20On (25/02/12 16:18), Yosry Ahmed wrote:
>=20
>=20>=20
>=20> On Wed, Feb 12, 2025 at 03:27:08PM +0900, Sergey Senozhatsky wrote:
> >=20
>=20>  We currently have a mix of migrate_{read,write}_lock() helpers
> >=20
>=20>  that lock zspages, but it's zs_pool that actually has a ->migrate_=
lock
> >=20
>=20>  access to which is opene-coded. Factor out pool migrate locking
> >=20
>=20>  into helpers, zspage migration locking API will be renamed to
> >=20
>=20>  reduce confusion.
> >=20
>=20>=20=20
>=20>=20
>=20>  It's worth mentioning that zsmalloc locks sync not only migration,
> >=20
>=20>  but also compaction.
> >=20
>=20>=20=20
>=20>=20
>=20>  Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> >=20
>=20>=20=20
>=20>=20
>=20>  FWIW I don't see a lot of value in the helpers (renaming the lock =
is
> >=20
>=20>  useful tho).
> >=20
>=20
> I want to hide the details, keep them in one place and at some
>=20
>=20point *in the future* have the same "locking rules" as for zspage
>=20
>=20lock. Also *possibly* throwing a couple of lockdep assertions.
>=20
>=20So I'd prefer to abstract all of these.


I'd prefer to introduce the abstractions when they are needed tbh. Right =
now they just make the code less readable.

