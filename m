Return-Path: <linux-kernel+bounces-294637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A22D959090
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D38D1C20D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F8F1C7B96;
	Tue, 20 Aug 2024 22:39:48 +0000 (UTC)
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B12F15C13C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 22:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724193588; cv=none; b=amav084EJzcgvjq2cYmipg7S5MNolf4wPg1q8Zm2zhc8vp3lVUm2W6RaMj/TgVT8ztmuAvqL9ZxQKFX7bNH/DZU2pW4dsgSi3jS/qGWhZmZ+8Qyw5/nH+CPT8nn4KU+xgoZdrj1R9EqO0D/2uHkRk3+qujsv7bNhdABqqjtSNoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724193588; c=relaxed/simple;
	bh=PeWtKwrI+EPIszXK4gRV9wKWCQh+v9RnVEpv4rd4pwo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pjKKlaowIjX002x7ihGNOxar0IDJPBh592gJfm3XTXhBeT1U2xC8UpuC1Bzr4AnRGoMWhWwJ+pVwzV1LovgoV2f6pSbTFG9pLfi0MtATy0bIAyGfNBHNKq5Qgibb8eu2i+1r07k+WwDgPR+bp3ddS27hg0xw6oy6fXsIRQuyuUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.189])
	by sina.com (10.185.250.24) with ESMTP
	id 66C51AFE00005C77; Tue, 21 Aug 2024 06:38:57 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 23513810748479
X-SMAIL-UIID: A5E29B964BFE4EC482B6F72378661E3A-20240821-063857-1
From: Hillf Danton <hdanton@sina.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@Oracle.com>,
	syzbot+036af2f0c7338a33b0cd@syzkaller.appspotmail.com
Subject: Re: [PATCH] maple_tree: Remove rcu_read_lock() from mt_validate()
Date: Wed, 21 Aug 2024 06:38:45 +0800
Message-Id: <20240820175417.2782532-1-Liam.Howlett@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 20 Aug 2024 13:54:17 -0400 "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> 
> The write lock should be held when validating the tree to avoid updates
> racing with checks.  Holding the rcu read lock during a large tree
> validation may also cause a prolonged rcu read window.
> 
From the rcu stall's view, holding spin lock plays the same role of rcu
read lock, so what are you fixing by simply dropping rcu read lock?

> Link: https://lore.kernel.org/all/0000000000001d12d4062005aea1@google.com/
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Reported-by: syzbot+036af2f0c7338a33b0cd@syzkaller.appspotmail.com
> ---
>  lib/maple_tree.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 755ba8b18e14..fe1b01b29201 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -7588,14 +7588,14 @@ static void mt_validate_nulls(struct maple_tree *mt)
>   * 2. The gap is correctly set in the parents
>   */
>  void mt_validate(struct maple_tree *mt)
> +	__must_hold(mas->tree->ma_lock)
>  {
>  	unsigned char end;
>  
	lockdep_assert_held(ma_lock); instead

>  	MA_STATE(mas, mt, 0, 0);
> -	rcu_read_lock();
>  	mas_start(&mas);
>  	if (!mas_is_active(&mas))
> -		goto done;
> +		return;
>  
>  	while (!mte_is_leaf(mas.node))
>  		mas_descend(&mas);
> @@ -7616,9 +7616,6 @@ void mt_validate(struct maple_tree *mt)
>  		mas_dfs_postorder(&mas, ULONG_MAX);
>  	}
>  	mt_validate_nulls(mt);
> -done:
> -	rcu_read_unlock();
> -
>  }
>  EXPORT_SYMBOL_GPL(mt_validate);
>  
> -- 
> 2.43.0

