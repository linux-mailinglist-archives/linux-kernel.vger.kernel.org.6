Return-Path: <linux-kernel+bounces-282053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2EC94DF2E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Aug 2024 00:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B8261F21CB1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Aug 2024 22:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66B31422CC;
	Sat, 10 Aug 2024 22:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="Dx9UXrTv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nowOQL6t"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AE138DD4
	for <linux-kernel@vger.kernel.org>; Sat, 10 Aug 2024 22:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723329206; cv=none; b=LJoaZX2zNBcz/xhlg+dilXeLADTnnAn+4iKo/Gc6fgakzUj7IwrEdWLna8URV/Y3h296r83dcExUYutFsbPRM64767ramym76skz+hBNa52FAz5twrpETuIrkDDfNNfcjWsGcSAz2Y/beWyV9BGW8V7LLhcjN0M8VHyFZVc86lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723329206; c=relaxed/simple;
	bh=3/uj7NN4PtfW51YLATXZ/VahyiuEFth/ZyA+aC/N8G8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQPLin0SSUGgBdpLdAME9/Fs6ITIIQx42ZsIWWbmOXDUWg72/b5NTGOGEyU1VkdnAC5RHg6aKSq5QxFtKS5OCjVFWyFmnr0ToG/P2O0gSvCo8PK+EWm9ZR780i1cDgsJQzu4oQ46eqTWoOHbs/Ow6vXxnKo9hWh+lINfvFUuCGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=Dx9UXrTv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nowOQL6t; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E632E1151B6A;
	Sat, 10 Aug 2024 18:33:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 10 Aug 2024 18:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1723329202; x=
	1723415602; bh=16V/ecT+Q3nGYJ/WX/ghSoW8dgWNcKTfOO+4QSdRadY=; b=D
	x9UXrTvKdqX+nV/Z/ORnMEifuI+9V87tT29ac83M+HQ+DiRMhYBc87yR4qimd7dN
	YNauDOelBteJLGjFELjc4vd/HCP+Lz9fQrCKhtURsOrxUuHE/NKvik5iEV+lxsuU
	xxrm5HE0IalRrZeaXJ9Rj8O0qrcep9SGO8nXo3kVjB2YgTf0TITzaf1KU/+AXnRT
	6s2StbX+bCdEs4X2FDqByur7v2g0RZ+GUdp1pSKLXjqTMfveZ1u+ChltJ00lTjNy
	6Yhjgmqxd/sqc5vFYVg8fQI1/eWoNSnboUTcRWVaPSzQPkdrhJDWBiB3Es/JPU/a
	9fHOnOJZJQ/itcXpEnEzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723329202; x=1723415602; bh=16V/ecT+Q3nGYJ/WX/ghSoW8dgWN
	cKTfOO+4QSdRadY=; b=nowOQL6tUJAneBxZDncGR01PWucfnuYH6t6L3Ayts/xI
	t0H/NgmsOTCuA9oJf5sy4LW6ftkHpWhyfr1CKGh4+jp1oBjSqrLHCiiSEiC8FrdR
	GFdTXWB2MgpOHGuWji3lgoqGVlzOAjsOUSGKntUEiND+0u2qWBS9PD8v2LS7XU6d
	knV4r+SwBszePmgd+chFYHsmn5PRWjM/M4cOAXxPJ7b5OqWtPCjOg1yl4Z8RFXHe
	vjF2V4gqiKmmyEJxaq+EzTF8VKGjsOIAWr6fO6yqEsHIC2aAVomjK092iQoynBS+
	ozNjF+opgXWzHGAuRXNdszxa2bsyhGRzJAeuOGTCtg==
X-ME-Sender: <xms:suq3ZsHh5uLV4Oyi1SJOMoskaxDmyMTmyPjGAdNxcHh2jd2o8h3LpQ>
    <xme:suq3ZlWhA8-Ay1aUp7ezPvOwFFcQoMw79YVL1q_dBjzsNbpYC2vzNInwcMrwMeBme
    -qIRKPij3jI4fUO6S0>
X-ME-Received: <xmr:suq3ZmJnOs-calY88B6bmtJU0YES_MASIop1Lc0IuqCbo35aNLd23GmKy_6keDpmAAItTjcmdMeqf6SAzcTo9rgUkk80hzYn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrleejgdduvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhho
    thhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrth
    htvghrnhephefhhfettefgkedvieeuffevveeufedtlefhjeeiieetvdelfedtgfefuedu
    keeunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepoh
    dqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugidufeelgedquggvvhgvlh
    eslhhishhtshdrshhouhhrtggvfhhorhhgvgdrnhgvthdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:suq3ZuF8-0NrgniJFrLNw4UjS9S3GY2ypvJpARbCN78YkoC7sSfq2g>
    <xmx:suq3ZiUW9l0P3l1waHLXozA61BQh8cQGHXxa2cOLTaGpTWgWDoGkmQ>
    <xmx:suq3ZhNIrxo4WB7tVmh-Y4pJ-rJ1JTtW-lqwHS91VNsALmW_CqdoeA>
    <xmx:suq3Zp1ThDUrqxw32QXPk1ajwN9ZVBSsjwYHU0GX7tqxvaz3CB6eiw>
    <xmx:suq3Zvjind_N46F0aB10i2IFblgaLc6Npgd0qxeDn-9K9VZwVYlu3yXj>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 10 Aug 2024 18:33:21 -0400 (EDT)
Date: Sun, 11 Aug 2024 07:33:18 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: correct range of block for case of
 switch statement
Message-ID: <20240810223318.GA74211@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240810070403.36801-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240810070403.36801-1-o-takashi@sakamocchi.jp>

On Sat, Aug 10, 2024 at 04:04:03PM +0900, Takashi Sakamoto wrote:
> A commit d8527cab6c31 ("firewire: cdev: implement new event to notify
> response subaction with time stamp") adds an additional case,
> FW_CDEV_EVENT_RESPONSE2, into switch statement in complete_transaction().
> However, the range of block is beyond to the case label and reaches
> neibour default label.
> 
> This commit corrects the range of block. Fortunately, it has few impacts
> in practice since the local variable in the scope under the label is not
> used in codes under default label.
> 
> Fixes: d8527cab6c31 ("firewire: cdev: implement new event to notify response subaction with time stamp")
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/core-cdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firewire/core-cdev.c b/drivers/firewire/core-cdev.c
> index 672a37fa8343..c211bb19c94e 100644
> --- a/drivers/firewire/core-cdev.c
> +++ b/drivers/firewire/core-cdev.c
> @@ -589,11 +589,11 @@ static void complete_transaction(struct fw_card *card, int rcode, u32 request_ts
>  		queue_event(client, &e->event, rsp, sizeof(*rsp) + rsp->length, NULL, 0);
>  
>  		break;
> +	}
>  	default:
>  		WARN_ON(1);
>  		break;
>  	}
> -	}
>  
>  	/* Drop the idr's reference */
>  	client_put(client);

Applied for-next branch.


Regards

Takashi Sakamoto

