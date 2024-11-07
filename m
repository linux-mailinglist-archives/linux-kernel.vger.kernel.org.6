Return-Path: <linux-kernel+bounces-400170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C44C9C09D8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 16:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509F1286005
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 15:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AF41EE02A;
	Thu,  7 Nov 2024 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="fNtYKep2"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22AF2101A4
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992549; cv=none; b=Jj7K9qsyP6e3H7x17Hmza+mBdTjmwG9n7lJG0TN7Y6/+2Ib3n6V6Z2+0gOgh5RYEJaAh8yY/JqFFMxpF0u/WI9AoDy8wbb0H5HmTkE9ZFIehemUsaXS7Uj2ICzRVmJAxT/jxKMXSSSENVZnCkph16q2GEKNLNo4HW+OrvRaq4iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992549; c=relaxed/simple;
	bh=f53VMlD9u95v+55/gffunntgJ3OC/A8Q9e72woQmo3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=diZW5iCaDfa0CZU1IhV/a5iC8A11K+8nF+U96oOGwbL5e9DnUllRQF1LGF8Q1skuusBML4zd6o9C9M9UdSTZjh8l2q8KdWwDvdw7Als8hwXd62OiVA4gVWvqgJdraf5qmg2QJAKz2FVgFMKK4dU0L88K9dTYdlV3BhUiYnFrGXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=fNtYKep2; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4A7FD8Q2003576
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 10:13:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1730992391; bh=NpRVto2oJv1r9qgeFToO/9vEnPP/tQoaldlTKis7JNI=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=fNtYKep2oIzKI0QbVF5GbmbCv8UL4jeeHYSSFO1mOyOGVfkmjoq3uOtPkJsXaUCPK
	 yTGBQAZ3MEplk9TcRBzGxrnoaoWlR+8Uo9fMirOckuJd+TNOtIzYDl9M/Xro52Ty00
	 WoxGJxZRHkLCe4TxQApGDDWTTtPuQ9APjLwcP23PqY6T9AF5of1c4d4obrWKgrN6oh
	 VvthQb6lSQL+FISiQPO067/RIVByvDXQWCBqTh1ARDE6Nsg0wN23v09GbQU6+6yg2z
	 n6YY3pC13TTm44cx5UvAuzy7gXOPITP6iYNhOpMSJGhs95OmasyXJLwFjFBepK70G5
	 h45Odjo5gi8NQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 4F03315C1C63; Thu, 07 Nov 2024 10:13:06 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, adilger.kernel@dilger.ca, jack@suse.cz,
        ritesh.list@gmail.com, yi.zhang@huawei.com, chengzhihao1@huawei.com,
        yukuai3@huawei.com
Subject: Re: [PATCH -next] ext4: don't pass full mapping flags to ext4_es_insert_extent()
Date: Thu,  7 Nov 2024 10:13:01 -0500
Message-ID: <173099237653.321265.15423417228670209283.b4-ty@mit.edu>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906061401.2980330-1-yi.zhang@huaweicloud.com>
References: <20240906061401.2980330-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Fri, 06 Sep 2024 14:14:01 +0800, Zhang Yi wrote:
> When converting a delalloc extent in ext4_es_insert_extent(), since we
> only want to pass the info of whether the quota has already been claimed
> if the allocation is a direct allocation from ext4_map_create_blocks(),
> there is no need to pass full mapping flags, so changes to just pass
> whether the EXT4_GET_BLOCKS_DELALLOC_RESERVE bit is set.
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: don't pass full mapping flags to ext4_es_insert_extent()
      commit: a274f8059aa45b2af52e8b92424d53f6139a3c4e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

