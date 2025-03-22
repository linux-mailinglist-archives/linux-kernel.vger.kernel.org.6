Return-Path: <linux-kernel+bounces-572571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161FEA6CB90
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 17:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133153AF67D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Mar 2025 16:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A515123372A;
	Sat, 22 Mar 2025 16:51:49 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5852F2E;
	Sat, 22 Mar 2025 16:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742662309; cv=none; b=e5LWC6sqLFgFzHgybBCi8OjZZAGxTXYuToDKz0ZkF/94vKO/9+3gXxDz9GPmHL8vFAWj90OfUqWh5y8MNP3xWy0DkqYgWv+8Tr5LWcuLeFRaGlUhCAX22aDlnTblE3CoVpczewOBhley2nOesUwDFVQv5swV/u/QC9SVD9n3Nes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742662309; c=relaxed/simple;
	bh=YY0zwQFccafI0e+UieGhfuVrKOH9vs96kL6/Y4+N8aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nw67nqLUPpevfIGzG8E+FneICwIBZGYZgvQlP/505EcSmRI88bK/yF4vzWB65Xg9htGsqYmPJo1TMhO+iKosMWd/SdK1GyF/jp3qCeROGNt4yXHIUuk9YqpMyvtfBY4kIuPW2n9rt9HYnGrraAJG1SNS6Rdk7E6wP5VEeuMzMIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from localhost (unknown [116.232.48.233])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dlan)
	by smtp.gentoo.org (Postfix) with ESMTPSA id C4C90343231;
	Sat, 22 Mar 2025 16:51:45 +0000 (UTC)
Date: Sat, 22 Mar 2025 16:51:40 +0000
From: Yixun Lan <dlan@gentoo.org>
To: Alex Elder <elder@riscstar.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
	heylenay@4d2.org, guodong@riscstar.com, paul.walmsley@sifive.com,
	palmer@dabbelt.com, aou@eecs.berkeley.edu, spacemit@lists.linux.dev,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/7] dt-bindings: soc: spacemit: define
 spacemit,k1-ccu resets
Message-ID: <20250322165140-GYF11633@gentoo>
References: <20250321151831.623575-1-elder@riscstar.com>
 <20250321151831.623575-2-elder@riscstar.com>
 <20250321222546-GYA11633@gentoo>
 <1d79fb7e-4501-4c62-8379-f00515dec3e4@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d79fb7e-4501-4c62-8379-f00515dec3e4@riscstar.com>

Hi Alex:

On 09:27 Sat 22 Mar     , Alex Elder wrote:
> On 3/21/25 5:25 PM, Yixun Lan wrote:
> > hi Alex:
> > 
> > On 10:18 Fri 21 Mar     , Alex Elder wrote:
> >> There are additional SpacemiT syscon CCUs whose registers control both
> >> clocks and resets:  RCPU, RCPU2, and APBC2. Unlike those defined
> >> previously, these will initially support only resets.  They do not
> >> incorporate power domain functionality.
> >>
> >> Define the index values for resets associated with all SpacemiT K1
> >> syscon nodes, including those with clocks already defined, as well as
> >> the new ones (without clocks).
> >>
> >> Signed-off-by: Alex Elder <elder@riscstar.com>
> >> ---
> >>   .../soc/spacemit/spacemit,k1-syscon.yaml      |  13 +-
> >>   include/dt-bindings/clock/spacemit,k1-ccu.h   | 134 ++++++++++++++++++
> >>   2 files changed, 143 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> >> index 07a6728e6f864..333c28e075b6c 100644
> >> --- a/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> >> +++ b/Documentation/devicetree/bindings/soc/spacemit/spacemit,k1-syscon.yaml
> >> @@ -19,6 +19,9 @@ properties:
> >>         - spacemit,k1-syscon-apbc
> >>         - spacemit,k1-syscon-apmu
> >>         - spacemit,k1-syscon-mpmu
> >> +      - spacemit,k1-syscon-rcpu
> >> +      - spacemit,k1-syscon-rcpu2
> >> +      - spacemit,k1-syscon-apbc2
> >>   
> >>     reg:
> >>       maxItems: 1
> 
> . . .
> 
> 32
> >> @@ -180,6 +184,60 @@
> >>   #define CLK_TSEN_BUS		98
> >>   #define CLK_IPC_AP2AUD_BUS	99
> >>   
> >> +/*	APBC resets	*/
> >> +
> > I'd also suggest to drop above blank line, keep style consistent
> > with others in this file, some same below that I won't comment
> 
> OK, I'll fix the weird extra line and will drop these blank
> lines as you suggest in v2.  I'll post another version after
> Sunday.  I recognize the merge window means I can't expect
> reviews during that time, but this code is waiting for the
> clock code to get accepted anyway.
> 
no need to hurry, we will postpone clock to next merge window,
let's give more time for people to review, thanks

-- 
Yixun Lan (dlan)
Gentoo Linux Developer
GPG Key ID AABEFD55

