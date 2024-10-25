Return-Path: <linux-kernel+bounces-382127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA159B09CF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 18:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981AE1F23B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 16:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DA8187874;
	Fri, 25 Oct 2024 16:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORsXMbD2"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628AB1D86FF
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 16:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729873402; cv=none; b=aYzv5M3xB5iClgpWNCbDcwIVD49wUHXP4XqTSQgBHBbz0OlgfqLaSC+hu47INI/hOdoepTZtYzLzdz8BIOWFPnFLLPGj0Vrl2ZGtGaougu7f4ktnT0gQVX1VzdpjZ5ORV2eTQWRkLxgqkueybbvwRslzmqLWMPVHKbfAFEQTTjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729873402; c=relaxed/simple;
	bh=GGBPfMX4reQZHpoNp8d9EMUtd1yvjpdopqwsQevEdeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cb7cf++wcGPaECNQAw17TeN/IXvBc09N9mMsMF/bmy5YHucbKbOhEpNMxw8W09z/gWhcvRsxUTKWIh2gYaahGM3ElqlxhfC9t1Y+pWXmUv7HSk9FVThdXxwNX4S9uCuW9FlF56KyemZt6cH/afCcONk4zLn21hZg2ZumOAVNt+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORsXMbD2; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6cbd092f7f0so14397616d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729873399; x=1730478199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGilbTYvXREpjzQxbFNvjO/mqKDXNhtT6bX9C0+4cn0=;
        b=ORsXMbD2q61rUSA5PjZ1lK5l1B43XDF8bJzbUuXmzkadmnCOfOPsunNn9hpWNJrArq
         8n0hv9OlL6B6fAWj0XeniI0OUs2JYjRHERB9B7r/7D95hgl3Tv5eF938+VH61BDzqt7V
         W86YIUN3tsyNN/pPB1SDWuVtKgj8KladvGCafq1J11BZ2bH3hCrgkwPEpWQmsAuSjcGp
         CfvFfkC2/fyqQCd4sIofvNvtRjZ3dm3z++r93+l9iA6gEuFqUL+6ATDr6m3wnw3b8Tv4
         kBDEB2pO4Hu7HPt7ZBSbiSdRDrbxKUz5ByGmn18Pk6bMinmpSfSUkrXt04N1QGSmVW4b
         fGVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729873399; x=1730478199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pGilbTYvXREpjzQxbFNvjO/mqKDXNhtT6bX9C0+4cn0=;
        b=NgFlFIiYLcf4fpZJByblUo3rG+R+pZXhliefZlF/DGkb+1Pcj51IItN2okFWriJ/c7
         5TmoNQTecibq6YuhtBRSkmmPB6NbnQ0KL2rXT59C2p4uwQkh0hrGJH0cgDHSjX7p6FzX
         26jLYytpJZwBE3VNOYGz+FsMeogUn9pnTYhJxQUZQB6TYzMw2G6ZWgZ47eFb4NZazo4a
         +zDl9BoTo4j/bVceRcxjSDzzOoV9AR4JOdCcv8a2JuXKLuqJbD/U2qz4wA4sH6jcsa2M
         LfS6VZhlpTftktM5lsj3PB0E7TRyhGqpduk2n9WMP06inlLLJlwiVPephrW/qA6ArH9V
         D8nw==
X-Forwarded-Encrypted: i=1; AJvYcCXreh5QePq2HZcxXNHkdscQ/TeVKfKroVQNTgLdGf9l4GEwL3Nc7YLNJHdXunOK7N6NU8RVtmeitTtWWZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrWNMq5BUBrqNY2bkdwribkAJLMtzi/ZDqDfJgm4UHYrDc2HdL
	KZXmMykouck4+ylup8mzBFYl7iaT8qBW2Aw6Tzj77bhSV2PMtS/j
X-Google-Smtp-Source: AGHT+IFRB8pUdeFb5DFr+PJzHKDglrebOrRLJsNW2R5rK7mczEGl7y/Z5mmp6FZGjBMDl33gcMP0rA==
X-Received: by 2002:a05:6214:5705:b0:6cb:c994:160b with SMTP id 6a1803df08f44-6ce3417ed6dmr134650476d6.18.1729873399208;
        Fri, 25 Oct 2024 09:23:19 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d179a2e71asm6968886d6.129.2024.10.25.09.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 09:23:18 -0700 (PDT)
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7A0081200068;
	Fri, 25 Oct 2024 12:23:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Fri, 25 Oct 2024 12:23:18 -0400
