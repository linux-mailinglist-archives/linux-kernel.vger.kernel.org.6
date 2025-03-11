Return-Path: <linux-kernel+bounces-556411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D95BEA5C745
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 16:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E6E168977
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 15:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D994F25E831;
	Tue, 11 Mar 2025 15:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CFXJSCqX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4656B25E807
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 15:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706954; cv=none; b=lSFyA8FECPPoEAEzrk8xqjfORfSaUDtWOjAyV7ElZQ2O7RdaaUhliRBiSGvP8AYudJSrMsJTUBGjs4RzvhUGAa9dZDxcscSzF07kGoLyr2wAjN8NePXHadMZGV5senNvmwRZLC7u2uUBn7oTvP6hwSqp/hcbZ9vbnH80V/UtSIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706954; c=relaxed/simple;
	bh=8oiatXWxAmC7tZxULK3TGWZXmbO8bRFrzxBhwwq00Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAwNWW8nk9cx9lKDKDo5BUHPM8zjC8I9Qrmy9LuWns/X/+RyPABcA0iVYTKeUn8+XhCnAUAgBsQCbpr1N3Ctc//or3oAk/tkAqtHr9OD9QXsrB91w4EdXfVkM7FWS4GMHhzgCX1C9MCRqch1js0PsPbryvpa9JE+Q5H8775MmoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CFXJSCqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16DFC4CEE9;
	Tue, 11 Mar 2025 15:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741706954;
	bh=8oiatXWxAmC7tZxULK3TGWZXmbO8bRFrzxBhwwq00Iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CFXJSCqXYmfBAkVsFSvQUlq4Sp/zHRaGfRikxXmvz7p8DWntE3IWm2kJ/u04p6hWa
	 8YHia5MgojilHSmEmAo9m6HA7FTSvwBBVF0oWUFBNmXzH7Exofq4l9HwSKKwNzE/3Z
	 +k77paad/jDwQ4l/9iSykFtBZjCT4Dxc7nrsYu8aMUdpZC8wk86eSC3Hb4lYiKrfiP
	 5CXjEIgdguzpbA5KDn1NvjF1MWzoFqJtVJ/TkJSb4tXeBa4TkZHBFVuz0Jqpmv7zUK
	 wut9LVm8maZ5VcU3lE07ykJy9/D2YUUs2MgcQdzqISulQjL97bowhweruRkiKS2Qnr
	 6N+v9lrlaa59A==
Date: Tue, 11 Mar 2025 16:29:11 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Benjamin Segall <bsegall@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrey Vagin <avagin@openvz.org>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [patch V3 15/18] posix-timers: Make per process list RCU safe
Message-ID: <Z9BWx1eyo2gPzHyJ@localhost.localdomain>
References: <20250308155501.391430556@linutronix.de>
 <20250308155624.403223080@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250308155624.403223080@linutronix.de>

Le Sat, Mar 08, 2025 at 05:48:43PM +0100, Thomas Gleixner a écrit :
> Preparatory change to remove the sighand locking from the /proc/$PID/timers
> iterator.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

