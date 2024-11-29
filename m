Return-Path: <linux-kernel+bounces-425754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C47D19DEABA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 17:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64B6F2817D0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 16:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5EE14A098;
	Fri, 29 Nov 2024 16:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GI3ZQH3z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494AB168DA
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 16:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732896780; cv=none; b=H2Sd5APxeqikB1Ar+hNuSIF+otKw+wVgwcPIhJQtuuoJAprSOxoQAqNrDzYSn2zkV/wiZVhEiGFdviMow02pqICa1+RlhMKH+welNJoh4gZ4xgQB7NxlcprtGlaVHvWH9p6yhqp+KapPNadFoblPToOjDl3dDHLPBsexmxG6dyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732896780; c=relaxed/simple;
	bh=CmjVgATqZJEEX4NyzDINfv8QhIxwJcdSI48pre3gvVg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rwUIQpGPfEqHXCT/Mh38EyCt7Uil/YtwrwlmqXNRlG/M1MhwCQVFDTeQ7bqulljPUHb64QQCWiBaDfwoNmm9/mZdHSXBqwrxHoOYE6b0PF8euL6ECixdtJ96VYdyj3UrIO5Gm7yhj/TgPx4mLKWu8hXuSGSNCwYsb1ZjqiHM2m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GI3ZQH3z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732896777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ev/779P6/ivLvufd6X9UU2VfWDhin/qY7HAkdMd5KSY=;
	b=GI3ZQH3zZ5CNAF7DAiice1T2nlH+wvm5H3ZLMfP8veGcZmMJsjpBsdo8iaoWXUgu8ha1jt
	hl6mjUlS8sQEMomw5AR16AoQfRTsuunQD9OnVOIhHYHElFtUlZQwV/6hZfva1coLKZbnfE
	e3mQu2OVf0OegQz+SqPcXj9yrJ+alR4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-YgWwgnsOP2WN7KVdHaU51w-1; Fri, 29 Nov 2024 11:12:56 -0500
X-MC-Unique: YgWwgnsOP2WN7KVdHaU51w-1
X-Mimecast-MFC-AGG-ID: YgWwgnsOP2WN7KVdHaU51w
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6d881cf6707so13972986d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 08:12:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732896775; x=1733501575;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ev/779P6/ivLvufd6X9UU2VfWDhin/qY7HAkdMd5KSY=;
        b=u9LEq/eo3h4XUrJedXSDL3p/OBqaFmn+xp4w7jOisO24t9v2KYt4cc1H945D/38GKj
         JTjiiI9Vaf6aoP5KXfevzsLBJynnOoJj7GOD684mlAXcqaJGbEP1/Er1S3gs2NY4EnZ0
         XKv1+jRmKx07FAfpOGBt8tLsXuguVJv+ewZujwuPl6EYX7GTXJc/LsSXEmaUO0FiSbBX
         9f6IMZsoq0ppNeVDM3eEyWQbKbpudkpqLS+c7oVpWfafYd6TX8g1KiDs0oambk2IFnin
         noqiy/fHEtQhPFkSCvQk3unO0Bbi+x4Xx+UC98XN22Cqhz4heyu9ZHmm5QaOtGMK5Q7L
         EiLA==
X-Forwarded-Encrypted: i=1; AJvYcCXn3fOG8GV2W3hXpyTOLyXU7WMy3a363TCPa+DU9dZyP4yWvMh1ehmQ8dTGbQ4co6YOVNfzimu2HCYorL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww24r2tVF0P/lRAwivwRJry/tJOoLS6tpItnXz5Rx0YA+9ROhS
	RRvyrecGCbvsLx8WoFMaFRbjCASzyRFIPfkGRiiWzRiHAbr00jVnD9P4Oy80cUL4oLfScF+Ak/y
	xBOsWWKOPSvw6PyOn+psS0cnast/Xwa7oF39DFjRHdlHa181knrMtYK/H/9koCA==
X-Gm-Gg: ASbGncsA75JhkrTHukBNxHGWFPtf2ZZlkxxFx3tb0RLa8L7i3PbYKMirGbqiE7ykKZI
	qavy7SfnYxx7mDk6ry2fx40UnWApFZ2iLyxKqeXo+9eeH1GR72iaaRuAxEg+qUZZ0/RzUDvC3bF
	pn6KiQ5QXk5sXLjqNvz/gl1FB7uwcxtqxyDfYwbW1jwowb3kqMX2gJiJyJW89DIZAkJwsa99sn0
	1jpCG/tk00+duq8dfg4vEySppa4Jtp7NtbTL77btRKA8SIbHJUvuxC3XkSNdv66nSEddaiCZ2NH
	MgTuBlWTwXfR/AxAN+ey2/3n13tCTMXjKXEKxQ0W3w==
