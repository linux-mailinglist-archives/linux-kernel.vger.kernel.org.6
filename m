Return-Path: <linux-kernel+bounces-411649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D22C29CFD5E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 09:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05612B232C1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 08:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A57A192B76;
	Sat, 16 Nov 2024 08:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wf0Bw9cA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D9163C
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 08:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731746191; cv=none; b=UHF1LJzaLrVr8IIZQIvSIvxlAYQKdrkCSTcZvkWoNLgmSRrKzRAbn1ND5CAnbjCqzDqzGp1VMED2L4nElMUeld6CKxOr9fip2/Ou2AI7yW2A4dfWjiRBl3fKXDBgwhUf2KDn5DPoxeS1DKHpamlJogX3ecEmowIk0Sf12NGuzGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731746191; c=relaxed/simple;
	bh=Shyxa3IxR4zKrjVFwJjrOTnDY+nWH7p5n46FAGVuMxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDm8XX8C3g/CbtH822TdwK1r8OyPKBK1DBLQPLRJtcAMdtNRdRyfZC4Tw64Y2SR8tLksUc4mOIbQWc8h1Tz50NG0ciMrUq4UnJmBMqzyi/oSr3WHFNlqhSDwPfDUJbPx8nwt5cYbfwUwSCHQCjahsAHtIn2c26sS7S9wKJfXl60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wf0Bw9cA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EDABC4CED2;
	Sat, 16 Nov 2024 08:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731746191;
	bh=Shyxa3IxR4zKrjVFwJjrOTnDY+nWH7p5n46FAGVuMxY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wf0Bw9cAdN3bJfIIJipC1prhjUIckVYyn3d3KbuIt3MN9yhOYbuX35GTR71p3E89T
	 0h8Jr1wurYkKEujTjKXLb/1XthxsgINFqIJGQYOv/Ibo839u/O/9xaPF63o1dvkC5+
	 mOdEeWgP15rQmY4dFxwPVJKRzOiZTJbyt5GTv3Yl8h4TvM4B1f93ks0bMZgsL/sL3s
	 TlAs7OEJAtsyNzQ6jrqoq19QrYdOZkmfB+0nMusq7hyLYJo/RdRsEHBz9Nzpa3XEbx
	 NR52F52Quwa4PvL2lZfhI1nbCX5AnS4xYiJ6CeTOup2xZkojSLet2KOyKmRjCiBmXK
	 pxSSbSt+RyIog==
Date: Sat, 16 Nov 2024 09:36:26 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org, bp@alien8.de,
	x86@kernel.org
Subject: Re: [PATCH 2/3] x86/ioremap: use helper to implement
 xxx_is_setup_data()
Message-ID: <ZzhZinP5QLwHrPYa@gmail.com>
References: <20241115012131.509226-1-bhe@redhat.com>
 <20241115012131.509226-3-bhe@redhat.com>
 <0dd9802f-ee28-180e-98b2-854c32288a72@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0dd9802f-ee28-180e-98b2-854c32288a72@amd.com>


* Tom Lendacky <thomas.lendacky@amd.com> wrote:

> On 11/14/24 19:21, Baoquan He wrote:
> > This simplifies codes a lot by removing the duplicated code handling.
> 
> You should probably squash this with the first patch.
> 
> > 
> > And also remove the similar code comment above of them.
> > 
> > While at it, add __ref to memremap_is_setup_data() to avoid
> 
> The __ref shouldn't be needed if you remove the __init from the helper
> function.

Yeah.

Baoquan, I've zapped these 3 commits from tip:x86/mm for now, mind resending them the init 
annotations fixed?

Thanks,

	Ingo

