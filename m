Return-Path: <linux-kernel+bounces-308090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBCB965716
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 07:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24E691F22B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 05:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCC714BFB4;
	Fri, 30 Aug 2024 05:45:38 +0000 (UTC)
Received: from cmccmta3.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39FE22615
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 05:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724996738; cv=none; b=J6ui7NMWy/R7AVAj3BIO8hZcaWNKOwFYOMd+mh1I3bTSUsIN+JTfHOZ5zheEP3JywapNnxX8BABnzLRh1COSS+xsONITnwpfJ2CNbQ/eraQF5DarOKWznPATzxVpVwtIxYrwbniWcBESc2OUv7dMskGLktkSAc8XhYVoEs3FG0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724996738; c=relaxed/simple;
	bh=jBouCbt2dYRJ2+B3a0eyoDmoqDvqbJZYJl7LR3TNK0Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z6HvIBiEZuvmD7f/rsfpGpAssHR++haMow8yb76vRHs7M8bK4XcqmrMlpZHUkstDIXiJsXuVDMXqbpUizRTRYHVlTQ7Laz2HzG3M1fVWJ1PdtEh+rw+MjOPhd3Pz2lijilVAbgYHD4Bih7VYUNEtd6DiEf/T8q4Sjeaah97e5NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee966d15c7293c-c293f;
	Fri, 30 Aug 2024 13:45:24 +0800 (CST)
X-RM-TRANSID:2ee966d15c7293c-c293f
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.54.5.255])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee766d15c73443-cce58;
	Fri, 30 Aug 2024 13:45:24 +0800 (CST)
X-RM-TRANSID:2ee766d15c73443-cce58
From: Liu Jing <liujing@cmss.chinamobile.com>
To: akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: The percpu memory used by memcg cannot be cleared
Date: Fri, 30 Aug 2024 01:06:44 +0800
Message-Id: <20240829170644.15588-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

hello=EF=BC=8Clinux boss=0D
=0D
        I found a problem in the process of using linux memcg=EF=BC=8CWhen =
I turned swap off, the memcg memory I created with the following script cou=
ld not be deleted with echo 0 > memory.force_empty, as explained below=E3=
=80=82=0D
=0D
---------------------------------------------------------------------------=
-------------------------------=0D
step1=EF=BC=9Aswapoff -a=0D
=0D
=0D
step2=EF=BC=9Ause this script to create memcg=0D
=0D
#!/bin/bash=0D
mkdir -p /tmp/test=0D
for i in 'seq 2000'=0D
do=0D
        sudo mkdir -p /sys/fs/cgroup/memory/user.slice/user-0.slice/test$ {=
i}=0D
        sudo echo $$ > /sys/fs/cgroup/memory/user.slice/user-0.slice/test$ =
{i}/tasks=0D
        sudo echo 'data' > /tmp/test/test$ {i}=0D
        sudo echo $$ > /sys/fs/cgroup/memory/user.slice/user-0.slice/tasks=
=0D
        sudo rmdir /sys/fs/cgroup/memory/user.slice/user-0.slice/test$ {i}=
=0D
done=0D
=0D
=0D
step3=EF=BC=9Aview /proc/cgroup and /proc/meminfo  files=0D
=0D
[root@localhost ~]# cat /proc/cgroups=0D
#subsys_name    hierarchy       num_cgroups     enabled=0D
cpuset           10                   1           1=0D
cpu              4                     1           1=0D
cpuacct         4                     1           1=0D
blkio            13                     1          1=0D
memory          14                 2009             1=0D
devices         6                   94             1=0D
=0D
[root@localhost ~]# cat /proc/meminfo | grep Percpu=0D
Percpu:           600576 kB=0D
=0D
=0D
step4=EF=BC=9Awhen I use "echo 0 > /sys/fs/cgroup/memory/user.slice/user-0.=
slice/memory.force_empty", I find the num_cgroups of memory and percpu  hav=
e no changed=0D
=0D
[root@localhost ~]# echo 0 > /sys/fs/cgroup/memory/user.slice/user-0.slice/=
memory.force_empty=0D
[root@localhost ~]# cat /proc/cgroups=0D
#subsys_name    hierarchy       num_cgroups     enabled=0D
cpuset              10               1            1=0D
cpu                 4                 1           1=0D
cpuacct              4               1             1=0D
blkio                 13              1             1=0D
memory              14              2039            1=0D
devices             6               87               1=0D
=0D
[root@localhost ~]# cat /proc/meminfo | grep Percpu=0D
Percpu:           600576 kB=0D
=0D
=0D
step 5: when I use swapon -a to open swap, then echo 0 > /sys/fs/cgroup/mem=
ory/user.slice/user-0.slice/memory.force_empty again=0D
=0D
[root@localhost ~]# swapon -a=0D
[root@localhost ~]# echo 0 > /sys/fs/cgroup/memory/user.slice/user-0.slice/=
memory.force_empty=0D
=0D
=0D
step 6: view /proc/cgroup and /proc/meminfo  files ,I found the the num_cgr=
oups of memory and percpu  have been reduced. =0D
[root@localhost ~]# cat /proc/cgroups=0D
#subsys_name    hierarchy       num_cgroups     enabled=0D
cpuset              10             1                 1=0D
cpu               4                1                 1=0D
cpuacct            4                1                  1=0D
blkio            13                1                  1=0D
memory            14              185                 1=0D
devices           6               87                 1=0D
freezer           9                1                 1=0D
=0D
[root@localhost ~]# cat /proc/meminfo | grep Percpu=0D
Percpu:           120832 kB=0D
---------------------------------------------------------------------------=
-----------------------------=0D
=0D
=0D
Therefore, I want to know why swap affects memcg memory reclamation,  echo =
0 > memory.force_empty this interface should force the memory used by the c=
group to be reclaimed. =0D
I want to know why ,I look forward to hearing back from the community.=0D
Thanks.=0D



