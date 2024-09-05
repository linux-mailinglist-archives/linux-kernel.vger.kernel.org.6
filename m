Return-Path: <linux-kernel+bounces-316579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5793196D17D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14D71283CBD
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9D21957FD;
	Thu,  5 Sep 2024 08:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QTVNt4PI"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BC01953BD
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725523695; cv=none; b=VTycPo9gFltCjGrXOS8PUy20l+m5SRCpRu/FVMMAyntWXcO8Q/iqewFApV34GPLi8a+K+lbwGs8Iw3XFgS0R38Hu+X4FhEW7dYX8Re4fD0fDVaOOFYd2S9kuxwoHWVPpQkflLtHtCFXEnPYB/u3PYAVgCH2MegXxJ1lMFSe4Yjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725523695; c=relaxed/simple;
	bh=poBaygU7+HWiLDKkFSk+8ccL2GmYFP/9Qk2v9fz7F8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ay2p1P7CkL5aH/V5kjMK7oe4/mBWcsRMBTgzGTZ5zpOjmqXV0el7ws8QSviauMd0vwBjCxUwPuZe5etFOxOpcHWBWnzAfQXE2lqZ9Bu9hst1H9m3uyMgHqz71y9/eRmIWrTBaR673Lq0epFqPjqJsUR8KyGf1E+K3VaDfTrNSZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QTVNt4PI; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-374c180d123so223061f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725523692; x=1726128492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poBaygU7+HWiLDKkFSk+8ccL2GmYFP/9Qk2v9fz7F8E=;
        b=QTVNt4PI+lbLVEOccq+YXoTqwglUFO8ZHVi/fJ/cL+Qwz+R61oITHO9AIfiQEHhT5d
         7MxNKo1iMpg1dhvhzv4i8Am6j/XGvCEK5jScxuEUE7Eep7hSocUDf3saQ9EL4wEWuxcL
         nV+6uyaKKmdOcM9lzjvQY5vFhv7R9mrArsNihqu70G4nkm35Efa1u74XXkIPQIUvcHm/
         j8K7vW2BbO8AUx35ilfAN8YdU3Ap+/uNl37TcyX/MVvqKjJzz9HRm5Bp5fJKZhXmC6HF
         imZhpy520k0QPlsb4eFXBaCvlkfjEJXagXMIgbU46k0jHcs9rRsw7ZCjT+StCPz++q7P
         CRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725523692; x=1726128492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=poBaygU7+HWiLDKkFSk+8ccL2GmYFP/9Qk2v9fz7F8E=;
        b=npvA2wFQpNTvpooD2jaXC9kBMiAPzWSKGSaEOHRh+PaKm98SAXBvfx5bzCPi/hDL5W
         is+QOX+05vhL1cqhPzRcRoWVYGDNh0lCwBMqJqPbYiGL3koQAts81fjIsJ75hsXqHTAs
         Ls3Vbg7HCuwnlGQo6pG16Em7UCLPq4SuMSaKJT5gMTUrI+jmbuUepo4XNd1Je+RPkqdQ
         3bDKHsUkAnkdS90oCY16WDknNysYnA0fwVLORg0e1SqYNnW7Lf+dkOBYOcsey2tyFhlx
         HVZbVEKz4O09mf2eLJs/SjjHR2S9L/g4yIz2EEfCvcL95lqLUmatzBQhe7EXi2xy9Wf9
         hcZA==
X-Forwarded-Encrypted: i=1; AJvYcCWrcPXCm4sFIBKC8oC/shuXCwvh7khHbG+2A1UEY6ANg06zhm/x5tdfJPywgseCZy2BfhLnE6pLVBUqKws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1wa/jxWp0JT7LzR2eS6XK8NyaToK4vIv5Qrpt0oAOL1WwoZeO
	KkT2K7+rj/nkqXf2PJTy90LCO61mP7hpBIcY1UdnlWa3fpHm7OIEzAmgCmQbPasKiPoFZaGCNYY
	dAnOZZqW8nJK+wDiv8typm19O9ceYrnkfOCYF
X-Google-Smtp-Source: AGHT+IEQUylIRonA2uVlZFEoYTcRptbEOhXQeLWztRoXVHu9gmPqIPrVqsbgBqz3oJzQ8miyvaRCKs04O6ZvMsW8VkE=
X-Received: by 2002:a5d:40c7:0:b0:374:c05a:4046 with SMTP id
 ffacd0b85a97d-374c05a41e8mr9249377f8f.19.1725523691535; Thu, 05 Sep 2024
 01:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-7-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-7-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 5 Sep 2024 10:07:58 +0200
Message-ID: <CAH5fLghKkzUpt0zDQVdpZCeUYRv+kUXCqkS7coUpFtaxNk7Bjw@mail.gmail.com>
Subject: Re: [PATCH 06/19] rust: enable `clippy::unnecessary_safety_doc` lint
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> In Rust 1.67.0, Clippy added the `unnecessary_safety_doc` lint [1],
> which is similar to `unnecessary_safety_comment`, but for `# Safety`
> sections, i.e. safety preconditions in the documentation.
>
> This is something that should not happen with our coding guidelines in
> mind. Thus enable the lint to have it machine-checked.
>
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#/unnecess=
ary_safety_doc [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

