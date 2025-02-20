Return-Path: <linux-kernel+bounces-523113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC01FA3D229
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 910533B8E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D081E4937;
	Thu, 20 Feb 2025 07:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJ24PUdd"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005B419AD8D
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740036150; cv=none; b=ptGHFugum7ANt5be0VuW+cgejNKR8SaEqi0B5LNGsfKygvDnqqq5spjE+o+3hdztsNPI0WYW/dgvzH7DZpiQv7Kc7zM9/I+DLfjtfN332El+GYMm7KbPt+e7UWNyouJdW1ZY3qyvuhjPw8TtaAlUivMDFB6uwP2aagl4Vnz2qkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740036150; c=relaxed/simple;
	bh=zrsb17kkEekWilONs567qtMz+pCVr2F+/DpHIyDcdiY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Uysv6cQ1lQ3J8HPxzJC8mVGrzQe+GKoOIJEI6DN1nA2ouVVFT/9TNzhYt3IcZ8OxtrtfvVoB5YBUj1ArMxT/JeMXL07ne3IzubeivkLucEqRjOe5z9lZhhWPPca6U+9qGQHaHRTJ6yRFFZER6c5awhcjqMsUp+30b+CYI4juqbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IJ24PUdd; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fc11834404so982565a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 23:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740036148; x=1740640948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zrsb17kkEekWilONs567qtMz+pCVr2F+/DpHIyDcdiY=;
        b=IJ24PUddunbaHE7X1g2htJlGQ9d2D5jvkZF8fs4ihcAAnmGPtet83EqOtCBXlsFJD7
         KKD9vktKXvMvgZ2FlJRoiHO+j4YMnt64GabY3maYwgaH/ZanGDBUtD/rVLmDah2wTQG9
         PeyC1ELR92g7EmxP1yoK82Y6kB+QIdwkIQaHPormy46gGIXrwos+XI10Lcqze5SLOXSI
         dZqpq4t5GEoRvtfYSaPPdap04MTYAOzq5RsEk0sWiozfRVt7bgpCzXVYKhUkZRRJtEJj
         lnTGyF4/mCqC399Rv4H9Vi3cLT7f9XUmEjs4bbYhCTZ5+wfHxEDicPBILQG4iCj97YVI
         lwHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740036148; x=1740640948;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zrsb17kkEekWilONs567qtMz+pCVr2F+/DpHIyDcdiY=;
        b=lXWmI+9cqJL9nX+r9JXvyvUt6sHeU+wHrkdXbGMKzU54EYKtBZVc/RxbBcHTFpc0Mo
         HRigL+5O1tutTzIftx23+NLgg9Wyr/Puh1nln1q+2nHNVFZmkoUvBmnNoDNxu9Xm8zkb
         6r4bb9uAqAWj6aE9MAL9o7rnj0wkjcQHXavsBe5nIWGLldCvubljmtn4HRHAQRxQwQbb
         WKuNzhsc10hRp/zlkkG7IYnFMCeAuubn6HShZLVRJ/dd88v/hW7C1HyQfkKkDpm+PbSo
         Z0s2IRyLjJfZgXy7nKcK21f60Ay8q6A3qbzau7pimSgkoEMGcJVC7LxHYkZbQGAXLSJv
         DKpw==
X-Forwarded-Encrypted: i=1; AJvYcCXMUgMQKo4kxivCsK0dglOEcIWFgM9I/x+mldmd7LDR8GhD4EEFVl4IgAiTJH1Nmfjd1hQwTzI2Q1VSchE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUIUf629C3CMg7PjzgoadWDaiH6fq5wEu0Y70hwRig3EUI7QU1
	C3EZbCZIHHaXm2L8c3WViwuCTqiMc0+RmQyZJ6VMMVQYsNqHo/7EK76NbQ==
