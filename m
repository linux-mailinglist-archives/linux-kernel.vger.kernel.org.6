Return-Path: <linux-kernel+bounces-536345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 500C0A47E6E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CF6B3B30F0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2FBA22CBC9;
	Thu, 27 Feb 2025 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZLuFVM23"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E3621ABBE
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740661211; cv=none; b=mCcptEeZJoycF2nx5c5eH6XJBt5vcMjOpHiGjkX/t39qX4bOx2qdftn9bvtd7u1tKXtoyU3ZmfSbj1GQI324m+bvGnyOzYO21rsaR13Gi6UiUZuk2qMRn3NESyW9FpESQ80dO+jZPpxC/U3jU5xLZWQxUEKRAcQE55Ik30ilVWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740661211; c=relaxed/simple;
	bh=XrLSTN02dFRcO/fXv16CTFH33qJLSqpqFHueqwiFOZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HD6HPpHoDC+OabLob5FDhT6kTlGnHKETXYpTVFB1urrupDrqDMBRhsAe15gtIgNGFn/m/t4JWjCAmylefzXuKW212Dg3vdOYq1KXEWmK0bixhHBjqQB62/AO933cXrV0zAl3GkMnSssAtSoxCW+QRrdwWj4gz+Dr2m/Kwb+Z1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZLuFVM23; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D06C4CEDD;
	Thu, 27 Feb 2025 13:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740661210;
	bh=XrLSTN02dFRcO/fXv16CTFH33qJLSqpqFHueqwiFOZw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZLuFVM23k0MYwthMW45SEF7SBL3/Ow9d7isJ3kC40fbPZ39d72tP3ysdiszNo+ggM
	 MHy5i2pHL61WX+YXyX/1Ad7StUOg7Tb2NIv1lbQZfyaWryfJjaka5ezzokdkc9M4zH
	 8f3Vj50nAE7wpOd4LQzfZWLBCJx9+VuX0NcIVDr97my2w26DtFJwN9QsVKimsaxRsj
	 mKGjhm3nSfGWJb2DXUPZ2eJvNRduwqutnRI4dZSZ2hRYaHfJtXiWOi9dXQqrcejKWH
	 zH6du15wY8RlAAEz2cQh+dFInMda9jLiox6SnkITFBLH9DRcabIY57vIg+u/NnQST4
	 2fLgN9xRhAyeQ==
Date: Thu, 27 Feb 2025 14:00:00 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Yu-Chun Lin <eleanor15x@gmail.com>,
	Kuan-Wei Chiu <visitorckw@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86/bootflag: Replace open-coded parity calculation with
 parity8()
Message-ID: <Z8Bh0BQssbZZQxeT@gmail.com>
References: <20250227125616.2253774-1-ubizjak@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227125616.2253774-1-ubizjak@gmail.com>


* Uros Bizjak <ubizjak@gmail.com> wrote:

> Refactor parity calculations to use the standard parity8() helper. This
> change eliminates redundant implementations and improves code
> efficiency.
> 
> [ubizjak: Updated the patch to apply to the current source.]

Please preserve the original From line in these cases - I fixed that 
up by adding:

  From: Kuan-Wei Chiu <visitorckw@gmail.com>

Probably the Git rebase/conflict-resolution step made you the author 
without warning.

Thanks,

	Ingo

