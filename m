Return-Path: <linux-kernel+bounces-531968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA790A44730
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13FB13AA7AA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA96D19EEBF;
	Tue, 25 Feb 2025 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Plc0twXl"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755D119DFA2;
	Tue, 25 Feb 2025 16:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502433; cv=none; b=EVGrMPvlB+In0M6iKnixWceeNhlJDjxSkxe052vymWacRzSPFk52Jp4yJyzuPWyooznIodD64WOjnlkBJUtLoQWl/T6FbyCJBTmX7gpBiZwcWeK1Tzd27H5GipFRTa98NCtYjx+cQy6Bek/TjqsDX1OoYBbbboiksq+Doyr8fzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502433; c=relaxed/simple;
	bh=fAZ9eBfqUZ1j1hJE/SKqho5/8TZT9csYTO59O+is2ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CiaqxvqZmU5dYjB9W569mI2n61VZRQcG2zSIBfYEJq79vxTlj9uEIEL3VWO6KHoKHjG1876QTx7/CMZBwrjLfUNtZT471xjIl2YrKlxO3xpTSXI/r48eOage2FHEcvFpHY72M2ehidxmzyN/M5/qrUh2VbOHNAXhtja8H/LH6zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Plc0twXl; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-46fcbb96ba9so71193991cf.0;
        Tue, 25 Feb 2025 08:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740502429; x=1741107229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8bdae5F+VYfuzrIBEblkvYdYq9m8ykaFmUEScrQDhWY=;
        b=Plc0twXlEqOoRpeEMLVcPpeSjFk0AStf0c4d3nftTw7ZnYR6o7vFwng050asiDzigt
         Wzczr7UJlO70fbjXy8aKu8IIUMnePz4uzwSVzp2jfX4+4j7lXa//iylosisscXAfRgVD
         3SclX9/sYD6LQuKlDPk9g3t7Pb4dnKgFXB2aL1gT4/y96tAMJ2BfdtWlrgv0KNBcMVXY
         wdNYD+uw+lIwQQOgBx5R2YxIb1fPnS329ZDbayXqF08AumnhfpFen3msSb1Noosjp+yO
         tZlXbv+AXRKDyOO4XwfEgZM/j+nhF7GO44Rcl2y1iUjgrouiRM/VBH6iQJhhjQAHZpC6
         slIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502429; x=1741107229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8bdae5F+VYfuzrIBEblkvYdYq9m8ykaFmUEScrQDhWY=;
        b=JU8OvTlgx4qeoCI4DxaBTR+DPIxt/skoHvFtz5luWTHhz9X4okJz7SRX2cK5Zx6e8v
         /7TEQzdHeLn5d2wSqOqDp2/T8MzXW0/AHMAYb7J2KuML6TVdOUi8GdOBr9Zb3YqYWK+w
         jqYn/Nqafx7Lx+571UNDopZ6xaNSlTbz9fv0CmLK4paQAv0J9yuwv3Hci5ScOw0VeyDc
         ZlewcLbMpdS9ZFJ2KIHeT4MNF+d8A1anQzDtCrmuQs1OaKGUuiSTrhxKFdxbAw9KVIQ0
         EAYF9KxKjXo1iLjRq5pEtRNP0FlH5bejMR9NO2ETE4TvRtUwvqLzHbX3G/iyP9K7mpfF
         5RnA==
X-Forwarded-Encrypted: i=1; AJvYcCUz0oMeBFFjAp34TTQkaeqqC9qWvCbwwK/kYwsPHeN4rho26KB7VQQ2uiDFKAg5AMfqtbMTZy/Mai/mBMy9eg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7FHKi6RcrL/IRER15LTWwZDL5pD5R+OlZgqhgUOQ4G4vc5ppQ
	VNqtxxuJVpp4GUpvqQjtQs/wlVR4uPTZO+GPTiUG2A+PMza5XJJt
