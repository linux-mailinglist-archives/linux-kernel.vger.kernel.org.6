Return-Path: <linux-kernel+bounces-322558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DECF2972AD4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 09:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101CF285411
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 07:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2717D8BF;
	Tue, 10 Sep 2024 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PNfIG8Kx"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A99158DB2
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725953523; cv=none; b=ZSxSCFKCBZ9Qew4C+agk+YatfI2ll1eCs6WpiwzzU16Feei58mksfWcMupbCffVOJtr/tPja/NX9ii2eZ38B3NPLhQwUxuXjOg17GYGKpqHR4gCgFkmZ1Guo5IgEUpym3jIxzppcB+WEs/8o/0ZvjKce0CT+Tg1rj9YYflYREF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725953523; c=relaxed/simple;
	bh=f77j3SCTqwAT+GaM8xKCdHzIx3G/Jn8Mz8HPtqQebr8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=C0pNyeUgLli5n55C/88cYtW36GDNjfkOQ5MsYO8Q0JVu14uryjsc9S/AYVO+f/1q6kmOdGgDLG0TOCNF2VnCe1cdu/+Z6z/WCpBGF+gYBHfbIa4LKY35X9+B/O1uOIULkUlSMKf5oNP/Y2lAjkzZmKNyRCEr0B0VMgA4OeAbpfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PNfIG8Kx; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cba8340beso8059535e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 00:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725953520; x=1726558320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eszUiQ9wlG/1tjLAyBKIiKLnnAvpZBasgR+qa/r6bgw=;
        b=PNfIG8Kx8JYce+7KICM0SCFHRveYs3y9thbvBGSxm3IowVmcmpPxfS9IkJ7ad1dQ9P
         su0fIRXhXr5wI4YqMmdMALt1CnDWDl8d+O5SCH6hQ+lQUspRKiyZRZjXgiWiFOw6cEFS
         CBN0OWYZsEu/xg5rIiEbP5ckSq+oY7gArebb5m5bGX4qIH3NraHNcFLcMlIjfSEvrCp5
         Lh8C713CKJxPYEmLvNaxzHVHfn+5G+YbL3hN8cnyFQzgw2uTxgLdIX9Aicbw3NxwL0WE
         H2fcanV22SiHn9CDhR4vcYGOlHYYTOpOAnwVcZ5OsJSPOM48JreW6lWv8hYi/Dl1Dwn0
         +4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725953520; x=1726558320;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eszUiQ9wlG/1tjLAyBKIiKLnnAvpZBasgR+qa/r6bgw=;
        b=YYYthE431DOPmpkX55Atja/JVbSbTnd8of2qolmpS23nuFemMkOzi4Jn7iUR0+LIUW
         NVyVeuxAHWaOZhftMpLb7X+p15wtM0Ilt4Mncrx0WYPa4O1J/emYKU6Peu/bQuz5ox3K
         Yn+0kIvEK27/v6obcZSav1TtwewE91TEi3UDsw+cZwdWpSdYEX5YWPdrfn1zj+SerIse
         8fJ7Ne/v3ceVZRx9QEy3TZkO1XzgfpkcUXLLCH63nzI57ZjE9Y9kF2CwNs+CyufbXKAC
         YXfM/2TZxoHzZxJd2Rl0n+tfhaHuEpuBS7oNrcNOMezCcRHUdLEv6ZOCcOGntsjJu9Fl
         dNrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO80xUfit0VJwnnTD+jseD2mmk088Y5duiwGfg0cpE884DsLKwVF+F9pBgl+pR/woK53MlTEXvECj7xOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1Os3I8Cz8Q86UHUGJYMv6NrtdMhPDNi3n9wOQcwpayMVM+Tr8
	U/BS7qUW5wXzC4TGxM+obC4Cy9+8SDsqIZ/aGrEuG+XEESxu0uxQyT5D6/1vjcI=
X-Google-Smtp-Source: AGHT+IELa+rG14pL1lB7AiyIMDigzrd0vAidxvik7sx8yhamOOu/U1MRmirvLr3oz1Xd5vrj6Iz8HQ==
X-Received: by 2002:a05:6000:1ac7:b0:374:c6b6:c656 with SMTP id ffacd0b85a97d-378a8a3de4cmr1414873f8f.21.1725953520367;
        Tue, 10 Sep 2024 00:32:00 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378956767dasm8091431f8f.62.2024.09.10.00.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 00:31:59 -0700 (PDT)
Date: Tue, 10 Sep 2024 10:31:56 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Eric Biggers <ebiggers@google.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
Subject: drivers/md/dm-integrity.c:521 sb_mac() error: __builtin_memcmp()
 'actual_mac' too small (64 vs 448)
