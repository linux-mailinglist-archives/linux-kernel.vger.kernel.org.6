Return-Path: <linux-kernel+bounces-268214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 662969421CA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 22:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 855891C2403C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 20:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2961118FDDF;
	Tue, 30 Jul 2024 20:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Gjp+hkHn"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A01818DF62
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722372131; cv=none; b=BE0BK6ISEJmIkAzlFS+AFlTFXaFK1rIVk2F9geF3Lc4hXtzXffCidLDqBs7FvIhTDeSX2eqU6RjBXMsyt/78IGwas8GgeBeYcy3aXYlCg8ugx2NGwWe2T/nK8a2dnQbvjb1cDlz/IMJDiU3swPM3mvYEmsf6irAm3i4kI9vwh0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722372131; c=relaxed/simple;
	bh=SeJUJSRj1A5h20HzHOqQaZ16XgUf+3Alvj7rMvDzVG4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=BCEi5lV/C7SR/BxTrG9KRiHKEDSGu07b3qrnzKt5t6zz5v7ZPENZGWaBkfEcLJ8pNYf7V+fYH2v+YrUR3JdOcBOHwumjcO293YjdvbI0QR5A03qoovH01MQiGJj99Hv1nD6Y6yaHWYDVfaOSIFB17OQBPWugy0VFUnKm4nuDtPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Gjp+hkHn; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a2ffc34722so505118a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722372127; x=1722976927; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQDSUf9qVf6rrSdyp/WjPyLLR10PpkvNhtYgC4dx4JI=;
        b=Gjp+hkHnRI0ZfePG7c7NYbnoOTyhDB7W8q7SSOSMV+K4tVlyZCpm/ef2wXrWMR5wQf
         pr+LvjJivRzWV6EYVcb1WK95SNemLpQif+wzfxmjvnUg3PQuvO4JCL5lUt2hY9KZw6Iq
         k8z80qF0LHk7dhHjZYFHNqLUgHsorolZfnN0Ym40ufl9Dc//Epvewj0f4CtWfSgw8PJl
         i+73SB9WeIwrbLF0kvunnu1R5LULt4e847BtZEgLiIZ32njvvV3NeQT4V2I5ENV/mEAN
         MMD+6HJhdOxQ7MqoK2imekmcqEvWvviZ6h9XCHepjy+BpU3KfL8UMq3tfl/hf9aIlyVB
         npyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722372127; x=1722976927;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQDSUf9qVf6rrSdyp/WjPyLLR10PpkvNhtYgC4dx4JI=;
        b=HB2q5lSE5i7skFsURmuOe+Xu05Ky+p17R1DMKGMVsD6PbpdU1OHF13gdPQ0MHTYhw3
         ScQxvCuuPseQvIa6pwtM7IaOvbDvuQIV9e3XJgM7VM8rKswb8aEZkLsEs77uYkwym+ti
         EucMq2W+RDbzsYbviUInL81pMwB1ZjqX/XoqN9f8z3tL5qqTHmdA1/wXbklGsExTwG9G
         dzI3exGxGS/bgOrtEsmy3MZqjp0pwduYuVH2qrfvnnbiS/1qP7+bKeBlz0jwZutOvKq7
         Ouh4CHRD1F22ZhJF2dkWit4P+9v355MutfqvkFF57eS+y0/gmoh1BSOQ+PdQP30Qez8f
         kzGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUm9L3AlmxIMC4stPNoX1q1MJxqCUQh+yqlMl9SfQmjaYF1Y7oIiwQM4i4w+ZIAFmyoawPIBnvwHhbnhQ+2yxdZ3Q0dAThQBAZQ/oyd
X-Gm-Message-State: AOJu0Yw11fP5sdjHEAOPAO92lEr3BXr0A8UGkkEQTPgQ3u57Ai+HiIke
	9k5fYvmciX/ayjgBItRRn3EQo+/5+6+J7GqNlka2lG1iWI7nfKWMtaxOvrjs8x0=
X-Google-Smtp-Source: AGHT+IEk3gBXb0BChOHPjZjDPNI7/jDNPJae5VrxXQC2xMV26ISbNd7bgMEaF0jYXSvxGPO0N6weKg==
X-Received: by 2002:a50:8d5c:0:b0:5b4:ec9d:d66a with SMTP id 4fb4d7f45d1cf-5b4ec9ddc0bmr2108402a12.15.1722372127127;
        Tue, 30 Jul 2024 13:42:07 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:10b5:fc01:4198:a192:529f:265d])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63d4724csm7594657a12.48.2024.07.30.13.42.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2024 13:42:06 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v2] ext4: Annotate struct ext4_xattr_inode_array with
 __counted_by()
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <d4362976-ac3d-4236-a213-666a42560dfe@embeddedor.com>
Date: Tue, 30 Jul 2024 22:41:55 +0200
Cc: tytso@mit.edu,
 adilger.kernel@dilger.ca,
 kees@kernel.org,
 gustavoars@kernel.org,
 linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C3E47BC-37AA-49BF-BEDB-C2A45F2D564E@toblux.com>
