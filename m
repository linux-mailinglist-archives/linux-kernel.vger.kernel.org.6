Return-Path: <linux-kernel+bounces-273829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8583946EA9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 14:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3121F215E3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 12:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A9E36AFE;
	Sun,  4 Aug 2024 12:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="FiwzAA3p"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E0411711
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722774637; cv=none; b=ZqJ8Imgds6o3ZbQA5sS9rFs4aRDTCJs8Gi8cMhzSeWkM5Fe0jx1vYt2yfyqhveRAdLIgyM9b5kDZ0dPcYLNYwBUDAPy9TZvmC/f6X/R1WNoZ9jilv2U/ylEpQrBCTy15T5JFUNepSo1bkSawiY1mIeZkVWzK5h/j0q+QyPv1hEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722774637; c=relaxed/simple;
	bh=O/ZJKgyGcWkgyEe6drwP7sHZANj6eLTthhNHl8yhQfE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAfOqUiPur4uYTlAgbA/h73prZdVhs9I9h0LBM+PLTrVru8U8DijMtcTZrkndzRTU4bqD1MVeoFx9bSsrxnzMCBGxeEIIXGDsRe8JQErrNiYSWS2WJRhFirGUdk8Qrclk3j/8E0iVu8ZsiBoBt6J6ZAR0x23S1n2dz9cnV+oqxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=FiwzAA3p; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1722774634; x=1723033834;
	bh=2q5zfcHDeLqkepGzsP16dnYhPXVBScaJkaul1z59vew=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=FiwzAA3pRggcOqW2No39gpN3H25Xen5/++7vr3PYM6XoMpoBc0pZtgpDJAlUt66Sb
	 t6nFjzlTRw7ZWMvNj0CReAb88so1WUHQ4hqEV2u/sn2b09sRj+X5kQrAl5pZ8N+3fw
	 sYV0VU4TJJyIPmMXyBqrj8eiR+Av7tZIO+q0ZAACHBuUFy/45bp1S1Pn2vth6SZJGE
	 cr5QiDraB35HN406myiXTLNknLUbFgE+phiHE3TK5JIk16iuVmMrPFxTPnNkN73l4Y
	 yLq154/ATgwoMM2t6O3Z7A/Gp52yYBNKHVo5xiEOfN2pDtKCMYj2e9ijIqObEKx/MX
	 J8W8WSVvzeTHQ==
Date: Sun, 04 Aug 2024 12:30:30 +0000
To: Krzysztof Kozlowski <krzk@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Harry Austen <hpausten@protonmail.com>
Cc: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 5/9] dt-bindings: clock: xilinx: add description of user monitor interrupt
Message-ID: <D374MXWNT0LZ.29SG3SJ1O4VXM@protonmail.com>
In-Reply-To: <5948f7b2-b4dc-4225-9f88-0d5da647d84c@kernel.org>
References: <20240803105702.9621-1-hpausten@protonmail.com> <20240803105702.9621-6-hpausten@protonmail.com> <5948f7b2-b4dc-4225-9f88-0d5da647d84c@kernel.org>
Feedback-ID: 53116287:user:proton
X-Pm-Message-ID: 1ed5efc5a0e33ab2beedf461eb5e0547e37c050e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Aug 4, 2024 at 10:04 AM BST, Krzysztof Kozlowski wrote:
> On 03/08/2024 12:58, Harry Austen wrote:
> > This Xilinx clocking wizard IP core outputs this interrupt signal to
> > indicate when one of the four optional user clock inputs is either
> > stopped, overruns, underruns or glitches.
> >
> > This functionality was only added from version 6.0 onwards, so restrict
> > it to particular compatible strings.
> >
> > Signed-off-by: Harry Austen <hpausten@protonmail.com>
> > ---
> > v1 -> v2: Fix binding errors by moving interrupts up front, restrict la=
ter
> >
> >  .../bindings/clock/xlnx,clocking-wizard.yaml  | 25 ++++++++++++++++++-
> >  1 file changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/clock/xlnx,clocking-wiza=
rd.yaml b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> > index 9d5324dc1027a..9e5078cef2962 100644
> > --- a/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> > +++ b/Documentation/devicetree/bindings/clock/xlnx,clocking-wizard.yaml
> > @@ -39,6 +39,14 @@ properties:
> >        - const: clk_in1
> >        - const: s_axi_aclk
> >
> > +  interrupts:
> > +    items:
> > +      - description: user clock monitor interrupt
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: monitor
> > +
> >
>
> Why multiple blank lines? Only one.

There were two blank lines here previously. I assumed it may have been to
separate out the vendor specific properties. Will remove in v3.

>
> >    xlnx,speed-grade:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> > @@ -62,17 +70,32 @@ required:
> >    - xlnx,speed-grade
> >    - xlnx,nr-outputs
>
> With above fixed:
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks!

>
> Best regards,
> Krzysztof



