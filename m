Return-Path: <linux-kernel+bounces-436845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C971B9E8B93
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 07:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8523D280C1A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 06:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A61214A7C;
	Mon,  9 Dec 2024 06:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zPZmIf1e"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D359321480F
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 06:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733726219; cv=none; b=bUknSmoaKmoK8Xy2guFLtXGjt6Rydi65NVFNtwmVwxp9Pjpm1L+m+EyjZ+X9wAzumGXoUg2ggAAOg/jP8hIkgCJ/49Jlpo6g1xyxnaQNIb9FLv50wto4So/y2E67S2LvcAMvC0gNSMt3+naXTQ2S/4xJKfCglvGob7J7UfUIryo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733726219; c=relaxed/simple;
	bh=6eqqUNJJ3vPG7vTcA2wxcPmZxdDyXarNS81G6pfi81Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jtrvZ4MimpY63eURpWLEiOqP8XFhsoCHrSTP3QVKfAuss9HonY18VCPUm967dq7zz7999egecTGhUdTlivie7OKepfDcilH9hZLlLRufzFS8btVQCWXckkMw3wc1zAaMgDZ9elqXmQrBL2Htx1bswBE3fg6s9IpDOw0lBAUTH5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zPZmIf1e; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a766b475so38943185e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2024 22:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733726216; x=1734331016; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0pYqNCYDwSFTStFCXhDRXkvYvPJ1uFwCy3cBb397Bbg=;
        b=zPZmIf1eG/s7ZYPDjnCzYcJHUs4YL7SBxINN88FJbkyaFtSDJEwVyXCtAKjkrBRrwW
         Epg/WSiL5XTMoo1vrlpLWg/QxUQOJdBxtGudzce4NXZOrGYkQeytKIGXAv9shuURP8QK
         53e04pce4VCkGszw9H5v1i/TZY/E5M0mjlvBCyjGfuv/c5e09HRaNOmW0u5hqsc0cUWk
         9S535ou+oNszzoUgrizUka8ZGD27vIKsf+5bp0wPMoYYLLPOK97ODVG9X4DxTtRxf+I4
         tHf+fZI6D/zCbzSuWKtfxrwhxvk9/87xNQ0tb3s/APETEfjdh2U250bjZmSaEdqX5JfS
         /36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733726216; x=1734331016;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0pYqNCYDwSFTStFCXhDRXkvYvPJ1uFwCy3cBb397Bbg=;
        b=VGGDqQzbl6kRZOqKNGuatCVMhThsf8tXMJR/64xe5Xe4XWYpetYID3c4p1oiHgyys2
         u6UHW21fWmq5JN8kXA8mumy/ZeOEY/EWrliB5WWbtnnMWv881slQmYB5dnnY1gjJvWSR
         9Y6YnBbFiVTnhTDA+WPH+7l2paOc85gR9ZpspI/Klc0ygS5qJx2v7/2Q6w1U50bKsj/t
         /IcT972/i90efXbWAwPj84DdtFo/TauTrh+mg+rjs1Y/fxjLeAyIyxYjwEgZjw+t46p7
         tniEDulAsvwf8xY3I1j2lOImaLuZwC6nVZWbbqr75EyJily1l4QFTEIPL39I15I33osY
         WXow==
X-Forwarded-Encrypted: i=1; AJvYcCXF+y+OsFCBhG52REzEqyvyngOW+1inl8QUuo/E3Ig3fsdAFJsCNEwCri1l3Qoh6IvemucvZ1XuA+nXshc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjE0ujhvoIkvj4qFIKKWKLIYVYP7B14fHKx/wyXE9bWJKKQY19
	cwk7/P4VB9H5qtCH/Fjop/bOefaKKpa0dux6/9wmsH8KiCCh3i3WgY8QmHhjyV4=
X-Gm-Gg: ASbGncs1MY1yJXwka9dykGPSUPBSZqScG1UUkT1tOMzU8VVa+INaFOiKQSmLf8uXXHQ
	TFJNZqEFo4y8+gv0gHf2p9KHm7bimqjcAJyk4xOLAmif6rcAdBB01pmj9Bgm/k//1mJ8Dn7jVaL
	q/6wygf8vJ62asoUyiuB89UCFJI0CKzV0UZZr3kUJ8njNAJcx+fcHoaNxtKcxEPnLmQNcmcD3sy
	qiFYTNAsUR1e35Fa93SQ/eMkX+tRSEmO6lhYQIix9aUHP/zV51xAqE=
