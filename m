Return-Path: <linux-kernel+bounces-218645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D127390C31E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 07:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86A31C2154D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 05:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995871B966;
	Tue, 18 Jun 2024 05:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KYpyPTqC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61DDDDC5;
	Tue, 18 Jun 2024 05:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718688709; cv=none; b=Q3iRONIkUSXPjM+is9QMXigNUzkSJmbyNlXIpESOnge8Arjequeq1dpEVu/x6XNQ8qJvgtMAoDzLwjSu62NTgfK+UDvRiRM+GpLSRCtmB2jBiwy8GZOoCzDVb/zR7mFwu1CtAhVw+NAAdfhmCJ4jcnmUAFjSCVxL1Ce2qpzrSKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718688709; c=relaxed/simple;
	bh=Q53Md0YM5ev/lM0ZZ8x3D6iVxQpFWSIJTW7HPkBxmOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fF7sUrT9oUuYYKeYXqwb/UPA3KPla/FBoHTuR7sIIzwxXn5twSlzg5fAXKl2Dq9ToI0VvkPyQp4Z+dqfkBPF4N7omwL7rhlBoMSGcYX3OaNVwN64EvBRWTOGrdzDcfI7+SrGoG2y9ry1p1lHHKwIiwwDM5cPJVNhTWzC0yNTkdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KYpyPTqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4909EC3277B;
	Tue, 18 Jun 2024 05:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718688709;
	bh=Q53Md0YM5ev/lM0ZZ8x3D6iVxQpFWSIJTW7HPkBxmOA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KYpyPTqCr3nJjntSs5sueJ/wsZZZVj3EfYGNJ5N7l7OgYdvWAdk4Xf8Gkym4lf6re
	 qcC00XBDdPY5IP85ekKpVJDyTn6RoPFMkISlEnfcSKOgp/PI4VItJZ7NiR2SUy1b1c
	 cqOrtiIsK/eKmgjiPa3firUMN/LMO69QvVlqxCTU=
Date: Tue, 18 Jun 2024 07:31:47 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: rafael@kernel.org, mcgrof@kernel.org, russ.weight@linux.dev,
	ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@samsung.com,
	aliceryhl@google.com, airlied@gmail.com, fujita.tomonori@gmail.com,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rust: add abstraction for struct device
Message-ID: <2024061823-judo-overhang-eeb1@gregkh>
References: <20240617203010.101452-1-dakr@redhat.com>
 <20240617203010.101452-2-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617203010.101452-2-dakr@redhat.com>

On Mon, Jun 17, 2024 at 10:29:40PM +0200, Danilo Krummrich wrote:
> Add an (always) reference-counted abstraction for a generic C `struct
> device`. This abstraction encapsulates existing `struct device` instances
> and manages its reference count.
> 
> Subsystems may use this abstraction as a base to abstract subsystem
> specific device instances based on a generic `struct device`, such as
> `struct pci_dev`.
> 
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  rust/helpers.c        |   1 +
>  rust/kernel/device.rs | 102 ++++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs    |   1 +
>  3 files changed, 104 insertions(+)
>  create mode 100644 rust/kernel/device.rs

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


