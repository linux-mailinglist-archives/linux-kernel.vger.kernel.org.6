Return-Path: <linux-kernel+bounces-533814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C98FA45F02
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8603E3B668B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 12:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE77212B23;
	Wed, 26 Feb 2025 12:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdYyYqrb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6D1198E65
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 12:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572530; cv=none; b=t/K7RW3jmVuvmed2v7+Nl9jU0dQKjx3k+zBzoBEBDoUKNylUDbAD/SmD8JsaLqLyHbmqZrKSxOMvEJELDIKZnnleptxIW8mF8iVklG7tzi1dWnC6opHrKbMGBn/vshkAfhx8cTm7nQa1qbIW82XCg0KxGdQLwunIFCCItSeSPj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572530; c=relaxed/simple;
	bh=eYNdnldgFakXb3cWiD8nUcmIzqR/RShqi1B3BqcRVgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i/wPsjXLBk3y31gx+xyYtcghrqeyOfy+ZkRpP5asiR/8WhrL3xvZOx2Zm3Q8nN1ehcV8au8kcZSgpu1kxxUWT7jfSx+3fH74fj7zMTB+RLuIphdt23gw0qWpk9nBsA+y1h7dikbcjjcBfRm06KN+UgFYkajYJgxuQnK2/G2uW3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdYyYqrb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EF4C4CED6;
	Wed, 26 Feb 2025 12:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740572530;
	bh=eYNdnldgFakXb3cWiD8nUcmIzqR/RShqi1B3BqcRVgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jdYyYqrb6LKMj7SS5wUoVsmKJT6e61xd00w+DGA1JV6haakqrSWMLWanBJdtGa8Hv
	 MHgzXdlaSoEl32Ug8IkcN01jIHbcjNemPWOvIUFUHM6++REeaakELSfLCdFJwgDy61
	 V0HMhZoEkOxXF5TCq5xd1NbOQyW7QSv+/yqWKh+rkVJPwADA5NiwYdRWPFdWS/Lxx9
	 25sq7MsBvCBygUffZz4ys/BeuyZNls/exuFduui5NF9SCaiOnyYLkXSlB4DjeZ0oQt
	 Kwb0EQEngw79ibmkoCJJeoQm5CBu6eEv3POojqnw1so1o3rbdSrt4PAyNYkxIbL/uT
	 h9eFCKVQkzG1A==
Date: Wed, 26 Feb 2025 13:21:59 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/2] x86/bootflag: Change some static functions to bool
Message-ID: <Z78HZ5i9aMJq58E4@gmail.com>
References: <20250129154920.6773-1-ubizjak@gmail.com>
 <31e1c7e4-5b24-4e56-9f17-8be9553fb6f9@kernel.org>
 <CAFULd4a4qbMiP3dYXDp0_vPapkoi-i-ApOY5pHfKG1h7=vfbbA@mail.gmail.com>
 <43c41ab4-1771-4b01-853e-08e1689df7f3@kernel.org>
 <CAFULd4bTYudfNap1trVyjqA0xv5cQQeWxSZ8numv_uHqxz1Afw@mail.gmail.com>
 <ef6e2925-f005-41e9-bc24-b9adc3922706@kernel.org>
 <Z7zBXyywUEC2ieiR@gmail.com>
 <67544c34-2c6f-43d3-b429-c8752f57a7e6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67544c34-2c6f-43d3-b429-c8752f57a7e6@kernel.org>


* Jiri Slaby <jirislaby@kernel.org> wrote:

> On 24. 02. 25, 19:58, Ingo Molnar wrote:
> > So this CodingStyle entry is a red herring, and the !! is absolutely
> > used in the kernel
> 
> Sure, for intended conversion to either 0 or 1.
> 
> > as an explicit marker of intentional type conversion
> > to bool.
> 
> With this in mind, you would have to write "if (!!x)" everywhere.

No, why would I? In a conditional statement any type conversion is for 
that evaluation alone and any mistakes are limited to that statement.

On a return statement the value continues to live on in the call 
context and has a far longer lifetime. Marking that the type conversion 
from int to bool was intentional is prudent, and the use of '!!' is 
common practice within the kernel:

  starship:~/tip> git grep '!!' -- '*.[ch]' | wc -l
  10739

Thanks,

	Ingo


