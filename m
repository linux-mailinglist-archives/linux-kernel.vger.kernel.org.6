Return-Path: <linux-kernel+bounces-217731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AA290B44A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 17:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BFF7B392C4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 15:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4A7154424;
	Mon, 17 Jun 2024 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDV6/8UU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF47153BD7;
	Mon, 17 Jun 2024 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634315; cv=none; b=P9Md0z4O/YGaFel1a5Xb6b5zTJGNYmB6Rv12IhFhVJtGl2MjDDUJ1nSs2z+dJXeTQTMWCatIGgTXnO6z8U7BnyHeyc7To+TWPk2CkC6CSacI+xcoczTl952AE/qNmfg4uWcrH7X151DBFCSH/iKhDlrjL2SURW2jwWQYn1nouoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634315; c=relaxed/simple;
	bh=ME8qz19GOaLNX/5j98PmYI8BvZeCSpM159rOsXAygRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5ul6Y+yggyC+EqrB1oKyNllLrI6EmTya/mxdSgrN96tq/8/fI7CDSJBNVKFozDM+nH+EkbsBiUMngOnHWeLLWSZ5yy94eMcJlS7C9/EuN7UMEl4+ybVrwoiwNu8cBQyEHTgo2uNangpK63qm7roNrpSCDq7QcebYQIU23xu1cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDV6/8UU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3358BC2BD10;
	Mon, 17 Jun 2024 14:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718634315;
	bh=ME8qz19GOaLNX/5j98PmYI8BvZeCSpM159rOsXAygRM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YDV6/8UUivqNYbFD7pVzIrm2TCaXgojnoyOPLZ8dKvelVoqjnZIY3CypZ+pLoZhjQ
	 /yOIDPBxqKbscqTvLkk1id8weDXk0S4K4w8/a1W4JcE/pXVXr9S0oQgU06wW5djO6s
	 mPT83UkIWWMJd23Lzc1GvihVyvDyg3gtKgzVn24EhFp0vFLGQihj49qhSeLibl7NPW
	 WCy484OVZl9zXf2aksjjt5Qs+nvOtHxOCj78TE8W9J3CpcHeiaGHWj39MOvXOIqkXK
	 FdYpr6ZvDRzkCvsjrKEtEW+G2Fz7TIRFw3zO5nHQF/LE2zQ7p9bigBJysx0AuRDhTQ
	 TCw3dTJisTd2A==
Date: Mon, 17 Jun 2024 22:11:17 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Yixun Lan <dlan@gentoo.org>
Cc: Conor Dooley <conor@kernel.org>, Yangyu Chen <cyy@cyyself.name>,
	linux-riscv@lists.infradead.org, Conor Dooley <conor+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup.patel@wdc.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jesse Taube <jesse@rivosinc.com>
Subject: Re: [PATCH v1 0/9] riscv: add initial support for SpacemiT K1
Message-ID: <ZnBEBQjTQtFs-fXt@xhacker>
References: <tencent_BC64B7B1876F5D10479BD19112F73F262505@qq.com>
 <20240616-exorcism-computing-e11e26084a62@spud>
 <20240616224811.GC3983622@ofsar>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240616224811.GC3983622@ofsar>

On Sun, Jun 16, 2024 at 10:48:11PM +0000, Yixun Lan wrote:
> Hi Conor
>  Thanks for bringing this up
> 
> On 19:35 Sun 16 Jun     , Conor Dooley wrote:
> > On Mon, Jun 17, 2024 at 01:18:52AM +0800, Yangyu Chen wrote:
> > 
> > No MAINTAINERS update, so I figure that means you don't want to maintain
> > it going forwards? If there's someone out that that does care about the
> > spacemit k1 (Jesse maybe?), then I'd be more than happy to have them
> > look after it.
> Yangyu kind of has limited time, too many stuff for him..
> 
> I'd volunteered to help on this if it can fill the gap
> Also I'd be more than happy if anyone willing step forward to co-maintain..

Does maintainership work like this? Is willing to do enough?
FWICT, maintainership involves active patch contributing, reviewing and
maintaining the whole SoC. It is better to take over the maintainership
after showing enough patch contributions and understanding of the SoC.

> 
> -- 
> Yixun Lan (dlan)
> Gentoo Linux Developer
> GPG Key ID AABEFD55
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

