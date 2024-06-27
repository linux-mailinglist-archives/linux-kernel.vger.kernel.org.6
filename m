Return-Path: <linux-kernel+bounces-232737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5767791ADCD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 19:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 879B21C25FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 17:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8C819A294;
	Thu, 27 Jun 2024 17:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iZ+OAvjj"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C0C199225
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 17:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508670; cv=none; b=UwjNZHLJ5VSFujiblgQPcizK6VQ9jAe/mICwgWEAJ8bpMQhxfMwm51Z64KwQzU1GWw1BKBwLTStcanYgytMPeOHnFslnDkOJcIgd1Pt+x5YeXSJo0V+5rh6BPcAw6aIvD/xbORLWUxV+E7zQ0QLM51veb7+5rrltshioIrBczbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508670; c=relaxed/simple;
	bh=BsuX0TwL2xAavumghQ/V7F80KHhaFw7bJmljx1r1XKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zl7lhRdSlM9K8GRjSFxpnqzUGVBvtzEIxYM7gkfZp5Un6CDlyzCMQJbJQhKZps/MCbUj8xUVCOVL+RkHme9mNS4BwPFJ7//8t5CBo4uEH8DxgMeS4HpOpj+olNObjwneyfQe7DsnmcIoakSwWiE7D6VKU+Bbtmctva1TT1R5LjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iZ+OAvjj; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-37624917c2dso5965ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 10:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719508668; x=1720113468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BsuX0TwL2xAavumghQ/V7F80KHhaFw7bJmljx1r1XKg=;
        b=iZ+OAvjjyM8wdjrQRP6tOy6Y5IUsT6RU/E3/zb/Dtd0QK/UDde55C7N0FyIY1rUUtk
         QiiCPwrD50306mf/fbETCkMpwXQb7hwpeWGLDm0j8P4t/78thB/Fu2xEAfjlvjAui1kU
         CMj+j/jBfj/a5XNYIX9yfj7lZwBs56riGdz/wrnTNRFFq4Tku7HnRgKIFpM55RxAf3qg
         QqNgJ5HOYDu4o8Ix8xAfb3XJ3sdvdRQvRFkoHtcDrhSNabUISnOpPj/1qB3iK9cOXKJh
         oFOKl6dZt71yJkV1COyjmQcoJxbcU2ne9biNvFEmS5n329rGs1B437T2p7X/KrCguXfX
         nzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719508668; x=1720113468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BsuX0TwL2xAavumghQ/V7F80KHhaFw7bJmljx1r1XKg=;
        b=V7BHG6JKEmjJC4B49BPbBzSU9KoKriBm28w4h4UIvIOkooTaG7UtDh6JTtKIQmTcWI
         2zrFShn6iKhDiqvHAfU0AD+s9v/HLFQp2Ljx+lzM0axdtKg+LkOawK52okAvSmB5IkuY
         cAcP+JKXy3WC80JKypGkEi9F2N5mVCQGoFbvj6uTOJ4XWtm5yfeQqZuK9JwO7nME/6AF
         2vtq/QugNJpvXL1UgNoUhFQEFgfrWzn6GEXqG8jb6OTBYdGBB8mN5PQ+HgaK6GV66/s/
         GtswzLK5pThPxOncN94PQNQhMTqOsX7PH48UU9oNtSFMEP8rcb4xQOZax6JrbW/ShBl/
         cN7w==
X-Forwarded-Encrypted: i=1; AJvYcCUilUfl0nADCAh9TJO0DU8kfCtcyoYX468AVZR3FCBPq3+JAiMFJ7EAR7E/m8flh9054KOofVpPmV0EszOQo5DRe8bhqD++pnNnSUeV
X-Gm-Message-State: AOJu0Yzev3D7drXNoTcSjIKDvCfYa7m3ljD58T3qi7PDZMeinxrDkapk
	12AaiuSTv0N+q2nr51W+1LhueLv/ZbTUzK7KypPkz7ZdZvdKf+Citfv/+nUI0DkyeLzBCgytnCt
	NdJSkkbHFf8zSMJgvccN5TbMNmfdi36PvM3Jm
X-Google-Smtp-Source: AGHT+IGvAgYSYBE307LmnsDUtRzN58DFq1f8GNu4AQnc3KQ2F0CVbN+2P2lh1gtRMhbEOkJmZIB8Y5W99gnsBV9ZJwc=
X-Received: by 2002:a05:6e02:1b05:b0:376:38e3:634b with SMTP id
 e9e14a558f8ab-3795cb30446mr3980715ab.12.1719508667569; Thu, 27 Jun 2024
 10:17:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627133743.407048-1-adubey@linux.ibm.com>
In-Reply-To: <20240627133743.407048-1-adubey@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 27 Jun 2024 10:17:36 -0700
Message-ID: <CAP-5=fWyDXFPi4Jn1PYTbVCRO_f_8gcp6aaB10=6CfqDdXgkLQ@mail.gmail.com>
Subject: Re: [PATCH] Perf: Calling available function for stats printing
To: Abhishek Dubey <adubey@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, naveen.n.rao@linux.vnet.ibm.com, 
	mpe@ellerman.id.au, npiggin@gmail.com, peterz@infradead.org, mingo@redhat.com, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chu howard <howardchu95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 6:37=E2=80=AFAM Abhishek Dubey <adubey@linux.ibm.co=
m> wrote:
>
> For printing dump_trace, just use existing stats_print()
> function.
>
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>

Thanks Abishek, the change looks good but it needs to be rebased on
top of Commit 411ee13598ef ("perf hist: Add symbol_conf.skip_empty") -
https://lore.kernel.org/r/20240607202918.2357459-4-namhyung@kernel.org
. Recently Howard Chu wrote a guide on this:
https://sberm.cn/blog/how-to-contrib-perf

Another small issue is the commit message should be "perf report: ..."
rather than "Perf: ...".

Thanks,
Ian

