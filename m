Return-Path: <linux-kernel+bounces-309810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 536539670AB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 12:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89022B2219A
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Aug 2024 10:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1C5155307;
	Sat, 31 Aug 2024 10:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b="PDRA8qaj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="su33q1Ve"
Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5864214EC64;
	Sat, 31 Aug 2024 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725098535; cv=none; b=BUdETpM4buBUMTptJhvY3iZHMGoWmZGIz5aykcKlhAMH0+pSn0fJ+XsJsAZy2kqNooslLf1SRKuFO9914+ZUwPKrpyD049Y61CW4Q2pKab6C6AQt+D92hS31XVzS8w5r55ULJ1EVcpzoAbt0ImhWjyvjmAlKGoo7f+xAvJyh/aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725098535; c=relaxed/simple;
	bh=L1TrhnEzb/1rX0rXhpXCcI8Yn5gO3/tLxhMYItfVpBM=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=r4QSMPAIHp7u1xWpyCuyOnO+Nfg/Kk8IrHbKJTH7xRGc/V5OLn4kQHmO+3Pef2mWRxt9HcZXUk6GSP/BP2OwZxkyr9ZnWMGZpdAY7QccryjEwi5LZZsYF30vkmJISArPozv774A8cDmKMtn34Rt3CKgl8occZGyYAA0ctZdQzXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev; spf=pass smtp.mailfrom=svenpeter.dev; dkim=pass (2048-bit key) header.d=svenpeter.dev header.i=@svenpeter.dev header.b=PDRA8qaj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=su33q1Ve; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svenpeter.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svenpeter.dev
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7279111404CA;
	Sat, 31 Aug 2024 06:02:12 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-06.internal (MEProxy); Sat, 31 Aug 2024 06:02:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1725098532; x=1725184932; bh=SiJOoaRUWDMyzY09vCov122wR1ISiGrU
	3Bq0OeXWJuo=; b=PDRA8qajO8vNSsN9HeCPgIkG3eXG1CUY+6zHuNBWgivuGHt+
	Y5L3/FOt5+vZUne6M2kfxJnP7wMLAUzQFKwmZBuR77ZdMR96vy1o1HkxEfNSLMyx
	66IHRZd8d+JqNnXKWH1pt9gIkl5Xk9E/NXu5VBhvCGb8KA2n9sXfoaC9fjL0J+tX
	B9tke3cWWCf9ikU8tVcaOfpNqHVq/vj/+AJai5UMBb7w3uv1+LP0WqdJNu9TFpgo
	Rcr6lqo8vBbsxJ4Y6/hwSHjK2iuvaAbUnjcohNFJD7EfBUOz3kH42/Rb2gt5jlVa
	cz9hebfOkijvVJ2VHhUrhfq9kc8tsBpzSBDe8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1725098532; x=
	1725184932; bh=SiJOoaRUWDMyzY09vCov122wR1ISiGrU3Bq0OeXWJuo=; b=s
	u33q1Ve5NbkE4NL7UhzjRUQ6GExngDnBuTp4+6GY4Yjr5V2hjyMVqonWr4oI6dEs
	EoN4lhc/NnGNmy37qiPgEVvpyJgUXkKe3L4aMKxz1rZzT1sO6lu63Se70XUh+tNL
	Z1JnTkzHo6FQAvfPWUIVq70fCfJCr0YIAp5NIwsIm6fENyiHC7qr56RBgvFPnXXI
	7V2I0Z3sfxHBEzxKzX81w+bbpkVNgf0wHFGKGn42hAZeB0ca0XBrIEs36pFjiw1w
	WqQMeWaLjZZ17s8GpaeLOJTIeBqZCKr+of313tNS9RaUNtjvcO9yhG1Pw6va//oU
	GloaMu9KhTmRr+O5o5Crw==
