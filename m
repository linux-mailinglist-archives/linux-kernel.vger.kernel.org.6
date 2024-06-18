Return-Path: <linux-kernel+bounces-218897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E4E90C77C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C89F9B20FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CD11BA091;
	Tue, 18 Jun 2024 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MV28pon5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4F623BE;
	Tue, 18 Jun 2024 08:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701054; cv=none; b=KhUrx/ax1g/+bfbBhJ5z83RE3h1V89vF6KD/JgsTsOt9rfj0nwB1ouCvXgjJWitEqG/7T12dfxcRXsb5ZSCL5zc2DvRzuP+NnIZc4eFKXj/IgZZthMhppRMpHT3+ZMChKCraXmyxMkti73otTRq5od5A4gpPoZYyjM8gvSWnwho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701054; c=relaxed/simple;
	bh=IQvfcNScGns3m2ToqyQh9Zim7wn97C7cUDFxy3YUCEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qlbkymdkowOKNsm4X5UPh3FoWo5OVm/qF1/INkS8ocAHIj325ZhoevjeWjN5CKImw5yViQsv1OHTX5VcxDIXmrZfx8V/M7DRY+iw78ogfMtOrdvQ4vlKZvoYrQc6KnvbXxSTJL1J9gsVBBTbsBGVs9yIWneMStdv1qtHhFmZwDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MV28pon5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979C9C3277B;
	Tue, 18 Jun 2024 08:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718701054;
	bh=IQvfcNScGns3m2ToqyQh9Zim7wn97C7cUDFxy3YUCEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MV28pon5ErrXgqH6o2OP7fx9+S6tv7p7XN4SWZ7fT+8RxBZkiZR/pMtBSar2Zy7LX
	 0Fr3sw+ko1QmZD4MHif/RqpIXT5dlxZMRTcDteWvo4pmDrRZXE6muufH28Z0mabXE6
	 UL6Ju3M5RTmp0V3S0INfLAKT18vt8K3vzBMlcn5A=
Date: Tue, 18 Jun 2024 10:57:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Danilo Krummrich <dakr@redhat.com>, rafael@kernel.org,
	mcgrof@kernel.org, russ.weight@linux.dev, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, pstanner@redhat.com, ajanulgu@redhat.com,
	lyude@redhat.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] rust: add abstraction for struct device
Message-ID: <2024061823-atrophy-definite-c139@gregkh>
References: <20240617203010.101452-1-dakr@redhat.com>
 <20240617203010.101452-2-dakr@redhat.com>
 <2024061823-judo-overhang-eeb1@gregkh>
 <2024061819-deprecate-bladder-8639@gregkh>
 <CANiq72kwROB8=HdmcbU49csAixKZkxfUUry7umZbpzPRUZ+3BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72kwROB8=HdmcbU49csAixKZkxfUUry7umZbpzPRUZ+3BA@mail.gmail.com>

On Tue, Jun 18, 2024 at 10:31:03AM +0200, Miguel Ojeda wrote:
> On Tue, Jun 18, 2024 at 7:32 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Wait, I should just take this in my driver-core tree, right?  Any
> 
> That would be ideal, yeah. Thanks!
> 
> > objections for me taking both of these there now for 6.11-rc1 inclusion?
> 
> Perhaps give it a couple days to see if any last minute feedback comes
> (and given Boqun's in 2/2, I think Danilo may want to send a quick
> v4).

Ok, I'll wait a bit, thanks.

greg k-h

