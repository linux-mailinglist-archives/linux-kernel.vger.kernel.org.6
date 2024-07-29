Return-Path: <linux-kernel+bounces-265775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C3B93F5D0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F00DA28318C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6D2148826;
	Mon, 29 Jul 2024 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6A4XChr"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9CE14A09F;
	Mon, 29 Jul 2024 12:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722257187; cv=none; b=T/EvTMAmuO3URSVAmoTAvhPrPFqSi9sq2NWz+MR/r/xc4KUL5RpFtexsMuOFqcnZ4T16l2aEMbE/cLEZQKpkzBbjaMZ/5LNb5doNfmyMTt1mtl+fqMtAAsL3hmt0V+AjOEPanAX6/KLq8UgZGI97dCa2q9lf3dBAymITT05x1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722257187; c=relaxed/simple;
	bh=qcpy7LMKnUp8Dg14PlLEcEVLdl+bOm9brE6x+UUU0Hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gYvjd+XUJ9ig/qoBZkqSXQqE7FQhJYhLVJyitOC2XzWCS1fRFgWo3RvnfSIZhJyzrI2mGL6Nmi3QiZ6C5J9uERR1njI/sY49KTMqx8qCFWxGe+Rfl8BsxcrpfgfoNNKVBo1FVzvE2yHi1WAtCqCZD2vKZfRC379qteGl/b0pWdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6A4XChr; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2cb576db1c5so1824902a91.1;
        Mon, 29 Jul 2024 05:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722257185; x=1722861985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=68gJWFZqXTZSFzVo9G+Yaj2MGiDPAIXFLBZKYLe8M5k=;
        b=O6A4XChrugSY3DQk+MJgt4K1eZ8/ZXt46Mk2PJsY4mrcyP4r40cKFI2SLfQuNy1Smb
         4wSl+eF44U2Qcc1NHKWVojqyFN8YHTnaecRlOhw4L8UU/D2r+HjEWK/jvN+gsD5NVxyk
         qI563Q+7gGAdo1UisFcU+1J0a+3rMrXh5mbyx8tUYmC6jZkgOXPRMTlaj0emUzLv6EFq
         CznY5CAaFEAm2bbTG6ZA1TmkS8kZXzsjdY1vjr4koK2503S83yoWF9DrUNVK5aFw2cHu
         J22fErDndT0HEnxyB8zU/MuEjPqjHxi+HPcMErurYGUoaK2/9NSKat+GL++mnhwZkeET
         eMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722257185; x=1722861985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=68gJWFZqXTZSFzVo9G+Yaj2MGiDPAIXFLBZKYLe8M5k=;
        b=qwArpSN8Sg0Al2wCJEQZMdtDfKBFqy5OxsiJCMn4slWv3aDUh5sQMe5FHAJu22d75D
         p6PJmgHTvTD1/dKdlfNm/l3vSTIa5GXpOmTUUNjjjo4oDbyO3tBV2+FrIhpyn1gQYWnb
         8/p1kK+Gm0PDK14uZolrWFlB7J9fwVJKfkvur9iMphITjMrt/iJUsa+/Y2xydO743Kx6
         ePQ56z4CVcQymhmbTylVRrFqHXDTXRtmE+uqV7PgobYae2/CEjlW4qCW8cfm9r+MRuQV
         QTFg/obuyEOaxkxKlUGhcamdzyYSDHva+CQAp/HwFmj8tg907CVCPh4OiTSuiTJHkejN
         i5DQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwxCzjHoDV3oyFF89W2f3JgtZtRfRio//hgaVQPwletdezqNUwrtDPZTjj2kJGqDlu9oT8AggqATimaFfLjCABD6s/ZGXjoBZbAT+V8dZcErH+o5Vf9S2sFnE6AuNcrKUORhqlkcvX/TUUjhY=
X-Gm-Message-State: AOJu0YymXRSlv6B00VxWag/EdiQMO7LWg3KgW+RJYzlg3wwLwxlZ+VlZ
	uwsjaF9LOjBdE2vR/tG4U49zT0mvdldbyzK/1+y9gHfwsR7KnlAN9VhW0vTk10CBBxJsxRlft6U
	goQa3K4EV6DLLNoQQg/KUANXjgQ4=
X-Google-Smtp-Source: AGHT+IHEqMJHckPbJVqKj0Iq3neNg/uR2lA6Cjv0+2iZCADEG2vjMpdoq4F7rISxazZTK2wF5snsTlyeUKzaL8rcIkk=
X-Received: by 2002:a17:90a:f998:b0:2cb:4c5b:2d8a with SMTP id
 98e67ed59e1d1-2cf7e1c651dmr5281397a91.12.1722257184863; Mon, 29 Jul 2024
 05:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727140302.1806011-1-masahiroy@kernel.org>
 <CANiq72=4vX_tJMJLE6e+bg7ZECHkS-AQpm8GBzuK75G1EB7+Nw@mail.gmail.com> <CAK7LNAQBqcBEYvJQNMHgP7WfQmLbsj_j-wz4DpwQ4Cr3D1bj-w@mail.gmail.com>
In-Reply-To: <CAK7LNAQBqcBEYvJQNMHgP7WfQmLbsj_j-wz4DpwQ4Cr3D1bj-w@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 29 Jul 2024 14:46:12 +0200
Message-ID: <CANiq72ks4ctTpT7P__vSio5S9FRqu8__LDA6SBmtfEV-VK2P2A@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: suppress error messages from CONFIG_{RUSTC,BINDGEN}_VERSION_TEXT
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 28, 2024 at 10:03=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> Agree.
> pahole-version.sh should be fixed too.

https://lore.kernel.org/all/20240728125527.690726-1-ojeda@kernel.org/

> Yes, please take this to your tree. Thanks.

Sounds good -- applied to `rust-fixes`.

Rebased on top of v6.11-rc1 since there was a conflict with a change last c=
ycle:

    https://github.com/Rust-for-Linux/linux/commit/5ce86c6c861352c9346ebb5c=
96ed70cb67414aa3
    https://github.com/Rust-for-Linux/linux/commit/aacf93e87f0d808ef46e621a=
a56caea336b4433c

Thanks!

Cheers,
Miguel

