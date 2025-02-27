Return-Path: <linux-kernel+bounces-536767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 324C9A4842A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 17:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211FD1896BC6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 16:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6B51B4159;
	Thu, 27 Feb 2025 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJVvX8bg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F66E1AAA10
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 15:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671765; cv=none; b=j4OUVtpNZPHLxBnXxMS7mruE3rfVnM9ax/mnEiLT0SNxgrOfuPMOeEKfMskhtAyF1qddlVFY7lnJnftqrZZJ2eZw2OzF8tg1OMfEiYyeiIkuABklawT35b/esC5V13XhNvwKTbmCtxhpqqe/deheJ9zT6hrEnxkcR83ohtkwWXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671765; c=relaxed/simple;
	bh=4XS/w8try2ACKldK10vEqyRkeuzlJ94ggQX1TVhimIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6MbbvV4oz5wXiMgcj55DpOjEjKINFAWBz+rewiYC2/8grcG3BZL6BjSfBRW1rcIoACUR+pBTypEWrZSX0RcC7ROmhhZWjTQDCzXQG1RVWVlrALz+vNpHdznSVT+9Jh71HDB64uXINBrZigNBX3PAGoryJa1maXJhJkuTOyvCY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJVvX8bg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F349C4CEDD;
	Thu, 27 Feb 2025 15:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740671765;
	bh=4XS/w8try2ACKldK10vEqyRkeuzlJ94ggQX1TVhimIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DJVvX8bgnM1Jhf6pxMjjppij2hlo+Src2FEWjX/NJSALnw9Kzrb6D7q5NI4qjoJdQ
	 gBXgDlvII2zh0LKKIS7Qay3V5+RIacVvXtWDRxD5ueL9hnXV8+w5LJRv+jH1grSB78
	 E5ebxNYzkuRKk0C19f96t77Upv4lAYzodoC8/troFcn6NDvtjQFnjMwI7prp/iO/EX
	 Ah34a152RATvOfXSZIrXmoHSVFnC3FZwb3h8ikzfVvO8atpUjI0YUAUfvZNLql4Car
	 b6tnRpVFwYBUttXx/yXPFnik6FIqL6odEH/gbjJAn09XcAWmUBjj+GFwT5T1ossxGg
	 tscYM0guOszGw==
Date: Thu, 27 Feb 2025 16:56:00 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 17/21] tests/acpi: virt: update HEST table to accept
 two sources
Message-ID: <20250227165600.16a74895@foz.lan>
In-Reply-To: <20250227165124.221ef1b2@foz.lan>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
	<9d57e2a6ec3f523eb7691347403f05ad40782b94.1740653898.git.mchehab+huawei@kernel.org>
	<20250227141038.28501d73@imammedo.users.ipa.redhat.com>
	<20250227141603.3957e78b@imammedo.users.ipa.redhat.com>
	<20250227165124.221ef1b2@foz.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 27 Feb 2025 16:51:24 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Thu, 27 Feb 2025 14:16:03 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Thu, 27 Feb 2025 14:10:38 +0100
> > Igor Mammedov <imammedo@redhat.com> wrote:
> >   
> > > On Thu, 27 Feb 2025 12:03:47 +0100
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > > 
> > > squash this patch into the next one
> > > 
> > > Also at this point there is no visible HEST changes yet, so a soon as you remove
> > > white-list without enabling new HEST, the tests should start failing.
> > > 
> > > I suggest to move 20/21 before this patch,
> > > as result one would see dsdt and hest diffs when running tests
> > > and then you can use rebuild-expected-aml.sh to generate updated
> > > tables and update them in one patch (that's what we typically do,
> > > we don't split updates in increments).    
> > 
> > on top of that,
> > it seems the patch doesn't apply for some reason.  
> 
> Hmm... perhaps the diffstat that I place here (produced by bios-tables-test
> output) is causing some confusion when you're trying to apply the patch.
> 
> Any suggestions to avoid that?

Nevermind. I fixed by removing the name of the file before the diff, e.g.
the description is now:

  tests/acpi: virt: update HEST and DSDT tables
    
    - The HEST table now accept two sources;
    - The DSDT tables now have a GED error device.
    
    @@ -1,39 +1,39 @@
     /*
      * Intel ACPI Component Architecture
      * AML/ASL+ Disassembler version 20240322 (64-bit version)
      * Copyright (c) 2000

...

Regards,
Mauro

