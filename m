Return-Path: <linux-kernel+bounces-272519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC7E945D68
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 13:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AED9B22E6A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 11:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158401E287E;
	Fri,  2 Aug 2024 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCMtwZ7U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5611214B967;
	Fri,  2 Aug 2024 11:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722599305; cv=none; b=Rl8RgbAyJIfjUttmx/i0hL6vlfRENasDxxUJPCMmoIU9FEDsSAq5JSYkiO32xBklY0Mh2JxDhksIkhvGqNoy8UI7q4nEKRLvpdCJlaekC/8ZpmvXmgftUP73Iso7doIfho0kRkbqzJnccvb+sGG0wq/e+A1xik87sbPGF0V37NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722599305; c=relaxed/simple;
	bh=o8iPC2bXimRPJlqxz22KFMbJp1dGZNPsEfxPSGSr0O8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WALvhOZnHEDwMTFOYYsPlCUpU7S13W6Wja94ppmeyQCMAODSxyCsFSm0Pz3NigRn3rmRKZjWpQ2Qa05aZz5Sxo60l4OgDJF6qviO0ZUMvQ+0nt7CIMgBIevys220VXmxpsmpR3dRRzGG7DEtm5iPXBZLgIMvjs/HoXVAOaROHtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCMtwZ7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5A9C32782;
	Fri,  2 Aug 2024 11:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722599303;
	bh=o8iPC2bXimRPJlqxz22KFMbJp1dGZNPsEfxPSGSr0O8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DCMtwZ7UbCchkiKKyFs0coG8tvY0xGzeqY7up4XVXCr/kYAvvIE8SJiSADwR6eZSB
	 74QAGt3/ibbeRec3c6QtRkfxTm7E4pkNu/CGLbAXYd/c0r0rscNH6eeR4WMbqxkWkb
	 pPSwN87b2/UriK/KrZYBDxeDq8wxizzyV8+jN2aULenpI/qPHwwOJKfGC9nqL0Kj5i
	 +9ExByG4sHnH42KiaCxmZuCuDkg/NKPUux5Hf9VRRxWwTJGCMvXyG55WGjmoz6kzD9
	 I4rLyeKl9Vr5wkgL9pBf1w2lXm9doUGRnSjzrY1e7YR4D0aa/rJ1rqynGwLREPTUz+
	 uetWFDj+9/62w==
Date: Fri, 2 Aug 2024 13:48:17 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4] rust: mm: add abstractions for mm_struct and
 vm_area_struct
Message-ID: <ZqzHgUifcBTZplEx@pollux>
References: <20240802-vma-v4-1-091a87058a43@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802-vma-v4-1-091a87058a43@google.com>

On Fri, Aug 02, 2024 at 07:38:32AM +0000, Alice Ryhl wrote:
> This is a follow-up to the page abstractions [1] that were recently
> merged in 6.11. Rust Binder will need these abstractions to manipulate
> the vma in its implementation of the mmap fop on the Binder file.
> 
> This patch is based on Wedson's implementation on the old rust branch,
> but has been changed significantly. All mistakes are Alice's.
> 
> Link: https://lore.kernel.org/r/20240528-alice-mm-v7-4-78222c31b8f4@google.com [1]
> Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

