Return-Path: <linux-kernel+bounces-329881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E47DD979712
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F3C91C20B5D
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 14:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B05D1C6F69;
	Sun, 15 Sep 2024 14:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qhQJbK8d"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66321C68A2
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726410253; cv=none; b=QeX88sTzw0R4ZJU+O527E53NuHEdo/awTvb1enxFHdNX+B0qZLgq24zLAdN4qhwkhpcW8hji5QjyatimaKl3yrtfwFXKURrI2kwLRXiYjeGuUtVHsiKPdjBnwOxi9rtriKkEYQ1w6W/dx5FzhoFu46X4E2g2FjECYCaQb9DsplY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726410253; c=relaxed/simple;
	bh=5boAO4ENTuFT2KbnTyArdZtpGbazoY5AnmGUXqzrW7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C+oY/2ldPXojJIh8rcAJLfLlkJs+44Logwy9gZyapSiy1p2agEc6q60UeRHQ3Z6ELMrsY7yDvmgpGth/N+6cUsU9uQm7a05JffMzqf454331mNsPrRMhvvxDK6eWuGWn/IWimHoYv3q6PFMxj9+mAl+GQUmTC/WPSCnhcJVYnSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qhQJbK8d; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso31715615e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 07:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726410249; x=1727015049; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j4CPKp3QZnMID8pkfud1N26aKpa0RCQYMk9K3q+I9pY=;
        b=qhQJbK8dfhirHYQG9kNWQ3EMF0HgeLReFgHz2aRJ51x4ymdg+4ZzorNCOOZQL9v6ce
         EOyig6QpQTPuP4zJ4fRG1HxO5YD8HExjOE7sbz/wzk5PN0PvY27vkM9NbvWL3TDxct1U
         MOaRrwJdsL7YRmbF0vXdNQdaoBzxhMKAr23PGS2O4yqWRou1o4KagsgWPKrF1oUp8vAc
         8WHuC8nNeq4Uz4Z+Vdf08GdId+Ka3cXf/Xr7mCEA7fHJvAyY2ACAf6g3Bb4VMcCCmkvX
         DnPEy6K9XD2si0tuFOGuytUtQnCenJGt65su4/QP+8zi4hctOtKqseuYyl1pPBxf9qUj
         O9nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726410249; x=1727015049;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j4CPKp3QZnMID8pkfud1N26aKpa0RCQYMk9K3q+I9pY=;
        b=ivCfXl7NzK3hdh3Q3d5dpobZJguxKjcm3XzFqAv5+zgQ/jNIdjeT01YSkq2Z2dD/VE
         H0GTwJ5kO88qZIIqc3Gpku5XuwTnQRhNfyJ9YkU2ov5x3KG05WRrXH9kyUY/yb4RRqLP
         Krdo+5hRz07kdK+RCtTa2dBINZCRE9uXvSd7jzInl4mv9+cuaLO1bH3VBpPghAqCSKfa
         fktvSC25CzpATX8QHwadtLJLCKXSR6wU5G93kZ2AeKWPFE6OI+kb+Zwims4ixHSpN95Z
         B67e19doeB7aRymaSQPyf5Ws8Cs+dGCNHqLpcYI+oGMBWq8JWps1kCIhSjmVvviddU2L
         FUdw==
X-Forwarded-Encrypted: i=1; AJvYcCXuJu5QKuZjwJrHuM6eGRrfdvazomZ9BWpmvimUU6oGtZK4q4EsCHW19OuKj0rTHJ6YPuYoHwMwadiOTS8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/rQc9FybMFlxyFULBIyhjYmgEpTJ0cELFcwOx2SsFRUQ8+oDP
	WsNTJU6s3N8OTxh+iHgDD5R8BLjwhPuzmWWAR3XW+pYE5C9IQbGaHDMO5vZg2NI=
