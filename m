Return-Path: <linux-kernel+bounces-223269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 728B791107C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:14:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280FB1F216E2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651FE1BE236;
	Thu, 20 Jun 2024 18:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="TrMdy504"
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41ED1B4C4B
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 18:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906543; cv=none; b=XEt18+gNUEkzOQadJmoFcH2bC/6sDcg+tDrgLlmEm6HzT0CiNKPz0CQqvWAz8Qg+By1DhhXRc7JyszPADouB73cD48Aav9d9J81+rpGEMwJ1Tv0az//q5+fCuuKa/AeSKvfUV4VEMK7ZHUABejIhnrBpv7Br5505ZGQY8atmsJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906543; c=relaxed/simple;
	bh=9OYNE5YcPJoW+cycciShcyXeb0c1OGto8YDuhiLt/9E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YlyxhTvNsjFRIh1R//iUZbdvWdu3a3aYJrY3tbtSySS5DKKjiGOzekvqni00vCRsBpP5K74H+ca/Wfju4uAxEYXTWMrVcpHkyPiGBBWBmWqD/GqlV18MmPn1iRGbBlhWTxsGlNEYqJmIs+8d6GsIcFYZwrwQ/5Cg1CWrSDj794E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=TrMdy504; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id KJYBsClkWrtmgKM73sp20K; Thu, 20 Jun 2024 18:02:21 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id KM72sncfLd4oeKM72sUtcE; Thu, 20 Jun 2024 18:02:21 +0000
X-Authority-Analysis: v=2.4 cv=aYKqngot c=1 sm=1 tr=0 ts=66746ead
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=wYkD_t78qR0A:10
 a=u8_TST9jJ4tMlxaXhdEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HfKKts8lHZEV18StgAl0ALsIpFvYHBbDUnFqCEnAdRs=; b=TrMdy504Ugni0jbv4PFKWfje9V
	ClDtpMDCuWWJYypILr/vUVFwgQ/jrR+7jbKpafdafiTG9H7OM1a3m9tzMpVVr214sbB+bt1ntOyb1
	xiMj3rY77gU+N4r5nY8MjIkcEOCmA4HQk/vClwkCo4znDagw7v4zOnJwLuJCkRCBUwnHUyBPUiw7v
	MaFluSrchhPqDq47wjsWQlasAIZs6+wmbHsUfpbCs3sjwHV2/CTnA97IusGBwIO6dBYknoLP1IsOL
	nzSwiGdSiDZga4EWSU9yQtcOSSHGVr0P+QjUk9E09rkG0Tnk1bL+745mR2hnq1JJtS0DMJ1PGairJ
	t/UW1t/g==;
Received: from [201.172.173.139] (port=42268 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sKM70-003e3c-2m;
	Thu, 20 Jun 2024 13:02:18 -0500
Message-ID: <c8404725-e4c4-453b-b72d-19ab0761da70@embeddedor.com>
Date: Thu, 20 Jun 2024 12:02:13 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: iwlwifi: mvm: Fix __counted_by usage in
 cfg80211_wowlan_nd_*
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Kees Cook <kees@kernel.org>
Cc: benjamin.berg@intel.com, dmantipov@yandex.ru, gregory.greenman@intel.com,
 gustavoars@kernel.org, haim.dreyfuss@intel.com, johannes.berg@intel.com,
 kvalo@kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 luciano.coelho@intel.com, miriam.rachel.korenblit@intel.com,
 shaul.triebitz@intel.com, yedidya.ben.shimol@intel.com
References: <20240619211233.work.355-kees@kernel.org>
 <d9bdb9c1-689e-4b3f-8325-8ee813257d8f@wanadoo.fr>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <d9bdb9c1-689e-4b3f-8325-8ee813257d8f@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.139
X-Source-L: No
X-Exim-ID: 1sKM70-003e3c-2m
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.139]:42268
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPI7T/Md3V5QRvWZE4xLM4GbNApyPHXwyw7CZzg9yg2VqHPsjGyPskey+0tASJXOXuf2hBU+KYEy/5+InsU9S/hYmGlNkTC3brm1ZrzsCGjDGiwj6ZOg
 0m/C5oiptISHTXiePfIeyLfEYXFf6tgeZv3vAQxGgj+hC3dmdah/rQrsrMNzscxRI7JJ8q51VUU2a3X7iyZ3xsHudGpTrR8PDwCE2HyvgAS9RF72S68j3P0i


> My understanding is that 'match', is allocated by :
>      match = kzalloc(struct_size(match, channels, n_channels), GFP_KERNEL);
> 
> So match->n_channels is *0* when iwl_mvm_query_set_freqs() is called.

n_channels is updated in the line before calling kzalloc():

n_channels = iwl_mvm_query_num_match_chans(mvm, d3_data->nd_results, i);

match = kzalloc(struct_size(match, channels, n_channels), GFP_KERNEL);

--
Gustavo

