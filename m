Return-Path: <linux-kernel+bounces-308950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F26C966431
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CA91C238F0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1D491B2527;
	Fri, 30 Aug 2024 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b="WSWjE2X8";
	dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b="SPM44f6I"
Received: from mx.pao1.isc.org (mx.pao1.isc.org [149.20.2.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F801B2531
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=149.20.2.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725028120; cv=pass; b=G8bwLUtiK2UlXZzZBMlNfbqLgjy9IUM+nxv0W7julEecUIR/UZamuYfJhOBNx3q23wSsovSfILzJUAMNZ2q3HdY2Hh3u6Fb5zntsKxjKWVgBTRhLW1rYlRvCw1GU+eWmFfJgGO2ul39+knZVT7OHgi0EkxFEhol2DVvrx4c5FEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725028120; c=relaxed/simple;
	bh=/ILRz/sbzBXx8EarrpEVduwlKPUD3+YAi34o+nsEZCE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JyZ3ScH9ZuowbY2M05aQ/LT5s6c6cahMCpOuNBuvjSFAUg5EKLWVpWdKMWEDMUirQ1uF0iQmZ1ZqnYhoWNqjOCsTyhb9spIagr0Y8IFF/PhC9vwc16HToJFtbgtMc1TCzJFhYALuCKjhTXcrI9+SbNR3kIJuxmbqaGQxIm21bYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isc.org; spf=pass smtp.mailfrom=isc.org; dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b=WSWjE2X8; dkim=pass (1024-bit key) header.d=isc.org header.i=@isc.org header.b=SPM44f6I; arc=pass smtp.client-ip=149.20.2.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isc.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isc.org
Received: from zimbrang.isc.org (zimbrang.isc.org [149.20.2.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mx.pao1.isc.org (Postfix) with ESMTPS id 0AD833AB28F;
	Fri, 30 Aug 2024 14:28:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.0.0 mx.pao1.isc.org 0AD833AB28F
Authentication-Results: mx.pao1.isc.org; arc=none smtp.remote-ip=149.20.2.31
ARC-Seal: i=1; a=rsa-sha256; d=isc.org; s=ostpay; t=1725028116; cv=none; b=fTOoWjm57R9oVg+63yie7UjHloHxHmQM7Fk8JDeNRd4hS4DZTKdjdjsHq8zNkdJ2/+h4sbFXAL5IeJcH3yrrhp6utpFKZ6PkAhSy0ToTNr9Otioz7dXaq/GSt66u8uJ8zMPBC6QFJ24mtGP/mhlgvy7vV/1ae3rqbiRZKGinevY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=isc.org; s=ostpay; t=1725028116;
	c=relaxed/relaxed; bh=/ILRz/sbzBXx8EarrpEVduwlKPUD3+YAi34o+nsEZCE=;
	h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:From:
	 Subject:To; b=mYjPiJcU1YkbLTusXRmZeg3bRZ2yJaa6EFunVRa3EEkxTSOPPEzXr3kdBdqHZyus9JrC39Ql8HOlmYr0XrHwvwXTgSilIoKYZh/hz+bpuCzjdLf5OW2J4Hj7o8y9lAgevDEEOwhwJB4YPCIXlNX6+frXEbDkKZG1UcNIUbId2Rc=
ARC-Authentication-Results: i=1; mx.pao1.isc.org
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.pao1.isc.org 0AD833AB28F
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=isc.org; s=ostpay;
	t=1725028116; bh=/ILRz/sbzBXx8EarrpEVduwlKPUD3+YAi34o+nsEZCE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=WSWjE2X8XzEfRmlKTp3LLy6ksaG9EI5ipEwBM9ku9dlH2ovrwr+LGErYDfXlRXdR3
	 wn5R48wd6Ed7HbQrELeDzOQoWpOxAIsC+bfSFBzWv3p2UOcZ0w2rlZ3UkOgcYBzNQu
	 VcZjC4FN9Cl4fMeMTNcLHRE6pc7LYJGxOCWb8KWg=
Received: from zimbrang.isc.org (localhost.localdomain [127.0.0.1])
	by zimbrang.isc.org (Postfix) with ESMTPS id 0436F110C7C4;
	Fri, 30 Aug 2024 14:28:36 +0000 (UTC)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbrang.isc.org (Postfix) with ESMTP id D45C9110C7C2;
	Fri, 30 Aug 2024 14:28:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbrang.isc.org D45C9110C7C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=isc.org;
	s=05DFB016-56A2-11EB-AEC0-15368D323330; t=1725028115;
	bh=/ILRz/sbzBXx8EarrpEVduwlKPUD3+YAi34o+nsEZCE=;
	h=Message-ID:Date:MIME-Version:From:To;
	b=SPM44f6I7OVrJa39LUJbktmU1arrhwAw2iqlsCdE9TP4PmrCXsxuDCx1vfh+WXPUq
	 /zN3UTLwC9y83v7qEwH+JbXofvvJJLZctYoR8J5VIqZ5gxcQvPAee5hjyRp8xpYjAp
	 D1eTmle61tPdCmNWmfvbQ9o1t3Y/V3oMmJWJGLns=
Received: from zimbrang.isc.org ([127.0.0.1])
 by localhost (zimbrang.isc.org [127.0.0.1]) (amavis, port 10026) with ESMTP
 id 1J5A0oOisKk8; Fri, 30 Aug 2024 14:28:35 +0000 (UTC)
Received: from [149.20.5.121] (unknown [149.20.5.121])
	by zimbrang.isc.org (Postfix) with ESMTPSA id D2066110C693;
	Fri, 30 Aug 2024 14:28:34 +0000 (UTC)
Message-ID: <5dca8600-0352-4b5b-acb0-0cd4f84733f4@isc.org>
Date: Fri, 30 Aug 2024 16:28:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?B?UGV0ciDFoHBhxI1law==?= <pspacek@isc.org>
Subject: Re: [PATCH RFC] mm: mmap: Change DEFAULT_MAX_MAP_COUNT to INT_MAX
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Vlastimil Babka <vbabka@suse.cz>, Liam Howlett <liam.howlett@oracle.com>
References: <20240830095636.572947-1-pspacek@isc.org>
 <90f07fec-3f46-4b38-86fd-07c9f8201904@lucifer.local>
 <82960a7e-9013-475e-9b80-7b29a5667482@lucifer.local>
Content-Language: en-US
Autocrypt: addr=pspacek@isc.org; keydata=
 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
In-Reply-To: <82960a7e-9013-475e-9b80-7b29a5667482@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 30. 08. 24 14:01, Lorenzo Stoakes wrote:
> On Fri, Aug 30, 2024 at 12:41:37PM GMT, Lorenzo Stoakes wrote:
>> On Fri, Aug 30, 2024 at 11:56:36AM GMT, Petr Spacek wrote:
>>> From: Petr Spacek <pspacek@isc.org>
>>>
>>> Raise default sysctl vm.max_map_count to INT_MAX, which effectively
>>> disables the limit for all sane purposes. The sysctl is kept around i=
n
>>> case there is some use-case for this limit.

[snip]

>> NACK.
>=20
> Sorry this may have come off as more hostile than intended... we are
> welcoming of patches, promise :)

[snip]

Understood. The RFC in the subject was honest - and we are having the=20
discussion now, so all's good!

I also apologize for not Ccing the right people. This is my first patch=20
here and I'm still trying to grasp the process.


> It is only because we want to be _super_ careful about things like this
> that can have potentially problematic impact if you have a buggy progra=
m
> that allocates too many VMAs.

Now I understand your concern. From the docs and code comments I've seen=20
it was not clear that the limit serves _another_ purpose than mere=20
compatibility shim for old ELF tools.

> It is a NACK, but it's a NACK because of the limit being so high.
>=20
> With steam I believe it is a product of how it performs allocations, an=
d
> unfortunately this causes it to allocate quite a bit more than you woul=
d
> expect.

FTR select non-game applications:

ElasticSearch and OpenSearch insist on at least 262144.
DNS server BIND 9.18.28 linked to jemalloc 5.2.1 was observed with usage=20
around 700000.
OpenJDK GC sometimes weeps about values < 737280.
SAP docs I was able to access use 1000000.
MariaDB is being tested by their QA with 1048576.
Fedora, Ubuntu, NixOS, and Arch distros went with value 1048576.

Is it worth sending a patch with the default raised to 1048576?


> With jemalloc() that seems strange, perhaps buggy behaviour?

Good question. In case of BIND DNS server, jemalloc handles mmap() and=20
we keep statistics about bytes requested from malloc().

When we hit max_map_count limit the
(sum of not-yet-freed malloc(size)) / (vm.max_map_count)
gives average size of mmaped block ~ 100 k.

Is 100 k way too low / does it indicate a bug? It does not seem terrible=20
to me - the application is handling ~ 100-1500 B packets at rate=20
somewhere between 10-200 k packets per second so it's expected it does=20
lots of small short lived allocations.

A complicating factor is that the process itself does not see the=20
current counter value (unless BPF is involved) so it's hard to monitor=20
this until the limit is hit.

> It may be reasonable to adjust the default limit higher, and I'm not
> opposed to that, but it might be tricky to find a level that is sensibl=
e
> across all arches including ones with significantly smaller memory
> availability.

Hmm... Thinking aloud:

Are VMA sizes included in cgroup v2 memory accounting? Maybe the safety=20
limit can be handled there?


If sizing based on available memory is a concern then a fixed value is=20
probably already wrong? I mean, current boxes range from dozen MB to 512=20
GB of RAM.

For a box with 16 MB of RAM we get ~ 16M/(sizeof ~ 184) =3D 91 180 VMAs t=
o=20
fill RAM, and the current limit is 65 530 _per process_.

Threat model which allows attacker to attacker mmap() but not fork()=20
seems theoretical to me. I.e. an insane (or rogue) application can eat up=
 to
(max # of processes) * (max_map_count) * (sizeof VMA)
bytes of memory, not just
max_map_count * (sizeof VMA)
we were talking about before.

Apologies for having more questions than answers. I'm trying to=20
understand what purpose the limit serves and if we can improve user=20
experience.

Thank you for patience and have a great weekend!

--=20
Petr =C5=A0pa=C4=8Dek
Internet Systems Consortium