X-Gm-Gg: ASbGncvjp1GPG7yGZVPEmlIIIVbrCuX/HoPjVJ32MErpvFC4Pr7oHKazRdqY7Qf6PBx
	5/z1gK9W68MVnNl2EzoYCCMOqkkAWJ/jWopO+cjslG7TM6oyAObSzZErgsqKW/URoubpgSUC+bd
	ov/oV9HV2j8ZFMtffN0/UR2/JAztDPuhfWaLENhALrX8P4Tw5UC+wTfVmUUTZqIb6Qfv2L2l+sW
	GdgO1YHCFKMA9L2fp94+3JSVIP5sH95oZ3eBprsxQqU9K5PUNxHYecsFgKAu9QiUSFBlS7lMWKJ
	WEmzPFeQfSYS2Rt4GVDqcj4=
X-Google-Smtp-Source: AGHT+IHncCP6wXIG+44d/eTWwBF2w97yHr2QCgigcgnFkdSUFlvxHfNPy4dWEYlqkuedYryqae5xfQ==
X-Received: by 2002:a17:90b:17c1:b0:2f5:88bb:118 with SMTP id 98e67ed59e1d1-2fc41044ffemr27454531a91.22.1740036148044;
        Wed, 19 Feb 2025 23:22:28 -0800 (PST)
Received: from ?IPv6:::1? ([2601:647:5e00:4acd:1571:cf3a:b215:dfab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d534af3asm114901105ad.44.2025.02.19.23.22.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 23:22:27 -0800 (PST)
Date: Wed, 19 Feb 2025 23:22:25 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Dirk Behme <dirk.behme@de.bosch.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_1/2=5D_Revert_=22drivers=3A_core=3A_sy?=
 =?US-ASCII?Q?nchronize_really=5Fprobe=28=29_and_dev=5Fuevent=28=29=22?=
User-Agent: K-9 Mail for Android
In-Reply-To: <2025022051-happy-plant-b40b@gregkh>
References: <20250220064647.2437048-1-dmitry.torokhov@gmail.com> <2025022051-happy-plant-b40b@gregkh>
Message-ID: <9232C7B6-627B-43F9-AD5C-1EA4BB69E40D@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 19, 2025 11:13:00 PM PST, Greg Kroah-Hartman <gregkh@linuxfound=
ation=2Eorg> wrote:
>On Wed, Feb 19, 2025 at 10:46:44PM -0800, Dmitry Torokhov wrote:
>> This reverts commit c0a40097f0bc81deafc15f9195d1fb54595cd6d0=2E
>>=20
>> Probing a device can take arbitrary long time=2E In the field we observ=
ed
>> that, for example, probing a bad micro-SD cards in an external USB card
>> reader (or maybe cards were good but cables were flaky) sometimes takes
>> longer than 2 minutes due to multiple retries at various levels of the
>> stack=2E We can not block uevent_show() method for that long because ud=
ev
>> is reading that attribute very often and that blocks udev and interfere=
s
>> with booting of the system=2E
>>=20
>> The change that introduced locking was concerned with dev_uevent()
>> racing with unbinding the driver=2E However we can handle it without
>> locking (which will be done in subsequent patch)=2E
>
>So shouldn't we take the second patch first to prevent any issues here?

I think the potential for the NULL dereference is extremely small, we live=
d with it for many years=2E But if you prefer the patches can be swapped=2E

>
>> There was also claim that synchronization with probe() is needed to
>> properly load USB drivers, however this is a red herring: the change
>> adding the lock was introduced in May of last year and USB loading and
>> probing worked properly for many years before that=2E
>>=20
>> Revert the harmful locking=2E
>>=20
>> Signed-off-by: Dmitry Torokhov <dmitry=2Etorokhov@gmail=2Ecom>
>
>No Fixes: or cc: stable for this?

I did not think we need "fixes" for a revert=2E=2E=2E Do we?

As far as stable goes: you're the maintainer so IMO it's for you to decide=
, but yes, I'd like it to land in stable=2E

Thanks=2E=20
Hi Greg,=20
--=20
Dmitry

