Return-Path: <linux-kernel+bounces-283348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F91094F142
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 17:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5F3B280CB3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E5B17C7C8;
	Mon, 12 Aug 2024 15:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SsSu4J2J"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD16F1E504
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 15:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723475205; cv=none; b=jnNBiCpxrRha00EVz5lLjc/dqLw5u8KBWzfB3ToNpOnr55IPGysfqVPv0noFMNfNI9j93PzT1cjbb9ztTxmbekm5x3bXixH6FeKvRXOllVxNCOhSpf/N07YW7NwxPpxtwZCGmLJQJLV9xPPqXgA5qPT1VgQQJOikj5Hrf0Kosek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723475205; c=relaxed/simple;
	bh=wZUKLmGZTJAG1WlIlifrMSRtJQlbTNydGbd1sztoIHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hodZpOeHmB6RziYWg1kH9SF7mekv1AYNZKNNZpwU+5mXxoBUKCWrYGfyY1fu68HKcCv+lyHZZZ9R3NMD8TUq4RmDUXeQCylIe6gGUCWCepn5kgH5i/BlxwDTR9AuQs3IVgJHcrzzZ692EHkpQ+aQqNe7jV7N4OpCJtWKhr3pCWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SsSu4J2J; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=OX2YxCLbB2YLRKPPMAa2K017NZPOzu80/T3MRpTE8kQ=; b=SsSu4J2JaMqE78Wm5orCsihZ1Y
	NVbvEmLPNskF9gT9W1ujQr6hc7tFs/D5+We5vniiUKmWrlWw28Cx4YhB0J2g8hm5kgVcffh5GlEJy
	D0xxcvIjEU4dTcnpu7TQQuo9ZnFBft5ubdv8BoGNQV6cXH6tJcXWQiLoMXHo4edSmHzipEdSCqbCr
	n+TW1Wq4GBpdxG2Aq/AyUAjIe0wt7k0SrW+G1Hr3rZmgW3Wfc/IAtxflUCa3PBCUr15ynY1waPYiH
	EMX7phVPycrQdg9PSqzDBd5atbaPtfyxM/2a1wryqDjt9yui65VK9YA3yLueV81C4/2niFndSWMeH
	iacW5q6A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33634)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sdWcx-00047v-30;
	Mon, 12 Aug 2024 16:06:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sdWd1-0000Yf-PC; Mon, 12 Aug 2024 16:06:35 +0100
Date: Mon, 12 Aug 2024 16:06:35 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Harith George <mail2hgg@gmail.com>
Cc: Yuntao Liu <liuyuntao12@huawei.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	arnd@arndb.de, afd@ti.com, linus.walleij@linaro.org,
	akpm@linux-foundation.org, eric.devolder@oracle.com,
	masahiroy@kernel.org
Subject: Re: [PATCH] arm: Fix build issue with LD_DEAD_CODE_DATA_ELIMINATION
Message-ID: <Zrok+yGp5epfcZTE@shell.armlinux.org.uk>
References: <20240808123556.681609-1-liuyuntao12@huawei.com>
 <54f87fcb-74da-4b48-a12e-4c7d9fa2870e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54f87fcb-74da-4b48-a12e-4c7d9fa2870e@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Aug 12, 2024 at 01:21:59PM +0530, Harith George wrote:
> On 08-08-2024 18:05, Yuntao Liu wrote:
> > There is a build issue with LD segmentation fault, while
> > CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is not enabled, as bellow.
> > 
> > scripts/link-vmlinux.sh: line 49:  3796 Segmentation fault
> >   (core dumped) ${ld} ${ldflags} -o ${output} ${wl}--whole-archive
> >   ${objs} ${wl}--no-whole-archive ${wl}--start-group
> >   ${libs} ${wl}--end-group ${kallsymso} ${btf_vmlinux_bin_o} ${ldlibs}
> > 
> > The error occurs in older versions of the GNU ld with version earlier
> > than 2.36. It makes most sense to have a minimum LD version as
> > a dependency for HAVE_LD_DEAD_CODE_DATA_ELIMINATION and eliminate
> > the impact of ".reloc  .text, R_ARM_NONE, ." when
> > CONFIG_LD_DEAD_CODE_DATA_ELIMINATION is not enabled.
> > 
> > Fixes: ed0f94102251 ("ARM: 9404/1: arm32: enable HAVE_LD_DEAD_CODE_DATA_ELIMINATION")
> > Reported-by: Harith George <mail2hgg@gmail.com>
> > Suggested-by: Arnd Bergmann <arnd@arndb.de>
> > Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
> > Link: https://lore.kernel.org/all/14e9aefb-88d1-4eee-8288-ef15d4a9b059@gmail.com/
> 
> Build tested. Solves the earlier build issue I was seeing.
> fwiw, you can add my tested by tag if needed.
> 
> Tested-by: Harith George <mail2hgg@gmail.com>

(a) please see the note in my signature below.
(b) this tested-by needs to be collected by the submitter before it gets
    into the patch system.
(c) it needs to get into the patch system.

Bear in mind that as a result of (a), it's going to be better to get it
into the patch system sooner rather than later - I am expecting there to
be a period of time (weeks) where it will be impossible for me to read
the screen...

-- 
*** please note that I probably will only be occasionally responsive
*** for an unknown period of time due to recent eye surgery making
*** reading quite difficult.

RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

