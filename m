Return-Path: <linux-kernel+bounces-334773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F4497DC00
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 09:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAF9C1C21041
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Sep 2024 07:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29EE14F9F1;
	Sat, 21 Sep 2024 07:39:37 +0000 (UTC)
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D427355E73
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726904377; cv=none; b=p0Ho3eYzu/l50BxvsqmfFBkDlobjm2qXlXbX8BbW9R3HjC2m8UCHhuU9hM2BiZ4Ylt846bUA4mKXRZ4Ba9riRflupOpv86oohTs5J8faofIY8+jMYrfaD3odAOYiJhbBrw4a3pevtUkPHgAbDVgHCkDqXNQEj2M7HSLNTYNS0mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726904377; c=relaxed/simple;
	bh=b49Ez1YGgjNC6RNBk0dws5ZgC/pQM+VHwDGCzCPIQ7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndVqKeCWk4DUrHDtl/e/zYKVMqZv035dPObW2ZMm95CgNXxI5fRkoyKzKY9PnL0CRDMBo6+7fDzJyLKkfogKFXwOmEd02aq4LB95PGwlrJzOcUL4flGyHduUWUvMQjBP6rmC3EAGNM4x/NOJ+bcNB+IwztX5unM255cChiMwfIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4X9gcd5CLRz9v7Hl
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 15:19:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 91E23140485
	for <linux-kernel@vger.kernel.org>; Sat, 21 Sep 2024 15:39:17 +0800 (CST)
Received: from [10.45.144.173] (unknown [10.45.144.173])
	by APP1 (Coremail) with SMTP id LxC2BwDXaDAaeO5mG+FWAQ--.10859S2;
	Sat, 21 Sep 2024 08:39:17 +0100 (CET)
Message-ID: <c0b25884-b22a-46d6-949a-81fa9ce8f836@huaweicloud.com>
Date: Sat, 21 Sep 2024 09:39:05 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] tools/memory-model: Switch to softcoded herd7 tags
To: Akira Yokosawa <akiyks@gmail.com>, paulmck@kernel.org
Cc: stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
 peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
 dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
 dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
 quic_neeraju@quicinc.com, frederic@kernel.org, linux-kernel@vger.kernel.org,
 lkmm@lists.linux.dev, hernan.poncedeleon@huaweicloud.com
References: <20240919130634.298181-1-jonas.oberhauser@huaweicloud.com>
 <20240919130634.298181-5-jonas.oberhauser@huaweicloud.com>
 <8cb4e810-da6c-4d8f-b608-5bdba56da2bd@gmail.com>
From: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <8cb4e810-da6c-4d8f-b608-5bdba56da2bd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:LxC2BwDXaDAaeO5mG+FWAQ--.10859S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw47KFWxurWfWr47uF45Jrb_yoWfuFX_JF
	WkGFyvkr15Xw17Jw4UKryjyrWjyr17Ar1jvw4Utrs7Z3WxJryDJrn8Wrs8X34rXw1kCryk
	KF1rZw1xArWrJjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
	1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY
	04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7sRRKZX5UUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/

Thanks Akira for your continued eagle eyes!
Will include in next revision.

One question below.
  jonas



Am 9/21/2024 um 4:44 AM schrieb Akira Yokosawa:
> This litmus test is not compatible with klitmus7, which is much
> stricter than herd7's C parser.
> 
> You can have only int or int* variables in the exists clause.
> Register variables need their declarations at the top of each Pn()
> (classic C).
> 
> See below for klitmus7 ready code.
> 
> And tools/memory-model/litmus-tests/README need to mention this
> litmus test.
> 
>          Thanks, Akira
> 
> ---------------------------------------------
> P0(int *x, int *y, atomic_t *z)
> {
> 	int r0;
> 
> 	WRITE_ONCE(*x, 1);
> 	r0 = atomic_add_unless(z,1,5);
> 	WRITE_ONCE(*y, 1);
> }
> 
> P1(int *x, int *y)
> {
> 	int r0;
> 
> 	r0 = READ_ONCE(*y);
> 	if (r0 == 1)
> 		WRITE_ONCE(*x, 2);
> }
> 
> exists (1:r0=1 /\ x=1)
> ---------------------------------------------
> 

Should z also be changed from atomic_t to int?


