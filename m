Return-Path: <linux-kernel+bounces-571741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F30AA6C1A5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 18:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBCDA7A6462
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 17:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2BA22DF9F;
	Fri, 21 Mar 2025 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p2EjPcz9"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01FB1DE884
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578531; cv=none; b=LPp/tARq37+XDnPWEHuC/9/RGLgIfxazYqnTAXXrlIfDn5Rc+/hHXvzHt79NiKsGpO98eJzde/pLi0uHkgl0o13qub/+yFwLpUEgLL38nkDLsfD0wPKZnH7o+pMyFKSYSUOhiQanMuS/2eT6XbpnUKA+hsn7GFOKjypYiC6giLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578531; c=relaxed/simple;
	bh=JnaW8NoZXs1mWMerjoYsGJuJPFqA5xQHNNKpx0jD+CQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1uJVUJ4qHKo5ZSwAbehOEWikron4Nr9QbW0h5pE93hnyq2v3nxtgrJ/lGxpCcqWGkaKzs5s4S4jdEtJZ8UCQRoVMM1KI9t65m1n5eDCltDnfTXIOvFFRoW+lbpy1jDYm4ULFXm7b+0zqOzduoDGfUxhaWkj+CbqsheWk6Ah27s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p2EjPcz9; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so11182955e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 10:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742578528; x=1743183328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VM1LB5RPRJUoaX/SK0r0zxXUzjTWyAeypB9AEGb5D3Y=;
        b=p2EjPcz9BM4N4oyqhJfV2nck8QFPlEZbUTmJD5djEAx+iDJ8+VZT0ouUlZkJLU4qUP
         h6Xg1aRRY8jBRVbWuObplrcL/EvJ/60ja46jtYARCAYjvnwJOusa5JGWA8nWpH/gxbiG
         9L12Yrf06gor2Mywa8VwDOmHIn0NWqtJ0OktoRJtJUvZvxKi42TXmG+neMMe3urpbesA
         zhOf+0wqU+6Zh2Z6fMk4kjNaDTowgyEjXALV/2yYBPHEk9HpXLfqZXOHME9Izk7g1ACn
         WD3Gm/zi6cLHpxtWoz6gzypMBwf4BPw9YaroYZz87SdTHKVzOKC4FkMdIzrbdQ8B0Qpg
         pgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742578528; x=1743183328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VM1LB5RPRJUoaX/SK0r0zxXUzjTWyAeypB9AEGb5D3Y=;
        b=l502fD7yS1NhIvhtQmC7mzhnYwoV/+0czsBNBSEMnzXloPKjQC9Pwfj7LSdNdHuOLf
         RQAvY2Skv1JaNyWSX0XF8RW8leLM9ot7Ps4vJLPw+zEUlcNbnL7tDJGOBC5sIR+CQUif
         6Wc+BXTA7/6W7ipPRYs0qIIuhT1cwnj8w55rYFv2Vkw91Wve4njKY6TE5CuU5bhPdtoM
         1GLHcjoKtQfdsVeflMkanIl2gWxecsQM9kw5ZE8Uoh3gO/utTzP0fm5oqI2chVobsBDI
         etNhnAj1Jvt0uAYfM91/N1jsP0hAL/BT6WfEAn1gNm6QTcO2J7Oj+mZKEdFXYkVOuQ28
         XhwA==
X-Forwarded-Encrypted: i=1; AJvYcCXUo5LNQy6Ye+ZY/jNWa6rzYh7DHPtZNpAJQJyDWmytmvug8pHN0kzVTbxuz9RT8sgXvoAK1jEOSl1h/ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLGE3pnNhazHAv4cmrCYd5dgg6NX7lTX/LQGpzBu9WB+LxBFdL
	dk79+6q4Z5Zcj2vFLLgKQ0Iu7ZsLaIVSfzYSyKTjhdNr1+Uw815Ly12AB8By1Jk=
X-Gm-Gg: ASbGnctEDTJEp2DoPZetsBWBL63yfTL45739XZ4Q+8rKtO0ZmaeQYeZSJBdQQktI2UL
	dJ+TS3Lo+Mmen6CaBE/tzmT96LHS/NDH+SnP2VNM3azrsdcwdmyOHFTl4PJjW2V9gaM3OtFBsUN
	j1L9A3xoWh/loHR9Ph+uq0BQdkjxl8MdSG39WGj3aAEa5cIXpUrXAkmBfEsuyDalTk6/5yfD4Bg
	4MzxUjTdYgwvIpGWSxwtcDgTFW0FpfdIr9YbqFhdNuf3m+/e/UlT0LgnEf7FXkppwK3t68IXLEn
	GVgZcj8b6kSevFb/vRP6laGtgALGdQhG0B15oKLnVEz4/XyCNQ==
X-Google-Smtp-Source: AGHT+IGjauLF3FiaekujjWRPdiwnm31O9jhDz+mK3nAqpBJ67EtcwutfqHgUb3S2fV6TNS6UHTigjQ==
X-Received: by 2002:a05:600c:1c19:b0:43b:cd0d:9466 with SMTP id 5b1f17b1804b1-43d509efa30mr35210415e9.9.1742578528065;
        Fri, 21 Mar 2025 10:35:28 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d4fd181b6sm32529655e9.9.2025.03.21.10.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 10:35:27 -0700 (PDT)
Date: Fri, 21 Mar 2025 20:35:25 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Qasim Ijaz <qasdev00@gmail.com>, nbd@nbd.name, ryder.lee@mediatek.com,
	shayne.chen@mediatek.com, sean.wang@mediatek.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	chui-hao.chiu@mediatek.com, Bo.Jiao@mediatek.com,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: mt7996: prevent uninit return in
 mt7996_mac_sta_add_links
Message-ID: <356de8c6-b3a2-4f7c-9737-011a91c4bdfd@stanley.mountain>
References: <20250320201914.48159-1-qasdev00@gmail.com>
 <46a714fb-8a14-4d24-a0a6-a22cc9d45768@stanley.mountain>
 <Z92eiVIFIUOFKXj_@lore-desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z92eiVIFIUOFKXj_@lore-desk>

On Fri, Mar 21, 2025 at 06:14:49PM +0100, Lorenzo Bianconi wrote:
> > On Thu, Mar 20, 2025 at 08:19:14PM +0000, Qasim Ijaz wrote:
> > > If link_conf_dereference_protected() or mt7996_vif_link() 
> > > or link_sta_dereference_protected() fail the code jumps to
> > > the error_unlink label and returns ret which is uninitialised.
> > > 
> > > Fix this by setting err before jumping to error_unlink.
> > > 
> > > Fixes: c7e4fc362443 ("wifi: mt76: mt7996: Update mt7996_mcu_add_sta to MLO support")
> > > Fixes: dd82a9e02c05 ("wifi: mt76: mt7996: Rely on mt7996_sta_link in sta_add/sta_remove callbacks")
> > > Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
> > > ---
> > >  drivers/net/wireless/mediatek/mt76/mt7996/main.c | 12 +++++++++---
> > >  1 file changed, 9 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> > > index 91c64e3a0860..78f7f1fc867e 100644
> > > --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> > > +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> > > @@ -998,16 +998,22 @@ mt7996_mac_sta_add_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
> > >  			continue;
> > 
> > What about if the list is empty or we hit this continue on every link?
> 
> we will return 0 and I guess that's fine, agree?
> 

Fine by me?

regards,
dan carpenter


