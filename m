Return-Path: <linux-kernel+bounces-303357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60485960B23
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D63C28133C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 12:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9E51BB6B7;
	Tue, 27 Aug 2024 12:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mxFOPqqE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4AC1A0715
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763220; cv=none; b=QIU2nsKLWmIZlQrkN+smHLYqkUvK/8qtqZsO58lznRZJXYKQqZIbRCICuHr5P2mQBR/d0NGilW3LQGP+7gAOikXDg/2BpXxw66ipbVRRBgxR6EwfFa31PjDV3CQLjo/xwV6QhhOd/er8HhqLpw0odPIn04ZT6JmlcRxjmy+OTtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763220; c=relaxed/simple;
	bh=y1WUu1jEStLUVI5qg4HDk+K18wMW0OvXnCReTnAjNZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EumnHO88kGkmo2G56r6/P/mU5Y7v1/eADZmeRU0lhsIfRVIi+avR7YEEzqTrgCuuu5RtF1EiAOwXXgL9EbOhBvqLMN7lOAWnApJsTBW6PT/ERX04c0yKSsvhNiYYjojAs6oLorQrG1YnurbLMGeBVfXW8Lam7gD3zMD8gyou76g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mxFOPqqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F09C6105D;
	Tue, 27 Aug 2024 12:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724763220;
	bh=y1WUu1jEStLUVI5qg4HDk+K18wMW0OvXnCReTnAjNZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mxFOPqqELuSLP3A0GzfeK1isECIgDfVOyMzXRQlpDlE5td3JdPslpGNHS/aBEOqTm
	 PoiHIbloJkUgAIDELfCqqLjp4B060qQemc9wc3XwzmSFmKS5VK3ZVEvZuH5JQdfQvN
	 cHoj5DPLWBq2x+QeHCvY3+W0oUmGzxJXDL6PvpNzspaD4vi5ihWiPLCA15vJPYIono
	 z/hbPY8MoNFrBriVkjsPSydjljktkb+4Am4OJW9PvQuRXdmLtsako2CZqiytnN6JaV
	 NeWPwutj5QepgD/ZovHDiJx5xCp+qhiPzPsnK1t/zMV8Si6g17UGWlwqjcedHNh3/n
	 nVghFDV7xzFfw==
Date: Tue, 27 Aug 2024 13:53:35 +0100
From: Will Deacon <will@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Atish Patra <atishp@atishpatra.org>, Anup Patel <anup@brainfault.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH -fixes] drivers: perf: Fix smp_processor_id() use in
 preemptible code
Message-ID: <20240827125335.GD4772@willie-the-truck>
References: <20240826165210.124696-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826165210.124696-1-alexghiti@rivosinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, Aug 26, 2024 at 06:52:10PM +0200, Alexandre Ghiti wrote:
> As reported in [1], the use of smp_processor_id() in
> pmu_sbi_device_probe() must be protected by disabling the preemption, so
> simple use get_cpu()/put_cpu() instead.
> 
> Reported-by: Nam Cao <namcao@linutronix.de>
> Closes: https://lore.kernel.org/linux-riscv/20240820074925.ReMKUPP3@linutronix.de/ [1]
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  drivers/perf/riscv_pmu_sbi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
> index 31a17a56eb3b..25b1b699b3e2 100644
> --- a/drivers/perf/riscv_pmu_sbi.c
> +++ b/drivers/perf/riscv_pmu_sbi.c
> @@ -1373,11 +1373,15 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>  
>  	/* SBI PMU Snapsphot is only available in SBI v2.0 */
>  	if (sbi_v2_available) {
> +		int cpu;
> +
>  		ret = pmu_sbi_snapshot_alloc(pmu);
>  		if (ret)
>  			goto out_unregister;
>  
> -		ret = pmu_sbi_snapshot_setup(pmu, smp_processor_id());
> +		cpu = get_cpu();
> +
> +		ret = pmu_sbi_snapshot_setup(pmu, cpu);
>  		if (ret) {
>  			/* Snapshot is an optional feature. Continue if not available */
>  			pmu_sbi_snapshot_free(pmu);
> @@ -1391,6 +1395,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>  			 */
>  			static_branch_enable(&sbi_pmu_snapshot_available);
>  		}
> +		put_cpu();

Are you sure it's safe to enable the static key with preemption disabled?
I thought that could block on a mutex.

Will

