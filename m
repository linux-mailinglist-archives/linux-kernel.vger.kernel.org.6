Return-Path: <linux-kernel+bounces-575498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2797FA7035F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48FAE3BB534
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34F825A2DE;
	Tue, 25 Mar 2025 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="CpLHgFCm"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723151DD9D3;
	Tue, 25 Mar 2025 14:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742911796; cv=pass; b=sOztdSuUnEGeHTR8E9Wi/pmVoXRptFRWkCz2ymaUeOhaID+ESFhzDnjT/KnK3D+ol6up0YGREKpZf7Ikk+5FGhLTeMx43hm6w+nTLL0rxfOwSZWlinLsFzCCKuS9YYWgJN2H5QScL92M0IqepwfgfN8ogASQ0kmcZ+kdfcJw+7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742911796; c=relaxed/simple;
	bh=LNIxqLWu7KptjhAubWb1gWHI/laNC8Zcyz6V1AFcJgU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=J5NPaRTWztqTJQAE9NTZWzPbIsZQ+gxCZo0I+aIIT5xI8+iVPfnEeVJXqSduOhOzdrdIo3Wzbemtd7lSkCG4FpJ9Pxjo+hVLOxklNsmsSgGmolLkn9pn/tFHY9e1zfdrJLZEw15iTFYNN5/ov8TcoE6x9ZIV+ZQ8SaYNfFF+9C0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=CpLHgFCm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1742911638; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ncJ52/Q5NqGoSP0kBa5A3acAjZsX+sM8LWlCzpjv7e+Cf6QAtfPUNrsfTNE/zqS6p1/AB4+sqd680PT7SArZBdPN+dAE9x4mclSB0F7MbNzwUS7PfIaoHVEYklBFAAKyF/4xRWyC0XYuRGu3+0E99G/YIUSbGCn/oz8s+tYZL2w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1742911638; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DnUjQnltcNh6I2kOpe5b8pDo1IEr9myQnFAoNaCUY/M=; 
	b=DLsI3ZPnET6Bhk1S/XYUIfBylecm+Dlhj5Cxg/ZsMqrBUuqbMb/QfIINcIuHNcycZqcppwjkSHoRCW67W+1AktqYY8bkeHhKyBBjYPOy20JRIUYYq25LxwKea/8klvS376BbVQ2Q8zz7jFA2uuYclrx9/6j3Utl6wHUz+I1+QdI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1742911638;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=DnUjQnltcNh6I2kOpe5b8pDo1IEr9myQnFAoNaCUY/M=;
	b=CpLHgFCme1iWkCcrvmKZWwdCfx6CZ/1Efp6ATysb6f8+AoBMIPWpFXF2TbFOMJC0
	VbupbuOEfL8yjeLsooFe+4Qiqp+Xr+7REo2jhv/j1OjBmZWt4bBWjcxeld2uckIgUMz
	XCSjS5/N8UgWQxkrukE+03tH30zd9GgaAWC7gs4k=
Received: by mx.zohomail.com with SMTPS id 1742911635918478.89731093055434;
	Tue, 25 Mar 2025 07:07:15 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.400.131.1.6\))
Subject: Re: [PATCH v4 09/11] scripts: generate_rust_analyzer.py: avoid FD
 leak
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250322-rust-analyzer-host-v4-9-1f51f9c907eb@gmail.com>
Date: Tue, 25 Mar 2025 11:06:59 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Boris-Chengbiao Zhou <bobo1239@web.de>,
 Kees Cook <kees@kernel.org>,
 Fiona Behrens <me@kloenk.dev>,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Lukas Wirth <lukas.wirth@ferrous-systems.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <15D9DEFA-12F6-4632-979E-F67C7315E95F@collabora.com>
References: <20250322-rust-analyzer-host-v4-0-1f51f9c907eb@gmail.com>
 <20250322-rust-analyzer-host-v4-9-1f51f9c907eb@gmail.com>
To: Tamir Duberstein <tamird@gmail.com>
X-Mailer: Apple Mail (2.3826.400.131.1.6)
X-ZohoMailClient: External



> On 22 Mar 2025, at 10:23, Tamir Duberstein <tamird@gmail.com> wrote:
>=20
> Use a context manager to avoid leaking file descriptors.
>=20
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
> scripts/generate_rust_analyzer.py | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/scripts/generate_rust_analyzer.py =
b/scripts/generate_rust_analyzer.py
> index bd6e321a6aa5..ccb15aa66929 100755
> --- a/scripts/generate_rust_analyzer.py
> +++ b/scripts/generate_rust_analyzer.py
> @@ -211,7 +211,8 @@ def generate_crates(
>=20
>     def is_root_crate(build_file: pathlib.Path, target: str) -> bool:
>         try:
> -            return f"{target}.o" in open(build_file).read()
> +            with open(build_file) as f:
> +                return f"{target}.o" in f.read()
>         except FileNotFoundError:
>             return False
>=20
>=20
> --=20
> 2.48.1
>=20
>=20

Oh, nice!

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

