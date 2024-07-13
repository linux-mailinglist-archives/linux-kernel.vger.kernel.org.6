Return-Path: <linux-kernel+bounces-251273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D12349302E5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 03:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A2181F226F8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 01:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44140D2FF;
	Sat, 13 Jul 2024 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="OrSyoQ3N"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA342F2B;
	Sat, 13 Jul 2024 01:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720832452; cv=none; b=A1dVwt5+juF7td1LM6BN08c5ur3rTlTfZziJ3hkP7OCEJ5eo3L34vFSiuOYHtSoEPGAUPXktkh3kmiXSZBQ2ULztbXlTwS1oWFZXX341Zns/tn8O3mE+3G2KJUUuwsYpa21pF3ek4ruHpHiiy/N62yyCmFsLmqBYAUWomNQjPtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720832452; c=relaxed/simple;
	bh=w/mpt+RlfSL8Dp/1of7ZO8A1RTwC9qamUzbz96QfUWs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=aPDrnIKmYRld8td7TQnkKBMMv0fZr7Fc1LKAWFkq+MRd0ru+quUlbfCQ5pH0ZdZsCa57N3cnk2jYcF13s4tufp7+tct3qCpl17W25d0Alb4vc50fpJnDZ5e81tJHWDaRCwScfF9zSrFU3/f7rOFP45fYh18wJEQenIa5IBnvVMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=OrSyoQ3N; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720832443;
	bh=w/mpt+RlfSL8Dp/1of7ZO8A1RTwC9qamUzbz96QfUWs=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=OrSyoQ3NfLGmrie4sOHpBxx9p3cghk74+ESentpuMhw+yGNSHVb6cBsmY5DsY4DPj
	 PMrXhlo+Kf0tyxjdJoRWkDH/gUZkt5B8LVWCuELq46AfrgZElBdSu2SNHckle4d3/h
	 3VHwSFfO3gB0ge0YnzAiX15gdqnopDsLTmS4siArj/iwHWswYrc4RqQB9z8rKSa4IW
	 iKfmChdjXiAikCxHo6HAZbCd29/5JDJUCe0vnA158VN9Iw4foSfL/909q6BjTSjo8v
	 beQmi03fyNWcnmHhBwJph1yk/0uVXx7eoGynEWyrwhToCTybFk/4owNVIIb8OIaiRS
	 QATaV3FBhT+MA==
Received: from smtpclient.apple (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 581E837813B9;
	Sat, 13 Jul 2024 01:00:39 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [RFC PATCH] drm: panthor: add dev_coredumpv support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <CAPM=9twNU3Wm02zCqzipSt4mDU3UUF5AyVycpBkPTGqv7fwPAQ@mail.gmail.com>
Date: Fri, 12 Jul 2024 22:00:26 -0300
Cc: Danilo Krummrich <dakr@redhat.com>,
 Steven Price <steven.price@arm.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 ojeda@kernel.org,
 lyude@redhat.com,
 robh@kernel.org,
 lina@asahilina.net,
 mcanal@igalia.com,
 rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <76D10179-FC78-4563-93CD-0528E3420D45@collabora.com>
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <fe84a028-01a8-4987-b1b7-141fb76d263c@arm.com>
 <4344B22F-D859-4C64-A351-69FFB5208362@collabora.com>
 <ZpFDeajsuVONbSYJ@cassiopeiae>
 <0A0C1EFC-29A1-4D73-8B02-CC1C693D6A7A@collabora.com>
 <ZpFMmAEdqo1dhj0s@cassiopeiae>
 <CAPM=9twNU3Wm02zCqzipSt4mDU3UUF5AyVycpBkPTGqv7fwPAQ@mail.gmail.com>
To: Dave Airlie <airlied@gmail.com>
X-Mailer: Apple Mail (2.3774.600.62)

Hi Dave,

>=20
> I think I'm on the uapi should remain in C for now, we define uapi
> types with the kernel types and we have downstream tools to scan and
> parse them to deal with alignments and padding (I know FEX relies on
> it), so I think we should be bindgen from uapi headers into rust for
> now. There might be a future where this changes, but that isn't now
> and I definitely don't want to mix C and rust uapi in one driver.
>=20
> Dave.

Yeah, once this was mentioned:

> How do we (easily) verify that changes in the Rust code don't break =
the uAPI by
> due to leading to changes in the generated header files?
>=20
> Do we have guarantees that future releases of cbindgen can't break =
anything?


I realized that there would be issues with my original approach.

> I think I'm on the uapi should remain in C for now

No worries, I will fix this in v2.

=E2=80=94 Daniel=

