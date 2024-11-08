Return-Path: <linux-kernel+bounces-402274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 054879C25B5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C274D282178
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49161AA1F9;
	Fri,  8 Nov 2024 19:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSb9x0GU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B3D1AA1DD;
	Fri,  8 Nov 2024 19:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731094966; cv=none; b=uOXnR04U1mcYNwKaHNf02tr9kzx7jccn0io4FGdj+3hk6dNmEkACarP5twLPQuH8FlBLEG5K4o0Mzak5ID+U+5aTXB03fyw3Tbb3gRIRxvehYkeCSzRX/cG5uI5NtUQeC/i1ccYm7DfthQzrpCMoJlMuH+wuCAmgbFHnXCtIvCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731094966; c=relaxed/simple;
	bh=wc/0U0agYo2e1dSD9uCnBCKEtXgVgG6L+AYjpQaiHwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUBZD6Gz7dZbylcf9yKT5ZbRLtyeOEGWCKHcuUerXF50BUZjojJrcgHx0x/oNc7ETYE1fAf8oLdFhr9JUW0fWdapheWfQJh16azsmCX7hbWGNdiDO8ywjtLnagC/4KKiV8fDf5ZbKl45HrAhtGSoC64hEq34F9bmWKW2tYcImAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSb9x0GU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A625C4CECD;
	Fri,  8 Nov 2024 19:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731094965;
	bh=wc/0U0agYo2e1dSD9uCnBCKEtXgVgG6L+AYjpQaiHwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HSb9x0GUG8/XdJI4Vpm8/cM5rwOMxhAtW6OstK4S1N0eRN5CTV2QFn0q09sYy+mey
	 cKnhl2uiYsrhi+XLanNdf17pkJoTpUs67zulx+YDrVWGmo7mkbbRVSMxmsXGO5EA7F
	 bBFqr1ow5LThs8e0cobF9DOipWXdFw8nQWkPTckdW7fRhadjFk8PZoGcQM0atHUkm8
	 1EeEM6aw9+65O4rj4vRyTxM87WCGRSAB3HAg1VK191v5z/VPEVq2KA/pXBRsE71Y7h
	 knAcfbQqihIloFFML5Eq5gv2iYhXvUpu6NEXt51M0bZKHsm5iEZlN2P7SKqi7fvaAi
	 IRcbqtUTQArqQ==
Date: Fri, 8 Nov 2024 09:42:44 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v3 sched_ext/for-6.13] sched_ext: Do not enable LLC/NUMA
 optimizations when domains overlap
Message-ID: <Zy5ptHdJaU1aHzaK@slm.duckdns.org>
References: <20241108000136.184909-1-arighi@nvidia.com>
 <20241108181753.GA2681424@thelio-3990X>
 <Zy5eadwAuQSzqp-1@slm.duckdns.org>
 <Zy5o44PLucx52Fp1@gpd3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy5o44PLucx52Fp1@gpd3>

On Fri, Nov 08, 2024 at 08:39:15PM +0100, Andrea Righi wrote:
> Sorry, this is a mistake, it definitely needs to be &&.
> 
> Do you want me to send a fix on top of this one or a v4?

An incremental fix patch would be great.

Thanks.

-- 
tejun

