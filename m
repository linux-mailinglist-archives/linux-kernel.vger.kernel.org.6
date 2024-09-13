Return-Path: <linux-kernel+bounces-328524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94B397853B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A753288A9F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC296F2E2;
	Fri, 13 Sep 2024 15:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="iMVEhlTd"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E506BFD4;
	Fri, 13 Sep 2024 15:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242951; cv=pass; b=FNr6ON8o+2fpKAvYxOutNC18S1d8vM6EzELsBaT2rSwk4fXIpeoDtcX0Hvm7V+oqmku0+SeOdFTh0rUYiMNaKWMWO2QQXeL2pnE+sL5Jfcx8Rkt1tQ/R99dHP4nzAmdNR0Yb9RzLZv7qaL0bzBKklB6aSJJnoZqdhcOIqaK7Kbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242951; c=relaxed/simple;
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MA+LLByEMqhXe14b5XfVUoNqo6kq/CRpAwgJcoN0NGUNoYqgN4HTfZpFkIVZcm9Bdn2emTqJaR2syt31SDkfZCit+G8g/9Ei90HL2QzBhQ7ljjZUOOwXommTj3CXsEmyE66FDfC0kJCip8PEgXmUdNmUVfNenRbTbrH6HxduBls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=iMVEhlTd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726242923; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=mTsylh5Ko1Xl65mk647B50EUaYUtBj6pXDh7VGfC4FhL3eDeTBLtY8AdVCGJ5mip+2QtBt05TqjbIWlBM9lHj2/AC9tJ3Oz1fC9JdYRxMhjRvigpNPVl51Uwd1pJWS17HbuuRa1XPduKfhX52wAsV1hxUcJlm/XWo/o7j6J4h2U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726242923; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=; 
	b=Q6WFHvlURuaOhjD+C4JKsQ5/+zj9bUkmygHhoQ9395asgGntl80tF95KRTMBY4DuvV6Nr8jtRoLYkPDvolPtOwiX5ejKuefkuL3ULmURLZimd/IjrrDXXx+Pgr5jCVQT4xXKapKBZrSevaL7BbFToBMH8WRPi/JYfU+BcRyDa+8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726242923;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
	b=iMVEhlTdbMhEOgJRP8KndDTSf4YZxWi0Zvn6ew2ndnVZsSu9s3n5e5EGdqwXiX3x
	1H4RyhIL9LbuKQZM+556uVZDM5Se5k+VZoLLcB/Zz18CFZAh5eRriLMf8rRqgUXceyW
	pIc0BJDDgJZ3hFuhAkyfk5VCBim/cLW8uiUHJ+wg=
Received: by mx.zohomail.com with SMTPS id 1726242921220263.1030702448844;
	Fri, 13 Sep 2024 08:55:21 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v5 2/3] rust: sync: Introduce lock::Backend::Context
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240912190540.53221-3-lyude@redhat.com>
Date: Fri, 13 Sep 2024 17:49:04 +0200
Cc: rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@redhat.com>,
 David Airlie <airlied@redhat.com>,
 Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>
Content-Transfer-Encoding: 7bit
Message-Id: <4B16DFE3-2492-4E24-B5FA-30D822EA7E15@collabora.com>
References: <20240912190540.53221-1-lyude@redhat.com>
 <20240912190540.53221-3-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51)
X-ZohoMailClient: External

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

