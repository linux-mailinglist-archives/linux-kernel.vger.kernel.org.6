Return-Path: <linux-kernel+bounces-271916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B4F9454EE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 01:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 418951C231FA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 23:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E169B14E2D9;
	Thu,  1 Aug 2024 23:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="ZlCMqIs8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W0OR6anF"
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DC314C599
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 23:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722554985; cv=none; b=AnGAM3896BLkg+/gLt0TE1NCjn3KLKvbd+zAuRCRijB+M+be29DBJfA7a7EKdORK54BEelmJqTSbJv4qG7bIzf8Qo4Nh4PRr6CB2G0Tx5xvpVlk2IlGI4kGVH8F4J4CwANE1DuUXHao/i+ft7ri0bHNFyndtHka+r3StDxztC/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722554985; c=relaxed/simple;
	bh=Rz+IyWh3a89HCuJdqrOJFFIAogL5zrk5daoJOmAHT1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYTJc2W57XLZYZApwmI0ndic+EcvzuNahWmwil5Q1M7OG4PM0boHMOQwN5NkJ8TAr9nP+y07MB5IhzBFN8tIQI9JhdqBxMY0pXkMGHOBLrq1IOC20vWXqT3PZVsJ7tyRXri9sUl5IJ1/2bX6sVi3lfnjbTTTMeQFRBunp7+7v6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=ZlCMqIs8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W0OR6anF; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 15C2B138C92C;
	Thu,  1 Aug 2024 19:29:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 01 Aug 2024 19:29:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722554982; x=
	1722641382; bh=cWzBNSyZr/nWD+nAfENMlUJZa1DrpVqdWP/gez6SRyI=; b=Z
	lCMqIs86IwIn0cZCF5gL9viZ7kEDB5OcBT3pB3iLgligDx2C1bPB2S8wzf5ine/I
	QKWTbP9ZhRsfhZwr6X8GttQvSn+UMdw2ajJ8FsslUoMdBEqTcMt9z1+vkCtPZyEl
	gM5ALiG1+7nojjMYzzRKoQY89wCA7Q2QbceVu63hEfMEMqHSoWg+oN1/B5h3JNZH
	K4o1yEq+ItmgZ748Mh5tyOb8Gvcgnw8YKlFxva4aSP/uxvaT0KhgW6GH3rZKrRuP
	rw2JP+ds9V9/k48edFutelmotXQluAVruHJiMwCm1AbWknasqIZt22ztWv9qCdRt
	rtjt4dNqgX6y86jrZzKog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722554982; x=1722641382; bh=cWzBNSyZr/nWD+nAfENMlUJZa1Dr
	pVqdWP/gez6SRyI=; b=W0OR6anF1S/9KUFhZmsVZ+lMBf/kgMOMeg4N7+Qux4In
	PbiO5rZI4CZOCJMKJ87SRuUgrjcN5jQFuEluc26Pu9l4/d6JY5RR4gocA2vyFM7n
	V4XRBclbyNtFVRc/pdTkiO/c0g9H/nIg1S9oB79DseWI0Md8osPMNkouiRS4getl
	SxoOHPlpbX8k8+kwNZZthgMZZqExlQEUHPxW92eqT6xbYiadGagNjz+eQZq933x+
	Kr2jap6b1gleaMAjl6q+5y3Mub2/GixUURV8lZY/WOPe2mW0qkkfaJ1PQ9sJT1sC
	4QguISjDX43eBPx43sH6CQmg7EKBpoHEm+4CXwghbw==
X-ME-Sender: <xms:ZRqsZiYEWwwoS-uXAip76jTJezvLiHkaeQMsTl15euitbzCXQqwl2g>
    <xme:ZRqsZlYEeRdQJunJ4lsun-ZI4exux2nkE1kni4G1Yt6RuGhqv9AEz2hIMUgpIrqGS
    VuGA2LNIa_dvNyD_Jo>
