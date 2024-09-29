Return-Path: <linux-kernel+bounces-342783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA32A9892FC
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06E661C22957
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 04:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF95026ADD;
	Sun, 29 Sep 2024 04:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="eCRCLb70"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E9322092
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 04:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727583536; cv=none; b=ihTJs2+0fCEuCfQi8Vv5b6GxWjgNBkqAnsn+mcOxxiCJf9sS+VvX6qoX58DxHZZOKs7oR8kCHr7ue9AN+6mxky4HBa0d3aA6RbMPYGbYv2Z5H3ZaWBsucC/Ha9wuvNBED0oTtk0q2h7f3GV7DAtslQ8KcKS2gDEAznnrRZmKFp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727583536; c=relaxed/simple;
	bh=f3AYE4EAY7+DIMSg6zZBDw1KLgq1Bt3GxtTiTGtRrOY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PEK8HP7esqJYmBVjrARCCQ+qN9/AiP303f4Bi/sLwupEWnJd2XBS7fD9LYnpNlogeFiE8FL7MYgwr59Ir/xSixoC7q0pwyIcQYp6LY3n1cmMTMaIyk8z8iUdOEfx7ieYRUdRSG/gkJ8v4BtbqnmxuALuGpZD4RyQFHLk/rwdiK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=eCRCLb70; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e24985919c8so3343720276.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 21:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727583534; x=1728188334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3AYE4EAY7+DIMSg6zZBDw1KLgq1Bt3GxtTiTGtRrOY=;
        b=eCRCLb70z8OxrwSlA6eC1Gm+AskYkDNr1/x1StOZJ18fsC6GiINFtN3953P/+Zi6Wd
         2fr/3bo/gK8IlVXmNuXesWDoUb5WEbJuhkAiPBrwVeOXgrY5fpsgfYDUAHCKenodXa7R
         6YlVZiz66/LZ9KmGyE1byMhsI8xywZcy8eGfD1tt8nN2dKlveGJM4w5+V69bOqRr0/Tb
         e+eXNtasojd0AeLtc0YKbRgy8I0A6tnD8txJMkBqzBsLdLWhAcE229bk0UCfDa3VJC+P
         boeOXWxoM6LOpWhzAa2594TTzT9utzX4af1TlI8Z8cG/8t3jZ/M+f63Rp3L0nmhaK47P
         3QKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727583534; x=1728188334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3AYE4EAY7+DIMSg6zZBDw1KLgq1Bt3GxtTiTGtRrOY=;
        b=fDIFwqvVlmj0h1sIO6YC4SuNPjZNK8sY0Rhuc4js+oBhAo1ujU9kac7cQY7mDWGYhw
         mJzLUGgpH5Maz2X2Xlu6cvrojHDQi+uZf3A63nHpmPwJvL1Be4/OT1MWfToaqKDR4usO
         VwjY1cqab7MBxBzXUNRIF7gwlHs9bHzjwO/Xt0i8pqm7flxSWdKW09KT2K+85LOxdYR/
         q7mW4Tmvir6/TPb3jSN/Vyl89bKZr+VrF010phfQ/9Lx4B0P0L5sn9WyDQ3SGmFNpQqe
         UPWaoVxP6kS3ECC9Mf5kAjEdR1n4iibZawKlI+NW0jzSVKvRnwWd2rVuexNjh99o+dkl
         Uwsg==
X-Forwarded-Encrypted: i=1; AJvYcCWH528trRgIBewAh89ugso1SGBGUTHsnrKucmiD0RDhukEnnfaPzBzUNM1gxGIDown5W0FR9qiasELndck=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyt2urP1yxwhlQlQgTLYKR0kcFvzfyfys9hVvpBzzn4rgJ+n9j
	kPEbal4RbFSYMSvOEX8nT9dvUzJkxqnsByVnB9v9yUqwrtsEnMV4nI/ps7NyV9ZTHGHzfxmN+km
	2hS4fVKWChK6zQcU3Z1v2YrbKcVpSIsiOeXoLnA==
X-Google-Smtp-Source: AGHT+IH+HCA/i8rZh8JidjsUomu0azwpuBChRZ5m/iwQKitnQIu0YDMzjdhAOLhRYeUuP7vLilNtecFjiWVpiz02oWo=
X-Received: by 2002:a05:690c:448f:b0:6db:da26:e8c6 with SMTP id
 00721157ae682-6e247610a6fmr48073547b3.44.1727583533702; Sat, 28 Sep 2024
 21:18:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-3-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-3-ojeda@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 00:18:42 -0400
Message-ID: <CALNs47uftdC2wY=Se9dx_cavd3yB6rJ09NSf2CHDtS31OZMjKw@mail.gmail.com>
Subject: Re: [PATCH 02/19] rust: sort global Rust flags
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:44=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> Sort the global Rust flags so that it is easier to follow along when we
> have more, like this patch series does.
>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

