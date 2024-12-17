Return-Path: <linux-kernel+bounces-448399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 766069F3F9B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 01:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF34B16436E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 00:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7DF45C14;
	Tue, 17 Dec 2024 00:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ub2CovJA"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7953A8D0
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734397113; cv=none; b=X4VCWH9XtfTo35SiCOXGnvXWj8hEEKcnoAOK8+bdCPQucK82P6480CZttUm6JNym02Db8Ja99N2xcvGSqGWX1nUPXSRGh6C8OfEWt6Gq1j4btEPGLt+caUuBX49aagCHNPh46oz1liOCTmwHHS1o2tkWyGys8lXeQwk4gS7qDOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734397113; c=relaxed/simple;
	bh=9hLxiFcAFu2TwOav6BII2qkjiKd5UnfCseBsehlGuYE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=R54xl0/y88CT7/4AYKcKIc4RG3w8oK7ldTJ6Wkm69LRR7q7ZR17WtCotmVhsyrt7l8KzUu3yhs5llSVs7UgH5OU5R2FJTC7//pnMamPAWgVeX8aMMEONPCxJkjlCltfyhDwYhpJ3eat9DhSi1sXTr71w8CWzHMU8Z47X0IO89/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ub2CovJA; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2eeeb5b7022so4447525a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 16:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734397111; x=1735001911; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QtHb+TAzClaiol0zXJv2UBR+65gtWo5dViHfxTkrdAw=;
        b=ub2CovJAhnyqfCeu3yqRq+Zw7jfPiEF/rlFc/KvFuebFJ4whiLM0fhBrOtM9yCS4I5
         RwB0EbjGt04nOW/tCC4+NEMEaKEo1mm/xH5JVBDT+Ebm/iGa3ma6/4YHO9D8STw3TI3x
         4Di9hEfXfr6UYbLFf0HcRnW7OBwoQxUhCwEdOt98/XI7n3Ik2RAf6SiDt3VLe48Nsyaq
         tF01DPc9MklxR/pg07JrmwqEoxhWjaKKpjSMn7yd0Sq2w51B00Rob5xUJSwRphIruR7j
         H2c8itjyn1JFTkIheTkLCf4kOOyxc+DHsxWYncxp47foY3N5rTC+KYpxkAXcHPwmaik/
         JdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734397111; x=1735001911;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QtHb+TAzClaiol0zXJv2UBR+65gtWo5dViHfxTkrdAw=;
        b=e+Co8ZWCd0b5fD5jTED74CSfrJhdKslP3OndpgqzRqj1Gs7AR07YCCupVun0FlBLWv
         fIZ964nhQ9opeZkXz4YALX31n3LyiwCt8Kfsr3QbPYL/7Zc3VkqoLoUA6G1mfbA/G1ts
         QnKEK9HU4MCW0ISbu4NIhEey+AwwF5KzFOCHz4G2Qr6918LBYKHcUg0lhOVsFYRQ4Pn7
         4bdnDeNZnbeiZnKTjk7TuHfani6Mo8uV0qeWIeK4y4C3rH0xZG96Gjhn9jzGXZdabPAI
         h/sxH5psPhVRpL9PUYwscrkoT0mEh1MvcwDKLmQmJZvkXOOijj3k1s2kKF+ZuaZd3vr3
         da2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVd7EzmtPetsTDUooqj9bQCUGrMIslMBqVfSzWU4PpeyEibBSgqFuUYfLqZzwsorC6eVC7HncqnfeNAmyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLqslo6YOjju5YhHDJJlLg0HnnNqSYCkmfAcpZRwMwkcTot/t3
	CX5J+GO8+Jz4C4tCHyjISTauF3k2UzAOHfSdRqP+1mFuyq7VMSYSTfqIeQfb1FOww0z6R7Ol5YN
	rTA==
X-Google-Smtp-Source: AGHT+IEDvBU9k6Ru9M5gPh97laz5Mo8W2tw1aRDBQ5B2tFJS8jeNlhuSwR6DcjhDTvSWoYi3GDuhfvGoGcw=
X-Received: from pjbsr5.prod.google.com ([2002:a17:90b:4e85:b0:2ef:8ef8:2701])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a90:b0:2ee:bbe0:98cd
 with SMTP id 98e67ed59e1d1-2f28fa54ecamr22543216a91.7.1734397111522; Mon, 16
 Dec 2024 16:58:31 -0800 (PST)
Date: Mon, 16 Dec 2024 16:58:30 -0800
In-Reply-To: <20241213235821.2270353-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213235821.2270353-1-seanjc@google.com>
Message-ID: <Z2DMtr3jdLK9cg34@google.com>
Subject: Re: [ANNOUNCE] PUCK Agenda - 2024.12.17 *** On Tuesday the 17th!!! ***
From: Sean Christopherson <seanjc@google.com>
To: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

Non-automated reminder, PUCK is on Tuesday this week.

On Fri, Dec 13, 2024, Sean Christopherson wrote:
> *** LOOK HERE ***
> 
> Due to holiday schedules, next week's PUCK will be on Tuesday the 17th (regular
> time), not on Wednesday.
> 
> There is no scheduled topic (which is code for "SNP, TDX, and guest_memfd").
> 
> Time:     6am PDT
> Video:    https://meet.google.com/vdb-aeqo-knk
> Phone:    https://tel.meet/vdb-aeqo-knk?pin=3003112178656
> 
> Calendar: https://calendar.google.com/calendar/u/0?cid=Y182MWE1YjFmNjQ0NzM5YmY1YmVkN2U1ZWE1ZmMzNjY5Y2UzMmEyNTQ0YzVkYjFjN2M4OTE3MDJjYTUwOTBjN2Q1QGdyb3VwLmNhbGVuZGFyLmdvb2dsZS5jb20
> Drive:    https://drive.google.com/drive/folders/1aTqCrvTsQI9T4qLhhLs_l986SngGlhPH?resourcekey=0-FDy0ykM3RerZedI8R-zj4A&usp=drive_link
> 
> Future Schedule:
> Dec 17th - No topic
> Dec 25th - Canceled
> Jan 1sth - Canceled

