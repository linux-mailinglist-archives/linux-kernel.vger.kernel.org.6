Return-Path: <linux-kernel+bounces-385485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2D99B37BA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 18:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F8831F227C0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Oct 2024 17:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC00F1DF27B;
	Mon, 28 Oct 2024 17:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J6Bh8ELV"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268211922FC
	for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 17:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136902; cv=none; b=TITA1CYb8+QJgioDIzeeiWLzPn0JJHNiFU4wOiWiUcTUlawCWsYPeGrtPkaJdaeOATntIhx609gax4Qkg0NWhS7HO0tPzuoRo7+HD+h3BoRk9hvSD+/o4lScSVcUpkX/ZySrPc0qOIiTGuJXflaZGBhGJo8UCg0j9LHcsgFAEvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136902; c=relaxed/simple;
	bh=FDuiQoGQ4RDc41lkhRz1RQhRhTYcpgFWqGDnQQqwCGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YIhgP6ITnnHMVgpG/hkJUutTJBsOAjNqJExme2etJncri1uJdphOPMA3ZXU1Bm0/LDuOBaXr58mj/duxdnklilqBbkK6SXx/2ectMX82eA/Jc3Feq5x6J63N4BXu+NREDrZbl+dcSIY7esQYl1lg6GtsQNsDH2cDRboMtSMHpcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J6Bh8ELV; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4609d75e2f8so46934091cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2024 10:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730136899; x=1730741699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E17fLZnZNHxD2R3MrSGao59rVkX6KlS6Yr9x5FBdU8o=;
        b=J6Bh8ELVtWnwVi649XLsGq70xvNFgrkfGqpm6t7jknVyHbXCYikURUC3E8VcCbAaWr
         xhmIvMMCS6MUyE2YOBxnZaFbSacEH5xlDZpRsx0QZf6/zpa8IwZu/baxitOxcuUreC6r
         NMBwbf1Kam8VegXpO+oPiKDY9csmk4SIoN/+sntWh3WQGbKVnjvkkIdb8M5rC3I8PQUE
         VgCRpw/Srh5KHcEOCwXW67novW/Sc64yeQiDCJcR20vFQ8LXhw8NV8s4K9WXaQ9heTok
         vedN37d2S5tP/n0G/ZEKykx2vXyfRSTKeD09okSJkJ/oQ0gjtahA3lLYR1ABYrDl8HFl
         Ks+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730136899; x=1730741699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E17fLZnZNHxD2R3MrSGao59rVkX6KlS6Yr9x5FBdU8o=;
        b=h4JLKB3nryPzDnil5d1Jn+GDwOCA8S/1Hdbu/3fuyikD4vkQExfVbpPOUhy2J0V6GS
         3Ep7MOPJpOR+mYzCJ8mTbT6R9ubWiPWtJSiwr4IXWB7fxfqWGegKr9lRKbeneOXMNeBX
         TnoZ9ke1jjQrTgKeB/PPb6lO70aCEZl2peTY3qHVVfMSFdBzNQ+9RnVEYUTfXoM842ki
         OHGIavg99i0yUN0/fEWhax2IH7CDabS2Bk06yHgAtYjGCLCDHul2Sp++yHUWdieGET/C
         yTRfAVAnA1UO5BRyYQIYPNl8ubNrcX8YjMFnh7tPO9og8rsH800O0W+b6A2d4qeudyNj
         G9hw==
X-Forwarded-Encrypted: i=1; AJvYcCUCkk6b1c91nz2PaL4xTxkLvRkXcg3jwylk8OfCjmGGe5b81tankF6rV/MSBV75QhT+W+FgB66mF0q3sws=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCC71qwI7/XhcnACk/f6D+VD2Uw443HHLwYp+/DmA8sD7tBH8f
	MunbzkfBCzY14oQxWsF1v3DvP2SmQqaqtXykYnkv+CgTphnCAgJW
X-Google-Smtp-Source: AGHT+IFLDz359pHsc2wBqkj8GSYztNOx2FuQ08nojQ+WPfP4okZg0/NvdxD0ZGrejKkKKEZzlDXxow==
X-Received: by 2002:ac8:5f92:0:b0:461:20b2:ba00 with SMTP id d75a77b69052e-461641e12cbmr6963731cf.18.1730136898882;
        Mon, 28 Oct 2024 10:34:58 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4613211c6f5sm36475371cf.9.2024.10.28.10.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:34:58 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id CC0531200068;
	Mon, 28 Oct 2024 13:34:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 28 Oct 2024 13:34:57 -0400
