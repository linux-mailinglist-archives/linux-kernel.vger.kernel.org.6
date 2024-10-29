Return-Path: <linux-kernel+bounces-386157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 160C79B3FCF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 02:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41ACE1C21C06
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 01:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7AC57BB0A;
	Tue, 29 Oct 2024 01:33:17 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024FED51C;
	Tue, 29 Oct 2024 01:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730165597; cv=none; b=gPwO64OQuw3uP+ehGohD3ZJF+8CCiTguikfimeF5lvjWUSZttotJlmFOWRq9+gAsYO9APyxISaR85eIf7o4jgFUCheNNu4RyAk+ap/5z8xPT9u5Oi8C6IcVcz03cf+v/aO+MZP2uiTRJIdjX+l+cqb+WC+CXa8ufhhWfeCwrAj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730165597; c=relaxed/simple;
	bh=NtthpP5qalHVs/To3+cd+Sq5y5rdtu6Thv5JRcLQ9R4=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=sD0baETP2bVs+BB4W+B/D4O+VwTq7YqacMo0/B1FoZx767Kfi+Bs8vw6fRIujtrEMgpCvvOaYVBqeQOdWS3yY6kw/arUP9OuZT6JC++0RX6pYBwLUVgngnNiJKdRBqNeo54Ie19i1KV7SqjmSYGX4cfq2DiAurCTRHNdkC7O9sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Xct6l1s2kz4f3jXh;
	Tue, 29 Oct 2024 09:32:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E05861A07B6;
	Tue, 29 Oct 2024 09:33:04 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgAnieVOOyBn2oPvAA--.338S2;
	Tue, 29 Oct 2024 09:33:04 +0800 (CST)
Subject: Re: [PATCH v2 bpf 2/2] selftests/bpf: Add test for
 trie_get_next_key()
To: Byeonguk Jeong <jungbu2855@gmail.com>,
 =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Yonghong Song <yonghong.song@linux.dev>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <Zxx4ep78tsbeWPVM@localhost.localdomain>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <b91763b5-9c02-525d-db8a-ff0da5cbdb69@huaweicloud.com>
Date: Tue, 29 Oct 2024 09:33:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Zxx4ep78tsbeWPVM@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgAnieVOOyBn2oPvAA--.338S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYs7kC6x804xWl14x267AKxVW8JVW5JwAF
	c2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vI
	Y487MxAIw28IcxkI7VAKI48JMxAqzxv26xkF7I0En4kS14v26r126r1DMxC20s026xCaFV
	Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
	x4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
	1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/



On 10/26/2024 1:04 PM, Byeonguk Jeong wrote:
> Add a test for out-of-bounds write in trie_get_next_key() when a full
> path from root to leaf exists and bpf_map_get_next_key() is called
> with the leaf node. It may crashes the kernel on failure, so please
> run in a VM.
>
> Signed-off-by: Byeonguk Jeong <jungbu2855@gmail.com>
> ---
> v1 -> v2:
>   - Fixed a build error.
>   - Removed unnecessary comments about crash-on-failure warning.
>   - Fix a variable to be initialized before using it.
> ---

Acked-by: Hou Tao <houtao1@huawei.com>


