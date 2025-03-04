Return-Path: <linux-kernel+bounces-543694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 659BAA4D8C7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 10:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D2C03B2461
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1095200BA1;
	Tue,  4 Mar 2025 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gw9j3nAA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E55200118;
	Tue,  4 Mar 2025 09:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080669; cv=none; b=F+Vnsy5WrwST/CKx6epvw04gx4GQP5j+SfLy9COhGjBwfXj36RJRCbP3o4K6Q0UByz2wbqQcY4FMTs3XnUSihbgEknugCARMPiCx3wX0xXjLPeQ/ZkVg6okMJXEsLdCM+sG/iO0jyVeNHUCJ6O6lcBtumBpvYWpZ/w8Mm+3pydk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080669; c=relaxed/simple;
	bh=Do2frzdRutto2F6ee7dOQGoY3kKTvwVrxYBzQmLnlNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSBy1s/eAzwnaHMiSPw81t/wH9MRZAwXaai9n61ahQsw5K55uqN0Vc1KCk0bClDviuUrsal1bVNCKLCPMB1l6zdS4tTZrYyJX0Keh3+Evr7AbEcIa5/oOIP4M8eTNXufofCJc+tqUW+JuoExQfoYknVwPJ7Jmqk6K8WepstkacE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gw9j3nAA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2931AC4CEE5;
	Tue,  4 Mar 2025 09:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741080668;
	bh=Do2frzdRutto2F6ee7dOQGoY3kKTvwVrxYBzQmLnlNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gw9j3nAAsIBapGQDQhcY8A6iMGpeIGqXHj+nw6S/LWV+qLiiQ4+ZbMuzeBvCLt9Fi
	 QG1kWhtV8/stT2p0qwqm9il6CvSyyk3MsXalDbg2kabz+8qwxnnXp0YGwgPHYzvrpe
	 NQ6ds7tv4rCjNBLTrcQvOIw0pyRFeEJsykwtn0GX0k7xg8nstZdkeikQNoGhkCvOg4
	 c4dbCxb9TdXT+o/ODOOrZ5yN4B+94kLKi0EuX6Zc6SA/n2yESXKNBW3Mkc2BBjwcqC
	 Ce3iA2xTmpDsv6bsjHWG6yA//jF5TvEmeC4BmBbwk8h+sIvsQz3zgUdhBjAHWNiKw/
	 VEAUnFj9/e/Qg==
Date: Tue, 4 Mar 2025 10:31:02 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cred: rust: mark Credential methods inline
Message-ID: <20250304-umzug-anrichten-effb38f7f23d@brauner>
References: <20250303-inline-cred-v1-1-b2527beace76@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250303-inline-cred-v1-1-b2527beace76@google.com>

On Mon, Mar 03, 2025 at 03:28:50PM +0000, Alice Ryhl wrote:
> I'm seeing Binder generating calls to methods on Credential such as
> get_secid, inc_ref, and dec_ref without inlining. Since these methods
> are really simple wrappers around C functions, mark the methods to
> inline to avoid generating these useless small functions.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Thanks!
Reviewed-by: Christian Brauner <brauner@kernel.org>

