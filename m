Return-Path: <linux-kernel+bounces-573463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 133EBA6D7A4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8149F3A7838
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEE525DAE3;
	Mon, 24 Mar 2025 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4ZJw7Cy"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F5725D554;
	Mon, 24 Mar 2025 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742809073; cv=none; b=kn9UjWc4irCHgg8lq42TeNBMfQrZaIaOk7godI5H+nWE/uxurJXbkMvAV70qI/snywdCEde6MChTgyF41iqpLzhPmtNHbdfw9Pb5Mi/pqvy5J3jdCmy8XEeIelo18/roXJvGIQ87zP6VHp6b/8QX+iKZgMfkGz0vszINUl9kPbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742809073; c=relaxed/simple;
	bh=F09joWCE15FJHzvmnuhZZDe0J85P+cppG5qFK6Ig3eM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dfMaQy9qWFYD8rL3NE5g0aXxcwPQtKzHqbTwS4OcYDVSYutXODo18e+iFjBNPO0qeJGYsz8DzzjudRajEWlszs8Ge5GpgdzVypOgZs6Pi1HOYWkYyEGd6qLYOGaWFv0gkGntOQaq6gP0AQmOpvToSFw7c4q6heqLgKxxFbK/8+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4ZJw7Cy; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223f7b10cbbso8334445ad.3;
        Mon, 24 Mar 2025 02:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742809071; x=1743413871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F09joWCE15FJHzvmnuhZZDe0J85P+cppG5qFK6Ig3eM=;
        b=D4ZJw7Cy/8X4UceQ/sr5/i1UkJwvFgmwbmGCXrE6fpvVsnGKXPZ+wCao6mSd+OFCZX
         UDh7hZWks75PpP0fzWsIuBE/xeezilGx/vynFevDDy32YrCZq35SMqTJ5niweX/g47gN
         aqz+555xbi/SyCUxPP3D8Rh9mzaXnb4uvgnit0K4TxIzv8et+bOgAntyYYxJ3d5Osn8T
         Q3e/+yjwr47GFHgupJCO8CYpHPXMj1UuC2oR+S+DFMsGr4UjU3Mtl/lMd1jGApbxpjYZ
         t8r9sFNXmpOyQUyCD0IupQRaZXeRDPweDGbsh4AnJZIDRSkYe+orKtthzi1ph3OTHNTO
         5bbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742809071; x=1743413871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F09joWCE15FJHzvmnuhZZDe0J85P+cppG5qFK6Ig3eM=;
        b=GeYiLzPe6v9+Y6B72KwpAYpW2CXw595mXGXbkspiyAOXt6DMhmnBbMdjl7JiKT6JGD
         WJae1h6ZjdmN8XHXL0ZdQCN3xto1HyMp+D7md2ApV4IiS7d/Bvo41gIL5PtYycZPOBVW
         JQORKSkwCdiQLkftU9x7KK/Wq+bg9hsaEW8miqaifqCycFh5RbJMgMmeWZ3t0QduFo/2
         Grs/k9PQiHhBstRk1p+6EqcAygniQtHnfPzqTdAvKQ67ZaEX1OaTUAwl70/K0DXJxekW
         hh7bhnCCgmGnd4tpMy14Q+0BAO2YilClIdlcym22xNBYKOOQWdRj2Id8KuxXFZw/tXjQ
         mZUQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2sFhe8+XFzm9TmNl8KGV/Y8Lz3Ujaq1uEnOj31ucfq6e+RtKOvUpZuU4YO8DXkkQYsJnBq515ulqNUAgGkwY=@vger.kernel.org, AJvYcCWa8z3+t+Xt8gx40aFKVLFIU9Xlerzkao/6epFk8Iu/+Y91jqz0hjFCIASoWnAHvWkd4oDXIeoL17BJ++E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGwIEZiPnoARsEVEegDgWZ9u6JZ55/BESbGcg3vNczsdpAkq5p
	gnkKRxjVQBevfE+XqBCTDDVwdKFOww2IWOhEwtLab4x7KgZRWy3OPP6zqpiezVQ5Ns4EuJem6Xe
	dV7T/hOi5Muencqf148bFhpCJBwU=
X-Gm-Gg: ASbGncuqP9jKKI3Am3BaGugtMrY0uI1i02fTQfhaK+0BzNjhcW3JXdAG/w+AttdPqYT
	12N860Ekcws8tzObFiaEO8ecxsVPF0eLO5s+wctXOwZ3T0f8zlC9P2Dp6OzEr1MGQEs8yt9W4+o
	jOz4Jz1oZKQCRFvdN/idno9UIkQg==
X-Google-Smtp-Source: AGHT+IEdykui222hm/ZWYGLSJ8TexC3iOARKnbXgoXKpded+UXemeqbT/BZzY3q6RLfstwRMsEnNOERjQExhvXa3/JQ=
X-Received: by 2002:a17:902:d511:b0:223:364f:7a5 with SMTP id
 d9443c01a7336-227913b871dmr50503065ad.11.1742809070900; Mon, 24 Mar 2025
 02:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324061835.1693125-1-kunwu.chan@linux.dev>
In-Reply-To: <20250324061835.1693125-1-kunwu.chan@linux.dev>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Mar 2025 10:37:38 +0100
X-Gm-Features: AQ5f1Jqf8saODp4jWXHiWsm4m-HG1gDbjXnY9txF5lZmpm0WlV9pTLQSxoUMJEE
Message-ID: <CANiq72=KjT8HRJA0NStHeqm-9286gay496CU8edNALPQ9_N+ww@mail.gmail.com>
Subject: Re: [PATCH v2] rust: sync: optimize rust symbol generation for CondVar
To: Kunwu Chan <kunwu.chan@linux.dev>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	morbo@google.com, justinstitt@google.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Kunwu Chan <kunwu.chan@hotmail.com>, Grace Deng <Grace.Deng006@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 7:19=E2=80=AFAM Kunwu Chan <kunwu.chan@linux.dev> w=
rote:
>
> Link: https://github.com/Rust-for-Linux/linux/issues/1145
> Suggested-by: Alice Ryhl <aliceryhl@google.com>

Nit: I typically use Link after Suggested-by, to mimic what the docs
require about Reported-by with Link. (No need to resend a new version
just for this :)

> - Remove '#[inline]' for notify()

It is good that the commit matches the log now, though I wonder if in
the future we may want the `#[inline]` for `notify` anyway, even if
LLVM does that one on its own today.

Cheers,
Miguel

