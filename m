Return-Path: <linux-kernel+bounces-197375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26D508D69D7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 578F41C242DF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3E4178369;
	Fri, 31 May 2024 19:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="CjBUiVTt"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1031C6BD
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184311; cv=none; b=ibrS81RflWovkyBjBEzELsWNinQBBH1esCCF7yGmrcnWZfLC3rJHWw9BVRT4r5N6Flo4L9APKbFbaAdSgbpnJuuA7+JwjOvtOdHd4K3O39rnodvyc+DWMXa/W5MhKCVFb2ZHtTNL4ZmvSPeo2QXbbh5ATYf0Vp10VTQLXj+TKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184311; c=relaxed/simple;
	bh=ohuz/YnQmIawkxKylcKhOTg9gvJ8Mh1Y5hyj14wnYFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c8v5YZnTtg+4vrJQunfq/QRZoWrbBBFoK03Mu0kf+HFLOs3FbB1mfBYIRrfqoYjK/ziXLxVOZd5v7MbeBpRnM9tqGWBauQBSqBz5aLuDYGJpyB1C4RF5nglNVxf8ABoUwPg6ewXuzGo8EzpSKphCaHnsKTvZO21+ycYAKPGsWtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=CjBUiVTt; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D5DE840E02BB;
	Fri, 31 May 2024 19:38:27 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id v013xnRX7c2b; Fri, 31 May 2024 19:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1717184304; bh=UZsf1AeqASq5kfd99ju57zEsraxqq6Eox6I8tYWLI0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CjBUiVTttPkhSXSUCCo9BH0hXdSBM5uXLDXKujd/GSOD4eNZlp2nuSNpDHU/GHEhx
	 +o+XqewFdWVp9bZ5I8yAWN2W0/+dqjLoSP1RUO4n2gsTmjS2fGQHFzuyK/wDhTi8yr
	 moNc1NgXX99u9yvYVACL+I6rRVjmFIYT2zYF7B3cy+j2XEfgmb1Rmao6jBbRMJVy0/
	 IvUd18adY7FFSGyRoCuOpmlNNnpOQdcwpfqaPtLrIM0kvyne5r3/0iWRgYd2Jc3f/A
	 MqTkAnku8ubwAU9G9FOh1ua9hOhfddyf4zaO0GozyUr3LKP35FkwGxrzyssiDMTVmY
	 yaTvNhfdU1I8ulvcb75/7oYy8hxYHykvrLRYgHGdtslPwr2Jqc0LgUZntiunqTKWQc
	 /wwI4a61lmUHLssJXU1jKvW4Q3L19M5t4osch2f48ECbO52/Yx1ERPMIG0s6AAUy9m
	 D6qQFaThiAB8CYURvhqyw2HcnC0YUagz9FCBUC/f44GBIT/uaCJ8AnybchNQOxrgqT
	 GPOz3OlzAsf9hlR4AVX0LB2DDKBaeTmI9smpAy57twaNssCGtnhb0g0GuwooTPpZqI
	 FSRlpNdI2a/1IzDDo8XdTzyLldzoBwngxrmiKj0jMdPVcNDTN6+7OX6F3dv0FiQ8Zx
	 WTJfgM6VNCgQ5KHgDgY7XzJU=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 53C8640E02B2;
	Fri, 31 May 2024 19:38:10 +0000 (UTC)
Date: Fri, 31 May 2024 21:38:04 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v4 10/15] virt: sev-guest: Choose the VMPCK key based on
 executing VMPL
Message-ID: <20240531193804.GMZlonHNj42yE1XBTe@fat_crate.local>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <b8508f57712e3194484aa8695494eea26abe1b73.1713974291.git.thomas.lendacky@amd.com>
 <20240531125503.GEZlnIp7YobFu7g9iS@fat_crate.local>
 <ad55da28-e5e0-a348-3cbc-d1a80d0ab2bb@amd.com>
 <20240531190348.GKZlofFDL4ESfpOQ6O@fat_crate.local>
 <d97f837e-fe7c-64ed-78ec-2581607150c6@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d97f837e-fe7c-64ed-78ec-2581607150c6@amd.com>

On Fri, May 31, 2024 at 02:34:37PM -0500, Tom Lendacky wrote:
> It probably should have been documented above the module parameter itself
> and/or in the sev-guest documentation. Those can be done as part of this
> patch or separate, whichever is preferred.

Yeah, pls do it while you're touching that area.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

