Return-Path: <linux-kernel+bounces-303024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA2096064D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 11:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DC0C284662
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 09:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688D118D65C;
	Tue, 27 Aug 2024 09:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKiAHU7n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B7C15ADB4
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752448; cv=none; b=iebnC2lU1453RkqoxCMPajMHrcSTz/Ux7gJwN5qjn6f4cN5TlK8xT5YJ3ujYHyup48RASHNpO6OecDHr7heW1J7G0bzb2a2PE3U+Q7KOTtywcXTx+NXBDI2di9hvJzmdniFEeTR3N2vpecxafhgtW9z4uaRAqTgnIBok4wC9N8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752448; c=relaxed/simple;
	bh=+Yyy6DESuy5vOWHSUOvwdM44M68i426opWdvYATe0kU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pdKElPjIKrLErASib4qrGVSVb+6xAfaeK0zoIz9Ds8OvfOty3X0R/ySldiHd9u4A9WRQcFXyQHW91GuywuV+tvevwFl7uDvhlnIQ9NXhmQM3MHMzSTXbudpU5kB8BkeuN/qZj9aDFqV4ME6TIuawsNrJc8p2bcuYdgkORlNg628=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gKiAHU7n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724752445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Hby8+vWGcxG1apHDhMC9Hlf5K3xHSz1sN7KMidP78I=;
	b=gKiAHU7njRqG9IUZpxFpHYG5IiQ5sC45TGxuGbGqiG5J/jRy/Qaoycy7ag4Ickfw68u/uH
	x1zf9bQV17JhVPI2sns3tlXxAjTfQT/MX/vnqhNM7Y15UuVERxX+nIDUvW2byUS7m+sUBz
	dP6PkdA6BrB8FNVMKbp3hhDlEvyldgc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-8lmtCi0XMTa7Dgo8KtKz5g-1; Tue, 27 Aug 2024 05:54:04 -0400
X-MC-Unique: 8lmtCi0XMTa7Dgo8KtKz5g-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3719559c51dso3035195f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724752443; x=1725357243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4Hby8+vWGcxG1apHDhMC9Hlf5K3xHSz1sN7KMidP78I=;
        b=iRh0ASOmmUFCRvpm3u1srpgGHP8pWdn2pxfc2lKq+R2AmiFr45t5B4xJmo1IvBcEUe
         8hnbF619ACcqjRqK0FPAoD/fKjFZXUlof/glKaeTw8S4Bv2xPR5XbvwwAH17/Yd+DqAG
         LfkIpax3ecQQIVkVrfXZQaclNQU+gCMO7nIKuwLuKyXLb405Byp5iveJd0xVBQtzbYEd
         HVATLKKpEL+0ARL4pMNfWrzqbT56R+w0ef8BFzerYYGthsyjgn0InZEjxrecmaAs+cM0
         93S734l4r9reqGO+q3N0yRAxzjtqJnkByZJJIcPiHK0QpbRGFM3of2f7c7ujm3iYPls3
         04wQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDkcJv1wRXnvyfgunv4lPi9WqlSmHfDv3EkHo1DEqXvtBAocaUF92xNEeVpMHZMXRrkKcTk23+vL+aV4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+xgsEDkzh8LAMSpw2AwR2TBhSZMlEGZnwtChULbu/uMT7pr+Q
	agr+RpB9elw73uLe0rKSt+LJQkevI2ZBbO5kAW5jm/9rW9df+kdIVF4EaVN1VircNoDxY+R85X6
	7pmJ8A2436wZxulr16OpIlM+3FEh5W8yefTcJ6DG5ylPnNtfTE3nse2Jnr/YYrA==
X-Received: by 2002:a05:6000:1c4:b0:373:b87:55d3 with SMTP id ffacd0b85a97d-373117c1b62mr9101558f8f.0.1724752442955;
        Tue, 27 Aug 2024 02:54:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc/tL9DeVtL170LyHNOFtbZ0GhSMbtprkRUoyZNpYZdNAFBYoLQDvSprEczt11CUVxwzKnGQ==