X-Gm-Gg: ASbGncv3DnUzJVneR/gd56MF1+uFucsrD9ygfv29x+obTRy47Q++x21QaJjUjl6/QFH
	M+168EBbhdhcUoyEb7wgCDPDNIdf0ZMXDCqPasm0YcTt2Q9SurJyZlMKtWIpC3wIrqzmAaM9XxN
	BR2QxSV6lafA+OP/sogEf3AnCrQhLjue6avXtU1ETZimJvHcSZGtq6M0+6cAlwBpEi0sQMecdem
	iRDCHP3cla0VaCg7NS6oOphw6I2ZzcerJ+yQdqvGS8gCZq2gcV9xbnW+/VlmtmVFs4R0EHgHoCH
	ekFhgaLeFRZCY1amoV8+e+njI1P1NrLIAqygYdpY/Xt7VG6n04xfYYS6u0MTv+T2mNfVVH2wWmw
	v6Km+r/X118WMQa97
X-Google-Smtp-Source: AGHT+IEdAlXI9gLk8gU5udKtO9vQTmAP70Bf9d5luqy/QHbshdtVPFsvLdDyNnBaZ3uXW70i7Xahag==
X-Received: by 2002:ac8:7f51:0:b0:471:eca0:1135 with SMTP id d75a77b69052e-4737725d52emr49743711cf.40.1740502428751;
        Tue, 25 Feb 2025 08:53:48 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47377e071c2sm11930861cf.10.2025.02.25.08.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 08:53:48 -0800 (PST)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id D6A9D1200068;
	Tue, 25 Feb 2025 11:53:47 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 25 Feb 2025 11:53:47 -0500
X-ME-Sender: <xms:m_W9ZwFv5B-L0DBfAQq7kAKGnBzgm8yW2l2PIA1C9D50RuqMZiv4sQ>
    <xme:m_W9Z5VF4Eqy8zr1-8gMwEYXNAOcKVHAFccNQYtbTL4sv9U1DinQayLAZSFjRdORR
    MpUYj4A8AgMzYcxhg>
X-ME-Received: <xmr:m_W9Z6LWvbK_Wi_dTc8RNr_EzjhVFOkqMghS2nhf5utnVDiLX-XKHE70Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekvddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrih
    hlrdgtohhmqeenucggtffrrghtthgvrhhnpeejhfeikeekffejgeegueevffdtgeefudet
    leegjeelvdffteeihfelfeehvdegkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhu
    nhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqdduje
    ejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdr
    nhgrmhgvpdhnsggprhgtphhtthhopeduhedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoheplhhinhhu
    gidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhush
    htqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepmhhinhhgohesrh
    gvughhrghtrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlohhnghhmrghnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehojhgvug
    grsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:m_W9ZyFb5Uc9vuFNsBspS5ZMZpwOp-UtoC-FzDF5uTv6vjfhSZIN6w>
    <xmx:m_W9Z2U3N4lvgrEjIQzNPDaZAAL_h5qwwJiaJz48ZB2ApiuHviNmGQ>
    <xmx:m_W9Z1PwSTDLmDRE0M-iQPWn2LrlbPTgcdSmehM6h03bWVJSEf3xCg>
    <xmx:m_W9Z912h_abwn0eIpITxof1Fl6TG3E5PHML1Om2fvb9NBPOBlvLdw>
    <xmx:m_W9Z_X25O6fun012i9ZeKl4W_7EntffNmOOsBAIE40sYD9_6XnQX8zh>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Feb 2025 11:53:47 -0500 (EST)
Date: Tue, 25 Feb 2025 08:53:46 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>
Subject: Re: [PATCH] rust: sync: lock: Add an example for Guard::lock_ref()
Message-ID: <Z731mvxPATfDhQ6l@Mac.home>
References: <20250223072114.3715-1-boqun.feng@gmail.com>
 <CAH5fLgi2iXKg+Mwze41KHk1rLa1=f7=ofhbq_wz6mxmC4GNe6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgi2iXKg+Mwze41KHk1rLa1=f7=ofhbq_wz6mxmC4GNe6w@mail.gmail.com>

On Mon, Feb 24, 2025 at 12:19:27PM +0100, Alice Ryhl wrote:
> On Sun, Feb 23, 2025 at 8:21 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > To provide examples on usage of `Guard::lock_ref()` along with the unit
> > test, an "assert a lock is held by a guard" example is added.
> >
> > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> 
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 

Thanks!

> > This depends on Alice's patch:
> >
> >         https://lore.kernel.org/all/20250130-guard-get-lock-v1-1-8ed87899920a@google.com/
> >
> > I'm also OK to fold this in if Alice thinks it's fine.
> 
> I think we can just keep two patches :)
> 

Fine by me.

Regards,
Boqun

> Alice

