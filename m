Return-Path: <linux-kernel+bounces-185222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC3C88CB24A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 18:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED88D1C21316
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 16:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64324142E6B;
	Tue, 21 May 2024 16:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BpmA8xrY"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8FE14291A
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716309374; cv=none; b=NrxV54+i4ZNiUEeoo9GpxIKdikwRjObJrgvaHfX6DPTFAX7dffys0ZEWIeFfgE5+IVeg8U0R7P1bri9Nks5UvgsHcd3+9ZrUmqvnRfC3773KLfuJL35qUz/Loz4MpylL2ITs1AsSP1//KcxNISi4OK0qd1GBNa/JBv84+s3/9So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716309374; c=relaxed/simple;
	bh=N9Kg/pf8gYSS0qulg1Vt1ueNfM10M5TXHTQ8MBNrIoQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rJGclprDzpOgV3IVsTGsLlJ+1P3FQ/j9Rmqukefy1e6ff0oI+TiIyMzicCmhPK8Khban0usnxwS20YU1mSjwwToDRlmC4dCpTIDL3EciyHVp9rwXqvEv/mbfNU/tzpMnxA1BgjmfroV/6WgYAbjNG/ciZX9yRuuH8Z6vKhjVN8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BpmA8xrY; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso394929a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 09:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1716309371; x=1716914171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N9Kg/pf8gYSS0qulg1Vt1ueNfM10M5TXHTQ8MBNrIoQ=;
        b=BpmA8xrYvZSfC3crSH+m+P45E3KwGJ+iPajdirU1Ztb0Pw+tRxh522LV3c94onEI7A
         ZJR1pJRNkGKxNPib6s4WlOrpDin0Lednz3/7fJOwcZA+jNBhvoltCy3EUiujJ4GcDe4j
         oOTTk/giYecpZ2IwkAWqS3aQ2cF0wV6D8bAp6cjBwWS0NhBcqTXv9eWGWbCDtUt68aLu
         oZcn2hGVrM8VYhM9KKLU1s0KCA7/Begw2tg2II7cLEU3ztjsgMoljG6dWYuIVR4Qg9cp
         il43nvsTUaJw6Nc0GsVbX5Zudd5nbKyTQomOxskvGsxj9N3ovtlNrSsGWZfeHorZbIzq
         WRkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716309371; x=1716914171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9Kg/pf8gYSS0qulg1Vt1ueNfM10M5TXHTQ8MBNrIoQ=;
        b=u0L+fmMNHf2nXlIGN55J3UMDYieNybcX6W6lx5X8J3CyLNeEaXkuH30bgFmigOe/ih
         wO00p4lLSFePFpHjwm/WkzLT1EjGb6TM5nylMr3lla/3Q6qKicDDHCfQe5LRQ8MBU8lw
         NALquP0pDoNPLu1gEb35b1TtdQxic6FGWFQwU50Q2zR/NSKYqd8AC7dKW1bDer3Pdsds
         3Skj+qDi+fy+t8vqhqu9/uimd5jjI+zWtYW3IeFXYkQdR9BeXjmcYZ+80hzqGDbcbRTW
         GIz2DcElSo4/pG2HDvA6nYj9TZ9JSO8hjRHYzqCqHbGJyJAuNdt8dDQeFb+Ehd0u/KXn
         0VIg==
X-Forwarded-Encrypted: i=1; AJvYcCXHscCKLINGGAakvc1Y6gKqR73du1ENwocIJHRP/ZbXHye2pmm9bwg37GtFOXTklRK4nsX1dRjUmB+3wrgEBlND0DmHB2/nlnsrbFBd
X-Gm-Message-State: AOJu0YzsnW0eq0F1+RTDhx/v50tU68bnyiADYDbQu8gJjMIFMiPfkhhV
	9QE0b0oLOeSdVtMyX3vzfl2Sb3JmY9qCQ8Y0u2Tvl9Bx1oLiEZcIEOtN0exXUz02k2/eUpUac7i
	imJ5LgWgamaWYo4qI8Xgb8vTdjCnZYU0aKT1VpxjbWrbSoAQwwEc=
X-Google-Smtp-Source: AGHT+IEMRQf8n5hn5cwPOiLQmIwQ4FziPw3Hoz6DOA70lGfEPA68bFBNlgXxaaLUwATjW/Cx/n5mTBBy05z2xfdJbrE=
X-Received: by 2002:a17:90a:e7ce:b0:2bd:820b:7863 with SMTP id
 98e67ed59e1d1-2bd820b7aa8mr5509290a91.18.1716309370797; Tue, 21 May 2024
 09:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240520202045.427110-1-jmeneghi@redhat.com> <20240520202045.427110-2-jmeneghi@redhat.com>
 <f808fa46-e7c7-48e6-8c80-3d28efd0afec@suse.de> <595e5988-b94d-41ba-a233-f87aed55028d@redhat.com>
In-Reply-To: <595e5988-b94d-41ba-a233-f87aed55028d@redhat.com>
From: Caleb Sander <csander@purestorage.com>
Date: Tue, 21 May 2024 09:35:58 -0700
Message-ID: <CADUfDZrTjDUsu1eEXkmEsSGCXn5=y_KnLnFcz-NbO1DF+BEKBg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy "queue-depth"
To: John Meneghini <jmeneghi@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, 
	emilne@redhat.com, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, jrani@purestorage.com, randyj@purestorage.com, 
	hare@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 8:03=E2=80=AFAM John Meneghini <jmeneghi@redhat.com=
> wrote:
>
> On 5/21/24 02:46, Hannes Reinecke wrote:
> > On 5/20/24 22:20, John Meneghini wrote:
> >> From: "Ewan D. Milne" <emilne@redhat.com>
> >>
> ...
> >> Tested-by: Marco Patalano <mpatalan@redhat.com>
> >> Reviewed-by: Randy Jennings <randyj@redhat.com>
>
> I need to fix this. Randy doesn't have a redhat.com email address... Cut =
an paste error :-(
>
> >> Tested-by: Jyoti Rani <jani@purestorage.com>
> >>

Should be "jrani" instead of "jani" here also.

Thanks,
Caleb

