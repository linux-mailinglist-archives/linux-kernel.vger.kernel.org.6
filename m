Return-Path: <linux-kernel+bounces-560851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4963A60A29
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E29D16E732
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3990A18892D;
	Fri, 14 Mar 2025 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slrqn5rS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9005C158870
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938039; cv=none; b=SLPi5xoeMMSLuBbBnefCDNAn37iSkDrqX+rVhMoJ4rnlfy/6C1KTCXTQYOPt9c+p4/YdFOYP2ohX7w1Jkbgz9m7df1qZh1Z0CIGcj/2y9tx4U3PqM9Jfa88MgDXXmkSQeMbk4rtUP95R/nj7xVSPp2ZEzCW/ND3xckHgLJcOukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938039; c=relaxed/simple;
	bh=cZHObQyc4WIrTAFoYw+ZBLwnZMrRJxIHZxIxht/mE34=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fSb7xuOEVEMfA1ktXKJZQD0iCcxpTNLTWhCUiy6ccLNH/9dKRn7a4Wr+owHa84EMxeUTSumgyY3xFyHTUIcY2gmrk8S3A13Jfqtzkm2Q4BzB/9EFyMunpXNdput1/UyGu3dNS3wJVKFxKZIOMCmYVC+5fVpztb8Wr8QbG3z+3Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slrqn5rS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C2CC4CEE3;
	Fri, 14 Mar 2025 07:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741938039;
	bh=cZHObQyc4WIrTAFoYw+ZBLwnZMrRJxIHZxIxht/mE34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=slrqn5rSprDoCRW37ehneMOSF/4zeDbuA/8+MwVmT03/JpailkBFrOdPFVPGwJHay
	 vnhcaD+TlbvL7VyIbaZiKfv2UrCrACOXIj6dd36+9fTjjbJt0FXbN9FAxAnZcUGbwh
	 FIPhVPvYCAGbE79OfShlWbOeKoZafz28W+t095NishYtkFFqlK/VUd30Js1ovcktt0
	 kzxgf2s6XOK1TCHjSZYXJyIx54D29Sb52pqqBHrKVVz9p2cS1LEj8XdhFgpOYRSko4
	 wdk4wb8bpaJmsVTct8Giw4ID4yVc5Wxb4JG1XFyJnDCgrKqM4cOsP7Rl9GV7xgl/XE
	 nJxlc4uFFDIew==
Received: from disco-boy.misterjones.org ([217.182.43.188] helo=www.loen.fr)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tszem-00DSa3-IQ;
	Fri, 14 Mar 2025 07:40:36 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 14 Mar 2025 07:40:36 +0000
From: Marc Zyngier <maz@kernel.org>
To: Will Deacon <will@kernel.org>
Cc: James Clark <james.clark@linaro.org>,
 linux-arm-kernel@lists.infradead.org, robh@kernel.org, broonie@kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland
 <mark.rutland@arm.com>, Oliver Upton <oliver.upton@linux.dev>, Anshuman
 Khandual <anshuman.khandual@arm.com>, James Morse <james.morse@arm.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] arm64/sysreg: Enforce whole word match for
 open/close tokens
In-Reply-To: <20250313215622.GA8101@willie-the-truck>
References: <20250115162600.2153226-1-james.clark@linaro.org>
 <20250115162600.2153226-3-james.clark@linaro.org>
 <20250313215622.GA8101@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <36968527640d231882444ba7065317fe@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 217.182.43.188
X-SA-Exim-Rcpt-To: will@kernel.org, james.clark@linaro.org, linux-arm-kernel@lists.infradead.org, robh@kernel.org, broonie@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com, oliver.upton@linux.dev, anshuman.khandual@arm.com, james.morse@arm.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On 2025-03-13 21:56, Will Deacon wrote:
> On Wed, Jan 15, 2025 at 04:25:56PM +0000, James Clark wrote:
>> Opening and closing tokens can also match on words with common 
>> prefixes
>> like "Endsysreg" vs "EndsysregFields". This could potentially make the
>> script go wrong in weird ways so make it fall through to the fatal
>> unhandled statement catcher if it doesn't fully match the current
>> block.
>> 
>> Closing ones also get expect_fields(1) to ensure nothing other than
>> whitespace follows.
>> 
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>>  arch/arm64/tools/gen-sysreg.awk | 31 +++++++++++++++++--------------
>>  1 file changed, 17 insertions(+), 14 deletions(-)
>> 
>> diff --git a/arch/arm64/tools/gen-sysreg.awk 
>> b/arch/arm64/tools/gen-sysreg.awk
>> index 1a2afc9fdd42..f2a1732cb1f6 100755
>> --- a/arch/arm64/tools/gen-sysreg.awk
>> +++ b/arch/arm64/tools/gen-sysreg.awk
>> @@ -111,7 +111,7 @@ END {
>>  /^$/ { next }
>>  /^[\t ]*#/ { next }
>> 
>> -/^SysregFields/ && block_current() == "Root" {
>> +$1 == "SysregFields" && block_current() == "Root" {
> 
> Stylistic nit, but could you just do:
> 
> 	/^SysregFields$/ && block_current() == "Root" {
> 
> instead? That way the diff is smaller (well, same number of lines) and
> you avoid the ugly $1.

The code is trying to match the first field of a line such as:

SysregFields	ZCR_ELx

while you seem to try and match a SysregFields all alone on a line.

That being said, my perl-foo is sub-zero, so I may be very wrong myself.

         M.
-- 
Jazz is not dead. It just smells funny...

