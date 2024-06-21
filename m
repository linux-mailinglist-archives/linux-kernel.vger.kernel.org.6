Return-Path: <linux-kernel+bounces-224190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E19FF911E8F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94BD81F22CA1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1903C16D33A;
	Fri, 21 Jun 2024 08:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1eG/NfN0"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E91E16B722
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718958128; cv=none; b=vGFbt0zvIUScpZu7C3gJgUcjiK8M88lANPkqgCd1iC37X+difhA39pbyugClrw7fwB4hyLnd8WaLzHRZ4rYNbbl6bmtyvRFavSjkM15nBFv1LGEOZG+eEmSrnBSBhW/N1B0+mqRT26BOmHkvKiLw4rx9iuckYlGDn+S3sR3GE2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718958128; c=relaxed/simple;
	bh=GiWp0R3m1O2e8FqlZeCTxBARLk8raP5XQEmY3Orplv4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bFCmkkX/GEIpW4xNe8w82freBt0FUIogU+3ryA8PbBcABhQH3NKcMPpKbkWCSo0vWnz4v1taS51IZYgEtUpEqq8MLqrjM5nLm2QgBoxCmoV1ACK9hz8oZ7qsToG2ABrHmmUa6JgUW9cGuC7Q/pTUSTWgVO3Y04A6sGa5/PH3jEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1eG/NfN0; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6b50018e054so8384746d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718958126; x=1719562926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiWp0R3m1O2e8FqlZeCTxBARLk8raP5XQEmY3Orplv4=;
        b=1eG/NfN0jaGe3ZnPl3fgAgNp62mc8cly+lC3xeN+OUNj6yRKCxL9Ge17+X3kvTHSiT
         V+hiMSSzmNFvrdv165b2RPjJBuIcp5a+g5q+B9PLCNn5UKoGU7GR+mMZM6uPjPeAcOZ1
         LOAg1NdKjyjDDoBwxucx+4Rdz/L15A0eajmAWVzsQdxAAHuf6RNOnzlmAJ9TcTOiBxDt
         NwYGIJXA6dUiMVkALlpy+gbzoEpSlK1UUnPb4IpqmDL/dNov6khWdoR655Apnmb3qjrM
         rsp/XPaTl6WJ3jRykz4kpvZL5Mhr8WQLX81cEN37Oo34MdE7aMCQVdcYdmniima2ht7N
         +aGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718958126; x=1719562926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiWp0R3m1O2e8FqlZeCTxBARLk8raP5XQEmY3Orplv4=;
        b=q+FUHjnpHdYb3DXlDXbZ5WHHMf8kfvD9DSmnTxDaLl71kjBGUquJbgs9sz8MFenFuf
         KuVXMEBHgixsLAFdOWOp9h4+TAjQX/w8TUCahy6l4BU5oRpNjFU9Ld6dvfELcid0WE1f
         ho60aBPdgIe/U6ieGEZDfpf9hAfbo1QgTirmXoF7LAgJesqle/FLd/O+D0juIdZqIXLn
         7j7ABnSS19ngl2LmDDCUVaSy+/JB2l7lzFiPOEWtv4AnNrNLpCQDOoVWa4RdOG8YiD6I
         9Hp1hkSoIjt/8Zd8ZwfDu5GD/2Hm70K5xhQ6nbvkFWoP/8HuTKL5pJXU2WsG3hD0SvuP
         6DlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKX7t4B6ChzsFF7SZXfWUR740qZZ6ul0eQhrQnLwGH084U16aIGnidCl4Za/mXkpf8AYoqWv7+ElzI/+l1J0ub1qCyZE12s5c0Y/oR
X-Gm-Message-State: AOJu0Yzi3SZAmrne5khEAOx2sSZmsYbvVEi1eKJkRyyJ0j+XzV41zR8E
	34D//JVOqpDTZqh+5+AT9QlfFY0yVC8iGysEDySe/c6BHyOX1PxvvGiMwc/pPJfhsP4Lt3nRhlC
	FgpI8HFVtO3nyUd36AQBW6ordQc+Fl/b4MZ8d
X-Google-Smtp-Source: AGHT+IEqLUO3OT9Bhboypnctwqc8Ohld/THbrsKqdROXjqX2LTf1GcH5jlfhi1RSDxSEenbd4gpWPErmzbl81ksieb4=
X-Received: by 2002:ad4:5842:0:b0:6b4:fe1a:9ea9 with SMTP id
 6a1803df08f44-6b501df8ce0mr76732636d6.6.1718958125525; Fri, 21 Jun 2024
 01:22:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621002616.40684-1-iii@linux.ibm.com> <20240621002616.40684-17-iii@linux.ibm.com>
In-Reply-To: <20240621002616.40684-17-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 21 Jun 2024 10:21:29 +0200
Message-ID: <CAG_fn=XKAdJ_VR8_fsOFSRqZxqGRB+GsHMMQjuy4gQGEGi9aDQ@mail.gmail.com>
Subject: Re: [PATCH v6 16/39] kmsan: Expose KMSAN_WARN_ON()
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

On Fri, Jun 21, 2024 at 2:26=E2=80=AFAM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> KMSAN_WARN_ON() is required for implementing s390-specific KMSAN
> functions, but right now it's available only to the KMSAN internal
> functions. Expose it to subsystems through <linux/kmsan.h>.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

