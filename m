Return-Path: <linux-kernel+bounces-223360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 491A19111BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 21:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03AE8284C61
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F371B5838;
	Thu, 20 Jun 2024 19:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="jvmowCZX"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED7F156255
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 19:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910188; cv=none; b=fBL3IormRDh4rgj3aXa6svWz+927Pv/1mahpmKSrXfcWiQ596eUUgz8Tp10QCOaIX4ULhi34aV49nFjKgsWQitZvGRev7XLO+7M4UpejqtBG8fF1hNM6IimnvYr5aUUCLbqu/CPNWIxraJueSjQReiDeFQ7pPT+tSZ7YNPChdsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910188; c=relaxed/simple;
	bh=+Jj2iyrjvgazskQSxghCtRl5yuPRiI5t6yni7Yjz8Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o6XqSv1kra7II2IdlkMWwFnd+Lu8yObPZHTKpbOQyCJtFurxqMu84XIIvBEzxU+jlrJe9rapDqP8tQhb0CzcA5gug7mR6iZxREyJzh+8GQIeobfTPQCc7HCqqY9IzRd37ozOmvA3uX0/GG4Rbkb7oh+73/nQwK8JXtCc/AHLfRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=jvmowCZX; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id KHgisxT7VSqshKN3ksK4T4; Thu, 20 Jun 2024 19:03:00 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id KN3jsoLhId4oeKN3jsVbzw; Thu, 20 Jun 2024 19:03:00 +0000
X-Authority-Analysis: v=2.4 cv=aYKqngot c=1 sm=1 tr=0 ts=66747ce4
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=frY+GlAHrI6frpeK1MvySw==:17
 a=IkcTkHD0fZMA:10 a=T1WGqf2p2xoA:10 a=wYkD_t78qR0A:10
 a=YnLhUqmXxxwrq80so2UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=W5Sd7FdHakQhG3LkErMyF9EONJJIZEQHFSsJXeCMdcw=; b=jvmowCZXAPZXwN71QtV56/f/2t
	OgMWzfsKABm/jZfdV6sxtYD/1ZpuF7qoFCl/zk0XFls2Hn6CverV/XuR9wdS7u7I210A3qoN3VI/x
	NoUm81K8WFt2l0N+y5EFhauq84MJSbpxXrOcvK0rJ2iqNEhxXYX9O+elYynryhMlUH0DGlJ79OJZ1
	JZMQrVDB7npUIWd65TfGvkQE0yOjAnF+fOHLPc51qq/XZb9/KnQMmwBA8heUgaP5KUcEV76YCwDlZ
	taCEVPIJ1gLPAjtf7s4VrF1KJy3YTfKaUSbdpep1kPQoQUASywrs5ZkoANo7EGKn2Hu5h6CePQQyi
	EoRu27NA==;
Received: from [201.172.173.139] (port=38462 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1sKN3h-000CZj-3B;
	Thu, 20 Jun 2024 14:02:58 -0500
Message-ID: <b0569cd6-83a4-4b5c-a31e-340bba452473@embeddedor.com>
Date: Thu, 20 Jun 2024 13:02:55 -0600
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
 <c8404725-e4c4-453b-b72d-19ab0761da70@embeddedor.com>
 <47a71c03-0306-4239-b77c-cb63a1760d19@embeddedor.com>
 <0f7d2d25-5c7c-4a19-8af7-ce38ee630d4d@wanadoo.fr>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <0f7d2d25-5c7c-4a19-8af7-ce38ee630d4d@wanadoo.fr>
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
X-Exim-ID: 1sKN3h-000CZj-3B
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.173.139]:38462
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfPIGiyH8oQRXfGyaVHWWBq1W+N5w7rbqu76DPGpQfjzWmseRo6urvgcnxwMq4QYoT2BcD7vLViZOHMDV2Go6Zihln5a3XH1iDD+qxpOTidevQ8mQshsb
 MsOojf6k/ueV/GHHrMUgf1VvEy+41ZfkVKtUGrUuaMfjX6fTjq67NFdnHCue2qQK7f62OdP7pPcrnwL1OpPc7YJ/YYJPuAbVIozA5x0mEv818hAlVDAVsbJB


>> then match->n_channels updated here:
>>
>>           if (!match)
>>               goto out_report_nd;
>> +        match->n_channels = n_channels;
> 
> Thanks for the explanation.
> This is what I was looking for, and I missed this line.
> 
> Sorry for the noise.

No worries. Glad to help. :)

--
Gustavo

