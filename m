Return-Path: <linux-kernel+bounces-553121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A36A58424
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 13:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCF487A51AD
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 12:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CCE1D61B9;
	Sun,  9 Mar 2025 12:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJM3u6CX"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E71740849;
	Sun,  9 Mar 2025 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741524681; cv=none; b=IVF3iAtUtqzVIvJCAB14jmmcg6pyhCBydZvGNddLRfeiNSyHPLQoFUZeY15s0S/N6UAafZtH8LI+1guJu5a3iXZ3KMeC1X3C/YnDf9ANppmKyNY+N++lCRElsC5YUEcVYzopT5Qha0rc0fmDuwfO39LDyNsEWlNGA2juaA6ltDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741524681; c=relaxed/simple;
	bh=+Iz1/STkZsl6Qt0No+jbhF8zFhsRbcGfp/VaE+EiszQ=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=sRn0/cHpFsVq7C9+ikkmGC+lofvxQAndFcgnkPdVpTuHb2tJpvO+gN2LKLxLbLuzfrb5NmT6c/taKHtzfrn9w6c8q0KbGLKxFPkVH/+fVUgSTnsZ9GKDecY/YV+OInGgnzfUijy5JEN+9RyHMe+mqDEukk91/cHzxNTFEZdFjJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJM3u6CX; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5b56fc863so4616910a12.3;
        Sun, 09 Mar 2025 05:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741524676; x=1742129476; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=juHFm7Io04+HJg8np5JkFCyDzrtheq4bEz92iaonhGM=;
        b=ZJM3u6CXCwps3lU3xbDdLzLSrG/9UJW0Aw6GZ0YRSm/RPbrBHh6ProvZ4KC229UTNc
         mbw0p2lMzjbfrtdbcs5XPZQPvXTuwMakJBgMLkLvjo3n8jDz5Zgif0fPsLEUyoU2hY2P
         TrmCIMJl4lPIxwhNBLx+Ehh0FpFbdAoYhsLSfbVCAOUqgx8snqmQwLpz7KRDLwKugeRi
         XB0wALVFHfpZrpk9VMC0qkBQEx52iC/beNV6mg/Ejzz3lhMkK/lrw6f5W/L+U5DGtyp2
         zhXJjfLQjBArh5Dy/bBuLo2EF8jCMaV9FoiZRGyONiOZqFabHKXnWPPlryES385EcPvL
         c9hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741524676; x=1742129476;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=juHFm7Io04+HJg8np5JkFCyDzrtheq4bEz92iaonhGM=;
        b=r4SgTgW+D/Qts34Slrar6k8LjDqLbwWfiObYzVPd/0CWheYoVB1Bip7SgoHDUnXhuA
         rxs47yINtCLZ4jx4Oomk8Qkpamm0XYit32y2lmSq7CDjp9ab+7JxzyYxC7KbiI0JQw2K
         OK6HLzCYKmvh01b4xdrOTgmO86YPhGTwEuYNkxQ37sFLIhPGZWf3F38ZkKdUyOBgmr4J
         lyxYVlztiEa95WOxFFBxczuvAWa80O9gNuz2x35cnvuVYldeZCgrDvdbhLQ9vmMswzXn
         QJe/4kHDfY/oxP5juQXkVDrXHp8P+pe06KRpq7Yhtvx3Dad91zUNUh5ms/lWbEXkzBt8
         qVrA==
X-Forwarded-Encrypted: i=1; AJvYcCW6zH0vcGgVMKSwbuaz3bqmrmov/B3dfXq/dq5yfw1m/QJiPIQ4ChFI3tvTdlVgqnxfslBKn5371oLoPwU=@vger.kernel.org, AJvYcCWfWPuY2LHCpc9cAuaJ7FEGPMef+kjBzE9loKWuyI7eX9Ko3iCRe9e476bLzHT/3SDNk3V4VE+d1J/Qi761VtPtLBF+UA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsAJSEI9d6b9Cuu6TNIOfSlKYe8W6dfmVbLKmqCG3y9i+6YXzH
	a7j7f0DEdGNLSx1yDqE88rZCLkCW+i5bW71/dgsH9QT/MtdxlkxcRKybzBcI
