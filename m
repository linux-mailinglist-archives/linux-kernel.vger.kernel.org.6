Return-Path: <linux-kernel+bounces-443255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8442A9EE955
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 15:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0AC8165625
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 14:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CFF21576E;
	Thu, 12 Dec 2024 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IoAEDCnS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ADF20E716;
	Thu, 12 Dec 2024 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734014837; cv=none; b=MQlGebddM5oy1XFeXQREdxSB483PKuka1HDtRakIewL11gdbVlU2oi7OsQYCaztL0riDyWlbeSUh2BJB9vYHFeCZe6YsFVq+U7oIUEhIwD6tbh5NRzr5nlgUJgjLuxAQRKL7+tsLi4/LKcKhRCKKSwK0sSPa+PseVs97PLZ7Rj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734014837; c=relaxed/simple;
	bh=g1mOrLShRZkDahxNGNDh1xUvZ51oGx3Ld8Kz7Atay7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iB6EYJ4FPKMYco0JcfY9atiMdSrWo2r4gKlmKkDXEzNakrd0G+4s3t9GUcpbwficDUr9Dw1NDhOP9UFFx9WPbsdG8owd/ESyX3vpIZDiWx1fRV2JpeYRhPmx+64YP29vNGA/JIanX1XpxbPMX0l2ezS1p8ckvruiAPINHeHCdnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IoAEDCnS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF2BC4CECE;
	Thu, 12 Dec 2024 14:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734014836;
	bh=g1mOrLShRZkDahxNGNDh1xUvZ51oGx3Ld8Kz7Atay7A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IoAEDCnS1LYfHYbLxG3L/LLTI9V6gN5zYWv8zr1A9661zxqA+ubOOLnGH/ReoPKax
	 q0IBimOmWsvjCJIhdi/wLGNtwwuMgmf4wk3q3/oDNdliiccv/eCHjOUnJCjO3tsEPe
	 XiMgK27gfyU5CwxfIZqLlDRQ6X1xARKJ25qw12TA=
Date: Thu, 12 Dec 2024 09:47:15 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v11 0/8] Rust support for mm_struct, vm_area_struct, and
 mmap
Message-ID: <dvpyp2d4rrxdzdcyu3mh3wdsegi5qcmnp2hitfu4guft2igacg@xfvixz3tsiss>
References: <20241211-vma-v11-0-466640428fc3@google.com>
 <CAH5fLgiB_j=WbTqFs6o9-WaUOHC_-0+nPXT_PYD_1bZ75+2wBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAH5fLgiB_j=WbTqFs6o9-WaUOHC_-0+nPXT_PYD_1bZ75+2wBg@mail.gmail.com>

On Wed, Dec 11, 2024 at 11:47:41AM +0100, Alice Ryhl wrote:
> When I sent this series, b4 put the changelog stub for v12 above the
> cover letter for some reason. Also, I'm not sure why the list of
> recipients were included in the cover letter. Any ideas what I'm doing
> wrong?

Yes, and it's a common gotcha that I don't know how to properly address. For
the moment, we use "---" lines to indicate the main sections of the cover
letter. There are three main sections:

    The main message

    ---

    Additional information

    ---

    The basement

Looks like you removed the "---" between the changelog and the main message,
which causes b4 to stop properly parsing the cover letter.

I'm open to suggestions on how to make this less fragile, short of "use AI to
figure out what part of the cover letter does what."

-K

