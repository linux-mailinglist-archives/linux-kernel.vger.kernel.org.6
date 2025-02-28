Return-Path: <linux-kernel+bounces-538158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB81A49530
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 10:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B21E3B9A41
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FA62580C4;
	Fri, 28 Feb 2025 09:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpzoQXNN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686701EBFE0
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 09:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740735191; cv=none; b=RQEYpgo3ucIQa/Txx0GAL43Le4zKS91GEx7buEWWkHhgeQ+UQnuL46pCiiTwUFEGYdcKA7MlMKRfs3V8HD2RsYKBTjcy1yHgkB+4IEOL5mwY09Z9gw9oeUDaUtNX7db7VP4Tiw1iAPrXwJk45MBwnq9IHigEnGW5+s6AQnlQW2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740735191; c=relaxed/simple;
	bh=AY9OvS1AvX+5A9DhNYI+M1ljpVODYov13OWLY0qSWaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpItnfqiiqV6qGQY3IKFmaW5f+XZqWll1FDg9UtgnewglQYZzubK1OS27aFr8OB155oZ8L8bCbMx4Q4/Tjh4WMBbzb8GiR032tkO+zGzhXWPMECtzZLJm5nomaviNqFkxX7m2OBH5YaKd07cBpFFFHMzg0X2KWiGOTbkhtMlxgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpzoQXNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64CF8C4CED6;
	Fri, 28 Feb 2025 09:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740735190;
	bh=AY9OvS1AvX+5A9DhNYI+M1ljpVODYov13OWLY0qSWaA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MpzoQXNNXOlQq1SG3rvBXoBlOI5KG8zuCluMgvmPgd9HiuCd+3ZW+ORk4Cqjozyb0
	 lejGsbXLBX2W0n/CLdWb51+rkGthNmjwGk0aDicY472zCdsC21P0PEmLd/IRJ5W0Lm
	 q/jb5nDnirzEQTDoM7DizvMZ+I2pttkWR6ZES7yEA1+AcmI4ORLq/o1Lhu34BCCRKB
	 NZ6MQ0Vpbwmb4B9aV8SkDxF2KSgG8asXB273nUsLFbs4ECJD3JibzOXZdLT7e75VbC
	 0sp1sEiq2EfLl12KotpzU4/5AxbUdMDdgUJwuPW7nx3+0o7ATmdjdi/0vMrGylb69H
	 /Cxw2yeQ31kMw==
Date: Fri, 28 Feb 2025 10:32:59 +0100
From: Ingo Molnar <mingo@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
	hpa@zytor.com, linux-kernel@vger.kernel.org, zhanjun@uniontech.com,
	niecheng1@uniontech.com, chenlinxuan@uniontech.com,
	Huacai Chen <chenhuacai@loongson.cn>,
	Wentao Guan <guanwentao@uniontech.com>
Subject: Re: [PATCH] x86/srat: Conditional apic_id vs MAX_LOCAL_APIC
 comparison
Message-ID: <Z8GCyyt0Dud0kvwq@gmail.com>
References: <E053FB6951F019A2+20250228051847.50002-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E053FB6951F019A2+20250228051847.50002-1-wangyuli@uniontech.com>


* WangYuli <wangyuli@uniontech.com> wrote:

> The apic_id employed within the acpi_numa_processor_affinity_init()
> function is derived from the acpi_srat_cpu_affinity structure defined
> in acpi/actbl3.h.
> 
> When CONFIG_X86_X2APIC is not enabled, its maximum value is limited
> to 255.

How does the compiler know the value is limited to 0-255?

<acpi/actbl3.h> has an u32 apic_id field:

 struct acpi_srat_x2apic_cpu_affinity {
        struct acpi_subtable_header header;
        u16 reserved;           /* Reserved, must be zero */
        u32 proximity_domain;
        u32 apic_id;
        ^^^^^^^^^^^^
        u32 flags;
        u32 clock_domain;
        u32 reserved2;
 };

and the apic_id local variable in acpi_numa_processor_affinity_init() 
is an 'int':

        int apic_id;

Neither is limited to 0-255.

Thanks,

	Ingo

