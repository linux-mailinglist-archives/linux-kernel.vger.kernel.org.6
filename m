Return-Path: <linux-kernel+bounces-375443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 016BB9A95FD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 04:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21B072835A7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 02:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E66612D75C;
	Tue, 22 Oct 2024 02:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rl3LyQ5b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731071E51D;
	Tue, 22 Oct 2024 02:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729562937; cv=none; b=kKDA4YScGyfM9sbc7b85T7jU0VAoqFxrtwa99LTzurc8xcMBzKQ3g2qb9u/3tDtVBAfkLXeADRu9eItH+gg+cgA0XKCi+PyJrlpJ3scTJGzhs/Sp/2GwqDAEFx3KTKPi7U6ssb6xihaFpyFcBQzWJGgcC6nOznUMLPsodWsevFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729562937; c=relaxed/simple;
	bh=LMXviNltoqXWdqO4iCQaz4PnXyhh7PoIjqWaqIsjCMg=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=suyct4MNErfWvEzpb/Mh/s+ZqkVXzUac8OdUf4HiFOzIbWHDXntrTcKsLccLID4c51cTrhxt0WgfCA89PVnb5wudSXUvHConCmv2YlGGws3+EdZw24X2CRMh/Lap7jbCFBvkDvAiftVKvDeZ1Rtovto6ExaYFRdp03iC81qEEEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rl3LyQ5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A7E7C4CEC3;
	Tue, 22 Oct 2024 02:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729562937;
	bh=LMXviNltoqXWdqO4iCQaz4PnXyhh7PoIjqWaqIsjCMg=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Rl3LyQ5bkrq4S0Nq1aPQyYD9TFNJCZNs/1Fvifz2NiTxQCPqJE5bQPdkhRPNnNHkz
	 D0e8UWAToalkq7N5iKsj8Nf/ffKxqKoXFQNqTriAqS0/L59s74SXVJfUBwn62r7yil
	 LclvE6TQ4DCIr2PYfj/QOryhzg53vJCYKwXUiET9vlN7bvc43mviWEU8pnHnroIVa7
	 ojrP/FmILf8fkkNhSB3PfCUDRmZp4ejPfwQ72f1z/bp6PNIlPXU1CAGI1jntXRF13J
	 m/XIVPRL00W+lhKtY6ifd+7eoXDBjABZBge8EG3sYlQ+RqwmHWgiUCU+piKwIdqaup
	 FzjNmLiFGTpMw==
Message-ID: <260b8dbd-a2e6-4600-b7bf-4fb1b510476b@kernel.org>
Date: Tue, 22 Oct 2024 10:08:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix to convert log type to segment data type
 correctly
To: kernel test robot <lkp@intel.com>, jaegeuk@kernel.org
References: <20241018092200.2792472-1-chao@kernel.org>
 <202410200521.Mc4H4BHm-lkp@intel.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <202410200521.Mc4H4BHm-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Thanks for the report, I rebased this patch on top of
https://lore.kernel.org/linux-f2fs-devel/20241017012932.1570038-1-chao@kernel.org,
so there will be dependency in between these two patch.

Thanks,

On 2024/10/20 5:57, kernel test robot wrote:
> Hi Chao,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on jaegeuk-f2fs/dev-test]
> [also build test ERROR on jaegeuk-f2fs/dev linus/master v6.12-rc3 next-20241018]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Chao-Yu/f2fs-fix-to-convert-log-type-to-segment-data-type-correctly/20241018-172401
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
> patch link:    https://lore.kernel.org/r/20241018092200.2792472-1-chao%40kernel.org
> patch subject: [PATCH] f2fs: fix to convert log type to segment data type correctly
> config: i386-buildonly-randconfig-002-20241019 (https://download.01.org/0day-ci/archive/20241020/202410200521.Mc4H4BHm-lkp@intel.com/config)
> compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241020/202410200521.Mc4H4BHm-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202410200521.Mc4H4BHm-lkp@intel.com/
> 
> All error/warnings (new ones prefixed by >>):
> 
>>> fs/f2fs/segment.c:3818:38: warning: declaration of 'enum log_type' will not be visible outside of this function [-Wvisibility]
>      3818 | static int log_type_to_seg_type(enum log_type type)
>           |                                      ^
>>> fs/f2fs/segment.c:3818:47: error: variable has incomplete type 'enum log_type'
>      3818 | static int log_type_to_seg_type(enum log_type type)
>           |                                               ^
>     fs/f2fs/segment.c:3818:38: note: forward declaration of 'enum log_type'
>      3818 | static int log_type_to_seg_type(enum log_type type)
>           |                                      ^
>     fs/f2fs/segment.c:3843:16: error: variable has incomplete type 'enum log_type'
>      3843 |         enum log_type type = __get_segment_type(fio);
>           |                       ^
>     fs/f2fs/segment.c:3843:7: note: forward declaration of 'enum log_type'
>      3843 |         enum log_type type = __get_segment_type(fio);
>           |              ^
>>> fs/f2fs/segment.c:4828:44: error: argument type 'enum log_type' is incomplete
>      4828 |                 array[i].seg_type = log_type_to_seg_type(i);
>           |                                                          ^
>     fs/f2fs/segment.c:3818:38: note: forward declaration of 'enum log_type'
>      3818 | static int log_type_to_seg_type(enum log_type type)
>           |                                      ^
>     1 warning and 3 errors generated.
> 
> 
> vim +3818 fs/f2fs/segment.c
> 
>    3817	
>> 3818	static int log_type_to_seg_type(enum log_type type)
>    3819	{
>    3820		int seg_type = CURSEG_COLD_DATA;
>    3821	
>    3822		switch (type) {
>    3823		case CURSEG_HOT_DATA:
>    3824		case CURSEG_WARM_DATA:
>    3825		case CURSEG_COLD_DATA:
>    3826		case CURSEG_HOT_NODE:
>    3827		case CURSEG_WARM_NODE:
>    3828		case CURSEG_COLD_NODE:
>    3829			seg_type = (int)type;
>    3830			break;
>    3831		case CURSEG_COLD_DATA_PINNED:
>    3832		case CURSEG_ALL_DATA_ATGC:
>    3833			seg_type = CURSEG_COLD_DATA;
>    3834			break;
>    3835		default:
>    3836			break;
>    3837		}
>    3838		return seg_type;
>    3839	}
>    3840	
> 


