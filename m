Return-Path: <linux-kernel+bounces-341732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CBF98851D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 14:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DD22830CE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 12:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845B318C02E;
	Fri, 27 Sep 2024 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wz/6QDMy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C0618C00E
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727440649; cv=none; b=H7RnFleMTBlu8akCZTQqieg2TbBYIIJfpktmvWeAQF4ZAfypzFpYwye+w+1DfRa/KqTxnMEhGUunt+88JRFna9aiUP5kl2Z17w5/uv9U4ccf1QAg5l/ioezxc4kCEnY/J29s19+V+Y0VjwyRgo7l+QctdartWCnKPlTsqomXgC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727440649; c=relaxed/simple;
	bh=V93uE6y6ldXLVmqcJ2G1QfTb2tlyDZh2dP3zdydS+gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNGKoZCJFKwQTu/jOZY2ErF3d/9YnXbWxQBlpxNgO1D3vq8JaimdgrvvOfSzHiZ/MUl3F498Uh+4TGkK4neI1p4f8Dp3TnR0XNxcMXHl1GoI7SrXep1eE8qVxOOk3JWqlZypOUOoMxzvvtg+e1Xy6EcjVxDFtvOzkW9aEyPNEx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wz/6QDMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BF5C4CEC6;
	Fri, 27 Sep 2024 12:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727440648;
	bh=V93uE6y6ldXLVmqcJ2G1QfTb2tlyDZh2dP3zdydS+gM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wz/6QDMyisGxqVrrXimwr5/IQOMhXAt/2hU4mb0c0+5QngacqBrswN2V2mLQcydJT
	 tgogaSXE6KzaBZE2MN4ViHqa9JpiAE3gc1iaygWTmXy22hmNIHYEM3GBMeW8w/lyGT
	 fW2BJyraqnKzwbtwZ6ZJX/0wc3JpNtthyb3neUQo6aHXHXNqjam1F/6OSxlC7khKZc
	 GrR4pYSCpFuQU0kWyTCu4bf+MTsTn4FWrj0ik5ccoQNjpmW47lqKwKHpK1IZGRf2aJ
	 Zp8dudbbWbsq8zkYTu6gOedaDFKCkgQXHSGkerPIYehQRNm3cjWRfrJm9thLgbN27l
	 L1gJ/4rNgwLqg==
Date: Fri, 27 Sep 2024 14:37:26 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>,
	Oleg Nesterov <oleg@redhat.com>
Subject: Re: [patch v4 02/27] signal: Prevent user space from setting
 si_sys_private
Message-ID: <ZvanBnJrf8e2_d1A@localhost.localdomain>
References: <20240927083900.989915582@linutronix.de>
 <20240927084817.014903652@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240927084817.014903652@linutronix.de>


Le Fri, Sep 27, 2024 at 10:48:41AM +0200, Thomas Gleixner a écrit :
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The si_sys_private member of siginfo is used to handle posix-timer rearming
> from the signal delivery path. Prevent user space from setting it as that
> creates inconsistent state.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Funny that this field is exposed to userspace.

Anyway:

Acked-by: Frederic Weisbecker <frederic@kernel.org>

