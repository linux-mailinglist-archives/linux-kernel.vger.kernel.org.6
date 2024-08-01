Return-Path: <linux-kernel+bounces-271330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE6B944CF1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 15:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F13351C2257F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 13:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810721A073F;
	Thu,  1 Aug 2024 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="YjElgTb1"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7591198A03
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722518051; cv=none; b=H3CMeU3Rrhuku6J4WydsNnnYJAKNURu/pLymKfWyuQFq9UiSZCWwLUkXtEDhfwJKw9Uf6yFfXkGEPzyMdGscpKns8PI1lCqN/D0lmKhEIFJBDFwkpeY7Rwnyav+fXg/UDlFHIjrUosR0k3+13qsj22LXkg7tcHXbKsa+PyRt+Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722518051; c=relaxed/simple;
	bh=OfZ3bDvGx/mlDmniVqFGjbuBBbNEI1lO7D3BKzUqh1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPpZm34WU+sHheGTALOU5CqmAfwwfqgvCa080PYHDHOI9yRsSviv+kJZpvBIC3wdFtKb64pQ6OFMy1w+WiqlcYESAqVEz6updE9e33iKgsMaj25VKgOLifBpojscYPvQp7TDrU+9EpXiwa2f6zfbKprICRiIaxyL1iqH2R6wq6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=YjElgTb1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3684e8220f9so1155802f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 06:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722518048; x=1723122848; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C1zAq2A8tIjO2hNDIqGfuwyFl2KKWufIdH/9uRMO7aA=;
        b=YjElgTb1nr8qjdfRmxsv47mH6knl4RN0nPw28V0NyKBs44oHfZyfU68ELLYiz5uikA
         1VEtmWYhsbj9vKS9K+VIsoVeuuH85ywlghUdpmvw9OCR49jIVQyjACJzQrCR3/zxYL3T
         8dZug4bpeA4SyTzHJZQIAo9t2nX42LLVsSzjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722518048; x=1723122848;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C1zAq2A8tIjO2hNDIqGfuwyFl2KKWufIdH/9uRMO7aA=;
        b=Xq+jpbN0+umfwpT55DElz17kTx8IN/ysG76Hc0XDazcjHfAZ7U0/FoACfwd2TqP4sj
         xBw0GhiWOiilYzpXKlEVL5RfMJU2uGt1ao5X721x7DmhY2Qx0YDuwIn1kL2tcvafI7jo
         dnQQwN921P7O+YW5hpTtZC2x/T4Pcf3Um799c6l3ExcqDfPi4DE0QoTwZxEj7u/08mcm
         ZR7gNaBD2o2HANXQdqTH4yMt+IiaFkks/5v0SAC3F6dhWctyp4GZ0H18rYsEJGkmzNbO
         1S1FRqT+DBvhxVMKFQy5ps5e24G2Jrmt/5aCLdMc7ZGtsUDSS5auBObCJ6aTTnzrcfup
         SgXw==
X-Forwarded-Encrypted: i=1; AJvYcCWOvmpnTiDmSLjcPDMc7+LYA/qTCkRh1kPX85I9vfEI2H2kdQeieNWtVeZJ26IGC7DtJu21Oleiu52TvXkeZXIL/7V/T13z+uEHBcj9
X-Gm-Message-State: AOJu0YxoRfJQzWlM75oFSJsOdRhRjjj42bM11tz+GZvIckBs/yta5cUN
	XBxVQjRw87ba3AsBUS2s10YuvqFNybJASI13IyKu/3v+oSt3zXPAfMKXMoq51oIbj7zgEGbTwDs
	vi+0=
X-Google-Smtp-Source: AGHT+IGY6C6HxMfYIEbuN5skOyWJua94QhKtVofdw583XyL2PipegA2/E/h1+XhGjqNYBfKRCf4SUQ==
X-Received: by 2002:a5d:4251:0:b0:367:9048:e952 with SMTP id ffacd0b85a97d-36bb35c63f5mr1373341f8f.18.1722518048015;
        Thu, 01 Aug 2024 06:14:08 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb1dfd6sm56904175e9.42.2024.08.01.06.14.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 06:14:07 -0700 (PDT)
Date: Thu, 1 Aug 2024 14:14:06 +0100
From: Joe Damato <jdamato@fastly.com>
To: Stefan Roese <sr@denx.de>
Cc: Elad Yifee <eladwf@gmail.com>, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH net-next v2 1/2] net: ethernet: mtk_eth_soc: use prefetch
 methods
Message-ID: <ZquKHioPb6SMpztT@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stefan Roese <sr@denx.de>, Elad Yifee <eladwf@gmail.com>,
	Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Daniel Golle <daniel@makrotopia.org>
References: <20240729183038.1959-1-eladwf@gmail.com>
 <20240729183038.1959-2-eladwf@gmail.com>
 <ZqirVSHTM42983Qr@LQ3V64L9R2>
 <CA+SN3soUmtYfM_qVQ7L1gHMSLYe2bDm=6U9UwFLvj35odT0Feg@mail.gmail.com>
 <17deb48c-6148-4e3d-aa0b-6c840f55302d@denx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17deb48c-6148-4e3d-aa0b-6c840f55302d@denx.de>

On Thu, Aug 01, 2024 at 09:09:27AM +0200, Stefan Roese wrote:
> On 7/30/24 20:35, Elad Yifee wrote:
> > On Tue, Jul 30, 2024 at 11:59 AM Joe Damato <jdamato@fastly.com> wrote:
> > > 
> > > Based on the code in mtk_probe, I am guessing that only
> > > MTK_SOC_MT7628 can DMA to unaligned addresses, because for
> > > everything else eth->ip_align would be 0.
> > > 
> > > Is that right?
> > > 
> > > I am asking because the documentation in
> > > Documentation/core-api/unaligned-memory-access.rst refers to the
> > > case you mention, NET_IP_ALIGN = 0, suggesting that this is
> > > intentional for performance reasons on powerpc:
> > > 
> > >    One notable exception here is powerpc which defines NET_IP_ALIGN to
> > >    0 because DMA to unaligned addresses can be very expensive and dwarf
> > >    the cost of unaligned loads.
> > > 
> > > It goes on to explain that some devices cannot DMA to unaligned
> > > addresses and I assume that for your driver that is everything which
> > > is not MTK_SOC_MT7628 ?
> > 
> > I have no explanation for this partial use of 'eth->ip_align', it
> > could be a mistake
> > or maybe I'm missing something.
> > Perhaps Stefan Roese, who wrote this part, has an explanation.
> > (adding Stefan to CC)
> 
> Sorry, I can't answer this w/o digging deeper into this driver and
> SoC again. And I didn't use it for a few years now. It might be a
> mistake.

I asked about it because it was added in v2 of the patch, see the
changelog from the patch:

  - use eth->ip_align instead of NET_IP_ALIGN as it could be 0,
  depending on the platform 

It seemed like from the changelog some one decided adding that made
sense and I was just confirming the reasoning above.

