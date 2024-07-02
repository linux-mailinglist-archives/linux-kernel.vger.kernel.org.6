Return-Path: <linux-kernel+bounces-237269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8A891EE57
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E74A1C21226
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 05:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040C83EA9A;
	Tue,  2 Jul 2024 05:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xEYNKbyx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204CD282E1
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 05:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719898393; cv=none; b=nCmDJOljotfZ5Tiya5+RJfvQiZwrIkrJo6IETgWSEthlXuum4rt1MgW1jWd/XxT1CCu3/A+IUgab58TjegjNaxk3zuncQpP3kn39gV6IwVpfncsBi0IY/VuCf7a94eGXOkO03PPAPBMAZLb09eyx1C0mtI7mGS0C3+Ozw1GJsyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719898393; c=relaxed/simple;
	bh=YzXHc2kguAymYpIw7ftn/Y44XL6+Z2gZJcj9VYnpoCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFeQm87UuSuanzpuefPYpsnZif3b3RCFbDGk7el4BLIxKgyKEtRSegN93RxTz+1jxX8AVpUHgWjXbIlNjd5XA4xuy2vmUtWu7djSdnbdUwR5xEOlmpCGgmypsKxi+u/ZuvMclZDTPbH6/u0r3p00fZNJ6jHSpoU1iGv4EaOwqYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xEYNKbyx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E7CC116B1;
	Tue,  2 Jul 2024 05:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719898392;
	bh=YzXHc2kguAymYpIw7ftn/Y44XL6+Z2gZJcj9VYnpoCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xEYNKbyxrwInt0vOuXjkQq0S/FWVdp4hHK71mPY7sF3Kyta6gGCVFsKpBFKWhkLUH
	 KKEdyCSvQi8qhXeM8ciN8lHCi5U958XYKdTyyfuLm3VgDYLedHzzq1hVVSHNXdQLUO
	 SPp8uzXurq/nwxQaKbum0TnwmWCYy1mDMSvWeMNY=
Date: Tue, 2 Jul 2024 07:33:08 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: LKML <linux-kernel@vger.kernel.org>, rafael@kernel.org
Subject: Re: Summarize my recent devres changes for code review and merging
Message-ID: <2024070248-those-rearview-ac34@gregkh>
References: <d2a150dc-1bac-4be2-a19a-d9dc6296e810@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2a150dc-1bac-4be2-a19a-d9dc6296e810@quicinc.com>

On Tue, Jul 02, 2024 at 06:48:04AM +0800, quic_zijuhu wrote:
> I would like to summarize my recent patches for devres as following:
> 
> [PATCH v2] devres: Fix devm_krealloc() allocating memory with wrong size
> https://lore.kernel.org/lkml/1718537455-20208-1-git-send-email-quic_zijuhu@quicinc.com/
> 
> [PATCH v1] devres: Fix memory leakage due to driver API devm_free_percpu()
> https://lore.kernel.org/lkml/1718804281-1796-1-git-send-email-quic_zijuhu@quicinc.com/
> 
> [PATCH v1] devres: Correct code style for functions that return a
> pointer type
> https://lore.kernel.org/lkml/1718631689-11929-1-git-send-email-quic_zijuhu@quicinc.com/
> 
> [PATCH v3] devres: Initialize a uninitialized struct member
> https://lore.kernel.org/lkml/1719871765-14774-1-git-send-email-quic_zijuhu@quicinc.com/
> 
> [PATCH v2] devres: Simplify devm_percpu_match() implementation
> https://lore.kernel.org/lkml/1719871779-14818-1-git-send-email-quic_zijuhu@quicinc.com/

Please submit a patch series for all of these, that would make managing
them much easier, don't you think?

thanks,

greg k-h

