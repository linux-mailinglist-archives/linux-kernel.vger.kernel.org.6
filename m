Return-Path: <linux-kernel+bounces-243737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ED29299D1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 23:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDD128156A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jul 2024 21:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6FA60B96;
	Sun,  7 Jul 2024 21:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="lLQWe5RB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zr/X68AV"
Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D4D524F
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jul 2024 21:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720388615; cv=none; b=TV2jTMcalNo8xo3POiivzM5ZvhgeyJgND7ezRE/BnrMuI2jSKx/gMfY6r09J8yeTjJ/scNJPd88r/Pb/8LTe2yZ0rk+EoSMyIBGnFwelo0kQF4aXtM+hfZ7LzhoGR9KjWZ2zxFzhfortjJtfGeBjNfRKZ3cmOCJPHzr1e9Igf0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720388615; c=relaxed/simple;
	bh=1uamMF8FmlFiYL3AfX4/AhJ/gWPQfNmgOkRZ5mmMLMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGbn5AmJ2bkYypK6STXQTSoRcD6OU+4VD0bNj49wCm/2CCqqzWpdyvxv+Q0fDFfnSVVeg4jc4uOq9X0+RKeVfKn6w0ZIDY1fh28Qf8w3XYS1F6JXaqeW7W0Ac7WIGyKv1vRiQyepit8Oee4d3jEtAVpuyN73Z99Mn17t4ECp5Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=lLQWe5RB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zr/X68AV; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id AB8CC13802E6;
	Sun,  7 Jul 2024 17:43:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 07 Jul 2024 17:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1720388611; x=
	1720475011; bh=xt+HlmR1s84WsBoGqDJDIMxpN8aHSwMnJsBwuWrNkd4=; b=l
	LQWe5RBAP55W198nB6fONq3jZ8s06rnlaqt89QdZwNZRdjGVCaQeiqWkjGBSicj+
	Ob7K7v8F1Qe6Hze9VNAzxFcAzieuvKXi2pI/pCCFntCp8Z12ewVmbsppyonoehE6
	sAugLGfpe6l80PYnkl1RfeXuHMt6fzVPPk1dtGkGp3gOiw0B35MYvcEKn6oCWOpl
	HfxSko5wlmq1ZXy3BXZCRJWzbWeaRkmUpZY8+Nc/ilxlXRoO2H8pskj3yfPTUrfv
	uoo6jxfmy0kCopTTrJvo/J8/RGwVuSHExAwi3ismK8lMq5Ni0812Ncr1DIVEfLWL
	eKff/g1y8gQPe0sOihUeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1720388611; x=1720475011; bh=xt+HlmR1s84WsBoGqDJDIMxpN8aH
	SwMnJsBwuWrNkd4=; b=Zr/X68AVCZ8tLjzDp4dyCiyuS5yLSEDsc7yLqn98W2LM
	MHLn78fw7U/A47ZxU/g9kUx4E5fF5f4DRXYaXS+mSnGdoohcSi7azq6VTlVOC9mc
	RSbocWS1Cc1AMM73ax/bzEp30nocWqbz71f2eV8Co/74e0axH6DRYkOJQNtlVapJ
	fWTVaxPG204BKNvvnp50GpS9Ch+7wwAgu0c9Ov+FcWtdaolx/Mvk0odBXSVfKNYw
	I7nNx+cIisUlPUHsn8Ee5fFOZpctsX1uASZKwsq3AuDoSnRsFVcdt14NLDLUPuFs
	+uIGap4uRzTOBkk7Vs80EmfEYM3Z6BSY3VU5yu0AUw==
X-ME-Sender: <xms:AwyLZp2gSIVM34SzlLXaNBfQCiKNPW9nr40TlQ6d8YedZIN37P-HhQ>
    <xme:AwyLZgGN636olgntwiJf6ZpoHobS0nf8dtpim22JIetm_yA7Tu2FZHYbyqt6KX2_t
    5vPup9Uj1WpLGgPg9I>
X-ME-Received: <xmr:AwyLZp5HRn08XGjoc2bAFihtt_Wqqrk453ltF3_G9EoBR6CZc-gUhUtwpUGJ9aT4U8u_kOK0pQpfZ39XYDMqeF9xXvA_KaokbwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeigddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveeilefhud
    ekffehkeffudduvedvfeduleelfeegieeljeehjeeuvdeghfetvedvnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:AwyLZm3ez8nlvab5kmIF-Pq0hA1c4S0eN0SUJ-GBWyzQEtmytVRX3Q>
    <xmx:AwyLZsFmF35LYYNR5thn19FbdAMgn-fhK-pMED3LIZJ3YDuUIyCaDg>
    <xmx:AwyLZn_CGk_4KdwE0XGLa24R5NyIf1lpxJb2iTzQcEUGcNOXe91JoQ>
    <xmx:AwyLZpl71Jq4zoYQKLO3S9GZymeVMe3anpAxjBuGxHlQXGVLnr5I0A>
    <xmx:AwyLZgBZQ7ToeDqMMMmXmc-mi6_CZIlZBSQVwh8UfJ0J58ZPPCGfAhoQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Jul 2024 17:43:30 -0400 (EDT)
Date: Mon, 8 Jul 2024 06:43:26 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] Revert "firewire: ohci: use common macro to interpret
 be32 data in le32 buffer"
Message-ID: <20240707214326.GA16237@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20240707134523.11784-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707134523.11784-1-o-takashi@sakamocchi.jp>

On Sun, Jul 07, 2024 at 10:45:23PM +0900, Takashi Sakamoto wrote:
> This reverts commit f26a38e61c03fdfacb6b596e1daf665cf4526a60, since it
> causes the following sparse warnings:
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/firewire/ohci.c:891:23: sparse: sparse: cast to restricted __be32
> >> drivers/firewire/ohci.c:891:23: sparse: sparse: cast from restricted __le32
>    drivers/firewire/ohci.c:892:23: sparse: sparse: cast to restricted __be32
>    drivers/firewire/ohci.c:892:23: sparse: sparse: cast from restricted __le32
>    drivers/firewire/ohci.c:893:23: sparse: sparse: cast to restricted __be32
>    drivers/firewire/ohci.c:893:23: sparse: sparse: cast from restricted __le32
>    drivers/firewire/ohci.c:905:31: sparse: sparse: cast to restricted __be32
>    drivers/firewire/ohci.c:905:31: sparse: sparse: cast from restricted __le32
>    drivers/firewire/ohci.c:914:31: sparse: sparse: cast to restricted __be32
>    drivers/firewire/ohci.c:914:31: sparse: sparse: cast from restricted __le32
>    drivers/firewire/ohci.c:939:18: sparse: sparse: cast to restricted __be32
>    drivers/firewire/ohci.c:939:18: sparse: sparse: cast from restricted __le32
>    drivers/firewire/ohci.c:2033:23: sparse: sparse: cast to restricted __be32
>    drivers/firewire/ohci.c:2033:23: sparse: sparse: cast from restricted __le32
>    drivers/firewire/ohci.c:2037:27: sparse: sparse: cast to restricted __be32
>    drivers/firewire/ohci.c:2037:27: sparse: sparse: cast from restricted __le32
>    drivers/firewire/ohci.c:2038:27: sparse: sparse: cast to restricted __be32
>    drivers/firewire/ohci.c:2038:27: sparse: sparse: cast from restricted __le32
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407050656.03bw1YXA-lkp@intel.com/
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/ohci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next branch.


Regards

Takashi Sakamoto

