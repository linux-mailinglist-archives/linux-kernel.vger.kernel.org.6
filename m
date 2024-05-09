Return-Path: <linux-kernel+bounces-174226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8E18C0BD7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 09:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C174AB22624
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 07:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350A613C9A4;
	Thu,  9 May 2024 07:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gdb0OgJO"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2275D12FF99
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 07:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715238113; cv=none; b=XjFCPhbp1IpGN1Q5QB+acNJFmA27D7i2yD5b1ChVmNVUDkCZ+iPK+Zl8wnS0uiGYGHZzJUJarbDaOeBaiMWpC8UIPfL8LiP3ncVSn8DAPGVNExJzo5V+pB7VKsoaDiFE69I1VWv9iVFzsz/zCOYo68u4Y7XGWzyyRhPRzJZaI1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715238113; c=relaxed/simple;
	bh=R/YwftwUnrsnD2ekPwpf6DG41P3dbIZt6arqycGLRs0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rR7A5R6iDgh9MwUpx+SGZmlAXmmGXsI/nGpDKt22JetVOn16eskswFlCxDZn/p071R+cBagqr9jEu1HgZn587oFGFgnwJ3jMFNtnM0hYkxea03GE79C7nGqKc82Jj5mmvnGiCgR4hbY8q9x55EahhXc1JWDGBaiG+q3zQeNmYhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gdb0OgJO; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2db101c11beso7455911fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 00:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1715238109; x=1715842909; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e41S4BwwMsWXaNjFvLtDtQWWdZXnGXjA1B5HEHxantk=;
        b=gdb0OgJOuJFGRDaLsCqOVeLfakNxtHcd0r3Ghc8IgdMPciMJIdI0sv3N7jib6kI0cv
         G6p30Q0SQ92Q3UK1BC1daPxgZRRYWWwCBRgXQjbxxjhWSTBE4e14c+jZoOmfSnKWh4yv
         /156jZd9fey3+a54oe5fA0ndsaiVg/8eDCa3ldDC13SIf8jWfbGNfwzmvlxg6ySykn5m
         sAqvRtcSPDxTwoUEXzW+TygonQH+gMJoG2JpDnTy0aYaf5G2VfVjeTf/p+K4xrShX9Mb
         O3YD2FGiQcUN2KgMyXT4hngiiFdBDVc/8IIrozGdVeQ951ue3N6BGpBU13++MWYKm1x4
         6Ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715238109; x=1715842909;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e41S4BwwMsWXaNjFvLtDtQWWdZXnGXjA1B5HEHxantk=;
        b=tGxbFZBVqzBTLBJpDWe2za3ayBIgr0dTP+D0SQLu10sRImAwfC+SEc3EApIRPCUCz5
         aLWbSPIvkfU/ihA98SegT2RGR0Ixrd/R1CrY5AYW1ULXQpWKo/lK8HUfK6N1Zlq4KYHN
         JocbSqeCWN2V2kRSpuVAhB6de8MkPZAaBk5HyH1BuXo3EyY4W7E8X/P5C5Hyq89D0gOD
         Ixh0VrUhcqWmdPyqc7xm1QYnQQ++UywA29hmFWD94LTafAq9ctJAvEM3i1hdkK0+gA7g
         lJdYCGzn1B7mkpDjGzCHTTJSUUBCpVrL/YSCnq0tH9o65Fvojqh33t+kRqylF1tyf5SG
         QbVA==
X-Forwarded-Encrypted: i=1; AJvYcCVKCotbGb7sj03SCDUlYc4GcAWSdzTXjgQVz0M/GUG0NkA+kmSOO+tGZVxJB/esK6N/82gqZuYd7Fh4xc9DvSTsCKYKylAUOaS3OJQz
X-Gm-Message-State: AOJu0YxLG81ot9821ulK6cGl8ELmqjLyBwsyZZqE72znz78IlUQYlCQL
	ooJH9HxfZzWXThkBCf3i8PuK2s6Blu2cgBrNXsG8phMrebNZ2Ng7vhAATB38HBQ=
X-Google-Smtp-Source: AGHT+IF2AYdO2e2kYJO5GoNt5HNgyNTtGqKIN6Haiic+0Yqn/wneiyEuaP3ZswRhhyD8HSCkHjA/qg==
X-Received: by 2002:a2e:b60a:0:b0:2de:7046:b8f8 with SMTP id 38308e7fff4ca-2e446d86159mr31015791fa.5.1715238109246;
        Thu, 09 May 2024 00:01:49 -0700 (PDT)
