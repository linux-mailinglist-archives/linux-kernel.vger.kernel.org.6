Return-Path: <linux-kernel+bounces-572845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A8FA6CF4F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 13:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6158A3A8664
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Mar 2025 12:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870A9747F;
	Sun, 23 Mar 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2YbYrjH"
Received: from mail-ej1-f67.google.com (mail-ej1-f67.google.com [209.85.218.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B8E17D2
	for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742733966; cv=none; b=jFRZXsEjCFPM3fHLiSMECSWnPaouXWlzMue1IoAn6escImxfazd8DZf97GOyJKtRnmY03RIInLQe3i7J6mQc9dx0B8KycSm2Jk+VaZ94WKkNXeLUWZXvtZvAR42Ev1A68LBP3sqKZ+Vq4m7sMR1mC5Unlig14SIfnAvgox9fyPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742733966; c=relaxed/simple;
	bh=AocQ2VXeWvU5KCRHIhA5Ihkpawng3E317fyd5EjlioM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=SfRMfbN4N1PDqPuuFlvBT3uXEDI7NEtIONBx5Dv2ysvgbwQjlP/DinU7mcx0tq9OkDXU3NJ5HxIFUAdYkM7oN7UWO3r1FdYFL0x3h2vDyg/gd/WfJxSuzXNnoSIU3TF6E3Up4z2SF0Hnc/hjdMOlaLCM9aw7MPwGmmT6EmlqWEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2YbYrjH; arc=none smtp.client-ip=209.85.218.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f67.google.com with SMTP id a640c23a62f3a-ac25520a289so634076766b.3
        for <linux-kernel@vger.kernel.org>; Sun, 23 Mar 2025 05:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742733962; x=1743338762; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XewGdysPg/vedgjcYLBowRjsqjB3Wr1D9cj9ENdt9/o=;
        b=m2YbYrjHrtAw21i8hsZtrTt17ATpT76S0pVouQVvsfpbiN9MHN+SmCo4fk9F1/a58q
         zv8qKk+fjHAHeg3tWeD717lilIGvrSLZAE0w8Xtsy7ZJx9RKdlr08V+mLnBQMJWjwaPm
         tdiXxVLthR6Y9NkOXhFETLeYeAuaILpD6YxLsqdxLqj+NK1JJKmrP5qXdGv3lwBkT42X
         eQmdhUqTVD+s1bzq6h4UEp5/tFbhbqnxTLQ4onvl1PiF76ZZAw7gFXAKn2OhMDjma9du
         k9oI0aFKyOmMP40WIks0ifsRTx0sFf/ZfsuYUYbP6TxW7IybP8vDj0hY9ar1fLIzo6p9
         ZqHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742733962; x=1743338762;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XewGdysPg/vedgjcYLBowRjsqjB3Wr1D9cj9ENdt9/o=;
        b=riLecIT/1CGvosbqUCL3xWbY0qZWmRkpoD+9cUFp6YLMpZivFGIccfQ+G3xb1Gs+fp
         lg2413Lx8q7RJXvQNq6K1FIcSJTGLqJfKzLk6cVRI9Czz/ITTLIZL8KI47D8buDioWBN
         9tlTZ2ppnLplmgs7bKmEOud0NM4w736gCKI01WDqCxudIne8D8F4ZGmy/uwBjtXPP0Bq
         56cq0pu7B6gGmysrkHQScHvThVfBgGe0omMHbMp4HoEGFU0m/BwyD1UFb6EFhtvtn94l
         EeX3RQx7b0PG36ZYoZiv6cJddcdPWaZosNVX3XzF0O6050EHSA/T+g8zTRxmMGQZvCC+
         NR/g==
X-Forwarded-Encrypted: i=1; AJvYcCVVexTL2GBuQB4ssVJJWJDVU5riwwUiwrj42fy7l5n/lEDltYatc8AiVUXYoTdb9NxhvHCejaMBW6RQZFk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTqmlr3cjpO+tPs3NO51m9jccZnd73kkXEo1Kw9SM2C6c0eBTT
	vANzkLU7PUs8pErrM/5lE5GFmo2SXx1BT0v1iUgY/oAjjmqTuIRoZZcqmIRbFTrzPXorUli4JDu
	SQUFgViocSr3visF9LPYmmEiZg6Vo0SW0AXU=
X-Gm-Gg: ASbGncvTo/OIFbRih1STUOrj8mr1dtijeaEZG/RrMMx1ImpkOK3BcFWU1ASIgD8tZWm
	1lEMZ3u579nyLodP+1LeP+bV75oom2B3jJlW6o1DITdNzZtHQMIkWIMqZRxUw8HF36yOsLTcH5d
	XPXAr7e7RATbFPubAqxIvFtLALygr0GxuGOAp8pQ==
X-Google-Smtp-Source: AGHT+IHscydsvv4RIOvJdrSmd2kAk/Mod6/iOSQib4zejNz/W8kXCfiSAtHP9mCl/NxiXxCD9EGBRwLWg5CttYZMJHA=
X-Received: by 2002:a17:907:2d08:b0:ac2:e748:9f1c with SMTP id
 a640c23a62f3a-ac3f2267455mr890786666b.33.1742733962219; Sun, 23 Mar 2025
 05:46:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN2Y7hwHWFpVRL3ZTSmKn2CGtixDBdszxofE4DSUx0rAOeK41g@mail.gmail.com>
In-Reply-To: <CAN2Y7hwHWFpVRL3ZTSmKn2CGtixDBdszxofE4DSUx0rAOeK41g@mail.gmail.com>
From: ying chen <yc1082463@gmail.com>
Date: Sun, 23 Mar 2025 20:45:51 +0800
X-Gm-Features: AQ5f1JqlbCMTNnO81bBnjYu03Xd3Jox0EFgYrqwNVUVLiDQGDD8sXCLOKy0k-So
Message-ID: <CAN2Y7hyM6pAupptUZx-cQsbTimxYSYKinyrSGBLYq5i3Dbxmgw@mail.gmail.com>
Subject: Re: [bug report, 6.1.52] /proc/loadavg shows incorrect values
To: "mingo@redhat.com" <mingo@redhat.com>, peterz@infradead.org, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, linux-kernel@vger.kernel.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello everyone. Have you ever encountered a similar situation?

On Tue, Mar 18, 2025 at 9:54=E2=80=AFPM ying chen <yc1082463@gmail.com> wro=
te:
>
> Hello all,
>
> In our production environment, "cat /proc/loadavg" shows incorrect
> huge values. The kernel version is 6.1.52. So far, at least four such
> cases have been found. It seems to be a kernel bug.
>
> ~$ cat /proc/loadavg
> 4294967392.49 4294967395.80 4294967395.83 87/16100 2341720
>
> top output is below:
>
> top - 21:12:13 up 191 days, 20:50,  1 user,  load average:
> 4294967397.45, 4294967396.82, 4294967396.15
> Tasks: 2388 total,   3 running, 1208 sleeping,   0 stopped,   0 zombie
> %Cpu(s): 27.9 us,  6.7 sy,  0.0 ni, 57.3 id,  0.5 wa,  1.7 hi,  5.8 si,  =
0.0 st
> KiB Mem : 99966995+total, 56704217+free, 22655678+used, 20607096+buff/cac=
he
> KiB Swap:        0 total,        0 free,        0 used. 68817177+avail Me=
m

