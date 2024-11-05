Return-Path: <linux-kernel+bounces-397028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE509BD5C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 20:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC516B20F7F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 19:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F80B1EBA1D;
	Tue,  5 Nov 2024 19:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gR4d4Y7Z"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181C417BEB7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730834504; cv=none; b=GB8tr+qJ43Qscu9lR3SO/b+wvxyrvojTjhx+KOK73dr5QZQNta7R8UFzYKOpOqlwhH5S1hnmSu4J6zRTF27YnflnZ6iw1W7TyzFzCFWoZGntbX0G1yJFgc6ImjtX6d9BB4GJi6rS7GUSC5i3CNdgMyVu5PVKT2XLczyQXrk9xRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730834504; c=relaxed/simple;
	bh=5WjO8kooJsNK7ZBxwniHhJKcVajJEn35p+jeOFdCYDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3KrOfGZnnylMUYaZi4bDcbRBRKD0fD/iuBtvmRiZ9bXa2cZjWbaKX1AAjrt/+2LWa4XSWoV3243OpClApcvjcqfk4ktzMBlRYOPmOavBhvVQGrRlzhV4p6BwLjRd6AQznk++zNg0Du04ibEJ0SRGQCI03LhA6Hp3mzx67y/mjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gR4d4Y7Z; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-84fb1225a89so1897910241.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 11:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730834502; x=1731439302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5WjO8kooJsNK7ZBxwniHhJKcVajJEn35p+jeOFdCYDw=;
        b=gR4d4Y7ZGIwhk3TG6FM458VXATERvSxalgXXENHz8cYItp7cllUhCR6FQTz8sr4z/S
         gMIwxujvKY1QrNaviUqrtDt2dgXORk1PB8B+2nLghG1ihOAMS6jhS7Wy2px1qM3dyTcj
         cHiSD1EtFKXwv4yskydmSRL78mt8j8CanV+ah61YNYLe3Xqk/FH/Ej/cUkhjOU7XhoHn
         GaJ0CwOF8e916mRKLUbUYpFYLAShsdA2HYneZXhQxGUBTkbPOBT1JCZ+GGw11C+fVUo9
         R9W/JtmjPCay/JtN3D9t7nG8MKLSa8JE7/vigHDyseIvaAtfVOw+HnaUJPQbPNXq/ZDg
         EzPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730834502; x=1731439302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5WjO8kooJsNK7ZBxwniHhJKcVajJEn35p+jeOFdCYDw=;
        b=O1mNJWgG0wN5/+QLsNcVc1jclHkGj8SnwaUBC8zYGkDGSdMO3TyRKCw1Olez2avqOv
         K6UV/jw2oxenj4KLmiPOX6KKwXZazD/vPIanDnmXrjPgr7e0G/Q7ZY71pxrPz8cJVdtQ
         SSxZoUu1d7afY6uWw9FukGY59KX3a9iq37wGEHnhu2QPkqNrEygv4XBXm/MKugdjpJIB
         FHmKkxNT29egA+fNK0QsrWdF2/U6Fq+OFEy8VXO8pXGU54eXCm/OWcbmt8U/PYwCord8
         nm3g+QwgLLUvhbcXsFAaEtculxrObWskbcMcyaQLIvDQU18Kt37vq2tNwzzGc78b4VCo
         vlEg==
X-Forwarded-Encrypted: i=1; AJvYcCXUq3AHQ0B+M/Z5tudatGB+FL5pa+BNOD3uUew1LMyf4Eb1X/mGxCwlTpkTKDnNliUtS6zGXn5ukuMq1HI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd5qRsj9fKHxVPGzwdM8WeHVUK6g9A6qpp4YlTlAv4DC/2FfrM
	n0L0G5EhBZZF8WPjED62FCQlCiVIe76goMIOqGxP2Lvr2Vvx0+osp11Am3rTZNu9zAOKqMQh3Dr
	HFwypyUIAS3omrL8ZiEFsexoDGw5WsrzgEhjP
X-Google-Smtp-Source: AGHT+IEo+Kzl8oq8hn5GP7PubF/mZ9ZN65TG13mkSZTKtWpHUHtBiEPxJIfZWEDkljfh9z2TeQ4oGnRnMXvz3siHkys=
X-Received: by 2002:a05:6102:6c5:b0:4a4:7257:e71e with SMTP id
 ada2fe7eead31-4a8cfb4b70emr36918399137.7.1730834501695; Tue, 05 Nov 2024
 11:21:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105184333.2305744-1-jthoughton@google.com>
In-Reply-To: <20241105184333.2305744-1-jthoughton@google.com>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 5 Nov 2024 12:21:05 -0700
Message-ID: <CAOUHufYS0XyLEf_V+q5SCW54Zy2aW5nL8CnSWreM8d1rX5NKYg@mail.gmail.com>
Subject: Re: [PATCH v8 00/11] KVM: x86/mmu: Age sptes locklessly
To: James Houghton <jthoughton@google.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	David Matlack <dmatlack@google.com>, David Rientjes <rientjes@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Wei Xu <weixugc@google.com>, 
	Axel Rasmussen <axelrasmussen@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 11:43=E2=80=AFAM James Houghton <jthoughton@google.c=
om> wrote:
>
> Andrew has queued patches to make MGLRU consult KVM when doing aging[8].
> Now, make aging lockless for the shadow MMU and the TDP MMU. This allows
> us to reduce the time/CPU it takes to do aging and the performance
> impact on the vCPUs while we are aging.
>
> The final patch in this series modifies access_tracking_stress_test to
> age using MGLRU. There is a mode (-p) where it will age while the vCPUs
> are faulting memory in. Here are some results with that mode:

Additional background in case I didn't provide it before:

At Google we keep track of hotness/coldness of VM memory to identify
opportunities to demote cold memory into slower tiers of storage. This
is done in a controlled manner so that while we benefit from the
improved memory efficiency through improved bin-packing, without
violating customer SLOs.

However, the monitoring/tracking introduced two major overheads [1] for us:
1. the traditional (host) PFN + rmap data structures [2] used to
locate host PTEs (containing the accessed bits).
2. the KVM MMU lock required to clear the accessed bits in
secondary/shadow PTEs.

MGLRU provides the infrastructure for us to reach out into page tables
directly from a list of mm_struct's, and therefore allows us to bypass
the first problem above and reduce the CPU overhead by ~80% for our
workloads (90%+ mmaped memory). This series solves the second problem:
by supporting locklessly clearing the accessed bits in SPTEs, it would
reduce our current KVM MMU lock contention by >80% [3]. All other
existing mechanisms, e.g., Idle Page Tracking, DAMON, etc., can also
seamlessly benefit from this series when monitoring/tracking VM
memory.

[1] https://lwn.net/Articles/787611/
[2] https://docs.kernel.org/admin-guide/mm/idle_page_tracking.html
[3] https://research.google/pubs/profiling-a-warehouse-scale-computer/

