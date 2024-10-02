Return-Path: <linux-kernel+bounces-346885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F6A98CA44
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84E3281AAB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D355E610C;
	Wed,  2 Oct 2024 01:06:36 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62B15227
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 01:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727831196; cv=none; b=bXi5sa4KbnNP8h2MzHHBCV/BpmM4MvNi3iaakOA+nPfTOWwpnJ8b6lIzzzUaq+IL8TIjG/Ro9nChi4ItIyVkp/elDtcwQRLyCZL5DNFsnEyKg1tuqN6Ypk06Oser3CJSAcwjMsF9XT4o6O+shi8nWdhs01c7GEYMfSbwwD0RfiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727831196; c=relaxed/simple;
	bh=wybCse/EtsUOmhV2TCIXtapa9p9yXfW3du+66J3JFkI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MAmTHXJt270Q9fDv9LZ2qFCoczxyZ5P7w2g9GPLzFM6dBwW9gFxwFC6Au1AZhkQZvUH3iKNRphcmg5IgSzdLEraHy7vlhSDruwO8jMWQuWe28acpwNYoK9yPKANI0jz98xyfJWFWi3ZFMz8U1BJ6uBBlZmR4uwTnJVeXJdLKtxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id B172E1206B8;
	Wed,  2 Oct 2024 00:27:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf08.hostedemail.com (Postfix) with ESMTPA id DA7DA20025;
	Wed,  2 Oct 2024 00:27:08 +0000 (UTC)
Message-ID: <a848671f803ba2b4ab14b0f7b09f0f53a8dd1c4b.camel@perches.com>
Subject: Re: [PATCH] sched/psi: fix unnecessary KERN_ERR and memory barrier
 comment
From: Joe Perches <joe@perches.com>
To: Pintu Kumar <quic_pintu@quicinc.com>, hannes@cmpxchg.org,
 surenb@google.com,  peterz@infradead.org, mingo@redhat.com,
 juri.lelli@redhat.com,  vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org,  bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com,  linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org, pintu.ping@gmail.com
Date: Tue, 01 Oct 2024 17:27:07 -0700
In-Reply-To: <20240930135119.21164-1-quic_pintu@quicinc.com>
References: <20240930135119.21164-1-quic_pintu@quicinc.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Stat-Signature: btu9q8mza5jyxzc9c7skzyg9jmtaa6ej
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: DA7DA20025
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19DitOSwSnV5UJLzVQVXILHaPsT5lIrpU0=
X-HE-Tag: 1727828828-224587
X-HE-Meta: U2FsdGVkX1+gFmHGwqUy0/7TtB78ee7jeXWNhSSjZghs4bXoSFcAobNz64ndVApr6VOgTgYchi8PWTncddsG4pVD3C1Ma60Rly3dVoiTTh6mLuzI2RiqYzGlEhHZpVbNAfO5SVDQJWoSb12CBmjqAcK5bUYtzWSCHLPD7ek4ciouDHm28gBdy50rsnQhfwuUVtjnlzW2i8eRB/UCSIZTqz/IZ9BmuTAhfO8GoU2qke6GXVjAZipHBs4s04xTVcLWP2r8ZJG17kUhBDpHQHw1EfbEouYuc3sb/9lx9Ekt4rhwiwUu3wzL7MnjnjvnHptu

On Mon, 2024-09-30 at 19:21 +0530, Pintu Kumar wrote:
> These warnings were reported by checkpatch.
> Fix them with minor changes.
>=20
> WARNING: Possible unnecessary KERN_ERR
> +                       printk_deferred(KERN_ERR "psi: task underflow! cp=
u=3D%d t=3D%d tasks=3D[%u %u %u %u] clear=3D%x set=3D%x\n",

printk_deferred does not have pr_<level>_deferred variants
so a KERN_<LEVEL> use here is appropriate.