X-ME-Sender: <xms:I-rSZkvwd0QwGtLQ2H_oa5QibHnzz9-z6VIZLgpQEjMNZRbDsymqxg>
    <xme:I-rSZhfODsAPh-s3Q2HHIcJlyOL3TAxfMhNoB3liyIoEJGjWOum-y7lb1sOgBPykN
    jdl70E7U4IFD2-CCUE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefkedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedfufhvvghnucfrvghtvghrfdcuoehsvhgvnhesshhvvghnphgvthgvrh
    druggvvheqnecuggftrfgrthhtvghrnhepleefteeugeduudeuudeuhfefheegveekueef
    ffdvffektdffffelveffvddvueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepshhvvghnsehsvhgvnhhpvghtvghrrdguvghvpdhnsggprhgt
    phhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepthhofihinhgthh
    gvnhhmihesghhmrghilhdrtghomhdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepkhhriihkodgutheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslhhi
    nhhuthhrohhnihigrdguvgdprhgtphhtthhopehlihhnuhigqdgrrhhmqdhkvghrnhgvlh
    eslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegrshgrhhhisehl
    ihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepmihpohhsthhmrghrkhgvthhosh
    dsuhhpshhtrhgvrghmihhngheslhhishhtshdrshhrrdhhthdprhgtphhtthhopehmrghr
    tggrnhesmhgrrhgtrghnrdhsth
X-ME-Proxy: <xmx:I-rSZvzBCvrzIa_jlxWU74ro3fj5glk2kNt3tkbU7sXpaO6rw3Rm8w>
    <xmx:I-rSZnNsEMIYC0rFqBO2j-YruNH29eThIpPHBY7nxuknL3oekKa7Sw>
    <xmx:I-rSZk9DtVK7E2nlZpUkzgwYgRFdIHn24rztImkkDzBgnICI90LIuw>
    <xmx:I-rSZvU-YSFvAQVpeIgoaqDCOaEd-kqL1YoDkEsF0zqbSMrGiXNmuw>
    <xmx:JOrSZvWh5JJy9xK9Kvsrp14gOp7tXh7Fm-Ng8fRd1oqt06KLP3Ihtxr3>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5D1E9BA0069; Sat, 31 Aug 2024 06:02:11 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 31 Aug 2024 12:01:39 +0200
From: "Sven Peter" <sven@svenpeter.dev>
To: "Nick Chan" <towinchenmi@gmail.com>, "Hector Martin" <marcan@marcan.st>,
 "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, "Konrad Dybcio" <konrad.dybcio@somainline.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht
Message-Id: <43a31087-0e3a-4684-87e3-26c22bd5a4c9@app.fastmail.com>
In-Reply-To: <20240831055605.3542-6-towinchenmi@gmail.com>
References: <20240831055605.3542-1-towinchenmi@gmail.com>
 <20240831055605.3542-6-towinchenmi@gmail.com>
Subject: Re: [PATCH v2 4/4] irqchip/apple-aic: Only access system registers on SoCs
 which provide them
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Sat, Aug 31, 2024, at 07:48, Nick Chan wrote:
> From: Konrad Dybcio <konrad.dybcio@somainline.org>
>
> Starting from the A11 (T8015) SoC, Apple introuced system registers for
> fast IPI and UNCORE PMC control. These sysregs do not exist on earlier
> A7-A10 SoCs and trying to access them results in an instant crash.
>
> Restrict sysreg access within the AIC driver to configurations where
> use_fast_ipi is true to allow AIC to function properly on A7-A10 SoCs.
> As part of the restriction, the IPI-always-ack path in aic_handle_fiq()
> has been removed. If the code path were to be reached, the system is
> fast IPI capable and one of the fast IPI compatibles should be used
> instead.

The last part is a bit weird. This is really just a bug in the driver.
We either have a system with fastipi and then we can handle it.
Or we have a system without fastipi and we shouldn't even try to read
SYS_IMP_APL_IPI_SR_EL1.
Your first sentence  "Restrict sysreg access within the AIC driver to
configurations where use_fast_ipi is true to allow AIC to function properly
on A7-A10 SoCs." already explains what's going on here. You're fixing
a bug where we tried to access SYS_IMP_APL_IPI_SR_EL1 unconditionally.
It just didn't matter so far because there's only upstream support
for M1+ where SYS_IMP_APL_IPI_SR_EL1 always exist.

