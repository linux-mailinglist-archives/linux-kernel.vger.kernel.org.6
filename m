Return-Path: <linux-kernel+bounces-285381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B2A950CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4E3C1C22E46
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE2B1A3BC7;
	Tue, 13 Aug 2024 19:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0NfnlrF"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDC61097B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723575857; cv=none; b=E9nwjnqIlkJQdITAFOpuCsA+jSfuZLLJp6GKHagyG9yzcPDoQ538bveeATcDFOtgV50k475atxMzDs+Hz3Ks4jbEN6hZqDKPuQ8sqQnuM9/cR1KLy+oIWpi/EvKJwu2wqEiAqIeEZEU/uz31N6E9GP+rdvGiU42VH4q1AuG8Vfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723575857; c=relaxed/simple;
	bh=DngfM7504RFdshdTxoUjceF4KJ/bZilO9ufue7YzFhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDYYygNgu59zypS7Grk50QCyBDL2pmH9PhGCONJ2IflM/kWgdK0yV1K0rtkif6O19msmNv01firpwaiJqHUNL8MCd5LQyYPZN3KhNGyiBaCKeWMbD6pkS/JjIyOIYna46ERkhz37wjwsCW3olwG+NSOcCCaVCpHr2uTwS/3AnB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0NfnlrF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fdd6d81812so57588755ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723575855; x=1724180655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwdyItdOBjgi7Kans4AaT44akFS7oahigY4s0qP0bFg=;
        b=j0NfnlrFY6sRsGaF7vYqamwkEb/rjugrbagxZywmngeyVkLvXfaNXnoZwxqUTtn2IV
         8pEVUtE92h9KkAcRp2kYtw5Q3w1/c2dHnLQdDWDspaUiSVFP8Wnq3GVpv966Gv9zLHSo
         8bDF/t3pZ/f9xelU/Q2PjL088fYkzjvqTUmQB32vWns3DvktCovUXJ7k0/wz7c3MVqxa
         MwlyC9jMPuYkXIiopodXDKeUEpq17zv2gKiXp8b9GjriqKdyRBpqWUcGy/TugsNKo+7P
         bXrAvZfZlspgDSSp33Xzu8n7G8NxTgsNlwfxxIL5dUYpGFCcdr58rT1ZMkjR2M7WLXNR
         5vjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723575855; x=1724180655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwdyItdOBjgi7Kans4AaT44akFS7oahigY4s0qP0bFg=;
        b=SmLuiK5c3tBn3GgobFwXSI/681v5IpsXUg48c/Q0mbBpYaqXqmPiWx8RmpBEGBOMVp
         kSIeCHYy95oEFdXSn5DRq6c3c+HctPsvjBhweBxvbQ31DJo+bxqv1ZUYv1BtPsjMXOjo
         sOQ/nHCPPRMSNRsQNQrHuQ5hwAE2jiqIClyQIIVEIiirH2BuS8oNbLIZNLKgvFkDx7NH
         qjyug3CJ8ig9YlShXhH7Jkrp8CAYmUj9Levga++KDUE6sG7Aiu8XFskFlKUxZBKkJZo4
         n1UYveBNcCua06+sFx09DLSO+x5ZryRRuVWD/Vv5kK8N+Bk0/O50Q4FjIOOX/+EoG5aL
         CkaQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOhbu4x+im+jSOe0kIgaI/3XZvH2r4Ev5YldgrAkaBQUHeA30Km9Lsn4p7N9aPp4tRtiDk0+FoNFlJ7IaXTMz/hODl5wlOHg2JijGU
X-Gm-Message-State: AOJu0Yw9QlN7NwcZyYaKkrjstUy+nYAtyDrmxs7S4MSna6A2Y0mUl4yK
	tAtj4NAb0xoUeHMMkAibY/osVb590AnBzXLx+xJlsVhQpWmXija5
X-Google-Smtp-Source: AGHT+IGYi8pBuIg2OuXLtnoHO8vZ9WW7IUFApPzkL3UnWEL4IRP8eJ/v1Sp03U4fV/oB07SrCBsbxA==
X-Received: by 2002:a17:903:18b:b0:1ff:3c4f:e93d with SMTP id d9443c01a7336-201d65c09f4mr5832055ad.55.1723575854779;
        Tue, 13 Aug 2024 12:04:14 -0700 (PDT)
Received: from localhost (dhcp-72-235-129-167.hawaiiantel.net. [72.235.129.167])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1cbae3sm16976035ad.279.2024.08.13.12.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:04:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 13 Aug 2024 09:04:13 -1000
From: Tejun Heo <tj@kernel.org>
To: Manu Bretelle <chantr4@gmail.com>
Cc: void@manifault.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: define missing cfi stubs for sched_ext
Message-ID: <ZruuLRv2h6RYWAFb@slm.duckdns.org>
References: <20240813185625.535541-1-chantr4@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813185625.535541-1-chantr4@gmail.com>

On Tue, Aug 13, 2024 at 11:56:25AM -0700, Manu Bretelle wrote:
> `__bpf_ops_sched_ext_ops` was missing the initialization of some struct
> attributes.
> With
> https://lore.kernel.org/all/20240722183049.2254692-4-martin.lau@linux.dev/
> every single attributes need to be initialized programs (like scx_layered)
> will fail to load.
> 
>   05:26:48 [INFO] libbpf: struct_ops layered: member cgroup_init not found in kernel, skipping it as it's set to zero
>   05:26:48 [INFO] libbpf: struct_ops layered: member cgroup_exit not found in kernel, skipping it as it's set to zero
>   05:26:48 [INFO] libbpf: struct_ops layered: member cgroup_prep_move not found in kernel, skipping it as it's set to zero
>   05:26:48 [INFO] libbpf: struct_ops layered: member cgroup_move not found in kernel, skipping it as it's set to zero
>   05:26:48 [INFO] libbpf: struct_ops layered: member cgroup_cancel_move not found in kernel, skipping it as it's set to zero
>   05:26:48 [INFO] libbpf: struct_ops layered: member cgroup_set_weight not found in kernel, skipping it as it's set to zero
>   05:26:48 [WARN] libbpf: prog 'layered_dump': BPF program load failed: unknown error (-524)
>   05:26:48 [WARN] libbpf: prog 'layered_dump': -- BEGIN PROG LOAD LOG --
>   attach to unsupported member dump of struct sched_ext_ops
>   processed 0 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
>   -- END PROG LOAD LOG --
>   05:26:48 [WARN] libbpf: prog 'layered_dump': failed to load: -524
>   05:26:48 [WARN] libbpf: failed to load object 'bpf_bpf'
>   05:26:48 [WARN] libbpf: failed to load BPF skeleton 'bpf_bpf': -524
>   Error: Failed to load BPF program
> 
> Signed-off-by: Manu Bretelle <chantr4@gmail.com>

Applied to sched_ext/for-6.12.

Thanks.

-- 
tejun

