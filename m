Return-Path: <linux-kernel+bounces-263001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B631893CFB1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 10:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA9901C22125
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C3D176ACD;
	Fri, 26 Jul 2024 08:36:53 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD3F36D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721983012; cv=none; b=JkbAvirXwg0Jr/dEs3JM9MC0Yh0QlAzpKri7zorth7eohIEz5Z2O9aFS/idJSZJ/rWbgxePJL0PFtOSvYDeBnQ54/3kpn5M6x7PoEGQ+mRLBcyYY3QmZbARhznezKmyQ9rUWEFybd7TA2TcOQ9c8FiYMZb+VbH4gUS5E60UoQq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721983012; c=relaxed/simple;
	bh=fpGmmeeUw0McZWoiyJPZD2A/3yq+gebnXRWMvHPGuPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Vujsz1NdZ6F4nB0gr0yfT+W/HI09V7uDNMy/so6to1YwnkQoXjLRjk5mHZJ1bAh5oRm/4uECBS15W0UzZ7LVTxENYQ18phr0arKUvOLpiNQ1dFHnJVcejY/A07LshBcrffKr2MEI/oRcGhD8Y/y2ez7qahq7GXa1tXVTiSSnv4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WVgwq26bwzPsyF;
	Fri, 26 Jul 2024 16:32:27 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 9F90E140971;
	Fri, 26 Jul 2024 16:36:40 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 26 Jul 2024 16:36:40 +0800
Message-ID: <96170678-b302-4990-b229-b30d96e39806@huawei.com>
Date: Fri, 26 Jul 2024 16:36:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: UML/hostfs - mount failure at tip of tree
To: Christian Brauner <brauner@kernel.org>
CC: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, Matthew Wilcox
	<willy@infradead.org>, Kernel hackers <linux-kernel@vger.kernel.org>, Patrick
 Rohr <prohr@google.com>, Linus Torvalds <torvalds@linux-foundation.org>
References: <CANP3RGceNzwdb7w=vPf5=7BCid5HVQDmz1K5kC9JG42+HVAh_g@mail.gmail.com>
 <CAHk-=wijWMpPk7feEZ8DzdLi7WLp_BhRpm+qgs6Tew1Bb2CmyQ@mail.gmail.com>
 <b84a6ef8-7c3b-4c04-81d3-859692d91137@huawei.com>
 <CAHk-=wjH5uKPB6xrWoB8WkBMuLEJO2UsidKE1wV8XSXjAUFO8Q@mail.gmail.com>
 <CANP3RGdgnXOXjnAFe6irf2JwrPsStTLvihKkowpY2ggSgNw7KA@mail.gmail.com>
 <CANP3RGd7AQXPYQVrhjbgEN608Jo7hDUh7nc8VQ62gGQqW0iXMg@mail.gmail.com>
 <4a8ae74e-2f90-4da8-9511-325ca6f67aa6@huawei.com>
 <20240726-wurmt-mitfiebern-d8e3f85d6992@brauner>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240726-wurmt-mitfiebern-d8e3f85d6992@brauner>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/7/26 15:52, Christian Brauner wrote:
