Return-Path: <linux-kernel+bounces-532585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC861A44F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 23:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C0E23AE4C7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 22:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED54F211A31;
	Tue, 25 Feb 2025 22:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uh3uiWde"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5704E19415E;
	Tue, 25 Feb 2025 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740521280; cv=none; b=W8CyXpLWXeFbsPdPfH3lfoMqWGIqr8kcCZy9YbU6gcyjjjnkNq+dKAaZ881+6dxu7Jc6IxgqDRrvn2nP6QsmnetGqExLeOh3jvljyfKdfs1ISClzjoJmuWJF1zMS7eJkikPkyl/Yb9yrGqrHeUs+U9/I3R5I+H7qyYLdOKj/Bec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740521280; c=relaxed/simple;
	bh=0NcnfcWnvhmaN3XeVuV1OJeIKLaEyYNHBl+5GykE8Xo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaEYom1MnZZ3ka2B2hDAICcONLUuCZzXljnw/fyLPF4zFO7rs7cBtIcr+Iz3Ag4Z7E6IrN6Y4h+eRHoHjxVx5vEEYbZfIDwIPPFUPr1cBBzUHu4B06BBV5qeAVJr4FkMNIZSeyHJyY6SMv9NFii+Oq8BVVK0fV2fterP6EudPXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uh3uiWde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9347C4CEDD;
	Tue, 25 Feb 2025 22:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740521279;
	bh=0NcnfcWnvhmaN3XeVuV1OJeIKLaEyYNHBl+5GykE8Xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uh3uiWdef72dvl149o9u47xcNbMbLPVbdtdmwTLVcK85olNQSjF6ATId68LBsI/eL
	 DylIN94K8lz6mH6rBJ/xN2SfqgCM1GMuK2rbZh5s6S5iD1spmN/2cmeafJa5A912r7
	 EeLph/5AxQX1eH0Rwx5jblpCrAlgVE4F8ATtB0AKRGeLEpgTczqjKM3attTazZ2hTK
	 4mNdgM6LCNQKiBbKx+Ib1qKhzL+vHPG4wZNXC0nM0ot18fEHoWL6+5z5dliV/sUXZQ
	 8VVsTsWBHQUG+8eLBbdYl/kX5vwd2fh9UtZSxdRsyDlkmDNgIvp0c6ypahdWWp7COI
	 Q1wuY9hVh8ggQ==
Date: Tue, 25 Feb 2025 23:07:53 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?iso-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] rust/faux: Add missing parent argument to
 Registration::new()
Message-ID: <Z74_OalguCdq8uqU@pollux>
References: <20250225213112.872264-1-lyude@redhat.com>
 <20250225213112.872264-3-lyude@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225213112.872264-3-lyude@redhat.com>

On Tue, Feb 25, 2025 at 04:29:01PM -0500, Lyude Paul wrote:
> A little late in the review of the faux device interface, we added the
> ability to specify a parent device when creating new faux devices - but
> this never got ported over to the rust bindings. So, let's add the missing
> argument now so we don't have to convert other users later down the line.
> 
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Danilo Krummrich <dakr@kernel.org>

