Return-Path: <linux-kernel+bounces-437585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECB09E957B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5E216531E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B4722A1FB;
	Mon,  9 Dec 2024 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyvItAdt"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510B8230D23;
	Mon,  9 Dec 2024 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733748931; cv=none; b=rvY62uQ6Eu6CqnNgizZzuLS/BuF7MZT7fSMp99+vy4QB+IbAsXr3KzV6RTqZ1MXysioIyA/ufWuAy+bcrXUVxGSodkA8Y72lToySe+v7oHmENQSoh7cZa75qo7LaDQobMoJ63uiPN1rGSzLH0OYGu7tz7B5KcCDMcQH7NECgaqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733748931; c=relaxed/simple;
	bh=SI85qI4aYVhNTkWpJ+X2AtUKzXDM9U1usOBZ8go22GU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NYJgNvwpirh3uW4T4c/NSSjxQE8R3TDtnFYuYqkxco6McrAUI34JmhvQaAhtRPuIhKmSWIxACojH0gmlCjIvvAhR7KoZeK/w3kaSlGOfZKVr5ovoeULoERosUG3ZJfGlt+8NnxJ/Arpd+zBcDakQfyT1gJZC4v2274/kDS0ES7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TyvItAdt; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-725f4025e25so448796b3a.1;
        Mon, 09 Dec 2024 04:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733748929; x=1734353729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hlm+0UDjIRRqTSMlzzjiAUEABuynPVGrbkA9eGipCa8=;
        b=TyvItAdtbMwd6zZu5xo8LuznaIT245EPOqJL0qMKQDZfnGQndaTF7QlycnM2ppgHz8
         Z4o7+8CC4i4y6zy4kyIb3jfd2i5/7kPQq69IH8egkT8S0fi15SV8gG0hsCmWVpZ+r8Nx
         UiFrHF51r9TM835Qy9VmFamM1aXnFZmFtGDOKjbd/DqWGPHWfGkZ0CMCKuYRe9m/ps5n
         nYwHHiX50ujr1BvcycwIJpKEl/LBGDpPxEfVX/Rg2DmRif21d83CKKVnzEgul27zGUUx
         6D3xcx8401XleTLEAtk4wcBeF7G/iae9teNDO0lcIpTCFHU0zJPPzWsxEyzS/MfaqfC6
         SfxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733748929; x=1734353729;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hlm+0UDjIRRqTSMlzzjiAUEABuynPVGrbkA9eGipCa8=;
        b=roPLBGSRheODGJycELtxln8eF5odLdrcvyJvhTXdXrakDUP4uxfxidv05OHpFffvHS
         NgnKQHHZSrZ9hoJuYfm7OFLlr8g8OAMKlTcmivzBGOiw+Zr0RXX8Jq/u5pDPU+Kk0ql8
         6GUYo6h0RdwQ1Z365Yqrf60BChnr2BllMgO8IsjwXpV/m/1ddmlGI+tdeyAbthxu8ypn
         ny/FnY0VTR8PHLto2EwXvNoxI0Lf1cgkNfVkOgUmzt4dmMBLFg1cK8pPMsxa0A783Mnj
         UNagLZj85LMqHnsMR77B0HLxmq2bctdoWWAAjf/GePaRcyW7cKDzdaluFP0oP7BganfQ
         Lirg==
X-Forwarded-Encrypted: i=1; AJvYcCUfASgOogqgXj/NCbtDqRwhw/rp9gCZxLOo+jLE80H6cLpmCO80BMvqF6urvFAUwiD7IkYaiB66I+7h6DpKvSg=@vger.kernel.org, AJvYcCXLE9EcrIRqj1nqfSWBnq2D4XQhESh6j24WHzm+A+Mp5F2ofaoUE3zwfNFyDWq4U6fmh1BxWuv27dGF+Nw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEBKmD59tnIRJgMT8C4NYs8ByXkCXi4erE5Hi1wdojC0q27rbM
	pRXjJ/n4iZwFvt6LEfmCGaeMNo0F4xJOFBGgiXH76nWtdR3h+/Kp
X-Gm-Gg: ASbGncvgJrJtNJrvyZCCM94MD7ivl5Rnaqs0aWQZSYVmNawhUZgLv3VD+RkvskIksse
	ItQvA5yt8IGZJtfmAFdqsS+AKqAn9SzxqYBCLtRozAlt4wdLXI6+kqR3tzC+gUczhwOzgrlyWMZ
	SaxZ/JmI5fGOwKRZlF/NGnp2tm6apjKtOgN3oLcWfqrW/4xWUAbJ02C6/neKRJN5lr/U7Y+RpX/
	TF5AtbOzE7vSUqxcwcQe4C6PuIYyksQHgv/FaiVggLJRcfClaDXkimo
X-Google-Smtp-Source: AGHT+IEacy22mT4e64ZXJ4WAg97dV3C+p2p0yUemPXEWoIje0nsDx/jq9iYUBnzOsbhqr7dspojk3g==
X-Received: by 2002:a05:6a00:4b03:b0:725:456e:76e with SMTP id d2e1a72fcca58-725b80feb59mr20056668b3a.6.1733748929407;
        Mon, 09 Dec 2024 04:55:29 -0800 (PST)
Received: from linuxsimoes.. ([177.21.143.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725c9ef18a2sm4462148b3a.86.2024.12.09.04.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 04:55:29 -0800 (PST)
From: guilherme giacomo simoes <trintaeoitogc@gmail.com>
To: miguel.ojeda.sandonis@gmail.com
Cc: a.hindborg@kernel.org,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	daniel@sedlak.dev,
	fujita.tomonori@gmail.com,
	gary@garyguo.net,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	tahbertschinger@gmail.com,
	tmgross@umich.edu,
	trintaeoitogc@gmail.com,
	walmeida@microsoft.com,
	wcampbell1995@gmail.com
Subject: Re: [PATCH] rust: macros: add authors
Date: Mon,  9 Dec 2024 09:55:20 -0300
Message-Id: <20241209125520.414960-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANiq72mh2_QhHcE65-t+6UEEqe+9XwGQ3gJ1CCQpZ6r3HOcokQ@mail.gmail.com>
References: <CANiq72mh2_QhHcE65-t+6UEEqe+9XwGQ3gJ1CCQpZ6r3HOcokQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:
> Yeah, that is a good point. There are hundreds of drivers with 2+
> authors, so this could indeed be an issue eventually.
> 
> Having said that, we already have e.g. the `alias` and `firmware` keys
> that take a list, so I think we already have the potential issue, thus
> being consistent in our use of lists sounds simpler (unless we are
> discussing migrating those away too).
> 
> We could also try to mitigate the formatting issue via e.g.
> `checkpatch.pl` if needed.
It is true, we already have the formatting problem with `alias` and `firmware`
fields.
If we will follow this logic (doing equal in C side repeating fields), maybe we
can end have the lines a lot for modules that have a `alias` a lot, or
`firmaware` a lot. Two example about this is the `sound/oao/fabrics/layout.c`
that have the 38 MODULE_ALIAS and `drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c` that
have 77 MODULE_FIRMWARE.

Maybe, have something like:
	authors: ["author", "author", "author", "author", 
		"author", "author", "author", "author", "author"]

and having a check on checkpath.pl doesn't seem like a bad idea. Because for me
it's better than:

	author: "author",
	author: "author",
	author: "author",
	author: "author",
	author: "author",
	author: "author",
	author: "author",
	author: "author",
	author: "author"

due to the fact that we spend more time scrolling the screen code than
programming.

But I don't sure. 

Thanks and regards,
Guilherme

