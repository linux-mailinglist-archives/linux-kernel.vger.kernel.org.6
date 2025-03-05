Return-Path: <linux-kernel+bounces-547656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E00C9A50C0E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 20:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EC271894FDE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 19:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EA82561BA;
	Wed,  5 Mar 2025 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu5QG/9S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AAC25335D;
	Wed,  5 Mar 2025 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204611; cv=none; b=niysNtmbcrKBrB+iuRYVQ8R6xfkWPUTGmJdbQMdFYj41SNhqJq/LIXdZwNtOZiVyOmVJSTErL00/zSNtKUeBxFxxnjnj3mpKECG5sXV+X7fYAvkB+9T7AhH0XxFN/qLQc4haLFOhF+NDsU4GyNeUQgsgQ/9VirUi1HKU9k7j5NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204611; c=relaxed/simple;
	bh=tHSKWwl3ha1y5igXyzymqDuF6lQTvM1zbhu3+g/qgJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFN9F8rSNZzaKcadnJgim8JismdIHUe97i1uKWtpfyQefn6iVGvknXI/oZWnMhUxCfMGD5RobTX3rhZNHpyGYQP+AU4qboFSSqtuB9hJr6LELeUkNbhz/rYWoSKpOCJ/a43e9OrKZxRB4+PtQ1I3SPmIAqlCyKE2b2lSkuqeH3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu5QG/9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22DF0C4CED1;
	Wed,  5 Mar 2025 19:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741204610;
	bh=tHSKWwl3ha1y5igXyzymqDuF6lQTvM1zbhu3+g/qgJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tu5QG/9SpMYQUa8MRGPA1RC06rAh3B2yWsKvKOW6ZLAIskB5bxCBOtbALANu1yasf
	 HYl/les0LAJ4JEmz1RjiywpgHYGSdT69S8mndOhTDZG24B5dO8+udH5OKg+3/3sqSl
	 hen0e7YDXp8E/7WAHKQ3K9xtr3aeUrlCz2Zp0gtrmcuThe7MtC/ZxYOTMqo5kM+VB2
	 wtls0g3r6q23U4b7/okLTDV2a9EUyJkI58qkBBXIIcI71FZeQr9D8DI9t2ua0ZbKUA
	 Y6KBe24O6hH8uZ3nGGCUsxRs4Oe6BUoPvSeuzj4+VMWvLqiCcPoi8pWWLkT3c3Q579
	 ZDdOqcxazc3dw==
Date: Wed, 5 Mar 2025 20:56:42 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, mcgrof@kernel.org, russ.weight@linux.dev
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, ajanulgu@redhat.com, lyude@redhat.com,
	pstanner@redhat.com, zhiw@nvidia.com, cjia@nvidia.com,
	jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 0/5] Initial Nova Core series
Message-ID: <Z8isev0gwQJPs7S9@cassiopeiae>
References: <20250304173555.2496-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304173555.2496-1-dakr@kernel.org>

On Tue, Mar 04, 2025 at 06:34:47PM +0100, Danilo Krummrich wrote:
> Danilo Krummrich (5):
>   rust: module: add type `LocalModule`
>   rust: firmware: introduce `firmware::ModInfoBuilder`
>   rust: firmware: add `module_firmware!` macro

Greg, Luis, Russ, any objections on me taking the two firmware patches through
the nova tree?

>   gpu: nova-core: add initial driver stub
>   gpu: nova-core: add initial documentation

