Return-Path: <linux-kernel+bounces-263942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 546E093DCF4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 03:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C271F23E08
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 01:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6290E1878;
	Sat, 27 Jul 2024 01:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="wc4b3fPj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AbMe2EeV"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3917B186A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 01:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722044225; cv=none; b=EpSNs4NHM2+qz6UgEAc7QTSR1EjyhWE1gcZDGmC1v+dG4fVp2tO7KHnYfCMAxVxlZFdScktR/PDFl2X08l29xOFppVymIuZSmIqIcUcy7A4gJNKKJ3Es+9DNoKczFHCl6hXuS7dR47d1lxMdVZQ4egHJ2YgpgNPHfztqEZ29fx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722044225; c=relaxed/simple;
	bh=tla3eDKFXJGxqzcKzzAWNc2HUqJWlZY9BWNhCnF5QJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CX7dsymduJFJcSJi29HxiCAUfaN26KqtKdl+0oASdzZvGbRl2WGuCgC2HJqTFtpB99MUEWq7NXQtMX+xNd1z2Hx9J9P7IWl4YauqnWRv/9rKYpqiG/6xarrbcCN+ZfROsE4EvMT7J7/B4qNI4QH0SfULGuAl037uMaxe0Z32Mh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=wc4b3fPj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AbMe2EeV; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 41D81114016B;
	Fri, 26 Jul 2024 21:37:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 26 Jul 2024 21:37:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1722044221; x=
	1722130621; bh=aGQwEv9LAE+vilTM4phPNf8+PymlrONlm64LKRuFtL4=; b=w
	c4b3fPjZm53KAK2Uw4xsZxjaaH/2UenhYFSYZl+eU7gH07x6OAXECHVvN8jI5eO8
	6sa/iEdLpcedjWtJCSBu2U92s87f6gUCKy43ZmKIk1QhXVKi8L4S6XkJQV3YMLyZ
	4k6D5buyb/NemzfZj9Ill0zl6NS6HuNnw2cVKkXjJd3NEO3FfgWYrDUVXM2zEay5
	A68IJr40MqcFNB7HAki/xVAei8gdu8MKYNW8HHxCUOGgusl0gsGhYy7d6O6zrEIK
	yxfJzn+0JS1kGkXHhBcssqp54ovoa8bqp7BdJrxqjUGEMIVHf31lFmMt+bHTbFlw
	1xrvbelfNRsosb4QN4A1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722044221; x=1722130621; bh=aGQwEv9LAE+vilTM4phPNf8+Pyml
	rONlm64LKRuFtL4=; b=AbMe2EeVgSv3RdzBf6296Q0lTzO09srcxtg5CqA9GDdj
	yxLnvXaArevmmntXaS0gEnTCHChu0LrWcGIDwLNW1/eE/kkbhphgPFahAX/yvjir
	DjDP8bX36/Epw7s03GxfV/YGXie6xdYpzX3H1pzoX0FlbingoEkqkt3tjSm5SxA8
	L8EHGsiMnNkxWP/nTA4FHZlT9IIZ3NC9AsyONbOp2H0qthqL8m1Kh5/OkM+b2Cc4
	++3yh3oKgD5bCz/LjHzOU5YxyK90RXJ+igohzgTTuZGw0V8xkHX6wQbgddT2jgVd
	SM7HsCCyZOmCk68T4O7Ial8SIFY+AegS1kBOKfCqMw==
X-ME-Sender: <xms:PU-kZvgB94znfxKW0nX52dssSTPLQq-coaUbeDcWBqXZYHUe5ow9RA>
    <xme:PU-kZsDChhnArUqgaIeyaikCG8aTe2i18inrtDyjfLqKZ50GWbokGRoe9CfVoHZqh
    nVLv5Ofd9ybVCYa820>
X-ME-Received: <xmr:PU-kZvHDufHC1pRDYleAxm9WbONWkC6mjQhrSWFJUdCmnbsl9GLvfTNDUAtc5ui2KCR3bH8rgJ-WdL_reJpl82G2RkE4pS0mjUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieeigdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomhepvfgrkhgrshhhihcuufgrkhgrmhhothhouceoohdqthgrkhgr
    shhhihesshgrkhgrmhhotggthhhirdhjpheqnecuggftrfgrthhtvghrnhepveeilefhud
    ekffehkeffudduvedvfeduleelfeegieeljeehjeeuvdeghfetvedvnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhppdhnsggp
    rhgtphhtthhopedt
X-ME-Proxy: <xmx:PU-kZsRfMrdj-vjNQwsJu7xr2FHRXISP9YXRl7K3MRYt6K43LEW2tQ>
    <xmx:PU-kZsyicL-_-C2V9_zTET7RpUiMrF-zijBwdcLj3F1M3zHxY7Hynw>
    <xmx:PU-kZi41LzJr7Sr8mRnh4rPTCCWfxc49MDvWGghwlblQ2a-BOK9lmg>
    <xmx:PU-kZhyK5iQTQx5jC4sJqygH3Ck-4Bsoyq7johAozONw_ENFAiobyg>
    <xmx:PU-kZo_Sa_HyyBqylFxyWJE1zRen3bviUChgZYAkuLZI2Zoa5pLdk7fc>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jul 2024 21:36:59 -0400 (EDT)
Date: Sat, 27 Jul 2024 10:36:57 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, gustavo@embeddedor.com
Subject: Re: [PATCH] Revert "firewire: Annotate struct fw_iso_packet with
 __counted_by()"
Message-ID: <20240727013657.GB163039@workstation.local>
Mail-Followup-To: linux1394-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, gustavo@embeddedor.com
References: <20240725161648.130404-1-o-takashi@sakamocchi.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725161648.130404-1-o-takashi@sakamocchi.jp>

On Fri, Jul 26, 2024 at 01:16:48AM +0900, Takashi Sakamoto wrote:
> This reverts commit d3155742db89df3b3c96da383c400e6ff4d23c25.
> 
> The header_length field is byte unit, thus it can not express the number of
> elements in header field.
> 
> Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> ---
>  include/linux/firewire.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/firewire.h b/include/linux/firewire.h
> index 00abe0e5d602..1cca14cf5652 100644
> --- a/include/linux/firewire.h
> +++ b/include/linux/firewire.h
> @@ -462,9 +462,8 @@ struct fw_iso_packet {
>  				/* rx: Sync bit, wait for matching sy	*/
>  	u32 tag:2;		/* tx: Tag in packet header		*/
>  	u32 sy:4;		/* tx: Sy in packet header		*/
> -	u32 header_length:8;	/* Length of immediate header		*/
> -				/* tx: Top of 1394 isoch. data_block    */
> -	u32 header[] __counted_by(header_length);
> +	u32 header_length:8;	/* Size of immediate header		*/
> +	u32 header[];		/* tx: Top of 1394 isoch. data_block	*/
>  };
>  
>  #define FW_ISO_CONTEXT_TRANSMIT			0

Applied to for-linus branch in firewire subsystem tree[1], with slight
change of comment. It would be sent to mainline today with another patch[2].


[1] https://git.kernel.org/pub/scm/linux/kernel/git/ieee1394/linux1394.git/log/?h=for-linus
[2] https://lore.kernel.org/stable/20240725155640.128442-1-o-takashi@sakamocchi.jp/

Regards

Takashi Sakamoto

