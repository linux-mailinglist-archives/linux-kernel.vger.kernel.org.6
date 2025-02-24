Return-Path: <linux-kernel+bounces-529140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15639A4205B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACB0916A8EC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B683524887A;
	Mon, 24 Feb 2025 13:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WC67035u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE21204C19;
	Mon, 24 Feb 2025 13:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403198; cv=none; b=ko83P2hUYyycUCF9uLdgW37/OQmNJX6zy7W7oIuRRFswkjicIU3Ml3yFaSiXwGZtlWd4bqjIXXd27xxmb4MP5Q1XII6R+KDw5CeOUOn7xzqLnge+TqgteGY5JfFrSVxmMsRiT1kn0D994uAgfssPHJexBt3EzAxdo8Fbaj0YoHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403198; c=relaxed/simple;
	bh=KA0U3yGXGRApRKSXSLe/A+8EbnTuZLr33bkGUSV34E8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cZJtbMGrUECqcI3xm4M0g8Lzu0ACb2fmTgUtPNPYJd4RVn2hoEcHR03Q3yxL7JJdTyqf1zn5qFgLjQ7iQWWUxpX4Tww2lw1/L4pulFQNnmI7wD9EviwjQJPub128UoQYUv7p0m4v91TIxAv4LBSQ2Q7rM7msv8d/KxUPdq7zhfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WC67035u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16342C4CEE9;
	Mon, 24 Feb 2025 13:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740403197;
	bh=KA0U3yGXGRApRKSXSLe/A+8EbnTuZLr33bkGUSV34E8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WC67035uEDhZLCLF+fM4DWybhrnc8ELZshTrBfgVskOrNof/rUw5S1UH66RZH9R5A
	 7KqdlmPoqur6lqx3I4SyvB8fZpyAloOMXdd3FO1dygceg5cPmEsgyrYKBEwfPGAgom
	 pqgbh7LmWC8CXMXHRciufEBtBDgnhah3lLf+SX57xKNrVXgD82rA7Xkl69usXlQFeA
	 /SRfE0pfrrXjn7AQ69Be8O2HXTWfovejM7dry8bhLAbF6u/hF3eB5a0qmESkw5fMyV
	 sdg8ahrlHW5EeD0FU9vyS1UABvb/lkUKlz7SCGZhVRjh1ya86IJOdOdqo4GGpBGvQ2
	 +moOnfmVO4g2w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Frederic Weisbecker" <frederic@kernel.org>
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>, "Thomas Gleixner"
 <tglx@linutronix.de>,  "Danilo Krummrich" <dakr@kernel.org>,  "Alex
 Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,
  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno Lossin" <benno.lossin@proton.me>,
  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>,
  "Lyude Paul" <lyude@redhat.com>,  "Guangbo Cui" <2407018371@qq.com>,
  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel Almeida"
 <daniel.almeida@collabora.com>,  "Tamir Duberstein" <tamird@gmail.com>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>
Subject: Re: [PATCH v9 01/13] rust: hrtimer: introduce hrtimer support
In-Reply-To: <20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
	(Andreas Hindborg's message of "Mon, 24 Feb 2025 13:03:35 +0100")
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
	<Fg4QliwzbHj3m-Fr3ZeUiU11d6Bu-I7w_9xzSsnDlzQtqCkjgqxJpI6_YxuXnB8m0MqESq6V7vK7FhPnEcvGwg==@protonmail.internalid>
	<20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 24 Feb 2025 14:19:45 +0100
Message-ID: <874j0j1nv2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Frederic,

"Andreas Hindborg" <a.hindborg@kernel.org> writes:

> This patch adds support for intrusive use of the hrtimer system. For now,
> only one timer can be embedded in a Rust struct.
>
> The hrtimer Rust API is based on the intrusive style pattern introduced by
> the Rust workqueue API.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---

I dropped your ack because I added the kconfig. Re-ack if you are still
happy :)


Best regards,
Andreas Hindborg



