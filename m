Return-Path: <linux-kernel+bounces-340475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8789873DB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 14:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E883E1F219CA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 12:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F92F200CB;
	Thu, 26 Sep 2024 12:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9zyE6/b"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550F2AD4B
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 12:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727355174; cv=none; b=RX4fYSVHJgN3HtLpjBP5XoIS8OA/4OSSxChyE7l0z3cYnYD949J2TBkvcwCmyPn0lxLyw7YVfjEt4nSjIp9x5R1BcOdsvy/2lRznx9PvfuIixzoJgg+dMp/PGitKdXxG5ZH+gRKvaDlIGgsLAV8wnGJWFZloSnwlY+RcZ++3W34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727355174; c=relaxed/simple;
	bh=pUpI01rYEYl8lEF1U+rLDPbRTp9AUUwCxq5GUhTAozM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBU1E5UXQiWu0lSw3mCNi/INAEF1ssLXN6nVxPHm5msYJWzpD9Y767q3C+Qk/8ZY1CqqQhCLpbLi2avxz3K29yAHUh7QI6ZxBR063Ud1ipXEZ14VOEJhS9kNWzVlZjdKOdWx62pHCbhnJhm1RGFKLn9I0Ubo1XzQrBHpyTeVV/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9zyE6/b; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7198cb6bb02so708473b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 05:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727355172; x=1727959972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUpI01rYEYl8lEF1U+rLDPbRTp9AUUwCxq5GUhTAozM=;
        b=v9zyE6/bJtosREAr+QXBdIPrKOESe8AxehGGBs+krKpshCs/EsYSbjF1k51yPwZbKc
         3xL3cc0OSksd5IoP+sdLMtyCo/yuf2T5MwBMtr9Qef7AWF9tZkJIma+j/bNhfjTn/5L7
         2evZZ4PJeqUu5pw4KOmY63czgzdHZccuog9YiiR5lyNJ+iuC4pEpUebonJrcXTvj8Hgv
         EqyPZtoWSVk9tWCaOws85iSDNznpVsgMI7EMkt/GDn7fdvgFNYwyLY/lZMA6alH5xsnT
         RLTpSUWS1bmuHxaP/wp3dXUgd20LtrrSYjb1Pc8hCI+15BWjZS+CuAgH0vmlsP1rDz9+
         lDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727355172; x=1727959972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUpI01rYEYl8lEF1U+rLDPbRTp9AUUwCxq5GUhTAozM=;
        b=DWQKBwK2g/Biohxv+gQWQKBGhC2d21GJDsCWo/h3sZmL+Yt5bONqwpB+nzWYg8crBR
         qc+4bKhmoFb2jDHLdYNswGQoSMspizd1IfATWmDzUe6mXyyaH99y0ruC4qfTkKn6wefC
         SU5e6RX0YpsCYU3bY8cVtnClPwOLNfspgzWXqu8LlxiL2SrtQTQla2BjaVO5vxvNqJ6W
         QhjJapOUVMWyctgoINKNoVX5OcJpOZGcrDOBDK07kE0fA+Z6yrl+J/9a1B8TPSG7RKe4
         QFeQJ0FFuHwRUWmLKvlUBCOgACC/S/qH05m5dRhnO5CZjFc1Roq56XBIGQdGvX+Eq9Hz
         DCqA==
X-Forwarded-Encrypted: i=1; AJvYcCUCBFaK/vP878bl9EnPxSwM1L/cempM8eHIPGrlloVMX0dsWyTbmHPHS7ihnuIKDPwS3EawmHMYAVPzqWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/TY6F8ZJ7OVv7/BalXjhCVq6fjvSpN14psWXx/WbDM3HOp7UU
	1um3EAWZaFux9L83nVGGIAXzOIWQTtY+Yie+yOiYLq56RD2d+HIHoZ8nQOULV3n0oQQM2pwYiXH
	I7/RKCIbA1A9JP1yovt/Rm5tCsjq/iXztuoOC
X-Google-Smtp-Source: AGHT+IEWKTQjnC7Cgd+zNjTKvb1kAwlHpzLu9nyHOTqSz08Qcm69uWAB1guPeiKTZTqyc1H+BozcQhfNsTBjkEkGSV0=
X-Received: by 2002:a05:6a00:198a:b0:717:9154:b5d6 with SMTP id
 d2e1a72fcca58-71b0ac45f47mr8660601b3a.22.1727355172204; Thu, 26 Sep 2024
 05:52:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240926124751.345471-1-ojeda@kernel.org>
In-Reply-To: <20240926124751.345471-1-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 26 Sep 2024 14:52:37 +0200
Message-ID: <CAH5fLgg8v8Oy4-tKavqZYaHB-2pSU+14DwTPQOYL7d0cNww-jQ@mail.gmail.com>
Subject: Re: [PATCH] rust: kernel: sort Rust modules
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 26, 2024 at 2:48=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Rust modules are intended to be sorted, thus do so.
>
> This makes `rustfmtcheck` to pass again.
>
> Fixes: 570172569238 ("Merge tag 'rust-6.12' of https://github.com/Rust-fo=
r-Linux/linux")
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

