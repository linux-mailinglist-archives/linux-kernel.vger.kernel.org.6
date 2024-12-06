Return-Path: <linux-kernel+bounces-435061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40619E6EF6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 14:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06DC916063C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 13:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB60207641;
	Fri,  6 Dec 2024 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RMB6BtQP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312C9204F74;
	Fri,  6 Dec 2024 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733490365; cv=none; b=jE8F8QOnG+48m1O6mLtaiYO+r/+tz3oXGOQZbZFHW78SO6+KSJFcOZnXUJZQBuZFhkUT4f7cSQu2qQtvRFIkJum//qS7N1aIO+zuRkhfHciZVbhU+1ughUgxDKMR92N9EU+Vm7hm71MqEPGVL8igceNMyo9dDFTFF+4myZXChSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733490365; c=relaxed/simple;
	bh=PDqJLL74c64eubCzsjcFf2PgzPgR9tpuuqMUc4vcq/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoNd/xZIjbmspn/ZN92eyzUwdo6YWk/zL3s5TVRU969rY747ay6ifwmoroQXE8uU4wPWn1y47o/BMDOLE3Wb/6QOQIyeAUYz6wcGcg/AAQXU9xfgGceEKAY4JHLqjttDeHP6qMn17ezMPOz20AP49/ftgJteYYwwCBkg1bB5h80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RMB6BtQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D444EC4CED1;
	Fri,  6 Dec 2024 13:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733490364;
	bh=PDqJLL74c64eubCzsjcFf2PgzPgR9tpuuqMUc4vcq/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RMB6BtQPZ2mYjF6V5tBtNrXsaNuMD7F2YYOHdQqF7QKi8HxlMEhULm2YkJSCP1y9R
	 x47hUXe611bweOGZX0ZiesfEUqcBREfaUGE+ua2OpdajB7ybZ3yU0Rpv4WBRjdKrjQ
	 ZXJ8SG4wCFdVd2dj885rYROCxE4UMCsSe73Fe571VTZh2EuGDR9p65UvBILGc8r3up
	 yjzxMW6unv1EkRD8pFwZeUZWd5ZBWE3leTRWs7jC2zvrdmd73wo3aCSfTpydAijEqA
	 QKp8CepwZt/9G7kAZUYCELdHfmmSxn+5dCOTGy0hRW5AqmQieA5FMfO4YP+JkboLkc
	 1HxhJzC1Hwvhg==
Date: Fri, 6 Dec 2024 14:05:58 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v5 0/4] rust: miscdevice: Provide sample driver using the
 new MiscDevice bindings
Message-ID: <Z1L2tjNrIa2Q0Awf@pollux>
References: <20241206124218.165880-1-lee@kernel.org>
 <Z1LzOORuFpO0MXAZ@pollux>
 <20241206125430.GB7684@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241206125430.GB7684@google.com>

On Fri, Dec 06, 2024 at 12:54:30PM +0000, Lee Jones wrote:
> On Fri, 06 Dec 2024, Danilo Krummrich wrote:
> 
> > On Fri, Dec 06, 2024 at 12:42:11PM +0000, Lee Jones wrote:
> > > It has been suggested that the driver should use dev_info() instead of
> > > pr_info() however there is currently no scaffolding to successfully pull
> > > a 'struct device' out from driver data post register().  This is being
> > > worked on and we will convert this over in due course.
> > 
> > I think you're going too fast with this series.
> > 
> > Please address the comments you receive before sending out new versions.
> > 
> > Also, please document the changes you have made from one version to the next,
> > otherwise it's gonna be very hard to review this.
> 
> I can add a change log.
> 
> What comments were missed?

I think MiscDevice should ideally use the generic `Registration` type from [1].

I see that you use `InPlaceModule` now, which is fine. But since this is just a
sample, we could probably afford to wait until the generic type lands.

Also, there was a comment about how we can make use of the `dev_*` macros.

I really think we should fix those before we land a sample driver. It's gonna
be hard to explain people later on that they shouldn't do what the example
does...

[1] https://lore.kernel.org/rust-for-linux/20241205141533.111830-3-dakr@kernel.org/

> 
> -- 
> Lee Jones [李琼斯]