> On Wed, Jul 24, 2024 at 05:49:16PM GMT, Hongbo Li wrote:
>>
>>
>> On 2024/7/24 11:59, Maciej Żenczykowski wrote:
>>> On Tue, Jul 23, 2024 at 7:55 PM Maciej Żenczykowski <maze@google.com> wrote:
>>>>
>>>> On Tue, Jul 23, 2024 at 7:22 PM Linus Torvalds
>>>> <torvalds@linux-foundation.org> wrote:
>>>>>
>>>>> On Tue, 23 Jul 2024 at 18:35, Hongbo Li <lihongbo22@huawei.com> wrote:
>>>>>>
>>>>>> I apologize for causing this issue. I am currently tracking it down.  If
>>>>>> reverting this can solve the problem, you can revert it first.
>>>>>
>>>>> I don't get the feeling that this is _so_ urgent that it needs to be
>>>>> reverted immediately - let's give it at least a few days and see if
>>>>> you (or somebody else) figures out the bug.
>>>>>
>>>>> Maciej - if you can verify that folio conversion fix suggestion of
>>>>> mine (or alternatively report that it doesn't help and I was barking
>>>>> up the wrong tree), that would be great.
>>>>
>>>> That appears to fix the folio patch indeed (ie. I no longer need to revert it).
>>>>
>>>> The tests are still super unhappy, but I've yet to fix our tests very
>>>> broken netlink parser for changes that released in 6.10, so that may
>>>> be unrelated ;-)
>>>
>>> +++ fs/hostfs/hostfs_kern.c:
>>>    static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
>>>    {
>>>           struct hostfs_fs_info *fsi = sb->s_fs_info;
>>> -       const char *host_root = fc->source;
>>> +       const char *host_root = "/";
>>>
>> This doesn't work in case where the host directory is designated (such as
>> mount -t hostfs hostfs -o /home /host).
>>
>> I can fix this by the following patch, the root cause of this issue is the
>> incorrect parsing of the host directory. The original mount path will use
>> `parse_monolithic` to parse the host directory. For the new mount api, it
>> use `parse_param` directly. So we should call `fsconfig(fd,
>> FSCONFIG_SET_STRING, "hostfs", "xxx", 0)` to mount the hostfs(I think may be
>> we should add hostfs as the key for host directory.). This may need
>> Christian's reviews.:
>>
>> ```
>>  From e7cc3be86a01b8382e9510f6ae1a2764942c7cba Mon Sep 17 00:00:00 2001
>> From: Hongbo Li <lihongbo22@huawei.com>
>> Date: Wed, 24 Jul 2024 16:08:32 +0800
>> Subject: [PATCH] hostfs: fix the host directory parse when mounting.
>>
>> hostfs not keep the host directory when mounting. When the host
>> directory is none (default), fc->source is used as the host root
>> directory, and this is wrong. Here we use `parse_monolithic` to
>> handle the old mount path for parsing the root directory. For new
>> mount path, The `parse_param` is used for the host directory parse.
>>
>> Fixes: cd140ce9f611 ("hostfs: convert hostfs to use the new mount API")
>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>> ---
>>   fs/hostfs/hostfs_kern.c | 64 ++++++++++++++++++++++++++++++++++-------
>>   1 file changed, 54 insertions(+), 10 deletions(-)
>>
>> diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
>> index 3eb747d26924..205c3700a035 100644
>> --- a/fs/hostfs/hostfs_kern.c
>> +++ b/fs/hostfs/hostfs_kern.c
>> @@ -17,6 +17,7 @@
>>   #include <linux/writeback.h>
>>   #include <linux/mount.h>
>>   #include <linux/fs_context.h>
>> +#include <linux/fs_parser.h>
>>   #include <linux/namei.h>
>>   #include "hostfs.h"
>>   #include <init.h>
>> @@ -927,7 +928,6 @@ static const struct inode_operations hostfs_link_iops =
>> {
>>   static int hostfs_fill_super(struct super_block *sb, struct fs_context *fc)
>>   {
>>   	struct hostfs_fs_info *fsi = sb->s_fs_info;
>> -	const char *host_root = fc->source;
>>   	struct inode *root_inode;
>>   	int err;
>>
>> @@ -941,15 +941,6 @@ static int hostfs_fill_super(struct super_block *sb,
>> struct fs_context *fc)
>>   	if (err)
>>   		return err;
>>
>> -	/* NULL is printed as '(null)' by printf(): avoid that. */
>> -	if (fc->source == NULL)
>> -		host_root = "";
>> -
>> -	fsi->host_root_path =
>> -		kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
>> -	if (fsi->host_root_path == NULL)
>> -		return -ENOMEM;
>> -
>>   	root_inode = hostfs_iget(sb, fsi->host_root_path);
>>   	if (IS_ERR(root_inode))
>>   		return PTR_ERR(root_inode);
>> @@ -975,6 +966,57 @@ static int hostfs_fill_super(struct super_block *sb,
>> struct fs_context *fc)
>>   	return 0;
>>   }
>>
>> +enum hostfs_parma {
>> +	Opt_hostfs,
>> +};
>> +
>> +static const struct fs_parameter_spec hostfs_param_specs[] = {
>> +	fsparam_string_empty("hostfs",		Opt_hostfs),
>> +	{}
>> +};
>> +
>> +static int hostfs_parse_param(struct fs_context *fc, struct fs_parameter
>> *param)
>> +{
>> +	struct hostfs_fs_info *fsi = fc->s_fs_info;
>> +	struct fs_parse_result result;
>> +	char *host_root;
>> +	int opt;
>> +
>> +	opt = fs_parse(fc, hostfs_param_specs, param, &result);
>> +	if (opt < 0)
>> +		return opt;
>> +
>> +	switch (opt) {
>> +	case Opt_hostfs:
>> +		host_root = param->string;
>> +		if (!host_root)
>> +			host_root = "";
> 
> That should be:
> 
> host_root = param->string;
> if (!*host_root)
> 	host_root = "";
> 
> as param->string is never NULL but can be an empty string. I'll fix that
> up though.
> 
Thanks for reviewing!
Yeah, param->string is checked at the begin of fsconfig syscall, here is 
just for double check (may be redundant). The empty string is allowed 
for host_root(also ""), or just remove this?

Thanks,
Hongbo

> Otherwise overall looks sane to me.
> 
> I'm a bit puzzled that hostfs allowed to specify an option without a key like:
> 
> mount("hostfs", "/mnt", "/home");
> 
> but ok. So in the new mount api you did:
> 
> fsconfig(fd, FSCONFIG_SET_STRING, "hostfs", "/home", 0);
> 
> which I think is a lot saner.
> 
>> +		fsi->host_root_path =
>> +			kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
>> +		if (fsi->host_root_path == NULL)
>> +			return -ENOMEM;
>> +		break;
>> +	}
>> +
>> +	return 0;
>> +}
>> +static int hostfs_parse_monolithic(struct fs_context *fc, void *data)
>> +{
>> +	struct hostfs_fs_info *fsi = fc->s_fs_info;
>> +	char *host_root = (char *)data;
>> +
>> +	/* NULL is printed as '(null)' by printf(): avoid that. */
>> +	if (host_root == NULL)
>> +		host_root = "";
>> +
>> +	fsi->host_root_path =
>> +		kasprintf(GFP_KERNEL, "%s/%s", root_ino, host_root);
>> +	if (fsi->host_root_path == NULL)
>> +		return -ENOMEM;
>> +
>> +	return 0;
>> +}
>> +
>>   static int hostfs_fc_get_tree(struct fs_context *fc)
>>   {
>>   	return get_tree_nodev(fc, hostfs_fill_super);
>> @@ -992,6 +1034,8 @@ static void hostfs_fc_free(struct fs_context *fc)
>>   }
>>
>>   static const struct fs_context_operations hostfs_context_ops = {
>> +	.parse_monolithic = hostfs_parse_monolithic,
>> +	.parse_param	= hostfs_parse_param,
>>   	.get_tree	= hostfs_fc_get_tree,
>>   	.free		= hostfs_fc_free,
>>   };
>> -- 
>> 2.34.1
>> ```
>>
>> Thanks,
>> Hongbo
>>
>>> appears to fix the problem (when combined with Linus' folio fix).
>>>
>>> I think fc->source is just the 'block device' passed to mount, and
>>> thus for a virtual filesystem like hostfs, it is just garbage...
>>>
>>> (and with the appropriate netlink fixes all the tests now pass at tip-of-tree:
>>> 87f3073c2871 (HEAD) hostfs_fill_super(): host_root := "/" (not fc->source)
>>> 2743a4aabac6 fs/hostfs/hostfs_kern.c:445 buffer =
>>> folio_zero_tail(folio, bytes_read, buffer + bytes_read);
>>> a2caf678d7e1 neighbour: add RTNL_FLAG_DUMP_SPLIT_NLM_DONE to RTM_GETNEIGH
>>> 3bb0c5772acf net: add RTNL_FLAG_DUMP_SPLIT_NLM_DONE to RTM_GET(RULE|ROUTE)
>>> 786c8248dbd3 (linux/master) Merge tag
>>> 'perf-tools-fixes-for-v6.11-2024-07-23' of
>>> git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools
>>> )
>>>
>>>>> And perhaps remind me about this mount API thing too if it doesn't
>>>>> seem to be resolved by the end of the week when I'm starting to get
>>>>> ready to do the rc1?
>>>>>
>>>>>                Linus
>>>>
>>>> --
>>>> Maciej Żenczykowski, Kernel Networking Developer @ Google
>>>
>>> --
>>> Maciej Żenczykowski, Kernel Networking Developer @ Google
>>>