X-Gm-Gg: ASbGncuwDtwcbCdgiM3P4m+nCNGU/+gNqs4IIX8JOZzeyoRHxXBMizAubmKHEypQgX+
	YdC/OvWG8wk3cHQJSx4QhyX/7zngCsEtjfDMBl/bQgA6mhazg6dcA/4a7Y5nDoJGDND+skS4fyT
	1jA4IhlcluZRjezo5YYonUhqyjWqjnXJtRGwrIzy3tLw8WpeaLkz+KLLZpw3Om+DnMD5ylrI+g8
	v7zExaKirBsjTu69pPCRJUsSBFCADC75I8h6uAHe3HpgvzZtFhIn/68yFXFiaHxcQF7Kf4r8XZI
	FzDKs0AnXqL+nMDS8pV+/iJxpRHtuokfJhGXsse6aXFhPy1SiNKDmQ6Mg03ok84R9V7wzbI=
X-Google-Smtp-Source: AGHT+IFX/qTtBfk0Mho2kJIlb5qdFgqaWund3g4q5leqWSlItvCEwakE17E5a/P01CaecNdNjqeZTg==
X-Received: by 2002:a17:907:1ca4:b0:abe:cccd:9222 with SMTP id a640c23a62f3a-ac252f3ed45mr1095618166b.54.1741524675729;
        Sun, 09 Mar 2025 05:51:15 -0700 (PDT)
Received: from smtpclient.apple ([109.78.84.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac2399d4877sm586181766b.169.2025.03.09.05.51.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 05:51:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Rayan Margham <rayanmargham4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2 0/3] platform/x86: acer-wmi: Add fan control support
Date: Sun, 9 Mar 2025 12:51:03 +0000
Message-Id: <637B90F3-58C6-43B6-9822-5314C62138C6@gmail.com>
References: <f5d8b82d-c711-4611-b257-b4297f172bb1@gmx.de>
Cc: jlee@suse.com, basak.sb2006@gmail.com, kuurtb@gmail.com,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <f5d8b82d-c711-4611-b257-b4297f172bb1@gmx.de>
To: Armin Wolf <W_Armin@gmx.de>
X-Mailer: iPhone Mail (22B91)

I=E2=80=99m so sorry I=E2=80=99ve been in a mental health unit for the past m=
onth, are you still working on the driver I would love to test anything you p=
rovide me now

Bestest regards
Rayan Margham=20

> On 5 Mar 2025, at 00:24, Armin Wolf <W_Armin@gmx.de> wrote:
>=20
> =EF=BB=BFAm 15.02.25 um 18:45 schrieb Armin Wolf:
>=20
>> This experimental patch series aims to add fan control support to the
>> acer-wmi driver. The patches are compile-tested only and need to be
>> tested on real hardware to verify that they actually work.
>>=20
>> I CCed two users who requested support for this feature. I would be
>> very happy if both of you could test those patches and report back.
>>=20
>> I am ready to help you both with compiling a custom linux kernel for
>> testing this series.
>=20
> Any updates from the two people with Acer hardware?
>=20
> Thanks,
> Armin Wolf
>=20
>> Changes since v2:
>> - remove duplicate include and replace hwmon_pwm_mode with
>>   hwmon_pwm_enable in second patch
>>=20
>> Armin Wolf (3):
>>   platform/x86: acer-wmi: Fix setting of fan behavior
>>   platform/x86: acer-wmi: Add fan control support
>>   platform/x86: acer-wmi: Enable fan control for PH16-72 and PT14-51
>>=20
>>  drivers/platform/x86/acer-wmi.c | 298 +++++++++++++++++++++++++++++---
>>  1 file changed, 273 insertions(+), 25 deletions(-)
>>=20
>> --
>> 2.39.5
>>=20
>>=20

