Return-Path: <linux-kernel+bounces-563335-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97223A63E89
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 05:41:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80AD13ABDA6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 04:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44566214A9D;
	Mon, 17 Mar 2025 04:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="at7X4qYe"
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38AC207E14
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 04:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742186512; cv=none; b=UIrMA3SIaN2EeBdR/pQavdlbSVBDb6yHy4Smm7EYJANJRDivs0LxeZQ6hT2JJx3WDYSquv0TG142thY4RgdV89rR+DjLfHlzYYi5z59aFHngfkjVGTEOA49tRvry3a0CyQ932+W/G0Is9yslLAA959BuPkDEKzkPdoRTZN0iCC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742186512; c=relaxed/simple;
	bh=OHdQtfx+uuhnWp1sTD1WAzlOAjtZAJhksJYh+ZhNzno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aR6xwsj0A0z9DKGl8Dj7PM65i7CMkMZYViybPCpilQ3B0e3+twAi4blZFEiEJaVB5zIT4Y5xCg7wj9Zr6zlcFVhQvFdX3f2vGivvjF2YFFXTW90AveLndZ4bW7Bt+EWlGjIBPSeaKMcZVZdRfA3cTVna9lV5vwxy4MWA0FMtSEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=at7X4qYe; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5009a.ext.cloudfilter.net ([10.0.29.176])
	by cmsmtp with ESMTPS
	id tv5ltMhPKVkcRu2IKtzxwy; Mon, 17 Mar 2025 04:41:44 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id u2IJtXG6oaBenu2IJtbZ1N; Mon, 17 Mar 2025 04:41:43 +0000
X-Authority-Analysis: v=2.4 cv=I7xjRsgg c=1 sm=1 tr=0 ts=67d7a807
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=BLCW4eN0VRAnxn5/FNkZeA==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=7T7KSl7uo7wA:10
 a=aqjusoyMyk9cqG8RMkgA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Qagcm+b9ADxCwFZUPtxgdLD7LayhL+I77jhLGCR+kCQ=; b=at7X4qYe1cbeLW5Bm0KmR2/31F
	zlVNX4nzxQcvP5RbjR/r6GYC84+JLo3YEG8lHcTLDLbKl/xzV5PUMp91TSy8qYoz0Kz7PJz4oYs2R
	wSe91x1ktjzIcdNAyiJA5WX6srJldV4oGRjXTzqjP/EVjFxqmPB3IkjaGDDUVptbwBNMp6WfhxUkB
	tAzK0MfEehYo5NB1w0ZVZvaRNxFW67PH16QXHgrMnOUp2D22O6rk1s4dKc0C6QlN2xwN/4MlVEn9O
	v/rHdEQbpCU17zOtEAYHB2mdTrcFuYu+ldHvOI13TH2Lsxivc3vwC8nC7cD4hqRIiqfoZN1JKx7sN
	lCI0E2ww==;
Received: from [129.127.202.110] (port=50746 helo=[192.168.225.44])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.1)
	(envelope-from <gustavo@embeddedor.com>)
	id 1tu2IH-00000000dxd-3LUv;
	Sun, 16 Mar 2025 23:41:42 -0500
Message-ID: <112490dd-4490-44f4-abd2-07f7a519aa7b@embeddedor.com>
Date: Mon, 17 Mar 2025 15:10:38 +1030
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] iio: cros_ec: Avoid -Wflex-array-member-not-at-end
 warning
To: Tzung-Bi Shih <tzungbi@kernel.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Benson Leung <bleung@chromium.org>,
 Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
 chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <Z9dy43vUUh4goi-Q@kspp> <Z9d7rp-ullvmXKoM@google.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <Z9d7rp-ullvmXKoM@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 129.127.202.110
X-Source-L: No
X-Exim-ID: 1tu2IH-00000000dxd-3LUv
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.225.44]) [129.127.202.110]:50746
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIwLkfCqX43Dko/Cb5436+/Iqf9OcF9RlzDbER11U59cYCVUxPzUEGCbA0P/8m2XFwKVYjbqwh/xTKTJBah5JeGqV8shF03By58ei/0wkWbh2BGs6vU6
 0NsgG/JGD6giagL9UO+GfNdp2jFBwlnnlea8/nxFGeWdhBMKm/BDTOoGChrXIsaagrqhFTiJ6F6ZncZi3CvLPqMOyQoE5OMrI87U9gu2HLzI74siVAuy0teh



On 17/03/25 12:02, Tzung-Bi Shih wrote:
> On Mon, Mar 17, 2025 at 11:24:59AM +1030, Gustavo A. R. Silva wrote:
>>   static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
>>   					     u16 cmd_offset, u16 cmd, u32 *mask)
>>   {
>> +	DEFINE_RAW_FLEX(struct cros_ec_command, buf, data,
>> +			sizeof(struct ec_response_get_cmd_versions));
> 
> max(sizeof(struct ec_params_get_cmd_versions),
>      sizeof(struct ec_response_get_cmd_versions))?

I considered that, but DEFINE_RAW_FLEX() complains about it due to the

_Static_assert(__builtin_constant_p(count),				\
		       "onstack flex array members require compile-time const count");

--
Gustavo


