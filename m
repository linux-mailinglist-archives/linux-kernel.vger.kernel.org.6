Return-Path: <linux-kernel+bounces-325653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C406975CAC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 23:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227812861E6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 21:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234041AC899;
	Wed, 11 Sep 2024 21:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4fnHTmL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A651428E4;
	Wed, 11 Sep 2024 21:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726091542; cv=none; b=mxQrJG9NUCKRoF8GJaB4+M/MY3R0ZoDiJ3J5l5c7AtheY3wZIha1IdcwD/ajSfscnnO9BijuukdyNmjLQlhIVYISuG2t05vkyl6kd+PLD3bVXlBHw0Gx4vcA3JrubvTZSOS3VmfS/9quWJjb0BPw7732SSicd/GL1VEmiMUEirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726091542; c=relaxed/simple;
	bh=uZNWVHvlgdVrrl8vudrG5UITO9VmGf5URzcYnjO4lRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeB/ju0OgUXZW4qOgXvCEt9mGK5bjc+5wV3tohrw5ZRf0e4mnitNB36Pr+fwrDQOPMO3YoXsJyOukQFGWgk4xW6DcKPdreE5hFHFwNY8MKk/C0CHc+OsdlwE5vhSl6lWr7VQogSsw0NOS3orBFwCwhLkE8rSiOrjNhx2jqLs9SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4fnHTmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1B8C4CEC0;
	Wed, 11 Sep 2024 21:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726091542;
	bh=uZNWVHvlgdVrrl8vudrG5UITO9VmGf5URzcYnjO4lRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4fnHTmLTgMQnhQH6Wt+kNssw78yAWFgbcGCxTROdmd/5AaHIiIexyZa14hgz2o/+
	 bOM3u3rojGhjMm7yOF/Ux+Xr0IvHwY0kYxu3YW/x7zL/aqpqMbscpCEI9XvNyu4ckA
	 3BDGE9Yke6LVTljovqd/dUdBGU1T1VfoeuSt6LHMzoApDQM0ZcxEM/CDsqp3PAIIpo
	 ie04GImUtW8TAtw9l3+anXJSrgyj0YirD7U0Jeg/Mb3qdrUnRYTpOWuKyl4LhNQfQp
	 iz/KheY4TFDThI1h7XcBVhSn5fiUQ4KG8xb3YTwYmwQ40Vj233x92A7wT7fW4m0ffp
	 UIEO9QDPhaqHw==
Date: Wed, 11 Sep 2024 23:52:12 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Ayush Singh <ayush@beagleboard.org>
Cc: Ayush Singh <ayushdevel1325@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	fabien.parent@linaro.org, d-gole@ti.com,
	lorforlinux@beagleboard.org, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org, Andrew Davis <afd@ti.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/8] rust: kernel: Add Platform device and driver
 abstractions
Message-ID: <ZuIRDGuJ-PmXfd1Y@pollux>
References: <20240911-mikrobus-dt-v1-0-3ded4dc879e7@beagleboard.org>
 <20240911-mikrobus-dt-v1-1-3ded4dc879e7@beagleboard.org>
 <2024091106-scouring-smitten-e740@gregkh>
 <bd542178-af1c-439d-bde4-9865cf6c853c@gmail.com>
 <16d70285-cbec-4378-98eb-b522a0efbbe6@kernel.org>
 <ba9a5ae8-c5af-4045-9e22-28363dc94d42@beagleboard.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba9a5ae8-c5af-4045-9e22-28363dc94d42@beagleboard.org>

On Wed, Sep 11, 2024 at 11:35:43PM +0530, Ayush Singh wrote:
> On 9/11/24 23:09, Danilo Krummrich wrote:
> 
> > On 9/11/24 5:52 PM, Ayush Singh wrote:
> > > Sure, can you provide me a link to patches or maybe the branch
> > > containing that work? I also think it would be good to have the link
> > > in Zulip discussion for Platform Device and Driver.
> > 
> > Sure, please see [1]. But please be aware that I plan to rework some
> > parts
> > before sending out the next version.
> > 
> > [1] https://github.com/Rust-for-Linux/linux/tree/staging/rust-device
> 
> 
> Maybe the branch is just out of date? It still contains the generic
> structures for IdArray, IdTable and RawDeviceId.
> 
> Has something changed since the discussion here [0]?

Yes, it has; this refers to what Greg mentioned when he said that we worked
through this last weekend in his original reply.

Things will probably not remain exactly this way, but the general concept of the
abstractions will, i.e. the existance of `IdArray`, `IdTable`, and some
`DeviceId` abstraction. Please also see [1].

[1] https://lore.kernel.org/rust-for-linux/ZuHU5yrJUOKnJGrB@pollux/

> 
> 
> [0]:
> https://lore.kernel.org/rust-for-linux/2024062031-untracked-opt-3ff1@gregkh/
> 
> 
> Ayush Singh
> 

