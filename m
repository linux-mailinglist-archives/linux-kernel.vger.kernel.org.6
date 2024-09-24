Return-Path: <linux-kernel+bounces-337617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AD8984C7B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 922D61F2492D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D00513CA8A;
	Tue, 24 Sep 2024 20:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lsLbBMuC"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3785512FF72
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727211431; cv=none; b=LuEmDPBDMJ6sjDYCgCYy7qdyRrISYTp/nk8y5fAnwfs4h3MhqRpPQ1f6cEW+PF9OFdkRl4PiAoEEjmcte54K4ouwKRQdpuTBXpph2A3/yZv0eI1nxCh1/3gjJYgXbzUz8x8ccNpkpY89IuW604DYY3mW0yjJKV65dSUEE6s3Tb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727211431; c=relaxed/simple;
	bh=UaKB8Un+Q1vwKe8+AS7CMQ4fzALGIusOYY+CofvVRPc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pKPPUyyvjdJHL3UxREtRXIRtJIVoM0BH6Vb5FP2RVXxjH04HsqnAv9/g3Sd8lzOUeaGrKt+EJDIvRV78TyS2YsLAOkXwSen7+m1VXzzX9GR9rgbqIDnxhxE8dwgtZGqUiGfY66CBVMR/YQ6b66bPlpNdz8Vx8JaF5qeYoNfvQD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lsLbBMuC; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1727211426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=so/tx8p9gJQk2GUcGb8sLZGfdc/Csod3rlNxGWYEDS8=;
	b=lsLbBMuCapcqI3qPYQlf8h426A5YYPDPQ4raIm0wVRYA8CM3u/54gqpysJMY9LkTIyqENc
	JfULAlZEim6YAD134MF5ambObR6DJzml2LqE+1uPqzk9AOmUfIyjEdvdceeu/vs5sv7NU5
	iH3XgioIKw9/+D1Ww51viINHzFdiovU=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH] ksmbd: Annotate struct copychunk_ioctl_req with
 __counted_by_le()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <C22D945F-4C40-4C0E-8074-07747C944C99@linux.dev>
Date: Tue, 24 Sep 2024 22:56:50 +0200
Cc: Namjae Jeon <linkinjeon@kernel.org>,
 Steve French <sfrench@samba.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Kees Cook <kees@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 linux-cifs@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4B489C2C-5463-4776-8182-F878BAD1754A@linux.dev>
References: <20240924102243.239811-2-thorsten.blum@linux.dev>
 <d6341fc4-1d9d-46af-b809-f30430b30455@talpey.com>
 <C22D945F-4C40-4C0E-8074-07747C944C99@linux.dev>
To: Tom Talpey <tom@talpey.com>
X-Migadu-Flow: FLOW_OUT

On 24. Sep 2024, at 21:33, Thorsten Blum <thorsten.blum@linux.dev> =
wrote:
>> On 24. Sep 2024, at 20:05, Tom Talpey <tom@talpey.com> wrote:
>> On 9/24/2024 6:22 AM, Thorsten Blum wrote:
>>> Add the __counted_by_le compiler attribute to the flexible array =
member
>>> Chunks to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>>> CONFIG_FORTIFY_SOURCE.
>>> Read Chunks[0] after checking that ChunkCount is not 0.
>>> Compile-tested only.
>>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>>> ---
>>> fs/smb/server/smb2pdu.c | 2 +-
>>> fs/smb/server/smb2pdu.h | 2 +-
>>> 2 files changed, 2 insertions(+), 2 deletions(-)
>>> diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
>>> index 461c4fc682ac..0670bdf3e167 100644
>>> --- a/fs/smb/server/smb2pdu.c
>>> +++ b/fs/smb/server/smb2pdu.c
>>> @@ -7565,7 +7565,6 @@ static int fsctl_copychunk(struct ksmbd_work =
*work,
>>>  ci_rsp->TotalBytesWritten =3D
>>>  cpu_to_le32(ksmbd_server_side_copy_max_total_size());
>>> - chunks =3D (struct srv_copychunk *)&ci_req->Chunks[0];
>>>  chunk_count =3D le32_to_cpu(ci_req->ChunkCount);
>>>  if (chunk_count =3D=3D 0)
>>>  goto out;
>>> @@ -7579,6 +7578,7 @@ static int fsctl_copychunk(struct ksmbd_work =
*work,
>>>  return -EINVAL;
>>>  }
>>> + chunks =3D (struct srv_copychunk *)&ci_req->Chunks[0];
>>>  for (i =3D 0; i < chunk_count; i++) {
>>>  if (le32_to_cpu(chunks[i].Length) =3D=3D 0 ||
>>>     le32_to_cpu(chunks[i].Length) > =
ksmbd_server_side_copy_max_chunk_size())
>>> diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
>>> index 73aff20e22d0..f01121dbf358 100644
>>> --- a/fs/smb/server/smb2pdu.h
>>> +++ b/fs/smb/server/smb2pdu.h
>>> @@ -194,7 +194,7 @@ struct copychunk_ioctl_req {
>>>  __le64 ResumeKey[3];
>>>  __le32 ChunkCount;
>>>  __le32 Reserved;
>>> - __u8 Chunks[]; /* array of srv_copychunk */
>>> + __u8 Chunks[] __counted_by_le(ChunkCount); /* array of =
srv_copychunk */
>>> } __packed;
>>>=20
>>=20
>> This isn't correct. The u8 is just a raw buffer, copychunk structs =
are
>> marshaled into it, and they're 24 bytes each.
>=20
> Hm, I see.
>=20
> How does this for-loop work then? It iterates over ci_req->ChunkCount
> and expects a srv_copychunk at each ci_req->Chunks[i]?
>=20
> for (i =3D 0; i < chunk_count; i++) {
> if (le32_to_cpu(chunks[i].Length) =3D=3D 0 ||
>     le32_to_cpu(chunks[i].Length) > =
ksmbd_server_side_copy_max_chunk_size())
> break;
> total_size_written +=3D le32_to_cpu(chunks[i].Length);
> }

Never mind, I just realized that the pointer arithmetic takes the array
offset into account.

A srv_copychunk takes up 24 bytes and therefore 24 __u8[] slots. The
__counted_by annotation is essentially off by a factor of 24.

Thanks,
Thorsten=

