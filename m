Return-Path: <linux-kernel+bounces-369679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 818CC9A20DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 13:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADD291C21323
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 11:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABC11DC075;
	Thu, 17 Oct 2024 11:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="iynDoyPt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hLsztB4Z"
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6531DB34E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729164391; cv=none; b=aOJQqpae2wbGEFiZAV5wYTNq2XzgakHZYIalSnPUsCD+u6FCrB7UsOx4ntAxPfwKa356P5gNBUpqVPJROHMW78/QLsFNAGwjnajk/t3kzKwiqyc7piI4TLKk2M9WrbxuXmnju1tCFABg/TKQJsTJjvKau/7jnIkVfdV3WRzSNRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729164391; c=relaxed/simple;
	bh=SmSWtZYMriZ7uhV+gQZT3FPr+I0Vujx1nxMLQCepl94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkAmU9AVL4YN4lSan29zMCiIJOit4uMiZFqT6kfmcQzuxkc5ygFMFDwacCKBh9lWE6JOzIUmfJy3YL0qOPpXDnrIlwEDjANaV0XdS3Z8soQfR/5C2w3xSXgAYNG8hm7rA/LfWp5trvg92pPQ7dWeWxExXkI9e7kyVYw2ymTXsy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=iynDoyPt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hLsztB4Z; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id BD64F13801E7;
	Thu, 17 Oct 2024 07:26:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 17 Oct 2024 07:26:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1729164387; x=1729250787; bh=RKLdY9fSq4oo8drhIwNXN/BmgJJsKXWT
	1VoCp5OTUSE=; b=iynDoyPtNNLJU59lD+1kug96XY2iKi/+PB+w7H59arDACK5X
	0dXVJtMT339t48qwGCGa/K60YvJnmh1vMKF+Oz2oUHpu6Vqhzx/Kzt/NYZXTXu45
	9BayZ9l0TS5pZwpjYA7Edrmy7m0fF1BiOobrW3BBIuM1gQF8gdMCo5npQOyOcgC9
	W77sk+gmhjXkATjgmNs3SIAH5ZZliyDxpl4kDIy5BjxQ3f0t1S8hqUopX6pHrHuM
	7W4AYhUdntT9SrrDm9ec4+/nVYjkoEpkehJd9/ABuuUbIUy7ttEC5xNAsUoVnvsV
	T5wpPgiuosdiq8Cre5p7qNqv3WZMeSpScBz+Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729164387; x=
	1729250787; bh=RKLdY9fSq4oo8drhIwNXN/BmgJJsKXWT1VoCp5OTUSE=; b=h
	LsztB4ZOpK9awXVcT6AYJUzmdQ7aIHUBYa5bk+FsthbhPAYw3b2KMvZlmKVSBW1p
	OEsFVEpN16mrRSnu/aqhe/BBl6MvG+BlIXe43Clx4yOjHyjq3A5TLMzvU0UxgGBq
	i92mi692DyFwJNz/IlDB5Bz9q1VGdI/rRwOBhh1jExQaggHMaOHC8GcAgPE3tZpV
	QzFdk0Op9BYZKdTE0cviMY752ynlCv+abscDQDaiva+g5FSG9yHiazUINT2dYyga
	jNwOo8MFYpRKr5qpXJPGOchlqbDeAgkzjdPpZOZ12VoLDlqJqXO1GCOpyOozC5p6
	Qvc4WiNe8wyH2Ce6zZ7dQ==
X-ME-Sender: <xms:YvQQZ85BjEX22HDdNT1cibzRk-vKjHP3j1Pf9YbZaHZXI4FL3M24zw>
    <xme:YvQQZ940tTUU2myeKD_DKUhLtr7oZwPHzHd6IBRcD2KOJBelib-b0PsnTeu5g7DpC
    ooRQuhamNpioPN8JzE>
