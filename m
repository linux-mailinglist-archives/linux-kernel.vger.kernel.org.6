Return-Path: <linux-kernel+bounces-411000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1689CF181
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 17:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3DBE1F243B9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 16:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4121D47C7;
	Fri, 15 Nov 2024 16:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W01u209Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFBE166307
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688231; cv=none; b=VtPN22xku12rISBcZv00NBTH/aPh8SwCNl9EEc6PnTHTuSzPMcS9kiy7yxhoGjUIOWBysTBtoiSXIgyCULLOr/rFoXw3E8FmXGtJnMc9U+DFjoH3ZdwWk570wn9EN9+Q8HmbwgfbmJH00pm1cezait+yEAG8aDyeT0ioCxTHIQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688231; c=relaxed/simple;
	bh=23WwRG9YMIrdOINPp98oIY1pU+b7asr/HtZ9Lb7K10Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F4igolprMs4du7+4PpfL6AAC2Me18plQg5XQqNRFcvfcvaMdtbO0gHfcNILrJ4vFPIVWY8G/YbJZUcXN2MevUxaK502bxYUXNoJyyYfiMXoXop38evYE1IoIcYNCPSfLwwzXdKTfDt+0nIU61IQYCyxNycA49NC4Kh4H1/Ia2nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W01u209Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731688228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=CWuLwX1NW+1DyPKTMhME1vJOYG/j4m1+TWZHBmu4nbA=;
	b=W01u209Y5hH+UR19vgz4FlzAHYgNz4X1hbT2jaCETZaxQCfIx2knMQ0IvxDBV3a4QaBn12
	0npZxQY04R0wxy+bwnfP2yDuZnzv/RHNS4gwLxPZkwVO1zich2egIeFcISFqclULhN+DLA
	uw7DxFM3kztBYxl9sLunCS0rPB6LBik=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-wBxC1R4qMqu_dhReoxRBVg-1; Fri, 15 Nov 2024 11:30:25 -0500
X-MC-Unique: wBxC1R4qMqu_dhReoxRBVg-1
X-Mimecast-MFC-AGG-ID: wBxC1R4qMqu_dhReoxRBVg
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6d3a07b63e6so26040786d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 08:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731688225; x=1732293025;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWuLwX1NW+1DyPKTMhME1vJOYG/j4m1+TWZHBmu4nbA=;
        b=Vok0jly/mS/iGMUdAK4FvG6/aohy8kLK6085mpgDvL4ujvVlaygGilBS96g4D56cv6
         Qm4UeLHQILFJlxHdc7y8gCp+ney2TwDd0odWBEkswDkrV9OGuwurrrIGUOo3r/5AjDfq
         4PugZ05EuGiSi5mQQZCYaO2r6ZOaOAA2JAEcFgaavteo8VBgaaM+zJeQ7zwJbuv0AWKH
         Fdb1SrI5aRfFCcBuXBb7V+tIHo9OAl9pFDsaCyJY+RCruBvOMgVkBnxsDCIP3vuH0YP5
         tq76bqQgLh9WccFxTkXU80ZtWSZ+4UuNMNdkejk85siNV3lbxg5YapaSmsmoZawb2nlh
         rsqw==
X-Gm-Message-State: AOJu0YyXBX1Ck85y8DbAe867RBcWtzURrbpaNUujnsqatXQ02CXDR0vT
	j/Uj2ZeNbgitVDPhmg0hYScwDC4H5/VIM3Lec8h8h9Hq1jFIpK/jsEmwnvVOm3vshu4wVnW0A0z
	jVHFcdfhGaPlmtbJb2oZCWDeE4KKBeXOqaxKYlVKk7dtjAMpSIAtkopJPfGNhcg==
X-Received: by 2002:a05:6214:3992:b0:6d3:f904:5359 with SMTP id 6a1803df08f44-6d3fb821c77mr44867256d6.33.1731688224824;
        Fri, 15 Nov 2024 08:30:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFJdcgA20MMlQvFTg5eHsqs/sPveryXiK7wPJsLZuT6HmgM/b7XQecSuNE+S749+ckIL3iYRQ==
X-Received: by 2002:a05:6214:3992:b0:6d3:f904:5359 with SMTP id 6a1803df08f44-6d3fb821c77mr44866866d6.33.1731688224360;
        Fri, 15 Nov 2024 08:30:24 -0800 (PST)
Received: from jlelli-thinkpadt14gen4.remote.csb (host-80-47-4-194.as13285.net. [80.47.4.194])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d3ee77386fsm19197606d6.6.2024.11.15.08.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 08:30:23 -0800 (PST)
Date: Fri, 15 Nov 2024 16:30:19 +0000
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Koutny <mkoutny@suse.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: Additional issue with cpuset isolated partitions?
Message-ID: <Zzd3G67_UwBUJaRt@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

While working on the recent cpuset/deadline fixes [1], I encountered
what looks like an issue to me. What I'm doing is (based on one of the
tests of test_cpuset_prs.sh):

# echo Y >/sys/kernel/debug/sched/verbose
# echo +cpuset >cgroup/cgroup.subtree_control
# mkdir cgroup/A1
# echo 0-3 >cgroup/A1/cpuset.cpus
# echo +cpuset >cgroup/A1/cgroup.subtree_control
# mkdir cgroup/A1/A2
# echo 1-3 >cgroup/A1/A2/cpuset.cpus
# echo +cpuset >cgroup/A1/A2/cgroup.subtree_control
# mkdir cgroup/A1/A2/A3
# echo 2-3 >cgroup/A1/A2/A3/cpuset.cpus
# echo 2-3 >cgroup/A1/cpuset.cpus.exclusive
# echo 2-3 >cgroup/A1/A2/cpuset.cpus.exclusive
# echo 2-3 >cgroup/A1/A2/A3/cpuset.cpus.exclusive
# echo isolated >cgroup/A1/A2/A3/cpuset.cpus.partition

and with this, on my 8 CPUs system, I correctly get a root domain for
0-1,4-7 and 2,3 are left isolated (attached to default root domain).

I now put the shell into the A1/A2/A3 cpuset

# echo $$ >cgroup/A1/A2/A3/cgroup.procs

and hotplug CPU 2,3

# echo 0 >/sys/devices/system/cpu/cpu2/online
# echo 0 >/sys/devices/system/cpu/cpu3/online

guess the shell is moved to the non-isolated domain. So far so good
then, only that if I turn CPUs 2,3 back on they are attached to the root
domain containing the non-isolated cpus

# echo 1 >/sys/devices/system/cpu/cpu2/online
...
[  990.133593] root domain span: 0-2,4-7
[  990.134480] rd 0-2,4-7

# echo 1 >/sys/devices/system/cpu/cpu3/online
...
[ 1082.858992] root domain span: 0-7
[ 1082.859530] rd 0-7

And now the A1/A2/A3 partition is not valid anymore

# cat cgroup/A1/A2/A3/cpuset.cpus.partition
isolated invalid (Invalid cpu list in cpuset.cpus.exclusive)

Is this expected? It looks like one need to put at least one process in
the partition before hotplugging its cpus for the above to reproduce
(hotpluging w/o processes involved leaves CPUs 2,3 in the default domain
and isolated).

Thanks,
Juri

1 - https://lore.kernel.org/lkml/20241114142810.794657-1-juri.lelli@redhat.com/
    https://lore.kernel.org/lkml/20241110025023.664487-1-longman@redhat.com/


