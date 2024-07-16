Return-Path: <linux-kernel+bounces-254346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8EC93320D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8861F2623F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 19:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84ED1A070D;
	Tue, 16 Jul 2024 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="msNMRdeP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UWt+sROd"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D931A01DA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 19:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721158447; cv=none; b=NvR9AZjW0mSQSqQOxky6deMIz/eQFj67bWn0d5gS67GT1X6y/RKc3WBcgKFhmPi6f5aqCmNbqO8twajJs8HsjoKMGEmHm9t9g0rD0A8/h57sqcL5+zHyHDv6/jy92NaxtGd+Z9NzOqjXHrffgj+TStBzUciynVKv+CptWxEfZhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721158447; c=relaxed/simple;
	bh=BVX0rHhMp1NQv8ticqtFXJgp7I8TSlU72oPlCRss4ds=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=NNg6la58AxbF70E6i/dndpxkyJfmZyJXjYfYe2wFrdVDKKGNKtEvVLR500G4swHAlmdhvHFz9MAy0G/1kGRJjcjj3BVLKBd/hS7enEyIhoPqKv4F0gOzzq36kQQHlUtoagyutwUjtlBaPCcvFxl7NQb55S9r8podVvY7kTfAO5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=msNMRdeP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UWt+sROd; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 62A6A1147E87;
	Tue, 16 Jul 2024 15:34:04 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 16 Jul 2024 15:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1721158444; x=1721244844; bh=TDhL7S6Al9
	iAbakQeQjPClMt67S4P0lNtZj45Ka2TjQ=; b=msNMRdePPF0EUzw9LOCRUHrmUf
	+dWOu9O0qWbuu3E5zUuIYkHSD+gTUVp4Ut+8jmxu1JtWe7c1xgaBAL/e9TiO0qIj
	whBTsm6rqVMvy6qD0pZu8sDEVlipOB2PUZrfQc8yelKBON+3mo+Ehf0xb60hmH5u
	KTPdZ8D99kxK5JE6rfQO98ThUlCt1MwPaE7Nqtil76Hvf2NKd996uI2wxsF0wk40
	Sf8BawuDW+LEnMrnTsbA9ongACYEbjqXNA8+lEdojw9szbwFa5XmLC3E9IorHQ+k
	oaCxiexquDCw2++jqGu0HzXrNK1JEF2R6HPqoS/QZSsgum8zqWPoYCESJNUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1721158444; x=1721244844; bh=TDhL7S6Al9iAbakQeQjPClMt67S4
	P0lNtZj45Ka2TjQ=; b=UWt+sROdxCrpFjh1ROym4vgbgF0M3BHNO+93ac2xb+np
	PozmzaYSH1AcaBqA/4qP0+8HhfXeo3t1Wub2IHECfWMiqQnIrvG+2XzT6brx3aE0
	VyMUXxKZ+6VV9I/BaD3dk47dWtXm3UnwFoPXRXi4aa+PAkBFwXSSkjbq2MiJgUGD
	AC4/LkZ3cqAj98pGZiqr99jBGArlUrSZjeWqsDb+E8WBEBBjqlUyZILFRzh8EZ/q
	kqiADoRhrL0GiH6DSG1vrEr3bf9G7hQOiR5R4J/Rhywcq73Pg+VzZoIVxq2xwozJ
	HbiCOP/BJ5P+dKEg2P+NcpO0qM1q4c15tZENR92EbA==
X-ME-Sender: <xms:K8uWZrS0WXGRV2EPDyBi6c5vdHOY5uGlFxBND_cAGZngBnv-r7BGFQ>
    <xme:K8uWZszEcdGPt3tmWfPFl9byezIy-6K_r-NFhO_n4OrAqUx2CzGeRwI2sJox6sJoK
    f39KFSGvag2Ll9Nf_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrgeeggddufeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:K8uWZg1rsK_k1Km6SMvauBroojqEBZ9U_QXe9G0ujqjBCAgJIWAT6A>
    <xmx:K8uWZrCuKomsxRoULawVwljE5fazPwixas9ZJU2y-Q2FhegM2Q87jg>
    <xmx:K8uWZkhFoqYC6nyQkyfF9Mljeq6AZw2Rw2py_9UFUHSS0Uyq868QSw>
    <xmx:K8uWZvrLnIzzT8jd0E3yebSTeB7hkl4sPSQKHxpB1SqBXae801wbvA>
    <xmx:LMuWZtUwNJb6MByqtpvYsP68ZQjFjt6lMVeDJZ3YxuwJoRpnqhKx42b6>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 27D48B6008D; Tue, 16 Jul 2024 15:34:03 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ed757bc4-38ba-420a-9da8-d7de1f1123f6@app.fastmail.com>
In-Reply-To: 
 <CAHk-=whp2O+NjOXf77hfATgEe-LHTefbFb0eR=ytQUJTOUnfdQ@mail.gmail.com>
References: <fe3126a0-7c32-426a-9997-77d76ade5179@app.fastmail.com>
 <b55b7bb8-97b6-4d25-9592-8213ecfe7b6c@app.fastmail.com>
 <CAHk-=whp2O+NjOXf77hfATgEe-LHTefbFb0eR=ytQUJTOUnfdQ@mail.gmail.com>
Date: Tue, 16 Jul 2024 21:33:42 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 soc@kernel.org, "Stephen Boyd" <sboyd@kernel.org>,
 "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
 "Luo Jie" <quic_luoj@quicinc.com>, "Bjorn Andersson" <andersson@kernel.org>,
 "Jagadeesh Kona" <quic_jkona@quicinc.com>
Subject: Re: [GIT PULL 2/4] soc: dt updates for 6.11
Content-Type: text/plain

On Tue, Jul 16, 2024, at 20:55, Linus Torvalds wrote:
> On Mon, 15 Jul 2024 at 14:03, Arnd Bergmann <arnd@arndb.de> wrote:
> And no, this is not some kind of merge mistake of mine. It was wrong
> in your tree.
>
> qcom_cc_really_probe() has always taken a
>
>     struct platform_device *pdev
>
> as the first argument, not a "struct device *". So the "&pdev->dev"
> thing is completely wrong, and always has been.
>
> Looking around, this was also reported by the kernel test robot at
>
>     https://lore.kernel.org/all/202407072331.baglL4Sd-lkp@intel.com/
>     https://lore.kernel.org/all/202407072212.WptVaUDt-lkp@intel.com/
>
> and still I had to just notice it in my local build test.
>
> I did fix it up, but this is *not* ok.

I'm very sorry about this. I had missed the extra driver slipping
in with the qcom DT patches at first and then failed to build test
the dt branch standalone even after I realized it was there.

I see that the interface change is in
git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git#clk-next,
which also contains the commit with the driver. This means you'll
probably have to revert your fix once you merge that branch.

Apparently the new driver was tested by the authors based on the
other changes that are in the clk tree, but committed on a branch
that didn't have them.

       Arnd

