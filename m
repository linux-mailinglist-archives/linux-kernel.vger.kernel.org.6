Return-Path: <linux-kernel+bounces-433352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A589E574B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 14:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24E83280A73
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 13:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AD4218ABE;
	Thu,  5 Dec 2024 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gUGZ/wwY"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161B923918D
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 13:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733405699; cv=none; b=OyrQQDxyPgAh5Oadoerngq6sojqqJzKFFyHhuy3JEjKBFGdEZnxS2d1lBOMGEzp3589+1pkPmbCFuQbHgXK0RwxXclq1uJOR+uDSK8cUMGbkZwIfzjFDxuuz7t3jlaL5blA8a2oO6NqebdLrl+navZWyM8Hyr0LmdoSzijC3eGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733405699; c=relaxed/simple;
	bh=BoLGBVb1NPdm4L7pMGNdH6ioputrhx+cxasjf5qotXc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EH3unSQHwqC5YCjJmZC+YTcdnO5585K5A92cDzF8LDz8mYSp/35uVHu2mqZHaRXyZmpdchvqIPDirymfLtjkOYATTMZVGavbqvY5N4Rd2jqKpPbG2QENa8thI+Dmh2zErz3FONDX2qa/TJd+1u5yvp/szvFTSCFlG9803OX6joI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gUGZ/wwY; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43494a20379so9392215e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 05:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733405696; x=1734010496; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+JBc8KL57J8xHVYF4fKLeUkmEHOFhgXUcAjrh4skgb8=;
        b=gUGZ/wwYWODM7EGTfmiKbh/Xo7H5QL5nmfNmtfkck91eVRqbYvbc6Od/S45QD3Ij9h
         HvUyQi8egCUYa72Y3F8A7JMdztRNFsQvHXWB1gV7U5vjYlaJL9lud0Juedl2y4bqc8mp
         UQRmJYXVql5CTdukYMUWnCgOEIqP23wkLzeKwwzmVMG/29LtZA6EasrsFeKJRN3WXxZ4
         RZHaCi1tY3l8kxuxJ55mF4HM4Fo3YNzJgamagWiKj+bTJYu5I6/IaVjj4Otor/D1OOdW
         ee5KuoOUGjcQsGE4TTL/XFi/HhbjcwQpE6Hub8YTC2KXMEDmV1BkhwdubfT2R3s5Nss2
         VYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733405696; x=1734010496;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+JBc8KL57J8xHVYF4fKLeUkmEHOFhgXUcAjrh4skgb8=;
        b=WCOpdC0WIwI8QKx1yNvFzWdNQ/DMaCCkEhk2/0ZjhFWbMRuyenlnK50q4DHc7/EQRy
         Rdl1QbtXruemuXeens61q9hG8W272znYUj1e9E3/olmB/mJpLttbrjX+VAQrB6MzLCW+
         o9I6plwSbIMwHLT8Gtggxcqq7iti8t4ugjnvOQUEXt0/aIl37brGA5JlBD0fc4BwLEd9
         ubbEA4Yx8VoXHgXrY4K59ruw0GNVBYOGFrr43nPvbwbgwnjlrYfhj+uEzpGnceV8lMt6
         Qprmw1raxjww/9ooaiI3/Mj9G1Cc3+53blxQZIijZQQ8+/U5s7N58KZ/WU+nzDXQzRQp
         88dA==
X-Forwarded-Encrypted: i=1; AJvYcCWUti+OOaHvp8q63xRLgZ7Kfjc6kF20/C11UGbjrforxZNw1qcR9R92pLRwI2YnaTL0IhUO//MjBM5vjlM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa4iGI/mNjqkXjR4O5bmYX5D0KKhuu4apLCmY7U4QESYagjdCr
	iV9gGyhYeqHC1FhNWLlU3SYZFbE8d++2t75k/Vqw5Cp3fmj8e1LfMUToUaGCxJ4=
X-Gm-Gg: ASbGncuRcouOYlWh0ndt+16vFwDq0z9O3ed1ZKaAFlL5y9AevdQSMnVcFjSTDasPpS/
	fjTxyXMR7sTB9rjcbWPsoi/VZ6xvWZ2Xxzaql0JHawtDAfhtNnp67bMbWG32Xy8ZhlUypjoRnBx
	Y+0MxwfwjWZ7TPsXusQYJWxA8SPUSKoozyeKBUjDGsxlvsaQcw1ZKx5tv1ZcQp237eStDmM4pKF
	rlJAx6SpvYPGknx1ieNI1KsKbt+yIgt/UdQG62oGKve9ieyODgHHQ0=
