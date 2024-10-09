Return-Path: <linux-kernel+bounces-356752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 497F2996629
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 11:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55491F270EB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 09:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9A8190045;
	Wed,  9 Oct 2024 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="RhIZ9UYB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OOivAaDK"
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F4F18C329
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 09:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728467696; cv=none; b=NMJK7z+qzkYqNidHeQ880NGUz0a4vkqsrsIKY62WHuH+5lGZ8YeekUj5ovGut0iZB3vxjSdUdf/UA4UGrE0C6K0fO3jfc7y1quyvlFMTAHcl0Onbunutc+EVxUY0+cntPAzXt+o3D3H6eCpFQvykLXYCUUSgjmF/l+toClei/Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728467696; c=relaxed/simple;
	bh=eKsgermwDrQGhVumFgyUIe7QcPRxeN37V7XvT71396g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KFceoPoCD5JLskKHcoXyxZjLi8zmc7FA4rWj3+jxdZahZu1r9eg0tTWnC33nxguw7doi1dlGshOM2g88qAuD8lzPdg3J5hiarDAFrDEnaWJaQ9LWLEdV/tuVSFstqdxlOT7QHsfMQuVKyB9TwgjqkdGF83GsneTZWb+QY97BvXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=RhIZ9UYB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OOivAaDK; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E853F138027C;
	Wed,  9 Oct 2024 05:54:52 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 09 Oct 2024 05:54:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1728467692; x=
	1728554092; bh=/zLzRuSs1YnET6OT3LUnDQJVQHIXJWvli8llGfyJ3fg=; b=R
	hIZ9UYBW4hOE0sycWqzG7xLjwCOINNXT4nv96wgjxXXMc1JnrRi0P29DTV2DO6Rf
	Cuw6eQ95XotIj7VXpG9h9rVLiuNNVtqecks4YmsO6fXNTKf7GX+0rjgEx2ICgj+G
	FRoBoIHkNi+zcF/UhfI0xZK8rpXhGvcf4tmQVNDBgmtZzSaoCQicIfqLx+VIgyXU
	rfJytDsigeiGLhmyZCUU+pjKH7q7aD9by4WtoK5WcVOETS+HXt0pKy1P0lR43IlM
	JMFjcdiypi75931LnXzSkQYJOrz0WcgQbNgTsYicPplH6fiZZjmuAskeya6O4wZ8
	PQz95arBr+JhcANaPkv0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728467692; x=1728554092; bh=/zLzRuSs1YnET6OT3LUnDQJVQHIX
	JWvli8llGfyJ3fg=; b=OOivAaDKf2L3Zqo72PDwiUf2/lM8kWrR/4bSSsPemyzi
	T+z1ZktZjtaS4YAGHIFQONFY4guLm6PFp8x8xB6SUnW/VMyUuBgkqUfAqOUCxmD2
	VUaG+aUW8kVtaKsHB3VS88w6vErVr3UDHKDPz4OMdoydyBp5daKZeqTqFIM+m452
	yaB71s4qw3WLSluYW46Ci98Rss59IczQu1sEStEMk+0cptFoO31j6LV/YvlsG7wU
	avgoP9gGA6U/rjdEXpKicNd42EKMAL9U7C2ZerV+h0Qsiw5ScNzP+Kwz/uumOiFJ
	rwuKV5aarkFOcakzuu74WLmRqNJbOTPkcD0A8izfDA==
X-ME-Sender: <xms:61IGZ_inVgeiQruKxxytE_dCImlx1fRZE0DBZtTF9GA65GxJfR-eLA>
    <xme:61IGZ8BwZCunBien5U0XxFi4n-lszDPs1v-JMWXIYIlwjROCqzFGPDhCItGuP6DCk
    AkwLZGhNXA2WjxNVMc>
X-ME-Received: <xmr:61IGZ_HZcB96aEMWCX3h9bj5A07KGn52KxG4S2AD2JQ3s7bgcBlxvfzbLWugUnlkHjccNA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddtvden
    ucfhrhhomhepfdfmihhrihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlse
    hshhhuthgvmhhovhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeffvdevueetudfhhfff
    veelhfetfeevveekleevjeduudevvdduvdelteduvefhkeenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhv
    rdhnrghmvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopeiiihihsehnvhhiughirgdrtghomhdprhgtphhtthhopehlihhnuhigqdhmmhes
    khhvrggtkhdrohhrghdprhgtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorh
    hgpdhrtghpthhtoheprhihrghnrdhrohgsvghrthhssegrrhhmrdgtohhmpdhrtghpthht
    ohephhhughhhugesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhirhhilhhlrdhshh
    huthgvmhhovheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhopegurghvihgu
    sehrvgguhhgrthdrtghomhdprhgtphhtthhopeihrghnghesohhsrdgrmhhpvghrvggtoh
    hmphhuthhinhhgrdgtohhmpdhrtghpthhtoheplhhinhhmihgrohhhvgeshhhurgifvghi
    rdgtohhm
X-ME-Proxy: <xmx:7FIGZ8S96vM6lBXeBXJcQ7Ww5Khm3v3-QvwEbgEYYjZG2kMdWRaVWw>
    <xmx:7FIGZ8yoZObn4CZSdmgxj2lFMSspVrwvzr4_ofh3F7MWq2UN0C83Dw>
    <xmx:7FIGZy7DeY39BWwXKOOc0mE4EaxLYYBwXOHJNU_cqN6HNRG_iJOj7Q>
    <xmx:7FIGZxwAOedPYZXtZgZ8d82MrTp1KiWy3oqvi66K3JrTMG4Lth1OVA>
    <xmx:7FIGZ4gerf5ULefTfz5B1vvk6wFBZOdAT1_Sjobmh7wX8diTSXRp0fey>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 05:54:47 -0400 (EDT)
Date: Wed, 9 Oct 2024 12:54:42 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, David Hildenbrand <david@redhat.com>, 
	Yang Shi <yang@os.amperecomputing.com>, Miaohe Lin <linmiaohe@huawei.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Yu Zhao <yuzhao@google.com>, John Hubbard <jhubbard@nvidia.com>, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] Buddy allocator like folio split
Message-ID: <omwjkm2iealxsdxtaxkxjpet2zqz22x7ryvbzmhaxf5gp5k4se@7p5a5vznnsnq>
References: <20241008223748.555845-1-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008223748.555845-1-ziy@nvidia.com>

On Tue, Oct 08, 2024 at 06:37:47PM -0400, Zi Yan wrote:
>  mm/huge_memory.c | 648 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 647 insertions(+), 1 deletion(-)

The idea is sane, but I think it would require a lot more ground work
before getting it upstream. I don't think we can afford two parallel split
implementations. folio_split() and split_huge_page*() should share the same
implementation internally. Otherwise it is going to be pain to maintain
them in-sync.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