With a fixed commit message:

Reviewed-by: Sven Peter <sven@svenpeter.dev>

>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> Co-developed-by: Nick Chan <towinchenmi@gmail.com>
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>  drivers/irqchip/irq-apple-aic.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/irqchip/irq-apple-aic.c b/drivers/irqchip/irq-apple-aic.c
> index 01a3c79054f5..a6d812afb10d 100644
> --- a/drivers/irqchip/irq-apple-aic.c
> +++ b/drivers/irqchip/irq-apple-aic.c
> @@ -234,6 +234,7 @@ enum fiq_hwirq {
>  	AIC_NR_FIQ
>  };
> 
> +/* True if UNCORE/UNCORE2 and Sn_... IPI registers are present and 
> used (A11+) */
>  static DEFINE_STATIC_KEY_TRUE(use_fast_ipi);
>  /* True if SYS_IMP_APL_IPI_RR_LOCAL_EL1 exists for local fast IPIs 
> (M1+) */
>  static DEFINE_STATIC_KEY_TRUE(use_local_fast_ipi);
> @@ -550,14 +551,9 @@ static void __exception_irq_entry 
> aic_handle_fiq(struct pt_regs *regs)
>  	 * we check for everything here, even things we don't support yet.
>  	 */
> 
> -	if (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING) {
> -		if (static_branch_likely(&use_fast_ipi)) {
> -			aic_handle_ipi(regs);
> -		} else {
> -			pr_err_ratelimited("Fast IPI fired. Acking.\n");
> -			write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
> -		}
> -	}
> +	if (static_branch_likely(&use_fast_ipi) &&
> +	    (read_sysreg_s(SYS_IMP_APL_IPI_SR_EL1) & IPI_SR_PENDING))
> +		aic_handle_ipi(regs);
> 
>  	if (TIMER_FIRING(read_sysreg(cntp_ctl_el0)))
>  		generic_handle_domain_irq(aic_irqc->hw_domain,
> @@ -592,8 +588,9 @@ static void __exception_irq_entry 
> aic_handle_fiq(struct pt_regs *regs)
>  					  AIC_FIQ_HWIRQ(irq));
>  	}
> 
> -	if (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) == 
> UPMCR0_IMODE_FIQ &&
> -			(read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
> +	if (static_branch_likely(&use_fast_ipi) &&
> +	    (FIELD_GET(UPMCR0_IMODE, read_sysreg_s(SYS_IMP_APL_UPMCR0_EL1)) 
> == UPMCR0_IMODE_FIQ) &&
> +	    (read_sysreg_s(SYS_IMP_APL_UPMSR_EL1) & UPMSR_IACT)) {
>  		/* Same story with uncore PMCs */
>  		pr_err_ratelimited("Uncore PMC FIQ fired. Masking.\n");
>  		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
> @@ -830,7 +827,8 @@ static int aic_init_cpu(unsigned int cpu)
>  	/* Mask all hard-wired per-CPU IRQ/FIQ sources */
> 
>  	/* Pending Fast IPI FIQs */
> -	write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
> +	if (static_branch_likely(&use_fast_ipi))
> +		write_sysreg_s(IPI_SR_PENDING, SYS_IMP_APL_IPI_SR_EL1);
> 
>  	/* Timer FIQs */
>  	sysreg_clear_set(cntp_ctl_el0, 0, ARCH_TIMER_CTRL_IT_MASK);
> @@ -851,8 +849,9 @@ static int aic_init_cpu(unsigned int cpu)
>  			   FIELD_PREP(PMCR0_IMODE, PMCR0_IMODE_OFF));
> 
>  	/* Uncore PMC FIQ */
> -	sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
> -			   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
> +	if (static_branch_likely(&use_fast_ipi))
> +		sysreg_clear_set_s(SYS_IMP_APL_UPMCR0_EL1, UPMCR0_IMODE,
> +				   FIELD_PREP(UPMCR0_IMODE, UPMCR0_IMODE_OFF));
> 
>  	/* Commit all of the above */
>  	isb();
> -- 
> 2.46.0

