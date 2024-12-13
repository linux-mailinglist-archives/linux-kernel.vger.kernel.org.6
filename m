Return-Path: <linux-kernel+bounces-444733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6BA9F0BC7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 12:59:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD8F2833CE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 11:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87381DF268;
	Fri, 13 Dec 2024 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="tQgxBTJ7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uHJTAYSv"
Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC921632F0
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091171; cv=none; b=VggVf+wo2PkXctA24uinMIn92xKidC9iJOhyFsaBGw/eQXs1O4Nla+mThqSt6NMB5af+y34p3wZvYOdz6FJSy7RyQDSDTlOoTBL1Vc44XNRK514ZsBR+rlWUmnM00vcnCM01s/+V48N6R6oPHUkIrFCK0KYZHtjlel3XY/ldZDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091171; c=relaxed/simple;
	bh=rUpySWGEsFvcUXIQXaBJepeaYu0L20ijo9gqw3q9u5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LK8dCEOsTsrh5fS9bSjuP1mOz6+3WDDJ3Q4bG7zFiTLYVVaf5ulgOdIyw2Nll+p8AilbvJ7L9rQxmCViTHtatT8zVcrVIVZnRyf4hkoM7W65dth5iK9redoTRHXhe3NjsUVAi8nT+DcOmIXLIxdj5tP9ORstBXeM1tZZ10SbivM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=tQgxBTJ7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uHJTAYSv; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 9DEE31140216;
	Fri, 13 Dec 2024 06:59:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Fri, 13 Dec 2024 06:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1734091166; x=
	1734177566; bh=YY9Ny37WV/e8XNd3tcZJEJMvfANE4ZRS8J1X5XId050=; b=t
	QgxBTJ7cI21MODHm5IIhsr9qQzk4lUA0CTYP4QXEFNOgSxelQHeakjL+MZkdtoSw
	ld7ieKDSHQKVUZJ03hzJ1b4ApDYLShIMZ2/1sQ/07AmlG+/WqCEIkwmJUoSMVuxf
	lE46e4YNbqvpRzK3Er+9gVFjHXCmcI/Iz9vdMIMZzJ5Pfp2+AGW0GcYY+JO+0I9o
	7dU1+wSufBh8U149cRZAVjGaNfVF2qwDh0zkYs5V0v8aojQaYlLgh3BH64mtDwF/
	Uz9OV+qisQPQj1ovy5JQlHG2I0+RDihEkEcY7wqnEPtcDixc/fDiAk7EwCiEBz+u
	k9wr+T8lfG2rdpxyIFU/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734091166; x=1734177566; bh=YY9Ny37WV/e8XNd3tcZJEJMvfANE4ZRS8J1
	X5XId050=; b=uHJTAYSvYyol+OslkmlWVtjJxWlbd6yvuoAI+aLInxA51QCTJ+w
	0zgUiCFT5M3BkYay9NetzJ9vIKz8Rgl4jPugaEXY/7MwiWU7Q95moFYBNktPp7Rs
	xLlTMyq/0meVG4P6x3w9OSnouLbB8Y0UYi728bJ/WluPkeYT1sg/U3guL9ZMu0Q1
	u/9lOFirZb5EHkekq8HhWCU5T/4ueLYsdvKMuTEO4Jk1GnLUFMMjQuZimGTCLc1e
	8ygE0yPAtfa9FCxYhHauPrTfHoVE0az+9tm3UXC0TUEZz96zvov/NErDhXTU/AIW
	xOySIUmbdP6OPjtwdgpo9amPsZsKG3KOylg==
X-ME-Sender: <xms:nCFcZ9jwvYrdqGJY5AXoELdLaHGuUUfWoHHb7qyvrcs7otL--F9zcQ>
    <xme:nCFcZyC4V1hIWZSgfKWznAW135Kb86FiCIDfn-3_TTYBrClnjPMAFz_QtuZbIpiU-
    5pL5JxhyYjwld8sO4g>
