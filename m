Return-Path: <linux-kernel+bounces-351864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C50F991701
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 15:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8AAA82821F9
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 13:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9161531D5;
	Sat,  5 Oct 2024 13:29:09 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2D9149DE8
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 13:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728134949; cv=none; b=kv8Pe3uzueykSRz4J+mEWJY6DJ6ueJetp1RiaY/Wip2Nm5uxn1Q9pxiHn3lLQeYR81qlyQU4c6G6r+x84NpbW3vouB0AYOKKxO44WYO8Wh9F86GUrJTzcZ5a6x1F8VbGc8LbJutyOsP52h0jyR07HGSwc5/SbbHC3GTsW3jVXZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728134949; c=relaxed/simple;
	bh=be+G4OvzmnupOoHxJCq94y07fr+7R/AVAuRyLp6zzhI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oT6tDUQTR7Ev2UD7l041Ym+IByTSAC39l64+bSJpSv5ab21shqy1iCZyGA3PTVIKgwl7CcAulIEMJf6uNqlAQJgbByC1zM9E7nFxAwwVKyEk24yluN/NTejdIaSW1CxlarnZpa8OahsXccmfkdCgUsMUiTXAJ85K5cqvdQWNW/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 498B11202B5;
	Sat,  5 Oct 2024 13:28:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id 6ED3E20030;
	Sat,  5 Oct 2024 13:28:55 +0000 (UTC)
Message-ID: <a3f10804c9b793b90513301a08bdfb406959b6f8.camel@perches.com>
Subject: Re: [PATCH v2] sched/psi: fix memory barrier without comment
 warnings
From: Joe Perches <joe@perches.com>
To: Pintu Kumar <quic_pintu@quicinc.com>, hannes@cmpxchg.org,
 surenb@google.com,  peterz@infradead.org, mingo@redhat.com,
 juri.lelli@redhat.com,  vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, rostedt@goodmis.org,  bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com,  linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org, pintu.ping@gmail.com
Date: Sat, 05 Oct 2024 06:28:54 -0700
In-Reply-To: <20241005131643.7692-1-quic_pintu@quicinc.com>
References: <20241005131643.7692-1-quic_pintu@quicinc.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 6ED3E20030
X-Rspamd-Server: rspamout06
X-Stat-Signature: wqow3wjha6x139me6c6zje9w6m1yojxd
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18Wdh9AUIuqIKMfcjQclAS0J3P9f45QB50=
X-HE-Tag: 1728134935-751264
X-HE-Meta: U2FsdGVkX1+jfpg2EPnGXItRFUYpOpkJu5HZJZvuKVtizJAlqb85lutxqbVX3c9U4MzC3eetlqjfQmPp9FJ6nZwaledBQLfOZ9qrdV3SwDh64Y4vqg6gy3DaBV0m40pEAYEBKZg2Gw28GfB6omeK2fUWhW+dZNp3j8cK2bP/Sj8hrQ71+gDVDOVbDIWBPaDGWhmxg2XwUFKv2UGNZlFJq3PHv35y58Tcn7LWBYWIupXHWsfy+xyVdi1AUE5+5xhpYbzX3SBxh2/kP/Jo+b7Nt8cxpE0Axz9apTYenWy0o7Xz5rQoHDRDJYAsJ3HXyP5K21RBQhVxl8RTDH5EIesY+U35hcFR5X/Cn2VZKEi8Emxjxuvxfn6RuLxCfBHRoZHMt84wCtXOQWAGL4QtHFyJXiiNKtenIxyGVyRrApMk3BNlwGtR0TYVkEQfEE6YgLL+

On Sat, 2024-10-05 at 18:46 +0530, Pintu Kumar wrote:
> These warnings were reported by checkpatch.
> Fix them with minor changes.
> No functional changes.
>=20
> WARNING: memory barrier without comment
> +       t =3D smp_load_acquire(trigger_ptr);
>=20
> WARNING: memory barrier without comment
> +       smp_store_release(&seq->private, new);
>=20
> Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
> Reviewed-by: Joe Perches <joe@perches.com>

Please do not add signatures not given to you.


