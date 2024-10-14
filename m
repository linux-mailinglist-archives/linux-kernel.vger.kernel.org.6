Return-Path: <linux-kernel+bounces-363588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BF399C471
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 10:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D2E1F2415D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 08:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5E7156C5F;
	Mon, 14 Oct 2024 08:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RvSDwrOq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEA1154BFB
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728896275; cv=none; b=kqAJtKTErm7gxo2QgXIUMTaebUpyuA4rsWdxb/tgyBOhtqe3B1dKP+huMBe/fi8tcIoC9YLDWmJEZJEtCwE2FXkODYXeML2SigKKGqGguyTzEN1Slplv7BOedgr+khkS22GvhAgyzzO622ZBLcryPPgXK53gvMJ637dY19STPS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728896275; c=relaxed/simple;
	bh=oIiQmayO/M0rscDY2JPYBUNFS9Gh1tN1sxn9bgN2BLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGw74+JGvbFoHNF9qEjssB32MFnlX/vAPJ7ECS4lazSBrgPveFN7IASrgDw4ylp5sOIrMggpCnwZRzNJr8A820LF85FV+ijWsiq8rLr9cI1kVERrKh7+W/yOtdEDwWJbR53fDJEyHoZ2wgaCbzkZrKxnjacKPhmhxWYRcTSTIAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RvSDwrOq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728896273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oIiQmayO/M0rscDY2JPYBUNFS9Gh1tN1sxn9bgN2BLU=;
	b=RvSDwrOq0FQ+hKfkmFxUCuogTIZGudPIA5R+lruC6stfviqVI9NGW+IHrAcD5frFH7tOpM
	ASwFBmyM2bdIrOoOkKW4bhTtwMDc0lwIqY6ov/rwhWnJF0QcnPYzyfevLQVWnOzM8TXsh4
	CAf1gPfRdwq6sUJQFIE46savUNHI6VA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-XhgIQV3dM2mXeGnUeOJQPQ-1; Mon, 14 Oct 2024 04:57:50 -0400
X-MC-Unique: XhgIQV3dM2mXeGnUeOJQPQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a99fa9f0c25so77480366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 01:57:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728896269; x=1729501069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oIiQmayO/M0rscDY2JPYBUNFS9Gh1tN1sxn9bgN2BLU=;
        b=cqaWZpQ/3C0DG9qJ76HViypyD6XqYhvFIRm1Sa4xsToonRZ6rT4+0qi5DZocdIbZSD
         twqFVZGTEtqrZlP1VlSPyX4N4vqFQcJEYIT7tSAkIQxYqBjMMd+A/d9VqGeINAhPQhra
         XFz4R8sE6kIxovglBbselXfJUnlLqXGL+doi80ry4J1JlLX6YRn9wSmPPdBVCSTFZDxn
         FBqqmyw+bG1viwdoFHQK+0WG3d7oc8v8WkFUQ74ElcZb0nrpSz2ScAWnRXzuhjTo9SBT
         5aexknWwi4I207a6LB7RacGf8xFEWRg7EEu589RVAYLf3LP9QqZH//vfIVMN5yqj0u/A
         D/qQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8mdpl2Q/fTCVeAmHIZ8e64b8GUzadn8y9tzrOyR4n5FQcxkQrvVUkUo4BuPB2AZ4VPZQMpZx7mqowSNw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU4qhxujJwi8o81wIvr9WljI2diavJfqsVClot57HwtXxCKmAy
	Ib7XS68UBUznhJDDxQKUcdK31YhknebFhAbZSb4lau6w4AOJkGlXrVRknBk+c/5Xl0Q2c4/lija
	zyebfK6ubfWm16+IxLnsG3jQxg5aYynQ5f4K2MQBC5Y3nlq54zg05X6S4q43w5aRWHIzQVGbJdQ
	Z+XObFUx0DYeUN7cKiY5g5OuAiRcE/Zd8UE8He
X-Received: by 2002:a17:907:2ce6:b0:a99:ff70:3abd with SMTP id a640c23a62f3a-a99ff703c38mr334453166b.31.1728896269116;
        Mon, 14 Oct 2024 01:57:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPAQSthAxdUlKLMrCSRaNSm0eV4krUcbONfq7qXqZ01cmONSYTgFBnYa5QptEtUa4rzWI36TnTtiDiMv2dcHE=
X-Received: by 2002:a17:907:2ce6:b0:a99:ff70:3abd with SMTP id
 a640c23a62f3a-a99ff703c38mr334451966b.31.1728896268776; Mon, 14 Oct 2024
 01:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011121015.2868751-1-tglozar@redhat.com> <20241011132356.28c48902@gandalf.local.home>
In-Reply-To: <20241011132356.28c48902@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Mon, 14 Oct 2024 10:57:38 +0200
Message-ID: <CAP4=nvR+RML-=owASqjqQvhn1ernCP5QtREcPU=FLiOZ5G-RBA@mail.gmail.com>
Subject: Re: [PATCH 1/2] rtla/timerlat: Make timerlat_top_cpu->*_count
 unsigned long long
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jkacur@redhat.com, lgoncalv@redhat.com, Attila Fazekas <afazekas@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 11. 10. 2024 v 19:23 odes=C3=ADlatel Steven Rostedt <rostedt@goodmi=
s.org> napsal:
>
> Thanks, I'm applying these, but could you or someone else create a test
> directory in rtla and even rv that tests this code. I just examine it and
> run some basic operations, but I have no idea if it is really working or =
not.
>
> Having a utest directory or something would be really beneficial. That wa=
y,
> I can at least run that test before I push it up to my tree.
>

Yeah, we definitely need that, ideally to test expected behavior for
each common set of command line options. That would prevent unexpected
changes, like the recent defaulting to userspace threads requiring -k
to be used together with -U, otherwise, -U has no effect (because -u
is added by default). I'll look into that.

Tomas


