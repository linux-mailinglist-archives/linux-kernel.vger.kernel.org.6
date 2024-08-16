Return-Path: <linux-kernel+bounces-289678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5281954911
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 14:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85A691F2326D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 12:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BD21B150D;
	Fri, 16 Aug 2024 12:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=woltmann.art header.i=@woltmann.art header.b="Ofo4kXtN"
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B012E859;
	Fri, 16 Aug 2024 12:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812383; cv=none; b=KwFUwPdmE8e45mR0YopcgtwVcHqmks4GZLAzYAcc5ymKTgdEIdYuRV/91zZEpL3BCNqlc8ludEcnEr/IO+W1QTFnW3gLsyJ4+TLhFCtuxplidUrj0HGyN5AU+WwuAVvu0nVID7qUJ16cTWzs0CBK5HO+acxNjr47ejvbfHQy7dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812383; c=relaxed/simple;
	bh=QWNpYU3pWiV57+7SurtAARnts5tJewlmVTfYZF98uvI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=KKLHV2kwGMZSONwzkXFlA24mRU8VL6xvQhnE7Y5hLiVADUtql9i+Nn+ieQyjN3OiXlHhQd6Zd+VuGlLVhhOuCn6ydNm5W1WW+QHaU1dIZNJ9qPazhwbA4wwruSzZPQGz4GB4gAv3ExYyTkh7iO+a9iWJjWmTRDgT0cLpq4f2RrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=woltmann.art; spf=fail smtp.mailfrom=woltmann.art; dkim=pass (2048-bit key) header.d=woltmann.art header.i=@woltmann.art header.b=Ofo4kXtN; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=woltmann.art
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=woltmann.art
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4WlhZ10TJ1z9vl7;
	Fri, 16 Aug 2024 14:46:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=woltmann.art;
	s=MBO0001; t=1723812377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkqdX+9+e8U5naCUvH0638tTZBSM4TEqE32jNdQOARc=;
	b=Ofo4kXtNA1ZfrC9lipkdlD0FwPHu2uVn6vFRW4RhTGHkEYaAsoWkDIz/8V1fadv3BOKbeA
	jxQXvXTla3NLJpcwhMOqrZhQLObBwUrA2XqMFfR1QCYJBrEQ3ayCojcQW2sv2yWajjci3m
	/Zb9aTHODEUXzN2QZqPfELo1LLGpCgMs9laVNDtAgwPclog7K4oDdMea0/BmBGCShb3JsB
	UVgMisUuYf/au75ldDyRmJNahSn0/etX6lvbAlm1toibQJLIRgvMGLZqxie7xTGZa7j5ZC
	8KdN20TbKU86qDJflia+b2BUnl6XPyBgA0otoAgb/bxF/aqcYWChWpi1VvjmFw==
Date: Fri, 16 Aug 2024 14:46:13 +0200 (CEST)
From: Vincent Woltmann <vincent@woltmann.art>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, Jonathan Corbet <corbet@lwn.net>,
	Julian Merkle <me@jvmerkle.de>, Wei Liu <wei.liu@kernel.org>,
	Sven Van Asbroeck <thesven73@gmail.com>,
	Adam Bratschi-Kaye <ark.email@gmail.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Message-ID: <2130133683.467462.1723812373582@office.mailbox.org>
In-Reply-To: <CANiq72nN+x9FR8whpiEFtUr+4gkBN=pfw6URO9VO31qtX7=5Bg@mail.gmail.com>
References: <20240816092536.2444105-1-vincent@woltmann.art>
 <CANiq72nN+x9FR8whpiEFtUr+4gkBN=pfw6URO9VO31qtX7=5Bg@mail.gmail.com>
Subject: Re: [PATCH] rust: Remove erronous blockquote in coding guidelines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3
Importance: Normal

> Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> hat am 16.08.2024 11:32 CE=
ST geschrieben:
>=20
> =20
> On Fri, Aug 16, 2024 at 11:26=E2=80=AFAM Vincent Woltmann <vincent@woltma=
nn.art> wrote:
> >
> > -    While sometimes the reason might look trivial and therefore unneed=
ed,
> > -    writing these comments is not just a good way of documenting what =
has been
> > -    taken into account, but most importantly, it provides a way to kno=
w that
> > -    there are no *extra* implicit constraints.
> > +While sometimes the reason might look trivial and therefore unneeded,
> > +writing these comments is not just a good way of documenting what has =
been
> > +taken into account, but most importantly, it provides a way to know th=
at
> > +there are no *extra* implicit constraints.
>=20
> Doesn't this part of the change make the paragraph be outside its bullet?

Yes, you are quite right, I must have missed that. Thank you for the feedba=
ck and I will prepare a new patch

Have a great day,

Vincent

