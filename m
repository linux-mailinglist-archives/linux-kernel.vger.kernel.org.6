Return-Path: <linux-kernel+bounces-569198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121F8A69FDF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61993AD250
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 06:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEA51EDA1A;
	Thu, 20 Mar 2025 06:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hriKurFW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEB279C4
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742452555; cv=none; b=MyVwi/T9fdrrGmVP/aGw7McWkPR6qdogTJNAkuHUQkv4jTVb6F9q0jSvnmexAQOP1J7DIDq1IuSA7gYVIrKCpulpgJJBX9UIaAulnloJokm5G3FERrC9z/M3E1pAEOFxlPJBv0vDZ0GKtctu7357wdHHxmE6WCllY02L6t0fJZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742452555; c=relaxed/simple;
	bh=szwn4Bj/PLXzPNZdH0y+zZEVHCkEJQZXEyGBSUkWYuU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BPbpjrVMWWai1GlGepDcuTTN8bCJicizUcjAIe+UvguYQsUBruF9hYlW0npfRHxVCwac4ZDj4RPDyoLd3MfPzQG8n+LX3B0BzG0nwkJIqKNZGDIjH0RxHBniymEPTq/xM8vVRyhNALS/Cz41kCdykLvNeyamEgm9oKrGVtH4HLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hriKurFW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAE5C4CEEC
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 06:35:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742452554;
	bh=szwn4Bj/PLXzPNZdH0y+zZEVHCkEJQZXEyGBSUkWYuU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=hriKurFWsfSomsK7L1cARccJyhdGUfqrdimlzk3C8I3tyYuf9crM/vgwdkhKQoNKA
	 u+JBuiKLUxxLGadIAeEcyVBPJdrXE0sJogbBbsCKT0Z+BOMWJy+bnnxtQzptTDMgzO
	 SDS5ZBI+9wZ/lWw2tp/wHDPW1Qv7b8pxYr/cwGFVZVvgsXvoqMnJqi6fOeAmmvwzun
	 4Sxl2x9umSirtAC8jIFDGAoA9lSCGz6mDVTdlfZdvJwofQuWxEtT9O/giycs4476r1
	 fAxDxNtyS+/FhYU1FGenbAdbAuddrRM1HIvkb2HWOkAlawsCKiwY8SnlVblTr7EN8a
	 hmleDNSQbm1Ag==
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id D13121200068;
	Thu, 20 Mar 2025 02:35:53 -0400 (EDT)
Received: from phl-imap-12 ([10.202.2.86])
  by phl-compute-10.internal (MEProxy); Thu, 20 Mar 2025 02:35:53 -0400
X-ME-Sender: <xms:SbfbZ9E0Mffxbs1zs9rFEMFzbL2njv02GbVegGupSQVdcTzzCeSu8A>
    <xme:SbfbZyVfCaxE29fd88NMBjDmjPUdWHT9SP7_YiqJdzvX5vjHSiRswyORp4BCW_6Z5
    4sP25dPey9Y2OQ9h_E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertder
    tddtnecuhfhrohhmpedfnfgvohhnucftohhmrghnohhvshhkhidfuceolhgvohhnsehkvg
    hrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepjeevffelgfelvdfgvedvteelhefh
    vdffheegffekveelieevfeejteeileeuuedvnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheplhgvohhnodhmvghsmhhtphgruhhthhhpvghrshho
    nhgrlhhithihqdduvdeftdehfeelkeegqddvjeejleejjedvkedqlhgvohhnpeepkhgvrh
    hnvghlrdhorhhgsehlvghonhdrnhhupdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehsfhhrsegtrghnsgdrrghuuhhgrdhorhhgrdgruhdprh
    gtphhtthhopehjghhgsehnvhhiughirgdrtghomhdprhgtphhtthhopehlvghonhhrohes
    nhhvihguihgrrdgtohhmpdhrtghpthhtohepmhhitghhrggvlhhguhhrsehnvhhiughirg
    drtghomhdprhgtphhtthhopeihihhshhgrihhhsehnvhhiughirgdrtghomhdprhgtphht
    thhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehlihhnuhigqdhnvgigthesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:SbfbZ_IY9W6f_dGfzwoi3HrXpdvBzfF-MIBCX0DbK0tsOqmwyU3_Jw>
    <xmx:SbfbZzF3wJKgf7tx7bMVRIJNOh1fGMUVlBIH33-vS-aMk8sCyP9fLQ>
    <xmx:SbfbZzWKeAJe5hMaI-C6h9aG0RjHJ1VoMFjSEIEbsU1acv8ssTFLUg>
    <xmx:SbfbZ-MSQTlxdYEjZPtDfhxq0yci9ablpL5-4M8_1MDdhVLoRlQhpA>
    <xmx:SbfbZy2Ojo1tiqsp6lKI0waiBE7_CdYarsraM9sTFbswRWGd1DbCKdt8>
Feedback-ID: i927946fb:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A85A11C20066; Thu, 20 Mar 2025 02:35:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T206c77f1cb322050
Date: Thu, 20 Mar 2025 08:35:32 +0200
From: "Leon Romanovsky" <leon@kernel.org>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>,
 "Jason Gunthorpe" <jgg@nvidia.com>, "Leon Romanovsky" <leonro@nvidia.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 "Linux Next Mailing List" <linux-next@vger.kernel.org>,
 "Michael Guralnik" <michaelgur@nvidia.com>,
 "Yishai Hadas" <yishaih@nvidia.com>
Message-Id: <64f58e2e-3081-4523-af37-b6c344ea301d@app.fastmail.com>
In-Reply-To: <20250320120823.588aa58e@canb.auug.org.au>
References: <20250320120823.588aa58e@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the rdma tree with Linus' tree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Thu, Mar 20, 2025, at 03:08, Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the rdma tree got a conflict in:
>
>   drivers/infiniband/hw/mlx5/mr.c
>
> between commit:
>
>   cc668a11e6ac ("RDMA/mlx5: Fix a race for DMABUF MR which can lead to 
> CQE with error")
>
> from Linus' tree and commit:
>
>   24d693cf6c89 ("RDMA/mlx5: Fix cache entry update on dereg error")
>
> from the rdma tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> -- 
> Cheers,
> Stephen Rothwell
>
> diff --cc drivers/infiniband/hw/mlx5/mr.c
> index 753faa9ad06a,2080458cabd1..000000000000
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@@ -2023,8 -2031,7 +2032,9 @@@ static int mlx5_revoke_mr(struct mlx5_i
>   	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
>   	struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
>   	bool is_odp = is_odp_mr(mr);
>  +	bool is_odp_dma_buf = is_dmabuf_mr(mr) &&
>  +			!to_ib_umem_dmabuf(mr->umem)->pinned;
> + 	bool from_cache = !!ent;
>   	int ret = 0;

LGTM, Thanks a lot.

>  
>   	if (is_odp)