X-Received: by 2002:a05:6214:21e8:b0:6cb:ef1f:d1ab with SMTP id 6a1803df08f44-6d864d8aef7mr160482116d6.30.1732896775283;
        Fri, 29 Nov 2024 08:12:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExpXj2o0mq4c/YcClrxXHbwMCytsXtpgHlNKbRHUYBfNPW8ClGEsBKWB8n/hlgLFKeXxg2cQ==
X-Received: by 2002:a05:6214:21e8:b0:6cb:ef1f:d1ab with SMTP id 6a1803df08f44-6d864d8aef7mr160481476d6.30.1732896774760;
        Fri, 29 Nov 2024 08:12:54 -0800 (PST)
Received: from thinkpad-p1.localdomain (pool-174-112-193-187.cpe.net.cable.rogers.com. [174.112.193.187])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d87516342fsm17869646d6.26.2024.11.29.08.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 08:12:54 -0800 (PST)
Message-ID: <de1201930a55aa3b13f413b9bee986d85e2b4283.camel@redhat.com>
Subject: Re: [PATCH v8 1/2] cacheinfo: Allocate memory during CPU hotplug if
 not done from the primary CPU
From: Radu Rendec <rrendec@redhat.com>
To: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, x86@kernel.org
Cc: Andreas Herrmann <aherrmann@suse.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Chen Yu <yu.c.chen@intel.com>, Len Brown
 <len.brown@intel.com>, Pierre Gondois <Pierre.Gondois@arm.com>, Pu Wen
 <puwen@hygon.cn>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Sudeep
 Holla <sudeep.holla@arm.com>, Srinivas Pandruvada
 <srinivas.pandruvada@linux.intel.com>,  Will Deacon <will@kernel.org>,
 Zhang Rui <rui.zhang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>, 
 Huang Ying <ying.huang@intel.com>, Ricardo Neri <ricardo.neri@intel.com>,
 linux-kernel@vger.kernel.org
Date: Fri, 29 Nov 2024 11:12:52 -0500
In-Reply-To: <20241128002247.26726-2-ricardo.neri-calderon@linux.intel.com>
References: <20241128002247.26726-1-ricardo.neri-calderon@linux.intel.com>
	 <20241128002247.26726-2-ricardo.neri-calderon@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-27 at 16:22 -0800, Ricardo Neri wrote:
