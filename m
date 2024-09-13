Return-Path: <linux-kernel+bounces-328527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4006097853F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 17:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7956E1C212ED
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 15:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B87774070;
	Fri, 13 Sep 2024 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Oj7sKpS1"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03BB2BB13;
	Fri, 13 Sep 2024 15:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726242996; cv=pass; b=MigHN31HHY/YZjXa52xq2q1fCPVlJ5wFShKWNIGyzx92vONobplTVGTsxmYPAMxTzmlq0YPkmlWnQ0X20gn9wy67Qu8o29mgwlaMV9r/p35MLcFHZ41RZVXuu1n+by6xsif6cWWHUEp0pe2XGQ3rZFhq1HdYEHBEtBwhQ6k3oWc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726242996; c=relaxed/simple;
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=iGWLWd1vLYR2CmZ8/isvF/tnB5B7+7yeL2uKHaY05ylo9jm42Jr/z/zGgSQGuBdzn7tDD8+911GHMzpHSvoYPhYE4B/tQ0/4eo1PJmFzwXICIUfF8SWfR5eKdtUE1zRM53wraDY5CZms+gc9v4VoV+DMl9z6zcrrx5fe99uaIUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Oj7sKpS1; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1726242969; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HRN2i3NgyF8T+AQx2iIiTQBatW6mlhaQ/6vqm2xgUZOwP0WywzBSmrVRd56xyrZwUKzcsa8lAoPYrg9AJ0M5iyid3PdXows+eLdwiac+fE9RzIokM76EjzWOEv08aBegqRPYy3bdMJfYiuH4Ofe7/4mCZ3oGNZWoVmx++uYRZZg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1726242969; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=; 
	b=nnqB2RsY3lJFmVKnF7HdhHI4SuIR+C3Cprdmfvi9+7xbO3XAhhH/sLciyq6UNjhCZugYA0fRjLMl3qFuKRMt/UUXPCL5eG6VXZa2ZE9LJoCew2kgvh1mcVARqG/n/2421t7TouIkL5HSL8T4kVYVHQ3Y0Ltq+mRGtmxyP0gjJ4A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1726242969;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=aTrG2U3nnsahZNHEmxNMi33V9p9IP53O5HAC6ElbmRA=;
	b=Oj7sKpS1bSVG7YxkvXL8V76VjlKKYQKVSsRtCuGHTlTTjqEXTKTk/lBgG2SaQ/zI
	wfNaw3ppINs6tpnuP1qq4kiwzOqrCQbOvnfAcH5hrTtfe8Lh7YN94j36td9b5Jgd+P3
	tsjt8Wy3xBGxVUa6dCpMzYrfd7hlYYiIAItceTU4=
Received: by mx.zohomail.com with SMTPS id 1726242967822327.13111016610935;
	Fri, 13 Sep 2024 08:56:07 -0700 (PDT)
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

