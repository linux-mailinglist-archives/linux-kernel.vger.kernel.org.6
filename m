Return-Path: <linux-kernel+bounces-347062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 946FF98CD40
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F148B23620
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 06:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D134A12DD90;
	Wed,  2 Oct 2024 06:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="o0jF/io4"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E6C12BF24
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 06:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727851307; cv=none; b=RAbthmRUez3bkX5EpQCiMtnAtSsOSveO7NCagKN4TTWd2Kkl1aAxLegSrG0qp0KyaMCgEkGJQXXc6MaE86kFAaceemdBVpQQSBKSkt0xsnlxN1c4gqMtdZ4LzCV6Npib48JGaXpinIDMR2QO2hFD1gva8cNny6cxYDIYnXmbo5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727851307; c=relaxed/simple;
	bh=lM8tzlISdvr8uIsxZltdJeWkPQ44hI6oZAogLuNgXAQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dokvWPsjfkC40l5jC3fLdpSylZH+/TCae1U9Zneze5/Yoq0BqT5skFJSS/ljrHtNT8AJf/l9CgUuQmylXDWPHf8LbLQd1FSmatFkvhDlsFWnc3X09aucKZJjkr/JuE9x6BXTNaYIpNnJxA+l1Fpj2hUX/Fi8ad6wQCEa3dMmycU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=o0jF/io4; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1727851246; x=1728456046; i=efault@gmx.de;
	bh=XjAbUiOaLTJsTKhP10rXuEnEJnvHkBTHU3h7qXq5ebE=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=o0jF/io4uIkbjX47MmjRJwcz3vB+wWX1GQj7kKgH9jDOv2SEnnZ//l69r6XTkAJr
	 TWLV4StdCnT1DyWREakJa5jNikVPDO0N14vAtYLimBACVtrV6SZpWJcrdKwJEjfQL
	 e4xnx8c/x1OmzyAK0+DCgtt5k9PlDRrrLylm0Dw/EIoNBjnVTGVQR53umZdY3haFa
	 TZlh8ws9g8/2Gjqds5V8iO2UZuQm5dnzJ3VYakUUu2TED9G3A8wgM/vbrO3UzwLx2
	 oEfnAgWbYbAhK+NLQyCWnMAGRUAFj+91MF0hDNwe0jO/fzToFS9Et9Sz7JiK2vNhZ
	 e3/XPYwd8qJVfhJ35w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.86]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MK3W0-1sbSjo098w-00PXmh; Wed, 02
 Oct 2024 08:40:46 +0200
Message-ID: <12242825054bb861578de6405504875e4d1bb6c2.camel@gmx.de>
Subject: Re: sched/fair: Kernel panics in pick_next_entity
From: Mike Galbraith <efault@gmx.de>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Juri Lelli <juri.lelli@redhat.com>, Dietmar
 Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,  Valentin
 Schneider <vschneid@redhat.com>, luis.machado@arm.com
Date: Wed, 02 Oct 2024 08:40:44 +0200
In-Reply-To: <09e16088690e6577b60de489e6e52a3e5769f96f.camel@gmx.de>
References: <ZvVWq3WM6zVza_mD@linux.ibm.com>
	 <20240930144157.GH5594@noisy.programming.kicks-ass.net>
	 <Zvr2bLBEYyu1gtNz@linux.ibm.com> <Zvr4wJ9YJRzWrbEF@linux.ibm.com>
	 <55a2acefffb8c99e4234bd18656a75625447c2d0.camel@gmx.de>
	 <ZvwCaKkgb2F6pzLP@linux.ibm.com>
	 <09e16088690e6577b60de489e6e52a3e5769f96f.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jhj5PZvjMqouGBqy1K5kV5mmtIkrpkPAoj2lBKzJK9T71lnh686
 SKB22Yi/xbOyKH9rA3kb/yYqQFr2EcuN3vpoZ4SjzXWULYgs0xy5NgRWfVk7yhQgjh9c3CA
 K8tfZ6zYvSTb6MjTysG1KxsbVpKJZw6iGZyAP0PHxP+C5PcEcIRmJ+wVxJ0yzLoj2xxz07h
 JJ/opoSF8TLRSph97M9rw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QpSexjVcPWk=;d+AXr70HESbkv013Y+eIbTfGt3c
 A2DZflCeZrp8c/5VwBRVE03pWkN/7PbOnVn1BUBwW0Wf1ly1KHD3OEtF5cKvE48OrbZh+Q65x
 imX2Ovls4jhLm3xglPSaMc+AWWlyPmKzF+FheFYdsNsGNGwU82p01vBoRfvQZ1JtIU819rIGe
 vmhe7CfC6FS7hEkS41riUFXq4R3WxbIpwSJ8TN1cW5SKsAo3KqhCk0eeseH6/qiJAgJfOWvIP
 niCAp/A/xuAvNy5PnZouOyhnBXE+jGle2+/tyPhUrUg9s1MubxtKhu45RtaCQrstXAXvcTeNB
 Co1Ir4QdeitzNGPofi745xvZqKiUoOeIAkJOfvzUmy0jXPEGD6Np4vl1B8pqmjHBLomKymYns
 QcruCjw9orhOjtXWYcjkYXGbFW/Vj5dpO6p5QeFw96+ORkXXLU8ZFfCKV5LEfQuMz2BI23mMS
 k2HygLRkFtiA7hOeIdcuBAUzCCXbZhUcNSyZSyT5fAe0k4qJ0uUG/ZkQENdKu9s8SaD09ifx3
 hci8aTqPFlnVP13eYgngEuUI+VZ2KfKtxJ7iddZV/CApL+fLf6VjtAB2WOjQ29r1EUByLPj0S
 V9k9OR0lyRKG/wdF+2cwYbNy0UK807GL0afZk6VbNQuHY1aHvxD1qdR1iMhv4/7BudcuKznbZ
 RT4WMDXK0BrB0llWTO/Vt3lFOLfve6aC+O2EcE1I7IkZMa4oV9v02/tFKLI4WDtnrMyHv7T2Z
 1bl4nv71YyNeRDRrKbBKl7ZVWfqNWmZLG6KhXPQbMyJzVacDWbPBW44EIX9fbplk24dIJ5qo/
 +Lp9tKBwJG3xr0lS77X/nN9A==

On Tue, 2024-10-01 at 18:41 +0200, Mike Galbraith wrote:
>
> When I hit $subject, LTPs cfs_bandwidth01 was running, but there was no
> warning prelude, box went straight to panic.=C2=A0 Trying to reproduce u=
sing
> that testcase plus hackbench as efficacy booster produced lots of dying
> box noise, but zero sneaky $subject instances before or after quash.

Hohum, this morning I did hit..

1. WARNING: CPU: 5 PID: 931 at kernel/sched/fair.c:6062 unthrottle_cfs_rq+=
0x4c3/0x4d0
2. WARNING: CPU: 0 PID: 786 at kernel/sched/fair.c:704 update_entity_lag+0=
x79/0x90
3. NULL dereference in pick_next_entity()

..instead of brick, workqueue stall etc. Twice.  Not that it matters.
I was only mucking about with it because I was curious whether telling
LB to stop moving sched_delayed tasks about would matter. (nope)

	-Mike