Message-ID: <e8c80d61-2c74-4b50-ab50-2cf1291df9bc@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b831f83e40a24f07c8dcba5be408d93beedc820f
commit: 070bb43ab01e891db1b742d4ddd7291c7f8d7022 dm integrity: use crypto_shash_digest() in sb_mac()
date:   10 months ago
config: i386-randconfig-141-20240906 (https://download.01.org/0day-ci/archive/20240906/202409061401.44rtN1bh-lkp@intel.com/config)
compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202409061401.44rtN1bh-lkp@intel.com/

smatch warnings:
drivers/md/dm-integrity.c:521 sb_mac() error: __builtin_memcmp() 'actual_mac' too small (64 vs 448)

vim +/actual_mac +521 drivers/md/dm-integrity.c

09d85f8d8909ec Mikulas Patocka   2021-01-21  492  static int sb_mac(struct dm_integrity_c *ic, bool wr)
09d85f8d8909ec Mikulas Patocka   2021-01-21  493  {
09d85f8d8909ec Mikulas Patocka   2021-01-21  494  	SHASH_DESC_ON_STACK(desc, ic->journal_mac);
09d85f8d8909ec Mikulas Patocka   2021-01-21  495  	int r;
070bb43ab01e89 Eric Biggers      2023-10-28  496  	unsigned int mac_size = crypto_shash_digestsize(ic->journal_mac);
070bb43ab01e89 Eric Biggers      2023-10-28  497  	__u8 *sb = (__u8 *)ic->sb;
070bb43ab01e89 Eric Biggers      2023-10-28  498  	__u8 *mac = sb + (1 << SECTOR_SHIFT) - mac_size;
09d85f8d8909ec Mikulas Patocka   2021-01-21  499  
070bb43ab01e89 Eric Biggers      2023-10-28  500  	if (sizeof(struct superblock) + mac_size > 1 << SECTOR_SHIFT) {

This is paired with the line before and prevents the subtraction from going
negative.  It limits the mac_size to 0-448.  Is it reasonable to have a mac_size
which is > HASH_MAX_DIGESTSIZE (64)?

09d85f8d8909ec Mikulas Patocka   2021-01-21  501  		dm_integrity_io_error(ic, "digest is too long", -EINVAL);
09d85f8d8909ec Mikulas Patocka   2021-01-21  502  		return -EINVAL;
09d85f8d8909ec Mikulas Patocka   2021-01-21  503  	}
09d85f8d8909ec Mikulas Patocka   2021-01-21  504  
09d85f8d8909ec Mikulas Patocka   2021-01-21  505  	desc->tfm = ic->journal_mac;
09d85f8d8909ec Mikulas Patocka   2021-01-21  506  
09d85f8d8909ec Mikulas Patocka   2021-01-21  507  	if (likely(wr)) {
070bb43ab01e89 Eric Biggers      2023-10-28  508  		r = crypto_shash_digest(desc, sb, mac - sb, mac);
09d85f8d8909ec Mikulas Patocka   2021-01-21  509  		if (unlikely(r < 0)) {
070bb43ab01e89 Eric Biggers      2023-10-28  510  			dm_integrity_io_error(ic, "crypto_shash_digest", r);
09d85f8d8909ec Mikulas Patocka   2021-01-21  511  			return r;
09d85f8d8909ec Mikulas Patocka   2021-01-21  512  		}
09d85f8d8909ec Mikulas Patocka   2021-01-21  513  	} else {
070bb43ab01e89 Eric Biggers      2023-10-28  514  		__u8 actual_mac[HASH_MAX_DIGESTSIZE];

This buffer is only 64 bytes.

0ef0b4717aa684 Heinz Mauelshagen 2023-02-01  515  
070bb43ab01e89 Eric Biggers      2023-10-28  516  		r = crypto_shash_digest(desc, sb, mac - sb, actual_mac);
09d85f8d8909ec Mikulas Patocka   2021-01-21  517  		if (unlikely(r < 0)) {
070bb43ab01e89 Eric Biggers      2023-10-28  518  			dm_integrity_io_error(ic, "crypto_shash_digest", r);
09d85f8d8909ec Mikulas Patocka   2021-01-21  519  			return r;
09d85f8d8909ec Mikulas Patocka   2021-01-21  520  		}
070bb43ab01e89 Eric Biggers      2023-10-28 @521  		if (memcmp(mac, actual_mac, mac_size)) {
                                                                                ^^^^^^^^^^
Read overflow.

09d85f8d8909ec Mikulas Patocka   2021-01-21  522  			dm_integrity_io_error(ic, "superblock mac", -EILSEQ);
82bb85998cc9a3 Michael Weiß      2021-09-04  523  			dm_audit_log_target(DM_MSG_PREFIX, "mac-superblock", ic->ti, 0);
09d85f8d8909ec Mikulas Patocka   2021-01-21  524  			return -EILSEQ;
09d85f8d8909ec Mikulas Patocka   2021-01-21  525  		}
09d85f8d8909ec Mikulas Patocka   2021-01-21  526  	}
09d85f8d8909ec Mikulas Patocka   2021-01-21  527  
09d85f8d8909ec Mikulas Patocka   2021-01-21  528  	return 0;
09d85f8d8909ec Mikulas Patocka   2021-01-21  529  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


