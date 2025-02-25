Return-Path: <linux-kernel+bounces-532255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A5FA44AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C93017FF33
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC661A2846;
	Tue, 25 Feb 2025 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnUklc5J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB631547F8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 18:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508621; cv=none; b=F9KnxCHesHfZmHg8HW5pooowbZ1qLewdjJycgZ73K3oyhGcoF4+0MxxFZkj16WyV4buVPNgO+gKArgK/iDGLU2GO3ZM4yjCFoFkT6o3UClfJs+Y8fm1Imxk/ehtFgM80uBGkf66sPaJI8zx54ICoacoEWJAL9WbGS6dT/4oeuUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508621; c=relaxed/simple;
	bh=rBJy6wiO9q7Tq7+S9OZe1plqy0M727RIRIhXQ9bTG88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cl2DrVoDKhtnoqOPS23jPyf5JC1ToP7/c1oJWQpWmZ2JW1L2NOpbY2QAv0/IJ/gFpz4rzqAUFsfDcCxoYgFiuE4ElZxHwrYheOIweVxyUhUObwPksHat/b6hm/R49lKoD4TQcUTyBpq5dqYTZDGjPilJVhWEIsH+/xpKlU43OIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnUklc5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5377AC4CEDD;
	Tue, 25 Feb 2025 18:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740508620;
	bh=rBJy6wiO9q7Tq7+S9OZe1plqy0M727RIRIhXQ9bTG88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QnUklc5Jy/mwDMSY09/1xFBNBAYL8JhI4CgDCcJsQbXsTfsGh6kzY78JiN1y+oLNa
	 nS2Iru2OLxFRuYTV+hCxrkZzoF1N6baOiNgkCVGimzBM1HrT/xDGLHPRhba6xlSbp8
	 E+V1A2tzZvWacbVeKsM3oeya7+t807MYZnbrFOWN3EfVSOUAO58JMs7JgJPCLyqO//
	 qODCAqPtr634b5GBvS9Ye9elv+hXIAYGn9GsRC188V6nEwDLdCa+TH5CiaIfENF/SX
	 wdQ8zbL0jkoNE6466B6ZUwGqwa+IUV+eZF41sRXgUjCBiw6s2fx7BH93y8s+PbftPO
	 tDszbRHhGHlbA==
Date: Tue, 25 Feb 2025 08:36:59 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/sched_ext: Provide consistent access to scx flags
Message-ID: <Z74Ny5KicQWh-o8q@slm.duckdns.org>
References: <20250224224959.264808-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224224959.264808-1-arighi@nvidia.com>

On Mon, Feb 24, 2025 at 11:49:59PM +0100, Andrea Righi wrote:
> Make all the SCX_OPS_* and SCX_PICK_IDLE_* flags available to the
> user-space part of the schedulers via the compat interface.
> 
> This allows schedulers / selftests to set all the ops flags in
> user-space, rather than having them split between BPF and user-space.
> 
> Signed-off-by: Andrea Righi <arighi@nvidia.com>

Applied to sched_ext/for-6.15.

Thanks.

-- 
tejun

