Return-Path: <linux-kernel+bounces-553312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B076A5874A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830C23A5529
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 18:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B411B1F4CB4;
	Sun,  9 Mar 2025 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fou6gAfH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165AF1FB3;
	Sun,  9 Mar 2025 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741545633; cv=none; b=oSUl2o0LmmA/zWRH/Yvd7xzRdkLspDZSiRGcL3duAWl/QpxHga6tPQjszN157Ig0jlM4ttnX1iRsyirA6VdRlmt6mdI7fPw7lGY+wOO9rj688Hi5X0l/BB9xpztFCoOIa5WMUkYfbDYMFCT3uYYbq1gIv6IGIrLrqA0ao3QtvU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741545633; c=relaxed/simple;
	bh=wxAdK4cesWjR2yjL5pnLFSlTuVjdMgVxI0GcMjaQjAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpD8WBbPk6w8o9kYD6EtXrRSvmPxkgYpNde3hCrOTH++kfQexOGViPwQBQKWT6jv/7v6q3BqGNUNp5eI9heYZ7WnEhe9Lf+qJ2EG74ARzALPqgtPr22WoGZ4OJ4eQvtyGfIib6nBWTpuViM3q04u1nDq2Z5SYNi9rfEZByL2BSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fou6gAfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2EC8C4CEEC;
	Sun,  9 Mar 2025 18:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741545632;
	bh=wxAdK4cesWjR2yjL5pnLFSlTuVjdMgVxI0GcMjaQjAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fou6gAfHQJ/gv2gkxO3GKSNmNnTelGd0UGlZ0La4k5xj7+GaGkNbLcrT+lss2BKig
	 MC+nG+PWVvPMBrjyPwYpI4FOg+iC4AtZ9/61nFacfOq0jPVxS1b9FJ7V4333QNGJcP
	 JpWpPp6jkI6CUcNuDON/pAwUeFh76rcGpKynltJm/lso0kRYrf0NbQ6mmoNzi4IOiT
	 c+he/4n6ZPXoL5xdXLQxBMOpdlbnJmd+7MfhnVctCnABWbvEatqaIe/bTgaOWIQ9AA
	 ZRwMoZjSnV0rlLKFR9TeuhMEHYmNvXCSxVSD3efx3w7BxWuQyMfxnRxYj9Gf9jgkVP
	 3gDNAzSDnvjsw==
Date: Sun, 9 Mar 2025 19:40:24 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, ajanulgu@redhat.com, lyude@redhat.com,
	pstanner@redhat.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	gregkh@linuxfoundation.org, mcgrof@kernel.org,
	russ.weight@linux.dev, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Initial Nova Core series
Message-ID: <Z83gmL38o8BsQKUi@cassiopeiae>
References: <20250306222336.23482-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306222336.23482-1-dakr@kernel.org>

On Thu, Mar 06, 2025 at 11:23:26PM +0100, Danilo Krummrich wrote:
> This is the initial series for the nova-core stub driver.

Applied to nova-next, thanks!

