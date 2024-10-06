Return-Path: <linux-kernel+bounces-352596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C9B99213B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 22:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18CBD281755
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 20:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A249016DC3C;
	Sun,  6 Oct 2024 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="uGv1jT1g"
Received: from st43p00im-zteg10072001.me.com (st43p00im-zteg10072001.me.com [17.58.63.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADA116EB56
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.63.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728247200; cv=none; b=jSxxXk5zy+HJDTernK+kaJiMMa7C8+ldyDhigMk9Ynx97S2hE/FSDuiGaqa94jf33U6SFpVfwMktRADZ4whlNk0+LKsHE1VUZIlLDxHwi1gfv45kDufXsa1sOLklJrrip5YY7W78eN3MFV7zf9S2MQxF698AVLlTx1Ui9T/ihK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728247200; c=relaxed/simple;
	bh=j8yPXLwN/wbiGB2fcWjnBLjyxnejjvCdy1hHzqSqqKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvqTbszWpPYMQSWYrmiHLe+KZ0TGSpV2pZ7u9pwbTwaqQuJHm72u0OwgqdHithrYEyPAmZkATRQ31WWyZJl2PkNLI7k7611gJKUNPG7ppKwjIaUpQKMSYCuK6DB6zwCKAfLwXjP0WH4cJLgNGllUj6me722RAobtPQ5kg1gdtgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=uGv1jT1g; arc=none smtp.client-ip=17.58.63.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
	t=1728247197; bh=dYh5mzcFJXRf3wk6w3WtIRm8iKhJuRkBoV9itkg3l7w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	b=uGv1jT1gswOdoroGU/sHPuHjcSE39zOViJ3eHssRWl/825aY86TsX57lA3x6yG7Zw
	 8vOZAb2wQ1g4kQqsoOm/GVC1NuVYNyQSK7HRAiDNwmOiRYdagowrmC4ahQrxL3GeG0
	 CcwGWonBwyIoNljksHOec9Y4sEP8UizcEycOfEDgj0od/9lSsdK2j37ByF7t7mK8nj
	 ycXypb3q63cFtjZGbwO5lbWSHUSbvbk/FKnGVlhX28V6oOisU02lsse2Yo+Ynl8NB3
	 cARwVtgsHEHY1WEugROT2FsXroy7AD1N/+qQAVQscneqefX67qgDpYmPMPVg4QJVBO
	 RG+dutfwu4yIw==
Received: from macminiubuntu (st43p00im-dlb-asmtp-mailmevip.me.com [17.42.251.41])
	by st43p00im-zteg10072001.me.com (Postfix) with ESMTPSA id ABA31120D85;
	Sun,  6 Oct 2024 20:39:55 +0000 (UTC)
Date: Sun, 6 Oct 2024 20:39:53 +0000
From: Alain Volmat <avolmat@me.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: gpu: mali-utgard: Add ST sti compatible
Message-ID: <ZwL1meNjsfVnvaSd@macminiubuntu>
Mail-Followup-To: Krzysztof Kozlowski <krzk@kernel.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20241005-sti-gpu-v1-0-9bc11100b54b@me.com>
 <20241005-sti-gpu-v1-1-9bc11100b54b@me.com>
 <t6ueaovdm5gfqmdsedm4aaz7zabsf5lcx3jpintfwyx26uokup@2qhaqycrj2sl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t6ueaovdm5gfqmdsedm4aaz7zabsf5lcx3jpintfwyx26uokup@2qhaqycrj2sl>
X-Proofpoint-GUID: E97Q7bmpmpGeWLKav0lTflDrrstAp0p6
X-Proofpoint-ORIG-GUID: E97Q7bmpmpGeWLKav0lTflDrrstAp0p6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-06_19,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=740
 adultscore=0 phishscore=0 bulkscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2410060148

Hi Krzysztof,

On Sun, Oct 06, 2024 at 02:45:43PM +0200, Krzysztof Kozlowski wrote:
> On Sat, Oct 05, 2024 at 06:07:59PM +0000, Alain Volmat wrote:
> > ST STi SoC family (stih410, stih418) has a Mali400.
> > Add a compatible for it.
> > 
> > Signed-off-by: Alain Volmat <avolmat@me.com>
> > ---
> >  Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
> > index abd4aa335fbcebafc9164bd4963f9db60f0450c4..97a7ef0fea1a10df0ff485b9eb4468f44c92da39 100644
> > --- a/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
> > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-utgard.yaml
> > @@ -33,6 +33,7 @@ properties:
> >                - rockchip,rk3188-mali
> >                - rockchip,rk3228-mali
> >                - samsung,exynos4210-mali
> > +              - st,sti-mali
> 
> That's quite generic compatible. I would expect here per-soc.

Ok, right, I change this into st,stih410-mali in a v2.

Thanks,
Alain
> 
> Best regards,
> Krzysztof
> 

