Return-Path: <linux-kernel+bounces-260242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EF393A4E6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 19:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B03F1F22EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 17:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB1E158219;
	Tue, 23 Jul 2024 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="gg3XkoBI"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D789914C5A1;
	Tue, 23 Jul 2024 17:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721755430; cv=none; b=gbwU8dGxCBY+XmQ/fHEc0VVODnXh0CW0bzhudKlS260ULiSignPdr8ATJfz6lsR+FUYEwpUeuJHfV61Bjesvpf46vuRPJAoozIQzuPEGFZTOfwHpBPMXBAr3cHSKuHLQLsnqL2r5WCdmTu1f94xY+6JQk4nn4vTkWRlp3zHt32I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721755430; c=relaxed/simple;
	bh=JyVcTgHb3Y8+SNEOpKEbDo+aRs4mxVVq1rDwQWET29k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=fW0t3DPsrp75fCD9FvxV9kVgbnTzsCyL+yWyGqdCllk/lV9nafI+dKT91WVRaR9XdoD06ET8HqIPFQbox0/9eyK0PWTWZJvrcESjva97CzNUthkv3wHXHaP3oWydbbddP0SykEZm9nKamki/L561J3GUvojLR9590kf8CBwKNBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=gg3XkoBI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1721755427;
	bh=JyVcTgHb3Y8+SNEOpKEbDo+aRs4mxVVq1rDwQWET29k=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To:From;
	b=gg3XkoBIURmtWSBVdaSXHRPO2aAxC5pm8JV/yuT/N75aqgai2iBtYlLf2J5q5Byv3
	 04hHju8+G/ZDLrDWCxDhprO0pSHIoKEUV1ScbOm4CovarEPBsgpLwOjiHc0MkdhVVt
	 ZdGz1P/HYmUJOBqT2JmKhtfsD5iUCjjJGosioW7tYGYT6XwiyPIDNjSMN/fESR3xvA
	 PUYnggrQZOrrhpAApAVMmkDanNgjCJuLt5RlbWNY5bFRwcih2U/qUjBcOoe9J2lrEN
	 OjNPy5/9vxvhVRmUV2Vd+APg1iWzr1sFhk/xtYNEcRC7vk73ib4jirNTQv9tpOLVHO
	 it+BcFvdlzgOQ==
Received: from smtpclient.apple (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 19E4D37813AE;
	Tue, 23 Jul 2024 17:23:42 +0000 (UTC)
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
In-Reply-To: <20240723180642.73502856@collabora.com>
Date: Tue, 23 Jul 2024 14:23:29 -0300
Cc: Steven Price <steven.price@arm.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Danilo Krummrich <dakr@redhat.com>,
 Lyude Paul <lyude@redhat.com>,
 robh@kernel.org,
 Asahi Lina <lina@asahilina.net>,
 =?utf-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 David Airlie <airlied@gmail.com>,
 rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <AC03F2C1-4483-43BC-8E92-D3F26CDFC8A8@collabora.com>
References: <20240710225011.275153-1-daniel.almeida@collabora.com>
 <fe84a028-01a8-4987-b1b7-141fb76d263c@arm.com>
 <4344B22F-D859-4C64-A351-69FFB5208362@collabora.com>
 <edda856e-3102-495a-8cc6-b79f5f114833@arm.com>
 <20240723180642.73502856@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: Apple Mail (2.3774.600.62)

The script (and the panthor_regs.rs file it generates) is at

=
https://gitlab.collabora.com/dwlsalmeida/for-upstream/-/commit/783be55acf8=
d3352901798efb0118cce43e7f60b

As you can see, it=E2=80=99s all regexes. It works, but I agree
that it=E2=80=99s simpler to generate something more idiomatic by hand.

=E2=80=94 Daniel=

