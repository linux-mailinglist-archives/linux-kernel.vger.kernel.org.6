Return-Path: <linux-kernel+bounces-423618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C739DAA82
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 16:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D08B20D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 15:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0685E1FF7CC;
	Wed, 27 Nov 2024 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ieXpiEcS"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C841046447;
	Wed, 27 Nov 2024 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732720367; cv=pass; b=oe0ALPwk5pH6IADOoFM2rxawllcXgOv7AHaxhjcDcrZIgWivHbw298wqP6n8aGxhJu0N0S7pW4Lo7DaTZyXCUWaxWng43a5bwZGmDLJ6QjB8CP85iPR/V+xziALaohfxuf3IQa6R/0wueSFt+ibJWCACtb2D38ZKyU+v/ikB79E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732720367; c=relaxed/simple;
	bh=cTFP4XBvlPFpskQQ7HDrMUlZzWRc90xxB4Oix/TjsyA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mrpKgSeywpIYho/01PvW+9/N2Pcda421y5W8/eRJZ870vmWW/NMh1empDXCyX4/N7ktdjB08xaQYGxBhDx9kyYFXwcFaIpHI6VjSB/AzNTvchgd7efVc9ws4zKQeK96dkO+R8ocKZrXX68G6WymKqra2H5fLFjQwaDR7u9t+HDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ieXpiEcS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1732720334; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Hv2B66P1ZZzQLsRM4f0bELzP8jQfPw0JWer+YSWDiH6PcvtA+tnKEZ0l9Rjpn/4z1BePKH7TIJvG5vmBBTPiUHSk5bI8NbDy4/MnZviy8wnSOlkS6WaTu2oY2WUfNNBiMGB1Fu/Nt7hoV5Wa/8wllCoWG/Ljo9JSFVKQv2k8G7Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732720334; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9L2AiOozzSpLhcSSpRzvu1g03kdBd1tb1vq6nDUVOfs=; 
	b=GzOgYoj6VWLUSTAURLaPYhVhjMyKuW8lv9T8+kEFk9qhABxvfBCRKlj8vmjvpcCY7Hec4GAoQNV+KCRWRda32z3uYlB/Ps0jur0JJbDd3OzpWHRqow9XzLz3NiUceF6yHA7HJAGjHCZuVDW18PYu5Y9NN2dMo7vujyrbtWTCSI4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732720334;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=9L2AiOozzSpLhcSSpRzvu1g03kdBd1tb1vq6nDUVOfs=;
	b=ieXpiEcSibL/uVZhZX+SZ1owhsoB0hmJd6MG8WHUue5ksfGLe3869dJUEuTxzMhJ
	WVgSAUJ45W/hJhLq4pZ4Z6MY2FCchZt4symrOhy1bKNN/Haj19EAlHtSVwHmQM78wjZ
	aNjLkjpcqi3kedLre07bJlz9P7eTUjGiAxmmbt+8=
Received: by mx.zohomail.com with SMTPS id 1732720333622129.81615342128612;
	Wed, 27 Nov 2024 07:12:13 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [WIP RFC v2 12/35] rust: drm/kms: Add
 ConnectorGuard::set_preferred_mode
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240930233257.1189730-13-lyude@redhat.com>
Date: Wed, 27 Nov 2024 12:11:58 -0300
Cc: dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org,
 Asahi Lina <lina@asahilina.net>,
 Danilo Krummrich <dakr@kernel.org>,
 mcanal@igalia.com,
 airlied@redhat.com,
 zhiw@nvidia.com,
 cjia@nvidia.com,
 jhubbard@nvidia.com,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D2094DDF-C817-4FB4-9B02-01E0CFDFF039@collabora.com>
References: <20240930233257.1189730-1-lyude@redhat.com>
 <20240930233257.1189730-13-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.200.121)
X-ZohoMailClient: External

Hi Lyude,

> On 30 Sep 2024, at 20:09, Lyude Paul <lyude@redhat.com> wrote:
>=20
> Add a wrapper for `drm_set_preferred_mode()` for our new
> `ConnectorGuard` type so we can set the preferred mode for RVKMS
> connectors.
>=20
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> ---
> rust/kernel/drm/kms/connector.rs | 6 ++++++
> 1 file changed, 6 insertions(+)
>=20
> diff --git a/rust/kernel/drm/kms/connector.rs =
b/rust/kernel/drm/kms/connector.rs
> index 7d0f67c3bdaf8..ec842ebc111ae 100644
> --- a/rust/kernel/drm/kms/connector.rs
> +++ b/rust/kernel/drm/kms/connector.rs
> @@ -387,6 +387,12 @@ pub fn add_modes_noedid(&self, (max_h, max_v): =
(i32, i32)) -> i32 {
>         // SAFETY: We hold the locks required to call this via our =
type invariants.
>         unsafe { bindings::drm_add_modes_noedid(self.as_raw(), max_h, =
max_v) }
>     }
> +
> +    /// Set the preferred display mode for the underlying =
[`Connector`].
> +    pub fn set_preferred_mode(&self, (h_pref, w_pref): (i32, i32)) {
> +        // SAFETY: We hold the locks required to call this via our =
type invariants.
> +        unsafe { bindings::drm_set_preferred_mode(self.as_raw(), =
h_pref, w_pref) }
> +    }
> }
>=20
> // SAFETY: DRM expects this struct to be zero-initialized
> --=20
> 2.46.1
>=20

LGTM

=E2=80=94 Daniel=