X-ME-Received: <xmr:YvQQZ7dOr-PZ1PeV4ekxR9uw0BhdkJ1QuWENcl6IsCGvfbe_GnBZv9vBP9pOu4B5dkiXnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehuddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddttdej
    necuhfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllh
    esshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhepudeffeetffegteef
    jeetvdekgeelveeiheeiffeltddtgeeuffevvdehveevheffnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhho
    vhdrnhgrmhgvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepsggrohhlihhnrdifrghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdp
    rhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheprg
    hkphhmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehhuhhg
    hhgusehgohhoghhlvgdrtghomhdprhgtphhtthhopegurghvihgusehrvgguhhgrthdrtg
    homhdprhgtphhtthhopeifrghnghhkvghfvghnghdrfigrnhhgsehhuhgrfigvihdrtgho
    mhdprhgtphhtthhopedvudgtnhgsrghosehgmhgrihhlrdgtohhmpdhrtghpthhtoheprh
    ihrghnrdhrohgsvghrthhssegrrhhmrdgtohhmpdhrtghpthhtohepihhofihorhhkvghr
    tdesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:YvQQZxJa9PkZaLsrEYEz_pq6vCYWEkXRRjsrqyL1EsVUn_YG-m7EoA>
    <xmx:YvQQZwJK0taHtXl8xsFG7ayUDlgV-e5v8GR4KpbYnFVFUAmzgcuw7Q>
    <xmx:YvQQZyzrxdz78Q5wQaRUD25SxW08ymggsrJgJ39lNH92cewHuzAfjg>
    <xmx:YvQQZ0I7vDiUcesUW2MaIOlvAGwzKU5g9bsWp6Pi6FVmtuvA-lJkdw>
    <xmx:Y_QQZzaZTOLFTwkvA2SpMMbMWFyY3h5XJ_AyrliOJHTMszjE3fcdGUZS>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 07:26:22 -0400 (EDT)
Date: Thu, 17 Oct 2024 14:26:16 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org, 
	hughd@google.com, david@redhat.com, wangkefeng.wang@huawei.com, 21cnbao@gmail.com, 
	ryan.roberts@arm.com, ioworker0@gmail.com, da.gomez@samsung.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [RFC PATCH v3 0/4] Support large folios for tmpfs
Message-ID: <6dohx7zna7x6hxzo4cwnwarep3a7rohx4qxubds3uujfb7gp3c@2xaubczl2n6d>
References: <cover.1728548374.git.baolin.wang@linux.alibaba.com>
 <Zw_IT136rxW_KuhU@casper.infradead.org>
 <e1b6fa05-019c-4a40-afc0-bc1efd15ad42@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1b6fa05-019c-4a40-afc0-bc1efd15ad42@linux.alibaba.com>

On Thu, Oct 17, 2024 at 05:34:15PM +0800, Baolin Wang wrote:
> + Kirill
> 
> On 2024/10/16 22:06, Matthew Wilcox wrote:
> > On Thu, Oct 10, 2024 at 05:58:10PM +0800, Baolin Wang wrote:
> > > Considering that tmpfs already has the 'huge=' option to control the THP
> > > allocation, it is necessary to maintain compatibility with the 'huge='
> > > option, as well as considering the 'deny' and 'force' option controlled
> > > by '/sys/kernel/mm/transparent_hugepage/shmem_enabled'.
> > 
> > No, it's not.  No other filesystem honours these settings.  tmpfs would
> > not have had these settings if it were written today.  It should simply
> > ignore them, the way that NFS ignores the "intr" mount option now that
> > we have a better solution to the original problem.
> > 
> > To reiterate my position:
> > 
> >   - When using tmpfs as a filesystem, it should behave like other
> >     filesystems.
> >   - When using tmpfs to implement MAP_ANONYMOUS | MAP_SHARED, it should
> >     behave like anonymous memory.
> 
> I do agree with your point to some extent, but the ‘huge=’ option has
> existed for nearly 8 years, and the huge orders based on write size may not
> achieve the performance of PMD-sized THP in some scenarios, such as when the
> write length is consistently 4K. So, I am still concerned that ignoring the
> 'huge' option could lead to compatibility issues.

Yeah, I don't think we are there yet to ignore the mount option.

Maybe we need to get a new generic interface to request the semantics
tmpfs has with huge= on per-inode level on any fs. Like a set of FADV_*
handles to make kernel allocate PMD-size folio on any allocation or on
allocations within i_size. I think this behaviour is useful beyond tmpfs.

Then huge= implementation for tmpfs can be re-defined to set these
per-inode FADV_ flags by default. This way we can keep tmpfs compatible
with current deployments and less special comparing to rest of
filesystems on kernel side.

If huge= is not set, tmpfs would behave the same way as the rest of
filesystems.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

