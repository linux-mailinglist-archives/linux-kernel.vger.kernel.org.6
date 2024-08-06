Return-Path: <linux-kernel+bounces-276518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FF99494E2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 17:54:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75E10B2B211
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D56381AA;
	Tue,  6 Aug 2024 15:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMf68li7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8D721105
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722959432; cv=none; b=EokLUY9NzwMs3EAfFMsEkbLo2D4ak0P+HcbeTYTm0d8o4JEpKaE6ZpZK9Ll15Eh7JnvijsZEwtYW4m3GpAmruoXYv26IWZDm50osGJ/2foY4sc5eb26ADsx0/tgNj9f+sVSsrbQVUgGI+xAVrR/FBJs8c5r9w+AvKwqLjHgyQZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722959432; c=relaxed/simple;
	bh=FrTfwV+pTxyUZOUdlAo1IU0O6QFzQjc+/lQkr4y8yJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o7tdM8BdMxtOXeXxk4J9ZKjpEJKpxz+19frL5Vy6Wl+w0z7kvO8SBRgk4zg/mMTcTl2TlGQJF/sAMxlj2N7tTvSAv06V//BBFLeckVw/Jji6AekAMcqgOK/KkRNs2rJFkW7F6iAeZlYA7lvvOnumagvPLqzyRFNAVAI0BLcaxnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AMf68li7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722959428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V1SZflUlzWRG2lz6nF9WqANN4zM73HGx+fcNBTyWTyU=;
	b=AMf68li7AzcwfbRgE1fgbmwtIfqyNk5K015lyErYdDSjZJuMYrJeI7qW+vrK2vU3W0Dnn8
	Ntp13GJmwwHwfpbN8AZq9hMtDJ9dL2/dUprVuH7flg7MlPXXz1RqUf3DVClYF2EcRmzdEW
	Vd55yQJr46y5QAOcZbC7aCRgT9YrE7c=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-5NJheQUjM76jB7jakTYK7w-1; Tue, 06 Aug 2024 11:50:27 -0400
X-MC-Unique: 5NJheQUjM76jB7jakTYK7w-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-52efc9f200aso838507e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Aug 2024 08:50:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722959426; x=1723564226;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1SZflUlzWRG2lz6nF9WqANN4zM73HGx+fcNBTyWTyU=;
        b=Ml5V0a/lqaqJAYFEWGWNIynKUkay7dDbcUY/mDF5DjsbSFrbEBGMI5gNcO28lEUXcw
         lF/ETFvio52DBge3hm1F856ERsaVy1MxUPTWgkg1kgTf53put1JfqfzKRdVg42jAKY92
         tvfGS6YZjUVQJJBc1dAdMK8/DegJzNrWKWKHua3bCfkpn6bvAP6EhMOX8pTX6uCl+8Hd
         LNMXzAGKcYUJUVUnQiXhSAbYfWcb6Bvgyj+U2tYoxBdDPcaA0GBUR+w9PelxhT29IWQm
         SUg+9Ywp25sjbn9vZke8YMTLY0YG6L0pnaDywTQTrawoNZr7cXwHLCW3xgVLUS+jRcXX
         cbNw==
X-Forwarded-Encrypted: i=1; AJvYcCWD0DDbzb3RVl33vQfyd+dOJgwxDq3zl5hGkrOopCohCnz4exSIOfZsyrpihtcYeXkth8WkMO0zHkZCyDtRcJWOvxVnB9HXD6mS2KEh
X-Gm-Message-State: AOJu0YyWjMmge4U72voMMKIeWknwPJOeoi9D4PH2fwrgVcK8sEzv2d6U
	/jb+tXQeebe7uPzJ3Ad9OSD7Rk8WwDSQ2iqI/6xHf+aKZydvaQIPZ9D4YWaAt/4Xk6COko8pXYC
	02RhGdLmpsqdIIXx2BTMJtJEd8MEyjGdjJIS29tFSmJqlHF9rjdCbEpsm0RnrGg==
X-Received: by 2002:a05:6512:1588:b0:530:ad8b:de11 with SMTP id 2adb3069b0e04-530bb366510mr10120983e87.9.1722959425560;
        Tue, 06 Aug 2024 08:50:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrP/2irlZFIsDLVFNkNhYd8/du5Rm7YYrDr/q2yS/bDqGryVxnLlmBrADtz1Oy4e5F1rfSFg==
X-Received: by 2002:a05:6512:1588:b0:530:ad8b:de11 with SMTP id 2adb3069b0e04-530bb366510mr10120956e87.9.1722959425004;
        Tue, 06 Aug 2024 08:50:25 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb9d464sm250003485e9.42.2024.08.06.08.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 08:50:24 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Leonardo Bras <leobras@redhat.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>
Subject: Re: [PATCH 2/2] sched/topology: optimize topology_span_sane()
In-Reply-To: <20240802175750.1152788-3-yury.norov@gmail.com>
References: <20240802175750.1152788-1-yury.norov@gmail.com>
 <20240802175750.1152788-3-yury.norov@gmail.com>
Date: Tue, 06 Aug 2024 17:50:23 +0200
Message-ID: <xhsmhy159mz0g.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 02/08/24 10:57, Yury Norov wrote:
> The function may call cpumask_equal with tl->mask(cpu) == tl->mask(i),
> even when cpu != i.

For which architecture have you observed this? AFAIA all implementations of
tl->sched_domain_mask_f are built on a per-CPU cpumask.

e.g. for the default topology, we have:

  cpu_smt_mask() -> topology_sibling_cpumask()

which is implemented as:

  arch/loongarch/include/asm/topology.h:35:#define topology_sibling_cpumask(cpu)		(&cpu_sibling_map[cpu])
  arch/mips/include/asm/topology.h:18:#define topology_sibling_cpumask(cpu)		(&cpu_sibling_map[cpu])
  arch/powerpc/include/asm/topology.h:139:#define topology_sibling_cpumask(cpu)	(per_cpu(cpu_sibling_map, cpu))
  arch/s390/include/asm/topology.h:31:#define topology_sibling_cpumask(cpu)	  (&cpu_topology[cpu].thread_mask)
  arch/sparc/include/asm/topology_64.h:50:#define topology_sibling_cpumask(cpu)		(&per_cpu(cpu_sibling_map, cpu))
  arch/x86/include/asm/topology.h:186:#define topology_sibling_cpumask(cpu)		(per_cpu(cpu_sibling_map, cpu))
  include/linux/arch_topology.h:91:#define topology_sibling_cpumask(cpu)	(&cpu_topology[cpu].thread_sibling)
  include/linux/topology.h:218:#define topology_sibling_cpumask(cpu)		cpumask_of(cpu)

and ditto for cpu_coregroup_mask() & cpu_cpu_mask().


