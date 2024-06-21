Return-Path: <linux-kernel+bounces-224453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0219091229F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B076C28AFCC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20A9171E4B;
	Fri, 21 Jun 2024 10:41:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33573171679
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966465; cv=none; b=bjJg+GQtOJUIXljF/CEy8dfh4FJWAFwHTplkNkpcfDlacpd/eGBdSRAilFpUCbT9FC3mp5ubfph/kt0yKJOJKkvZmqLzlEIwF0MzcQuJYciysaPWNL1GUDCvbcKedR3G2mk6DQNYnJNyzUiGqpwsEMurKFWbehbz3OQhUFmkt/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966465; c=relaxed/simple;
	bh=jzgGmfqFlVTZEJS9ofU/g3n66CmBRlAAwZHE7eoCQoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oqynJFceD2PnADH5kQ+bV3A/CP1xkiz2xiahdVmGf/jxPL9U6LzEhw93v/IxLErZn6/B+qr3XJo27yWUBYUUqGccmhXNIScwPwXMXoYT7zqgCiPz4jh8oew7nYvLzJqTktioNylEtMKAghUBIb+l3B312af+SwLG2YoN7ByU/JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C220DA7;
	Fri, 21 Jun 2024 03:41:27 -0700 (PDT)
Received: from [192.168.178.110] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30FD73F6A8;
	Fri, 21 Jun 2024 03:41:00 -0700 (PDT)
Message-ID: <8bfa0628-bd74-47c3-ba3c-4724acbfd717@arm.com>
Date: Fri, 21 Jun 2024 12:40:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Prevent cpu_busy_time from exceeding
 actual_cpu_capacity
To: Xuewen Yan <xuewen.yan94@gmail.com>, Qais Yousef <qyousef@layalina.io>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, vincent.donnefort@arm.com,
 ke.wang@unisoc.com, linux-kernel@vger.kernel.org, christian.loehle@arm.com
References: <20240606070645.3295-1-xuewen.yan@unisoc.com>
 <20240609225520.6gnmx2wjhxghcxfo@airbuntu>
 <CAB8ipk-9EVgyii3SGH9GOA3Mb5oMQdn1_vLVrCsSn1FmSQieOw@mail.gmail.com>
 <20240616222003.agcz5osb2nkli75h@airbuntu>
 <CAB8ipk-ejDKQTr8nAmK9MkhL2Ra=0J==p3Q+U-4K18G6MeJhQw@mail.gmail.com>
 <20240617110348.pyofhzekzoqda7fo@airbuntu>
 <20240618145851.je4a7cu4ltrt3qxa@airbuntu>
 <CAB8ipk_LXzkkGzT1SS6U8i4nW6j9coxeuwn6vuUFusCQcFM8zw@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <CAB8ipk_LXzkkGzT1SS6U8i4nW6j9coxeuwn6vuUFusCQcFM8zw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 19/06/2024 04:46, Xuewen Yan wrote:
> On Tue, Jun 18, 2024 at 10:58 PM Qais Yousef <qyousef@layalina.io> wrote:
>>
>> On 06/17/24 12:03, Qais Yousef wrote:

[...]

> Sorry for the late reply...
> In our own tree, we removed the check for rd overutil in feec(), so
> the above case often occurs.

How to you schedule hackbench on this thing then? Via EAS or do you just
exclude this kind of workload?

> And now it seems that on the mainline, uclamp_max is the only way to
> override this.

[...]


