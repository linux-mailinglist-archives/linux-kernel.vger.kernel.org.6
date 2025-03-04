Return-Path: <linux-kernel+bounces-544125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A25A4DDA6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE871783BE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D51202964;
	Tue,  4 Mar 2025 12:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqsWzjy2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFC41FF61B;
	Tue,  4 Mar 2025 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090594; cv=none; b=I/GDazbJGZ+p5UFoTqjnOKpO5TTlgfYVblHReTHa3NQOBNqMvdL9QUQ0FesbBlLhJWxtSyE6sQ9Z4fzjHW3fyylr4mI/cZELhXV0yxuucUvdtiXdTvK8yKWVdoTZsn6mLSKxiIjWtJV7Nyk8fULnpRuTppm8yrrY8nUQ8fQYKxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090594; c=relaxed/simple;
	bh=9JPCPQ9VllTi4dTdR5Ev8ixRZQkQn+UCwS7J79lbP1M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WuhvBYIYorY65uAY8AeyueuaOgwIg4uKJoDKAGqnJEulQ65A0yrH6fj2oiADwsjsrQXPv3XKzqmVVQSEQmDQFd5F1K/0y0ZpGUsEs/hRCckr+Zkj8+1bWk6unO9mQajMDBM3Y8d5FvpmNP21/90+O3xMVGkjWnlDYt3uNydWH+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqsWzjy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B24C4CEE5;
	Tue,  4 Mar 2025 12:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741090593;
	bh=9JPCPQ9VllTi4dTdR5Ev8ixRZQkQn+UCwS7J79lbP1M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oqsWzjy25XiDEpmdL6iJNaamC+7F0cBvEGrKxz1cI3Mk42lL5xim05HPyx9HuA1HS
	 /CDXzs5aTWkA6xyYV9a3fQBXkR1QlN12fP/7+I8HEEYSkxFLr/R5eoh5+4n54x/+84
	 qgGCs22pB4FG69ocfp2T3SD871GJX6PZWIOD+Od2hW4UanqYaHlQqK6zyCHlNpIsDy
	 lqWdRmLiWyNjXyMC98i0ahF1SmGLaTuJ/cxPZb8AhJ32/v++6CfCgLmJbrbdJ0kl8l
	 hGf47rTuhEDtTUfJUaV7O6uar8Bx1XTDM0lekzYTQFD26Yvyk5cZsmnQXjLFGXXK3C
	 S8uj2zTkdDhIw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Guilherme Giacomo Simoes" <trintaeoitogc@gmail.com>
Cc: <alex.gaynor@gmail.com>,  <aliceryhl@google.com>,  <apw@canonical.com>,
  <arnd@arndb.de>,  <aswinunni01@gmail.com>,  <axboe@kernel.dk>,
  <benno.lossin@proton.me>,  <bhelgaas@google.com>,
  <bjorn3_gh@protonmail.com>,  <boqun.feng@gmail.com>,  <dakr@kernel.org>,
  <dwaipayanray1@gmail.com>,  <ethan.twardy@gmail.com>,
  <fujita.tomonori@gmail.com>,  <gary@garyguo.net>,
  <gregkh@linuxfoundation.org>,  <joe@perches.com>,
  <lukas.bulwahn@gmail.com>,  <ojeda@kernel.org>,  <pbonzini@redhat.com>,
  <tmgross@umich.edu>,  <walmeida@microsoft.com>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 2/2] checkpatch: check format of Vec<String> in modules
In-Reply-To: <20250223174205.48404-3-trintaeoitogc@gmail.com> (Guilherme
	Giacomo Simoes's message of "Sun, 23 Feb 2025 14:42:05 -0300")
References: <20250223174205.48404-1-trintaeoitogc@gmail.com>
	<sTx6hWX7CKjlAu5OEpL0eUrR1ipEoN4O81qJP2P051_dYkDZRa_PDcgThPD_yy8047kutZHqeSx4Nf0i2RUAmw==@protonmail.internalid>
	<20250223174205.48404-3-trintaeoitogc@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 04 Mar 2025 13:16:19 +0100
Message-ID: <87tt89gfe4.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Guilherme Giacomo Simoes" <trintaeoitogc@gmail.com> writes:

> Implement a check to ensure that the author, firmware, and alias fields
> of the module! macro are properly formatted.
>
> * If the array contains more than one value, enforce vertical
>   formatting.
> * If the array contains only one value, it may be formatted on a single
>   line
>
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>

Tested-by: Andreas Hindborg <a.hindborg@kernel.org>

Does what it says on the label. However, indentation is not checked and
the following is passing:

    authors: [
        "John Doe",
              "Foo Bar"
    ],

Another thing: I'm wondering if we could have a rust hostprog to do
this check, rather than a perl script?


Best regards,
Andreas Hindborg



