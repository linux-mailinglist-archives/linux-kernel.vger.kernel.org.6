Return-Path: <linux-kernel+bounces-282757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 844C594E83C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72F91C21033
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 08:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8EF6165EEE;
	Mon, 12 Aug 2024 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="iXmSZ46R"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130C355896
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723450014; cv=none; b=jKV1ptfBUWC5hMc2P+hm+VYDfUWSimxtLsNIJKWXYurbNrlhYTFZVCCJMXlAPcHdkb88fzvrqGmt8MD/mceAJZj0TM89HxQmJfkk0lTGdEkqOMFtjQXxCzeWq42TBbBAta79YM/cymN5gtoQgaq20ui49hhd5nSE7q/ELtwoE80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723450014; c=relaxed/simple;
	bh=DOoOQx4Z+F4cPNHsoNoRm9Q1WHZ02gSqCQeTrV7Rd9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I0lJMknDXosrJr8lB6Evu975E8mZ5BPBpS1QpvvfSx3hpnCPRTCqvbde7mkBfqXuGDSUsyPC718NlFR6UlRiTSbDTwKyEP6IH7oBAM0IOy5sgkhfgCWtPBxeYpN5L6ex2MyuFFqpG5g4FJ3+/53yRgdd9CIfhXIx9P3QbT1buAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=iXmSZ46R; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52f04b3cb33so8089436e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 01:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1723450009; x=1724054809; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DOoOQx4Z+F4cPNHsoNoRm9Q1WHZ02gSqCQeTrV7Rd9I=;
        b=iXmSZ46RKXEI/Cg9w0xE2WMaWxeNqMtY49jbO2eyV/Y0BmzS9+JBFuY2hGsi7O79Pw
         8nBDpkZMSjK7PD3jHVqv8dp9rAUVBppCgAbFQnbwEFl0pAL8vYgJMgr+ZUk2ii8stO9d
         T62FH7nXzupP6aTDX56zZJOw9NWwlFEMezfQbdNkfpeegbdwKVLN+eYFh2GtbS+7M62p
         +vD9tLVhq6+5C4mqy1K+AW02+ECjdyQk5br1SlEzo7gYYBZbMoI6ztlEuubtGbXouHUF
         QbkCu4N4cfHGVZ094SmTtOSK73RidbCyQitLgB+yEjq4x1M07tQzD3fz5f9nucOkZXyt
         BGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723450009; x=1724054809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOoOQx4Z+F4cPNHsoNoRm9Q1WHZ02gSqCQeTrV7Rd9I=;
        b=D9yrBO55v+duCW7LKVdPjaOJVeBJdhgpaHkZ4sqyj7hZ79cXNz2JUwOhweZ6vS7V1b
         qWmx6Ut4P8PVltApCIxq5PUmYWarxFte1YD3mrfMMGxQR6wMPfRxm2rq2hAa1FMPWbxG
         oi4UaDmqIaQpuatnTrSIxdFV5A86anhQn7qyf6KR/TYbmHYIDB1Vyy7r3QIPsfl7D299
         qXyQCAwvCPcuasbsw+m2qQwGZcO/o9ccpUHbubyZvbqOZg87HBJK+q9q0fm5h+MHxgFQ
         6ppWp56qDlBW9Dh/5ic4RMX+rG26OMkbExm5qsx/zGVhG5M1kyPiAhoWcZ1ryaOOS/Ti
         E9tA==
X-Forwarded-Encrypted: i=1; AJvYcCVdM24DlRjRSjoEkG4F5k5Exw88XYoUlsoH3j6bpII0lXDiQywJ7peZNVDqHoJyHHsNivhjsv6yJ8pzFF7153IGwQOAQu/240ZPVP8l
X-Gm-Message-State: AOJu0Yyfc7mL5PFICz2vmkyfHE5jety1UILBpNCA5BObepuSu3HHQVsX
	Dpz0JcoYpDCdlH6OTzjJrodXjqnYDkHykDZOQqLSLbDWhDApwKST2M0Gxt8/EuCANAnJiRqE25e
	w0cnHBxh5zCamUVBAh+yBmctj2oYNBvJwnEj5rmqHRZOrgSSz
X-Google-Smtp-Source: AGHT+IEcSrvOCxR2Io0IaG3hiKNApuVnlc4YuE8loAyRtTekAMet03uPGmSaboXnXPb2sNrJZ5cuB5z3bCg9KXmGZnQ=
X-Received: by 2002:a05:6512:1251:b0:52b:be6b:d16a with SMTP id
 2adb3069b0e04-530ee999edfmr5980685e87.31.1723450008881; Mon, 12 Aug 2024
 01:06:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+8cD2CBcaerhwC0i7e0O4LU9oQg1w3J5RsV6qcZMEr2Uw@mail.gmail.com>
 <CAJuCfpGa55gpKHBE_0mwRPsf0f1Wp5UK7+w6N7yZi-7v31vNzw@mail.gmail.com>
 <CAKPOu+-DdwTCFDjW+ykKM5Da5wmLW3gSx5=x+fsSdaMEwUuvJw@mail.gmail.com> <CAJuCfpGDw7LLs2dTa+9F4J8ZaSV2YMq=-LPgOmNgrgL4P84V_Q@mail.gmail.com>
In-Reply-To: <CAJuCfpGDw7LLs2dTa+9F4J8ZaSV2YMq=-LPgOmNgrgL4P84V_Q@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Mon, 12 Aug 2024 10:06:37 +0200
Message-ID: <CAKPOu+-8DXbCSj1OiWbS6+MuGPN9-kgsFkWn=hvr2cFwaDEEqA@mail.gmail.com>
Subject: Re: Bad psi_group_cpu.tasks[NR_MEMSTALL] counter
To: Suren Baghdasaryan <surenb@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 5:56=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
> Hmm. The original scenario I was thinking about when I proposed this
> WARN_ON() was deemed impossible, so I think the only other possibility
> is that the task being killed somehow skipped psi_memstall_leave()
> before its death... Did you have the instrumentation I suggested to
> track imbalance between psi_memstall_enter()/psi_memstall_leave() and
> to record the _RET_IP_? If so, did it trigger at all?

No, unfortunately I did not have the instrumentation because I don't
know how this works (and didn't have the time to find out). If you
have a patch for me, I can merge it into our kernel fork so we have
the data next time it occurs.

Max