X-ME-Received: <xmr:nCFcZ9F9puHXqz8UHyPic35ImT0xh5322Wrg0RuDrW1285oZXBluiCDQENsEoz8MWdodpA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecu
    hfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhessh
    hhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhepffdvveeuteduhffhffev
    lefhteefveevkeelveejudduvedvuddvleetudevhfeknecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdr
    nhgrmhgvpdhnsggprhgtphhtthhopeeftddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepthhhohhmrghsrdhlvghnuggrtghkhiesrghmugdrtghomhdprhgtphhtthhopehk
    ihhrihhllhdrshhhuhhtvghmohhvsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpth
    htohepsghpsegrlhhivghnkedruggvpdhrtghpthhtohepthhglhigsehlihhnuhhtrhho
    nhhigidruggvpdhrtghpthhtohepmhhinhhgohesrhgvughhrghtrdgtohhmpdhrtghpth
    htohepuggrvhgvrdhhrghnshgvnheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphht
    thhopeigkeeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehhphgrseiihihtohhrrd
    gtohhmpdhrtghpthhtoheplhhuthhosehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:nCFcZyTEfCh21EnlTiPrK6G66zjhnkSICcPVJ5yGL_XX7CPK1LepTg>
    <xmx:nCFcZ6yfy5onCbvtfbE9MjEOnuFY59LeQraVqzy6cMwh2dZO7nNzwQ>
    <xmx:nCFcZ44gnrVsQRUU0evquTZE4W0t006Zwd1VWEzwQw8dmXJ7O69QwA>
    <xmx:nCFcZ_wBGf8yVd5DPOy-M9IiNQcdKezDc7xTboVD_T-5GwLBVrORwA>
    <xmx:niFcZz8dofWI4yELC61Xl2mY9kvqAIng5IyYovyCZ3-xyAvp6G73usVl>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 06:59:15 -0500 (EST)
Date: Fri, 13 Dec 2024 13:59:12 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 	Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 	Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 	Albert Ou <aou@eecs.berkeley.edu>, Alexei Starovoitov <ast@kernel.org>,
 	Andrea Parri <parri.andrea@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 	Daniel Borkmann <daniel@iogearbox.net>,
 Eric Chan <ericchancf@google.com>, 	Jason Gunthorpe <jgg@ziepe.ca>,
 Kai Huang <kai.huang@intel.com>,
 	Kefeng Wang <wangkefeng.wang@huawei.com>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 	Palmer Dabbelt <palmer@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 	Russell King <linux@armlinux.org.uk>,
 Samuel Holland <samuel.holland@sifive.com>,
 	Suren Baghdasaryan <surenb@google.com>, Yuntao Wang <ytcoode@gmail.com>,
 	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, 	Ashish Kalra <ashish.kalra@amd.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: Re: [PATCHv2 2/2] x86/mm: Make memremap(MEMREMAP_WB) map memory as
 encrypted by default
Message-ID: <myzpconz5z7xf4j7fnofb5zgxv7fc3evxhcys6wnqlao2c3xkj@aoapggj7lchq>
References: <20241021105723.2707507-1-kirill.shutemov@linux.intel.com>
 <20241021105723.2707507-3-kirill.shutemov@linux.intel.com>
 <20241118164616.GAZztvWGs9cOV8t20_@fat_crate.local>
 <s4frmqwtuvclinuu7ttyzfpe7bj7hju5xgt6sxzy3gyt3prr62@rrgvhkv4lgwv>
 <20241121114952.GCZz8eYEVa3yubYQzO@fat_crate.local>
 <bz3vlh3lri7yfckdkddopwhsgvkmizhw5q6ecomgeba7q22ufp@ntu2kugiho4o>
 <079cb87c-78aa-5fb5-b28f-e7a54e51aa78@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <079cb87c-78aa-5fb5-b28f-e7a54e51aa78@amd.com>

