Return-Path: <linux-kernel+bounces-558494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2C3A5E6BB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DA0168AF8
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 21:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC591EEA59;
	Wed, 12 Mar 2025 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="cJjQqddb"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E41C1D5175
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 21:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741815534; cv=none; b=gL264a2twBZRr7RLtRdZEBlKpyWDaegJ7AtZ6dPp50L5/u7lVNqmWimT4YA5HyylgDMsezLT4kvEa1HIHzusm+cQ3POv/3Vs4/2wTDVpaAMeg+WEOERJ1iQcr9KoCEvG1VyVnxK3movDbxutMG654oP/6OIRRvnRl9ajS/45rag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741815534; c=relaxed/simple;
	bh=6anuPuhZI65nLwGImtSYd/5iadYR4ZU7PRVCuaFE5y0=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=A/vziX4l/4B9WKNTT3OAn+QxXp/eLg3XfouF5MCBWTMpOmMmYUCp086IkALojH3YBkTrWJI2o1KJICmCSUs9I/hJqPWP6TpbbJR0xmFeN7ACt3C9yA+4gt3SrJMPsbOF7FtH2BkTqivvuDWDCBM7+7Mft90q75yiHHBaepf/Xjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net; spf=pass smtp.mailfrom=telus.net; dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b=cJjQqddb; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-223fb0f619dso6011875ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 14:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1741815531; x=1742420331; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eaRBP1qnCUKn4YZbxVF1PC4/9GVadtONrXO+zQElEWQ=;
        b=cJjQqddbyFwuRFNYQPOdOFaxYD+3bkBWbA+yW1RkVz71F9cblSzFDRaSakS6xtVkUI
         OET+ubOmsnKKOz98Sd9oPWnbc6L9AOjG/bEQu1LIK/bOHVLDrZRmZQ188WKtl96aKCGk
         wPjB1jjJT1CGl6zMOj92khHk7eLvev9Hed+EwyPEqT4fcsLaY/NI+BkKTRZqyBr2XFsq
         +kjgnDChWN0T6Yl37LTqodGCvQeTgC4aQ1Lxs5K1f1ajBnWSSeUZ6+QyApjhxHxTBQbB
         83eSP3guh9b5wfkL4NcWms2hmDbBSbITZWNp8xX0jGm7Fk1gfTiydQZXLfxJrkiL7nmv
         Osgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741815531; x=1742420331;
        h=thread-index:content-language:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eaRBP1qnCUKn4YZbxVF1PC4/9GVadtONrXO+zQElEWQ=;
        b=GdBdZhzIN5EBJAhjjLT7NtCPF+Uh9aNKXBKgKfwCPijEtd5duWvJJaLvVb6Bp7Nioa
         Ui1i+45OyiLqJShezBIm/UFxJojj+22c7vT42usP4NN+kH9p2D8/JmpI4pNfDpYzSHbe
         Pq2KOKrx+Gk6tYoT/LCzp7374XjL26E7PlZ97HBUxgn5qwEtv0JymstZeeJ+/0Zm68bQ
         SfOAwY1RWhq4lKem2prGQDAosKbpC3lEck+Gd+VKU8BtMGPTVS85TuLXQ6L/Yk2gaLfU
         ZhrtE0TsmdUu27tAp5MpKSwyIxyDx9Eub98NCYdqJSJmKE0py/aHt2eed4T4Y8ZKEOCY
         R7Kw==
X-Gm-Message-State: AOJu0YxuJSjcWFcEj6wNV3mUqIcT3cnUcq9Jhch2JuIjc4kV7ufaxlsA
	ZSabxvrcIhUMipKMzjbTzooCXLrtNRNXbpTRm4p8MrFCuzCLuLb98mev901xVO/EJqHqtddnOWL
	i
X-Gm-Gg: ASbGnctYgpYaD2L74uK6tq8EEDsq9pYehUPR4ni8u3uCZBNCFHudcmDjPxHx5e8bhul
	oWFCFGzyvcjrlo9JJzp9z/EnhRLoyStlS24mtHuZ1b3YSGx8SqDx86c9XCZuhkCUaM+lxUpuFKC
	WCFw3pDET74ukV+m4hZ2Oe+7K5t73Vvt1+Ly4r0E/pVROomeplv2lLJceC5JLSe5L5ExIf9nfHP
	burnTd2DFo2QvvbwZVtOOn7b4qeTxR9PHTT+M2jwEp37PRnlqz3w1NNQ8KThlThxEd/VXk6tkQj
	DYhAJG49z4MOqMaBsTWneJrQWmoj6YPJBcxFj3G2zLnW03Rv6ywFOIOpZu3BYvPP6MI/Tao9W0H
	zheSS0ZHovw==
X-Google-Smtp-Source: AGHT+IHAwJ6Qionrbl82EKXjyRz4SM2yShjA4Xi9CsaWXetVfoMihmh5KSFBnFI6MmPe4kOOH5X69w==
X-Received: by 2002:a17:903:2d1:b0:221:7b4a:476c with SMTP id d9443c01a7336-22592e2d657mr116019125ad.18.1741815530821;
        Wed, 12 Mar 2025 14:38:50 -0700 (PDT)
