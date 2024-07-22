Return-Path: <linux-kernel+bounces-258389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B54938760
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 03:41:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8832D1C20C05
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 01:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32052C8CE;
	Mon, 22 Jul 2024 01:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIPKoccM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD148F6B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 01:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721612466; cv=none; b=ABhpeOcAKFFVDBPCmXHTLxJQLlQ+JljSySNCFmB9k3vgHsUknig6DBg8sENK5NJ/VJVfSwl3fhlaDO1Xe7mtshnWRYgVMb0AbG7D4MwagPhsj/1xsHiHZk/ast29pnuDKBSubo0KrkxNzsegKPfouZCPy1xAAzJhdBoziNKcO5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721612466; c=relaxed/simple;
	bh=QvZs/pCfri9h/XsR3H5ktdCz77vqOCseX8U2sVMOHCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UTvySwQkrXbocFneDh/x70t/p/vtrfDUFcuT1TZSiTkaVmaNSzCiVtArQjgl7CUtkD6t/L2AVx4++N2XlLhMS3isXYwo7KhIHbJ6Vb0SGXzH+DYjaWFpB5OmV9FtdeS31vm2C1xqxacaqNNxzjNAutdrXUay7iRc9dpfgqdZyhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIPKoccM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D314C116B1;
	Mon, 22 Jul 2024 01:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721612466;
	bh=QvZs/pCfri9h/XsR3H5ktdCz77vqOCseX8U2sVMOHCc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aIPKoccM7YpbNcWtcdVarIni4QyC7BhG6Y4+lmhqaxe4LXBXZfHG9Y3DDM2ltUqbk
	 eqxhOzCSlVpHqHWeWQj7bIVdheXnn9/cG9OXAa/TkNjUXwFn9CgyERk13J6++hK3aC
	 9p7Ll3eIg9z2fI00l1kaoK2UwDpnOpo4cnguRfL3pywjEsZIr0Jbz7IOYs/OW/Ef3R
	 lmrW1ZrtMpKf9i9S3oMRpS65TKxAleBHsacU51J1qlCfj/yZk7XatTRDYik45WMCeM
	 xovvzeRc5rIUlQTb/YLPfHcRSWz1fDNIOhYqZ992pYGedOgtb3Ycf4V8ZAf+82BMVt
	 a9v/ZAg13/rFw==
Message-ID: <62626888-0503-4f77-992b-12278a530eae@kernel.org>
Date: Mon, 22 Jul 2024 09:41:02 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] f2fs: fix to use per-inode maxbytes and cleanup
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com, Hao_hao.Wang@unisoc.com
References: <1721295366-21008-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1721295366-21008-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/7/18 17:36, Zhiguo Niu wrote:
> This is a supplement to commit 6d1451bf7f84 ("f2fs: fix to use per-inode maxbytes")
> for some missed cases, also cleanup redundant code in f2fs_llseek.
> 
> Cc: Chengguang Xu <cgxu519@mykernel.net>
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