> Commit 5944ce092b97 ("arch_topology: Build cacheinfo from primary CPU")
> adds functionality that architectures can use to optionally allocate and
> build cacheinfo early during boot. Commit 6539cffa9495 ("cacheinfo: Add
> arch specific early level initializer") lets secondary CPUs correct (and
> reallocate memory) cacheinfo data if needed.
>=20
> If the early build functionality is not used and cacheinfo does not need
> correction, memory for cacheinfo is never allocated. x86 does not use the
> early build functionality. Consequently, during the cacheinfo CPU hotplug
> callback, last_level_cache_is_valid() attempts to dereference a NULL
> pointer:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 BUG: kernel NULL pointer dereference, address: 0=
000000000000100
> =C2=A0=C2=A0=C2=A0=C2=A0 #PF: supervisor read access in kernel mode
> =C2=A0=C2=A0=C2=A0=C2=A0 #PF: error_code(0x0000) - not present page
> =C2=A0=C2=A0=C2=A0=C2=A0 PGD 0 P4D 0
> =C2=A0=C2=A0=C2=A0=C2=A0 Oops: 0000 [#1] PREEPMT SMP NOPTI
> =C2=A0=C2=A0=C2=A0=C2=A0 CPU: 0 PID 19 Comm: cpuhp/0 Not tainted 6.4.0-rc=
2 #1
> =C2=A0=C2=A0=C2=A0=C2=A0 RIP: 0010: last_level_cache_is_valid+0x95/0xe0a
>=20
> Allocate memory for cacheinfo during the cacheinfo CPU hotplug callback i=
f
> not done earlier.
>=20
> Moreover, before determining the validity of the last-level cache info,
> ensure that it has been allocated. Simply checking for non-zero
> cache_leaves() is not sufficient, as some architectures (e.g., Intel
> processors) have non-zero cache_leaves() before allocation.
>=20
> Dereferencing NULL cacheinfo can occur in update_per_cpu_data_slice_size(=
).
> This function iterates over all online CPUs. However, a CPU may have come
> online recently, but its cacheinfo may not have been allocated yet.
>=20
> While here, remove an unnecessary indentation in allocate_cache_info().
>=20
> Reviewed-by: Andreas Herrmann <aherrmann@suse.de>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Reviewed-by: Radu Rendec <rrendec@redhat.com>
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> Tested-by: Andreas Herrmann <aherrmann@suse.de>
> Fixes: 6539cffa9495 ("cacheinfo: Add arch specific early level initialize=
r")
> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> ---
> Cc: Andreas Herrmann <aherrmann@suse.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Chen Yu <yu.c.chen@intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Nikolay Borisov <nik.borisov@suse.com>
> Cc: Radu Rendec <rrendec@redhat.com>
> Cc: Pierre Gondois <Pierre.Gondois@arm.com>
> Cc: Pu Wen <puwen@hygon.cn>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: stable@vger.kernel.org=C2=A0# 6.3+
> ---
> Change since v7:
> =C2=A0* None
>=20
> Changes since v6:
> =C2=A0* Merged patches 1 and 2 of v6 into one. (Borislav)
> =C2=A0* Merged the history of patches 1 and 2ino this patch.
> =C2=A0* Kept the Reviewed-by and Tested-by tags from the two merged patch=
es.
> =C2=A0* Fixed a formatting issue in allocate_cache_info(). (Borislav)
>=20
> Changes since v5:
> =C2=A0* Fixed nonsensical subject (Nikolay).
> =C2=A0* Added Reviewed-by and Tested-by tags from Andreas. Thanks!
> =C2=A0* Added Reviewed-by tag from Nikolay. Thanks!
>=20
> Changes since v4:
> =C2=A0* Combined checks for per_cpu_cacheinfo() and cache_leaves() in a s=
ingle
> =C2=A0=C2=A0 line. (Sudeep)
> =C2=A0* Added Reviewed-by tag from Sudeep. Thanks!
>=20
> Changes since v3:
> =C2=A0* Added Reviewed-by tag from Radu and Sudeep. Thanks!
>=20
> Changes since v2:
> =C2=A0* Introduced this patch.
>=20
> Changes since v1:
> =C2=A0* N/A
>=20
> ---
> The motivation for commit 5944ce092b97 was to prevent a BUG splat in
> PREEMPT_RT kernels during memory allocation. This splat is not observed o=
n
> x86 because the memory allocation for cacheinfo happens in
> detect_cache_attributes() from the cacheinfo CPU hotplug callback.
>=20
> The dereference of a NULL cacheinfo is not observed today because
> cache_leaves(cpu) is zero until after init_cache_level() is called
> (during the CPU hotplug callback). A subsequent changeset will set
> the number of cache leaves earlier and the NULL-pointer dereference
> will be observed.
> ---
> =C2=A0drivers/base/cacheinfo.c | 11 +++++++----
> =C2=A01 file changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> index 7a7609298e18..a1afc478e0e8 100644
> --- a/drivers/base/cacheinfo.c
> +++ b/drivers/base/cacheinfo.c
> @@ -58,7 +58,7 @@ bool last_level_cache_is_valid(unsigned int cpu)
> =C2=A0{
> =C2=A0	struct cacheinfo *llc;
> =C2=A0
> -	if (!cache_leaves(cpu))
> +	if (!cache_leaves(cpu) || !per_cpu_cacheinfo(cpu))
> =C2=A0		return false;
> =C2=A0
> =C2=A0	llc =3D per_cpu_cacheinfo_idx(cpu, cache_leaves(cpu) - 1);
> @@ -466,8 +466,7 @@ int __weak populate_cache_leaves(unsigned int cpu)
> =C2=A0static inline
> =C2=A0int allocate_cache_info(int cpu)
> =C2=A0{
> -	per_cpu_cacheinfo(cpu) =3D kcalloc(cache_leaves(cpu),
> -					 sizeof(struct cacheinfo), GFP_ATOMIC);
> +	per_cpu_cacheinfo(cpu) =3D kcalloc(cache_leaves(cpu), sizeof(struct cac=
heinfo), GFP_ATOMIC);
> =C2=A0	if (!per_cpu_cacheinfo(cpu)) {
> =C2=A0		cache_leaves(cpu) =3D 0;
> =C2=A0		return -ENOMEM;
> @@ -539,7 +538,11 @@ static inline int init_level_allocate_ci(unsigned in=
t cpu)
> =C2=A0	 */
> =C2=A0	ci_cacheinfo(cpu)->early_ci_levels =3D false;
> =C2=A0
> -	if (cache_leaves(cpu) <=3D early_leaves)
> +	/*
> +	 * Some architectures (e.g., x86) do not use early initialization.
> +	 * Allocate memory now in such case.
> +	 */
> +	if (cache_leaves(cpu) <=3D early_leaves && per_cpu_cacheinfo(cpu))
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	kfree(per_cpu_cacheinfo(cpu));

Since Borislav explicitly said you were not supposed to keep the tags,
I reviewed it again, and I'm OK to keep mine. Thanks!

Reviewed-by: Radu Rendec <rrendec@redhat.com>

--
Best regards,
Radu


