Return-Path: <linux-kernel+bounces-539862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D99A4AA06
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 10:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCC313BAEEE
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 09:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BE71D5CD6;
	Sat,  1 Mar 2025 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="He9JIc/A"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D96E1C5D53;
	Sat,  1 Mar 2025 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740821197; cv=none; b=gLs6/21/RZHSoassXWTlYQU8z1mFzOzecJ1yT8MiFbu22ZhZUUzR4jJxdoma1jJYwCslubVNqKxNbrN3Rp77JUuGQC2FZJqU1I6z6A97bN2tasNIeihg+KzvFaFwZMUxeM/ljpDemm2O/wbwIRs17MnsrtIkonzkuE7/mphNkZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740821197; c=relaxed/simple;
	bh=xj3Lz8WBzFiFygw0thjUTod3x4QweCN4bqgMTqEDAW4=;
	h=Message-ID:Date:MIME-Version:From:To:Subject:CC:Content-Type; b=A0cQLtH06qoczHtakbpgnIeQY0oaVtyJFEJ+QS6ej3vnmKhlJQoVRA03fC8gWuAq5ZY1Pi050/6FNTNcBcqCgR4lgeb3fjtdmcn8gzuwJ1M1lTKsbFmQ+CAGbmynEQ90tMlNbc6pziUh72q7bzVOAG60f/GMjp/KZPdFcq+DZ8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=He9JIc/A; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5213MEIB026214;
	Sat, 1 Mar 2025 09:26:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JWt/NUZknguicuHAF8RHXu
	mJkmwTavNNZclJ9Mzp8Gw=; b=He9JIc/ADg0T6QobxsJt6aoFO2EeO/ewv7TBap
	+wAqLaHntq7kcGtyXDtqzX+uYN4M5oe8HaG8/irhRN/PT6erAYCNzxxdDIeoHMoD
	D2fzWvJtBJky/odB+BesIGdxWGozZpEhjk+jFYsTD0qCPu+i/OSWru2xp9ZgS2Gk
	z9OQTHN+DCdLxxrOjNjNGPSlAotwgNPN+9ptneAPHh58U5m8NgUFJtAadRkbY4Yd
	CV3OJHfDk05/qcbYcFXmrWso8qqLf3uU/mYU0UYvxhlmtdRQGeVxKIYNvA2l3EZa
	8yN09WJlwM27JLlkVEOcC8YEEGYMzWhLK/H9hzopLR5wGG4Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 453t95rh8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Mar 2025 09:26:24 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 5219QNsg020032
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Mar 2025 09:26:23 GMT
Received: from [10.253.39.67] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 1 Mar 2025
 01:26:21 -0800
Message-ID: <6610cdb8-072e-47fe-b9bc-f4f5b9a79f8e@quicinc.com>
Date: Sat, 1 Mar 2025 17:25:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <syzbot+4cb9fad083898f54c517@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [sound?] BUG: sleeping function called from invalid
 context in snd_card_locked
CC: <linux-kernel@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <perex@perex.cz>,
        <syzbot+4cb9fad083898f54c517@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>, <tiwai@suse.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lGcwiKanQM3vAQ4yvCKzWdn1bTcS1mZM
X-Proofpoint-GUID: lGcwiKanQM3vAQ4yvCKzWdn1bTcS1mZM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-01_03,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503010073

 > Hello,
 >
 > syzbot found the following issue on:
 >
 > HEAD commit:    d082ecbc71e9 Linux 6.14-rc4
 > git tree:       upstream
 > console output: https://syzkaller.appspot.com/x/log.txt?x=14e3d7a4580000
 > kernel config: 
https://syzkaller.appspot.com/x/.config?x=8f2f8fb6ad08b539
 > dashboard link: 
https://syzkaller.appspot.com/bug?extid=4cb9fad083898f54c517
 > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils 
for Debian) 2.40


BUG: sleeping function called from invalid context and
raw_local_irq_restore() called with IRQs enabled seems can be
fixed by below change. if it is valid, will arise the PATCH.

#syz test:

diff --git a/sound/core/timer.c b/sound/core/timer.c
index fbada79380f9..5290c1b9f2b8 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -767,6 +767,7 @@ static void snd_timer_process_callbacks(struct 
snd_timer *timer,
  {
         struct snd_timer_instance *ti;
         unsigned long resolution, ticks;
+       unsigned long flags;

         while (!list_empty(head)) {
                 ti = list_first_entry(head, struct snd_timer_instance,
@@ -780,10 +781,10 @@ static void snd_timer_process_callbacks(struct 
snd_timer *timer,
                         ti->pticks = 0;
                         resolution = ti->resolution;
                         ti->flags |= SNDRV_TIMER_IFLG_CALLBACK;
-                       spin_unlock(&timer->lock);
+                       spin_unlock_irqrestore(&timer->lock, flags);
                         if (ti->callback)
                                 ti->callback(ti, resolution, ticks);
-                       spin_lock(&timer->lock);
+                       spin_lock_irqsave(&timer->lock, flags);
                         ti->flags &= ~SNDRV_TIMER_IFLG_CALLBACK;
                 }
         }
@@ -805,14 +806,16 @@ static void snd_timer_clear_callbacks(struct 
snd_timer *timer,
  static void snd_timer_work(struct work_struct *work)
  {
         struct snd_timer *timer = container_of(work, struct snd_timer, 
task_work);
+       unsigned long flags;

         if (timer->card && timer->card->shutdown) {
                 snd_timer_clear_callbacks(timer, &timer->sack_list_head);
                 return;
         }

-       guard(spinlock_irqsave)(&timer->lock);
+       spin_lock_irqsave(&timer->lock, flags);
         snd_timer_process_callbacks(timer, &timer->sack_list_head);
+       spin_unlock_irqrestore(&timer->lock, flags);
  }

  /*





Thanks
Zhongqiu Han

