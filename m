Return-Path: <linux-kernel+bounces-351560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17968991319
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 01:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B69571F24269
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 23:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687BF154452;
	Fri,  4 Oct 2024 23:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoWaaDZA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA0414D2A2;
	Fri,  4 Oct 2024 23:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084942; cv=none; b=pEvixiPfSDpuYfpZ0RPiTuVVdRdjYbaPY3VVLjQ/OSM8fKnAe4lBMP2QfuMo9zMvZOcwDfEpBlNsEYwkLVHH0qSliRtU739cUENvVCP5uQw+URBjl/dqc5lyUQUvDcRO+aS3k9wBIEaX9rEzrnwr67l9mCjCJmKAexGfcqJ3fRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084942; c=relaxed/simple;
	bh=TmZdt4YrxSW66wSdXAP4jMF4ARTNkpjzkEfl0g9jPe8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dYY1UPISxC7MP9C6vfmI7s827RLTBD2IMtRqA0CD8FFq6Ijrb+mNLq88ZzNe//hIwaORawgSUi0Xi+XH70naJMAvqMvJ4Fbw5pvMYTmx131we01VX81UDQAPvYrrII0cOmd+MteO2Sl+qWZ8BS/lpOwgQf6yIRN7t9lAuGBvxq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoWaaDZA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8F3C4CEC6;
	Fri,  4 Oct 2024 23:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728084942;
	bh=TmZdt4YrxSW66wSdXAP4jMF4ARTNkpjzkEfl0g9jPe8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RoWaaDZAT9Wi2hLxme4lNt5xHJAiH0L80Q6zTeny6T4fOtiR8AUQkgG+qPNlmMo33
	 ZJLLelWxt4jrTmDr/KRjommc/cITOLc4h3rc81md00hRZMFZNYenpTyxbiPi+irxKy
	 Q5I+w5NfCgtkWeH3pl/Y8vd0w5XEd5Y4VHEKrZccFkr45rAsZY/y0OxaW5qiH6p+vl
	 YcaDXEQVTKasYwoYgto9DJe6PAapV/GP6AflDWV+rBVilOJP70C+ZCUZ9v9+ZhL1JM
	 vf8XPc/ckmEZWl+OFFOwP54DRKuIDAYcIQdiQrpbEk7OlYGzdW+5qB+OG3i1uYM4ok
	 1Q1g7uS756iYg==
Date: Fri, 4 Oct 2024 16:35:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net,
 chunkeey@gmail.com
Subject: Re: [PATCH net-next v3 16/17] net: ibm: emac: mal: add dcr_unmap to
 _remove
Message-ID: <20241004163541.67a15dd3@kernel.org>
In-Reply-To: <20241003021135.1952928-17-rosenp@gmail.com>
References: <20241003021135.1952928-1-rosenp@gmail.com>
	<20241003021135.1952928-17-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Oct 2024 19:11:34 -0700 Rosen Penev wrote:
> It's done in probe so it should be done here.

second done -> undone ?
Also is this not a bug fix?