Received: from smtpclient.apple ([23.247.139.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b671783519sm705720a91.57.2024.05.09.00.01.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 May 2024 00:01:48 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v3 1/1] bcachefs: Move BCACHEFS_STATFS_MAGIC value to UAPI
 magic.h
From: Glass Su <glass.su@suse.com>
In-Reply-To: <20240509061718.GA231218@pevik>
Date: Thu, 9 May 2024 15:01:33 +0800
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
 linux-bcachefs@vger.kernel.org,
 Su Yue <l@damenly.org>,
 Brian Foster <bfoster@redhat.com>,
 Coly Li <colyli@suse.de>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <37665ED1-9929-444F-B9A0-3CC7EADBC064@suse.com>
References: <20240507153757.150891-1-pvorel@suse.cz>
 <6D9FCB08-480D-4CA0-82E2-284B1F2BF8FD@suse.com>
 <20240508211759.GA209026@pevik>
 <fg3cvwvadldeglwrqdeeglswxwupyy2cjki7si7sz3jwsrpzpf@5pkugq7jyzb2>
 <20240509061718.GA231218@pevik>
To: Petr Vorel <pvorel@suse.cz>
X-Mailer: Apple Mail (2.3774.500.171.1.1)



> On May 9, 2024, at 14:17, Petr Vorel <pvorel@suse.cz> wrote:
>=20
> Hi Kent,
>=20
>> On Wed, May 08, 2024 at 11:17:59PM +0200, Petr Vorel wrote:
>>> Hi Su, Kent,
>=20
>>>>> On May 7, 2024, at 23:37, Petr Vorel <pvorel@suse.cz> wrote:
>=20
>>>>> Move BCACHEFS_STATFS_MAGIC value to UAPI <linux/magic.h> under
>>>>> BCACHEFS_SUPER_MAGIC definition (use common approach for name) and =
reuse the
>>>>> definition in bcachefs_format.h BCACHEFS_STATFS_MAGIC.
>=20
>>>>> There are other bcachefs magic definitions: BCACHE_MAGIC, =
BCHFS_MAGIC,
>>>>> which use UUID_INIT() and are used only in libbcachefs. Therefore =
move
>>>>> only BCACHEFS_STATFS_MAGIC value, which can be used outside of
>>>>> libbcachefs for f_type field in struct statfs in statfs() or =
fstatfs().
>=20
>>>>> Suggested-by: Su Yue <l@damenly.org>
>=20
>>>> Would you kindly amend it to Su Yue <glass.su@suse.com> or
>>>> Kent can help if the patch is going to be applied.
>=20
>>> Unfortunately Kent was faster, it's already merged without your SUSE =
address
>>> (and your RBT you added in the end):
>=20
>>> =
https://evilpiepirate.org/git/bcachefs.git/commit/?h=3Dfor-next&id=3Dce8f9=
355f23be9756e499682d0d642a741db6c3a
>=20
>>> @Kent: Maybe it can be even now amended (with Su Yue's RBT).
>=20
>> ...sure, make me invalidate my test results :)
>=20
> Thank you! FYI there was also his RBT (Reviewed-by: Su Yue =
<glass.su@suse.com>)
>=20
Thanks both for you Petr and Kent :- )  Sorry for inconvenience due to =
my email quirk...

=E2=80=94=20
Su
> =
https://lore.kernel.org/linux-bcachefs/6D9FCB08-480D-4CA0-82E2-284B1F2BF8F=
D@suse.com/
>=20
> Kind regards,
> Petr
>=20
>>>>> Signed-off-by: Petr Vorel <pvorel@suse.cz>
>>>>> ---
>>>>> Changes v2->v3:
>>>>> * Align tab with other entries.
>>> ...
>>>>> #include <linux/uuid.h>
>>>>> +#include <uapi/linux/magic.h>
>>>>> #include "vstructs.h"
>=20
>>>>> #ifdef __KERNEL__
>>>>> @@ -1275,7 +1276,7 @@ enum bch_compression_opts {
>>>>> UUID_INIT(0xc68573f6, 0x66ce, 0x90a9, \
>>>>> 0xd9, 0x6a, 0x60, 0xcf, 0x80, 0x3d, 0xf7, 0xef)
>=20
>>>>> -#define BCACHEFS_STATFS_MAGIC 0xca451a4e
>>>>> +#define BCACHEFS_STATFS_MAGIC BCACHEFS_SUPER_MAGIC
>=20
>>>>> #define JSET_MAGIC __cpu_to_le64(0x245235c1a3625032ULL)
>>>>> #define BSET_MAGIC __cpu_to_le64(0x90135c78b99e07f5ULL)
>>>>> diff --git a/include/uapi/linux/magic.h =
b/include/uapi/linux/magic.h
>>>>> index 1b40a968ba91..bb575f3ab45e 100644
>>>>> --- a/include/uapi/linux/magic.h
>>>>> +++ b/include/uapi/linux/magic.h
>>>>> @@ -37,6 +37,7 @@
>>>>> #define HOSTFS_SUPER_MAGIC 0x00c0ffee
>>>>> #define OVERLAYFS_SUPER_MAGIC 0x794c7630
>>>>> #define FUSE_SUPER_MAGIC 0x65735546
>>>>> +#define BCACHEFS_SUPER_MAGIC 0xca451a4e
>=20
>>>> IIUC, due to some historical reasons bcachefs used to switched
>>>> ondisk sb magic from BCACHE_MAGIC to BCHFS_MAGIC.
>>>> Other major fses uses  *_SUPER_MAGIC both for ondisk=20
>>>> sb magic, kstatfs::f_type and super_block::s_magic.
>>>> However, for bcacehfs there are three magic numbers.
>=20
>>> Thanks for info. But for struct statfs in statfs() or fstatfs() only =
0xca451a4e
>>> is needed, right? I would not expose the other(s) unless it's really =
needed.
>>> Also we'd need to backport UUID_INIT() into UAPI :(.
>=20
>>>> Anyway, it looks good to me so far:
>>>> Reviewed-by: Su Yue <glass.su@suse.com>=20
>=20
>>> And also without your RBT.
>=20
>>> Kind regards,
>>> Petr
>=20
>>>> =E2=80=94=20
>>>> Su



