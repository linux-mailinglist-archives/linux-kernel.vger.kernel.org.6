Return-Path: <linux-kernel+bounces-275101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6715694809D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 19:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5BBE1F23AB4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 17:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF03415FA7C;
	Mon,  5 Aug 2024 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8YGOo2X"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B7515F330
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722879754; cv=none; b=HEoodax0iK+8rC0xR6Pk87MU+l2B4dbxA6NyHhKNarHrfQamFOBv8/5wRJ0a//RkI/pYyk0/RAuJ6eILjKUGJ1sOE7D9EYpLBZDVXZnNtKYQ+6Zx684GsyquTgGTWdWrhOh9YXQLr7ATnPRQpwM5NIREXecDS+NvcgCdFFd/tfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722879754; c=relaxed/simple;
	bh=TP2sz3n2hL7aRQLlMfeye1F2PXSaYt8rAk4SD0LCxNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EtSGGABuaFDV1tDW91vZ7+gBE9pTRbNt0al66EBw3s8KYl4ucIyDo57Zrh+qQ+c4OFbYd40oJZD+Q8TG/EGhZZczxkvsQZh300Q/liXMC02a5AxJvL9X6r16wYTahtytuGukJBy1uquWvwseAN7C/oZ/6A3yltamcvmnT4HQkP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8YGOo2X; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b7b23793c1so63834036d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 10:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722879751; x=1723484551; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mATvMNUOky9Y4cvuczn+HMyJ4XpzZrnp9ceIhMRVC5I=;
        b=G8YGOo2XPBqLk7IKUxckpXORyzNllwXisBc0qbb3NITjM/mODF4D/O2Mjz0eY6OJdV
         /7msRqYGg+ng2W4YDLKO5v5niECprossuepg66lQCae3CgX3jJ5tCuF2TYtigfrV1yD8
         piOGwikn0zcUEooP8MucQm79TwAzDezK4pnUJrAAb/8Q1CNfhVOyOGD6m4OJ8DH9KZ7p
         qiC2lCROnxYGeC3rHRVTEGgHHUaSdVkUXub3yInuWgLuVOl4L9NGzHlzHQv+BvL/JgeW
         6qII11GehRjggPL7SCMYZevRS7EDqIrfpgSozEbQ2y+8zC4uNMuIvf1NmBPvK9ikc3IO
         30Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722879751; x=1723484551;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mATvMNUOky9Y4cvuczn+HMyJ4XpzZrnp9ceIhMRVC5I=;
        b=EKQvSztIRPxGTrJ/ydWaXUDqPqatmQBkR1hEUCVJ3WGxLMHQmUZCKVKVHI7eNAY1+g
         PA3FHafVLCgrHdBJRHLIW6xcKc6jVsW6RcP1g1z+EyzA4iJtbwUZHvzQQHQnFHT0dQER
         oELSqom+sG8qhuZIrMMEIZMAICBASrh2Ji8JjtaTPs109q7mM9nxe7jG8v2hWso7LAB6
         HY8hLMa/XFEw5wuHrEEoN4q/Zw07Hb5xvZvxxZoc+ck/rzRWcKgRcJZBitMAFktQioRL
         BsRvw4K7SbfjnrLV05Gb+EIuLh/6lhkx+qlgp34ksHLYpFN9DCmw5w2n7fWXtdwV4HNk
         pN2g==
X-Forwarded-Encrypted: i=1; AJvYcCUC9asVR5EVrhZI/jJJaREnvAY52Nhkg6ErWSWXel4SZc+vJNIY4DONAmmbOTCAQe/QtyUQqeah/rjiWxpmPMjhpPwQpXb1h0kMIOQf
X-Gm-Message-State: AOJu0YzKiqDArpxMrXxcTVnaEtJYB2Ct5C+awNe/L51mnJePYOPQkKR1
	feL5og7sByqx1yucIJA17VX3w2BBS9UJbwq8VSm6382NR3/lvQGk
X-Google-Smtp-Source: AGHT+IGxGFxbCi0eHbOwwVp6CRe3Hxm/aR3j+7vNp8bwkWJIKAvzlNfdNfr5lTFWpmMKUksMSyBCAA==
X-Received: by 2002:a05:6214:5889:b0:6b4:ff83:c02f with SMTP id 6a1803df08f44-6bb9845be52mr153499616d6.53.1722879751302;
        Mon, 05 Aug 2024 10:42:31 -0700 (PDT)
