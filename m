Return-Path: <linux-kernel+bounces-378678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5F49AD3F6
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 20:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B0C1C20B89
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD7B1D0F65;
	Wed, 23 Oct 2024 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="l41O1iFV"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2E11BFE05
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729708175; cv=none; b=iwDdenn7+s3PH9JgZbIyLxgbo5FQL1yhBTY9Utq5aGfT9iXapjSWOrdQNdVoD0uUpHPkrScSvrZ4EoQ6huCGHKE5SjhUp2q09nQFwQDaMA7GNofpsxe06qXczME//el0FCRGC1E43arP0cY254LfCRXBNB+KZnnpXVSxuoToVRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729708175; c=relaxed/simple;
	bh=YhPnAykY09uvgHUZD+9d/UbZg3530EutzeGDcUlZqBw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sG1AOrUnAfS5KA7OQAyS1EAbnQlSKKJFzEw7x7CW6snzJR/7DamW60NCZm+ZVchjrzIDUHFItPCnyvKloUl9b2zYaXAcj/ET6llDhvfqLfNk+Baao3+UD1PsVipsPjzTLLD/EjQVTui1tvfGUML54240SpX8FeG5cvOFo4SURxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=l41O1iFV; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b155cca097so9815785a.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1729708172; x=1730312972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhPnAykY09uvgHUZD+9d/UbZg3530EutzeGDcUlZqBw=;
        b=l41O1iFVAutM2hz7AGWo/j6xOhU2PFxEx3MEZgiIdS1XCq8chZmIyY+pa137USSA72
         wBm4IkA64jiTRSMqaXveII1QTDyGbG361pd8P8q+P3Q9/12va0P/2LxDr6rxDoy4EjJj
         S953rHYLlQp6cDidA7++Ho7HkFeyDwoeXh2UYzwhikaMMfJtK/tCSr1EqdenurZjynxy
         L9o/xzIc52UvRHV6MAtS88SejRaNR+dFjKRrDq+u1D94aNnkYb1FHngQrY8u+TzKbEw0
         5LgxCA2TWPGcqqvixL4/vSbYrMqlMoQoFj3roXHKF6uhjjh7xJZ6GUQY8VUSCYnqhcBR
         2tWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729708172; x=1730312972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YhPnAykY09uvgHUZD+9d/UbZg3530EutzeGDcUlZqBw=;
        b=Bhy2pTkkE7qVxIjgFPoB8nlZB00oONoK2jW0PaFed1vJgrFQjtMuzyiOKuzQNW9gU1
         QD0d1qqVSuMJFSyrwlX84TuQgRgabz6+IkH8PGcdRm6ZXOe8sgaBJqDXvQ3YIFRnAUNR
         ijvDeRa9/NKddiPhiyuXKeMg1hZftoOYpHtctxfDJaG/MhM6drOd6Wdz+BCLGyULO1MR
         OpwSKA4NkGuRMvDlV6zQvlSIPfCrGmjEnrTYYowLcH1KkJaLretAHQTKrIhypcoKMkJY
         m7uqf3pLahvv1s6txOnwnrbcJ/4LNE1EQvRRrSFSHFJDKupnDmu33oEgJXDx3WgoOGoT
         lb3A==
X-Forwarded-Encrypted: i=1; AJvYcCVrXtpEScSwTXiKe0JUC+CtRTZaWeWtFUz5NCxpFgscdlHoP5gTBaRuNNj8uDi1eDKa5kgQT9+NDyqnWgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvVdF61HBGLbip12Sar2c1pvdlueDjW46q8E54g42aTjngBykk
	0coABA9j4KbZ/ut9MgKvJcGHId4INsYbjOzAR3g1N2dzHw2q3accMMfko0qKUnB1yrf0k7uS26Q
	gVhTmA1yKMQZuZNrhMqV+yTt23jeaT69SII/F7g==
X-Google-Smtp-Source: AGHT+IHN7Nn8TYgf6aogO4v+tavfp3Kp07Bk8F4db26KNztW0AXCpL0TnRtSVX9bTG1k+0/2LMpyl/hzTzQRoJaHQbk=
X-Received: by 2002:a05:620a:1994:b0:7ac:b95b:7107 with SMTP id
 af79cd13be357-7b175583433mr1343572285a.12.1729708172364; Wed, 23 Oct 2024
 11:29:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023170759.999909-1-surenb@google.com> <20241023170759.999909-5-surenb@google.com>
In-Reply-To: <20241023170759.999909-5-surenb@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 23 Oct 2024 14:28:54 -0400
Message-ID: <CA+CK2bD9UQsh8224QqTTAQ_Ybz23BE-DFeubLkf41psXBsMA=A@mail.gmail.com>
Subject: Re: [PATCH v4 4/6] alloc_tag: populate memory for module tags as needed
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net, 
	arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, 
	thuth@redhat.com, tglx@linutronix.de, bp@alien8.de, 
	xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com, 
	vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev, 
	dave@stgolabs.net, willy@infradead.org, liam.howlett@oracle.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, urezki@gmail.com, hch@infradead.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 1:08=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> The memory reserved for module tags does not need to be backed by
> physical pages until there are tags to store there. Change the way
> we reserve this memory to allocate only virtual area for the tags
> and populate it with physical pages as needed when we load a module.
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

