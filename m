Return-Path: <linux-kernel+bounces-219761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1EA90D90C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FD26B2B90D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 15:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF2A23777;
	Tue, 18 Jun 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ysXS1H4f"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8914A35
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718724979; cv=none; b=G3iZlpUXA6rZ9rOswsBj0uKENUFr4pWmUxoB9fBHtBmBpDo0FWjNjXAXwyA7l728rL74JExbYRqOGzV+82zMPSRzZDl0toQafH34Bm3ADEp6Z5ygI/bfRO892t/beEHn9Xiss0qzpuKriD6QoeF1lC3ZZObFTyDoEtnGVG+newg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718724979; c=relaxed/simple;
	bh=5RGeJPOFaWHdjpCL2phNpFb4SArUUUeonhkd+IsWbC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VApVp92DW72sCo3rocDppWvafTfzb1QRPlJfDnsZuRTQ+3ZQFJsTNEB2zVR7vcGGdE0inIel5RCN5NgmZtnCuSIME6AmkY8g1Q0t/U1FzqFlnDnunQwEcZPdnPr1nbVhN5kwaxFZ701GO86GWFSvWu/629NZo6ROKu9aLjZJALE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ysXS1H4f; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6fc36865561so1513604a34.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718724977; x=1719329777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5RGeJPOFaWHdjpCL2phNpFb4SArUUUeonhkd+IsWbC4=;
        b=ysXS1H4fS2mPV03Y4L/m84FKCjlkHSxi4xOu32dnqb6LzOwsyaraZoWoQH+LcpDk1H
         cFgLindy9f2RhCTqS2qdoZsnPhxjDYvAYZAuddd4mGhwuKseFVr+T63p/7jRFd9y+8Cu
         iq0nWFCXflnt8DFMsx1/RMCPABIQxCQpdHxEGONq+sFpQwMV16Ue7TY3DTYPNXp/mhaL
         MO9tdYbrl+a/D/gLdejAg8ugwKJEf4tbZHMNevcmsVyEtI1oi6TnGsm6KCITtEcIjsmo
         X9j0hF2G1+SGmpdKf/cBeoxvm0rOSp5qNU5/nl/oIjxpF4+GluSqPb5OiFNDRVFGRs8d
         BLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718724977; x=1719329777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5RGeJPOFaWHdjpCL2phNpFb4SArUUUeonhkd+IsWbC4=;
        b=QHWS/3ToPJhv2dDDiplwYoFEeU0S2IcOzjDg8orsPxjJGTJ/dMob/Wlms2jA7oEJ69
         8Qw/J/n/qZUT0u84LDXau/U8abbivIkwMSSaF6TFDTCW6kVsVwRniX5EDFH60vzgGdpL
         I/N3YMRQZj9T7lzNNaTMGFOTLD6LaqSKQNR9/Odtfb5a/BDMXeYBS51wqmaARiHM81Oc
         YBTv98PArn7TTuxcWucjptH6rwSjFYG9L83eIxzXhCnbBGcj5dVH/mJYMcnT9TNvdrGS
         WqQOAEE6dIstFcyHjmhWwUAj3jH2lxwWeMX+Oq4cRyHtUmpJlr88MM40/dt1jm0tYHkU
         4CiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0JaQs/eZlI0FKmIoyN96rntiD3/jk5vicrM98WCWHhEX28hcxF9BLn2aXgUdBd5Tm8Sbe1mJsV8VCacH6TgkIOp6cvaltqq/eu3Wm
X-Gm-Message-State: AOJu0YxLrUVk2z2LPZHlY7sObakfr3jhPmfbzn8UOEOWP6t++U0XAwP9
	p1/MizRtuWIPDwxihrmtcUgnrZe5HwLvU2e1LNx/hcloiNZMmVdfqpg0E3DvhcKZfd9MG0Dd9kT
	kMKysUV728gd5MKxcTTQPBaOKOukC0CScxY0s
X-Google-Smtp-Source: AGHT+IEspShaRu1ToIazyKYK7a+yojtYmsB71BOjBBtI4HtP9AWTraCEUo7NTIwtb9GkxSM1Qq0A95f/tFWqAqFyrLk=
X-Received: by 2002:a9d:6510:0:b0:6fd:6240:9dba with SMTP id
 46e09a7af769-70074ebf134mr77156a34.16.1718724976930; Tue, 18 Jun 2024
 08:36:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613153924.961511-1-iii@linux.ibm.com> <20240613153924.961511-10-iii@linux.ibm.com>
In-Reply-To: <20240613153924.961511-10-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 18 Jun 2024 17:35:36 +0200
Message-ID: <CAG_fn=VT5u6fn6eaqzdB4bDZ+aw0kKBta7_Ff2Thn813RG6EVQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/35] kmsan: Expose kmsan_get_metadata()
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Joonsoo Kim <iamjoonsoo.kim@lge.com>, Marco Elver <elver@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Pekka Enberg <penberg@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Vasily Gorbik <gor@linux.ibm.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Hyeonggon Yoo <42.hyeyoo@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-s390@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 5:39=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> Each s390 CPU has lowcore pages associated with it. Each CPU sees its
> own lowcore at virtual address 0 through a hardware mechanism called
> prefixing. Additionally, all lowcores are mapped to non-0 virtual
> addresses stored in the lowcore_ptr[] array.
>
> When lowcore is accessed through virtual address 0, one needs to
> resolve metadata for lowcore_ptr[raw_smp_processor_id()].
>
> Expose kmsan_get_metadata() to make it possible to do this from the
> arch code.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