X-Received: by 2002:a05:6000:1c4:b0:373:b87:55d3 with SMTP id ffacd0b85a97d-373117c1b62mr9101528f8f.0.1724752442418;
        Tue, 27 Aug 2024 02:54:02 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b67:7410::f71? ([2a0d:3344:1b67:7410::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308264ca6sm12720447f8f.101.2024.08.27.02.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 02:54:02 -0700 (PDT)
Message-ID: <c38c1482-1574-4cc9-9ebf-aa5ad30d627a@redhat.com>
Date: Tue, 27 Aug 2024 11:53:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v28 07/13] rtase: Implement a function to receive
 packets
To: Justin Lai <justinlai0215@realtek.com>, kuba@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us, horms@kernel.org,
 rkannoth@marvell.com, jdamato@fastly.com, pkshih@realtek.com,
 larry.chiu@realtek.com
References: <20240822093754.17117-1-justinlai0215@realtek.com>
 <20240822093754.17117-8-justinlai0215@realtek.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240822093754.17117-8-justinlai0215@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 8/22/24 11:37, Justin Lai wrote:
> +static int rx_handler(struct rtase_ring *ring, int budget)
> +{
> +	union rtase_rx_desc *desc_base = ring->desc;
> +	u32 pkt_size, cur_rx, delta, entry, status;
> +	struct rtase_private *tp = ring->ivec->tp;
> +	struct net_device *dev = tp->dev;
> +	union rtase_rx_desc *desc;
> +	struct sk_buff *skb;
> +	int workdone = 0;
> +
> +	cur_rx = ring->cur_idx;
> +	entry = cur_rx % RTASE_NUM_DESC;
> +	desc = &desc_base[entry];
> +
> +	do {
> +		status = le32_to_cpu(desc->desc_status.opts1);
> +
> +		if (status & RTASE_DESC_OWN)
> +			break;
> +
> +		/* This barrier is needed to keep us from reading
> +		 * any other fields out of the rx descriptor until
> +		 * we know the status of RTASE_DESC_OWN
> +		 */
> +		dma_rmb();
> +
> +		if (unlikely(status & RTASE_RX_RES)) {
> +			if (net_ratelimit())
> +				netdev_warn(dev, "Rx ERROR. status = %08x\n",
> +					    status);
> +
> +			tp->stats.rx_errors++;
> +
> +			if (status & (RTASE_RX_RWT | RTASE_RX_RUNT))
> +				tp->stats.rx_length_errors++;
> +
> +			if (status & RTASE_RX_CRC)
> +				tp->stats.rx_crc_errors++;
> +
> +			if (dev->features & NETIF_F_RXALL)
> +				goto process_pkt;
> +
> +			rtase_mark_to_asic(desc, tp->rx_buf_sz);
> +			goto skip_process_pkt;
> +		}
> +
> +process_pkt:
> +		pkt_size = status & RTASE_RX_PKT_SIZE_MASK;
> +		if (likely(!(dev->features & NETIF_F_RXFCS)))
> +			pkt_size -= ETH_FCS_LEN;
> +
> +		/* The driver does not support incoming fragmented frames.
> +		 * They are seen as a symptom of over-mtu sized frames.
> +		 */
> +		if (unlikely(rtase_fragmented_frame(status))) {
> +			tp->stats.rx_dropped++;
> +			tp->stats.rx_length_errors++;
> +			rtase_mark_to_asic(desc, tp->rx_buf_sz);
> +			goto skip_process_pkt;
> +		}
> +
> +		dma_sync_single_for_cpu(&tp->pdev->dev,
> +					ring->mis.data_phy_addr[entry],
> +					tp->rx_buf_sz, DMA_FROM_DEVICE);
> +
> +		skb = build_skb(ring->data_buf[entry], PAGE_SIZE);
> +		if (!skb) {
> +			netdev_err(dev, "skb build failed\n");

I'm sorry for this late feedback, but the above message should be 
dropped, too.

As pointed out by Jakub in the previous revision, this allocation can 
fail, and the counter increase below will give exactly the same amount 
of information, without potentially filling the dmseg buffer.

FWIW, I think the above is the last item pending.

Thanks,

Paolo


