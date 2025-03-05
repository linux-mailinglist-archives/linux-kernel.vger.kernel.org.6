Return-Path: <linux-kernel+bounces-546279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F2FA4F8AC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 09:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6CE91704AA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 08:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C501B1F866B;
	Wed,  5 Mar 2025 08:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="oy4gfSHP"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FFE1D8DEE
	for <linux-kernel@vger.kernel.org>; Wed,  5 Mar 2025 08:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741162961; cv=none; b=MkKGOjphmRVtPfKz/3b8Tp4oumlp8GcevX02Scic6rABgrVywrzJSsNXQhxQ7uLX49NkG5Oiv3A1DyuMKE3rQv/hHWmVJt55R21hMHJ+Y9QkFyWhFbApWbhJZZhh6KUbInQenuStI/w+jOdtW2VBGjmzGSSsfl2cmRJUEr1iyhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741162961; c=relaxed/simple;
	bh=nefCuvZh9BBXP1HgTB2e4dXo3Ejs7pSEpE8D1o/5fHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f5EnhIjNi4I4dKAMrNicmg8sUoFmO0b/TXp4YR0NJZoxT6UO00/3UyyR6Qr5/UuY32caNjY0t/1cdqzBtG0rujZycpHsGCcNzGpSTGu7WX8Wgap2QVHju5aiPYwu4CX8lhJg7b/JsGMLz7IC3M2DoN/VPWAiRSbRTbUMovSF/zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=oy4gfSHP; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5491eb37dso5416919a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Mar 2025 00:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1741162958; x=1741767758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1brnVJAGUyBrrxRVaMvTP6y55O5yEMp4c+P5cyU9eYc=;
        b=oy4gfSHPVrs6EKnJ6VdugQ/D6WJbu7Hvhkz/xOUGN0u8aq8yhPGUChia/pc0qJmEkE
         lmzGcuI4p7AnUFYt0/ugjJj3EIqjrRyNDPk0ecPp/iKW+w8ddqSv18fJGyDLuujNpOXE
         ICZuDdFncPvzWlUXFd/i1+TbRPF3pjx7zNi6mqkGLT7+3RZwwJGOR2DgLKi2lN2p0muU
         3s7XfKBdYXh/q0I2kdIa3Q0qf90okSt3yO7qpkKiXB749GKIuKXUOtJnXfWMvPoa4hQI
         7jnDk4CwU1HRimIFfxegfIdqvSPiVGoV+QGM27bpUIhklGcphgQgq2IbMwPLCTYNG3M3
         ig9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741162958; x=1741767758;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1brnVJAGUyBrrxRVaMvTP6y55O5yEMp4c+P5cyU9eYc=;
        b=caR3UkPio7O0YWtG2GvLcZ/V1Quo48MGCmpkH+5RmBhSHcIGOSX3EsspotTnnLEO57
         rlVLmdo186AcmQldlUZY9aBKGFvoCT/0XJ8l7u256FcYWBwY3EXvEFZuOexxCVp84ojp
         jQy0QH+j6u+pPbJjXZdd+ELSIuLxNvIHjWC57VNQ0tnAv5TLUzhXtyD3NhGlkB12kVzn
         Hzv+07nQ3WOzCA3fyyyObEb0JBiH6Mujp2uLo9FTC5yLpYdsZ5prjYYZAJ9W4lJzMKch
         J/frcn/wSUtfvElIVvhw2Ve63VnHao3SCcg42DbYCgMXar2fFyZLcLU6o4niTUBKZBA8
         r9cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL+2RMyQozapDwj4OL9xywPrCyuU8Y0BAvDbtTfYVRQagfrI/JuVdrjrR6yok0GUZOeAUVWLWzLJF9LIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGbvZQ/acsmqNlN1A2glRz3oB4PQ+w/+c/evk0LJuE9nTebtaO
	5uSlhkMkyOEkjOL3qUTJ0c4X/dj73ujlyoOVhGYK8jcW12HtA9zmiMc6QkjPyNU=
