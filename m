Return-Path: <linux-kernel+bounces-413659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CC59D1D03
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 02:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DE3C28493D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 01:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0663D994;
	Tue, 19 Nov 2024 01:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2j0dJh2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A1D2A1B2
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 01:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731978689; cv=none; b=uuKFYcl9y9dCzPtBLii6uIZOyPWs3vaI+ieSVEK4G3RnF1DmH1pdmI22uPrLoAoZcdu58kSOGdf2AtTdEpRAfuiriVtJStQSv2EppNP0sSOEv72Yk8zw3RLR8OfBZeqEGtqm0hva3i0liOBelLzeYnrFb0aqLnJzJR/Qjwb90aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731978689; c=relaxed/simple;
	bh=Qy7Yhho+ZT7oh2iBlIBJXe979+aHEvsqN7Fey7lQZBE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=j4f4oO1Y63VrSi/XVWJVGUdh1VbMWhj+uBArqMDiFF6DZ8hv4HfEBGNTLb8eY0btltQrw2/pAjEY+ceFRWxQsRhPFK89GWa6bD+PwK5Xad+C2JE5DeBJLpJIEbNr2BseUuxVRKfHbqyj6kJWdhhlhIT1ZNF6ABcsyGlKdFwLd5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2j0dJh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DEC6C4CECC;
	Tue, 19 Nov 2024 01:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731978687;
	bh=Qy7Yhho+ZT7oh2iBlIBJXe979+aHEvsqN7Fey7lQZBE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=n2j0dJh2iqV/J6ok/rnsTpu359K8rK5fVyK6T2+UMo0f/noXHOsK62eh/xmoowhHF
	 QusnB7RLeQxlGtoMy0UpJJzvC93Q4pr5KySfRiZpS6qRLOiNn85tLCH3ZadrSu+e39
	 fN9raJ22Z4lNi2IyzoUU3cdvm0Nb2xYbiTIh91BdmQCGaSgRjwddZ3UOQNL10b5VX+
	 3QPVBFM8D9B2lTSiqT9cdzJXJFUWTbMawCmofQTm9JTSvl7/ZqZcD/Smu5vYGNxXtG
	 qgFprrKDuuasnyEKYhw7Udvpsz6mIqWKbcZPZXMo8uxd6j2d6KQHIUafkMxX+a7lMK
	 bbW4j6skplzyw==
Message-ID: <bdc3c8eb-2c26-4575-af7c-f54541beca5a@kernel.org>
Date: Tue, 19 Nov 2024 09:11:22 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Chao Yu <chao@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, Song Feng <songfeng@oppo.com>,
 Yongpeng Yang <yangyongpeng1@oppo.com>
Subject: Re: [PATCH v2 1/2] f2fs: fix changing cursegs if recovery fails on
 zoned device
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
References: <20241118120517.3533055-1-shengyong@oppo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20241118120517.3533055-1-shengyong@oppo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/11/18 20:05, Sheng Yong wrote:
> Fsync data recovery attempts to check and fix write pointer consistency
> of cursegs and all other zones. If the write pointers of cursegs are
> unaligned, cursegs are changed to new sections.
> 
> If recovery fails, zone write pointers are still checked and fixed,
> but the latest checkpoint cannot be written back. Additionally, retry-
> mount skips recovery and rolls back to reuse the old cursegs whose
> zones are already finished. This can lead to unaligned write later.
> 
> This patch addresses the issue by leaving writer pointers untouched if
> recovery fails. When retry-mount is performed, cursegs and other zones
> are checked and fixed after skipping recovery.
> 
> Signed-off-by: Song Feng <songfeng@oppo.com>
> Signed-off-by: Yongpeng Yang <yangyongpeng1@oppo.com>
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

