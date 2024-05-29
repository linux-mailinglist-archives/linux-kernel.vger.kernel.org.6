Return-Path: <linux-kernel+bounces-193904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19788D33E1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 12:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E6EB218F5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 10:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA73417995A;
	Wed, 29 May 2024 10:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Z032jTVm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A18017A902
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716976850; cv=none; b=pAY4oelo3zff/nyvrcznsWGJ0uI7DoQTeyU+9Mt2WoG6+J2R1I1VFMqLsbHNaOps6y5q9ACW5fnzgapPRJtVwKyyeh+5UdDDKL1WqLJl5WUsN/J1azadw/x+18yobc9BnQKB6liShBKTrtDgKGVcWzd3K6AC3od66VNocfHQv3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716976850; c=relaxed/simple;
	bh=JkIX8xKo+lNY07uEq9QS69wNHFvrTozc/et+eiZHLE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FxaIyhhj4gLnnfTCddqQphZp3bGnvh5K42rFDNDeWLl4ttu7sFmAAQduwQJxXJUi3/yyNlgnJPbZVVIIY26kkbfd+1AmqGw0CwQpQZd3BvqKoxOEeSDJoR23xvRDiwzs3TJcgxDzZgzcSq+YXxtuPtGH7l8Yjr+Dr48HOKd5EDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Z032jTVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12ECAC4AF08;
	Wed, 29 May 2024 10:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716976849;
	bh=JkIX8xKo+lNY07uEq9QS69wNHFvrTozc/et+eiZHLE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z032jTVmh53cyY1k9uthsBXu6CX9bXQIlZj3fBscYA0lGqhqfILLHqI86PXjP5vRp
	 2QgJRBewVMKiqOJs4Ouf+3StxL9/NpQFQNHpK/q1M3UwhOOeBAMQ69IsLSPVciU5tR
	 rruJLA4t68ssP5VhkymRvzHKVzWiFmjrrRpzt9wY=
Date: Wed, 29 May 2024 12:00:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Soumya Khasnis <soumya.khasnis@sony.com>
Cc: rafael@kernel.org, linux-kernel@vger.kernel.org,
	daniel.lezcano@linaro.org, festevam@denx.de, lee@kernel.org,
	benjamin.bara@skidata.com, dmitry.osipenko@collabora.com,
	ldmldm05@gmail.com, srinavasa.nagaraju@sony.com,
	Madhusudan.Bobbili@sony.com, shingo.takeuchi@sony.com,
	keita.aihara@sony.com, masaya.takahashi@sony.com
Subject: Re: [PATCH] reboot: Add timeout for device shutdown
Message-ID: <2024052935-think-gaffe-80d4@gregkh>
References: <20240529083224.GA71473@sony.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529083224.GA71473@sony.com>

On Wed, May 29, 2024 at 08:32:24AM +0000, Soumya Khasnis wrote:
> The device shutdown callbacks invoked during shutdown/reboot
> are prone to errors depending on the device state or mishandling
> by one or more driver. In order to prevent a device hang in such
> scenarios, we bail out after a timeout while dumping a meaningful
> call trace of the shutdown callback which blocks the shutdown or
> reboot process.
> 
> Change-Id: Ibfc63ca8f8aa45866cbe6b90401d438d95eca742

Any reason you didn't run this through checkpatch.pl first?

:(