References: <20240730172301.231867-4-thorsten.blum@toblux.com>
 <d4362976-ac3d-4236-a213-666a42560dfe@embeddedor.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
X-Mailer: Apple Mail (2.3774.600.62)

On 30. Jul 2024, at 20:12, Gustavo A. R. Silva <gustavo@embeddedor.com> =
wrote:
> On 30/07/24 11:23, Thorsten Blum wrote:
>> Add the __counted_by compiler attribute to the flexible array member
>> inodes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
>> CONFIG_FORTIFY_SOURCE.
>> Remove the now obsolete comment on the count field.
>> Refactor ext4_expand_inode_array() by assigning count before copying =
any
>> data using memcpy(). Copy only the inodes array instead of the whole
>> struct because count has been set explicitly.
>> Use struct_size() and struct_size_t() instead of offsetof().
>> Change the data type of the local variable count to unsigned int to
>> match the struct's count data type.
>> Compile-tested only.
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>> ---
>> Changes in v2:
>> - Adjust ext4_expand_inode_array() as suggested by Gustavo A. R. =
Silva
>> - Use struct_size() and struct_size_t() instead of offsetof()
>> - Link to v1: =
https://lore.kernel.org/linux-kernel/20240729110454.346918-3-thorsten.blum=
@toblux.com/
>> ---
>>  fs/ext4/xattr.c | 20 +++++++++-----------
>>  fs/ext4/xattr.h |  4 ++--
>>  2 files changed, 11 insertions(+), 13 deletions(-)
>> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
>> index 46ce2f21fef9..b27543587103 100644
>> --- a/fs/ext4/xattr.c
>> +++ b/fs/ext4/xattr.c
>> @@ -2879,11 +2879,10 @@ ext4_expand_inode_array(struct =
ext4_xattr_inode_array **ea_inode_array,
>>   if (*ea_inode_array =3D=3D NULL) {
>>   /*
>>   * Start with 15 inodes, so it fits into a power-of-two size.
>> - * If *ea_inode_array is NULL, this is essentially offsetof()
>>   */
>>   (*ea_inode_array) =3D
>> - kmalloc(offsetof(struct ext4_xattr_inode_array,
>> - inodes[EIA_MASK]),
>> + kmalloc(struct_size_t(struct ext4_xattr_inode_array,
>> +      inodes, EIA_MASK),
>=20
> As Kees previously commented, you can use struct_size() here.
>=20
>>   GFP_NOFS);
>>   if (*ea_inode_array =3D=3D NULL)
>>   return -ENOMEM;
>> @@ -2891,17 +2890,16 @@ ext4_expand_inode_array(struct =
ext4_xattr_inode_array **ea_inode_array,
>>   } else if (((*ea_inode_array)->count & EIA_MASK) =3D=3D EIA_MASK) {
>>   /* expand the array once all 15 + n * 16 slots are full */
>>   struct ext4_xattr_inode_array *new_array =3D NULL;
>> - int count =3D (*ea_inode_array)->count;
>> + unsigned int count =3D (*ea_inode_array)->count;
>=20
> It seems `count` is not actually needed anymore.
>=20
> If you remove it and directly use `(*ea_inode_array)->count` in the =
following
> call to `kmalloc()`, you could use `struct_size()` in the call to =
`memcpy()`
> below, and copy the whole thing in one line. See below.
>=20
>>  - /* if new_array is NULL, this is essentially offsetof() */
>> - new_array =3D kmalloc(
>> - offsetof(struct ext4_xattr_inode_array,
>> - inodes[count + EIA_INCR]),
>> - GFP_NOFS);
>> + new_array =3D kmalloc(struct_size(*ea_inode_array, inodes,
>> + count + EIA_INCR),
>> +    GFP_NOFS);
>>   if (new_array =3D=3D NULL)
>>   return -ENOMEM;
>> - memcpy(new_array, *ea_inode_array,
>> -       offsetof(struct ext4_xattr_inode_array, inodes[count]));
>> + new_array->count =3D count;
>> + memcpy(new_array->inodes, (*ea_inode_array)->inodes,
>> +       count * sizeof(struct inode *));
>=20
> memcpy(new_array, *ea_inode_array, struct_size(new_array, inodes, =
(*ea_inode_array)->count));
>=20
>>   kfree(*ea_inode_array);
>>   *ea_inode_array =3D new_array;
>>   }
>=20
> Also, you are missing one more like just below this one, where =
`(*ea_inode_array)->count`
> is currently being used to directly index `inodes`:
>=20
> (*ea_inode_array)->inodes[(*ea_inode_array)->count++] =3D inode;

Thanks, I missed this one.

Thorsten=

