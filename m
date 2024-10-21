Return-Path: <linux-kernel+bounces-374897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BD79A71A9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 20:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72FE1F21FA4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E9D1F893D;
	Mon, 21 Oct 2024 17:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P4D7ABXI"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682B41F819A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 17:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729533559; cv=none; b=fnNe2FSWlfGmoCQavD0T3fqVlllD4mFGdDo8x+ceP3ShZqAg78maGKYLPYZi9RsDqp+ZrLw7z4NAurejXkGVbmbPxzASppXn7j8Qj0vdsKvPWpFEvsDTGt2fZ5VsgektfsUz71aa9vD60LwCihD/i4G28d+g4xDJuYxkGCKVQk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729533559; c=relaxed/simple;
	bh=zBxOz2PKiAMcUdIlDQcdTkv9bm2UiCEpiRRjP6g7cig=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i9n1HLNhIYUBN8Gu/F0ug7Quiemfi4DAGvexfx1MlH54jwkA1zsdA4flcA3j18CawdrGUc3Dwpvf2b6QQiu1iUjucJeLpmeq7gBbKb2DQRJgNtnGNLx72kwQqzo74cpX1OzdoytkiLAdd+k3tPiykLuyvf+sLGtfX+wcTazR4/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=P4D7ABXI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4315abed18aso44187225e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 10:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729533554; x=1730138354; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EvKRXFh670I33kQAOezgjUTcilQDzlgbUdaDIibWXsc=;
        b=P4D7ABXIC3TefadL0j5hIGDK0vB8iPSAXDzMlNHvNAtIvEai1H658uCcYj2EymGekm
         aS8TcbZGKv61yvp3eRSCjTNjcBg6z7zD3Xlm0TzkRjJZaF4A+d0vHY58LyuAe9z/Jz6R
         geY+sqcRqBch5yViDZkNPHkJAOBnP4PeyAx+mo+rFIH8ylHXq2m4GPdqEdSA2NZKs2yw
         JDQt35aM9Dmx3US8aR0+tETXR9vnyMyc9P0V6pqKxmZX1FWi5h8mDEllivcRZWboT4ZK
         dGF/4Ul9MG53NcSzkhFPqUXd8iejot/4SWfTHV+beuEymIEo45DP8w+T5POqV+0vG5pE
         Y40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729533554; x=1730138354;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvKRXFh670I33kQAOezgjUTcilQDzlgbUdaDIibWXsc=;
        b=puzH2he7WJOUjwaQxW/dApmvqClMVZqs4D6EY0ccrHsnnMFLJY2R0QktkHy5lFNrXs
         lC0FtHv0Rp+h9AZBbFtNrL67YGVUFFYWUT/vPXC1nMxAubE3kLAkB+HTOr+Rr+9q+b82
         H5MFu/FtRMlPQVCP6qNyilOVlzUKADdEqyFIZhkofwC7pva1v+A50PB/skBGqUex4xRZ
         /x+Tdc9NoJFvpz5DFkccK4+NIoAhRAhLV1w0Oc7YmyoTrPZzPASmimk3mRZgisqGnB3i
         BQfvaYGyOfTSU/74SbORMfdEAbxd8SvMOtWMTdKXG3kNDtGjhNcJ4B/HSHIb2hb67gLw
         EKTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdrLHdgBJWyhy9+7Oa8TC7wT4vbOZmFKaax3cPTFBMUMqRHhfjGO0xbKnjOfpC6k2poGSeRhNum0Kve7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzuUQ9enQLDqxCI0zLIgw2eTHlP6DAVL9rzvELaR8wlzichBUX
	nvRDwl5kOBAglADKnHfiHuElByktpHNiS6gHWOh7ufNlPQ/eDWO6wXS6y1GlUZY=
X-Google-Smtp-Source: AGHT+IEqdF36w84AIL9DGp2PjmsBi2+c4cwa4SuwVQPFm8W4VrEsvQKiJ2W2wr7gOatdjMMLouAh1g==
X-Received: by 2002:a05:600c:5490:b0:431:5aea:95f with SMTP id 5b1f17b1804b1-4316165a78cmr112152615e9.16.1729533554534;
        Mon, 21 Oct 2024 10:59:14 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4317c623dd1sm549415e9.0.2024.10.21.10.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 10:59:14 -0700 (PDT)
Date: Mon, 21 Oct 2024 20:59:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Steven Rostedt <rostedt@goodmis.org>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: kernel/trace/fgraph.c:1317 register_ftrace_graph() warn:
 inconsistent returns '&ftrace_lock'.
