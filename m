Return-Path: <linux-kernel+bounces-411169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F34B79CF412
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 19:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE8F1F21CBF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 18:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CEF1D515A;
	Fri, 15 Nov 2024 18:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DtYrQJHv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351212D05D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 18:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731695868; cv=none; b=RO6AT/jWM/RfLJrSYE+rq05ZZNkC9JidRDfjejl4PKWp7tQOcnmqRCwLYxco2jsjMvjSVS9U5KSnB2JXLQauvvzP2wGSsRF6G0V/2XHwYst3oJ7rJWe7FwNcROjHuFMfi9Zh/x5BSYq8o2p1FE8hTqUMkM5sTvoTLWXdN3dDLCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731695868; c=relaxed/simple;
	bh=CBhZomJZYT19jej48rX9lQmxjSh4DlQaQEpK2G6SK10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EaUfhHwgZIBuzG+yUq5ru//DDwQOYlm1VppyX0itAdtQ0tDmNqvI1FzB9UrI7jUx64xLcM7b9rn6QU8NmuR6Weh648Cha0TAMJISbBjVDmIqM65mJUqN2m6bpecdQufJCx2T5/o1Pj2U+nmSnJtsAvFXXenbIZRaYhaDwlk9gMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DtYrQJHv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC90C4CECF;
	Fri, 15 Nov 2024 18:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731695867;
	bh=CBhZomJZYT19jej48rX9lQmxjSh4DlQaQEpK2G6SK10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DtYrQJHvCdo9NoooDd8tVrWZFjE5HSQJUJCPO8RPKrA5IooUcaJNWt5/g+oGMz9Gj
	 NTkYunSIEVLgjQsVBCiubHB9LFvsBAFCbtm6/2YRaSeNP1tGjZ62hd4+GsNthXQc3U
	 PjOZ1/+j7h8sV7JnXwxn/w44HYEjXdwbR9b76IWo=
Date: Fri, 15 Nov 2024 19:37:24 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] sysfs: attribute_group: allow registration of const
 bin_attribute
Message-ID: <2024111510-acting-violet-1ff4@gregkh>
References: <20241115-b4-sysfs-const-bin_attr-group-v1-0-2c9bb12dfc48@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241115-b4-sysfs-const-bin_attr-group-v1-0-2c9bb12dfc48@weissschuh.net>

On Fri, Nov 15, 2024 at 05:42:47PM +0100, Thomas Weißschuh wrote:
> A small addition to the sysfs bin_attribute constification preparation.
> While it's very late, it would be great if this could make it into 6.13
> at it would speed up the tree-wide conversion process.

Looks good, now queued up for 0-day testing, thanks!

greg k-h

