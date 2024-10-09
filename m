Return-Path: <linux-kernel+bounces-356185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 280D7995DB2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 04:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7F01F25BA7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B262126BED;
	Wed,  9 Oct 2024 02:23:16 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9477603A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 02:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728440595; cv=none; b=V3ABhzGQTJ4gpUKZak/udPr5St2ffsMaNgSdkIWvuorRA9+7RieeKg/rbSFrXP2BGC9z/clpOWVpVrTfxYJZMMHaoQk9fj5+zIMWo67GB6SezqpTCjTdAtLpHlbk0QMqm+MaE0sGXbfIIm/GmOSHvU4m/zJwT/eCBRwtdnAwySo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728440595; c=relaxed/simple;
	bh=uosJ9Xg1KQ/Q7IPgKqFK6pDa9QD+ieL8y/y9lQ1DXBU=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=XUEQZU4tnVnhBxOyWOCRccctifOEhTfEDNd8g2sUHG57FsZmDGKOzISsdup4rZHeX6MzhqM0jfJsUS5+Tpt6Bnn1akOimgC3RcGI8dkc272uMgYCM66j1cCydXUKqZYguuSnoWm5HfjB7AsWg0/EoQGm+DYjV5k6sinQHHQDCng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XNc810qy0z1T8P4;
	Wed,  9 Oct 2024 10:21:21 +0800 (CST)
Received: from kwepemk500005.china.huawei.com (unknown [7.202.194.90])
	by mail.maildlp.com (Postfix) with ESMTPS id F074F140133;
	Wed,  9 Oct 2024 10:23:03 +0800 (CST)
Received: from [10.174.178.46] (10.174.178.46) by
 kwepemk500005.china.huawei.com (7.202.194.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Oct 2024 10:23:03 +0800
Subject: Re: [PATCH 1/1] ubifs: Try to recover from missing znode
To: Benedikt Spranger <b.spranger@linutronix.de>,
	<linux-kernel@vger.kernel.org>
CC: <linux-mtd@lists.infradead.org>, Richard Weinberger <richard@nod.at>
References: <20241008133342.1937674-1-b.spranger@linutronix.de>
From: Zhihao Cheng <chengzhihao1@huawei.com>
Message-ID: <0840be30-63bc-449d-a9a4-c4e6b54c8885@huawei.com>
Date: Wed, 9 Oct 2024 10:23:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241008133342.1937674-1-b.spranger@linutronix.de>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk500005.china.huawei.com (7.202.194.90)

ÔÚ 2024/10/8 21:33, Benedikt Spranger Ð´µÀ:
> After powercut on a system using ubifs mounting failed:
> 
> 2024-09-30T12:38:26.880487+02:00 sonja kernel: UBIFS error (ubi0:0 pid 2178): ubifs_read_node [ubifs]: bad node type (255 but expected 9)
> 2024-09-30T12:38:26.880506+02:00 sonja kernel: UBIFS error (ubi0:0 pid 2178): ubifs_read_node [ubifs]: bad node at LEB 103:46920, LEB mapping status 0
> 2024-09-30T12:38:26.880509+02:00 sonja kernel: Not a node, first 24 bytes:
> 2024-09-30T12:38:26.880510+02:00 sonja kernel: 00000000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff                          ........................
> 
> While traversing over zbranches during the journal replay one zbranch
> points to a znode, which was not written to the flash and therefore the
> flash is empty.

UBIFS guarantees two things for znodes:
1) all index nodes(in commit seq N) are written on flash before master 
nodes(for commit seq N) are written.
2) all index nodes(in commit seq N) won't be erased from flash before 
master nodes(for commit seq N+1) are written.
So, I don't understand that why znodes not exist during journal replaying?
> 
> Try to recover from that by inserting an empty znode instead of failing.
> 
> Signed-off-by: Benedikt Spranger <b.spranger@linutronix.de>
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
> ---
>   fs/ubifs/io.c       | 16 ++++++++++++++++
>   fs/ubifs/tnc_misc.c |  6 +++++-
>   2 files changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ubifs/io.c b/fs/ubifs/io.c
> index 01d8eb170382..0bbb426f9006 100644
> --- a/fs/ubifs/io.c
> +++ b/fs/ubifs/io.c
> @@ -1110,6 +1110,22 @@ int ubifs_read_node(const struct ubifs_info *c, void *buf, int type, int len,
>   		return err;
>   
>   	if (type != ch->node_type) {
> +		/*
> +		 * While recovering, we may face lost data i.e. empty flash.
> +		 * Give callsites a hint by returning -ENODATA.
> +		 */
> +		if (c->replaying) {
> +			u8 *b = buf;
> +
> +			for (l = 0; l < len; l++) {
> +				if (b[l] != 0xff)
> +					break;
> +			}
> +			if (l == len) {
> +				ubifs_errc(c, "no node, but empty flash");
> +				return -ENODATA;
> +			}
> +		}
>   		ubifs_errc(c, "bad node type (%d but expected %d)",
>   			   ch->node_type, type);
>   		goto out;
> diff --git a/fs/ubifs/tnc_misc.c b/fs/ubifs/tnc_misc.c
> index d3f8a6aa1f49..4d085fc1300f 100644
> --- a/fs/ubifs/tnc_misc.c
> +++ b/fs/ubifs/tnc_misc.c
> @@ -300,7 +300,11 @@ static int read_znode(struct ubifs_info *c, struct ubifs_zbranch *zzbr,
>   	err = ubifs_read_node(c, idx, UBIFS_IDX_NODE, len, lnum, offs);
>   	if (err < 0) {
>   		kfree(idx);
> -		return err;
> +		/*
> +		 * While recovering we may face a non written znode.
> +		 * Inject an empty znode in this case.
> +		 */
> +		return (err == -ENODATA) ? 0 : err;
>   	}
>   
>   	err = ubifs_node_check_hash(c, idx, zzbr->hash);
> 


