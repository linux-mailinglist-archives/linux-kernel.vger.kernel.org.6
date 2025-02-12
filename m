Return-Path: <linux-kernel+bounces-511767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55937A32F64
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 20:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 433BF7A338A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 19:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B83D26139A;
	Wed, 12 Feb 2025 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZYEyaoSH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BF9261566
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 19:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739387699; cv=none; b=lLtf/55is0ZoeqQWCcAus9SFoEl9otTYI8p1OnLlRacgs11jbyEAEK1mhsiKgrjr0Cb0LTEooBVc6cqrUTrAzdvoJ7IFd2zGmxTjNRpozEy+nBrzYgvADJLMVZJX+KwTWoLBePOQaZpbQ50zG9HIfaph1vlIgyIdJwBweWKVKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739387699; c=relaxed/simple;
	bh=rRq6PbosGwCh+S4uQAG0FbAB+DGiceJ9qM8veMJVZGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EN83hg3ClCrkSJ1IwGVzoqxP010EXLNnj9C2peByR2WiJdOL2Zq3LjFddjG67BTn+Uovtwl/QkIqxZWRC6bHx/KYreQ/q48ouiYMiO7XkBAbwBLpl0eCBkJslProM0qgPddQegXA57yvH6bzFhsKvSdV5NiMd+kzC9kPExdGusM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZYEyaoSH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739387698; x=1770923698;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rRq6PbosGwCh+S4uQAG0FbAB+DGiceJ9qM8veMJVZGc=;
  b=ZYEyaoSH+9IYyGtqUJCYx4H54NDKJCgEXNXsWc9yYO9oAw7RA/2GlQcQ
   3Vtxmllrsj7n5Quxu4Q9OGEFLI1bKdXP1x/oN7J6Hs4A2q3Hms1okNalA
   Y4kGSblv98xTIVfmVUIN4X/PPsA9IdUbvluT3jDSXA+0oAQMxkOonyz+4
   QZO6dpPwsauJRhbCjlFnkt3XQhpPuBfAddbio1pahPiHcrnHNscOO/8yO
   RQ6TpSGi7Ugm2ogCaYy+DxUwD2FT7ENkRuRWQQnGuvVaeZ8luqW3e0Wqy
   gF2MP/Mdf74wJIupVti3C90GpUv+BnHNmbL0FOoqxjHJfIDBMCDMMYILY
   Q==;
X-CSE-ConnectionGUID: 3Cw7d8ZdReGYESQaZmEDBg==
X-CSE-MsgGUID: bG1lMX6CRHCKPLFJyU35sw==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="27659203"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="27659203"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 11:14:55 -0800
X-CSE-ConnectionGUID: 4nC2yIOASvmJ+iivEluKMQ==
X-CSE-MsgGUID: vXJ0XwToTgOXF7p3Isk9Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="112903857"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO [10.245.244.188]) ([10.245.244.188])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 11:14:53 -0800
Message-ID: <7b0d8055-a58f-4c4c-adb2-c298b5df4f04@linux.intel.com>
Date: Wed, 12 Feb 2025 20:14:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Include ASPEED ast-drm 1.15.1 video driver in kernel tree
To: Nicolas Baranger <nicolas.baranger@3xo.fr>,
 dri-devel@lists.freedesktop.org
Cc: Tzimmermann <tzimmermann@suse.de>, airlied@redhat.com,
 Jocelyn Falempe <jfalempe@redhat.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <d507f6268ea3158b5af82b6860ca7b71@3xo.fr>
 <194c4656963debcf074d87e89ab1a829@3xo.fr>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <194c4656963debcf074d87e89ab1a829@3xo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Nicolas,

Thank you for taking a look at this. It would be nice to have an updated 
driver. The best way to go forward is to chop the enhancements from the 
version that you tested into small patches that can be applied to the 
kernel tree.

This way you get all the benefits from the updated driver, in a way that 
it's suitable to maintain for us.

Kind regards,
Maarten Lankhorst

On 2025-02-12 19:58, Nicolas Baranger wrote:
> Dear maintener
> 
> I did include ast-drm driver version 1.15.1 (in replacement of version 
> 0.1.0) on the new mainline kernel too (6.14.0-rc2) and I issue a new 
> dkms patch
> 
> Last DKMS patch had been sucessfully tested on mainline.
> And last ast.ko version 1.15.1 included in linux tree had also been 
> sucessfully tested
> 
> Online directory is updated with :
> - new DKMS patch
> - new DKMS srouces
> - new DKMS debian package
> - new tarball of mainline included ast_new ported in kernel tree
> - new kernel debian package (mainline with ast_new)
> 
> 
> NB: online directory is here: https://xba.soartist.net/ast- 
> drm_nba_20250211/
> 
> Please let me know what I should do to see this change in linux-next
> 
> Thanks for help
> 
> Kind regards
> Nicolas Baranger
> 
> 
> Le 2025-02-11 19:15, Nicolas Baranger a écrit :
> 
>> Dear maintener
>>
>> For my own usage, I did make work the ASPEED ast-drm 1.15.1 video 
>> driver on mainline kernel (6.13.0 + 6.13.1).
>>
>> ASPEED video driver is availiable here:
>> https://www.aspeedtech.com/file/support/Linux_DRM_1.15.1_4.tar.gz
>>
>> But it only work for LTS kernel
>> So I modify the DKMS package and I build a new Debian DKMS package 
>> with the adapted  source.
>> My patch can be find here :
>> https://xba.soartist.net/ast-drm_nba_20250211/nba-dkms/astdiff.patch
>> See the README:
>> https://xba.soartist.net/ast-drm_nba_20250211/nba-dkms/README
>>
>> Using this new 'ast 1.15.1' driver, performance are amazing compared 
>> to the 'ast' driver include in kernel tree, specially when using a 
>> discrete GPU and offloading VULKAN / 3D on it but using AST VGA card 
>> as the main video card and as the main and only video output (the 
>> discrete GPU is used only for offloading 3D or for cuda/opencl)
>>
>> So to make things easier, I include the new 'ast 1.15.1' driver in 
>> kernel tree as AST_NEW : linux-6.13.1-ast/drivers/gpu/drm/ast_new'
>> It's working fine as you can see on this video :
>> https://xba.soartist.net/ast-drm_nba_20250211/ 
>> vulcan_nvidia_prime_render_offload_on_ast_vga_card.webm
>>
>> I upload all the work I've done here :
>> https://xba.soartist.net/ast-drm_nba_20250211/
>>
>> See the global README :
>> https://xba.soartist.net/ast-drm_nba_20250211/README
>>
>> and the README in nba-kernel sub-directory :
>> https://xba.soartist.net/ast-drm_nba_20250211/nba-kernel/README
>>
>> I'm not a developer so please let me know if I made the things the 
>> right way and if this new 'ast 1.15.1' driver can be ported to linux- 
>> next or linux-? ?
>> If you need more explanations, do not hesitate to contact me, I would 
>> be happy to help
>>
>> Kind regards
>> Nicolas Baranger


