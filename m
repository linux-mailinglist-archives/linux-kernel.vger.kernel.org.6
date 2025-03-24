Return-Path: <linux-kernel+bounces-573177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 367AAA6D3E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 06:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A42EC16AE1E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 05:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A521513B58C;
	Mon, 24 Mar 2025 05:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EVjlNRCF"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C628335BA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 05:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742795444; cv=none; b=kX20a9kBvGZkGwYh435sIwScl5JVyQuRznRAYN4JMiEKDdw6KpheQaF1wtPBxdPcgsCGa6Tr2rIks9i98NzBq/sdPNKkTxWof/Ooq4gcGlNN/2eH/TdxyZ20JAIELjhuTuozx3A0lLe+utqS87eDGfNmWP7ERhKTSa0bA3G2uwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742795444; c=relaxed/simple;
	bh=oA91usqyqVBPuUrkzcyR4m1vhf7Mob5Ut2kSyX8cV48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khpTKD8TgDMrm7YOpvHRnBb0QvqfGhBnwFpWdkqvI/tDmQKdxqNkEAc8KkXMaZNql0jdr2EW4qex5m5bN1XWoGtRP2CCTYXC47fdMHPaj4mPzdR1iAMyo1Bz1Sc28CADjVVKt+DBTCAgV3VZDyNI8NsrBiCXom4AJLJI+r6qwfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EVjlNRCF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43690d4605dso26196175e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 22:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742795441; x=1743400241; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Y17ZL3We+j0Um9q8f67tlcHCzUzcIfQ03LepCBYfNfQ=;
        b=EVjlNRCFmFk/eP4K5WUK6/tuvYV0aYyJwHx77UiG5FcKi4yodD0LKI/orUE/S65/+U
         +PjsZMNiTLTu/zFQut9OdQ+TGmSL7nJWKwgljmf2aBljOY8RbBfA0P8/B7o1hIrut4a7
         htMeLnMfOfcDOgSG7HLcmNBJgLFhNW4ry9agPC0thyaUXcadarZiCfkJ6te1OWlB8s2r
         hK4h8nTb+zxJ5ujCYqAlX64huFLIlzeouuJ2sqWOJhqceOMzHe69VRzqKpFxWbkeAMO3
         ZHpH+btXqHqh57v0wHupqKY8hb9IXlro3UQYBCLEblEA00X4ZIh1zScItYRQs9iq/Jbn
         dGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742795441; x=1743400241;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y17ZL3We+j0Um9q8f67tlcHCzUzcIfQ03LepCBYfNfQ=;
        b=Uje9K+BUUR9SOz9+yPMAjb/uEG8O+aeU8UmQ8ZYApRe0QlyjYM+etzxXHUq4EVI7Qt
         jVpaqbuw8KX3DZ2EyhnHfEZXXRUdP91z6RgaHFih3laQibnEY5GFKM0b6qc1MWaQgMtr
         +rN0NdwrrbkfBGgNDserNXUsl8roh8xQxHsni3SMseKboKoVMHOgUfYKBqEaKzVStbKs
         TrAGuPALDPjf1Fcn26SLGzeJNylgv2MuTNf90sjsfdlU1bcygp1WSM1YVOGBGFHR9135
         +j+Z7U0KzRBTSEPplzcRfewuuUtX/hXFuxgFSZiOCZ80n28PPg3kTQUu5338eQFJ+fbx
         cwhw==
X-Forwarded-Encrypted: i=1; AJvYcCV0B4p4o8eKyOdxpVhHD98fVF7F+3Wk+n08oCViUh05hRgqzqTnEkQ7XyWB1pEgy3IsUD4Fe0CzXl7wIa0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF0FZykT8DfEl+WGIP/d4yp7carXHT9repcfAnlt6AqTNraayp
	HaWEmcMy2BNl0l4B9SzJ9rjA6aG0MIxTiJ3dOQBrXtpl2Ash7grt5gsyLRX4riE=