X-Google-Smtp-Source: AGHT+IES6dTJEaTnkmfHwTMG6jKosfbiP4CkXOOfgsEOmy/HB5R1ohvJm3vAtgSwl3yD4VVxuh+kKg==
X-Received: by 2002:a05:600c:19d3:b0:434:fa73:a907 with SMTP id 5b1f17b1804b1-434fa73ad6fmr9293965e9.13.1733726216159;
        Sun, 08 Dec 2024 22:36:56 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f39653c6sm48575895e9.7.2024.12.08.22.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 22:36:55 -0800 (PST)
Date: Mon, 9 Dec 2024 09:36:51 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: sound/soc/renesas/rcar/adg.c:416 rsnd_adg_create_null_clk() warn:
 passing zero to 'ERR_CAST'
Message-ID: <dd683985-6aac-43e0-8116-92f2c587874d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Lad,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b5f217084ab3ddd4bdd03cd437f8e3b7e2d1f5b6
commit: c087a94bea49acf34d651f7308506fe462a937b3 ASoC: Rename "sh" to "renesas"
config: openrisc-randconfig-r071-20241206 (https://download.01.org/0day-ci/archive/20241207/202412071740.OKhNHftG-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202412071740.OKhNHftG-lkp@intel.com/

smatch warnings:
sound/soc/renesas/rcar/adg.c:416 rsnd_adg_create_null_clk() warn: passing zero to 'ERR_CAST'
sound/soc/renesas/rcar/dma.c:840 rsnd_dma_attach() error: we previously assumed '*dma_mod' could be null (see line 833)

vim +/ERR_CAST +416 sound/soc/renesas/rcar/adg.c

cb2f97d89f383da sound/soc/sh/rcar/adg.c Kuninori Morimoto 2021-06-02  406  static struct clk *rsnd_adg_create_null_clk(struct rsnd_priv *priv,
cb2f97d89f383da sound/soc/sh/rcar/adg.c Kuninori Morimoto 2021-06-02  407  					    const char * const name,
cb2f97d89f383da sound/soc/sh/rcar/adg.c Kuninori Morimoto 2021-06-02  408  					    const char *parent)
d6956a7dde6fbf8 sound/soc/sh/rcar/adg.c Kuninori Morimoto 2021-05-24  409  {
d6956a7dde6fbf8 sound/soc/sh/rcar/adg.c Kuninori Morimoto 2021-05-24  410  	struct device *dev = rsnd_priv_to_dev(priv);
cb2f97d89f383da sound/soc/sh/rcar/adg.c Kuninori Morimoto 2021-06-02  411  	struct clk *clk;
d6956a7dde6fbf8 sound/soc/sh/rcar/adg.c Kuninori Morimoto 2021-05-24  412  
cb2f97d89f383da sound/soc/sh/rcar/adg.c Kuninori Morimoto 2021-06-02  413  	clk = clk_register_fixed_rate(dev, name, parent, 0, 0);
cc64c390b215b40 sound/soc/sh/rcar/adg.c Kuninori Morimoto 2021-08-20  414  	if (IS_ERR_OR_NULL(clk)) {
cb2f97d89f383da sound/soc/sh/rcar/adg.c Kuninori Morimoto 2021-06-02  415  		dev_err(dev, "create null clk error\n");
cc64c390b215b40 sound/soc/sh/rcar/adg.c Kuninori Morimoto 2021-08-20 @416  		return ERR_CAST(clk);

This driver doesn't check for error pointers in the right way.
https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

If a function returns NULL and error pointers the NULL generally means
it's an optional feature.  For example, an ethernet card can transmit
packets just fine without blinking LEDs.  The driver has to be written
to handle the NULL pointer.

Here I guess clk_register_fixed_rate() is optional and has been
deliberately turned off but we're printing an error and then returning
NULL back to the caller.  The callers check for NULL and change it to
an -EIO.  It's shouldn't print an error if it's deliberate.  Or if the
driver can't operate without the feature then that dependency should be
enforced in the Kconfig.

cb2f97d89f383da sound/soc/sh/rcar/adg.c Kuninori Morimoto 2021-06-02  417  	}
d6956a7dde6fbf8 sound/soc/sh/rcar/adg.c Kuninori Morimoto 2021-05-24  418  
cb2f97d89f383da sound/soc/sh/rcar/adg.c Kuninori Morimoto 2021-06-02  419  	return clk;
cb2f97d89f383da sound/soc/sh/rcar/adg.c Kuninori Morimoto 2021-06-02  420  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