Received: from DougS18 (s66-183-142-209.bc.hsia.telus.net. [66.183.142.209])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bd5db8sm98745ad.257.2025.03.12.14.38.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Mar 2025 14:38:50 -0700 (PDT)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Artem Bityutskiy'" <artem.bityutskiy@linux.intel.com>,
	"'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>,
	"'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	"'Christian Loehle'" <christian.loehle@arm.com>,
	"'Aboorva Devarajan'" <aboorvad@linux.ibm.com>,
	"'Linux PM'" <linux-pm@vger.kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <1916668.tdWV9SEqCh@rjwysocki.net> <4917ca35e5e0c7035f09c02d5080a69ed3e88c44.camel@linux.intel.com>
In-Reply-To: <4917ca35e5e0c7035f09c02d5080a69ed3e88c44.camel@linux.intel.com>
Subject: RE: [RFT][PATCH v1 0/5] cpuidle: menu: Avoid discarding useful information when processing recent idle intervals
Date: Wed, 12 Mar 2025 14:38:52 -0700
Message-ID: <005801db9397$266ddac0$73499040$@telus.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQD+BgZZG1yDo2pCGl+Ay1eM9EzyOwIPMwSptRqYRhA=

On 2025.02.07 06:49 Artem Bityutskiy wrote:

> Hi,
>
> thanks for the patches!
> 
> On Thu, 2025-02-06 at 15:21 +0100, Rafael J. Wysocki wrote:
>> Hi Everyone,
>> 
>> This work had been triggered by a report that commit 0611a640e60a ("eventpoll:
>> prefer kfree_rcu() in __ep_remove()") had caused the critical-jOPS metric of
>> the SPECjbb 2015 benchmark [1] to drop by around 50% even though it generally
>> reduced kernel overhead.  Indeed, it was found during further investigation
>> that the total interrupt rate while running the SPECjbb workload had fallen as
>> a result of that commit by 55% and the local timer interrupt rate had fallen
>> by almost 80%.
>
> I ran SPECjbb2015 with and it doubles critical-jOPS and basically makes it
> "normal" again. Thanks!
>
> Reported-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Tested-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

None of the tests I run/ran show anywhere near that magnitude of change,
and because it is not a free test, I thought I would try to create one.
For my "critical-jobs" test I searched for differences over a wide range of
jobs per second and workload per job. I found one significant difference, but
the opposite of Artem's SPECjbb results:

		load	seconds	total jobs	jps	min	50th	90th	95th	99th	max
menu-614	1	60		1174500	19575	160	470	620	650	800	1620
menu-614-p	1	60		1175251	19588	160	530	690	720	860	1600
							0.1%	0.0%	12.8%	11.3%	10.8%	7.5%	-1.2%
										
menu-614	2	60		1102431	18374	250	600	750	790	930	2600
menu-614-p	2	60		1111070	18518	260	560	690	730	860	1360
							0.8%	4.0%	-6.7%	-8.0%	-7.6%	-7.5%	-47.7%
										
menu-614	3	60		987408		16457	340	920	1040	1090	1210	7100
menu-614-p	3	60		1000063	16668	340	750	850	890	980	2390
							1.3%	0.0%	-18.5%	-18.3%	-18.3%	-19.0%	-66.3%
										
menu-614	4	60		914690		15245	410	1510	1830	1860	1980	3630
menu-614-p	4	60		927129		15452	440	11790	14920	15160	15400	95720
							1.4%	7.3%	680.8%	715.3%	715.1%	677.8%	2536.9%
										
menu-614	5	60		885468		14758	540	9680	11400	11800	15460	74040
menu-614-p	5	60		895095		14918	570	25430	30150	30640	31250	137830
							1.1%	5.6%	162.7%	164.5%	159.7%	102.1%	86.2%
										
menu-614	6	60		840939		14016	630	45660	52070	57750	84340	189980
menu-614-p	6	60		843512		14059	620	44750	52220	58750	85930	199990
							0.3%	-1.6%	-2.0%	0.3%	1.7%	1.9%	5.3%
										
menu-614	7	60		797438		13291	740	61420	68130	71040	101060	199990
menu-614-p	7	60		796645		13277	670	55630	63790	68140	98920	199990
							-0.1%	-9.5%	-9.4%	-6.4%	-4.1%	-2.1%	0.0%

Notes:
menu-614 = kernel 6.14-RC1
menu-614-p = kernel 6.14RC1 + this patch set
I am still on RC1 because of earlier testing, reported a few weeks ago.
load is arbitrary, but 2 does twice as much work as 1 and so on.
(for most of this work the load has been between 10 and 1000.)
Jps = jobs per second and is queuing task limited for these particular test runs.
min, percentiles, and max columns are in units of microseconds of job execution time.
For the percent calculations, negative is better.
The data is clamped at 199,990 uSeconds, so we don't actually know what 3 of the max's were,
not that we really care. It is more the 95th percentile area we care about.

I am not suggesting that overall the patch set isn't a net positive.
Just that I found conditions where the results are poor.

So, what's the point of this email?
With respect to the other thread "TEO as default governor ?" [1]
That is such a difficult question, as there are often conflicting results.
But overall, for my testing they are very similar these days.

[1] https://lore.kernel.org/linux-pm/d6de2118-eae1-4abb-818b-b3420732c82a@arm.com/T/#t