X-ME-Sender: <xms:QcsfZ8DaykkxfbvWIQFHWmtQgp0QRgBNn71UTZZJ34lv27ZvcD3_Mg>
    <xme:QcsfZ-i_3RwWxisylFtDT1nBTjGjz-vZfwutdhXISg4ZS778AutXM8mhxtjuVt_HV
    9RHBelz4-_jPNywlA>
X-ME-Received: <xmr:QcsfZ_l9FZZNdTdPBq72Q3ug2FoQRhWpkFavc-5p-MnHqnf7U0K_Ou0lD7w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejledgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrd
    gtohhmqeenucggtffrrghtthgvrhhnpefhtedvgfdtueekvdekieetieetjeeihedvteeh
    uddujedvkedtkeefgedvvdehtdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgvpdhnsggprhgtphhtthhopeduuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    eptghmlhhlrghmrghssehgohhoghhlvgdrtghomhdprhgtphhtthhopegrkhhpmheslhhi
    nhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrh
    hnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvrhhnvghlqdht
    vggrmhesrghnughrohhiugdrtghomhdprhgtphhtthhopeihihhnghdrhhhurghnghesih
    hnthgvlhdrtghomhdprhgtphhtthhopehhohhorghnohhntdehghesghhmrghilhdrtgho
    mhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtth
    hopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthhopehlohhnghhmrghnsehr
    vgguhhgrthdrtghomh
X-ME-Proxy: <xmx:QcsfZyzFw4ol3DOXeSXf6YMxbnyy-KkhIRDlnm52WQ4Y1iUY2MnKnQ>
    <xmx:QcsfZxRAVCES09Oq1BGw9qyR7uZ2tf6FlCWyzWzUyQT9wiDeQG1GFA>
    <xmx:QcsfZ9bcx82AF639gQCFtrNxcizOrjuG4b_Uv7Mw1Lt51dWRTSpAWA>
    <xmx:QcsfZ6TcZspbGm7PdoKszk4r6dY9PaRjgWhMX8K806DOzm5Zzssy7g>
    <xmx:QcsfZ7AW6D_yU-A71n1YuCSXAbOcuoCpmTrgHmtuURz4shLgolYNkoOb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Oct 2024 13:34:57 -0400 (EDT)
Date: Mon, 28 Oct 2024 10:34:56 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	kernel-team@android.com, Huang Ying <ying.huang@intel.com>,
	"J. R. Okajima" <hooanon05g@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 0/3] lockdep: minor config and documentation fixes
Message-ID: <Zx_LQN1pgp6f9wM5@Boquns-Mac-mini.local>
References: <20241024183631.643450-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024183631.643450-1-cmllamas@google.com>

On Thu, Oct 24, 2024 at 06:36:25PM +0000, Carlos Llamas wrote:
> These are some minor follow-up patches that came up during conversation
> at: https://lore.kernel.org/all/30795.1620913191@jrobl/
> 
> This v3 is based on master as commit e0ba72e3a442 ("lockdep: upper limit
> LOCKDEP_CHAINS_BITS") has now landed.
> 
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: J. R. Okajima <hooanon05g@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> 

Queued into lockdep-for-tip for future tests and reviews, if all goes
well, this will be merged in tip during v6.13 and in mainline during
v6.14 merge window.

Thanks!

Regards,
Boqun

> v3: rebased on master and collected tags
> v2: https://lore.kernel.org/all/20240807143922.919604-1-cmllamas@google.com/
> v1: https://lore.kernel.org/all/20240806010128.402852-1-cmllamas@google.com/
> 
> Carlos Llamas (3):
>   lockdep: fix upper limit for LOCKDEP_*_BITS configs
>   lockdep: clarify size for LOCKDEP_*_BITS configs
>   lockdep: document MAX_LOCKDEP_CHAIN_HLOCKS calculation
> 
>  kernel/locking/lockdep_internals.h |  3 ++-
>  lib/Kconfig.debug                  | 18 +++++++++---------
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> -- 
> 2.47.0.163.g1226f6d8fa-goog
> 

