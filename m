Return-Path: <linux-kernel+bounces-355744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9567B995657
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 20:21:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1A92888D4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 18:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0423212D04;
	Tue,  8 Oct 2024 18:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="W0mZNS7q"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EBD189910
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411654; cv=none; b=O5PYMenVSrIEnccShoYyJFBhbiPPFVZiguCiZsLdsYkrhqBCcEt4rPkvcNlTsHfMV7L95/tcMItRZUA4Gz7N584D/BavMQPUqqY4dL+vFzz+n/Mb0ophukuFgmngDs5ulMnTtSR3u8yGA8hhgTiWojS0nLxeZxstODSM0OCXhgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411654; c=relaxed/simple;
	bh=maT2ElR+ztAXb8N7d6RAwLafiZW6/aQk5wJi3IPWR0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxUsOiMl/PySxItKGFb/tW958/8Ioqwhug6WN2HRzn9nl+OBrpVv4WLXEC580Jmd7M+pJlHLvmmDkcKC1JpG20C6cN4RRj9WbG8bd3QJN0jhkrz3dY9RCTSItVTMmyNN1a5xHDSHM39gLtozXnvjgYRIrxVfcr8l+izsdb8D3DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=W0mZNS7q; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71de9e1f431so3467820b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 11:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1728411651; x=1729016451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdixHRRhJR+67cK5BvTRI84FxCdkiNcyBDRYQb0ntbk=;
        b=W0mZNS7q7PNrGpkL4TlMsJmeQC+19gKX5M0W49Vpy5OArPeUvd9EJ+U//n5sWYSJ2B
         EZlaomI38+v8b1AQUHAI3yxwHQFexWc9ZvBjaxgFrtFD54Bt4D+h1Dzi5+PJJnhH9oAd
         /RrqwJ2qEDg9daaZzT72U/4sB1WQI92HTQTJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728411651; x=1729016451;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdixHRRhJR+67cK5BvTRI84FxCdkiNcyBDRYQb0ntbk=;
        b=ovlXTFk+P0S+93x1oxpcB/nhHoUJfIFK5s9am1uhR+TrfAgbgVw+e5lKvv4Vt3Wst4
         TywB4PwsLB61eouGDVvuciJGa5KIBGbjbgPK0r8+LGY1YU791HZYSp9MG+a0Nxui7QWm
         o+5GxMyvLYhXrQeosXqUOh4eYcPGLrl1HdImxtte2R+fixwGOK1tD7J3RxfbBriFzkpj
         ud+VQzorY9a9vTTSItvgR4VI4nwRzecyVPxgjgM9V96xpK5TZvdd/LFr682bgF/tZn42
         NUx81Y4ErkzqSyoVOZtz931/G06AhY+hyFe3rpjsr3x+qAw39K13glra+VGo2WAjN/jb
         SBiw==
X-Forwarded-Encrypted: i=1; AJvYcCWsqv5U/NvwlnVLCg8az7eqtzcAoCXRJ/5KJWrOUUfmD5sjVxSmgOCyFd9vDivB6b3629gEhQAIofWx7LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuuvSwgeHJPzOhai82iNAVN+QpEKkMTkYiw1utDiq3ksYyYIed
	dOTRj4FpWn/TDynKdUO4SM0fQ0ON7XjKtiDPMmamjToHXyp1juzDcc7ewuQ+5r4=
X-Google-Smtp-Source: AGHT+IHcgv+kRTgXo20tsQSHIv8ZWddq4lfnoSxMVWL9FKQSzZc7w/QjVIgngvmNyac2gK8yiL0N6g==
X-Received: by 2002:a05:6a00:3a14:b0:710:6e83:cd5e with SMTP id d2e1a72fcca58-71de22e1e3fmr27948867b3a.0.1728411651549;
        Tue, 08 Oct 2024 11:20:51 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9f6c4915asm7122825a12.86.2024.10.08.11.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 11:20:50 -0700 (PDT)
Date: Tue, 8 Oct 2024 11:20:47 -0700
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v4 6/9] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <ZwV3_3K_ID1Va6rT@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
	mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
	bjorn@rivosinc.com, amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Daniel Jurgens <danielj@nvidia.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20241001235302.57609-1-jdamato@fastly.com>
 <20241001235302.57609-7-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001235302.57609-7-jdamato@fastly.com>

On Tue, Oct 01, 2024 at 11:52:37PM +0000, Joe Damato wrote:
> Add support to set per-NAPI defer_hard_irqs and gro_flush_timeout.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>  Documentation/netlink/specs/netdev.yaml | 11 ++++++
>  include/uapi/linux/netdev.h             |  1 +
>  net/core/netdev-genl-gen.c              | 14 ++++++++
>  net/core/netdev-genl-gen.h              |  1 +
>  net/core/netdev-genl.c                  | 45 +++++++++++++++++++++++++
>  tools/include/uapi/linux/netdev.h       |  1 +
>  6 files changed, 73 insertions(+)

[...]

> diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
> index b28424ae06d5..901c6f65b735 100644
> --- a/net/core/netdev-genl-gen.c
> +++ b/net/core/netdev-genl-gen.c
> @@ -87,6 +87,13 @@ static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_FD + 1]
>  	[NETDEV_A_DMABUF_QUEUES] = NLA_POLICY_NESTED(netdev_queue_id_nl_policy),
>  };
>  
> +/* NETDEV_CMD_NAPI_SET - set */
> +static const struct nla_policy netdev_napi_set_nl_policy[NETDEV_A_NAPI_GRO_FLUSH_TIMEOUT + 1] = {
> +	[NETDEV_A_NAPI_ID] = { .type = NLA_U32, },
> +	[NETDEV_A_NAPI_DEFER_HARD_IRQS] = { .type = NLA_S32 },

Noticed this while re-reading the code; planning on changing this
from NLA_S32 to NLA_U32 for v5.