X-Google-Smtp-Source: AGHT+IHbem+ThoKIpTAfmVUHsxyT17Xluqm4yopKeYyDxAcxf5LqmQ0p/xUeyzuaRpl08uRf9De+7A==
X-Received: by 2002:a05:600c:4588:b0:434:9c44:678b with SMTP id 5b1f17b1804b1-434d09c2766mr91769655e9.19.1733405696503;
        Thu, 05 Dec 2024 05:34:56 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526b375sm62072225e9.9.2024.12.05.05.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 05:34:56 -0800 (PST)
Date: Thu, 5 Dec 2024 16:34:52 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Syed Saba Kareem <Syed.SabaKareem@amd.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: sound/soc/amd/acp/acp70.c:217 acp70_pcm_resume() error: we
 previously assumed 'stream' could be null (see line 218)
Message-ID: <2c6a1bd0-7651-4c72-bca4-34674aabafe3@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   feffde684ac29a3b7aec82d2df850fbdbdee55e4
commit: d3534684ada99ef8c0899eb28c62b4462483ee19 ASoC: amd: acp: add Kconfig options for acp7.0 based platform driver
config: x86_64-randconfig-161-20241205 (https://download.01.org/0day-ci/archive/20241205/202412052149.HYbkQDxc-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202412052149.HYbkQDxc-lkp@intel.com/

smatch warnings:
sound/soc/amd/acp/acp70.c:217 acp70_pcm_resume() error: we previously assumed 'stream' could be null (see line 218)

vim +/stream +217 sound/soc/amd/acp/acp70.c

e84db124cb2158b Syed Saba Kareem 2023-10-21  208  static int __maybe_unused acp70_pcm_resume(struct device *dev)
e84db124cb2158b Syed Saba Kareem 2023-10-21  209  {
e84db124cb2158b Syed Saba Kareem 2023-10-21  210  	struct acp_dev_data *adata = dev_get_drvdata(dev);
e84db124cb2158b Syed Saba Kareem 2023-10-21  211  	struct acp_stream *stream;
e84db124cb2158b Syed Saba Kareem 2023-10-21  212  	struct snd_pcm_substream *substream;
e84db124cb2158b Syed Saba Kareem 2023-10-21  213  	snd_pcm_uframes_t buf_in_frames;
e84db124cb2158b Syed Saba Kareem 2023-10-21  214  	u64 buf_size;
e84db124cb2158b Syed Saba Kareem 2023-10-21  215  
e84db124cb2158b Syed Saba Kareem 2023-10-21  216  	spin_lock(&adata->acp_lock);
e84db124cb2158b Syed Saba Kareem 2023-10-21 @217  	list_for_each_entry(stream, &adata->stream_list, list) {
e84db124cb2158b Syed Saba Kareem 2023-10-21 @218  		if (stream) {

The list iterator can't be NULL so this check isn't required.

e84db124cb2158b Syed Saba Kareem 2023-10-21  219  			substream = stream->substream;
e84db124cb2158b Syed Saba Kareem 2023-10-21  220  			if (substream && substream->runtime) {
e84db124cb2158b Syed Saba Kareem 2023-10-21  221  				buf_in_frames = (substream->runtime->buffer_size);
e84db124cb2158b Syed Saba Kareem 2023-10-21  222  				buf_size = frames_to_bytes(substream->runtime, buf_in_frames);
e84db124cb2158b Syed Saba Kareem 2023-10-21  223  				config_pte_for_stream(adata, stream);
e84db124cb2158b Syed Saba Kareem 2023-10-21  224  				config_acp_dma(adata, stream, buf_size);
e84db124cb2158b Syed Saba Kareem 2023-10-21  225  				if (stream->dai_id)
e84db124cb2158b Syed Saba Kareem 2023-10-21  226  					restore_acp_i2s_params(substream, adata, stream);
e84db124cb2158b Syed Saba Kareem 2023-10-21  227  				else
e84db124cb2158b Syed Saba Kareem 2023-10-21  228  					restore_acp_pdm_params(substream, adata);
e84db124cb2158b Syed Saba Kareem 2023-10-21  229  			}
e84db124cb2158b Syed Saba Kareem 2023-10-21  230  		}
e84db124cb2158b Syed Saba Kareem 2023-10-21  231  	}
e84db124cb2158b Syed Saba Kareem 2023-10-21  232  	spin_unlock(&adata->acp_lock);
e84db124cb2158b Syed Saba Kareem 2023-10-21  233  	return 0;
e84db124cb2158b Syed Saba Kareem 2023-10-21  234  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


