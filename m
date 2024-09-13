Return-Path: <linux-kernel+bounces-328523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8064297853A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B981B1C224C2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D506F30E;
	Fri, 13 Sep 2024 15:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Z46ER/fx"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87CF6D1B4;
	Fri, 13 Sep 2024 15:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242939; cv=pass; b=FVNUR0X1Mlhreh0oL5Z13+5kgTgLD7gMxY6ERQJEYRau3gHn6T7/VKZNLY4MSASGOtuhkF1mh5AOZ+G68S4tQ8iRwdXDL2nLzmMy4Zb13YvfpCtjKuU2lnzIivn36d33uVI8nn482rzSBw9GSdx+VUxNaMB3M0urDcRe6AmBVCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242939; c=relaxed/simple;
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=hvmpEnp28W0CVLYHOQTEiPjsCg+1Ye6Ux1G3enD0jms7qCtRCk0XbGrt9irtDArbn00t5xDrJO9KYxpdu/RFLO6d3XmvYxyPJaF7Xk4sbHogh4AXdnR0JI0hIWuQv7DJjmNlEDAhuV3kWGfKcfpj52EyEGAwSrbRVXIKQvuPMGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Z46ER/fx; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726242898; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=VVw9DMcLQRM84QnM68LTQBkEItUrLRaYyCqxQcAkqWcQ1g27Y2Q6ER0BltJpO9EKC5vxCXioMktlaGCgrtoSD0/RfzprDzZm+WyVTKN59JDIe+Qh/8XDoiWDtx5LIilsFOUYmsH5uKfDI6xCmMFQxKcsq4fNYQ8eUFgnw/br7E0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726242898; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=; 
	b=aandjLA3cSDGYo5M5P8I/MIGu8w0oweSvHMAScJLIbU1/79Idmph2qcibzL0Ri1DrKxAE59xekQsSo1eZJ5wCSyugNofg/bQHnXfO96azIGTzjgWHe7iZ1MFje5KrsvVSo4XGli1u926VabsQ03MN3KZu+5hv+ZHs0Xh50L7NDk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726242898;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
	b=Z46ER/fxkFBPsRh7Kp01WYRSdqnKesP8v4cIwwe6wV9HbQCcDVpGrtul3kYr3Smz
	dfeM89DQNf9MnyCo/Bb69SIaaUQKF+Zs/tqbX64xQGXx9s2w8mJD8Af90pecn6TleD5
	6ed1D32wBCdogcusI8IMNac8aFtOJZQDnuMCiMvA=
Received: by mx.zohomail.com with SMTPS id 1726242896080493.21314640306775;
	Fri, 13 Sep 2024 08:54:56 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3776.700.51\))
Subject: Re: [PATCH v5 1/3] rust: Introduce irq module
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20240912190540.53221-2-lyude@redhat.com>
Date: Fri, 13 Sep 2024 17:48:38 +0200
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
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Valentin Obst <kernel@valentinobst.de>
Content-Transfer-Encoding: 7bit
Message-Id: <EA7D3895-32A9-4EE8-9B86-CA40D7A85FF7@collabora.com>
References: <20240912190540.53221-1-lyude@redhat.com>
 <20240912190540.53221-2-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3776.700.51)
X-ZohoMailClient: External

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