X-Gm-Gg: ASbGnctb7w7KOJilv0OdZL2JncDviRkJzpzOJ62mBtKJoJ/RJWG3On1ogkkRjeb020D
	EYU9W7Z+0oNxsJB2cV87TE9WUTUmyywiF/Jj1sLp/8/zSn6qlhtirmgzxkoJY3hu1jp9onD58vs
	Uay7zeqj3ik9grS3D7yiCh1i7hD46nfCVpVFN7xXaty2d59Uwbq8/vybpcYkRvbHavjqlaxAXrt
	O6SGoBCBYNeQZt33waErF5CC1olq2GYwuKCLt+dR0VvrVKhUdC8kBKwgBc0lNz6eAB3nGEHVS1c
	w7G5dx51EoN5js0HOejk7T+r5NnnBehHWbd8q9NvYfPFsGSxqA==
X-Google-Smtp-Source: AGHT+IHmTYmhdJOC8tWd9mJoKjnOkYwl7qqf/27G1AO/Qiuynr43p01EUz4e7kx3RkIBljch7G1LIg==
X-Received: by 2002:a05:600c:c8a:b0:43d:46de:b0eb with SMTP id 5b1f17b1804b1-43d509ec4ebmr103517695e9.12.1742795440557;
        Sun, 23 Mar 2025 22:50:40 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43d43f332cfsm161996995e9.6.2025.03.23.22.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 22:50:40 -0700 (PDT)
Date: Mon, 24 Mar 2025 08:50:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: James Dutton <james.dutton@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Markus Elfring <Markus.Elfring@web.de>,
	Qasim Ijaz <qasdev00@gmail.com>, linux-wireless@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	LKML <linux-kernel@vger.kernel.org>,
	Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Bo Jiao <bo.jiao@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>
Subject: Re: [PATCH] wifi: mt76: mt7996: avoid potential null deref in
 mt7996_get_et_stats()
Message-ID: <223c7280-443d-49b4-96b2-90472339dcd4@stanley.mountain>
References: <20250322141910.4461-1-qasdev00@gmail.com>
 <d1df5d97-4691-40d4-a6cc-416505f35164@web.de>
 <92d1a410788c54facedec033474046dda6a1a2cc.camel@sipsolutions.net>
 <CAAMvbhGrJ9b3Aab9+2a5zmvEgf0GZFmHLCC7Hud+egUE28voHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAMvbhGrJ9b3Aab9+2a5zmvEgf0GZFmHLCC7Hud+egUE28voHQ@mail.gmail.com>

On Sun, Mar 23, 2025 at 11:59:45AM +0000, James Dutton wrote:
> As a security side note in relation to the following patch:
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> index 66575698aef1..88e013577c0d 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
> @@ -68,11 +68,13 @@ static int mt7996_start(struct ieee80211_hw *hw)
> 
>  static void mt7996_stop_phy(struct mt7996_phy *phy)
>  {
> -       struct mt7996_dev *dev = phy->dev;
> +       struct mt7996_dev *dev;
> 
>         if (!phy || !test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
>                 return;
> 
> +       dev = phy->dev;
> +
>         cancel_delayed_work_sync(&phy->mt76->mac_work);
> 
>         mutex_lock(&dev->mt76.mutex);
> 
> 
> 
> Prior to that patch, the code looks like this:
> static void mt7996_stop_phy(struct mt7996_phy *phy)
>  {
>        struct mt7996_dev *dev = phy->dev;
> 
>         if (!phy || !test_bit(MT76_STATE_RUNNING, &phy->mt76->state))
>                 return;
> 
> 
> The compiler will completely remove the !phy check entirely because of
> the use above it, so it being present in the source code is completely
> bogus.

No, in the kernel we use the -fno-delete-null-pointer-checks so the
NULL check will always be there.

Also the "phy" point will never be NULL so the check should be removed.

regards,
dan carpenter

> If one actually needs a !phy check to be present in the compiled code,
> one must arrange it as per the patch above.
> 
> The fact that the !phy check is in the source code, implies to me that
> someone, in the past, thought it was necessary, but I think an opinion
> could be taken that it is there to obfuscate a security vulnerability.
> 
> Kind Regards
> 
> James