Received: from fauth1-smtp.messagingengine.com (fauth1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb9c79c147sm37537366d6.51.2024.08.05.10.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 10:42:30 -0700 (PDT)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 9E3371200043;
	Mon,  5 Aug 2024 13:42:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 05 Aug 2024 13:42:30 -0400
X-ME-Sender: <xms:Bg-xZlOG8KBFuZUOpldkeKa-OIx5g-HiNqfEBWbXaxB2kZ2zzYfOGg>
    <xme:Bg-xZn_fkbX7D4lYHc3bZRTOMlyurD6DQEIqiY_FWb4IKMtv0gY5H6su_WsDyvrqt
    Jdh0pdw6iqjeR-DGA>
X-ME-Received: <xmr:Bg-xZkSbXIBx2v5SCx0lhKYnun2xnzJlAO8-AEaMXROhCq5qyoGftQBwrU_kl4y3aVflNgMYcOaKn0hlqyadUgpS3SJOp5Yh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepgffhudetvdejueetieeijeejtdduhfdvffdvjeehffdtheevtdeuhfeu
    heehiefgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghp
    thhtoheptd
X-ME-Proxy: <xmx:Bg-xZhuggDojonVQDPU2yuuGtSuKcCPsqDMZyNwHvb8xmYz6Nq62SA>
    <xmx:Bg-xZtcxxLcQmaV_IY5YGOw_NXKQCuDn7gg8kAAiv0C6NzOTih00Wg>
    <xmx:Bg-xZt3-amgRBr_933DbNNA_g02E6X9XAKcavc8b-OYNC6XWay0GOg>
    <xmx:Bg-xZp-j4qKDbf51KeGHRPWpTqZPGfWaRvh6c2HJOhR1cd5AEwXiVw>
    <xmx:Bg-xZo9Rxbo0tWAJUvwzeE8A5D7Ugj-oRKxEyHddNjzRqXhMnjz9Wq_l>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 13:42:30 -0400 (EDT)
Date: Mon, 5 Aug 2024 10:43:08 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] lockdep: suggest the fix for "lockdep bfs error:-1"
 on print_bfs_bug
Message-ID: <ZrEPLFDGSSS3Dh80@tardis>
References: <Zqkmy0lS-9Sw0M9j@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <Zqkmy0lS-9Sw0M9j@uudg.org>

On Tue, Jul 30, 2024 at 02:45:47PM -0300, Luis Claudio R. Goncalves wrote:
> When lockdep fails while performing the Breadth-first-search operation
> due to lack of memory, hint that increasing the value of the config
> switch LOCKDEP_CIRCULAR_QUEUE_BITS should fix the warning.
>=20
> Preface the scary backtrace with the suggestion:
>=20
>     [  163.849242] Increase LOCKDEP_CIRCULAR_QUEUE_BITS to avoid this war=
ning:
>     [  163.849248] ------------[ cut here ]------------
>     [  163.849250] lockdep bfs error:-1
>     [  163.849263] WARNING: CPU: 24 PID: 2454 at kernel/locking/lockdep.c=
:2091 print_bfs_bug+0x27/0x40
>     ...
>=20
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Waiman Long <longman@redhat.com>
> Signed-off-by: Luis Claudio R. Goncalves <lgoncalv@redhat.com>

Queued at:

	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/
	lockdep-for-tip

Thanks!

Regards,
Boqun

> ---
>=20
> Changes in v2:
>   - removed extra space from the if condition.
>=20
>  kernel/locking/lockdep.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 58c88220a478a..1cf6d9fdddc9c 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2067,6 +2067,9 @@ static noinline void print_bfs_bug(int ret)
>  	/*
>  	 * Breadth-first-search failed, graph got corrupted?
>  	 */
> +	if (ret =3D=3D BFS_EQUEUEFULL)
> +		pr_warn("Increase LOCKDEP_CIRCULAR_QUEUE_BITS to avoid this warning:\n=
");
> +
>  	WARN(1, "lockdep bfs error:%d\n", ret);
>  }
> =20
> --=20
> 2.45.2
>=20

