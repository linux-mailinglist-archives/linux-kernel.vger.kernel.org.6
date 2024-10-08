Return-Path: <linux-kernel+bounces-354484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 256DF993E21
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 06:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1EA285F70
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61EFB1369B6;
	Tue,  8 Oct 2024 04:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="kxPK2ldM"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C0B2AE77
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 04:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728363581; cv=none; b=a7+mhzDmqPsPH/uMjhq5ssQrioRI4ZDFL08p0SyIaW3Iw+5KEdhmrWzlKckh8Hgvo2/68IetdF2+pQQKgrH5vKABkT18eD0PpOr7Q+sAaKWEBBwnkNZGg2pvp8hziFV8CtwwU+nUv795NDojWKvBxUCv3u1NsAY/CLPJRs4aDbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728363581; c=relaxed/simple;
	bh=2he7TmWRGX1I2Xw6fbx3AGiAfCkQ1CA7w92o52NR8BA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nz5gUAZTa7fhLOnTiPyibr0nPpnvU4wzVutRVxl9DCe4xPc+icBT4N1rdGsSx2pBtJ87zbaScREqVm4AztAqcp9QinQAymjxH1nEs0zwcY0LcEygBl0zTHReEiWXef2SAzEtqx9Kgkro1+t9HAXIgk1jZ6NTmUwmcErJHdRwPFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=kxPK2ldM; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728363541; x=1728968341; i=efault@gmx.de;
	bh=t7Mi51R4XOjeAh4Ma/htACrQooHwkpYDidzpIPppMO8=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kxPK2ldMw9knAsSRXIVDbedv/gzFIRKKOi2NzRaZzhAQI5YGj1ZbH2PSjGhu6eFN
	 cjWH+cyMvLq726uf9IlAmPyZ2e0OZUgoBigMEv/AzI3hOAUGbCDAxm09bTuwYAXEi
	 0qIxasv2aKWq37fzB0cWdcN5pO083A8Ol9Edz1mw6ZXZh4wY/NrBZ4a3IiwiZGTDa
	 o/82o6icuEqLCX91c3rYy97ucqCRBjkKVpvbKFgIMDugFUBiXuFoC0UgmAvf1kglf
	 v+2TQa3Lq3m8uV/t6FFOW0sKsTTrlKDztJdZj4gJisZML8o2oH9C8i9TFPRCaLVpr
	 SoCDb9F+E0wSBw9A4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([91.212.106.175]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTRQq-1tPYYj2nVs-00XriT; Tue, 08
 Oct 2024 06:59:01 +0200
Message-ID: <579b7ea34ef6e2f7c955abdfc0929fe1af36faef.camel@gmx.de>
Subject: Re: [PATCH 0/5] sched: Lazy preemption muck
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>, bigeasy@linutronix.de, 
	tglx@linutronix.de, mingo@kernel.org
Cc: linux-kernel@vger.kernel.org, juri.lelli@redhat.com, 
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org, 
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 ankur.a.arora@oracle.com
Date: Tue, 08 Oct 2024 06:58:59 +0200
In-Reply-To: <20241007074609.447006177@infradead.org>
References: <20241007074609.447006177@infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:A7EstQL3oyLhEMJa/owq7meZyzz0bcwvLkshWm8E0o7LlVlLiJM
 Q07BuLFhNXsQAzvw8ovCA6/K4VDh/CmUllw58y1YeyAf1QZ9gOJSfccZK87y2urSDUT7ENh
 +zLZK677gVLaykcqwg4LovT8E6UdLqeWcX2JpW1/FCVwxbP4vyrUCHXJFYCNU1rDFS6n5lN
 fu7g8yfVU0m6JgmUu8wVA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:PYkBP5A4XTU=;xRT87POMenAt0qWCbZ7E2TacIFG
 sddqhwtHF1ehFs71fYJHK6HTfILYj3BmylaC+KpUIIEng4Lcs25fWijoEOkCz+xvYY4jbBdE3
 Z41bXwMNlmYhgZTBj6RfXjbowtlShOwJXHVb0lKLYg/OHCeTXsuJYwIVA7Hn+Hko4UMMyWI+L
 lBFEWjnhQXh/+gaDWi6CqByPcnK1xHvueS4Xu4SvDFpdsWe3Cb6xXsAoHkRXTOb9DqzgdFJMv
 KeaWue7+A4k+cDvjWe4JtHY05yMyEn0UGhcGGUB/32K8A95lLd5LS3T2Z2wvzqaSDtntabzup
 65sfgzLQBhHsCaC/9pGJTvnRuhu8E5Purrnnl/owB2tZ0ZaGV83Ith+8JVBUvaRnCswrm9tC/
 oAHdAjOUD2MazypLDA/f4+1mkpTHyHnRTbpXcyGCcu028S+ONZnYtbjCKk6y3R5ULMuDi5SSo
 4qp8hGVHNWoNegENxtXNHLTgRBH0pZOQy/iD6TbjF2S+6uuoD4kzVyWvSpFoBledse4LV8i+G
 W2eS3ZceahdjAvxyoSGjXiI8R/TJxQNJ2Uxv6lzNiI+eV8S0I8UepS9cK/rnQap73U000qq7v
 Zhgt0va5+CASRWxdyD7fT3d/1n7s2iTj4248JsFob0x4OaovJQjoct6ZieBBj9m6P9IAlzssW
 sfQ4KCkJvq4EbhszcDCuQXZXn7SZrbivxY/+0IVxPyGGG3ng+E9SM429sJ5PPOx77sQmhUbeO
 2WVJbUMXcChwxcveD4SJ5Pb/vbVOHwgJiZFFjv+3aLVp3yQqJ26z0QbBtvvuqIs8NII6F5gFu
 yLrTMPvIl+MZQm4hYcEtx9vA==

On Mon, 2024-10-07 at 09:46 +0200, Peter Zijlstra wrote:
> Hi!
>
> During LPC Thomas reminded me that the lazy preemption stuff was not the=
re yet.
>
> So here goes, robot says it builds, and I checked both a regular and PRE=
EMPT_RT
> build boots and can change the mode.
>
> Please have a poke.

My box seems content.

I'm gonna miss VOLATILE (voluntary;) when it's eventually whacked, but
not a lot.. or at all general case, security and whatnot over time have
beaten up high end switchers far worse.

tbench 8 30s - single run, box=3Di7-4790

master static
  voluntary     3620.45 MB/sec   1.000   mean3 3613.45  stddev3 14.08
  voluntary     2706.54 MB/sec    .747   +cpu_mitigations
  voluntary     4028.72 MB/sec   1.112   nostalgia (4.4.231)
  preempt       3449.35 MB/sec    .952
  none          3631.99 MB/sec   1.003

master dynamic
  none          3548.19 MB/sec    .980
  voluntary     3495.77 MB/sec    .965
  full          3476.50 MB/sec    .960
  lazy          3473.95 MB/sec    .959
  laziest       3492.09 MB/sec    .964

master dynamic rt
  full          2352.58 MB/sec    .649
  lazy          2986.28 MB/sec    .824
  laziest       2977.63 MB/sec    .822

distro kernel dynamic
  none          1744.51 MB/sec    .481
  none          2189.74 MB/sec    .604  mitigations=3Doff


