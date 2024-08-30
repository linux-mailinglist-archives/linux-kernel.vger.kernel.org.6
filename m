Return-Path: <linux-kernel+bounces-309207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C4196677C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 19:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96C8C1F2498B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 17:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B012A1B581C;
	Fri, 30 Aug 2024 17:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b="L46vvzop";
	dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b="U31mSxET"
Received: from mx.pao1.isc.org (mx.pao1.isc.org [149.20.2.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB6A1B86D2
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=149.20.2.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725037241; cv=pass; b=Orkt3/C0cGE1KZ4ESTNgRW8r3uP6KaPuHRHI2/YdoZ5S8zBzUTL0zBadSb0OKt3hgvTQbc/TGpbaNWPR8CTojDqCsiDPLS0b/wzZonWOHyWDLU5gXdS628xk7MqQlZyeoMYQ5tEWsNtxF4AgXW0Nz5cxrJrYx2paNXJpaaZ3CSY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725037241; c=relaxed/simple;
	bh=V2GG/tXDp9gfop4u4Qh9FUkgHDxGc6gPqlrVfSwOzFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K1NwFEhJ4QU2cacop0MeTAMGMj/Oa2oUcPiiYShetb7cwOPspSYHRang3xbtWttUhlN/mAin+MSHsLamKjDIhTAfgDHVx6MJnKMv5HyfkcoSsGAbgldXdlCl2AO2t0gkfATrxYdNm4SwqoPDgLGtwXqmG/128ibx9qDCdCqF3Og=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isc.org; spf=pass smtp.mailfrom=isc.org; dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b=L46vvzop; dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b=U31mSxET; arc=pass smtp.client-ip=149.20.2.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isc.org
Received: from zimbrang.isc.org (zimbrang.isc.org [149.20.2.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mx.pao1.isc.org (Postfix) with ESMTPS id C7CA13AB28F;
	Fri, 30 Aug 2024 17:00:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.0.0 mx.pao1.isc.org C7CA13AB28F
Authentication-Results: mx.pao1.isc.org; arc=none smtp.remote-ip=149.20.2.31
ARC-Seal: i=1; a=rsa-sha256; d=isc.org; s=ostpay; t=1725037236; cv=none; b=WFKW13VDUAk4vasE9VCWIzNMp951A0BfUCr4M6txQVRO+ZumsegFb3yJhbEe08xWwete50QVnJgivjHqA8ai9y83OP8h52CTWajeHzdJBMtjjHeAvmEehU7XpEh28TuLFIEPwQpLIg3Dea3G06H1BfsUGLFxoD+xxqWwDGbySHM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=isc.org; s=ostpay; t=1725037236;
	c=relaxed/relaxed; bh=V2GG/tXDp9gfop4u4Qh9FUkgHDxGc6gPqlrVfSwOzFM=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
	 Subject:To:From; b=SeC4l7LeswcSBYiXYcuBERcv5A7HsEfWBxHTuRA04WV5/aj0mGw61TeRhmeIni53ePWWvnRq5pHswbOd39LuROZvQTlNPBR0cjhbBTciHh2mpDQ6aIcycuHh4jV8dAaoF0rFTbEYtTtMmPqGOgRN61CGTNzoYNzYtRbZhCAmqDw=
ARC-Authentication-Results: i=1; mx.pao1.isc.org
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.pao1.isc.org C7CA13AB28F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=isc.org; s=ostpay;
	t=1725037236; bh=V2GG/tXDp9gfop4u4Qh9FUkgHDxGc6gPqlrVfSwOzFM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=L46vvzop3wKMKZAYk1lbp2PIvKK97f/PA8Mmep4g9dRoglrO5h7eCnAL92xa/Qxwu
	 DL+whxVwYAVcGEEkjAvVPFhN0lMf/9k0g5duKGUvPm2hodIc7vy3GayqbT82hIb8sg
	 grIuNzULcT3kDOZMU8Ef4M1e4R1qIN1VFSm4fil8=
Received: from zimbrang.isc.org (localhost.localdomain [127.0.0.1])
	by zimbrang.isc.org (Postfix) with ESMTPS id C27A8110C758;
	Fri, 30 Aug 2024 17:00:36 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbrang.isc.org (Postfix) with ESMTP id 9F742110C744;
	Fri, 30 Aug 2024 17:00:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbrang.isc.org 9F742110C744
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isc.org;
	s=05DFB016-56A2-11EB-AEC0-15368D323330; t=1725037236;
	bh=V2GG/tXDp9gfop4u4Qh9FUkgHDxGc6gPqlrVfSwOzFM=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=U31mSxETSF/C1MQnEC6Vb0CLSxwmuIloUw7EyX0ScYKYuiNSSIAqYHKHoXjACZYiS
	 AyaQHDw1aPc0piFjbDiiFf+w9IINSG/5HK4H+fjuXxGyjHH9sJQX9TcYpib/QQIHPI
	 c1UU+h1JHD8MrW/7PjscQQ7imvttLICTwchGluF0=
Received: from zimbrang.isc.org ([127.0.0.1])
 by localhost (zimbrang.isc.org [127.0.0.1]) (amavis, port 10026) with ESMTP
 id E6wRzLn-kT9k; Fri, 30 Aug 2024 17:00:36 +0000 (UTC)
Received: from [149.20.5.69] (unknown [149.20.5.69])
	by zimbrang.isc.org (Postfix) with ESMTPSA id 7339A110BF9A;
	Fri, 30 Aug 2024 17:00:35 +0000 (UTC)
Message-ID: <b8436b35-0c39-4471-baf7-ec9a07537f9f@isc.org>
Date: Fri, 30 Aug 2024 19:00:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm: mmap: Change DEFAULT_MAX_MAP_COUNT to INT_MAX
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
 Liam Howlett <liam.howlett@oracle.com>
References: <20240830095636.572947-1-pspacek@isc.org>
 <90f07fec-3f46-4b38-86fd-07c9f8201904@lucifer.local>
 <82960a7e-9013-475e-9b80-7b29a5667482@lucifer.local>
 <5dca8600-0352-4b5b-acb0-0cd4f84733f4@isc.org>
 <mftebk5inxamd52k46frhq2llopoiiewsgdkrjbamg4yukyhqw@vf4jzz6lmgcu>
From: =?UTF-8?B?UGV0ciDFoHBhxI1law==?= <pspacek@isc.org>
Content-Language: en-US
Autocrypt: addr=pspacek@isc.org; keydata=
 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
In-Reply-To: <mftebk5inxamd52k46frhq2llopoiiewsgdkrjbamg4yukyhqw@vf4jzz6lmgcu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 30. 08. 24 17:04, Pedro Falcato wrote:
> On Fri, Aug 30, 2024 at 04:28:33PM GMT, Petr =C5=A0pa=C4=8Dek wrote:
>> Now I understand your concern. From the docs and code comments I've se=
en it
>> was not clear that the limit serves _another_ purpose than mere
>> compatibility shim for old ELF tools.
>>
>>> It is a NACK, but it's a NACK because of the limit being so high.
>>>
>>> With steam I believe it is a product of how it performs allocations, =
and
>>> unfortunately this causes it to allocate quite a bit more than you wo=
uld
>>> expect.
>>
>> FTR select non-game applications:
>>
>> ElasticSearch and OpenSearch insist on at least 262144.
>> DNS server BIND 9.18.28 linked to jemalloc 5.2.1 was observed with usa=
ge
>> around 700000.
>> OpenJDK GC sometimes weeps about values < 737280.
>> SAP docs I was able to access use 1000000.
>> MariaDB is being tested by their QA with 1048576.
>> Fedora, Ubuntu, NixOS, and Arch distros went with value 1048576.
>>
>> Is it worth sending a patch with the default raised to 1048576?
>>
>>
>>> With jemalloc() that seems strange, perhaps buggy behaviour?
>>
>> Good question. In case of BIND DNS server, jemalloc handles mmap() and=
 we
>> keep statistics about bytes requested from malloc().
>>
>> When we hit max_map_count limit the
>> (sum of not-yet-freed malloc(size)) / (vm.max_map_count)
>> gives average size of mmaped block ~ 100 k.
>>
>> Is 100 k way too low / does it indicate a bug? It does not seem terrib=
le to
>> me - the application is handling ~ 100-1500 B packets at rate somewher=
e
>> between 10-200 k packets per second so it's expected it does lots of s=
mall
>> short lived allocations.
>>
>> A complicating factor is that the process itself does not see the curr=
ent
>> counter value (unless BPF is involved) so it's hard to monitor this un=
til
>> the limit is hit.
>=20
> Can you get us a dump of the /proc/<pid>/maps? It'd be interesting to s=
ee how
> exactly you're hitting this.

I have immediately available only a coredump from hitting the default=20
limit. GDB apparently does not show these regions in "info proc=20
mappings", but I was able to extract section addresses from the coredump:
https://users.isc.org/~pspacek/sf1717/elf-sections.csv

Distribution of section sizes and their count in format "size,count" is=20
here:
https://users.isc.org/~pspacek/sf1717/sizes.csv

If you want to see some cumulative stats they are as OpenDocument here:
https://users.isc.org/~pspacek/sf1717/sizes.ods

 From a quick glance it is obvious that single-page blocks eat most of=20
the quota.

I don't know if it is a bug or just memory fragmentation caused by a=20
long-running server application.

I can try to get data from production system to you next week if needed.

--=20
Petr =C5=A0pa=C4=8Dek
Internet Systems Consortium