X-ME-Received: <xmr:ZRqsZs90FEN8jwAR3VdYKgnp9HcucaeWi85QnL08Mkmz01jqid4L3goYxDWaYVc4nUQ4WY4olI-K5WPX3Ob5hzvVwXb_NOFMuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeelgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhephefhhfette
    fgkedvieeuffevveeufedtlefhjeeiieetvdelfedtgfefuedukeeunecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohdqthgrkhgrshhhihessh
    grkhgrmhhotggthhhirdhjphdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:ZRqsZkoiX2bi8sCDyu-BLnf78IgHj5eKhVW7zLFh3Il-dzGXfQ04IQ>
    <xmx:ZRqsZtrZyxMBLPZi2enJ87iIVNHe2XiNEfxxQcavdstwPR7tX7JsNw>
    <xmx:ZRqsZiQ6ZPVzorbQxXPpDGZKpOM6kCDnAb-CjRK0QTCiAeht6gEnRg>
    <xmx:ZRqsZtqqtsvKV-pNVmQoefgwnCfoZLWMu7nvaWUE-LAMDdiObxqKQg>
    <xmx:ZhqsZk2I4sic7G11KpnSEWO-TE_h5iEeipph6R_0dC-W1g57beWX_mth>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 19:29:40 -0400 (EDT)
Date: Fri, 2 Aug 2024 08:29:38 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firewire: core: utilize kref to maintain fw_node with
 reference counting
Message-ID: <20240801232938.GA58901@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
References: <20240801022629.31857-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801022629.31857-1-o-takashi@sakamocchi.jp>

On Thu, Aug 01, 2024 at 11:26:29AM +0900, Takashi Sakamoto wrote:
> Current implementation directly uses refcount_t to maintain the life time
> of fw_node, while kref is available for the same purpose.
> 
> This commit replaces the implementation with kref.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  drivers/firewire/core-topology.c |  2 +-
>  drivers/firewire/core.h          | 15 +++++++++++----
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/firewire/core-topology.c b/drivers/firewire/core-topology.c
> index b4e637aa6932..46e6eb287d24 100644
> --- a/drivers/firewire/core-topology.c
> +++ b/drivers/firewire/core-topology.c
> @@ -39,7 +39,7 @@ static struct fw_node *fw_node_create(u32 sid, int port_count, int color)
>  	node->initiated_reset = phy_packet_self_id_zero_get_initiated_reset(sid);
>  	node->port_count = port_count;
>  
> -	refcount_set(&node->ref_count, 1);
> +	kref_init(&node->kref);
>  	INIT_LIST_HEAD(&node->link);
>  
>  	return node;
> diff --git a/drivers/firewire/core.h b/drivers/firewire/core.h
> index 7c36d2628e37..189e15e6ba82 100644
> --- a/drivers/firewire/core.h
> +++ b/drivers/firewire/core.h
> @@ -183,7 +183,8 @@ struct fw_node {
>  			 * local node to this node. */
>  	u8 max_depth:4;	/* Maximum depth to any leaf node */
>  	u8 max_hops:4;	/* Max hops in this sub tree */
> -	refcount_t ref_count;
> +
> +	struct kref kref;
>  
>  	/* For serializing node topology into a list. */
>  	struct list_head link;
> @@ -196,15 +197,21 @@ struct fw_node {
>  
>  static inline struct fw_node *fw_node_get(struct fw_node *node)
>  {
> -	refcount_inc(&node->ref_count);
> +	kref_get(&node->kref);
>  
>  	return node;
>  }
>  
> +static void release_node(struct kref *kref)
> +{
> +	struct fw_node *node = container_of(kref, struct fw_node, kref);
> +
> +	kfree(node);
> +}
> +
>  static inline void fw_node_put(struct fw_node *node)
>  {
> -	if (refcount_dec_and_test(&node->ref_count))
> -		kfree(node);
> +	kref_put(&node->kref, release_node);
>  }
>  
>  void fw_core_handle_bus_reset(struct fw_card *card, int node_id,

Applied to for-next branch.


Regards

Takashi Sakamoto

