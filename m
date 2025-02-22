Return-Path: <linux-kernel+bounces-526943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5C3A4056B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 05:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F86C7003AC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 04:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B6720100D;
	Sat, 22 Feb 2025 04:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G297iUlI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907ABA2D;
	Sat, 22 Feb 2025 04:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740197866; cv=none; b=L0uMYTUfKacqz28yRJ/qtBT3bPFey+rv78wTnr/+PlbRSWWsUHjzkal7kqm8r4wZwsO16LQYZpztM5HSXVznHKFiZGNJ8LNq4T7n2hNXhcwmYbErP06Kk+ysQZDwHpkYC9xcp1hF9iXy8M9PszzGAdK+FNLPb8c0iLz1WRFyO8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740197866; c=relaxed/simple;
	bh=XGzj2md212LaOjPHOjWC7GnDU4NWo1XIpaMinL5/MHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OPqRJEEL+AeSiOjXxpgiV/LaG2l0TEvSysg7/YfcZbyybROgz749mlJ37+DXZ1KHw9sdsjopHilKWDJ7zSwi8Hs43wkLxjrP6+d0EQoS+KJRI2k26o/hZE+iEU9sn5sBF4xig1J/GOE2NEUzHLJ/I3Hqq8r/YWKQiA/blqx2P5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G297iUlI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE36C4CED1;
	Sat, 22 Feb 2025 04:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740197865;
	bh=XGzj2md212LaOjPHOjWC7GnDU4NWo1XIpaMinL5/MHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G297iUlISYs8cijPfToFlxvk0zIc+29EfqwR34hgjXrhP0cBDkrCmaIoljJY5lPrI
	 ciPJvilarAmN/o/o3A3+XacaAyvugBtbIwY5bs/V3kpt/nvnkmqGh42zAyBLRvOOG7
	 QTWdwOrzXeDvsB2C+OkJJGxvZeCELeS1ExzgshM/2RrYe1GJUZMb3ShWLj0xjMocza
	 QmIEf4uTJTkVeSQrrY1VdP7j3tnar+CorCL1woKfV2j2w9s9OoOA5ggggEZ1IuVOjB
	 5xyTjP5BZag24NPuSoBt8HU2eewnuimxnMC2bMaRFugFhwNlXneHnQOfk82bUYjYJC
	 /PyPfad30TMAg==
Date: Sat, 22 Feb 2025 06:17:41 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Nell Shamrell-Harrington <nells@linux.microsoft.com>,
	Dirk Behme <dirk.behme@gmail.com>,
	Konstantin Andrikopoulos <kernel@mandragore.io>,
	Danilo Krummrich <dakr@kernel.org>,
	Roland Xu <mu001999@outlook.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: workqueue: define built-in bh queues
Message-ID: <Z7lP5VA374-TuNZz@kernel.org>
References: <20250221223533.158959-1-hamzamahfooz@linux.microsoft.com>
 <CANiq72nsDgRJeKk=B7C9Zo7HL12az+ZLR27qxckqi5H=cmuV5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nsDgRJeKk=B7C9Zo7HL12az+ZLR27qxckqi5H=cmuV5w@mail.gmail.com>

On Fri, Feb 21, 2025 at 11:45:38PM +0100, Miguel Ojeda wrote:
> On Fri, Feb 21, 2025 at 11:36 PM Hamza Mahfooz
> <hamzamahfooz@linux.microsoft.com> wrote:
> >
> > We provide these methods because it lets us access these queues from
> > Rust without using unsafe code.
> >
> > Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> 
> Cc'ing WORKQUEUE -- thanks!

Not meaning to complain but it by practical has no commit message.

Does not meet any quality standards in that area tbh. In order to
make Rust more appealing you really should pay more attention to
this. 

I learned absolutely nothing from this.

> 
> Cheers,
> Miguel
> 

BR, Jarkko

