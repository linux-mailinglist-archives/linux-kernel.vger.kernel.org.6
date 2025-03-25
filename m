Return-Path: <linux-kernel+bounces-575589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 897E1A70487
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 16:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419B21889412
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78CE25B691;
	Tue, 25 Mar 2025 15:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUrY9lz+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE4D25B683;
	Tue, 25 Mar 2025 15:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915039; cv=none; b=KMr+7K0Jpuin8sFd3n2/9FZq1MOFBA6ag5gkdf4Wz5bMN8jETfIDN8/k9UKqolFBJkr3cyJqmq4F8KU22B5gCsHHNgqKc88zsBds6VcDXwgHz3cyNsbFv/ceqh0bEKUhGIrqkXrjtige69mUkyRwaSqYpuapNmQUHBLkNF+ylQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915039; c=relaxed/simple;
	bh=DlSm/XJ+691y9WK83MK+K+VAhVyt9Uh+O14MYitCEMU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=q7Sqy2fW3Trk0QUaekotYyy3pCQZBCWN7Kwvf5uNCGK0ksZfJa+0YgiKf5Rf+Zd7zxaIq3afiEKo8pzK+VFf1vAoMUov/Fa9TxjoW4d8ZBpC+PwFNLw3PnrsqQDsh4b0eK3g6Jl9THUck7isU+22ddaHUxgkJf80ktqObbVGvnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUrY9lz+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1174BC4CEEE;
	Tue, 25 Mar 2025 15:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742915038;
	bh=DlSm/XJ+691y9WK83MK+K+VAhVyt9Uh+O14MYitCEMU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=pUrY9lz+D3qAxxjKU9sRrd3biaS0OmEhrrBkwmx4kPkTpUCMHpy/mzaWypb8rfZ4e
	 WLOGhPmrBt3fs8APit625QUMpFR+e16CpN6BEITDKRtEtwtexF6oaMn3wIkjYwgOeN
	 6FizHB25INbj95+5G1l44Aav81PK0heFxnEewIbWf7WuxLUokYDYAlKxW2nVNlvXo0
	 +ZLGoHASqyFS74gwKSkv05fI01LQ9Iii2kDieVumQb9V4b3kd16w0Zxcxjv9wGWtEc
	 lDYZMXceQTr71M7lM3D0LYTuesBJusjWuB+LWuX05PUAjv37EulHMnN5n7zgzuy3C2
	 93XGDsyQIeifg==
Date: Tue, 25 Mar 2025 11:03:21 -0400
From: Mike Rapoport <rppt@kernel.org>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
 Changyuan Lyu <changyuanl@google.com>
CC: linux-kernel@vger.kernel.org, graf@amazon.com, akpm@linux-foundation.org,
 luto@kernel.org, anthony.yznaga@oracle.com, arnd@arndb.de,
 ashish.kalra@amd.com, benh@kernel.crashing.org, bp@alien8.de,
 catalin.marinas@arm.com, dave.hansen@linux.intel.com, dwmw2@infradead.org,
 ebiederm@xmission.com, mingo@redhat.com, jgowans@amazon.com, corbet@lwn.net,
 krzk@kernel.org, mark.rutland@arm.com, pbonzini@redhat.com, hpa@zytor.com,
 peterz@infradead.org, ptyadav@amazon.de, robh+dt@kernel.org, robh@kernel.org,
 saravanak@google.com, skinsburskii@linux.microsoft.com, rostedt@goodmis.org,
 tglx@linutronix.de, thomas.lendacky@amd.com, usama.arif@bytedance.com,
 will@kernel.org, devicetree@vger.kernel.org, kexec@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v5 00/16] kexec: introduce Kexec HandOver (KHO)
User-Agent: K-9 Mail for Android
In-Reply-To: <CA+CK2bDtBk=49hbz+C=fDswz_Nbtj8kVjsY-pTsmBt+O8YPLmg@mail.gmail.com>
References: <20250320015551.2157511-1-changyuanl@google.com> <CA+CK2bDtBk=49hbz+C=fDswz_Nbtj8kVjsY-pTsmBt+O8YPLmg@mail.gmail.com>
Message-ID: <01864D3D-C935-4AA6-85A9-363B14EA5443@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On March 25, 2025 10:19:53 AM EDT, Pasha Tatashin <pasha=2Etatashin@soleen=
=2Ecom> wrote:
>> To use the code, please boot the kernel with the "kho=3Don" command lin=
e
>> parameter=2E
>> KHO will automatically create scratch regions=2E If you want to set the
>> scratch size explicitly you can use "kho_scratch=3D" command line param=
eter=2E
>> For instance, "kho_scratch=3D16M,512M,256M" will reserve a 16 MiB low
>> memory scratch area, a 512 MiB global scratch region, and 256 MiB
>> per NUMA node scratch regions on boot=2E
>
>kho_scratch=3D is confusing=2E It should be renamed to what this memory
>actually represents, which is memory that cannot be preserved by KHO=2E
>
>I suggest renaming all references to "scratch" and this parameter to:
>
>kho_nopersistent=3D or kho_nopreserve=3D

I'm leaning towards kho_bootstrap

>This way, we can also add checks that early allocations done by the
>kernel in this memory do not get preserved=2E We can also add checks to
>ensure that scarce low DMA memory does not get preserved across
>reboots, and we avoid adding fragmentation to that region=2E
>
>Pasha
>

--=20
Sincerely yours,
Mike