X-ME-Sender: <xms:9sUbZ2O64jB72ACKgm3sYj0qCj2IopO8ktSWDt2rDGXHR0_VZI665w>
    <xme:9sUbZ09qOHmUJCc4VSG-W77rrAbarmHFciTXP7pC8QWO4_VLD3XMmpfr9hoJa5leH
    lHxm4X_dDOBEvKsZw>
X-ME-Received: <xmr:9sUbZ9SVvMaVb12dRYe59OgyLBrRH1oD8NMTeuJaCDl8hbOP98EGiemzgLk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejvddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilh
    drtghomheqnecuggftrfgrthhtvghrnhepieefleffuefhueffieelgfegueevteelvefg
    leekkefgueegffejveehhfevgfejnecuffhomhgrihhnpehophgvnhgrnhholhhishdrtg
    hnpdhkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhith
    ihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgr
    ihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepkedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepjhhirghpvghnghdrtghhohhngheslhhinhhugidr
    rghlihgsrggsrgdrtghomhdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrug
    drohhrghdprhgtphhtthhopehmihhnghhosehrvgguhhgrthdrtghomhdprhgtphhtthho
    peifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnhesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprggsrggtiheslhhinhhugidrrghlihgsrggsrg
    drtghomhdprhgtphhtthhopegsohhquhhnsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:9sUbZ2uvO0kjuFZYvlZMNEVqGu4ahNbXNbu-E7AM3iak8QrJgiTSTA>
    <xmx:9sUbZ-eW64pTR4n9PT0nm5wiJ2MHqUTd-E-67u8g1aEmeiZBLv2-JA>
    <xmx:9sUbZ61mvb88M1Tx2iTfB8bF5z0I8Eg4ugOY4Cadf5Gth_t98MTfhg>
    <xmx:9sUbZy-3_e1wnAl6COfR3DZ6k8CrTTnbe7TJsCxIYsJu-sFBqS_iGA>
    <xmx:9sUbZ98FoPHCrdpLr8OqVdzqGj_nh54zcIIsiNyLO49AVEOfrkvbPRDI>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Oct 2024 12:23:17 -0400 (EDT)
Date: Fri, 25 Oct 2024 09:23:16 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: peterz@infradead.org, mingo@redhat.com, will@kernel.org,
	longman@redhat.com, linux-kernel@vger.kernel.org,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next] locking/ww_mutex: use swap() in get_random_order()
Message-ID: <ZxvF9KrmzEVUrK-J@Boquns-Mac-mini.local>
References: <20241025081455.55089-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025081455.55089-1-jiapeng.chong@linux.alibaba.com>

On Fri, Oct 25, 2024 at 04:14:55PM +0800, Jiapeng Chong wrote:
> Use existing swap() function rather than duplicating its implementation.
> 
> ./kernel/locking/test-ww_mutex.c:420:22-23: WARNING opportunity for swap().
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11531
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Thanks for the patch. However, I think Thorsten Blum beat you to it [1].
Would it be Ok if I queue that patch with you as a Reported-by (plus
the other Reported-by tag and Close tag)?

[1]: https://lore.kernel.org/r/20240731135850.81018-2-thorsten.blum@toblux.com

Regards,
Boqun

> ---
>  kernel/locking/test-ww_mutex.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/test-ww_mutex.c
> index 5d58b2c0ef98..bcb1b9fea588 100644
> --- a/kernel/locking/test-ww_mutex.c
> +++ b/kernel/locking/test-ww_mutex.c
> @@ -404,7 +404,7 @@ static inline u32 prandom_u32_below(u32 ceil)
>  static int *get_random_order(int count)
>  {
>  	int *order;
> -	int n, r, tmp;
> +	int n, r;
>  
>  	order = kmalloc_array(count, sizeof(*order), GFP_KERNEL);
>  	if (!order)
> @@ -415,11 +415,8 @@ static int *get_random_order(int count)
>  
>  	for (n = count - 1; n > 1; n--) {
>  		r = prandom_u32_below(n + 1);
> -		if (r != n) {
> -			tmp = order[n];
> -			order[n] = order[r];
> -			order[r] = tmp;
> -		}
> +		if (r != n)
> +			swap(order[n], order[r]);
>  	}
>  
>  	return order;
> -- 
> 2.32.0.3.g01195cf9f
> 

