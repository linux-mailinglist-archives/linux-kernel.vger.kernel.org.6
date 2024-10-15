Return-Path: <linux-kernel+bounces-365943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3511699EE3A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 15:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03110283A51
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C5C1B21AC;
	Tue, 15 Oct 2024 13:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCbD61NR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDCB1B219B;
	Tue, 15 Oct 2024 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000468; cv=none; b=VLuqdWn5ZkUSQ0+RgBAsFyHcoms1ObvX8WBXWHdRB2hoLX6pssq3284OmON7o0FORvEd94vVNAiRufvaRSC+M3By+K0UoXdGgjdhoppTdvLhTiwF8wYMZ0575Kx/oBEmuNK6O9IaFn/9gt2R8qnUrAxBMJNlN07HGKmdZS5bo/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000468; c=relaxed/simple;
	bh=tIsMM7fX/CrMgwmOAdB9kTlSRTDalPOoc2fQSb66mKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnPcftpt2MW80PGL6dHeirerFI4VSM0BfK8A/f21UCqefx82vpzMlyfJThjNqLT3lunuO5yJjadsVwElmPTy6u1DlAbrZP0zsotQHl+64ibciPwHTJZ8RbzvMRmo3266QWIoIdVEKZGGHgkDhua/LbEInGEEZAApMMPDtvESe5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCbD61NR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1939CC4CED1;
	Tue, 15 Oct 2024 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729000467;
	bh=tIsMM7fX/CrMgwmOAdB9kTlSRTDalPOoc2fQSb66mKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eCbD61NRnFFntH0NX/eddn0x3225iMNzntGFOyJjmbT0eiLZZqww1thuJSGRYKhed
	 FudtrU9x5Dsav8253kwjtRDC4ZBzU5+xUztMMfCSe7CwydaW2FTWlc0IEKCTZhXwvn
	 skdjHbSevEY2qixx8NLqs81jFKDTLDMEBwLa2IitGijMQiKJT529jWcvWzhyBlH20/
	 bot7hNxRjEZEl4zX/MPLwAdjEfLCqHd1pgXRIL7j1Tc2vO+m8ZE85ctmPIJOLJW4QH
	 9vITjCng2aWpnvEa6mZYZqWfvSpgDPMlW4HSlRVj7rxYrnnTtaGigwPyGO5jxyzD8B
	 qHy1KoUQBXKFA==
Date: Tue, 15 Oct 2024 15:54:24 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH v3 09/16] timers: Add a warning to usleep_range_state()
 for wrong order of arguments
Message-ID: <Zw50EGyh3DwA8wX4@localhost.localdomain>
References: <20241014-devel-anna-maria-b4-timers-flseep-v3-0-dc8b907cb62f@linutronix.de>
 <20241014-devel-anna-maria-b4-timers-flseep-v3-9-dc8b907cb62f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241014-devel-anna-maria-b4-timers-flseep-v3-9-dc8b907cb62f@linutronix.de>

Le Mon, Oct 14, 2024 at 10:22:26AM +0200, Anna-Maria Behnsen a écrit :
> There is a warning in checkpatch script that triggers, when min and max
> arguments of usleep_range_state() are in reverse order. This check does
> only cover callsites which uses constants. Add this check into the code as
> a WARN_ON_ONCE() to also cover callsites not using constants and fix the
> miss usage by resetting the delta to 0.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

