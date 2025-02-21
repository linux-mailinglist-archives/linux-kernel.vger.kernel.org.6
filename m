Return-Path: <linux-kernel+bounces-525469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137A0A3F059
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63ABB172434
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECDE202F96;
	Fri, 21 Feb 2025 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="of/m0kOC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018E51F4299;
	Fri, 21 Feb 2025 09:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130408; cv=none; b=GrH1qHxdoC/g4McG4yHoZjRyIfI2HExVWXxQAQ7Ubj3ze26j3HTnEh3KoKXKrM2Jc0qUkd/LLUQ2B8t0ucKt8QSQUVrvOlHxcdWKJG50r9ULXVmvFvYEpLs+d+U1j/eIShXqWX0gXKiYcj3Hj5CSR5GyDP+qGozM2YveFc8d68s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130408; c=relaxed/simple;
	bh=L6NnWHvH4Oaru+YoLlNKGPp2dieniu4gztrNVisZOJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pTbqBcnLSgEbVgQK3/L71iIaXhPnEY2GdKJBu4t7E/XgTaTmiHLZI26Yr6a3XZRLpt4dWh6lFtD1aaVrLxUfmib6T+vzqrR9u5GllCQf3bqlvfigSzKoNx/2XWeQF7TOEtR+XQOCLjJLCCQOt0Op9EWHBIzLf95wUieYVwFPnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=of/m0kOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AE3C4CED6;
	Fri, 21 Feb 2025 09:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740130407;
	bh=L6NnWHvH4Oaru+YoLlNKGPp2dieniu4gztrNVisZOJ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=of/m0kOCXPv8Tvw/GAVtHnMg5Ir8GFP+DATXA1HkPjPbcG1TkPlGlJm0u/j+Ty7b7
	 Nlm2TQ5nVW0j+Out0Fbgvx6LIb/uWgLaDHiX5L1CyKL64MeXgUtLi/hV8g/Ujyd6gA
	 15nCrCsUiW1ZRUQ21EPbBvnY7TdjkojTdvQm6W50rtj8ltRwWjo+hFtk8uUMhghWtH
	 wUyJkOicBNSgZWrFdVGs3TTCxa155H6K6v7tZ2jP8TQ0KY+yaiqQaZWNL0jY8q6JxP
	 ZxoJr1a64sMgkKH9V898y3O0UBb2FYim6JgiPR4gT/KtjxjuXwmsFyqiJqHxgMLNWS
	 EIwUbPEZlEw3w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Oliver Mangold" <oliver.mangold@pm.me>
Cc: "Greg KH" <gregkh@linuxfoundation.org>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH] Rust: Implement a unique reference type URef
 supplementing ARef
In-Reply-To: <Z7g60a63M7-zm1-G@mango> (Oliver Mangold's message of "Fri, 21
	Feb 2025 08:35:32 +0000")
References: <SpXhwnZO__ST8sHQ3HQ3ygThOcnmn0x2JlJ_nwJglL87vw5XfQA8sDH6HdkrGgFVycLhPBlCc6-UtEImTvY26A==@protonmail.internalid>
	<2025022123-channel-laundry-0393@gregkh>
	<EO6_qEoo2hKS8_TaKEUCjNLVzzuSmqmJZLLhUp_NvnQt9cIM9zF_OeBnJXSSsIiKmmH4VEWNy1UA0BpH9SYXSg==@protonmail.internalid>
	<Z7g60a63M7-zm1-G@mango>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 21 Feb 2025 10:33:21 +0100
Message-ID: <87bjuvfxr2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Oliver Mangold" <oliver.mangold@pm.me> writes:

> On 250221 0912, Greg KH wrote:
>> Nit, please wrap your changelog text at 72 columns or so, checkpatch
>> should have warned you about this, right?
>
> Sorry, I did checkpatch before adding the description. Learned something new, I guess :)

Thanks for sending this!

I can absolutely recommend b4 for sending your work [1]. It will warn
you if you try to send but did not run checkpatch after your latest change.


Best regards,
Andreas Hindborg


[1] https://b4.docs.kernel.org/en/latest/


