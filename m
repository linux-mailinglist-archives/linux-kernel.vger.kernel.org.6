Return-Path: <linux-kernel+bounces-327093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 934619770EE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1026CB22BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D1A1B654F;
	Thu, 12 Sep 2024 18:51:45 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E549B13D530
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 18:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726167104; cv=none; b=mL4xA02jJIdFltfKh5EnwND0C8OPB2PLgfVS1gn4OgZ4Zpl9s+zWN3oT9xxNcjpksQ6H/zmmEOvfWDSiovHxWmpzD5x6SbBixmmfpV8kdLZGnTxUFUBdxh4dXWsVIBKtqxKGxUszPFHrA7NTZaeV3txTAUP1CiqQ0kglvGOuXKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726167104; c=relaxed/simple;
	bh=X405vKpajqLpEgidAx2nmx+uo0oSPArWretG9DItQ0g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DcDz5mh3VBen/ikZ1/CnQ+jslcwLjQJcvI47J2Pwk0e2UzguFyAezDkbb4VtyXyOmjg/7YHs+y/VNPT2yhniUikUDCp//oUqMs6YMKNyUYkXBVl6cnMcHHMfe+qSq52DjauuOx49YXzfyGS5mqBFnFEUvYEC2DYI/LkqLJG7n3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C951363CF3DA;
	Thu, 12 Sep 2024 20:51:39 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id fdg0EdIOomSn; Thu, 12 Sep 2024 20:51:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 272D263CF3E9;
	Thu, 12 Sep 2024 20:51:39 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id oxJZREg1ixr5; Thu, 12 Sep 2024 20:51:39 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 0C51863CF3DA;
	Thu, 12 Sep 2024 20:51:39 +0200 (CEST)
Date: Thu, 12 Sep 2024 20:51:38 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: Tiwei Bie <tiwei.btw@antgroup.com>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, 
	linux-um <linux-um@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <78364371.37121.1726167098936.JavaMail.zimbra@nod.at>
In-Reply-To: <20240828135140.1015940-1-tiwei.btw@antgroup.com>
References: <20240828135140.1015940-1-tiwei.btw@antgroup.com>
Subject: Re: [PATCH] um: Fix the return value of elf_core_copy_task_fpregs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF130 (Linux)/8.8.12_GA_3809)
Thread-Topic: Fix the return value of elf_core_copy_task_fpregs
Thread-Index: VafjHGNkbF6XAN0sHcypTXWfv3/Q1g==

----- Urspr=C3=BCngliche Mail -----
> Von: "Tiwei Bie" <tiwei.btw@antgroup.com>
> An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridgegre=
ys.com>, "Johannes Berg"
> <johannes@sipsolutions.net>
> CC: "linux-um" <linux-um@lists.infradead.org>, "linux-kernel" <linux-kern=
el@vger.kernel.org>, "Tiwei Bie"
> <tiwei.btw@antgroup.com>
> Gesendet: Mittwoch, 28. August 2024 15:51:40
> Betreff: [PATCH] um: Fix the return value of elf_core_copy_task_fpregs

> This function is expected to return a boolean value, which should be
> true on success and false on failure.
>=20
> Fixes: d1254b12c93e ("uml: fix x86_64 core dump crash")
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> ---
> arch/um/kernel/process.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
> index be2856af6d4c..3cc2b663aa78 100644
> --- a/arch/um/kernel/process.c
> +++ b/arch/um/kernel/process.c
> @@ -291,7 +291,8 @@ unsigned long __get_wchan(struct task_struct *p)
> int elf_core_copy_task_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
> {
> =09int cpu =3D current_thread_info()->cpu;
> +=09int pid =3D userspace_pid[cpu];
>=20
> -=09return save_i387_registers(userspace_pid[cpu], (unsigned long *) fpu)=
;
> +=09return save_i387_registers(pid, (unsigned long *) fpu) =3D=3D 0;

Why a new local variable?

Thanks,
//richard

