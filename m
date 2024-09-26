Return-Path: <linux-kernel+bounces-341055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87CC987ACE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 23:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67FC2858A0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 21:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5E218893A;
	Thu, 26 Sep 2024 21:46:34 +0000 (UTC)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C1A183CA8
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727387194; cv=none; b=szYNeOUmjY3u4eQ2JMyzGfKXx+X2iK+oKT/+SsFGkwm42+NoM44yeU1a3GB28eAZpLBf901hRwTj15uUJo92oSIgAYsW8BTSiaDxnJqkug6Xz39FOUOk2Yg9a2fpnrjs6FLfeZwHOTSYP27QV6y6MUabTp4jyRvOxWvVl8t/wiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727387194; c=relaxed/simple;
	bh=E966zOVGM0snUqG9UPSQxI6Gs86xHm49tpD/Qy0qKsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jsgiC+fJJu61rjKTZukbPAxxZFJPez2tfuBjpWwXiz7kLalKXw3qg5zpSMOMRjRGfEeJwn32uCi4BOq55qE3xUn6i5mkg6cu2DxY4R3Qnes5TmOZQddOu9ENZx7AYE0kicAC1yjT/b3HpK5pQ2fMbLtfT94GZ+2ENqof70i+hbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a0c9ff90b1so5660645ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 14:46:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727387190; x=1727991990;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=upRWdmCxdcckjFmQlbmjdQ/KhqZ3NpGBkL+5+yEDx/8=;
        b=QmAb8E6jnMM8YlbS2aMKKktQNmf84rHp2ubSWxaMijPYEcw1CQv3/KFQd66DYFBh00
         A3QygYBI/wTmHjpIf2tEV/FQHIVxMdOXrFnAuXafRClfsdXRvzHLkd+y459iIJ20sgzZ
         wivMRga/A0zgkJ12+ZNHRbHdlwdI38VJ8ytSMFH0+BhfYF5n4dU8lvRg71qMoYL29eCt
         u/qFtX/RTvaLLi7avmk30JKR/CT/jEam3knvQI/8b1IvufvkWyzU9mINRamcg13IzRyG
         tLbEvgfj7QFAqITXVhMTDrWiBbDSmfk8GK7PDvLjLkUP+XXrrk5DkmCTGZGuKZU4XhI1
         XiMg==
X-Forwarded-Encrypted: i=1; AJvYcCU632tbErVDW1aut9gldCEtFeDlGH+PzzPNvJg/O8ocrr7qEtBnlg0vnn/xGycqK/XVqumt8B1hYAQ9B4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCQkVuaJ+uXisr+DO0OaiOtMBGbciru7vBFB/QJyAdcyhpX8/B
	+1Tsl1m3utRkXm2TrzrHxxzlPS51TVS0ELPWLNCpVVQdbaYqifkJPQXtEAwH
X-Google-Smtp-Source: AGHT+IFZQ/3KjKRA3EqQdFG6SsmXqGGlDHh4FJzJ1IoF3569oMTaIGpykEW1Mnpo4/3uDhS0mrx2bA==
X-Received: by 2002:a05:6e02:b4d:b0:39f:5e18:239d with SMTP id e9e14a558f8ab-3a34517aa22mr8686555ab.15.1727387190466;
        Thu, 26 Sep 2024 14:46:30 -0700 (PDT)
Received: from maniforge (c-76-141-129-107.hsd1.il.comcast.net. [76.141.129.107])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a344de1fa6sm1524675ab.64.2024.09.26.14.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 14:46:29 -0700 (PDT)
Date: Thu, 26 Sep 2024 16:46:27 -0500
From: David Vernet <void@manifault.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, linux-kernel@vger.kernel.org, sched-ext@meta.com
Subject: Re: [PATCH 3/5] sched_ext: Relocate find_user_dsq()
Message-ID: <20240926214627.GE26346@maniforge>
References: <20240925000622.1972325-1-tj@kernel.org>
 <20240925000622.1972325-4-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f4OJyBJY2qmPrUwK"
Content-Disposition: inline
In-Reply-To: <20240925000622.1972325-4-tj@kernel.org>
User-Agent: Mutt/2.2.13 (00d56288) (2024-03-09)


--f4OJyBJY2qmPrUwK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 24, 2024 at 02:06:05PM -1000, Tejun Heo wrote:
> To prepare for the addition of find_global_dsq(). No functional changes.
>=20
> Signed-off-by: tejun heo <tj@kernel.org>

Acked-by: David Vernet <void@manifault.com>

> ---
>  kernel/sched/ext.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
> index ed2b914c42d1..acb4db7827a4 100644
> --- a/kernel/sched/ext.c
> +++ b/kernel/sched/ext.c
> @@ -1029,6 +1029,11 @@ static bool u32_before(u32 a, u32 b)
>  	return (s32)(a - b) < 0;
>  }
> =20
> +static struct scx_dispatch_q *find_user_dsq(u64 dsq_id)
> +{
> +	return rhashtable_lookup_fast(&dsq_hash, &dsq_id, dsq_hash_params);
> +}
> +
>  /*
>   * scx_kf_mask enforcement. Some kfuncs can only be called from specific=
 SCX
>   * ops. When invoking SCX ops, SCX_CALL_OP[_RET]() should be used to ind=
icate
> @@ -1803,11 +1808,6 @@ static void dispatch_dequeue(struct rq *rq, struct=
 task_struct *p)
>  		raw_spin_unlock(&dsq->lock);
>  }
> =20
> -static struct scx_dispatch_q *find_user_dsq(u64 dsq_id)
> -{
> -	return rhashtable_lookup_fast(&dsq_hash, &dsq_id, dsq_hash_params);
> -}
> -
>  static struct scx_dispatch_q *find_dsq_for_dispatch(struct rq *rq, u64 d=
sq_id,
>  						    struct task_struct *p)
>  {
> --=20
> 2.46.0
>=20

--f4OJyBJY2qmPrUwK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZvXWMwAKCRBZ5LhpZcTz
ZDJSAPwKSl76uiMI795l+q0WEDcN2glSyRCQDpKrPXLg7snO3QD/YfZIhHWSjdG7
0vW2/g+2JH26tqGBBfh8pE9CO0RSnw0=
=Sv2/
-----END PGP SIGNATURE-----

--f4OJyBJY2qmPrUwK--