X-Google-Smtp-Source: AGHT+IHx7SmWR6pQnPw+/xqWuo+2jZh8WmUQyoBC4qc/MdwJU5vbCj64Og/BQ5muAEGyIUTMA4mPOQ==
X-Received: by 2002:a5d:58d4:0:b0:374:c7a5:d610 with SMTP id ffacd0b85a97d-378d6236b9cmr7343556f8f.43.1726410248866;
        Sun, 15 Sep 2024 07:24:08 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm4759980f8f.49.2024.09.15.07.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 07:24:08 -0700 (PDT)
Date: Sun, 15 Sep 2024 17:24:04 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Johannes Berg <johannes.berg@intel.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c:612
 iwl_mvm_mld_start_ap_ibss() warn: missing error code 'ret'
Message-ID: <de8ae132-a7b7-4e4a-b8f3-b507a75a670d@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d42f7708e27cc68d080ac9d3803d27e86821d775
commit: 3f3126515fbee0e364f8218f6171c091d8e2555e wifi: iwlwifi: mvm: add mvm-specific guard
config: csky-randconfig-r073-20240915 (https://download.01.org/0day-ci/archive/20240916/202409160031.caQ4LNOA-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 14.1.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202409160031.caQ4LNOA-lkp@intel.com/

smatch warnings:
drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c:612 iwl_mvm_mld_start_ap_ibss() warn: missing error code 'ret'

vim +/ret +612 drivers/net/wireless/intel/iwlwifi/mvm/mld-mac80211.c

f947b62c03b15d Miri Korenblit   2023-03-20  574  static int iwl_mvm_mld_start_ap_ibss(struct ieee80211_hw *hw,
cbce62a315f67e Miri Korenblit   2023-03-28  575  				     struct ieee80211_vif *vif,
cbce62a315f67e Miri Korenblit   2023-03-28  576  				     struct ieee80211_bss_conf *link_conf)
f947b62c03b15d Miri Korenblit   2023-03-20  577  {
f947b62c03b15d Miri Korenblit   2023-03-20  578  	struct iwl_mvm *mvm = IWL_MAC80211_GET_MVM(hw);
f947b62c03b15d Miri Korenblit   2023-03-20  579  	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
f947b62c03b15d Miri Korenblit   2023-03-20  580  	int ret;
f947b62c03b15d Miri Korenblit   2023-03-20  581  
3f3126515fbee0 Johannes Berg    2024-05-12  582  	guard(mvm)(mvm);
bde2f9b420f692 Mukesh Sisodiya  2024-04-16  583  
bde2f9b420f692 Mukesh Sisodiya  2024-04-16  584  	if (vif->type == NL80211_IFTYPE_AP)
bde2f9b420f692 Mukesh Sisodiya  2024-04-16  585  		iwl_mvm_send_ap_tx_power_constraint_cmd(mvm, vif, link_conf);
bde2f9b420f692 Mukesh Sisodiya  2024-04-16  586  
36cf537798cb6c Gregory Greenman 2023-03-28  587  	/* Send the beacon template */
36cf537798cb6c Gregory Greenman 2023-03-28  588  	ret = iwl_mvm_mac_ctxt_beacon_changed(mvm, vif, link_conf);
36cf537798cb6c Gregory Greenman 2023-03-28  589  	if (ret)
3f3126515fbee0 Johannes Berg    2024-05-12  590  		return ret;
36cf537798cb6c Gregory Greenman 2023-03-28  591  
bf976c814c864e Johannes Berg    2023-03-28  592  	/* the link should be already activated when assigning chan context */
bf976c814c864e Johannes Berg    2023-03-28  593  	ret = iwl_mvm_link_changed(mvm, vif, link_conf,
bf976c814c864e Johannes Berg    2023-03-28  594  				   LINK_CONTEXT_MODIFY_ALL &
bf976c814c864e Johannes Berg    2023-03-28  595  				   ~LINK_CONTEXT_MODIFY_ACTIVE,
f947b62c03b15d Miri Korenblit   2023-03-20  596  				   true);
f947b62c03b15d Miri Korenblit   2023-03-20  597  	if (ret)
3f3126515fbee0 Johannes Berg    2024-05-12  598  		return ret;
f947b62c03b15d Miri Korenblit   2023-03-20  599  
62e0ccb2170e7a Gregory Greenman 2023-03-28  600  	ret = iwl_mvm_mld_add_mcast_sta(mvm, vif, link_conf);
f947b62c03b15d Miri Korenblit   2023-03-20  601  	if (ret)
3f3126515fbee0 Johannes Berg    2024-05-12  602  		return ret;
f947b62c03b15d Miri Korenblit   2023-03-20  603  
f947b62c03b15d Miri Korenblit   2023-03-20  604  	/* Send the bcast station. At this stage the TBTT and DTIM time
f947b62c03b15d Miri Korenblit   2023-03-20  605  	 * events are added and applied to the scheduler
f947b62c03b15d Miri Korenblit   2023-03-20  606  	 */
62e0ccb2170e7a Gregory Greenman 2023-03-28  607  	ret = iwl_mvm_mld_add_bcast_sta(mvm, vif, link_conf);
f947b62c03b15d Miri Korenblit   2023-03-20  608  	if (ret)
f947b62c03b15d Miri Korenblit   2023-03-20  609  		goto out_rm_mcast;
f947b62c03b15d Miri Korenblit   2023-03-20  610  
f947b62c03b15d Miri Korenblit   2023-03-20  611  	if (iwl_mvm_start_ap_ibss_common(hw, vif, &ret))
f947b62c03b15d Miri Korenblit   2023-03-20 @612  		goto out_failed;

ret = iwl_mvm_start_ap_ibss_common()
if (ret)

f947b62c03b15d Miri Korenblit   2023-03-20  613  
f947b62c03b15d Miri Korenblit   2023-03-20  614  	/* Need to update the P2P Device MAC (only GO, IBSS is single vif) */
f947b62c03b15d Miri Korenblit   2023-03-20  615  	if (vif->p2p && mvm->p2p_device_vif)
f947b62c03b15d Miri Korenblit   2023-03-20  616  		iwl_mvm_mld_mac_ctxt_changed(mvm, mvm->p2p_device_vif, false);
f947b62c03b15d Miri Korenblit   2023-03-20  617  
f947b62c03b15d Miri Korenblit   2023-03-20  618  	iwl_mvm_bt_coex_vif_change(mvm);
f947b62c03b15d Miri Korenblit   2023-03-20  619  
f947b62c03b15d Miri Korenblit   2023-03-20  620  	/* we don't support TDLS during DCM */
f947b62c03b15d Miri Korenblit   2023-03-20  621  	if (iwl_mvm_phy_ctx_count(mvm) > 1)
f947b62c03b15d Miri Korenblit   2023-03-20  622  		iwl_mvm_teardown_tdls_peers(mvm);
f947b62c03b15d Miri Korenblit   2023-03-20  623  
fd940de72d493c Avraham Stern    2023-06-12  624  	iwl_mvm_ftm_restart_responder(mvm, vif, link_conf);
f947b62c03b15d Miri Korenblit   2023-03-20  625  
3f3126515fbee0 Johannes Berg    2024-05-12  626  	return 0;
f947b62c03b15d Miri Korenblit   2023-03-20  627  
f947b62c03b15d Miri Korenblit   2023-03-20  628  out_failed:
f947b62c03b15d Miri Korenblit   2023-03-20  629  	iwl_mvm_power_update_mac(mvm);
f947b62c03b15d Miri Korenblit   2023-03-20  630  	mvmvif->ap_ibss_active = false;
62e0ccb2170e7a Gregory Greenman 2023-03-28  631  	iwl_mvm_mld_rm_bcast_sta(mvm, vif, link_conf);
f947b62c03b15d Miri Korenblit   2023-03-20  632  out_rm_mcast:
62e0ccb2170e7a Gregory Greenman 2023-03-28  633  	iwl_mvm_mld_rm_mcast_sta(mvm, vif, link_conf);
f947b62c03b15d Miri Korenblit   2023-03-20  634  	return ret;
f947b62c03b15d Miri Korenblit   2023-03-20  635  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


