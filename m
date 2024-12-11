Return-Path: <linux-kernel+bounces-441172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE2B9ECA92
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 11:48:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376601888969
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Dec 2024 10:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C75986329;
	Wed, 11 Dec 2024 10:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C6o13m4h"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6164239BC5
	for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914077; cv=none; b=NVGl/zMikgqzx7szI/FEUEqj1G5e4POM18pn7+LlJ6mj8iYHNRl3RX8ekWDekdNnU14W7U3V1LQKJHHdbTx1ns8QspnAUAyqlkVUSsX9Ble7yXDqCyV0xbO4HTFKxv9hYtcAdQ81aTEY+3mFjs6kSANkyxwO2Eb3KpltVscjg5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914077; c=relaxed/simple;
	bh=ERu2lMc/72OfKFEt8f3vEi+Cv/1iFh4p6UxkL5KOpoY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MF8qSWqkW2qne5cj5p4Ed6AUNpmnyNtrUDmNNoyJBO098qNj3Ihb2JNUhpgOB2vWfvR3N8j6XMXUKPn5ZOa5V+CLkvBmONE7y22t/kcU2sFbQD0rc6pSCqzVuny0+KHvD4tOq1GGWfr/ydX5rL43e63/qi2eaMA+oxuf7rKdkas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C6o13m4h; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385eed29d17so4277208f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2024 02:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733914074; x=1734518874; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERu2lMc/72OfKFEt8f3vEi+Cv/1iFh4p6UxkL5KOpoY=;
        b=C6o13m4hCdKTc/KH+oCL+1SOSBHF2cx3NNv+a2bwsycJKcvrBBeVV6Mx9ShESUiXQ9
         DqFjyjK+qpDxsPoWi0hH+FM9A2RULDUgL70dfJ3RsI5oiNOvG0qCm4NlzDEpDH0Sui86
         cyDXYWC5WcIfqXxJZAdN3U4/AYqmMwCE4HZ/IchBbiC4ahE/ggSqT9793SFZJXMEYD4f
         d2J286MGXYEiKeUyPiqFyIkJOzfA58trdaPBsTIbCyWH2AT+awmcaunkOOW1WH+v4xY/
         Arfs6x2mm7nzSk85OmNAJ/YMLKDGQzAwCMRbQhdiXlhw2ebndmv5qtl6tdQ6eg3bbl/C
         KJcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733914074; x=1734518874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ERu2lMc/72OfKFEt8f3vEi+Cv/1iFh4p6UxkL5KOpoY=;
        b=vEiSG/5500pWKTKXxE5md7VqELnu/MCuUGT9gTiDnj0ll+ZeZsmay+Ja7axpdV5Vao
         F805hMmEqdGlg6L5AQieHqzWzSP7cxjRdjkhNumSpBtCEGt2/4y5adWpwd7Gwth8daWY
         MtdU7+sLytipw9xl920k9/eaGHVVnNMxEZGVOU2/ajtWjdUISOyB2vbKPTwFQ089DADL
         g1fOxXfaXCEPzKgQh1+l4WrggRiLDwKvYpQblDvfCuHL6qIH4/D2XGwcFTRt8ozGth9d
         6NZgtCVqVkAlhFG158jTaQ7ILxV9Jty3fXvgCVLsuFwYvngtYtjndAtoN0x81WP34U+3
         s6fw==
X-Gm-Message-State: AOJu0Ywo+Ar1wRJe8mYVhREynvde0q4Fhpc2+VyWZBFvgrfaCp4nwvpf
	m+x3omE2IYjV2Jw0ymXJZqj+Z4f82I0CDJqhfVDryLzA8I2k2ANZ336/VXJcaoO4hpJBDwiRxkK
	KM7S6eFwP6+oKpZfV1lcG1ePcBwhmvdcWcEE0
X-Gm-Gg: ASbGncuJDF57QIGivf9DU8xGQSzMQzce26AkF3Ga618Rg88kODRFfSoEqmFO85RBH5s
	fYIB/aP+fDD0zgliDwIracaPbrp20DwXZG6HmNbqK6lip+SS7sKcq24S35hZ4NpnzhA==
X-Google-Smtp-Source: AGHT+IGzZYiIr4DmqK33UPgrCEHs0lpGIkyfv6Meyj2LzE+prTeJcX3AEtK+DtwnabXUfkGufQjDZqJ6OJwOOj3ZiVA=
X-Received: by 2002:a5d:64cb:0:b0:374:c4e2:3ca7 with SMTP id
 ffacd0b85a97d-3864ce4adf4mr1621477f8f.5.1733914074114; Wed, 11 Dec 2024
 02:47:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211-vma-v11-0-466640428fc3@google.com>
In-Reply-To: <20241211-vma-v11-0-466640428fc3@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 11 Dec 2024 11:47:41 +0100
Message-ID: <CAH5fLgiB_j=WbTqFs6o9-WaUOHC_-0+nPXT_PYD_1bZ75+2wBg@mail.gmail.com>
Subject: Re: [PATCH v11 0/8] Rust support for mm_struct, vm_area_struct, and mmap
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 11:37=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> This updates the vm_area_struct support to use the approach we discussed
> at LPC where there are several different Rust wrappers for
> vm_area_struct depending on the kind of access you have to the vma. Each
> case allows a different set of operations on the vma.
>
> Patch 8 in particular could use review.
>
> To: Miguel Ojeda <ojeda@kernel.org>
> To: Matthew Wilcox <willy@infradead.org>
> To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> To: Vlastimil Babka <vbabka@suse.cz>
> To: John Hubbard <jhubbard@nvidia.com>
> To: Liam R. Howlett <Liam.Howlett@oracle.com>
> To: Andrew Morton <akpm@linux-foundation.org>
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> To: Arnd Bergmann <arnd@arndb.de>
> To: Christian Brauner <brauner@kernel.org>
> To: Jann Horn <jannh@google.com>
> To: Suren Baghdasaryan <surenb@google.com>
> Cc: Alex Gaynor <alex.gaynor@gmail.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> Cc: Benno Lossin <benno.lossin@proton.me>
> Cc: Andreas Hindborg <a.hindborg@kernel.org>
> Cc: Trevor Gross <tmgross@umich.edu>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: rust-for-linux@vger.kernel.org
> Cc: Alice Ryhl <aliceryhl@google.com>

When I sent this series, b4 put the changelog stub for v12 above the
cover letter for some reason. Also, I'm not sure why the list of
recipients were included in the cover letter. Any ideas what I'm doing
wrong?

This is what I sent:
https://github.com/Darksonn/linux/tree/b4/vma-v11

Alice

