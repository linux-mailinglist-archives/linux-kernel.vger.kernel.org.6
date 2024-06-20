Return-Path: <linux-kernel+bounces-223275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339369110BB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 20:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93164B28B17
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 18:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA041BF321;
	Thu, 20 Jun 2024 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="IlHTP6Bg"
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764D01BA096
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 18:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906895; cv=none; b=j9IsHmRNClZprzmYSaLj3gURHdEYOlX/gOEBPNgtAh8dc60XUCx8yK8x4ggwN/W1AWO6Of2S2Uh1dacSwkodoOP7knLLaoYuE0HukW8kLSVjkX07y+YH2ZpNLtLtNHAZ7q/8baD0emTdhFqvwJZZQDltTjcAWOMoBAEU/AYo5QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906895; c=relaxed/simple;
	bh=uB1apWJQ3OE6U+/LLsGbLd9fjmCXiikIAJ6C3moSk4U=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LOa8Z30DT2BC/qaIt43ituDPpJ/biSviVMd9IL3OMhNHty0Ytqmxix7yBlJsKzFmWzaxTs08P2HVv2+Zs+NcSZbIMyzY7fT6BgLeshT4CxqYZj9SYncfDdQ+VFRdtVlnrtjnHLl8cmvoAZxCugMzFA9J98h9r1kjNRYxGKuwlD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=IlHTP6Bg; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5005a.ext.cloudfilter.net ([10.0.29.234])
	by cmsmtp with ESMTPS
	id KHdAsOKcDkQe8KMCesaY4B; Thu, 20 Jun 2024 18:08:08 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id KMCdsIOUFYakKKMCds4Hpb; Thu, 20 Jun 2024 18:08:07 +0000
X-Authority-Analysis: v=2.4 cv=a4T79lSF c=1 sm=1 tr=0 ts=66747007
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=wYkD_t78qR0A:10
 a=x_dihBSuy5WN06TBF6EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lZUL9jcxKTQlsQHFQ46DQVLaL8P8p8lX4a8jvUbOugI=; b=IlHTP6BgrVTNg3fJkdhOKtM0lu
	ftNDr7BNhZTWwf6y0RiYCFSImLlGDLImDF1tCSTskiTXZX07zXm4ybjfSDKCIBqg8D5kH/+tVh3df
	LxESga1cqCnOZb6wX0v+LVownAcUnuCzasRxK2oJWSg6xpC+r06qF8OS4Vwyz2ovPn1sVtzyyA9ji
	70BaS3w10yS1fqzKJHbG3Gn3m2Hm1bKCaS9Z7O1sYyCd8TeM0HdB2m/JwMCDTiPdjQfsCdzCIsXNo
	kgGrhVA63jlydWKcicUz/HwG+S5OhprZiuw6cTvfdaw9ckZCfNemJny2GJ1IurN7FD7F+Wg9eb4LY
	Al897pvA==;
Received: from [201.172.173.139] (port=42488 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sKMCb-003kD1-2n;
	Thu, 20 Jun 2024 13:08:05 -0500
Message-ID: <47a71c03-0306-4239-b77c-cb63a1760d19@embeddedor.com>
Date: Thu, 20 Jun 2024 12:08:04 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: iwlwifi: mvm: Fix __counted_by usage in
 cfg80211_wowlan_nd_*
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
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
 <c8404725-e4c4-453b-b72d-19ab0761da70@embeddedor.com>
Content-Language: en-US
In-Reply-To: <c8404725-e4c4-453b-b72d-19ab0761da70@embeddedor.com>
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
X-Exim-ID: 1sKMCb-003kD1-2n
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.139]:42488
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 22
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPCAlDc9flDeCMM7SY3cgWiHU0v+ilDLaibALfyivOq9qFiKozqkAjNf4B5/oVnpG2ESfIC+0djpIJFEl0yyxQ5A+wy3oNRPhkZvz8pfUDs7ufAYx5Hl
 oZVXAcDhaGAy43QhTOfR616jrknIhANEM+KFJbp9LobNr9fku/MQmNNf6s4CnxbzXtnkXPBgMyWpMVx4UhVsN9kauiBVThA50fumcPKls39J4PXk8JC3bckV



On 6/20/24 12:02, Gustavo A. R. Silva wrote:
> 
>> My understanding is that 'match', is allocated by :
>>      match = kzalloc(struct_size(match, channels, n_channels), GFP_KERNEL);
>>
>> So match->n_channels is *0* when iwl_mvm_query_set_freqs() is called.
> 
> n_channels is updated in the line before calling kzalloc():
> 
> n_channels = iwl_mvm_query_num_match_chans(mvm, d3_data->nd_results, i);
> 
> match = kzalloc(struct_size(match, channels, n_channels), GFP_KERNEL);

then match->n_channels updated here:

  		if (!match)
  			goto out_report_nd;
+		match->n_channels = n_channels;

Sorry about the split response, finger failure ugghh

--
Gustavo

