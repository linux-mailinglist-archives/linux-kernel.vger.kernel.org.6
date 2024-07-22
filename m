Return-Path: <linux-kernel+bounces-259454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B59939673
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 00:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F4E1C2189D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF013F9FC;
	Mon, 22 Jul 2024 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1JOpdc8i"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9473E1B960
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721686812; cv=none; b=op7/7fazpNKRYbVgSJR+8XmnyyiLRNhWrFIvnDPgbYa3LYy7Tb20cwsoAEAFw+tyqJp5GY9r1HL/TS0OjRt/rjC9Z9O7cSZuJuPG1rT9ZwDICWGCk0DIGzkJIGsj6GhWPVwsNfxIp4O8Q4f+RjFZjSBztkOSeheGIDQN+zQc02Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721686812; c=relaxed/simple;
	bh=9xGnHY9spyfYZd0BxhANAb92E0Ku/QgzaJCPGqLy3/w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FyrzbfO5FaPM40LwnXzaQDMM2h8ny4YBdzpWhpXvgSR6O867fTYaxpFz+cHhsJKmE5qPSsATmA+tpYSH/h/MbSAlx+jrrWKjeGhbwLHBmqI3fVd5XTF7aTJBLlMUFCa3yxTpaJ2MYbT2Fux4Ou0qOoyQujF433uW2yFussSdeRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1JOpdc8i; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fd643d7580so20675ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 15:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721686810; x=1722291610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9xGnHY9spyfYZd0BxhANAb92E0Ku/QgzaJCPGqLy3/w=;
        b=1JOpdc8idw2NtA4SWZdA523gd6exx6420E90ay9ZCQesjXMq28ijyRWNQ+AO1Kd4e8
         YhtnFOz5iu47vSsY1R7/feV3dmz80Bgv6Q+zC+V3hsZTokx1KrL0DUueYi8Msw5v/352
         Q458JPRAqN89z15hCBLDCRAwbGK88sOIHn9zqReU/G63sHu+ygHVGeV2To3cHtSGnYsr
         60tvv54ZmOpSd0zk88vWp+k9T39JSpOz0LxFtd1Jw0S7h7IXEyyHYQEIxFOYyxBzigHZ
         0xxu2R77Y8cVA9LUXu5MRt4OLqs6YxOM3eQ3BqW/Vfh0kS3RUbIq3B/0FV1ACFSsX0Hk
         HVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721686810; x=1722291610;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9xGnHY9spyfYZd0BxhANAb92E0Ku/QgzaJCPGqLy3/w=;
        b=aWt/bH4wCR1CyNI9rFgUOyYqbA5XAgeVblgiH7bpshfYhKTzxtcT8zJxGAue/otB7s
         yLh4+WdHHsvoriB0p0AWe7WmRSUm45nRfQJMjT/fHeloH6hYIPSZpKn9HtJ92tiBDgl5
         XyR89mfs7t4A/xGqvG9+20/WglHWGNyCdwGsOfraRgbJ5aCbMqrYLF5DiKFWekKnZjmF
         LX56i/tj7K+iAqdlVOKCL0d6CtIAlNEaTFsixNV9YooUup/i/iXK5099BlpVno9PpsHr
         OoGIBSGjG4mOktvrLmVXrf2UGeGuwIony930VvBiiRX1SSC8Mg7/3lygqpkvAQ0661Qp
         ZOiA==
X-Forwarded-Encrypted: i=1; AJvYcCWYt/QPjKYQiF1mgM81XJHLtcP6OvoJPutubcOpbBPv9GwCRXAiFds9z9P7AM1pKVqIv2hksc9tCpiF2VyYQZkqqkEh5a0RT4lDrErz
X-Gm-Message-State: AOJu0Yw07iFRw9Cq2eNnIrs4ZLzHw0IkVDKM7VE35A5AqPlkMoYmXjo7
	yo1NeT4XuAoMRWskTDwano600Cq5eAQoeO+NTRJ5JQZk4ouI63P38c5w3U+PUA8nm3uoNOmPuhs
	X7tHJ
X-Google-Smtp-Source: AGHT+IGwwO1HyFKBIWTI2FRcHntTVKzvrrwc4JAYD/j0vrdjs/bYf8tbDHYKh3dBhHkmG2ni2S/9Zw==
X-Received: by 2002:a17:902:da8c:b0:1fc:72f5:43c0 with SMTP id d9443c01a7336-1fd7a2087b6mr5972215ad.24.1721686809504;
        Mon, 22 Jul 2024 15:20:09 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-202-176-14.hsd1.ca.comcast.net. [73.202.176.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ccf7b2c6absm7575751a91.4.2024.07.22.15.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 15:20:09 -0700 (PDT)
From: Benjamin Segall <bsegall@google.com>
To: Zhang Qiao <zhangqiao22@huawei.com>
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>,  <mingo@redhat.com>,
  <peterz@infradead.org>,  <juri.lelli@redhat.com>,
  <vincent.guittot@linaro.org>,  <dietmar.eggemann@arm.com>,
  <rostedt@goodmis.org>,  <mgorman@suse.de>,  <vschneid@redhat.com>,
  <chengming.zhou@linux.dev>,  <linux-kernel@vger.kernel.org>,
  <joshdon@google.com>
Subject: Re: [PATCH 1/2] sched/fair: Decrease cfs bandwidth usage in
 task_group destruction
In-Reply-To: <5607f1e2-b235-4eda-a9d9-2e9519db3f74@huawei.com> (Zhang Qiao's
	message of "Mon, 22 Jul 2024 16:16:12 +0800")
References: <20240721125208.5348-1-zhouchuyi@bytedance.com>
	<20240721125208.5348-2-zhouchuyi@bytedance.com>
	<91e88019-52f7-4fa6-a14b-ca5ecb8e63cf@huawei.com>
	<d0918be2-8d4e-427d-ac98-32aecffe3a3b@bytedance.com>
	<14c3db2b-5de2-4f1c-b4d4-6183568b8c24@huawei.com>
	<e4e3a63d-a5f2-4c1d-a9da-4ddbc3693450@bytedance.com>
	<5607f1e2-b235-4eda-a9d9-2e9519db3f74@huawei.com>
Date: Mon, 22 Jul 2024 15:20:07 -0700
Message-ID: <xm26ttghysq0.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Zhang Qiao <zhangqiao22@huawei.com> writes:

> =E5=9C=A8 2024/7/22 15:46, Chuyi Zhou =E5=86=99=E9=81=93:
>>>>
>>>> Thanks for your information.
>>>>
>>>> I think maybe cfs_bandwidth_usage_dec() should be moved to other more =
suitable places where could
>>>> hold hotplug lock(e.g. cpu_cgroup_css_released()). I would do some tes=
t to verify it.
>>>>
>>>
>>> The cpu_cgroup_css_released() also doesn't seem to be in the cpu hotplu=
g lock-holding context.
>>>
>>=20
>> IIUC, cpus_read_lock/cpus_read_unlock can be called in cpu_cgroup_css_re=
leased() right? But cfs
>> bandwidth destroy maybe run in a rcu callback since task group list is p=
rotected by RCU so we could not
>> get the lock. Did I miss something important?
>
>
> Okay, you're right. I ignored that we can't hold the hotplug lock in an r=
cu callback.

Yeah, cpu_cgroup_css_released/cpu_cgroup_css_free are fine I think, and
I think it should be correct to move the call to destroy_cfs_bandwidth() to
cpu_cgroup_css_free (it's unfortunate in terms of code organization, but
as far as correctness goes it should be fine).

As far as the diff goes, the _dec should go after the
__cfsb_csd_unthrottle loop.

