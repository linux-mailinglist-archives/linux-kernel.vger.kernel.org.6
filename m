Return-Path: <linux-kernel+bounces-545015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70605A4E8CB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 428F63A261B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC5025F7B4;
	Tue,  4 Mar 2025 16:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vyObC9lx"
Received: from beeline3.cc.itu.edu.tr (beeline3.cc.itu.edu.tr [160.75.25.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9D4279356
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741106697; cv=pass; b=jBQ1lY5YGD0vOt2NbnbPt9XUgV3g9lOoiy3Jh4onj3vm0t/yufQ2D5KUE30rbmAvky5J0i+4RGA5y+HX3PPVtz0jw/f1iZvBZ0ShNR99IWM8AkxkRkRHqoVfVOklquiWYcvJgamfqxmeOgBmFQE2NUuxn1gmpPYa37oV8gBKWPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741106697; c=relaxed/simple;
	bh=tljaYjwSlg6y5UbC2D9yfVyCulPk0lM63wJIeCX+tiU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OW1X4eBT8zHS4mm3oQvFgJ6b4hNMMzZbgXw/NPuuDFs1Lay3U44xxf5cA2EnvBNma9vcJlwnk4cw83+km6hQA2r8nlYor4LYggUeU3PVaL/GbA3J6lkwXczkfM3iCY122ayOSKAde42jt427VEZNj4Z4walrNuHAvCN8KgvU7hU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vyObC9lx; arc=none smtp.client-ip=209.85.208.51; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=pass smtp.client-ip=160.75.25.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline3.cc.itu.edu.tr (Postfix) with ESMTPS id 9AA6040CF4D4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:44:53 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6hM53yhQzG43P
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 19:43:13 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 60E6542733; Tue,  4 Mar 2025 19:43:08 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vyObC9lx
X-Envelope-From: <linux-kernel+bounces-541083-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vyObC9lx
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id EBD4F41B4A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:16:14 +0300 (+03)
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 583213064C12
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:16:14 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA2A3A82D6
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 07:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6112C1E9B18;
	Mon,  3 Mar 2025 07:15:55 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0C01D63F5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 07:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740986151; cv=none; b=LlSrA/1lRComAR87FrTsGzadCDnRCQet/Issh5SDKXdrw82Lw3z4oqEb3ecrqIVURpZEpGaH/5bxkIocFr5s1snj1sVeYkqeFpsqB3lSxv8KijqIqwq6EtlfFpljBlz7KZqiXjGTdGc2M0gdUqEBjFaoFMkHCKjrepKV3GRV+sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740986151; c=relaxed/simple;
	bh=tljaYjwSlg6y5UbC2D9yfVyCulPk0lM63wJIeCX+tiU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DLDnS5oDhjeAK1NupnyeK3z+0oTp+r1dXNKibxCGOi8Wofl9O3znOo76vSB7DHEvM/S14h1q4rtjRiQmb2lPWA+HF52zIyHCO/3iaX2cjov6nFKlkR3WdyWAetqZO3bjcWXPxsLWNFj0ABi6nOqpFFdhual5jU96a8KPybWpelE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vyObC9lx; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e4d50ed90aso4152260a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Mar 2025 23:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740986147; x=1741590947; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WqJOjyUVYTznSDpkzCNO5A37E0iHZ7NPdOKTmOaVY9A=;
        b=vyObC9lxmVdwyMOSOSbtX1Q8mbTpDtsjM9+pQcIgSRUEhOl0vaNRnTYozHYkg8xz6s
         3QSpvv910afXNyPOHDgzG62H8Fa/67wTFh6AiM+waJlwLAYzQ473hnYqVE3FLGj+9jYX
         ucDLruQpE4eWxnzEmO2JVeLpufF25noALKlW9KAU1XDFBa/Psa+1L4X2nQ8L6MotR+yt
         g2apHJ+ZSC+qoCSPlZsGzVuadiFyfzVNyZlLSZs9aUVKC75dipiJUt/xNvbK+6EXqOZx
         +xcn4j1ACuum4cN7uaYfSn3UukGSPxDe/qhmTsJAhaRaE9jsPzdwYLkgESzYb0UMiJyG
         csnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740986147; x=1741590947;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WqJOjyUVYTznSDpkzCNO5A37E0iHZ7NPdOKTmOaVY9A=;
        b=a1FBoU1L97zliux63ukYbxY6jzcb0RewJaJxKHYcBCXe2OqQGdSlRmixlZtFy9oVcN
         4X6RdiQm6c8AVNJ7DwSGWUFHzvRci04hXTCkWPhxINiWpptMsn+WhqnuJJAUF/72Ib8q
         kPz9Lp6pLO/00drBHHxG4XefM0QpAulrQ6EF6rjTgtdHwI6rKVCO8RdDsuP8Md8c4TfG
         5jW5Fu1hKjAG0LUzo4y32KBCC0QRggqDL5mmou3S1789M71vHe3B9U/Ctmc1mnTDdcFD
         ez8s7Tsf7L502ReSRg9cVX2XpbC1ZwJN4b3zdNp14Tw+Dy5qwIqz9u20koJELrikNJNY
         6PIQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJNrb46+YCT6gRAqVE8cx5mQgxHMZGUAf53PW78HfZzma4vUo8hF9+N7/lRW0jdaJUXSy03OB5p4TnIZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlXSqGiP5MUF1K+gKkADh3YrNkjccSMiMsoaLzSxeJoTvl4Jfo
	ziJkgIKSUaizfL3cTPzko6CGPoUpJaAfGwAo6u313brAhjH/3r2UKva0C+jq9tI=
X-Gm-Gg: ASbGncsENwnN72V5G7369fFFoWrJYfpyWhcY8gv5V7B6YIACDbVi1x+kQM2ctm7GxFH
	NeDZjXBGxQP29i7Br2P9ap6vjfdXIHyGNjrRSoY8xpKb9h7PiLFqMaC0sZpVNAOSSjfDXysBj7U
	xdWt9CiOVlFXQyDIrJhI5QbxGx+HZFDsxd9Cfac0hkL+yd8hT380RP6nH5j1Ag39+SoXX9JtJBg
	wuP0s2wvaW6SJOyqp+qft1b9AyF0ZayCfjfmZdzqshDYg3rSP43/8T9L6bKGH3S58Bc1XBuHZkN
	anpxe7a1FD3jOR7M+eNJZyI9bJKhYgmftabtKwPBXMPoCN8CFw==
X-Google-Smtp-Source: AGHT+IGfH5yyUc1OrD+Y0vuOehG5xPKevp3+ltByXcI37pZ447OrHONIAoRL4LvWzO0pT/QbRq6FLQ==
X-Received: by 2002:a17:907:3206:b0:abe:e981:f152 with SMTP id a640c23a62f3a-abf265a2a06mr1447149666b.37.1740986147147;
        Sun, 02 Mar 2025 23:15:47 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf5a6e59ffsm364959066b.171.2025.03.02.23.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 23:15:46 -0800 (PST)
Date: Mon, 3 Mar 2025 10:15:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Charles Han <hanchunchao@inspur.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Subject: drivers/net/wireless/mediatek/mt76/mt7925/main.c:2005
 mt7925_change_vif_links() warn: inconsistent returns '&dev->mt76.mutex'.
Message-ID: <a9ef6ddb-7f90-4cf3-b720-fedf1f5e4810@stanley.mountain>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6hM53yhQzG43P
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741711405.1677@Z5r0fqCk+6bTvhDa6bsk0A
X-ITU-MailScanner-SpamCheck: not spam

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7eb172143d5508b4da468ed59ee857c6e5e01da6
commit: 5cd0bd815c8a48862a296df9b30e0ea0da14acd3 wifi: mt76: mt7925: fix NULL deref check in mt7925_change_vif_links
config: i386-randconfig-141-20250303 (https://download.01.org/0day-ci/archive/20250303/202503031055.3ZRqxhAl-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202503031055.3ZRqxhAl-lkp@intel.com/

New smatch warnings:
drivers/net/wireless/mediatek/mt76/mt7925/main.c:2005 mt7925_change_vif_links() warn: inconsistent returns '&dev->mt76.mutex'.

vim +2005 drivers/net/wireless/mediatek/mt76/mt7925/main.c

69acd6d910b0c83 Sean Wang   2024-07-06  1901  static int
69acd6d910b0c83 Sean Wang   2024-07-06  1902  mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
69acd6d910b0c83 Sean Wang   2024-07-06  1903  			u16 old_links, u16 new_links,
69acd6d910b0c83 Sean Wang   2024-07-06  1904  			struct ieee80211_bss_conf *old[IEEE80211_MLD_MAX_NUM_LINKS])
69acd6d910b0c83 Sean Wang   2024-07-06  1905  {
69acd6d910b0c83 Sean Wang   2024-07-06  1906  	struct mt792x_bss_conf *mconfs[IEEE80211_MLD_MAX_NUM_LINKS] = {}, *mconf;
69acd6d910b0c83 Sean Wang   2024-07-06  1907  	struct mt792x_link_sta *mlinks[IEEE80211_MLD_MAX_NUM_LINKS] = {}, *mlink;
69acd6d910b0c83 Sean Wang   2024-07-06  1908  	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
69acd6d910b0c83 Sean Wang   2024-07-06  1909  	unsigned long add = new_links & ~old_links;
69acd6d910b0c83 Sean Wang   2024-07-06  1910  	unsigned long rem = old_links & ~new_links;
69acd6d910b0c83 Sean Wang   2024-07-06  1911  	struct mt792x_dev *dev = mt792x_hw_dev(hw);
69acd6d910b0c83 Sean Wang   2024-07-06  1912  	struct mt792x_phy *phy = mt792x_hw_phy(hw);
69acd6d910b0c83 Sean Wang   2024-07-06  1913  	struct ieee80211_bss_conf *link_conf;
69acd6d910b0c83 Sean Wang   2024-07-06  1914  	unsigned int link_id;
69acd6d910b0c83 Sean Wang   2024-07-06  1915  	int err;
69acd6d910b0c83 Sean Wang   2024-07-06  1916  
69acd6d910b0c83 Sean Wang   2024-07-06  1917  	if (old_links == new_links)
69acd6d910b0c83 Sean Wang   2024-07-06  1918  		return 0;
69acd6d910b0c83 Sean Wang   2024-07-06  1919  
69acd6d910b0c83 Sean Wang   2024-07-06  1920  	mt792x_mutex_acquire(dev);
                                                ^^^^^^^^^^^^^^^^^^^^^^^^^^
Locked.

69acd6d910b0c83 Sean Wang   2024-07-06  1921  
69acd6d910b0c83 Sean Wang   2024-07-06  1922  	for_each_set_bit(link_id, &rem, IEEE80211_MLD_MAX_NUM_LINKS) {
69acd6d910b0c83 Sean Wang   2024-07-06  1923  		mconf = mt792x_vif_to_link(mvif, link_id);
69acd6d910b0c83 Sean Wang   2024-07-06  1924  		mlink = mt792x_sta_to_link(&mvif->sta, link_id);
69acd6d910b0c83 Sean Wang   2024-07-06  1925  
69acd6d910b0c83 Sean Wang   2024-07-06  1926  		if (!mconf || !mlink)
69acd6d910b0c83 Sean Wang   2024-07-06  1927  			continue;
69acd6d910b0c83 Sean Wang   2024-07-06  1928  
69acd6d910b0c83 Sean Wang   2024-07-06  1929  		if (mconf != &mvif->bss_conf) {
69acd6d910b0c83 Sean Wang   2024-07-06  1930  			mt792x_mac_link_bss_remove(dev, mconf, mlink);
69acd6d910b0c83 Sean Wang   2024-07-06  1931  			devm_kfree(dev->mt76.dev, mconf);
69acd6d910b0c83 Sean Wang   2024-07-06  1932  			devm_kfree(dev->mt76.dev, mlink);
69acd6d910b0c83 Sean Wang   2024-07-06  1933  		}
69acd6d910b0c83 Sean Wang   2024-07-06  1934  
69acd6d910b0c83 Sean Wang   2024-07-06  1935  		rcu_assign_pointer(mvif->link_conf[link_id], NULL);
69acd6d910b0c83 Sean Wang   2024-07-06  1936  		rcu_assign_pointer(mvif->sta.link[link_id], NULL);
69acd6d910b0c83 Sean Wang   2024-07-06  1937  	}
69acd6d910b0c83 Sean Wang   2024-07-06  1938  
69acd6d910b0c83 Sean Wang   2024-07-06  1939  	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
69acd6d910b0c83 Sean Wang   2024-07-06  1940  		if (!old_links) {
9f89f05bef1a573 Sean Wang   2024-07-06  1941  			mvif->deflink_id = link_id;
69acd6d910b0c83 Sean Wang   2024-07-06  1942  			mconf = &mvif->bss_conf;
69acd6d910b0c83 Sean Wang   2024-07-06  1943  			mlink = &mvif->sta.deflink;
69acd6d910b0c83 Sean Wang   2024-07-06  1944  		} else {
69acd6d910b0c83 Sean Wang   2024-07-06  1945  			mconf = devm_kzalloc(dev->mt76.dev, sizeof(*mconf),
69acd6d910b0c83 Sean Wang   2024-07-06  1946  					     GFP_KERNEL);
69acd6d910b0c83 Sean Wang   2024-07-06  1947  			mlink = devm_kzalloc(dev->mt76.dev, sizeof(*mlink),
69acd6d910b0c83 Sean Wang   2024-07-06  1948  					     GFP_KERNEL);
5cd0bd815c8a488 Charles Han 2024-10-25  1949  			if (!mconf || !mlink)
5cd0bd815c8a488 Charles Han 2024-10-25  1950  				return -ENOMEM;

Call mt792x_mutex_release(dev) before returning.

69acd6d910b0c83 Sean Wang   2024-07-06  1951  		}
69acd6d910b0c83 Sean Wang   2024-07-06  1952  
69acd6d910b0c83 Sean Wang   2024-07-06  1953  		mconfs[link_id] = mconf;
69acd6d910b0c83 Sean Wang   2024-07-06  1954  		mlinks[link_id] = mlink;
69acd6d910b0c83 Sean Wang   2024-07-06  1955  		mconf->link_id = link_id;
69acd6d910b0c83 Sean Wang   2024-07-06  1956  		mconf->vif = mvif;
69acd6d910b0c83 Sean Wang   2024-07-06  1957  		mlink->wcid.link_id = link_id;
4f0f33d2747f207 Sean Wang   2024-07-06  1958  		mlink->wcid.link_valid = !!vif->valid_links;
b1d21403c0cfe71 Sean Wang   2024-07-06  1959  		mlink->wcid.def_wcid = &mvif->sta.deflink.wcid;
69acd6d910b0c83 Sean Wang   2024-07-06  1960  	}
69acd6d910b0c83 Sean Wang   2024-07-06  1961  
69acd6d910b0c83 Sean Wang   2024-07-06  1962  	if (hweight16(mvif->valid_links) == 0)
69acd6d910b0c83 Sean Wang   2024-07-06  1963  		mt792x_mac_link_bss_remove(dev, &mvif->bss_conf,
69acd6d910b0c83 Sean Wang   2024-07-06  1964  					   &mvif->sta.deflink);
69acd6d910b0c83 Sean Wang   2024-07-06  1965  
69acd6d910b0c83 Sean Wang   2024-07-06  1966  	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
69acd6d910b0c83 Sean Wang   2024-07-06  1967  		mconf = mconfs[link_id];
69acd6d910b0c83 Sean Wang   2024-07-06  1968  		mlink = mlinks[link_id];
69acd6d910b0c83 Sean Wang   2024-07-06  1969  		link_conf = mt792x_vif_to_bss_conf(vif, link_id);
69acd6d910b0c83 Sean Wang   2024-07-06  1970  
69acd6d910b0c83 Sean Wang   2024-07-06  1971  		rcu_assign_pointer(mvif->link_conf[link_id], mconf);
69acd6d910b0c83 Sean Wang   2024-07-06  1972  		rcu_assign_pointer(mvif->sta.link[link_id], mlink);
69acd6d910b0c83 Sean Wang   2024-07-06  1973  
69acd6d910b0c83 Sean Wang   2024-07-06  1974  		err = mt7925_mac_link_bss_add(dev, link_conf, mlink);
69acd6d910b0c83 Sean Wang   2024-07-06  1975  		if (err < 0)
69acd6d910b0c83 Sean Wang   2024-07-06  1976  			goto free;
69acd6d910b0c83 Sean Wang   2024-07-06  1977  
69acd6d910b0c83 Sean Wang   2024-07-06  1978  		if (mconf != &mvif->bss_conf) {
69acd6d910b0c83 Sean Wang   2024-07-06  1979  			err = mt7925_set_mlo_roc(phy, &mvif->bss_conf,
69acd6d910b0c83 Sean Wang   2024-07-06  1980  						 vif->active_links);
69acd6d910b0c83 Sean Wang   2024-07-06  1981  			if (err < 0)
69acd6d910b0c83 Sean Wang   2024-07-06  1982  				goto free;
69acd6d910b0c83 Sean Wang   2024-07-06  1983  		}
69acd6d910b0c83 Sean Wang   2024-07-06  1984  	}
69acd6d910b0c83 Sean Wang   2024-07-06  1985  
69acd6d910b0c83 Sean Wang   2024-07-06  1986  	mvif->valid_links = new_links;
69acd6d910b0c83 Sean Wang   2024-07-06  1987  
69acd6d910b0c83 Sean Wang   2024-07-06  1988  	mt792x_mutex_release(dev);
69acd6d910b0c83 Sean Wang   2024-07-06  1989  
69acd6d910b0c83 Sean Wang   2024-07-06  1990  	return 0;
69acd6d910b0c83 Sean Wang   2024-07-06  1991  
69acd6d910b0c83 Sean Wang   2024-07-06  1992  free:
69acd6d910b0c83 Sean Wang   2024-07-06  1993  	for_each_set_bit(link_id, &add, IEEE80211_MLD_MAX_NUM_LINKS) {
69acd6d910b0c83 Sean Wang   2024-07-06  1994  		rcu_assign_pointer(mvif->link_conf[link_id], NULL);
69acd6d910b0c83 Sean Wang   2024-07-06  1995  		rcu_assign_pointer(mvif->sta.link[link_id], NULL);
69acd6d910b0c83 Sean Wang   2024-07-06  1996  
69acd6d910b0c83 Sean Wang   2024-07-06  1997  		if (mconf != &mvif->bss_conf)
69acd6d910b0c83 Sean Wang   2024-07-06  1998  			devm_kfree(dev->mt76.dev, mconfs[link_id]);
69acd6d910b0c83 Sean Wang   2024-07-06  1999  		if (mlink != &mvif->sta.deflink)
69acd6d910b0c83 Sean Wang   2024-07-06  2000  			devm_kfree(dev->mt76.dev, mlinks[link_id]);
69acd6d910b0c83 Sean Wang   2024-07-06  2001  	}
69acd6d910b0c83 Sean Wang   2024-07-06  2002  
69acd6d910b0c83 Sean Wang   2024-07-06  2003  	mt792x_mutex_release(dev);
69acd6d910b0c83 Sean Wang   2024-07-06  2004  
69acd6d910b0c83 Sean Wang   2024-07-06 @2005  	return err;
69acd6d910b0c83 Sean Wang   2024-07-06  2006  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki



