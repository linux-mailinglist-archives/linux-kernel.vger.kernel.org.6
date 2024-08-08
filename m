Return-Path: <linux-kernel+bounces-279512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8839394BE3D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 15:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E93532873A1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9D818CC10;
	Thu,  8 Aug 2024 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="UHAF29oj"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78531E511;
	Thu,  8 Aug 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122641; cv=pass; b=V970dnwYKV/NRiQZRbJoLDALQrfvlKjgdU4hJJR8kb7fJAzqIw2Kdw3xAo0sgYiyDq4WHlkvNRa0yg2/yD6NfbmvjFDUS3ABEm+84mm5P7M0FDMcNAMiaxifJbjFl+TM4RDRjZe4KdAUDascGt3GBHDadb0AwWQ9vuD+3ThIEbA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122641; c=relaxed/simple;
	bh=ZY0FSscEcQivkYIlbxu8A/3+ds5ckFcTwpIi8w7tEfo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=WbRGDkurb+DoKbtehSsd9CvPVc3dXeJqpb/L1YzDSXFxQOiJle1CLaOiyYYltMjJOCV7nPn8MbS6hMMLvyLVP/0gTezQc8s5kZ9sL1tEvJ1Td1RaHSeHS6fac+71sv0FcdMrx8swqpjXRwsf7Tv5oSGvtb0/0ydmjFd3wESOObE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=UHAF29oj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1723122617; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SiVm3yEuhgFW8aFATjomSh5HsPR9cJNNxBUyRmc2Z7SaoxsZDCQ8CYKU31ypcy5FGxKw1qffKcRjXLM9rKsWY0yHszcel9RMSNyHSzPhbSjtpd8aZ5U6n8+XxWr8958+sN0YB/Ml7QCnDoG42CnM9dMALkbUT+opDtZMWLU55Js=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1723122617; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZY0FSscEcQivkYIlbxu8A/3+ds5ckFcTwpIi8w7tEfo=; 
	b=OXglsNDRf72AQ+usz7XVKQSjydo+8MMXRsxMgjsmFtE5pfsoOgUq0IV6yF3DmCCI05JIX3VR0vcWzWeYsEn85XaYXdM/GkgVuLPOnTu8W0tkHj2IAd7OYOssBXd9QJRLNhKCROellcZS0xN2T37lN92FfMt67nEWFm7Uxu4X4rA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1723122617;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=ZY0FSscEcQivkYIlbxu8A/3+ds5ckFcTwpIi8w7tEfo=;
	b=UHAF29ojODlUPsshmbEHXjt6cYzoO44Y64kn3tMgAwAyG3KNTCqdzzMbowfdEM8N
	U05Xg5L1TQa1ZSrYT4WY45uwZNCSqlQLk8opIUMRmbp75RF5PQVuEZK10My0AJINJt1
	FP/vSs1RDFxTzoIM/THHKVGltP22IgJluFmo7ps4=
Received: by mx.zohomail.com with SMTPS id 1723122616970646.6105827752397;
	Thu, 8 Aug 2024 06:10:16 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [RFC PATCH 2/5] doc: rust: safety standard: add examples
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <37d7b08d-f37a-45ff-9993-08fa7ed87443@proton.me>
Date: Thu, 8 Aug 2024 10:10:00 -0300
Cc: Jonathan Corbet <corbet@lwn.net>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9959901D-0839-454C-9141-F0661C956AD5@collabora.com>
References: <20240717221133.459589-1-benno.lossin@proton.me>
 <20240717221133.459589-3-benno.lossin@proton.me>
 <B0E3D539-2D29-4BB4-9CB7-98672F590A57@collabora.com>
 <37d7b08d-f37a-45ff-9993-08fa7ed87443@proton.me>
To: Benno Lossin <benno.lossin@proton.me>
X-Mailer: Apple Mail (2.3774.600.62)
X-ZohoMailClient: External

Hi Benno,

>=20
> I will try to rephrase this, tell me if it helps. When checking if an
> API is sound, you are not allowed to change the code behind the API.
> That is because `unsafe` code often relies on the surrounding safe =
code
> to work properly. In the example above, safe code ensures that the raw
> pointer `ptr` is valid. This is OK (and also very necessary), since we
> expect people to be *aware* of the `unsafe` block and thus more
> carefully review the changes in surrounding safe code. If you have =
safe
> code that only interfaces with other safe code you don't need to be =
this
> careful.
>=20
> Note that this heavily depends on where you put the API boundary. In =
our
> case, we generally have this boundary: driver code <-> `kernel` crate.
> But if your driver requires very specific helper code that does not =
fit
> into the `kernel` crate, then you might also have an API boundary =
there.
>=20
> If it doesn't help, then it would great to get some more detailed
> questions which part(s) you need help with.
>=20
> ---
> Cheers,
> Benno
>=20
>=20

Yes, I think this is more clear, but note that this explanation is more =
thorough
than the actual example.

My point being, maybe you should take some of what you just wrote and =
put it
into the actual docs.

=E2=80=94 Daniel=

