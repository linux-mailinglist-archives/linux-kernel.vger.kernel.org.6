Return-Path: <linux-kernel+bounces-199913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B11FA8FA7B8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 03:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6241C22B3E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 01:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E4B5FB94;
	Tue,  4 Jun 2024 01:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQxzwiTe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126E24A04
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 01:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717465582; cv=none; b=m8o9KUaHp8SXG7XsYSVd214L07z5ga7/7QPmmSvh2wuATDppLrNnh0flz0D2shComFpX67UBeEt3dFinby3bH/hkS0G3oVhBdDqsCr9G3GpssZP0VMuDUKtgMtnQsuvSFb0qMkWU+yrQ3eQNC3PKFkJoSUfVQUMehU9OdAAWO3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717465582; c=relaxed/simple;
	bh=Kr64VTbx4fuENMluaNdpiqWjuGc1bcsbOj4ozALLLP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZnJYbf6ouT516PV76Tz8/xkQRyLNR3CGXvKndyhs4jFjDB5Htp4glHw2lPWzSryJFadRrRdIc5ioHWVkc0GKc0PsGCrwWctj4xFiPKuY1ibvA+5MIrS3XnAJhyT+BM2cQ8xZDJSgTMLL//BlB+zlyBacbHYFE0EtUM+WcOZYDvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQxzwiTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3132EC2BD10;
	Tue,  4 Jun 2024 01:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717465581;
	bh=Kr64VTbx4fuENMluaNdpiqWjuGc1bcsbOj4ozALLLP4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uQxzwiTezo5rYVqKnfPuWeCcOZuf9H0P1W2Xp3HZSz91IlE1rt84UMYJLNF8/UMsx
	 8Iz9/glKOiQnQAIBt0B9D4tHaf5KW7l/XGQVFCiCPzpCDnuPIY37MFbzANxeSVYssA
	 KMifXL71STfa8xDqx352PDxrSokCMSMvP1UVsvPoTXidJ7OEu9kK6w8OwylUbzUdV0
	 3cj4HgJrKaw9LeouXb/SCBP/4YZ4DQAb45salKr6f5w6mCKbC6DFsjhplmuHX02dQT
	 WWi/CmBvofzL8zmLn1fyddH61vv3nKILax85Y0rm49yFyB1b9QN/jnclkY4rDVfbBR
	 8okvWEfgqSOhw==
Message-ID: <04c4b93a-fcd7-4f42-a7cc-1cc3ed4019e1@kernel.org>
Date: Tue, 4 Jun 2024 09:46:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] f2fs: use new ioprio Macro to get ckpt thread ioprio
 level
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 niuzhiguo84@gmail.com, ke.wang@unisoc.com
References: <1717414526-19658-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <1717414526-19658-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/6/3 19:35, Zhiguo Niu wrote:
> IOPRIO_PRIO_DATA in the new kernel version includes level and hint,
> So Macro IOPRIO_PRIO_LEVEL is more accurate to get ckpt thread
> ioprio data/level, and it is also consisten with the way setting
> ckpt thread ioprio by IOPRIO_PRIO_VALUE(class, data/level).
> 
> Besides, change variable name from "data" to "level" for more readable.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