On Thu, Dec 12, 2024 at 08:23:07AM -0600, Tom Lendacky wrote:
> On 12/10/24 07:26, Kirill A. Shutemov wrote:
> > On Thu, Nov 21, 2024 at 12:49:52PM +0100, Borislav Petkov wrote:
> >> On Tue, Nov 19, 2024 at 10:21:05AM +0200, Kirill A. Shutemov wrote:
> >>> Sure, we can workaround every place that touches such ranges.
> >>
> >> Every place? Which every place? I thought this is only an EISA issue?
> > 
> > I looked at other places where we call memremap(MEMREMAP_WB) such as
> > acpi_wakeup_cpu(). We actually get encrypted/private mapping for this
> > callsite despite __ioremap_caller() being called encrypted == false.
> > This happens because of IORES_MAP_ENCRYPTED check in __ioremap_caller().
> > 
> > So we depend on the BIOS here. The EISA problem happens because the
> > target memory is in !IORES_MAP_ENCRYPTED memory.
> > 
> > It's hard to say if any other memremap(MEMREMAP_WB) would trigger the
> > issue. And what will happen after next BIOS update.
> > 
> >> Then clearly your changelogs need to expand considerably more what we're
> >> *really* addressing here.
> >>
> >>> Or we can address problem at the root and make creating decrypted/shared
> >>> mappings explicit.
> >>
> >> What is the problem? That KVM implicitly converts memory to shared? Why does
> >> KVM do that an can it be fixed not to?
> >>
> >> Doesn't sound like the guest's problem.
> > 
> > Well, the problem is on the both sides.
> > 
> > VMM behaviour on such accesses is not specified in any spec. AFAIK all
> > current VMM implementations do this implicit conversion.
> > 
> > I think it has to be fixed. VMMs (not only KVM) should not silently
> > convert memory to shared. But VMMs cannot make memory access to go away.
> > The only option they have is to inject #VE instead indicating bogus
> > access. At this point it becomes a guest problem.
> > 
> > It will get fixed in VMMs naturally when TDX Connect gets enabled.
> > With a secure device assigned to a TD, VMM would loose the ability to
> > convert memory on its own. The guest would have to unlock the memory
> > first. This will make implicit conversion impossible.
> > 
> > But it also means guest should never initiate shared access without
> > explicit conversion. Otherwise #VE will crash it.
> > 
> >> Or maybe this needs a lot more explanation what we're fixing here.
> >>
> >>> Such mappings have both functional (as we see here) and security
> >>> implications (VMM can manipulate the guest memory range). We should not
> >>> create decrypted mappings by default on legacy interfaces.
> >>
> >> So we're getting closer.
> >>
> >> The changes themselves are fine but your text is missing a lot about what
> >> we're fixing here. When I asked, I barely scratched the surface. So can we
> >> elaborate here pls?
> > 
> > What about this:
> > 
> > x86/mm: Make memremap(MEMREMAP_WB) map memory as encrypted by default
> > 
> > Currently memremap(MEMREMAP_WB) can produce decrypted/shared mapping:
> > 
> > memremap(MEMREMAP_WB)
> >   arch_memremap_wb()
> >     ioremap_cache()
> >       __ioremap_caller(.encrytped = false)
> 
> That's because try_ram_remap() invokes arch_memremap_can_ram_remap()
> which is returning false (for some reason).

In EISA case try_ram_remap() is not called. is_ram is REGION_DISJOINT

> When arch_memremap_can_ram_remap() returns false, ioremap_cache() is
> invoked. ioremap() should provide shared mappings unless specifically
> requested to provide an encrypted mapping (via encrypted parameter) or
> if __ioremap_check_mem() determines that an encrypted mapping is needed.

I don't propose changing ioremap() behaviour. It's about memremap().

> Can logic be added to arch_memremap_can_ram_remap() to return true for
> the cases that TDX is having issues with?

It will not help EISA case, because we don't get this path.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

