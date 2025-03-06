Return-Path: <linux-kernel+bounces-548290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC626A542E7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 07:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5E43AEC42
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 06:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5B21A38E1;
	Thu,  6 Mar 2025 06:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YTBCZ5HT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A4478F45;
	Thu,  6 Mar 2025 06:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741243252; cv=none; b=flxD8+GtarHP68ts3w3CKEwNm5raQaay2mqF2MxXkWF4j8mU3wHJOLJ7jn2NyX9ZK1gbtZIIdSdlPWEBr+VUddwzteqg3RQHNqp4Yve0wTgnBIBCeqGcD4TXUrA2/VtE8fRzhTtwaQokjXxQBMwX2nUaCEfHsfuFWZoe/CqSiZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741243252; c=relaxed/simple;
	bh=8kwjl92rykcychAi9RQKmq2UV5+R5DBT3Ncrt4ABzA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJbFwhUnWDIYnumAbdxO17b/BWVMv9u2ZRIWkcwT+Ub59WsI4+i9W6hxQBPxVL5sMgCNQyfUr/0AZBU/Z8+J4MqNq4EV+voEaveLrg50sBUUXVz4RyfagjpBO2FhFOSGP0wZ4z+x+7AfzMhp6CVN4bN6GSJ19plYpxbQQmq97Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YTBCZ5HT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58ED7C4CEE4;
	Thu,  6 Mar 2025 06:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741243251;
	bh=8kwjl92rykcychAi9RQKmq2UV5+R5DBT3Ncrt4ABzA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YTBCZ5HTEYnF0lhxjYly1lFdZAL5CJRuGXJnBCmFX+ULRtxWDt8TsuywTX7xTXIgi
	 2YMR7iK2RA7DvXHkuykHRGzUiMEU6aI5rFxPnrrwLroJiFiaVWAljoG721dIH88zXh
	 rbPStM7B4ecYg1T/zc5TbMJD3Hn7coe0knxuOHdA=
Date: Thu, 6 Mar 2025 07:39:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, ojeda@kernel.org,
	alex.gaynor@gmail.com, boqun.feng@gmail.com, airlied@gmail.com,
	simona@ffwll.ch, corbet@lwn.net, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, ajanulgu@redhat.com,
	lyude@redhat.com, pstanner@redhat.com, zhiw@nvidia.com,
	cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com,
	acurrid@nvidia.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 0/5] Initial Nova Core series
Message-ID: <2025030629-porcupine-percolate-c4d8@gregkh>
References: <20250304173555.2496-1-dakr@kernel.org>
 <Z8isev0gwQJPs7S9@cassiopeiae>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8isev0gwQJPs7S9@cassiopeiae>

On Wed, Mar 05, 2025 at 08:56:42PM +0100, Danilo Krummrich wrote:
> On Tue, Mar 04, 2025 at 06:34:47PM +0100, Danilo Krummrich wrote:
> > Danilo Krummrich (5):
> >   rust: module: add type `LocalModule`
> >   rust: firmware: introduce `firmware::ModInfoBuilder`
> >   rust: firmware: add `module_firmware!` macro
> 
> Greg, Luis, Russ, any objections on me taking the two firmware patches through
> the nova tree?

None from me!

