Return-Path: <linux-kernel+bounces-357354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F82997042
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6898FB2336D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 16:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9981F12F6;
	Wed,  9 Oct 2024 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RmzLyaxN"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86AF1EF95F
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488176; cv=none; b=vFapQS/W7MNTcrOQUW1tLtNQ+ERer/SD6G2+NEIG+x5a15SA4TNv4CKwEV562sjxZ6Qj3qUHXjdJqE9V8/Ubl3r94v1POpeAtZ7trW14Gc/4yEYpR/meJOwg1T5urc+gZ1gAKoO457snDUHt4L94Mroz9Xdvciym+BCLWMe5Oss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488176; c=relaxed/simple;
	bh=t0jsWZVzZQn+sDURCRyRKujF2TOyMfjajxg8xq74q88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AnLyHUa0L1eYbI2M1G26fEOcbq0hgFTM5K0cn6FlE1Jlw9MvKphf5ZCY4aOqF9Do/hHcw/r6f/Q3tADSkCmHJhurMn3JMkCI6QmQLVbfwMtYjOZ8RIfOleZe/HkYxNkhjY1fuzeA8InVmSZuF/yr6s3Qib8B9WLPgweh/tWSlBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RmzLyaxN; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-84fc21ac668so172085241.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728488172; x=1729092972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qhu38DngzJNXLHykf9yFte9ZgoMKMY8LdzsSZdaHnjk=;
        b=RmzLyaxN8sjmApq7cFcKSo1Uaq6ZkYzM6NlPIxyfD0/RdCDtQ13ddThIM6RP20+woc
         jez37ghbj+ugxPTXZtaOAkxNK1EZhGF3PMswEAJnuyzsrRUsiKBTcpD244KjJBvQk1lu
         w6+LQJceWk7N3Gh+xb0on8+M/6X4QY4A0HdUtITtEZgu89DTKyMdwx81SysyzpWBlwMo
         mdXiah6rIZ78AZ3J1quvMBSpj0OjVOKn91fLf+N7pn/OkiOT+Hle6xI+CXaswtTDk1ki
         X7K928R0rHMWEflw1EbVeOjMnEJaHSgXNoL/5xGjVuhLGCc3w9ZVPiMgE1jPZUbrEwzb
         PJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488172; x=1729092972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qhu38DngzJNXLHykf9yFte9ZgoMKMY8LdzsSZdaHnjk=;
        b=L/ztrHbzkoD99l5pwofV1oVPc/dngR4r08EhwnuMsLT5LHM7+7S0Cas35uFsv1XKze
         fSDXh4/sGHlzw9mt9od20WJ6bwT3fugv2FtMR1tpeUBuKRf5o0T59930b7h6JFx5KxuC
         3RqWJUPVRBx2Y6VrV5emyNpFeOsFPONAg6JmvtAFCDb2wIGBXodjYzEiLa2ohfxPvp28
         UPYehsOjwPqMe/XWrSYhhIXPpqnQaz4CScJRuZsBONDGmd6+EqxyjATfR+1tJ9p0PWhd
         ChXwYVCT8uogdtq/L3uuwqIidktj4gE4GM3xrLjs3hIi3f/6ADb/RU/bcn6hF4Bnq4l0
         sTCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKvMPmZ3sTVqU00iYcES9g+9mFV8l1/d7UVWPPC40pY9a6h7AtUnLZ8emqM7kzb9w7pKFtiGacpKAlA2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOOL45Sk7lrx/4FUHsfRY93tU1aJQM6TGB5licbJhgMKCdtrmi
	gdtuVRAW0Tbw1pGzv//0uSK0zuc8Vry90Saq9pxnCuPItMR+5529yWR8TS+T4hBLFlI9M9yMfK6
	vV1PO77KwbcyBePRuupNzo+CINJ0mijqFUtnQ
X-Google-Smtp-Source: AGHT+IGXhNalhdnG3UgTDQ9dAvTj83wJi/06ycVsl8RL3FYNY25jYKWxfxAzxHyvtp+Cq9de5ucgCU67xNjnkIFk4Ug=
X-Received: by 2002:a05:6122:290f:b0:508:1db6:3b5 with SMTP id
 71dfb90a1353d-50cf0c8bb7fmr1934036e0c.13.1728488172555; Wed, 09 Oct 2024
 08:36:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 9 Oct 2024 11:36:01 -0400
Message-ID: <CAHC9VhSyWNKqustrTjA1uUaZa_jA-KjtzpKdJ4ikSUKoi7iV0Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] ima: Remove inode lock
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, 
	jmorris@namei.org, serge@hallyn.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, ebpqwerty472123@gmail.com, 
	Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 12:57=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Move out the mutex in the ima_iint_cache structure to a new structure
> called ima_iint_cache_lock, so that a lock can be taken regardless of
> whether or not inode integrity metadata are stored in the inode.
>
> Introduce ima_inode_security() to simplify accessing the new structure in
> the inode security blob.
>
> Move the mutex initialization and annotation in the new function
> ima_inode_alloc_security() and introduce ima_iint_lock() and
> ima_iint_unlock() to respectively lock and unlock the mutex.
>
> Finally, expand the critical region in process_measurement() guarded by
> iint->mutex up to where the inode was locked, use only one iint lock in
> __ima_inode_hash(), since the mutex is now in the inode security blob, an=
d
> replace the inode_lock()/inode_unlock() calls in ima_check_last_writer().
>
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  security/integrity/ima/ima.h      | 26 ++++++++---
>  security/integrity/ima/ima_api.c  |  4 +-
>  security/integrity/ima/ima_iint.c | 77 ++++++++++++++++++++++++++-----
>  security/integrity/ima/ima_main.c | 39 +++++++---------
>  4 files changed, 104 insertions(+), 42 deletions(-)

I'm not an IMA expert, but it looks reasonable to me, although
shouldn't this carry a stable CC in the patch metadata?

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

