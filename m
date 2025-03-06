Return-Path: <linux-kernel+bounces-549047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5936CA54C83
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 14:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7064D1898D9F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 13:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936B613957E;
	Thu,  6 Mar 2025 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LL3EFMl8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CD64C8E;
	Thu,  6 Mar 2025 13:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268714; cv=none; b=Hk0ksDtzsLos3iUbH7x0aV9qoZLFlLp46mhiwShu0IiE3UrAaD1/ojNYUqDengtMcXQn4cHNjIQgBnIcBrxObZPQONlJgZqXg2xbNskdr+jcRDopuEqjT94mH8R1B1V4YuYvVq2gqo4h6SDj/mzjXYgDYUDv8boUcrJy3OraMjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268714; c=relaxed/simple;
	bh=W/pLRzzCmKndl4i2cPdDqVunl8ECSHU4worQHHjuI3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LmbozDWphWQKyGPTJrviS9RwGpv+9UPwCGGVYRrLmpnZN3Nflv0gjdsuzWc+M6fyQpEzovV+E36wy5OxBPeXVWm0dAXVXEkkT5dPB4+ic5DRyN7TYa3YZIQMWZJ8Av+K1TODTOrwkUT4alTM86aL/rOv9YzvKaPg2IiYEFWYinc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LL3EFMl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936EDC4CEE4;
	Thu,  6 Mar 2025 13:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741268713;
	bh=W/pLRzzCmKndl4i2cPdDqVunl8ECSHU4worQHHjuI3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LL3EFMl8f/nuP1WsPibX1shS/JHV+dq34WHn35A+4Ni45fh2P+7iyWgA7S6uMv4py
	 JJAkRCViZogb4z0YWCYUE2Gz9V+p+FBSeo5+hNp4lSjLLbBlmsmqvRtQHlVax1Id5m
	 aMjf4wvokfguXu59H4gGpryCxEyYimv4ZH58GrmTxjJrK80dCGLDjXsx97MzZ758yi
	 f6dYBLIO06oExGQh/U2abS+ru99SgT8dCDY6q4q0zeaykGiwAsCPHGFn1nVU6gdrep
	 RosZ/T5VgXu7VEPaRPWFrhe95rPWZM84sFzHgVAmA9JvDl5kllS88xQzeELCzTfzIe
	 pqSF9MsJpMVFg==
Date: Thu, 6 Mar 2025 14:45:05 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, ajanulgu@redhat.com, lyude@redhat.com,
	pstanner@redhat.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	gregkh@linuxfoundation.org, mcgrof@kernel.org,
	russ.weight@linux.dev, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add initial documentation
Message-ID: <Z8mm4fJQxXMiN5tu@cassiopeiae>
References: <20250304173555.2496-1-dakr@kernel.org>
 <20250304173555.2496-6-dakr@kernel.org>
 <20250306.215638.838863448505767234.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306.215638.838863448505767234.fujita.tomonori@gmail.com>

On Thu, Mar 06, 2025 at 09:56:38PM +0900, FUJITA Tomonori wrote:
> On Tue,  4 Mar 2025 18:34:52 +0100
> Danilo Krummrich <dakr@kernel.org> wrote:
> 
> > +Delay / Sleep abstractions
> > +--------------------------
> > +
> > +Rust abstractions for the kernel's delay() and sleep() functions.
> > +
> > +There is some ongoing work from FUJITA Tomonori [1], which has not seen any updates
> > +since Oct. 24.
> > +
> > +| Complexity: Beginner
> > +| Link: https://lore.kernel.org/netdev/20241001112512.4861-2-fujita.tomonori@gmail.com/ [1]
> 
> I posted v11 last month.
> 
> https://lore.kernel.org/netdev/20250220070611.214262-1-fujita.tomonori@gmail.com/

Thanks for letting me know.

I think I lost track of this because in v1 the series was named "add delay
abstraction (sleep functions)" and with v2 it was switched to "rust: Add IO
polling" and I was searching for subsequent patch series with the "delay"
keyword.

Anyways, AFAICS you ended up with adding fsleep(). I think nova-core will need
control over having a busy loop or actually re-schedule.

I will update this entry accordingly.

