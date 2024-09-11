Return-Path: <linux-kernel+bounces-324836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8E6975166
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 14:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C875C28B0BD
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 12:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD27318785F;
	Wed, 11 Sep 2024 12:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BzUB+j4V"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8573251C4A;
	Wed, 11 Sep 2024 12:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726056199; cv=none; b=Cs9Nf1KSDeCV6h/U93kdTmJclubxL3E+Hky2W+pyyjOpsyQukE2hnAcBqxq2Z3GeyEy6V5RrxOv7pusQChQZJ9oy5pre899LreXaCpix1LKlLemdh13aVTW6lM6TMRkfGmaV8o1m9mDVze0O4wRCleuoAsyrHFUW/m5WRX5IRKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726056199; c=relaxed/simple;
	bh=RRWxLgszYAt2RDmKsJ8aH9d/Tr9vyeupDgydeQ5ejhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOnGbd37Lc8d8mWpGaPWAJnnK00aOXDvcAtP6T0zxaWROFi/8r7h+yqqZbVr0MVLhVZHx9YWTVPM5ISRLOeZ/h7yOENO27PRIGZBubNmDAv+1KLw6YmurNTNN8hoQl6gkTv0JkZFstaW1YUhXxKaOOe4PC5gbGrioaC+eMsAIzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BzUB+j4V; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Message-ID:MIME-Version:
	Content-Type; bh=LreFkTuW7liUdQSgQl8JsUo6bkRPZ76VmfyP6CVpOVQ=;
	b=BzUB+j4Vd55Bon2kvkuyeDzgyMsy6J424AkxqX+QcdeMCP0OY1mg9w4TkrEzJ8
	BeHbCm1vV/54NOrMrUsHLVJvsWZIbr2LELQFsn//VeUMht/h6TsNMDQ7Rd69HhBF
	/B1FEE5s/vctB8RhAwG42FzXvaeAQBrLQpQrn8pGvG5ZE=
Received: from localhost (unknown [120.26.85.94])
	by gzga-smtp-mta-g3-4 (Coremail) with SMTP id _____wBnSp_ehuFmOiukDQ--.6702S2;
	Wed, 11 Sep 2024 20:02:38 +0800 (CST)
Date: Wed, 11 Sep 2024 20:02:38 +0800
From: Qianqiang Liu <qianqiang.liu@163.com>
To: Mark Brown <broonie@kernel.org>
Cc: amergnat@baylibre.com, angelogioacchino.delregno@collabora.com,
	lgirdwood@gmail.com, matthias.bgg@gmail.com,
	linux-sound@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: mt8365: Fix using uninitialized value "i2s_data"
 issue
Message-ID: <ZuGG3jk6oqq7sUMw@iZbp1asjb3cy8ks0srf007Z>
References: <20240911001516.47268-1-qianqiang.liu@163.com>
 <9ea8731a-7888-40a2-a183-4598884bbb27@sirena.org.uk>
 <ZuGAwQGPWdpO1-G9@iZbp1asjb3cy8ks0srf007Z>
 <eb21bcab-333d-4ab3-9222-058764ced720@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb21bcab-333d-4ab3-9222-058764ced720@sirena.org.uk>
X-CM-TRANSID:_____wBnSp_ehuFmOiukDQ--.6702S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1rJFykGry7Jr15Cw4Uurg_yoW8XrWDp3
	4ktan2kFyqqr4jyrsrur1UtasIk3y3JFZrWay7Jw12yFy3ur4a9Fn2kas0kFWvqrnaywnF
	qrW2qr9xJrZ5A3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jcdbbUUUUU=
X-CM-SenderInfo: xtld01pldqwhxolxqiywtou0bp/1tbiRQJXamXAo2LUZAACss

On Wed, Sep 11, 2024 at 12:41:15PM +0100, Mark Brown wrote:
> On Wed, Sep 11, 2024 at 07:36:33PM +0800, Qianqiang Liu wrote:
> > On Wed, Sep 11, 2024 at 11:52:58AM +0100, Mark Brown wrote:
> > > On Wed, Sep 11, 2024 at 08:15:17AM +0800, Qianqiang Liu wrote:
> 
> > > >  	spin_lock_irqsave(&afe_priv->afe_ctrl_lock, flags);
> 
> > > > +	if (!i2s_data) {
> > > > +		spin_unlock_irqrestore(&afe_priv->afe_ctrl_lock, flags);
> > > > +		return;
> > > > +	}
> 
> > > Why would we look up i2s_data without the lock, take the lock, then
> > > check if we actually found it?  That doesn't seem right.
> 
> > Just check the "i2s_data" is NULL or not.
> 
> That doesn't address my question at all.

How about this new patch:

diff --git a/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c b/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
index 3482d8f8b4e7..11b9a5bc7163 100644
--- a/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
+++ b/sound/soc/mediatek/mt8365/mt8365-dai-i2s.c
@@ -465,13 +465,16 @@ void mt8365_afe_set_i2s_out_enable(struct mtk_base_afe *afe, bool enable)
 	int i;
 	unsigned long flags;
 	struct mt8365_afe_private *afe_priv = afe->platform_priv;
-	struct mtk_afe_i2s_priv *i2s_data;
+	struct mtk_afe_i2s_priv *i2s_data = NULL;
 
 	for (i = 0; i < DAI_I2S_NUM; i++) {
 		if (mt8365_i2s_priv[i].adda_link)
 			i2s_data = afe_priv->dai_priv[mt8365_i2s_priv[i].id];
 	}
 
+	if (!i2s_data)
+		return;
+
 	spin_lock_irqsave(&afe_priv->afe_ctrl_lock, flags);
 
 	if (enable) {

-- 
Best,
Qianqiang Liu


