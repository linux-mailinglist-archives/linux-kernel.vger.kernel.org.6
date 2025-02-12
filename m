Return-Path: <linux-kernel+bounces-511139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF65CA3267C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 626497A28B4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEA420E006;
	Wed, 12 Feb 2025 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="ebOHMC8s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="igHe+GkC"
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A48820CCF5
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365421; cv=none; b=T02of+ChNUAR4Rc6rLfUgUeT4YQejdUWjvfx81/e7BdKK70wGx8GpB0aS3+huoalvugQxFVAYRvby909unSxCbgs2yyhMAS6Fui6O0QnWQdv+/JR4LrnXBlci9VVWPiP+EhMki9QnXj+VRoG2c+rlfCIgnP+iTWA8uCmJqkS73w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365421; c=relaxed/simple;
	bh=5I+GoDOLPXwxaF/bdd/7zGEhpTleAA3217JXKvjhE4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKAmruBCXzp958mvka/V1QpFi08LBjPHmcOssl18Zr0G66qnxSgt6gPDPI3wH+oEejajKvylmTHJgba4nkaF2PpyExmr0GAYAJAlM/xE2Y1SrUgWXVZ4Ns0APOk6E92keH/X3CYecd4QGreJjsNe+84liLQx0SfygNUOOILyZqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=ebOHMC8s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=igHe+GkC; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 330B3114018F;
	Wed, 12 Feb 2025 08:03:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 12 Feb 2025 08:03:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1739365419; x=
	1739451819; bh=+Y6Ib/RSqKlmrUGsG+NEeNPWdjzf+UWt/aq1y+kKLoo=; b=e
	bOHMC8smW1FFDE+T0YMtLUOKeN1+oIci9V47ehV5TsmcVSEDTaBnlfpFVtuV/HlM
	tojgIXacFPQrNfJAfcXQlcX4vmyGyC62P5JC6z5c5Ti6FtQfK/RnB16QovbR2Vg4
	yNQltaSxbohA9ce+GWU8Qiizp1UVyvzmaFDDpsY3o408CwbnJ8yzflHOJ+mcct7y
	wVZbgsgxJWoOnV7fhDAcdnVrtq0CErG/z+UO/W7l60da8/ovSvhnQt5UWHs9D8It
	bmdyMaxg7M2s81ka/lN6rUhLXCvMX38J9w/TNA8FSxCNGfZk6AxRY60uUr1OMhnX
	wGP7aVQtDfEjsd8H4jKXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739365419; x=1739451819; bh=+Y6Ib/RSqKlmrUGsG+NEeNPWdjzf+UWt/aq
	1y+kKLoo=; b=igHe+GkC+oO+sjhu6f82OnkmsCRSej4hthz39z6T7SI7A1V7USa
	C0ChkJr3ZLxH6qdWrz0iVfixykXVIoxcvImA6SMKFZSSRF47ms91195Fgu3uW1dv
	2G+1mltvF1P7v+1z9fOD0PAIlE3GECltkioTXLvFnAT7m6+nWfFK9XI1c9OlrUaa
	LZJs4a0WZEjO1ozrr5irYYqs1H5DfjdOZxEfroqDVQ8YAsU7Av3V3tSI2DYi+3L7
	aj/sdq5Ad12YeXY9YAsZBR4nKYTCV3LRfeVtF7KftgdkQonrQdHJH64RR5KkTIz9
	oLM2kOSH3TFOr8xsQczzLHbGIzxbqGo7wpg==
X-ME-Sender: <xms:KpysZ75bDcq_Dv4rOLfzrNvSYQobhozPKD00g9ykeYpNwm5N_OO9xA>
    <xme:KpysZw7gOqfwR4FcUZAbcilF329sUpIO2-USYUVGeXm5e_SiyYyR1XjAUKSkIywmn
    ciIIgF8ZJ2omaaXEmY>
X-ME-Received: <xmr:KpysZydSpsHBuveNzQPtc7PVWNd3DsvmV4Fa4l29PPTXUEAzUVaA8DXV2lowNFBwd7TG4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddv
    necuhfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllh
    esshhhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhepffdvveeuteduhffh
    ffevlefhteefveevkeelveejudduvedvuddvleetudevhfeknecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhho
    vhdrnhgrmhgvpdhnsggprhgtphhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepvhgrnhhnrghpuhhrvhgvsehgohhoghhlvgdrtghomhdprhgtphhtthhopeig
    keeisehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpsghonhiiihhnihesrhgvughh
    rghtrdgtohhmpdhrtghpthhtohepshgvrghnjhgtsehgohhoghhlvgdrtghomhdprhgtph
    htthhopegvrhguvghmrghkthgrshesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprggt
    khgvrhhlvgihthhnghesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhigghgrohesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtohepshgrghhishesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:KpysZ8Jwd7SmUdQWsB3CpA0XEQr-SHdSQ7jlFyvn9SUqaG9MJX2l2Q>
    <xmx:K5ysZ_ISRZEj5D7uqBAOmfmWJnHizY5LxtmdRkS-1lCC5YHIcKva2A>
    <xmx:K5ysZ1wZbb3pCgjaOIspFoZ9YvEIdtSY8arRyUhyuYA489Suyb1fBQ>
    <xmx:K5ysZ7IFqkeMAZ9_wB3Ajs9IzHjgOEavHiMs4s7lUGJRVUTvFT7KlQ>
    <xmx:K5ysZ467oL4q_Dc7qqNBCmU0GVPQk3MrvpHn2okmIPgDb2hS16BvFaq2>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 08:03:33 -0500 (EST)
Date: Wed, 12 Feb 2025 15:03:30 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Vishal Annapurve <vannapurve@google.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	seanjc@google.com, erdemaktas@google.com, ackerleytng@google.com, jxgao@google.com, 
	sagis@google.com, oupton@google.com, pgonda@google.com, 
	dave.hansen@linux.intel.com, linux-coco@lists.linux.dev, chao.p.peng@linux.intel.com, 
	isaku.yamahata@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH V4 4/4] x86/tdx: Remove TDX specific idle routine
Message-ID: <avodert2s5di3s4m3ays6z4qhskwfz6zxenoq3rsf7crpclkfz@jaq7ptkmco4o>
References: <20250212000747.3403836-1-vannapurve@google.com>
 <20250212000747.3403836-5-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212000747.3403836-5-vannapurve@google.com>

On Wed, Feb 12, 2025 at 12:07:47AM +0000, Vishal Annapurve wrote:
> With explicit dependency on CONFIG_PARAVIRT and TDX specific
> halt()/safe_halt() routines in place, default_idle() is safe to execute for
> TDX VMs. Remove TDX specific idle routine override which is now
> redundant.

I am not convinced that it is good idea.

It adds two needless flipping of IF in the hot path: first enabling
interrupts in tdx_safe_halt() and disabling it back in default_idle().

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

