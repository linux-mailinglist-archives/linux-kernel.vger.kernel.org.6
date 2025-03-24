Return-Path: <linux-kernel+bounces-573064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FBDA6D28B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 01:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408E816F8B2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 00:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FBB9450;
	Mon, 24 Mar 2025 00:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="aCoY97bh"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7B6800;
	Mon, 24 Mar 2025 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742775718; cv=pass; b=qDO9WSiD8lgT3t1MMIx195ja7/htPXd4AEEQ9YgRrZqdMA3WyiYlnNkF0J1c8lTaOyr+3V9+GsYlOl56s1ojbaUQ/uH3S23Zw5U3Q+wVSUNINaNXcA6VBrLzNDwM/v4X/Hr53l/bePnwgsVdc3KFKAPwc1ywEeNZlj1fJx8fmW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742775718; c=relaxed/simple;
	bh=LSD68B2lXXUsNyzoiLEJWooRGTP7dy0r+BcpQ0ch2b4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Q09foWHooEuQmN7btPAOoSadCvljEj6rD6V6CdvuEPd3m1BpGd02yTRoIuhsvUoHOUYfZBaFQorEXR9lASFZktRSAyJM5gU317RH3d7uKm9RRzVuoxYdQ6WkkYNxBF1nRVPNlfWWPF95RdHOaZmPfzKUQWL76ZG0nTBI4n4sd8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=aCoY97bh; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742775647; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BPwV5t7/r4UqJd6kOOVC5FD7QFZnldIJ9/au7pcrg7t9yFZabT0n7pNcPLt7DQLh/ykasInS/UZyBTP+9roY2sGSkEMjIFCgrWLGLYb5+8yZ5Vd1XvDvq/9s5BNspnlziDOnQrEFC3007nb6HZ3v5okcyIIEcAMdltiPlfnAwh0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742775647; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ck808zhnD71RkvoUGLOtU0v+FWU54BhHaZzNtEpsxmo=; 
	b=O9tfWwEeF7+8QjMnYZLaE8vjFzJCFzII/hlwppETFcXd95I8Ht3Cdi+tu69eolU+T8dsr5uHm14gWjHlCXYg4LzIh6Qsp60HLD5dpnySdfrhZxTqmp0hWaAkaX2a9aXbZmVRx+XfSb+QzfvlBTk72Z+Tk5ax3O1iEi8cMxNdUoU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742775647;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=ck808zhnD71RkvoUGLOtU0v+FWU54BhHaZzNtEpsxmo=;
	b=aCoY97bhK5BoOxqKqdyoyktG8bYozuVjOLS4RguSELl60XJTpAaLAGSA8/bpW7HH
	4XiS1Yq8cAMt5Tyw3P6EeW3/JomHpKj9zHBLkhfdKo3EJJc5BZ8l0cqsRW6426sqwFs
	c8bdpBYUNr9H5oHTDK+SBUCYvBUpVtlEfrZDHhh8=
Received: by mx.zohomail.com with SMTPS id 1742775646583608.4505870195064;
	Sun, 23 Mar 2025 17:20:46 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v3] drm: Add UAPI for the Asahi driver
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <Z-B6uc7EEAdBPXmt@blossom>
Date: Sun, 23 Mar 2025 21:20:28 -0300
Cc: Faith Ekstrand <faith.ekstrand@collabora.com>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Janne Grunau <j@jannau.net>,
 Sven Peter <sven@svenpeter.dev>,
 Jonathan Corbet <corbet@lwn.net>,
 Sergio Lopez Pascual <slp@sinrega.org>,
 Ryan Houdek <sonicadvance1@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 rust-for-linux <rust-for-linux@vger.kernel.org>,
 asahi <asahi@lists.linux.dev>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 linux-doc <linux-doc@vger.kernel.org>,
 Asahi Lina <lina@asahilina.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <260D98E1-7204-4535-A84F-D55A4527FF7E@collabora.com>
References: <20250314-agx-uapi-v3-1-3abf7e74ea2f@rosenzweig.io>
 <195b507d4b3.b25d0dad175771.7566427576910952468@collabora.com>
 <195b582682b.121ba4d5e219032.3109114844776468245@collabora.com>
 <Z-B6uc7EEAdBPXmt@blossom>
To: Alyssa Rosenzweig <alyssa@rosenzweig.io>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External

Hi Alyssa,

>=20
>>>> +    /**=20
>>>> +     * @DRM_ASAHI_BIND_SINGLE_PAGE: Map a single page of the BO =
repeatedly=20
>>>> +     * across the VA range.=20
>>>> +     *=20
>>>> +     * This is useful to fill a VA range with scratch pages or =
zero pages.=20
>>>> +     * It is intended as a mechanism to accelerate sparse.=20
>>>> +     */=20
>>>> +    DRM_ASAHI_BIND_SINGLE_PAGE =3D (1L << 2),
>>=20
>> Does this require the BO to be a single page? If so, does it require =
offset=3D=3D0? Or does it just take whatever page is at the specified =
offset?
>=20
> I believe the intention is that it takes whatever page is at the
> specified offset and just maps that a bunch of times. HK doesn't use
> this yet though it probably should (this was added to help reduce
> overhead when emulating sparse with scratch/zero pages, which is still
> very new functionality in hk).
>=20
> Accelerating this properly involves GPUVM patches - although even =
without
> that, moving the loop into the kernel so it's only a single ioctl
> (user-kernel roundtrip) seems worth keeping the flag for.

FYI: I will be posting a patch for the GPUVM abstraction soon.

=E2=80=94 Daniel=

