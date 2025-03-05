Return-Path: <linux-kernel+bounces-546876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DDBA4FFF5
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 14:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB1F17690F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 13:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0B21FCF4F;
	Wed,  5 Mar 2025 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoLxqWEI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F7B24A063;
	Wed,  5 Mar 2025 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741180132; cv=none; b=FN9XcJu2yuGAeB9iQmGEulSk5dabYByYk0kLLmZXuM/U6nOKZASlcQg1S2hsea2RikIoE7CMT4Sc8bsfGyy1mz+RBMZdgmfBwR9dHs/sq9S7vXWJsR8EcQjmCXTgd4MFHfivtuWv/Eo9XaublGj8vdqefFiwIcdpoLyaxCIEa1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741180132; c=relaxed/simple;
	bh=pcZq84me13p8LuFoAmudOHo+js4dSQSGZrhSwrVgTNw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PDPE8nLKkmb6o5j9xn7trtOSd3p4xHtX7J7KgT7Q0bZDSPQde09aOh0jwjw4Yn9jmLGk1aYdawCpCX5Y43YzuEowRLIv3CMkrMJyJZ/dCniFsTz1W8jWeqXZ2LzyhLmsb66Dqw7KBW35bw2R4eE+6ooapyfIihKG6YHLjTcogYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoLxqWEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE7BC4CEE2;
	Wed,  5 Mar 2025 13:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741180131;
	bh=pcZq84me13p8LuFoAmudOHo+js4dSQSGZrhSwrVgTNw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=YoLxqWEIVLPfz0gNyyq6vfB7Ss7yz0PyFcmWNY2gKurnfNZXlUZQGFjOxl0qjcnoJ
	 Jv/saehov5gvQiwrlszoj7ZVmYjnQeCAldxifOi46qXONBQs/ZeG6kHNaW6rb71O5e
	 Yk7oxpkCK+Wjtkp4ymKdek8Jhh8lJE650v1SadR7I7WWZtzlsAT7tV6QtRwYTFJbtY
	 y8UP6Rq9VsI/PUFQ8mLD/7QGS+/KzsHx48AIrcTRUYpzcQHFTaDhKDxRyNB9QmAMyy
	 Ag0pVQaVdojj4doZimXAfxwfN1MYdK1f1AK8lR7coxrB04loe08h0vrimdYheOF8//
	 E8U4KbZTZa4QA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Danilo Krummrich" <dakr@kernel.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 17/22] rust: pin-init: synchronize documentation with
 the user-space version
In-Reply-To: <20250304225245.2033120-18-benno.lossin@proton.me> (Benno
	Lossin's message of "Tue, 04 Mar 2025 22:55:42 +0000")
References: <20250304225245.2033120-1-benno.lossin@proton.me>
	<wL8KKKv5FDuKbFRpqB4AUsTsec8Zodg7qwdhplFyLC22wTOaAI-oCS4V8N40NAmc5soMrgFzRF0ljEa_RTPNjg==@protonmail.internalid>
	<20250304225245.2033120-18-benno.lossin@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Wed, 05 Mar 2025 13:52:59 +0100
Message-ID: <87frjrbpw4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> Synchronize documentation and examples with the user-space version.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



