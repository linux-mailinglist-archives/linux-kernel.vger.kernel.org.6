Return-Path: <linux-kernel+bounces-413270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CED69D16AF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2380328169F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2204C1C07F7;
	Mon, 18 Nov 2024 17:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRfvnMEJ"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA781BD4E2;
	Mon, 18 Nov 2024 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949401; cv=none; b=rCgluyN/g9MO+lSvYFMfNNCmDMHM3LhFRoA+l+J2FXne0xb0aYWHDxaPRdGJmx8G5rFRcPeNTJK40hr5uN/Jv5UzJKrRXch0gn3rCRRcsQXj2FmoJIAceKvC6pyGqlq259ChUU+G27dYaHZYThDku1loa1GQrQSYwvGRDGwpqL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949401; c=relaxed/simple;
	bh=l7ddQfCnAyZKFCQRvFq/7jrnC5qLzspMtiTCOV/wDbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lME3jZtquX2+pBXr5yHPz2HeX4tjoL4JVK4j2y1WSqVXbhvSJ96dzKMQ99ztwK916GXjs7Hmn7o0FfNg5u74qsz8YxSLhn8T1n8b5u8jeUWRPTJ/DKgj/guarD9j9Mu+EypqdF8Ee6nPum8uEN2J6hH/mkOMsLHwLv57ewO3sQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRfvnMEJ; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-539f8490856so3496108e87.2;
        Mon, 18 Nov 2024 09:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731949397; x=1732554197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7ddQfCnAyZKFCQRvFq/7jrnC5qLzspMtiTCOV/wDbA=;
        b=fRfvnMEJ6GLfR4BnJFzQuAZZICz/EM/0pjfvin5jUEEDLAuKCpQhSOjRGLFwlMUO34
         M5wSAJsUrc/ln9keVYV6TNVQ0syq1D0AcvhizDoNbUHlFC1qr7IJMzdrlSeQ8LRexK0s
         sXrdhdc6xs3RMrC5ZS9WtC8Urt9bRfy7cr9B29XI035Z/6FwZWDWMxYRgc5yPc1Ov4oG
         KdEczC3GlgvsgUyU+3kE5UvnkJpeeeh1Nn3C93UwQ+I4JTChavwpaIClMpzAA9Gx8x0j
         AbaSmryxxKkAdISWcQL+Ebi4sQq0Tpoe7tvtmH+KRobb3fCLxSJ5erNIJSXorG1Sb2Re
         wx0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731949397; x=1732554197;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7ddQfCnAyZKFCQRvFq/7jrnC5qLzspMtiTCOV/wDbA=;
        b=K1MJOgIf8XwWO4HU7ifGZxJo2+IQOPsCc1dVk//N7RZFtgtQvzThgj3Ugh9QFJdZ6u
         ZLMQIAPy9rjUtrEqzbNfhMmzYcKQzJtDa+vRlBlTc62QrZ/3+CUA4DHL30QpP4TloRTH
         N4+SmxKAY81Jq9gO/GstMUjl3czVLvlKJPiNOeqWL+nd/nKaLxCXxNvUsF+bxayROpaN
         y35WyZMKxc9S0xdJVhXuxy5zMLLwMRDrHBH+F2qpWMa176/fFKcuco7zDIel+WeJxPsw
         LsU+yC3VNqhykSRkCJ+Iu6hEwF87OLyPGfSokQ6K5fjfZtzIxXtLs64DVBMBJB5jYMRC
         vMCw==
X-Forwarded-Encrypted: i=1; AJvYcCUm1FLsKLS7vMiaLJiDox24/LpQadntJYHVHZgTX329s834hqaNK3VPbIz/YyQdencqtSuRPwguMav/EwzgxZY=@vger.kernel.org, AJvYcCWYaLCpKdhxUj0kca6Fopw5WRI2z0eQo8INSN9XY7njNGzkHgjVT9AZAehK68Fv0jwIBvwfyXBNfKPsmGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5VqMthX4mOhSgJxG1hg25lTfGTXLZ3GyWg9UY/qBv9ZFHTTQM
	nCe+YexJimAN2FISXZUJHsv3WgyGpgbNPOmJUlklCpO326JiwWF2JNqSwJUhizAkUXkXUQlVnQy
	nyNSOoiJHL/RmY9N53nFXf/MTXIs=
X-Google-Smtp-Source: AGHT+IFNH6ZYLQ4qgIY3lvUzR8C2ueBqtEbtn3vzsKlbGD78m8WE7E5hPbtYx/mvgYeJn3n07NCcv8BqbU+yXrnKp7c=
X-Received: by 2002:a05:651c:b07:b0:2ff:5a42:9205 with SMTP id
 38308e7fff4ca-2ff6070e062mr64758341fa.31.1731949396381; Mon, 18 Nov 2024
 09:03:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com> <CANiq72=13uaXS+mptTiQZ7OLpyO_=r7-06cXEujFqtej=150YQ@mail.gmail.com>
In-Reply-To: <CANiq72=13uaXS+mptTiQZ7OLpyO_=r7-06cXEujFqtej=150YQ@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 18 Nov 2024 12:02:39 -0500
Message-ID: <CAJ-ks9nqcrOhOSuw+fN9+871W4YEs_rwRJehm=mnAx+M_v8Pqw@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] rust: xarray: Add a minimal abstraction for XArray
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 11:52=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Nov 18, 2024 at 5:33=E2=80=AFPM Tamir Duberstein <tamird@gmail.co=
m> wrote:
> >
> > This is a reimagining relative to earlier versions[0] by Asahi Lina and
> > Ma=C3=ADra Canal.
>
> Ma=C3=ADra's latest version has both of them listed as co-authors in the
> main patch -- how close is this to that version? (I see some bits that
> look fairly similar)
>
> Thanks!
>
> Cheers,
> Miguel

It's fairly different, and I discussed with both of them - we agreed
that Co-developed-by would not be appropriate.

Thanks!
Tamir

