Return-Path: <linux-kernel+bounces-404154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B03F9C3FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 14:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3017E286053
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 13:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C2D19E82A;
	Mon, 11 Nov 2024 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBxND8Qu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622EE19C552;
	Mon, 11 Nov 2024 13:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333130; cv=none; b=G7jicl+u+V5+l+59RtwN+KLQ5+hKOqrDCzjM6naf6wC38LLF6pTjscVKXGbfY0D5WnibB2QsiFFrqZhdRsQ4qZ7jJcxFaHWmrfW8Kt/kHr2bw/l+bI8xwbqup/XaOy6cl7B6xY3Rvce96h4I0xVWaT9M8fd+lxSkd/vbPCDgN74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333130; c=relaxed/simple;
	bh=QxF/kLnSp35vJXvisUEwnI1LBa6wyV6iJAHjZxY0B2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=F8VQ8XGw/sIP9GJRVLoKKwA9bcAg8ru2neTXiM97BRzN0jWgRHzod2SVClXZvQpNRLdYlehVdrKoKhSl8e3bgi+UedGC+8/uRNHcQuSjBjaY6qiHton1sdGUFcGKQglkp24vxZrw1hTkuSY5Rqxcu1gMdeAOGr087WYsM1M8RpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBxND8Qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33C7C4CED5;
	Mon, 11 Nov 2024 13:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731333129;
	bh=QxF/kLnSp35vJXvisUEwnI1LBa6wyV6iJAHjZxY0B2U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cBxND8Qu9cTGbaT7QfeYp70ZWP2tXTwzTvXIHRapuEG0Ql+UwTfi/gg7nh5mms4jE
	 QEjOCra/die2mSlP2N7KOW34mEQPiZJzZYUF849N0M/crm3qoJrRTzeofoQ9Rf1SPl
	 hErSIaRuKagLCGffIyjTSD6oy/Ig5hEtxexOdwENYVKF99Ht/efEgfEBz6k6Wf2mHp
	 F1GPtQXkEdc40wtc5WuPVcY5mM+CgSnEt+EcGjkH1UV/73cvWbjA5p4IyyCVG5uoIb
	 d6W9Nf7bx6i4HF/LsAZwxty8imOk2T+LUYz1brFyZLgM9Gyn13nVu3GSgVZPOYXq66
	 rMjkX0WRj2eZw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Dirk Behme" <dirk.behme@de.bosch.com>
Cc: "Alistair Francis" <alistair@alistair23.me>,
  <linux-kernel@vger.kernel.org>,  <boqun.feng@gmail.com>,
  <me@kloenk.dev>,  <benno.lossin@proton.me>,  <tmgross@umich.edu>,
  <aliceryhl@google.com>,  <gary@garyguo.net>,  <ojeda@kernel.org>,
  <rust-for-linux@vger.kernel.org>,  <alex.gaynor@gmail.com>,
  <alistair.francis@wdc.com>,  <bjorn3_gh@protonmail.com>,
  <alistair23@gmail.com>
Subject: Re: [PATCH v3 00/11] rust: bindings: Auto-generate inline static
 functions
In-Reply-To: <9369b621-47d1-4967-8a68-874bb602deeb@de.bosch.com> (Dirk Behme's
	message of "Mon, 11 Nov 2024 14:23:07 +0100")
References: <20241111112615.179133-1-alistair@alistair23.me>
	<bR_L15e11CHC0AS4d41vkbo-whYRfTKoU_htcjK8F_inG0Y5HQslqOWHOLBeNTCYqsgSqOtHXeoOj4ifT5ndJA==@protonmail.internalid>
	<9369b621-47d1-4967-8a68-874bb602deeb@de.bosch.com>
Date: Mon, 11 Nov 2024 14:51:56 +0100
Message-ID: <87msi5swsj.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Dirk Behme" <dirk.behme@de.bosch.com> writes:

>
> It builds for me now and the htmldocs were built as well.
>
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Does it build for you if you have a clean tree? I think there is a
dependency issue in the makefile, as indicated in another email.


Best regards,
Andreas Hindborg





