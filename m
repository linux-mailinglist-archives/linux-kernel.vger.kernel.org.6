Return-Path: <linux-kernel+bounces-315099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AC696BDEB
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2DEC28254E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 13:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFDA31DA30E;
	Wed,  4 Sep 2024 13:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cDeHgAH6"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AE11DA10D
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725455185; cv=none; b=SovfGJst1SVIwgt3j1yCcDUfHvqts3fRWjMk2XJxxMqZ5uzPYsyvb5vstThTLszHHbT4Ga9U8QUhG2IVZ/Ao0a02ejUfzQKXwpwDJZgjCD/cEtppZy2zYWvOclxF1R+H74//xKJDbtqE7cNEPyl94CUjx1H/vwZv151n504qbhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725455185; c=relaxed/simple;
	bh=bocrfzcAH59xhLMf/5/46drIM/Q0VMNA+1sVBYNB7lo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+I1mn0CqoyuV8dSzb9p47xucShhWdNTr3jdQVRSJE6SszhT4JzGoOIQ7i5G1GqN6KfcpuEBB5pc+I4Tbjbz66pd3OwCBukftYjqkjDgQejSgk/eRSCnc8RQ05nFrOgSv7txcd5kbGFO2nsi5MpmCxJdtqaeOCbcctgnGg1wk7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cDeHgAH6; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ea328b17-ba60-c7c3-3bab-52df1dd60fef@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725455180;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rgYD/ETXr/pJUs1peci6b7joO2Kw9YvzeNs0MfSj3OQ=;
	b=cDeHgAH655aDNPYPpIzP8Ab6O+Y2dfiWXAIuc+jZDD/lkpzeM7VJoTv4vfzveqLre12NU4
	AVRPUtMSS7SksYT1V+pIqnec05wUoTo/RpxJkuekEpEVwBOKylbwyY8qbM4JM8YaashiLF
	L5TgDb1PzWXjfYFm0DfXBrQx4KQrskE=
Date: Wed, 4 Sep 2024 21:06:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] nfsd: return -EINVAL when namelen is 0
To: Li Lingfeng <lilingfeng3@huawei.com>, chuck.lever@oracle.com,
 jlayton@kernel.org, neilb@suse.de, okorniev@redhat.com, Dai.Ngo@oracle.com,
 tom@talpey.com
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 yukuai1@huaweicloud.com, houtao1@huawei.com, yi.zhang@huawei.com,
 yangerkun@huawei.com, lilingfeng@huaweicloud.com
References: <20240903111446.659884-1-lilingfeng3@huawei.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <20240903111446.659884-1-lilingfeng3@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 9/3/24 19:14, Li Lingfeng wrote:
> When we have a corrupted main.sqlite in /var/lib/nfs/nfsdcld/, it may
> result in namelen being 0, which will cause memdup_user() to return
> ZERO_SIZE_PTR.
> When we access the name.data that has been assigned the value of
> ZERO_SIZE_PTR in nfs4_client_to_reclaim(), null pointer dereference is
> triggered.
>
> [ T1205] ==================================================================
> [ T1205] BUG: KASAN: null-ptr-deref in nfs4_client_to_reclaim+0xe9/0x260
> [ T1205] Read of size 1 at addr 0000000000000010 by task nfsdcld/1205
> [ T1205]
> [ T1205] CPU: 11 PID: 1205 Comm: nfsdcld Not tainted 5.10.0-00003-g2c1423731b8d #406
> [ T1205] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ?-20190727_073836-buildvm-ppc64le-16.ppc.fedoraproject.org-3.fc31 04/01/2014
> [ T1205] Call Trace:
> [ T1205]  dump_stack+0x9a/0xd0
> [ T1205]  ? nfs4_client_to_reclaim+0xe9/0x260
> [ T1205]  __kasan_report.cold+0x34/0x84
> [ T1205]  ? nfs4_client_to_reclaim+0xe9/0x260
> [ T1205]  kasan_report+0x3a/0x50
> [ T1205]  nfs4_client_to_reclaim+0xe9/0x260
> [ T1205]  ? nfsd4_release_lockowner+0x410/0x410
> [ T1205]  cld_pipe_downcall+0x5ca/0x760
> [ T1205]  ? nfsd4_cld_tracking_exit+0x1d0/0x1d0
> [ T1205]  ? down_write_killable_nested+0x170/0x170
> [ T1205]  ? avc_policy_seqno+0x28/0x40
> [ T1205]  ? selinux_file_permission+0x1b4/0x1e0
> [ T1205]  rpc_pipe_write+0x84/0xb0
> [ T1205]  vfs_write+0x143/0x520
> [ T1205]  ksys_write+0xc9/0x170
> [ T1205]  ? __ia32_sys_read+0x50/0x50
> [ T1205]  ? ktime_get_coarse_real_ts64+0xfe/0x110
> [ T1205]  ? ktime_get_coarse_real_ts64+0xa2/0x110
> [ T1205]  do_syscall_64+0x33/0x40
> [ T1205]  entry_SYSCALL_64_after_hwframe+0x67/0xd1
> [ T1205] RIP: 0033:0x7fdbdb761bc7
> [ T1205] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 514
> [ T1205] RSP: 002b:00007fff8c4b7248 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> [ T1205] RAX: ffffffffffffffda RBX: 000000000000042b RCX: 00007fdbdb761bc7
> [ T1205] RDX: 000000000000042b RSI: 00007fff8c4b75f0 RDI: 0000000000000008
> [ T1205] RBP: 00007fdbdb761bb0 R08: 0000000000000000 R09: 0000000000000001
> [ T1205] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000000042b
> [ T1205] R13: 0000000000000008 R14: 00007fff8c4b75f0 R15: 0000000000000000
> [ T1205] ==================================================================
>
> Fix it by checking namelen.
>
> Signed-off-by: Li Lingfeng <lilingfeng3@huawei.com>
> ---
>   fs/nfsd/nfs4recover.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 67d8673a9391..69a3a84e159e 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -809,6 +809,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
>   			ci = &cmsg->cm_u.cm_clntinfo;
>   			if (get_user(namelen, &ci->cc_name.cn_len))
>   				return -EFAULT;

If namelen is 0, I think the func should return -EFAULT above per below 
comment in [1]. Or can
get_user return success with x was set to zero?

  * Return: zero on success, or -EFAULT on error.
  * On error, the variable @x is set to zero.
  */
#define get_user(x,ptr) ({ might_fault(); 
do_get_user_call(get_user,x,ptr); })

[1]. 
https://elixir.bootlin.com/linux/v6.11-rc6/source/arch/x86/include/asm/uaccess.h#L108

> +			if (!namelen) {
> +				dprintk("%s: namelen should not be zero", __func__);
> +				return -EINVAL;
> +			}
>   			name.data = memdup_user(&ci->cc_name.cn_id, namelen);
>   			if (IS_ERR(name.data))
>   				return PTR_ERR(name.data);
> @@ -831,6 +835,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
>   			cnm = &cmsg->cm_u.cm_name;
>   			if (get_user(namelen, &cnm->cn_len))
>   				return -EFAULT;
> +			if (!namelen) {
> +				dprintk("%s: namelen should not be zero", __func__);
> +				return -EINVAL;
> +			}
>   			name.data = memdup_user(&cnm->cn_id, namelen);
>   			if (IS_ERR(name.data))
>   				return PTR_ERR(name.data);

Thanks,
Guoqing

