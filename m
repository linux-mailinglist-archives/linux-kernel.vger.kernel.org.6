Return-Path: <linux-kernel+bounces-241029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1F8927613
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2860F1C227E3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6991AE849;
	Thu,  4 Jul 2024 12:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="eC9J/ndt"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDB51AB8F8;
	Thu,  4 Jul 2024 12:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720096352; cv=none; b=bocoPNqg3DpSNTdtVJr25FvbNJI9yvUJzOSBnP6jlQHW+dyBmQikYOx7Nsa+48LbcVJqEykX6/JIJwUiNUkBc3k84k8BeSwIKf+G9dmN+dZVpcMpB2aXlPI0H0FMV6QEFD8lyPUlISnavO5fc/uPQaqgg4nPJbnjDQ/UAQEtrEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720096352; c=relaxed/simple;
	bh=IzeWJYYp6m5cyiUP0hsBAU7OPxm6xFSfbz0WFTaEY1k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kEPKgiPOgQZdackM9cJvyZr3pH28WB9epLJUht5g3iEiEu6skjGuN7XD0tEQfHLixrSmsvJgEgyQLkIqytgoDiQJyyJbneG2QLHsGspfp4piG8UATiF2Ff2Smnt93/cUMgb7etLE0dTGHQNK8tdk/IJYyIiNI0iigFLZzXbe2pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=eC9J/ndt; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1720096348;
	bh=Kg76KaOIbqnAt68SmtPouOnB34EHvYcOG9w3BrvhJDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=eC9J/ndtD3JZYC5bXcIUuL9baGS+FEO9OPeVGtvMcAfVWSbN1jia1Em79xmhsbey1
	 ix9jF1OFtfcOlZ/PsqE/Cvdjd8DLaWVIBdk7XuVWxnJoX2/CWaCi5AkFef0js7DppK
	 OC3c5wY7L7QYjUDAEc6m9bBbylPc/VqSre7llqaC2XyjUOi+CBaaUqaUmWFNRlOpUz
	 0ML8tWrrT5/3TQOqY0c4e9+cb8ag/vk/IqVx5siUeoR33KgCPUaRrvakLHSmPIRUQT
	 phQdAm+PVhNIF9AIn6IEESqQLrzgtxLQyggahFovqM4i3jtiA8bOPJTHCJeF4HNGcm
	 HfMLzR0cSNYhQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4WFGHt5Rmjz4wbp;
	Thu,  4 Jul 2024 22:32:26 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Naveen
 N. Rao" <naveen.n.rao@linux.ibm.com>, Scott Wood <oss@buserror.net>, Arnd
 Bergmann <arnd@arndb.de>, Jeremy Kerr <jk@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] powerpc: add missing MODULE_DESCRIPTION() macros
In-Reply-To: <2509b43d-630c-4295-8330-5976677bf8bc@quicinc.com>
References: <20240615-md-powerpc-arch-powerpc-v1-1-ba4956bea47a@quicinc.com>
 <2509b43d-630c-4295-8330-5976677bf8bc@quicinc.com>
Date: Thu, 04 Jul 2024 22:32:26 +1000
Message-ID: <87y16hibhh.fsf@mail.lhotse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:
> On 6/15/2024 10:06 AM, Jeff Johnson wrote:
>> With ARCH=powerpc, make allmodconfig && make W=1 C=1 reports:
>> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/powerpc/kernel/rtas_flash.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/powerpc/sysdev/rtc_cmos_setup.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/powerpc/platforms/pseries/papr_scm.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/powerpc/platforms/cell/spufs/spufs.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/powerpc/platforms/cell/cbe_thermal.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/powerpc/platforms/cell/cpufreq_spudemand.o
>> WARNING: modpost: missing MODULE_DESCRIPTION() in arch/powerpc/platforms/cell/cbe_powerbutton.o
>> 
>> Add the missing invocation of the MODULE_DESCRIPTION() macro to all
>> files which have a MODULE_LICENSE().
>> 
>> This includes 85xx/t1042rdb_diu.c and chrp/nvram.c which, although
>> they did not produce a warning with the powerpc allmodconfig
>> configuration, may cause this warning with other configurations.
>> 
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>> Corrections to these descriptions are welcomed. I'm not an expert in
>> this code so in most cases I've taken these descriptions directly from
>> code comments, Kconfig descriptions, or git logs.  History has shown
>> that in some cases these are originally wrong due to cut-n-paste
>> errors, and in other cases the drivers have evolved such that the
>> original information is no longer accurate.
...
>
> Following up to see if anything else is needed from me. Hoping to see this in
> linux-next so I can remove it from my tracking spreadsheet :)

I have this in my test branch, it will appear in linux-next next week.

A spreadsheet seems like overkill ;)

cheers