X-Gm-Gg: ASbGncu87od2f5jIvaHRWEasbkCr+kHcTrqwGTztJ/fL/PiwtcEGl9XMzK/GdTSw6lO
	Gv7yYGRBajvgkCZvB2KPPit/afzwoQRx1lyY/6jhqJlAc7Zm6ulizcfSqCygLcvkNcG8h2UBVdO
	3NcScTUUhVkPgJo7weWRb1PQ/dV9D/9CyNY/ZWp/Cdo1Qx15qzayK5HtZ3i7ft29SYlnjLHCS+T
	oypYutpnTvnfp4anI35+lAW8NDvedjGDPDu8q+H2SfiIz00fLLhII7ETi7ayb9SZC6udlMMcBmo
	v+Ysdfy3vxSo0cIodU+oXSYLpgiqeq8UlP/0ljJpHGC1kq0xcWLfDRP97GoEr2jwsYDVhNoSalo
	L
X-Google-Smtp-Source: AGHT+IHSB1wDKnA9pHV1GSviWm2eGdZkD28ziFa7v6M0Rd/G5QVSKS+XqVwTfVjxopyszVvymfpwQA==
X-Received: by 2002:a05:6402:40cf:b0:5de:dfd0:9d22 with SMTP id 4fb4d7f45d1cf-5e59f470c8dmr2220203a12.22.1741162957444;
        Wed, 05 Mar 2025 00:22:37 -0800 (PST)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3b6dbbbsm9395036a12.22.2025.03.05.00.22.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Mar 2025 00:22:36 -0800 (PST)
Message-ID: <350a057e-39ae-4e8d-a4ec-12b2f78f51cb@blackwall.org>
Date: Wed, 5 Mar 2025 10:22:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 11/15] netfilter: nft_flow_offload: Add
 DEV_PATH_MTK_WDMA to nft_dev_path_info()
To: Eric Woudstra <ericwouds@gmail.com>,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Jiri Pirko <jiri@resnulli.us>,
 Ivan Vecera <ivecera@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Ahmed Zaki <ahmed.zaki@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Vladimir Oltean <olteanv@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 bridge@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-hardening@vger.kernel.org,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20250228201533.23836-1-ericwouds@gmail.com>
 <20250228201533.23836-12-ericwouds@gmail.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250228201533.23836-12-ericwouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 22:15, Eric Woudstra wrote:
> In case of using mediatek wireless, in nft_dev_fill_forward_path(), the
> forward path is filled, ending with mediatek wlan1.
> 
> Because DEV_PATH_MTK_WDMA is unknown inside nft_dev_path_info() it returns
> with info.indev = NULL. Then nft_dev_forward_path() returns without
> setting the direct transmit parameters.
> 
> This results in a neighbor transmit, and direct transmit not possible.
> But we want to use it for flow between bridged interfaces.
> 
> So this patch adds DEV_PATH_MTK_WDMA to nft_dev_path_info() and makes
> direct transmission possible.
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
> ---
>  net/netfilter/nft_flow_offload.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/netfilter/nft_flow_offload.c b/net/netfilter/nft_flow_offload.c
> index 323c531c7046..b9e6d9e6df66 100644
> --- a/net/netfilter/nft_flow_offload.c
> +++ b/net/netfilter/nft_flow_offload.c
> @@ -105,6 +105,7 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
>  		switch (path->type) {
>  		case DEV_PATH_ETHERNET:
>  		case DEV_PATH_DSA:
> +		case DEV_PATH_MTK_WDMA:
>  		case DEV_PATH_VLAN:
>  		case DEV_PATH_PPPOE:
>  			info->indev = path->dev;
> @@ -117,6 +118,10 @@ static void nft_dev_path_info(const struct net_device_path_stack *stack,
>  				i = stack->num_paths;
>  				break;
>  			}
> +			if (path->type == DEV_PATH_MTK_WDMA) {
> +				i = stack->num_paths;
> +				break;
> +			}
>  
>  			/* DEV_PATH_VLAN and DEV_PATH_PPPOE */
>  			if (info->num_encaps >= NF_FLOW_TABLE_ENCAP_MAX) {

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