Message-ID: <0152510c-a9ac-4990-b062-c56204e42c1a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Steven,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42f7652d3eb527d03665b09edac47f85fb600924
commit: 2c02f7375e658ae93d57a31a66f91b62754ef8f1 fgraph: Use CPU hotplug mechanism to initialize idle shadow stacks
config: x86_64-randconfig-161-20241020 (https://download.01.org/0day-ci/archive/20241022/202410220121.wxg0olfd-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202410220121.wxg0olfd-lkp@intel.com/

smatch warnings:
kernel/trace/fgraph.c:1317 register_ftrace_graph() warn: inconsistent returns '&ftrace_lock'.

vim +1317 kernel/trace/fgraph.c

688f7089d8851b1 Steven Rostedt (VMware    2018-11-15  1247) int register_ftrace_graph(struct fgraph_ops *gops)
e73e679f656e678 Steven Rostedt (VMware    2018-11-15  1248) {
2c02f7375e658ae Steven Rostedt            2024-10-18  1249  	static bool fgraph_initialized;
c132be2c4fcc115 Steven Rostedt (VMware    2024-06-03  1250) 	int command = 0;
e73e679f656e678 Steven Rostedt (VMware    2018-11-15  1251) 	int ret = 0;
6d4786592ac88aa Masami Hiramatsu (Google  2024-06-03  1252) 	int i = -1;
e73e679f656e678 Steven Rostedt (VMware    2018-11-15  1253) 
e73e679f656e678 Steven Rostedt (VMware    2018-11-15  1254) 	mutex_lock(&ftrace_lock);
e73e679f656e678 Steven Rostedt (VMware    2018-11-15  1255) 
2c02f7375e658ae Steven Rostedt            2024-10-18  1256  	if (!fgraph_initialized) {
2c02f7375e658ae Steven Rostedt            2024-10-18  1257  		ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "fgraph_idle_init",
2c02f7375e658ae Steven Rostedt            2024-10-18  1258  					fgraph_cpu_init, NULL);
2c02f7375e658ae Steven Rostedt            2024-10-18  1259  		if (ret < 0) {
2c02f7375e658ae Steven Rostedt            2024-10-18  1260  			pr_warn("fgraph: Error to init cpu hotplug support\n");
2c02f7375e658ae Steven Rostedt            2024-10-18  1261  			return ret;

goto out;

2c02f7375e658ae Steven Rostedt            2024-10-18  1262  		}
2c02f7375e658ae Steven Rostedt            2024-10-18  1263  		fgraph_initialized = true;
2c02f7375e658ae Steven Rostedt            2024-10-18  1264  		ret = 0;
2c02f7375e658ae Steven Rostedt            2024-10-18  1265  	}
2c02f7375e658ae Steven Rostedt            2024-10-18  1266  
518d6804a865772 Steven Rostedt (VMware    2024-06-03  1267) 	if (!fgraph_array[0]) {
518d6804a865772 Steven Rostedt (VMware    2024-06-03  1268) 		/* The array must always have real data on it */
518d6804a865772 Steven Rostedt (VMware    2024-06-03  1269) 		for (i = 0; i < FGRAPH_ARRAY_SIZE; i++)
518d6804a865772 Steven Rostedt (VMware    2024-06-03  1270) 			fgraph_array[i] = &fgraph_stub;
6d4786592ac88aa Masami Hiramatsu (Google  2024-06-03  1271) 		fgraph_lru_init();
518d6804a865772 Steven Rostedt (VMware    2024-06-03  1272) 	}
518d6804a865772 Steven Rostedt (VMware    2024-06-03  1273) 
6d4786592ac88aa Masami Hiramatsu (Google  2024-06-03  1274) 	i = fgraph_lru_alloc_index();
6d4786592ac88aa Masami Hiramatsu (Google  2024-06-03  1275) 	if (i < 0 || WARN_ON_ONCE(fgraph_array[i] != &fgraph_stub)) {
c132be2c4fcc115 Steven Rostedt (VMware    2024-06-03  1276) 		ret = -ENOSPC;
e73e679f656e678 Steven Rostedt (VMware    2018-11-15  1277) 		goto out;
e73e679f656e678 Steven Rostedt (VMware    2018-11-15  1278) 	}
7aa1eaef9f4282c Steven Rostedt (VMware    2024-06-03  1279) 	gops->idx = i;
e73e679f656e678 Steven Rostedt (VMware    2018-11-15  1280) 
e73e679f656e678 Steven Rostedt (VMware    2018-11-15  1281) 	ftrace_graph_active++;
518d6804a865772 Steven Rostedt (VMware    2024-06-03  1282) 
cc60ee813b50334 Steven Rostedt (Google    2024-06-03  1283) 	if (ftrace_graph_active == 2)
cc60ee813b50334 Steven Rostedt (Google    2024-06-03  1284) 		ftrace_graph_disable_direct(true);
cc60ee813b50334 Steven Rostedt (Google    2024-06-03  1285) 
518d6804a865772 Steven Rostedt (VMware    2024-06-03  1286) 	if (ftrace_graph_active == 1) {
a069a22f391019e Masami Hiramatsu (Google  2024-08-18  1287) 		ftrace_graph_enable_direct(false, gops);
518d6804a865772 Steven Rostedt (VMware    2024-06-03  1288) 		register_pm_notifier(&ftrace_suspend_notifier);
e73e679f656e678 Steven Rostedt (VMware    2018-11-15  1289) 		ret = start_graph_tracing();
c132be2c4fcc115 Steven Rostedt (VMware    2024-06-03  1290) 		if (ret)
c132be2c4fcc115 Steven Rostedt (VMware    2024-06-03  1291) 			goto error;
e73e679f656e678 Steven Rostedt (VMware    2018-11-15  1292) 		/*
2fbb549983763b2 Steven Rostedt (VMware    2024-06-03  1293) 		 * Some archs just test to see if these are not
2fbb549983763b2 Steven Rostedt (VMware    2024-06-03  1294) 		 * the default function
e73e679f656e678 Steven Rostedt (VMware    2018-11-15  1295) 		 */
2fbb549983763b2 Steven Rostedt (VMware    2024-06-03  1296) 		ftrace_graph_return = return_run;
2fbb549983763b2 Steven Rostedt (VMware    2024-06-03  1297) 		ftrace_graph_entry = entry_run;
c132be2c4fcc115 Steven Rostedt (VMware    2024-06-03  1298) 		command = FTRACE_START_FUNC_RET;
4497412a1f7b5d9 Steven Rostedt (VMware    2024-06-03  1299) 	} else {
4497412a1f7b5d9 Steven Rostedt (VMware    2024-06-03  1300) 		init_task_vars(gops->idx);
c132be2c4fcc115 Steven Rostedt (VMware    2024-06-03  1301) 	}
df3ec5da6a1e7f6 Steven Rostedt (Google    2024-06-03  1302) 	/* Always save the function, and reset at unregistering */
df3ec5da6a1e7f6 Steven Rostedt (Google    2024-06-03  1303) 	gops->saved_func = gops->entryfunc;
df3ec5da6a1e7f6 Steven Rostedt (Google    2024-06-03  1304) 
c132be2c4fcc115 Steven Rostedt (VMware    2024-06-03  1305) 	ret = ftrace_startup_subops(&graph_ops, &gops->ops, command);
a069a22f391019e Masami Hiramatsu (Google  2024-08-18  1306) 	if (!ret)
a069a22f391019e Masami Hiramatsu (Google  2024-08-18  1307) 		fgraph_array[i] = gops;
a069a22f391019e Masami Hiramatsu (Google  2024-08-18  1308) 
c132be2c4fcc115 Steven Rostedt (VMware    2024-06-03  1309) error:
c132be2c4fcc115 Steven Rostedt (VMware    2024-06-03  1310) 	if (ret) {
c132be2c4fcc115 Steven Rostedt (VMware    2024-06-03  1311) 		ftrace_graph_active--;
df3ec5da6a1e7f6 Steven Rostedt (Google    2024-06-03  1312) 		gops->saved_func = NULL;
6d4786592ac88aa Masami Hiramatsu (Google  2024-06-03  1313) 		fgraph_lru_release_index(i);
518d6804a865772 Steven Rostedt (VMware    2024-06-03  1314) 	}
e73e679f656e678 Steven Rostedt (VMware    2018-11-15  1315) out:
e73e679f656e678 Steven Rostedt (VMware    2018-11-15  1316) 	mutex_unlock(&ftrace_lock);
e73e679f656e678 Steven Rostedt (VMware    2018-11-15 @1317) 	return ret;
e73e679f656e678 Steven Rostedt (VMware    2018-11-15  1318) }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


