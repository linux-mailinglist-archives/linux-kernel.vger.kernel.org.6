Return-Path: <linux-kernel+bounces-534012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA83AA4617A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCD4716D4EC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 13:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9EC2206AC;
	Wed, 26 Feb 2025 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="ARBcjjxj"
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1577D2A8C1;
	Wed, 26 Feb 2025 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578302; cv=none; b=GJg4+aWYG6Cujp3YZsF2vdDurqF1qSXJ98rZI7Uvt3gabbysiWa6YgFaHIqbQIBi9j5XE7khNQLkjYclfNWrANA6WJaqtsGyc038iR6nL+2ES0fWIKmrkisFH+8neqOJD42K+CQvM5mNUbzznsCzgeLSf26d0AMFzzEHMoE37ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578302; c=relaxed/simple;
	bh=/j3lfjiqZcqvT2PQ/eFP1OvhpNaj8E0n8/XSKRiemls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idE683Cf1J5iXqbavT0RCxQmSHyjptIJ31SOXZObtFVwRBK2VbixnAoU9bCM7ZbBi5683T4gfJNhhJYs0RfOb7IiWmZIVPgLVKfnwhOEgON1q6iKxr0m3+E/PTGSl9WDQPgjlBOPgUrEGdn5WY1+IXlcEF/uulLYatCiQKHYYY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=ARBcjjxj; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
	by mail11.truemail.it (Postfix) with ESMTPA id 07EF21FA03;
	Wed, 26 Feb 2025 14:58:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1740578290;
	bh=aP6mxVVWGR41Jkq1evaS9h/uHkl+eQ+MTfh6T74pxV8=; h=From:To:Subject;
	b=ARBcjjxjRLi/5qeEScXdQpOXS1gpU4Xl0IjbemuUtzrPJWCIWFR7TkZvDT2abRewk
	 1CXGVzZDpIabcSwBUEOfBoe/gbGk4NgwPcFvyyNB1PP/FIxHbJTxUKQ6pqJoVvF2qJ
	 WqxZYQF3poNsPcPBBYRLuFihVVgjjD2Dn4v3TT3ug1kKPSWaNErAV+o1UA1wOnpiet
	 rVL9o/pP8c02k7Gpu01PDMfw6hVSPz1j6vJdo89gosKpWCPKuwX6JhFB/VSUKyeSoD
	 NIELb7GDbh/VZWR96MEGFE5Ik6fdig0zQV6l3R4Z2/TbreVktUHBndS7cgQealaTeX
	 stmWXTxNs7tjw==
Date: Wed, 26 Feb 2025 14:58:06 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Farouk Bouabid <farouk.bouabid@cherry.de>,
	Quentin Schulz <quentin.schulz@cherry.de>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: amc6821: add PWM polarity
Message-ID: <20250226135806.GA47264@francesco-nb>
References: <20250224180801.128685-1-francesco@dolcini.it>
 <20250224180801.128685-2-francesco@dolcini.it>
 <20250226134922.GA1944823-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226134922.GA1944823-robh@kernel.org>

On Wed, Feb 26, 2025 at 07:49:22AM -0600, Rob Herring wrote:
> On Mon, Feb 24, 2025 at 07:08:00PM +0100, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > Add property to describe the PWM-Out pin polarity.
> 
> Why doesn't the invert support in the pwm binding work for you? Yes, I 
> read the discussion, but don't remember the conclusion and you need to 
> justify it here.

This chip is not a PWM controller, it is a FAN controller.

The HW has a PWM pin output that is used to control the fan, but the
device is not modelled as a PWM controller (correctly, given that is not
such a device) and the OS does not control the PWM, the chip reads the
temperature and decide the PWM duty cycle accordingly in an autonomous
way.

It's just the same that was done in commit ed39ff506adb ("dt-bindings:
hwmon: Document adt7475 pwm-active-state property").

Francesco


