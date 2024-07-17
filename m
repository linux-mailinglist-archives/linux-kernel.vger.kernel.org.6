Return-Path: <linux-kernel+bounces-255370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6BD933FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 17:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52B5EB22A1A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 15:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24027181CE4;
	Wed, 17 Jul 2024 15:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yHgLi2mP"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198E2181B9F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230587; cv=none; b=CMU7oxXzjRWf5TzhdsHvHvhshQp/o+DVhjDB/hFHwcESxgCdygiBatakPNecV09puhwcQyilWClsxLE0xEmx31c/91CZkkV+F2Ztt/DQjjr/3xlcVKu7oIuv8moLmk5rbibs3RtzQto1vJIImm04sPumzmHZwSbanTsnbV+BpzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230587; c=relaxed/simple;
	bh=U4lOBq92/A5nbA68C1/X8MmurvsWYYfhY8kYgF78L2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rakA0eLeGr5T8bsSr2Y19VWdyxGQNz5Xw9vaE+4HXaDj6LCHb183Ait7gXsG8sHgDJYYclak/VwLEDWpTw6drCUQMsbe2arLgJv0o0MYPBKR3cH6DEqbDRCn7wNxmBp3JnvgeTiMfjRG06bJwyoEEXl8qETqk9XUIoukkEolQG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yHgLi2mP; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-44a8b140a1bso373521cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 08:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721230585; x=1721835385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4lOBq92/A5nbA68C1/X8MmurvsWYYfhY8kYgF78L2s=;
        b=yHgLi2mPxZXkIvn3MwA0IV+mHz8zopb7BFS0q581PIsmTQ0AFSaxCMbhuXVQ2moSN2
         2HLNQwwkCTNMaK8AuAQKvJR6GN45dlSfMdVFaRdgBQxu/COisYdpOu6u4nvNFvMYTnRl
         Ln2NTQ/It66UT4zOLkh4N43WwoAoEDOH6XD2nWOwg6AU+D+vT6AMi2yacH3xTGZ71yPn
         PWJsMr21Vc/zgjpMeAy0n9lG8fm9Umvm3pqOqQqctM0deJwDVkZ9HftGYbULk3lRauLd
         dyyUn2zc7iZHE47t6135AVR1JlMqZ705JjKeHViEJ0WSnMZW+iOJ9KNHShkd0y78lYMf
         r4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721230585; x=1721835385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4lOBq92/A5nbA68C1/X8MmurvsWYYfhY8kYgF78L2s=;
        b=VGjq9MKV+UR0/08N7TuSRZybHA+2Mr+P7NyJsVTHhdNTjwR2IyoJxg5rpbwA8vpiVq
         iQukg66n3tXoOT2BYY1jaSiwy4f8Iapsy8Ph+p2RscDnIq17pUWKW3Qe3rVkAQDSQRKx
         W7jVpjoAyxf1L8XA3P98PjefS29r/C1QWqGpZ8GdHalY8QrmcnT4fUBmbtLqKff1spZo
         shnKsICuHYxJWGjjKQNosI8NvsFVTxlMz0nA5zDzxIVUCjXz0vf1IB7gzU2NHh0x5LGj
         tiVSUg6WelyEyD/HWKtCiwdOopcqwzDei3x+6VYIWDv9hyWOUzmRs9yiCUpBPW2z+baE
         4FmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQb3kM9cFVuhjzZR8P5yTk2DdPe7mJTQmI/ekcPWq0cKdf+0So0o2Mk96Fo+wa0OM3vuUnu7fHgVKm/iPy9d3xAtLSo/aDdVSrXMlw
X-Gm-Message-State: AOJu0YycONwRW0/CxxMZUt2iodaC7lAc9DBwTBObjgGDmdV0U0RCvFqG
	+bBHQAqmbs8//qTIEBYAWDweDinI0ObQg7jg4UGcrVZR8kpq6N7CWC5xQnEnRtwrxhdGwCLZSjO
	vTRnj2OtbfKzoxYFM7vxEwyhd000853WZdmK/
X-Google-Smtp-Source: AGHT+IEalDvuhLDexLMZf/xCnrcvDmSl+qwkU4w3Z8mWew0Oue5zbO8Ev8APAN6BenQiPOpjM3focVcnEXdW9CpFBeA=
X-Received: by 2002:a05:622a:2515:b0:447:dbac:facd with SMTP id
 d75a77b69052e-44f83a73376mr3929431cf.24.1721230584789; Wed, 17 Jul 2024
 08:36:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711102436.4432-1-Dhananjay.Ugwekar@amd.com>
 <CAP-5=fXXuWchzUK0n5KTH8kamr=DQoEni+bUoo8f-4j8Y+eMBg@mail.gmail.com>
 <05e96873-12a9-4b1f-b1b3-1db7647211ce@amd.com> <CAP-5=fVXi3Pdtjaw++oRkYgubh-MDkRYf=2k7dNqE8s+jyQ+Ew@mail.gmail.com>
 <2e7064c2-c769-41bb-a536-c6e75e8e5800@amd.com> <CAP-5=fXBYVH=qBJPm1d0-QEp8+HP3WtTLuukfF0g-2WU3gTofQ@mail.gmail.com>
 <a1603596-aa36-4bb9-8c66-295b1872a2fe@amd.com>
In-Reply-To: <a1603596-aa36-4bb9-8c66-295b1872a2fe@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 17 Jul 2024 08:36:13 -0700
Message-ID: <CAP-5=fVZvprNLZiO0baQ0cBgJE1qXjqqHRZvWz9YvU3FHUJHiQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] Add per-core RAPL energy counter support for AMD CPUs
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	tglx@linutronix.de, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	kees@kernel.org, gustavoars@kernel.org, rui.zhang@intel.com, 
	oleksandr@natalenko.name, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	ananth.narayan@amd.com, gautham.shenoy@amd.com, kprateek.nayak@amd.com, 
	ravi.bangoria@amd.com, sandipan.das@amd.com, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 1:05=E2=80=AFAM Dhananjay Ugwekar
<Dhananjay.Ugwekar@amd.com> wrote:
...
> Sounds great!, I'll be happy to refactor the RAPL code to use the event.c=
pumask
> feature to add the per-core energy counter. Also, please let me know if y=
ou need
> any help from me on the perf tool side as well.

I hope to send out some patches soon. One thought I have is that
"event.cpumask" is probably less intention revealing the "event.cpus"
as a name, so I'm going to code assuming the suffix is ".cpus" but
obviously we can change it to ".cpumask". To me the "mask" makes it
sound like we "and" the values with something, hence wanting to avoid
the confusion. There's much confusion in the area already, such as the
term "cpu map" that does not implement some kind of map.

Thanks,
Ian

